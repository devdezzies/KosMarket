<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 11/05/2025
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
	Product product = (Product) request.getAttribute("product");
	NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
	String formattedPrice = format.format(product.getPrice()).replace(",00", "");
	String categoryName = product.getCategory() != null ? product.getCategory().getName() : "Uncategorized";
%>

<div class="bg-white rounded-lg shadow-md overflow-hidden transition-shadow duration-300 hover:shadow-xl cursor-pointer"
		 onclick="window.location.href='product?menu=product_view&id=<%= product.getId() %>'">
	<div class="bg-gray-200 h-48 w-full overflow-hidden">
		<img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "" %>"
				 alt="Image of <%= product.getName() %>"
				 class="w-full h-full object-cover">
	</div>
	<div class="p-4">
		<h3 class="font-bold text-lg"><%= formattedPrice %></h3>
		<p class="text-gray-800 truncate"><%= product.getName() %></p>
		<p class="text-gray-600 text-sm"><%= categoryName %></p>
		   </div>
</div>
