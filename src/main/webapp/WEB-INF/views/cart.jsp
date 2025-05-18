<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 11/05/2025
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>KosMarket - Shopping Cart</title>
	<%@ include file="/WEB-INF/includes/header.jsp" %>
</head>
<body class="bg-gray-100 min-h-screen">
	<div class="container mx-auto px-4 py-8">
		<h1 class="text-3xl font-bold text-blue-600 mb-4">Your Shopping Cart</h1>
		<div class="bg-white shadow-md rounded p-6">
			<p class="text-gray-700 mb-4">Your cart is empty.</p>
			<a href="#" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
				Continue Shopping
			</a>
		</div>
	</div>
</body>
</html>
