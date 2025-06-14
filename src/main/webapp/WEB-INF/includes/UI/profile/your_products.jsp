<%--
  Created by IntelliJ IDEA.
  User: mrfer
  Date: 07/06/2025
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Product> products = (ArrayList<Product>) request.getAttribute("products");
%>

<h1 class="text-2xl font-bold text-gray-900 mb-8">Produk Saya</h1>

<main class="w-full">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
        <% if (products != null && !products.isEmpty()) { %>
            <% for (Product product : products) { 
                request.setAttribute("product", product);
            %>
                <jsp:include page="/WEB-INF/views/components/profile/my_product_card.jsp"/>
            <% } %>
        <% } else { %>
            <div class="col-span-full text-center text-gray-500">Tidak ada produk milik Anda.</div>
        <% } %>
    </div>
</main>