<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 11/05/2025
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>

<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="com.kosmarket.models.Bookmark" %>
<%@ page import="com.kosmarket.models.ProductCategory" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
	Product product = (Product) request.getAttribute("product");
	NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
	String formattedPrice = format.format(product.getPrice()).replace(",00", "");
	String categoryName = product.getCategory() != null ? product.getCategory().getName() : "Uncategorized";
%>



<div class="bg-gray-50 min-h-screen py-6">
	<div class="container mx-auto px-4 max-w-6xl">
		<!-- Breadcrumb -->
		<nav class="mb-6">
			<div class="flex items-center space-x-2 text-sm text-gray-600">
				<a href="/" class="hover:text-blue-600 transition-colors">Home</a>
				<span class="text-gray-400">/</span>
				<a href="#" class="hover:text-blue-600 transition-colors">Category</a>
				<span class="text-gray-400">/</span>
				<span class="text-blue-600 font-medium"><%= categoryName %></span>
			</div>
		</nav>

		<div class="bg-white rounded-lg shadow-lg overflow-hidden">
			<div class="lg:flex lg:gap-8 p-6">
				<!-- Product Images -->
				<div class="lg:w-1/2 mb-6 lg:mb-0">
					<div class="flex gap-4">

						<!-- Main Image -->
						<div class="flex-1">
							<div class="aspect-square bg-gray-200 rounded-lg overflow-hidden shadow-md">
								<img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "/images/placeholder.jpg" %>"
									 alt="<%= product.getName() %>"
									 class="w-full h-full object-cover">
							</div>
						</div>
					</div>
				</div>

				<!-- Product Info -->
				<div class="lg:w-1/2">
					<!-- Seller Info -->
					<div class="mb-4 flex items-center">
						<span class="text-sm text-gray-500">Dijual oleh</span>
						<%
							String sellerName = product.getMember() != null ? product.getMember().getFirstName() : "Tidak diketahui";
							int sellerId = product.getMember() != null ? product.getMember().getId() : -1;
						%>

						<% if (product.getMember() != null) { %>
						<a href="public-profile?id=<%= sellerId %>" class="text-blue-600 font-semibold ml-2 hover:underline">
							<%= sellerName %>
						</a>
						<% } else { %>
						<span class="text-blue-600 font-semibold ml-2">Tidak diketahui</span>
						<% } %>


						<div class="ml-2 w-2 h-2 bg-green-400 rounded-full"></div>
					</div>

					<h1 class="text-2xl lg:text-3xl font-bold text-gray-900 mb-4 leading-tight">
						<%= product.getName() %>
					</h1>

					<div class="flex items-center justify-between mb-6">
						<div class="text-3xl font-bold text-gray-900">
							<%= formattedPrice %>
						</div>
						<div class="flex items-center space-x-3">
							<% if (product.getItemCount() > 0) { %>
							<span class="bg-green-100 text-green-600 text-sm font-medium px-3 py-1 rounded-full">
                                    <%= product.getItemCount() %> in stock
                                </span>
							<% } else { %>
							<span class="bg-red-100 text-red-600 text-sm font-medium px-3 py-1 rounded-full">
                                    Out of stock
                                </span>
							<% } %>
							<!-- Bookmark Icon -->

						</div>
					</div>

					<!-- Location -->
					<div class="mb-6 p-4 bg-gray-50 rounded-lg">
						<h3 class="font-semibold text-gray-900 mb-2 flex items-center">
							<svg class="w-5 h-5 text-gray-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
							</svg>
							Lokasi
						</h3>
						<p class="text-gray-700">
							<%= product.getMember() != null && product.getMember().getAddress() != null
									? product.getMember().getAddress().getFullAddress()
									: "Lokasi tidak tersedia" %>
						</p>
					</div>

					<!-- Description -->
					<div class="mb-8 p-4 bg-blue-50 rounded-lg">
						<h3 class="font-semibold text-gray-900 mb-3 flex items-center">
							<svg class="w-5 h-5 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
							</svg>
							Deskripsi
						</h3>
						<p class="text-gray-700 leading-relaxed">
							<%= product.getDescription() != null ? product.getDescription() : "Deskripsi tidak tersedia" %>
						</p>
					</div>

					<!-- Action Buttons -->
					<div class="space-y-3">
						<button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-4 px-6 rounded-lg transition duration-300 flex items-center justify-center cursor-pointer"
								onclick="openWhatsApp()"
								<%
									String phoneNumber = "6281234567890"; // default/fallback number
									if (product.getMember() != null &&
											product.getMember().getAddress() != null &&
											product.getMember().getAddress().getPhone() != null) {
										phoneNumber = product.getMember().getAddress().getPhone();
									}
								%>
						>
							<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
								<path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.488"/>
							</svg>
							Terhubung dengan whatsapp penjual
						</button>
					</div>

					<script>
						function openWhatsApp() {
							const whatsappUrl = 'https://wa.me/<%= phoneNumber %>?text=Halo,%20saya%20tertarik%20dengan%20produk%20yang%20Anda%20jual.';
							window.open(whatsappUrl, '_blank');
						}
					</script>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/layout/layout_footer.jsp"%>