<%-- 
    Document   : eliminar
    Created on : 16 jun. 2024, 19:14:23
    Author     : Julieth
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Archivos</title>
    <link rel="stylesheet" href="../CSS/eliminar.css">
</head>
<body>
    <div class="container">
        <h1>Eliminar Archivos</h1>
        <form method="post" action="eliminar.jsp">
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
                    out.println("<form method='post' action='eliminar.jsp'>");
                    out.println("<input type='hidden' name='folder' value='" + selectedFolder + "' />");
                    out.println("<label for='file'>Seleccione un archivo:</label>");
                    out.println("<select name='file' id='file'>");
                    for (File file : folder.listFiles()) {
                        if (file.isFile()) {
                            out.println("<option value='" + file.getName() + "'>" + file.getName() + "</option>");
                        }
                    }
                    out.println("</select>");
                    out.println("<button type='submit' name='delete' value='delete'>Eliminar</button>");
                    out.println("</form>");
                }
            }

            if ("delete".equals(request.getParameter("delete"))) {
                String folderName = request.getParameter("folder");
                String fileName = request.getParameter("file");
                if (folderName != null && fileName != null) {
                    File fileToDelete = new File(baseDir + folderName + "\\" + fileName);
                    if (fileToDelete.exists() && fileToDelete.isFile()) {
                        if (fileToDelete.delete()) {
                            out.println("<p>El archivo " + fileName + " ha sido eliminado exitosamente.</p>");
                        } else {
                            out.println("<p>No se pudo eliminar el archivo " + fileName + ".</p>");
                        }
                    } else {
                        out.println("<p>Archivo no encontrado.</p>");
                    }
                }
            }
        %>
    </div>
</body>
</html>
