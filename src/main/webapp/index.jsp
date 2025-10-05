<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Join Our Email List</title>
    <link rel="stylesheet" href="styles/main.css">
</head>
<body>
<div class="container">
    <h1>Join Our Email List</h1>
    <%
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType");
        if (message != null) {
    %>
    <div class="message <%= messageType %>"><%= message %></div>
    <% } %>
    <form action="emailList" method="post">
        <input type="hidden" name="action" value="insert">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" required>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required>
        <input type="submit" value="Add User">
    </form>
    <a href="userList.jsp" class="back-home"><i>→</i> View User List</a>
</div>
</body>
</html>