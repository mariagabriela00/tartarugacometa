<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tartaruga Cometa - Sistema Integrado</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* Manter todos os estilos CSS do arquivo original */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }
        
        /* ... (Aqui vai ser mantido o CSS) ... */
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Essa parte é a barra lateral -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <h4><i class="fas fa-truck"></i> Tartaruga Cometa</h4>
                </div>
                
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="entregas">
                            <i class="fas fa-shipping-fast"></i> Entregas
                        </a>
                    </li>
                    
                </ul>
            </div>
            
            <!--Esse é o conteudo principal -->
            <div class="col-md-9 col-lg-10 main-content">
                <div class="header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h1><i class="fas fa-tachometer-alt"></i> Dashboard</h1>
                            </div>
                            <div class="col-md-6 text-right">
                                <span class="mr-3">Olá, Maria Gabriela</span>
                                <img src="https://ui-avatars.com/api/?name=Maria+Gabriela&background=3498db&color=fff" class="rounded-circle" width="40" height="40" alt="Usuário">
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="container-fluid">
                    <!-- Stats Cards -->
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card dashboard-card text-white bg-primary">
                                <div class="card-body text-center">
                                    <div class="card-icon">
                                        <i class="fas fa-shipping-fast"></i>
                                    </div>
                                    <h5>Total de Entregas</h5>
                                    <div class="stats-number">${totalEntregas}</div>
                                    <p class="small">+12% desde o mês passado</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card dashboard-card text-white bg-success">
                                <div class="card-body text-center">
                                    <div class="card-icon">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <h5>Entregues</h5>
                                    <div class="stats-number">${entregues}</div>
                                    <p class="small">${totalEntregas > 0 ? (entregues * 100 / totalEntregas) : 0}% de sucesso</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card dashboard-card text-white bg-warning">
                                <div class="card-body text-center">
                                    <div class="card-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <h5>Pendentes</h5>
                                    <div class="stats-number">${pendentes}</div>
                                    <p class="small">${totalEntregas > 0 ? (pendentes * 100 / totalEntregas) : 0}% das entregas</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card dashboard-card text-white bg-info">
                                <div class="card-body text-center">
                                    <div class="card-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <h5>Faturamento</h5>
                                    <div class="stats-number">R$ ${faturamento}</div>
                                    <p class="small">+8% desde o mês passado</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Restante do conteúdo do dashboard -->
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        // Script do gráfico, mas ai preferi manter igual
    </script>
</body>
</html>