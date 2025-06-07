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
  <div class="flex flex-col justify-center items-center min-h-screen lg:flex-row lg:justify-start lg:items-stretch lg:h-screen lg:min-h-0">
    <div class="hidden lg:block lg:flex-[1.3] overflow-hidden" id="left-side">
      <img class="w-full h-full object-cover object-center" src="https://images.unsplash.com/photo-1698928773747-3be8b64fa0cc?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="auth illustration">
    </div>
    <div class="w-full md:px-6 lg:flex-[0.7] lg:w-auto lg:overflow-y-auto" id="right-side">
      <%
        String pageParam = request.getParameter("page");
        String tab = (String) request.getAttribute("tab");
        if (pageParam == null) {
            if (tab != null && tab.equals("register")) {
                pageParam = "register";
            } else {
                pageParam = "login";
            }
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