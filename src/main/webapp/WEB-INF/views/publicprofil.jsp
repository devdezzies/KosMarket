<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="com.kosmarket.models.ProductCategory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<ProductCategory> categories = (List<ProductCategory>) request.getAttribute("categories");
    NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));

    Product sampleProduct = (products != null && !products.isEmpty()) ? products.get(0) : null;

    String sellerfirstName = "Tidak diketahui";
    String lastName = "";
    String selleremail = "-";
    String phoneNumber = "-";
    String addressText = "-";
    String joinDate = "-";

    if (sampleProduct != null && sampleProduct.getMember() != null) {
        if (sampleProduct.getMember().getFirstName() != null) {
            firstName = sampleProduct.getMember().getFirstName();
        }
        if (sampleProduct.getMember().getLastName() != null) {
            lastName = sampleProduct.getMember().getLastName();
        }
        if (sampleProduct.getMember().getEmail() != null) {
            email = sampleProduct.getMember().getEmail();
        }
        if (sampleProduct.getMember().getAddress() != null) {
            if (sampleProduct.getMember().getAddress().getPhone() != null) {
                phoneNumber = sampleProduct.getMember().getAddress().getPhone();
            }
            if (sampleProduct.getMember().getAddress() != null) {
                addressText = sampleProduct.getMember().getAddress().getFullAddress();
            }


        }
        if (sampleProduct.getMember().getCreatedAt() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy", new Locale("id", "ID"));
            joinDate = sdf.format(sampleProduct.getMember().getCreatedAt());
        }
    }
%>

<div class="container mx-auto px-4 py-8" style="font-family: 'Quicksand', sans-serif;">
    <!-- User Profile Section -->
    <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
        <div class="flex items-center space-x-4">
            <div class="w-20 h-20 bg-purple-200 rounded-full flex items-center justify-center">
                <div class="w-12 h-12 border-4 border-purple-600 rounded-full"></div>
            </div>
            <div class="flex-1">
                <h2 class="text-2xl font-bold text-gray-800"><%= firstName %> <%= lastName %></h2>
                <p class="text-gray-600"><%= email %></p>
                <p class="text-gray-600"><%= phoneNumber %></p>
                <p class="text-gray-600"><%= addressText %></p>
                <p class="text-sm text-gray-500 mt-1">Bergabung sejak <%= joinDate %></p>
            </div>
        </div>
    </div>

    <!-- Products Section Header -->
    <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800">Produk</h2>
    </div>

    <!-- Products Grid -->
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 md:gap-6">
        <% if (products != null && !products.isEmpty()) { %>
        <% for (Product product : products) {
            String formattedPrice = format.format(product.getPrice()).replace(",00", "");
            String categoryName = product.getCategory() != null ? product.getCategory().getName() : "Uncategorized";
        %>
        <div class="bg-white rounded-lg shadow-md overflow-hidden transition-shadow duration-300 hover:shadow-xl cursor-pointer"
             onclick="window.location.href='product?menu=product_view&id=<%= product.getId() %>'">
            <div class="w-full h-32 bg-gray-200 overflow-hidden">
                <img src="<%= product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? product.getImageUrl() : "/assets/images/no-image.png" %>"
                     alt="Image of <%= product.getName() %>"
                     class="w-full h-full object-cover">
            </div>
            <div class="p-3">
                <h3 class="font-bold text-lg text-gray-800 mb-1"><%= formattedPrice %></h3>
                <p class="font-semibold text-gray-700 mb-1"><%= product.getName() %></p>
                <p class="text-sm text-gray-500"><%= categoryName %></p>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <% for (int i = 0; i < 10; i++) { %>
        <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-md transition-shadow">
            <div class="w-full h-32 bg-purple-100 rounded-t-lg"></div>
            <div class="p-3">
                <h3 class="font-bold text-lg text-gray-800 mb-1">Rp. 150.000</h3>
                <p class="font-semibold text-gray-700 mb-1">Nama Barang</p>
                <p class="text-sm text-gray-500">Nama Lokasi</p>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/layout_footer.jsp" %>
