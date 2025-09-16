<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${entrega != null ? 'Editar' : 'Nova'} Entrega - Tartaruga Cometa</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>${entrega != null ? 'Editar' : 'Nova'} Entrega</h2>
        
        <form action="entregas" method="post">
            <input type="hidden" name="action" value="${entrega != null ? 'update' : 'insert'}">
            <c:if test="${entrega != null}">
                <input type="hidden" name="id" value="${entrega.id}">
            </c:if>
            
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5>Dados do Remetente</h5>
                </div>
                <div class="card-body">
                    <div class="form-row">
                        <div class="form-group col-md-3">
                            <label for="remetenteTipo">Tipo de Pessoa</label>
                            <select class="form-control" id="remetenteTipo" name="remetenteTipo" required>
                                <option value="Física" ${remetente.tipoPessoa == 'Física' ? 'selected' : ''}>Pessoa Física</option>
                                <option value="Jurídica" ${remetente.tipoPessoa == 'Jurídica' ? 'selected' : ''}>Pessoa Jurídica</option>
                            </select>
                        </div>
                        <div class="form-group col-md-5">
                            <label for="remetenteCpfCnpj" id="labelRemetenteCpfCnpj">CPF/CNPJ</label>
                            <input type="text" class="form-control" id="remetenteCpfCnpj" name="remetenteCpfCnpj" 
                                   value="${remetente.cpfCnpj}" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="remetenteNome">Nome/Razão Social</label>
                            <input type="text" class="form-control" id="remetenteNome" name="remetenteNome" 
                                   value="${remetente.nomeRazaoSocial}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="remetenteLogradouro">Logradouro</label>
                            <input type="text" class="form-control" id="remetenteLogradouro" name="remetenteLogradouro" 
                                   value="${remetente.logradouro}" required>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="remetenteNumero">Número</label>
                            <input type="text" class="form-control" id="remetenteNumero" name="remetenteNumero" 
                                   value="${remetente.numero}" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="remetenteComplemento">Complemento</label>
                            <input type="text" class="form-control" id="remetenteComplemento" name="remetenteComplemento" 
                                   value="${remetente.complemento}">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label for="remetenteBairro">Bairro</label>
                            <input type="text" class="form-control" id="remetenteBairro" name="remetenteBairro" 
                                   value="${remetente.bairro}" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="remetenteCidade">Cidade</label>
                            <input type="text" class="form-control" id="remetenteCidade" name="remetenteCidade" 
                                   value="${remetente.cidade}" required>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="remetenteEstado">Estado</label>
                            <input type="text" class="form-control" id="remetenteEstado" name="remetenteEstado" 
                                   value="${remetente.estado}" required maxlength="2">
                        </div>
                        <div class="form-group col-md-2">
                            <label for="remetenteCep">CEP</label>
                            <input type="text" class="form-control" id="remetenteCep" name="remetenteCep" 
                                   value="${remetente.cep}" required>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Formulário similar para destinatário -->
            
            <div class="card mb-4">
                <div class="card-header bg-info text-white">
                    <h5>Produtos</h5>
                </div>
                <div class="card-body">
                    <div id="produtos-container">
                        <!-- Produtos serão adicionados dinamicamente via JavaScript -->
                    </div>
                    <button type="button" class="btn btn-secondary mt-3" id="btn-add-produto">
                        <i class="fas fa-plus"></i> Adicionar Produto
                    </button>
                </div>
            </div>
            
            <div class="form-group">
                <label for="observacoes">Observações</label>
                <textarea class="form-control" id="observacoes" name="observacoes" rows="3">${entrega.observacoes}</textarea>
            </div>
            
            <button type="submit" class="btn btn-success">Salvar</button>
            <a href="entregas" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Script para manipulação dinâmica dos produtos
        let productCount = 0;
        
        document.getElementById('btn-add-produto').addEventListener('click', function() {
            productCount++;
            const container = document.getElementById('produtos-container');
            
            const productHtml = `
                <div class="card mb-3 produto-item" id="produto-${productCount}">
                    <div class="card-body">
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <label>Nome do Produto</label>
                                <input type="text" class="form-control" name="produtoNome[]" required>
                            </div>
                            <div class="form-group col-md-2">
                                <label>Peso (kg)</label>
                                <input type="number" step="0.01" class="form-control" name="produtoPeso[]" required>
                            </div>
                            <div class="form-group col-md-2">
                                <label>Volume (m³)</label>
                                <input type="number" step="0.01" class="form-control" name="produtoVolume[]" required>
                            </div>
                            <div class="form-group col-md-2">
                                <label>Valor (R$)</label>
                                <input type="number" step="0.01" class="form-control" name="produtoValor[]" required>
                            </div>
                            <div class="form-group col-md-2">
                                <label>Quantidade</label>
                                <input type="number" class="form-control" name="produtoQuantidade[]" value="1" min="1" required>
                            </div>
                        </div>
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeProduct(${productCount})">
                            <i class="fas fa-trash"></i> Remover
                        </button>
                    </div>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', productHtml);
        });
        
        function removeProduct(id) {
            const element = document.getElementById(`produto-${id}`);
            if (element) {
                element.remove();
            }
        }
        
        // Adiciona um produto por padrão ao carregar a página
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('btn-add-produto').click();
        });
    </script>
</body>
</html>