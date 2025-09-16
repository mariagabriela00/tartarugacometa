package com.tartaruga.model;

public class Produto {
    private int id;
    private String nome;
    private String descricao;
    private double peso;
    private double volume;
    private double valor;
    
    // Construtores, getters e setters
    public Produto() {}
    
    public Produto(int id, String nome, String descricao, double peso, double volume, double valor) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.peso = peso;
        this.volume = volume;
        this.valor = valor;
    }
    
    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    
    public double getPeso() { return peso; }
    public void setPeso(double peso) { this.peso = peso; }
    
    public double getVolume() { return volume; }
    public void setVolume(double volume) { this.volume = volume; }
    
    public double getValor() { return valor; }
    public void setValor(double valor) { this.valor = valor; }
}