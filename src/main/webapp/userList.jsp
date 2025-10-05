<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.db.UserDB, com.example.model.User, javax.persistence.EntityManager, com.example.util.DBUtil, java.util.List" %>
<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" href="styles/main.css">
</head>
<body>
<div class="container">
    <h1>User Management</h1>
    <%
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType");
        if (message != null) {
    %>
    <div class="message <%= messageType %>"><%= message %></div>
    <% } %>

    <h2>Add New User</h2>
    <form action="userList" method="post">
        <input type="hidden" name="action" value="insert">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" required>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required>
        <input type="submit" value="Add User">
    </form>

    <h2>Current Users</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Actions</th>
        </tr>
        <%
            EntityManager em = null;
            try {
                em = DBUtil.getEntityManager();
                List<User> users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
                if (users.isEmpty()) {
        %>
        <tr><td colspan="5" style="text-align:center;">No users found.</td></tr>
        <%
        } else {
            for (User user : users) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getFirstName() %></td>
            <td><%= user.getLastName() %></td>
            <td>
                <a href="userList?action=update&id=<%= user.getId() %>">Update</a>
                <form action="userList" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= user.getId() %>">
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');">
                </form>
            </td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5' class='message error'>Error loading users: " + e.getMessage() + "</td></tr>");
            } finally {
                if (em != null && em.isOpen()) {
                    em.close();
                }
            }
        %>
    </table>
    <a href="index.jsp" class="back-home"><i>←</i> Back to Home</a>
</div>
</body>
</html>