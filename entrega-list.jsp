<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Entregas - Tartaruga Cometa</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 0;
            margin-bottom: 30px;
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-pendente { background-color: #ffc107; color: #000; }
        .status-em-transito { background-color: #17a2b8; color: #fff; }
        .status-entregue { background-color: #28a745; color: #fff; }
        .status-cancelada { background-color: #dc3545; color: #fff; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1><i class="fas fa-truck"></i> Tartaruga Cometa - Controle de Entregas</h1>
        </div>
    </div>

    <div class="container">
        <div class="row mb-4">
            <div class="col-md-12">
                <a href="entregas?action=new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nova Entrega
                </a>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3>Lista de Entregas</h3>
            </div>
            <div class="card-body">
                <c:if test="${empty listEntregas}">
                    <div class="alert alert-info">Nenhuma entrega cadastrada.</div>
                </c:if>
                
                <c:if test="${not empty listEntregas}">
                <table class="table table-striped table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Remetente</th>
                            <th>Destinatário</th>
                            <th>Data Criação</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entrega" items="${listEntregas}">
                            <tr>
                                <td><c:out value="${entrega.id}"/></td>
                                <td><c:out value="${entrega.remetenteNome}"/></td>
                                <td><c:out value="${entrega.destinatarioNome}"/></td>
                                <td><fmt:formatDate value="${entrega.dataCriacao}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <%
                                        // Processamento do status para CSS
                                        String status = ((your.package.Entrega) pageContext.getAttribute("entrega")).getStatus();
                                        String statusClass = status.toLowerCase().replace(" ", "-").replace("ã", "a");
                                    %>
                                    <span class="status-badge status-<%= statusClass %>">
                                        <c:out value="${entrega.status}"/>
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="entregas?action=edit&id=${entrega.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:if test="${entrega.status != 'Entregue' && entrega.status != 'Cancelada'}">
                                            <form action="entregas" method="post" style="display:inline">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="id" value="${entrega.id}">
                                                <input type="hidden" name="status" value="Entregue">
                                                <button type="submit" class="btn btn-sm btn-success" 
                                                        title="Marcar como entregue">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <a href="entregas?action=delete&id=${entrega.id}" class="btn btn-sm btn-danger"
                                           onclick="return confirm('Tem certeza que deseja excluir esta entrega?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>