package com.tartaruga.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tartaruga.model.Remetente;
import com.tartaruga.util.DatabaseUtil;

public class RemetenteDAO {
    private Connection connection;

    public RemetenteDAO() {
        connection = DatabaseUtil.getConnection();
    }

    public void insertRemetente(Remetente remetente) throws SQLException {
        String sql = "INSERT INTO tb_remetente (tipo_pessoa, cpf_cnpj, nome_razao_social, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, remetente.getTipoPessoa());
            statement.setString(2, remetente.getCpfCnpj());
            statement.setString(3, remetente.getNomeRazaoSocial());
            statement.setString(4, remetente.getLogradouro());
            statement.setString(5, remetente.getNumero());
            statement.setString(6, remetente.getComplemento());
            statement.setString(7, remetente.getBairro());
            statement.setString(8, remetente.getCidade());
            statement.setString(9, remetente.getEstado());
            statement.setString(10, remetente.getCep());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Falha ao criar remetente, nenhuma linha afetada.");
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    remetente.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Falha ao criar remetente, nenhum ID obtido.");
                }
            }
        }
    }

    public Remetente selectRemetente(int id) throws SQLException {
        Remetente remetente = null;
        String sql = "SELECT * FROM tb_remetente WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    remetente = new Remetente();
                    remetente.setId(resultSet.getInt("id"));
                    remetente.setTipoPessoa(resultSet.getString("tipo_pessoa"));
                    remetente.setCpfCnpj(resultSet.getString("cpf_cnpj"));
                    remetente.setNomeRazaoSocial(resultSet.getString("nome_razao_social"));
                    remetente.setLogradouro(resultSet.getString("logradouro"));
                    remetente.setNumero(resultSet.getString("numero"));
                    remetente.setComplemento(resultSet.getString("complemento"));
                    remetente.setBairro(resultSet.getString("bairro"));
                    remetente.setCidade(resultSet.getString("cidade"));
                    remetente.setEstado(resultSet.getString("estado"));
                    remetente.setCep(resultSet.getString("cep"));
                }
            }
        }
        
        return remetente;
    }

    public List<Remetente> selectAllRemetentes() throws SQLException {
        List<Remetente> remetentes = new ArrayList<>();
        String sql = "SELECT * FROM tb_remetente ORDER BY nome_razao_social";
        
        try (Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Remetente remetente = new Remetente();
                remetente.setId(resultSet.getInt("id"));
                remetente.setTipoPessoa(resultSet.getString("tipo_pessoa"));
                remetente.setCpfCnpj(resultSet.getString("cpf_cnpj"));
                remetente.setNomeRazaoSocial(resultSet.getString("nome_razao_social"));
                remetente.setLogradouro(resultSet.getString("logradouro"));
                remetente.setNumero(resultSet.getString("numero"));
                remetente.setComplemento(resultSet.getString("complemento"));
                remetente.setBairro(resultSet.getString("bairro"));
                remetente.setCidade(resultSet.getString("cidade"));
                remetente.setEstado(resultSet.getString("estado"));
                remetente.setCep(resultSet.getString("cep"));
                
                remetentes.add(remetente);
            }
        }
        
        return remetentes;
    }

    public boolean deleteRemetente(int id) throws SQLException {
        String sql = "DELETE FROM tb_remetente WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean updateRemetente(Remetente remetente) throws SQLException {
        String sql = "UPDATE tb_remetente SET tipo_pessoa = ?, cpf_cnpj = ?, nome_razao_social = ?, logradouro = ?, numero = ?, complemento = ?, bairro = ?, cidade = ?, estado = ?, cep = ? WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, remetente.getTipoPessoa());
            statement.setString(2, remetente.getCpfCnpj());
            statement.setString(3, remetente.getNomeRazaoSocial());
            statement.setString(4, remetente.getLogradouro());
            statement.setString(5, remetente.getNumero());
            statement.setString(6, remetente.getComplemento());
            statement.setString(7, remetente.getBairro());
            statement.setString(8, remetente.getCidade());
            statement.setString(9, remetente.getEstado());
            statement.setString(10, remetente.getCep());
            statement.setInt(11, remetente.getId());
            
            return statement.executeUpdate() > 0;
        }
    }
}