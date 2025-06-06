<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
    <h1>Welcome to KosMarket!</h1>
    <p>You have successfully logged in</p>

    <form action="${pageContext.request.contextPath}/authentication?menu=logout" method="post">
        <button type="submit">Logout</button>
    </form>
</body>
</html> 