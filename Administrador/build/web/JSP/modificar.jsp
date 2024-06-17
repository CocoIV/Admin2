<%-- 
    Document   : modificar
    Created on : 16 jun. 2024, 14:31:41
    Author     : Julieth
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.util.logging.Logger" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modificar Archivo</title>
        <link rel="stylesheet" href="../CSS/modificar.css">
    </head>
    <body>
        <div class="container">
            <h1>Modificar Archivo</h1>
            <form action="modificar.jsp" method="post">
                <label for="archivo">Seleccione un archivo:</label>
                <select name="archivo" id="archivo" required>
                    <option value="">Seleccione un archivo</option>
                    <%-- Java code to populate the dropdown with files --%>
                    <%
                        String baseDir = "D:\\SimposioData\\";
                        File baseFolder = new File(baseDir);
                        if (baseFolder.exists() && baseFolder.isDirectory()) {
                            for (File folder : baseFolder.listFiles()) {
                                if (folder.isDirectory()) {
                                    out.println("<optgroup label='" + folder.getName() + "'>");
                                    for (File file : folder.listFiles()) {
                                        if (file.isFile()) {
                                            out.println("<option value='" + file.getAbsolutePath() + "'>" + file.getName() + "</option>");
                                        }
                                    }
                                    out.println("</optgroup>");
                                }
                            }
                        }
                    %>
                </select><br><br>
                <label for="nuevoNombre">Nuevo nombre:</label>
                <input type="text" id="nuevoNombre" name="nuevoNombre" required><br><br>
                <input type="submit" value="Modificar">
            </form>

            <%-- Java code to handle file renaming --%>
            <%
                Logger logger = Logger.getLogger("ModificarArchivo");

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String filePath = request.getParameter("archivo");
                    String nuevoNombre = request.getParameter("nuevoNombre").trim(); // Remove leading and trailing spaces

                    if (filePath != null && !filePath.isEmpty()) {
                        File file = new File(filePath);

                        // Log file path
                        logger.info("Ruta completa del archivo: " + file.getAbsolutePath());

                        if (file.exists() && file.isFile()) {
                            // Create new File object for the renamed file
                            File newFile = new File(file.getParent() + File.separator + nuevoNombre);

                            try {
                                // Rename the file using Files.move()
                                Files.move(Paths.get(file.getAbsolutePath()), Paths.get(newFile.getAbsolutePath()));
                                // Success message
%>
            <p>El archivo <%= file.getName()%> ha sido renombrado a <%= nuevoNombre%> con éxito.</p>
            <%
            } catch (IOException e) {
                // Error message if renaming fails
%>
            <p>No se pudo renombrar el archivo <%= file.getName()%>. Verifique los permisos de archivo o inténtelo nuevamente.</p>
            <%
                    logger.severe("Error al renombrar archivo: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
            %>
            <p>No se encontró el archivo <%= filePath%>. Verifique que el archivo exista.</p>
            <%
                }
            } else {
            %>
            <p>Seleccione un archivo para modificar.</p>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>

