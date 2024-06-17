<%-- 
    Document   : lista
    Created on : 16 jun. 2024, 22:27:22
    Author     : Julieth
--%>

<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Documentos</title>
        <link rel="stylesheet" href="../CSS/lista.css">
    </head>
    <body>
        <div class="container">
            <h1>Lista de Documentos</h1>
            <form method="post" action="lista.jsp">
                <label for="folder">Seleccione una carpeta:</label>
                <select name="folder" id="folder" onchange="this.form.submit()">
                    <option value="">Seleccione una carpeta</option>
                    <%
                        // Directorio base
                        String baseDir = "D:\\SimposioData\\";
                        File baseFolder = new File(baseDir);
                        if (baseFolder.exists() && baseFolder.isDirectory()) {
                            for (File folder : baseFolder.listFiles()) {
                                if (folder.isDirectory()) {
                                    String selected = request.getParameter("folder") != null && request.getParameter("folder").equals(folder.getName()) ? "selected" : "";
                                    out.println("<option value='" + folder.getName() + "' " + selected + ">" + folder.getName() + "</option>");
                                }
                            }
                        }
                    %>
                </select>
            </form>
            <%
                String selectedFolder = request.getParameter("folder");
                if (selectedFolder != null && !selectedFolder.isEmpty()) {
                    File folder = new File(baseDir + selectedFolder);
                    if (folder.exists() && folder.isDirectory()) {
            %>
            <h2>Documentos en la carpeta <%= selectedFolder%>:</h2>
            <ul>
                <%
                    for (File file : folder.listFiles()) {
                        if (file.isFile()) {
                %>
                <li><%= file.getName()%></li>
                    <%
                            }
                        }
                    %>
            </ul>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>
