<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 19/05/2025
  Time: 08:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="h-full bg-white">
<head>
  <title>Authentication</title>
  <%@ include file="/WEB-INF/includes/header.jsp" %>
</head>
<body class="h-full font-[Quicksand]">
  <div class="flex min-h-screen flex-col lg:flex-row lg:items-stretch justify-center">
    <div class="hidden lg:block lg:flex-[1.3] overflow-hidden h-auto min-h-[600px]" id="left-side">
      <img class="w-full h-full max-h-screen max-w-full object-cover object-center" src="https://images.unsplash.com/photo-1698928773747-3be8b64fa0cc?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="auth illustration">
    </div>
    <div class="flex flex-[0.7] flex-col justify-center md:px-6" id="right-side">
      <%
        String pageParam = request.getParameter("page");
        if (pageParam == null) {
          pageParam = "login";
        }
      %>
      <% if (pageParam.equals("login")) {%>
        <jsp:include page="/WEB-INF/includes/UI/login.jsp"/>
      <% } else { %>
        <jsp:include page="/WEB-INF/includes/UI/registration.jsp"/>
      <% } %>
    </div>
  </div>
</body>
</html>