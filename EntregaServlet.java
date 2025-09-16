package com.tartaruga.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tartaruga.dao.EntregaDAO;
import com.tartaruga.model.Entrega;

@WebServlet("/entregas")
public class EntregaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EntregaDAO entregaDAO;

    public void init() {
        try {
            entregaDAO = new EntregaDAO();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inicializar EntregaDAO", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertEntrega(request, response);
                    break;
                case "delete":
                    deleteEntrega(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateEntrega(request, response);
                    break;
                case "updateStatus":
                    updateStatusEntrega(request, response);
                    break;
                default:
                    listEntregas(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listEntregas(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Entrega> listEntregas = entregaDAO.selectAllEntregas();
        request.setAttribute("listEntregas", listEntregas);
        request.getRequestDispatcher("entregas/entrega-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("entregas/entrega-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Entrega existingEntrega = entregaDAO.selectEntrega(id);
        request.setAttribute("entrega", existingEntrega);
        request.getRequestDispatcher("entregas/entrega-form.jsp").forward(request, response);
    }

    private void insertEntrega(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
                try{
                    System.out.println("INICIAR INSERT ENTREGA");
                }
        // Pegar parâmetros do formulário
        int idRemetente = Integer.parseInt(request.getParameter("idRemetente"));
        int idDestinatario = Integer.parseInt(request.getParameter("idDestinatario"));
        String observacoes = request.getParameter("observacoes");
        double valorFrete = Double.parseDouble(request.getParameter("valorFrete"));
        
        System.out.println(" Dados recebidos:");
        System.out.println("Remetente: " + idRemetente);
        System.out.println("Destinatário: " + idDestinatario);
        System.out.println("Valor Frete: " + valorFrete);
        System.out.println("Observações: " + observacoes);

        // Criar objeto Entrega
        Entrega novaEntrega = new Entrega();
        novaEntrega.setIdRemetente(idRemetente);
        novaEntrega.setIdDestinatario(idDestinatario);
        novaEntrega.setObservacoes(observacoes);
        novaEntrega.setValorFrete(valorFrete);
        novaEntrega.setStatus("Pendente"); // Esse é o estado inicial
        
        // Inserir no banco
        boolean sucesso = entregaDAO.insertEntrega(novaEntrega);
        
        if (sucesso) {
            System.out.println(" Entrega salva com sucesso! ID: " + novaEntrega.getId());
        } else {
            System.out.println(" Falha ao salvar entrega!");
        }
        
    } catch (NumberFormatException e) {
        System.out.println(" ERRO: Dados numéricos inválidos");
        e.printStackTrace();
    } catch (Exception e) {
        System.out.println(" ERRO inesperado: " + e.getMessage());
        e.printStackTrace();
    }

    //Redirecionar para lista
        response.sendRedirect("entregas");
    }

    private void updateEntrega(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int idRemetente = Integer.parseInt(request.getParameter("idRemetente"));
        int idDestinatario = Integer.parseInt(request.getParameter("idDestinatario"));
        String observacoes = request.getParameter("observacoes");
        double valorFrete = Double.parseDouble(request.getParameter("valorFrete"));
        String status = request.getParameter("status");
        
        Entrega entrega = new Entrega();
        entrega.setId(id);
        entrega.setIdRemetente(idRemetente);
        entrega.setIdDestinatario(idDestinatario);
        entrega.setObservacoes(observacoes);
        entrega.setValorFrete(valorFrete);
        entrega.setStatus(status);
        
        entregaDAO.updateEntrega(entrega);
        response.sendRedirect("entregas");
    }

    private void updateStatusEntrega(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        entregaDAO.updateStatus(id, status);
        response.sendRedirect("entregas");
    }

    private void deleteEntrega(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        entregaDAO.deleteEntrega(id);
        response.sendRedirect("entregas");
    }
}