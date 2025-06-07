<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<div class="container mx-auto px-4 py-8" style="font-family: 'Quicksand', sans-serif;">
    <div class="text-left mb-8">
        <h1 class="text-4xl font-bold">All Products</h1>
        <p class="text-gray-600 mt-2">Check out all available products.</p>
    </div>

    <main>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <% if (products != null) { %>
                <% for (Product product : products) { %>
                    <% request.setAttribute("product", product); %>
                    <jsp:include page="/WEB-INF/views/components/product_card.jsp"/>
                <% } %>
            <% } else { %>
                <p>No products found.</p>
            <% } %>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/layout/layout_footer.jsp" %>
