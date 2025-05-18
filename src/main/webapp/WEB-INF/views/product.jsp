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
	<title>KosMarket - Products</title>
	<%@ include file="/WEB-INF/includes/header.jsp" %>
</head>
<body class="bg-gray-100 min-h-screen">
	<div class="container mx-auto px-4 py-8">
		<h1 class="text-3xl font-bold text-blue-600 mb-4">Products</h1>
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
			<!-- Example product card -->
			<div class="bg-white shadow-md rounded p-6">
				<h2 class="text-xl font-semibold text-gray-800 mb-2">Product Name</h2>
				<p class="text-gray-600 mb-4">Product description goes here.</p>
				<div class="flex justify-between items-center">
					<span class="text-blue-600 font-bold">$99.99</span>
					<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-3 rounded">
						Add to Cart
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
