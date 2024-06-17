<%-- 
    Document   : subir
    Created on : 16 jun. 2024, 19:43:58
    Author     : Julieth
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.nio.file.Paths"%>
   <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subir Archivo</title>
<link rel="stylesheet" href="subirArchivo.css">
</head>
<body>
    <div class="container">
        <h1>Subir Archivo</h1>
        
        <%-- Procesamiento del formulario de subida de archivos --%>
        <%
            String message = "";
            
            // Verificar si se ha enviado el formulario (POST request)
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                
                // Obtener la carpeta destino y el archivo enviado
                String carpetaDestino = request.getParameter("carpeta");
                Part archivoPart = request.getPart("archivo");
                
                // Depuración: Imprimir valores recibidos
                out.println("Carpeta destino: " + carpetaDestino);
                out.println("Nombre de archivo: " + (archivoPart != null ? archivoPart.getSubmittedFileName() : "null"));
                
                if (carpetaDestino != null && archivoPart != null && archivoPart.getSize() > 0) {
                    String nombreArchivo = Paths.get(archivoPart.getSubmittedFileName()).getFileName().toString();
                    String rutaCompletaArchivo = carpetaDestino + File.separator + nombreArchivo;
                    
                    // Crear un File para representar el archivo de destino
                    File archivoDestino = new File(rutaCompletaArchivo);
                    
                    try (InputStream input = archivoPart.getInputStream();
                            OutputStream output = new FileOutputStream(archivoDestino)) {
                        
                        // Copiar el contenido del archivo de entrada al archivo de destino
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = input.read(buffer)) != -1) {
                            output.write(buffer, 0, bytesRead);
                        }
                        
                        // Mensaje de éxito
                        message = "El archivo " + nombreArchivo + " se ha subido correctamente a la carpeta " + carpetaDestino;
                    } catch (IOException e) {
                        // Error al guardar el archivo
                        message = "Error al guardar el archivo. Inténtelo nuevamente.";
                        e.printStackTrace();
                    }
                } else {
                    // Mensaje de error si no se selecciona carpeta o archivo
                    message = "Por favor seleccione una carpeta y un archivo.";
                }
            }
        %>
        
        <%-- Formulario HTML para subir archivos --%>
        <form action="subirArchivo.jsp" method="post" enctype="multipart/form-data">
            <label for="carpeta">Seleccione una carpeta:</label>
            <select name="carpeta" id="carpeta" required>
                <option value="">Seleccione una carpeta</option>
                <% 
                    // Listar carpetas en el directorio base (ajusta la ruta según tu configuración)
                    String baseDir = "D:\\SimposioData\\";
                    File baseFolder = new File(baseDir);
                    if (baseFolder.exists() && baseFolder.isDirectory()) {
                        for (File folder : baseFolder.listFiles()) {
                            if (folder.isDirectory()) {
                                out.println("<option value='" + folder.getAbsolutePath() + "'>" + folder.getName() + "</option>");
                            }
                        }
                    }
                %>
            </select><br><br>
            <label for="archivo">Seleccione un archivo:</label>
            <input type="file" id="archivo" name="archivo" required><br><br>
            <input type="submit" value="Subir">
        </form>
        
        <%-- Mostrar mensaje de éxito o error --%>
        <div class="message <%= message.startsWith("Error") ? "error" : "success" %>">
            <%= message %>
        </div>
        
    </div>
</body>
</html>
