package com.tartaruga.model;

import java.sql.Timestamp;
import java.util.List;

public class Entrega {
    private int id;
    private int idRemetente;
    private int idDestinatario;
    private Timestamp dataCriacao;
    private Timestamp dataEntrega;
    private String status;
    private String observacoes;
    private double valorFrete;
    private String remetenteNome;
    private String destinatarioNome;
    private List<Produto> produtos;
    
    // Construtores, getters e setters
    public Entrega() {}
    
    public Entrega(int id, int idRemetente, int idDestinatario, Timestamp dataCriacao, 
        Timestamp dataEntrega, String status, String observacoes, double valorFrete) {
        this.id = id;
        this.idRemetente = idRemetente;
        this.idDestinatario = idDestinatario;
        this.dataCriacao = dataCriacao;
        this.dataEntrega = dataEntrega;
        this.status = status;
        this.observacoes = observacoes;
        this.valorFrete = valorFrete;
    }
    
    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getIdRemetente() { return idRemetente; }
    public void setIdRemetente(int idRemetente) { this.idRemetente = idRemetente; }
    
    public int getIdDestinatario() { return idDestinatario; }
    public void setIdDestinatario(int idDestinatario) { this.idDestinatario = idDestinatario; }
    
    public Timestamp getDataCriacao() { return dataCriacao; }
    public void setDataCriacao(Timestamp dataCriacao) { this.dataCriacao = dataCriacao; }
    
    public Timestamp getDataEntrega() { return dataEntrega; }
    public void setDataEntrega(Timestamp dataEntrega) { this.dataEntrega = dataEntrega; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getObservacoes() { return observacoes; }
    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }
    
    public double getValorFrete() { return valorFrete; }
    public void setValorFrete(double valorFrete) { this.valorFrete = valorFrete; }
    
    public String getRemetenteNome() { return remetenteNome; }
    public void setRemetenteNome(String remetenteNome) { this.remetenteNome = remetenteNome; }
    
    public String getDestinatarioNome() { return destinatarioNome; }
    public void setDestinatarioNome(String destinatarioNome) { this.destinatarioNome = destinatarioNome; }
    
    public List<Produto> getProdutos() { return produtos; }
    public void setProdutos(List<Produto> produtos) { this.produtos = produtos; }
}