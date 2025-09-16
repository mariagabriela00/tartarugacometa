<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Entrega - Tartaruga Cometa</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .header { background-color: #2c3e50; color: white; padding: 15px 0; margin-bottom: 30px; }
        .info-card { margin-bottom: 20px; }
        .product-item { border-bottom: 1px solid #eee; padding: 10px 0; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1><i class="fas fa-truck"></i> Detalhes da Entrega #${entrega.id}</h1>
        </div>
    </div>

    <div class="container">
        <div class="row mb-4">
            <div class="col-md-12">
                <a href="entregas" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Voltar para Lista
                </a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card info-card">
                    <div class="card-header bg-primary text-white">
                        <h5>Informações do Remetente</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Nome/Razão Social:</strong> ${remetente.nomeRazaoSocial}</p>
                        <p><strong>CPF/CNPJ:</strong> ${remetente.cpfCnpj}</p>
                        <p><strong>Endereço:</strong> ${remetente.logradouro}, ${remetente.numero} ${remetente.complemento}</p>
                        <p><strong>Bairro:</strong> ${remetente.bairro}</p>
                        <p><strong>Cidade/UF:</strong> ${remetente.cidade}/${remetente.estado}</p>
                        <p><strong>CEP:</strong> ${remetente.cep}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card info-card">
                    <div class="card-header bg-success text-white">
                        <h5>Informações do Destinatário</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Nome/Razão Social:</strong> ${destinatario.nomeRazaoSocial}</p>
                        <p><strong>CPF/CNPJ:</strong> ${destinatario.cpfCnpj}</p>
                        <p><strong>Endereço:</strong> ${destinatario.logradouro}, ${destinatario.numero} ${destinatario.complemento}</p>
                        <p><strong>Bairro:</strong> ${destinatario.bairro}</p>
                        <p><strong>Cidade/UF:</strong> ${destinatario.cidade}/${destinatario.estado}</p>
                        <p><strong>CEP:</strong> ${destinatario.cep}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card info-card">
                    <div class="card-header bg-info text-white">
                        <h5>Informações da Entrega</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <p><strong>Data de Criação:</strong><br>${entrega.dataCriacao}</p>
                            </div>
                            <div class="col-md-3">
                                <p><strong>Status:</strong><br>
                                    <span class="status-badge status-${entrega.status.toLowerCase().replace(' ', '-')}">
                                        ${entrega.status}
                                    </span>
                                </p>
                            </div>
                            <div class="col-md-3">
                                <p><strong>Data de Entrega:</strong><br>${entrega.dataEntrega != null ? entrega.dataEntrega : 'Não entregue'}</p>
                            </div>
                            <div class="col-md-3">
                                <p><strong>Valor do Frete:</strong><br>R$ ${entrega.valorFrete}</p>
                            </div>
                        </div>
                        <p><strong>Observações:</strong><br>${entrega.observacoes}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card info-card">
                    <div class="card-header bg-warning text-dark">
                        <h5>Produtos da Entrega</h5>
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Produto</th>
                                    <th>Descrição</th>
                                    <th>Peso (kg)</th>
                                    <th>Volume (m³)</th>
                                    <th>Valor Unitário</th>
                                    <th>Quantidade</th>
                                    <th>Valor Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="produto" items="${produtos}">
                                    <tr>
                                        <td>${produto.nome}</td>
                                        <td>${produto.descricao}</td>
                                        <td>${produto.peso}</td>
                                        <td>${produto.volume}</td>
                                        <td>R$ ${produto.valor}</td>
                                        <td>${produto.quantidade}</td>
                                        <td>R$ ${produto.valor * produto.quantidade}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>