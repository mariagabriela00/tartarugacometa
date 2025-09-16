package com.tartaruga.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.tartaruga.model.Entrega;
import com.tartaruga.util.DatabaseUtil;

public class EntregaDAO {
    private Connection connection;

    public EntregaDAO() throws SQLException {
        connection = DatabaseUtil.getConnection();
    }

    // INSERT - Criar nova entrega
    public boolean insertEntrega(Entrega entrega) throws SQLException {
        String sql = "INSERT INTO tb_entrega (id_remetente, id_destinatario, observacoes, valor_frete, status) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, entrega.getIdRemetente());
            statement.setInt(2, entrega.getIdDestinatario());
            statement.setString(3, entrega.getObservacoes());
            statement.setDouble(4, entrega.getValorFrete());
            statement.setString(5, entrega.getStatus());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        entrega.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        }
    }

    // SELECT - Buscar entrega por ID
    public Entrega selectEntrega(int id) throws SQLException {
        Entrega entrega = null;
        String sql = "SELECT e.*, r.nome_razao_social as remetente_nome, d.nome_razao_social as destinatario_nome " +
                     "FROM tb_entrega e " +
                     "INNER JOIN tb_remetente r ON e.id_remetente = r.id " +
                     "INNER JOIN tb_destinatario d ON e.id_destinatario = d.id " +
                     "WHERE e.id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    entrega = new Entrega();
                    entrega.setId(resultSet.getInt("id"));
                    entrega.setIdRemetente(resultSet.getInt("id_remetente"));
                    entrega.setIdDestinatario(resultSet.getInt("id_destinatario"));
                    entrega.setDataCriacao(resultSet.getTimestamp("data_criacao"));
                    entrega.setDataEntrega(resultSet.getTimestamp("data_entrega"));
                    entrega.setStatus(resultSet.getString("status"));
                    entrega.setObservacoes(resultSet.getString("observacoes"));
                    entrega.setValorFrete(resultSet.getDouble("valor_frete"));
                    entrega.setRemetenteNome(resultSet.getString("remetente_nome"));
                    entrega.setDestinatarioNome(resultSet.getString("destinatario_nome"));
                }
            }
        }
        
        return entrega;
    }

    // Aqui vão ser listadas todas as entregas
    public List<Entrega> selectAllEntregas() throws SQLException {
        List<Entrega> entregas = new ArrayList<>();
        String sql = "SELECT e.*, r.nome_razao_social as remetente_nome, d.nome_razao_social as destinatario_nome " +
            "FROM tb_entrega e " +
            "INNER JOIN tb_remetente r ON e.id_remetente = r.id " +
            "INNER JOIN tb_destinatario d ON e.id_destinatario = d.id " +
            "ORDER BY e.data_criacao DESC";
        
        try (Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Entrega entrega = new Entrega();
                entrega.setId(resultSet.getInt("id"));
                entrega.setIdRemetente(resultSet.getInt("id_remetente"));
                entrega.setIdDestinatario(resultSet.getInt("id_destinatario"));
                entrega.setDataCriacao(resultSet.getTimestamp("data_criacao"));
                entrega.setDataEntrega(resultSet.getTimestamp("data_entrega"));
                entrega.setStatus(resultSet.getString("status"));
                entrega.setObservacoes(resultSet.getString("observacoes"));
                entrega.setValorFrete(resultSet.getDouble("valor_frete"));
                entrega.setRemetenteNome(resultSet.getString("remetente_nome"));
                entrega.setDestinatarioNome(resultSet.getString("destinatario_nome"));
                
                entregas.add(entrega);
            }
        }
        
        return entregas;
    }

    // Aqui serão atualizadas
    public boolean updateEntrega(Entrega entrega) throws SQLException {
        String sql = "UPDATE tb_entrega SET id_remetente = ?, id_destinatario = ?, observacoes = ?, valor_frete = ?, status = ? WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, entrega.getIdRemetente());
            statement.setInt(2, entrega.getIdDestinatario());
            statement.setString(3, entrega.getObservacoes());
            statement.setDouble(4, entrega.getValorFrete());
            statement.setString(5, entrega.getStatus());
            statement.setInt(6, entrega.getId());
            
            return statement.executeUpdate() > 0;
        }
    }

    // Esse  é para deixar os status atualizados
    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE tb_entrega SET status = ? WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, id);
            
            return statement.executeUpdate() > 0;
        }
    }

    // Excluir entrega
    public boolean deleteEntrega(int id) throws SQLException {
        String sql = "DELETE FROM tb_entrega WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    // Buscar entregas por status
    public List<Entrega> selectEntregasByStatus(String status) throws SQLException {
        List<Entrega> entregas = new ArrayList<>();
        String sql = "SELECT e.*, r.nome_razao_social as remetente_nome, d.nome_razao_social as destinatario_nome " +
            "FROM tb_entrega e " +
            "INNER JOIN tb_remetente r ON e.id_remetente = r.id " +
            "INNER JOIN tb_destinatario d ON e.id_destinatario = d.id " +
            "WHERE e.status = ? " +
            "ORDER BY e.data_criacao DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Entrega entrega = new Entrega();
                    entrega.setId(resultSet.getInt("id"));
                    entrega.setIdRemetente(resultSet.getInt("id_remetente"));
                    entrega.setIdDestinatario(resultSet.getInt("id_destinatario"));
                    entrega.setDataCriacao(resultSet.getTimestamp("data_criacao"));
                    entrega.setDataEntrega(resultSet.getTimestamp("data_entrega"));
                    entrega.setStatus(resultSet.getString("status"));
                    entrega.setObservacoes(resultSet.getString("observacoes"));
                    entrega.setValorFrete(resultSet.getDouble("valor_frete"));
                    entrega.setRemetenteNome(resultSet.getString("remetente_nome"));
                    entrega.setDestinatarioNome(resultSet.getString("destinatario_nome"));
                    
                    entregas.add(entrega);
                }
            }
        }
        
        return entregas;
    }

    // Total das entregas
    public int countEntregas() throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM tb_entrega";
        
        try (Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql)) {
            
            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
            return 0;
        }
    }

    // Essa função foi adicionada, Calcular faturamento total
    public double calcularFaturamentoTotal() throws SQLException {
        String sql = "SELECT COALESCE(SUM(valor_frete), 0) as total FROM tb_entrega WHERE status = 'Entregue'";
        
        try (Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql)) {
            
            if (resultSet.next()) {
                return resultSet.getDouble("total");
            }
            return 0;
        }
    }
}