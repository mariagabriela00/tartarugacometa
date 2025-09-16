package br.com.entregas.servlet;

import br.com.entregas.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/entregas")
public class EntregaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try (Connection conn = DatabaseUtil.getConnection()) {
            int totalEntregas = getTotalEntregas(conn);
            int entregues = getEntregasPorStatus(conn, "Entregue");
            int pendentes = getEntregasPorStatus(conn, "Pendente");
            double faturamento = getFaturamentoTotal(conn);

            // 🔹 JSON de resposta
            String json = String.format(
                "{ \"stats\": { \"total\": %d, \"entregues\": %d, \"pendentes\": %d, \"faturamento\": %.2f } }",
                totalEntregas, entregues, pendentes, faturamento
            );

            response.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{ \"error\": \"Erro ao buscar dados\" }");
        }
    }

    private int getTotalEntregas(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM tb_entrega";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt("total") : 0;
        }
    }

    private int getEntregasPorStatus(Connection conn, String status) throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM tb_entrega WHERE status = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getInt("total") : 0;
            }
        }
    }

    private double getFaturamentoTotal(Connection conn) throws SQLException {
        String sql = "SELECT COALESCE(SUM(valor_frete), 0) as total FROM tb_entrega WHERE status = 'Entregue'";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble("total") : 0;
        }
    }
}
