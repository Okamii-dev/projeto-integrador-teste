<%-- 
    Document   : listarproduto
    Created on : 09/06/2023, 23:24:26
    Author     : wanes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    HttpSession sessao = request.getSession();
    if (sessao.getAttribute("usuario") == null) {
            response.sendRedirect("area_vendedor.jsp");
        }
    %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        
    </head>
    <body>
        <div class="container">
            <header class="p-4 mt-4 text-light bg-dark rounded">
                <h2>LISTAGEM DE PRODUTOS</h2>
            </header>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>PRODUTO</th>
                        <th>DESCRIÇÃO</th>
                        <th>PREÇO</th>
                        <th>CONTATO</th>                       
                        <th>VENDEDOR</th>                
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${produtos}" var="produto">
                        <tr>
                            <td><c:out value="${produto.idproduto}"/></td>
                            <td><c:out value="${produto.produto}"/></td>
                            <td><c:out value="${produto.descricao}"/></td>
                            <td><c:out value="${produto.preco}"/></td>
                            <td><c:out value="${produto.contato}"/></td>
                            <td><c:out value="${produto.idusuario}"/></td>
                            <td class="text-center">
                                <a href="Produto?acao=editar&id=${produto.idproduto}" class="btn btn-primary" >Editar</a>
                                <a href="Produto?acao=excluir&id=${produto.idproduto}" class="btn btn-danger" >Excluir</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>                  
            </table>
        </div> 
    </body>
</html>
