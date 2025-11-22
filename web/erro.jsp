<%-- 
    Document   : erro
    Created on : 28/04/2023, 17:03:03
    Author     : sala303b
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SISEC - ERRO</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body onload="document.getElementById('myModal').style.display = 'block'">
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">ERRO!!!!</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <p style="font-size: 18pt; color: red;">
                        <h1 class = "alert alert-danger">${msg}</h1>
                        </p>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <a href="index.jsp">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                VOLTAR
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
