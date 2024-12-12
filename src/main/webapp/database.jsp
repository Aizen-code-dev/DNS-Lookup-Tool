<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="net.NetworkUtils" %> <!-- Update with your actual package name -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DNS and WHOIS Lookup</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
    }
    .container {
        width: 80%;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .header {
        background-color: #333;
        color: #fff;
        padding: 10px;
        text-align: center;
        border-radius: 10px 10px 0 0;
    }
    .header h2 {
        margin: 0;
    }
    .table-container {
        margin-top: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f0f0f0;
    }
    .error {
        color: #f00;
        font-weight: bold;
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>DNS and WHOIS Lookup</h2>
    </div>
    <%
    String eurl = request.getParameter("url");
    if (eurl == null || eurl.isEmpty()) {
        %>
        <p class="error">Please enter a valid URL.</p>
        <%
    } else {
        try {
            URL url = new URL(eurl);
            String host = url.getHost();
            String ipAddress = InetAddress.getByName(host).getHostAddress();
            int responseCode = NetworkUtils.getHttpResponseCode(url);
            List<String> dnsRecords = NetworkUtils.getDnsRecords(host);
            %>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Property</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Protocol:</td>
                            <td><% out.print(url.getProtocol()); %></td>
                        </tr>
                        <tr>
                            <td>Host:</td>
                            <td><% out.print(host); %></td>
                        </tr>
                        <tr>
                            <td>IP Address:</td>
                            <td><% out.print(ipAddress); %></td>
                        </tr>
                        <tr>
                            <td>Port Number:</td>
                            <td><% out.print(url.getPort() == -1 ? "80" : url.getPort()); %></td>
                        </tr>
                        <tr>
                            <td>Path:</td>
                            <td><% out.print(url.getPath()); %></td>
                        </tr>
                        <tr>
                            <td>Query:</td>
                            <td><% out.print(url.getQuery()); %></td>
                        </tr>
                        <tr>
                            <td>HTTP Response Code:</td>
                            <td><% out.print(responseCode); %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="dns-records">
                <h3>DNS Records:</h3>
                <ul>
                    <%
                    for (String record : dnsRecords) {
                        out.print("<li>" + record + "</li>");
                    }
                    %>
                </ul>
            </div>
   <%
            // Provide a link for WHOIS lookup
            if (ipAddress != null) {
                out.print("<p>Click here for more information <a href='https://www.whois.com/whois/" + ipAddress + "' target='_blank'>here</a> for WHOIS information.</p>");
            }
        } catch (IOException e) {
            out.print("<p class='error'>Error retrieving information.</p>");
        }
    }
    %>
</div>
</body>
</html>