<%-- Created by IntelliJ IDEA. User: mrfer Date: 07/06/2025 Time: 15:55 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.kosmarket.models.ProductCategory" %>
    <%@ page import="com.kosmarket.models.Product" %>

    <%
        String success = request.getParameter("success");
        String productIdParam = request.getParameter("productId");
        Product product = null;
        if (productIdParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                // Find the product from the list set by controller
                List<Product> userProducts = (List<Product>) request.getAttribute("products");
                if (userProducts != null) {
                    for (Product p : userProducts) {
                        if (p.getId() == productId) {
                            product = p;
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                // handle error
            }
        }
        List<ProductCategory> categories = (List<ProductCategory>) request.getAttribute("categories");
    %>

    <% if ("1".equals(success)) { %>
        <div class="mb-4 p-4 bg-green-100 text-green-800 rounded">
            Produk berhasil diperbarui!
        </div>
    <% } %>

    <%
    String error = request.getParameter("error");
    if (error != null) {
        String errorMsg = "";
        if ("missing_productId".equals(error)) {
            errorMsg = "Gagal menghapus: ID produk tidak ditemukan.";
        } else if ("invalid_productId".equals(error)) {
            errorMsg = "Gagal menghapus: ID produk tidak valid.";
        } else if ("not_found".equals(error)) {
            errorMsg = "Gagal menghapus: Produk tidak ditemukan atau bukan milik Anda.";
        } else {
            errorMsg = "Terjadi kesalahan saat menghapus produk.";
        }
    %>
        <div class="mb-4 p-4 bg-red-100 text-red-800 rounded">
            <%= errorMsg %>
        </div>
    <%
        }
    %>

        <h1 class="text-2xl font-bold text-gray-900 mb-8">Edit Produk</h1>

        <!-- Edit Form -->
        <form action="${pageContext.request.contextPath}/profile/me?page=edit_product&productId=<%= productIdParam %>" onsubmit="return confirm('Edit Produk?');" method="post">
            <input type="hidden" name="productId" value="<%= productIdParam != null ? productIdParam : "" %>">
            <input type="hidden" name="page" value="edit_product">

            <!-- Basic Information Section -->
            <div class="space-y-6">
                <div class="border-b border-gray-200 pb-4">
                    <h3 class="text-lg font-medium text-gray-900">Informasi Produk</h3>
                    <p class="text-sm text-gray-500">Berikan detail tentang produk anda</p>
                </div>

                <!-- Product Name -->
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                        Nama Produk <span class="text-red-500">*</span>
                    </label>
                    <input type="text" id="name" name="name" required
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                        placeholder="e.g., iPhone 13 Pro Max 256GB"
                        value="<%= product != null ? product.getName() : "" %>">
                    <p class="text-xs text-gray-500 mt-1">Gunakan nama yang jelas dan dapat menarik pembeli</p>
                </div>

                <!-- Price and Category Row -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Price -->
                    <div>
                        <label for="price" class="block text-sm font-medium text-gray-700 mb-2">
                            Harga (Rp) <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <span class="absolute left-3 top-3 text-gray-500 text-sm">Rp</span>
                            <input type="number" id="price" name="price" min="0" step="1000" required
                                class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                                placeholder="0"
                                value="<%= product != null ? product.getPrice() : "" %>">
                        </div>
                    </div>

                    <!-- Category -->
                    <div>
                        <label for="categoryId" class="block text-sm font-medium text-gray-700 mb-2">Kategori</label>
                        <select name="categoryId" class="border p-2 w-full">
                            <%
                                if (categories != null) {
                                    for (ProductCategory cat : categories) {
                            %>
                                <option value="<%= cat.getId() %>" <%= (product != null && product.getCategory() != null && product.getCategory().getId() == cat.getId()) ? "selected" : "" %>><%= cat.getName() %></option>
                            <%
                                    }
                                } else {
                            %>
                                <option disabled selected>Tidak ada kategori tersedia</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Product Details Section -->
            <div class="space-y-6">
                <div class="border-b border-gray-200 pb-4">
                    <h3 class="text-lg font-medium text-gray-900">Detail Produk</h3>
                    <p class="text-sm text-gray-500">Tambahkan lebih banyak informasi untuk membantu pembeli memahami produk Anda</p>
                </div>

                <!-- Description -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-2">Deskripsi</label>
                    <textarea id="description" name="description" rows="4"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent resize-none transition-all duration-200"
                            placeholder="Describe your product features, condition, and any important details..."><%= product != null ? product.getDescription() : "" %></textarea>
                    <div class="flex justify-between mt-1">
                        <p class="text-xs text-gray-500">Jelaskan secara rinci dan jujur ​​tentang produk Anda</p>
                        <span class="text-xs text-gray-400" id="char-count">0/500</span>
                    </div>
                </div>

                    <!-- Item Count -->
                <div>
                    <label for="itemCount" class="block text-sm font-medium text-gray-700 mb-2">
                        Jumlah <span class="text-red-500">*</span>
                    </label>
                    <input type="number" id="itemCount" name="itemCount" min="1" required
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                        value="<%= product != null ? product.getItemCount() : "1" %>">
                </div>

            </div>

            <!-- Media Section -->
            <div class="space-y-6">
                <div class="border-b border-gray-200 pb-4">
                    <h3 class="text-lg font-medium text-gray-900">Foto</h3>
                    <p class="text-sm text-gray-500">Masukkan foto produk anda</p>
                </div>

                <!-- Image URL -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Upload Foto:</label>
                    <label for="image" class="inline-block cursor-pointer bg-yellow-400 hover:bg-yellow-500 text-black font-bold py-2 px-4 rounded-lg shadow transition duration-200">
                        Pilih Gambar
                        <input type="file" name="image" id="image" accept="image/*" class="hidden" />
                    </label>
                    <% if (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                        <div class="mt-2">
                            <img src="<%= product.getImageUrl() %>" alt="Current Image" class="w-32 h-32 object-cover rounded">
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row gap-4 pt-6 border-t border-gray-200">
                <button type="submit"
                    class="flex-1 bg-green-400 text-white py-3 px-6 rounded-lg shadow-lg hover:bg-green-500 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2 transition-all duration-200 font-bold text-lg">
                    <span class="flex items-center justify-center">
                        Perbarui
                    </span>
                </button>
                <a href="${pageContext.request.contextPath}/profile/me?page=products"
                    class="flex-1 bg-blue-600 text-white py-3 px-6 rounded-lg shadow hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-red-400 focus:ring-offset-2 transition-all duration-200 text-center font-bold text-lg">
                    Kembali
                </a>
            </div>
        </form>
<!-- Beautified Small Delete Button -->
        <form action="${pageContext.request.contextPath}/profile/me?page=delete_product" method="post" 
            onsubmit="return confirm('Hapus produk?');" 
            class="inline-block mt-4 ml-auto">
            <input type="hidden" name="productId" value="<%= productIdParam != null ? productIdParam : "" %>">
            <button type="submit"
                class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg shadow font-bold text-sm transition duration-200 focus:outline-none focus:ring-2 focus:ring-red-400 focus:ring-offset-2">
                Hapus
            </button>
        </form>

        