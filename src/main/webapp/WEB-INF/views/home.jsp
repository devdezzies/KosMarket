<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kosmarket.models.ProductCategory" %>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<ProductCategory> categories = (List<ProductCategory>) request.getAttribute("categories");
%>

<div class="container mx-auto px-4 py-8" style="font-family: 'Quicksand', sans-serif;">
    <div class="text-left mb-8">
        <h1 class="text-3xl md:text-4xl font-bold">Cari barang apa nih?</h1>
        <p class="text-gray-600 mt-2">Checkout out the latest release of Basic Tees, new and improved with four openings!</p>
    </div>

    <div class="flex flex-col md:flex-row">
        <!-- filters -->
        <aside class="w-full md:w-1/4 pr-0 md:pr-8 mb-8 md:mb-0">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <form action="/home" method="GET">
                    <input type="hidden" name="search" value="<%= search != null ? search : "" %>">
                    <div x-data="{ open: true }" class="mb-4">
                        <button type="button" @click="open = !open" class="w-full flex justify-between items-center cursor-pointer">
                            <h3 class="font-bold text-lg">Kategori</h3>
                            <svg class="w-6 h-6 transform transition-transform" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                        </button>
                        <div x-show="open" x-transition class="mt-4">
                            <% if (categories != null && !categories.isEmpty()) { %>
                            <ul class="w-full text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-lg">
                                <% for (int i = 0; i < categories.size(); i++) { %>
                                    <% ProductCategory category = categories.get(i); %>
                                    <li class="w-full border-b border-gray-200 <%= (i == categories.size() - 1) ? "" : "sm:border-b" %>">
                                        <div class="flex items-center ps-3">
                                            <input id="cat-checkbox-<%= category.getId() %>" name="category" type="checkbox" value="<%= category.getId() %>" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2"
                                                <%= (selectedCategories != null && selectedCategories.contains(String.valueOf(category.getId()))) ? "checked" : "" %>>
                                            <label for="cat-checkbox-<%= category.getId() %>" class="w-full py-3 ms-2 text-sm font-medium text-gray-900"><%= category.getName() %></label>
                                        </div>
                                    </li>
                                <% } %>
                            </ul>
                            <% } else { %>
                            <p>No categories found.</p>
                            <% } %>
                        </div>
                    </div>
                    <hr class="my-4 border-gray-200">
                    <div x-data="{ open: true }" class="mb-4">
                        <button type="button" @click="open = !open" class="w-full flex justify-between items-center cursor-pointer">
                            <h3 class="font-bold text-lg">Harga</h3>
                            <svg class="w-6 h-6 transform transition-transform" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                        </button>
                        <div x-show="open" x-transition class="mt-4">
                            <div class="space-y-4">
                                <div>
                                    <label for="min-price" class="block text-sm font-medium text-gray-700 mb-1">Harga Minimum</label>
                                    <input type="number" id="min-price" name="min-price" placeholder="Rp 0" class="w-full bg-transparent placeholder:text-slate-400 text-slate-700 text-sm border border-slate-200 rounded-md px-3 py-2 transition duration-300 ease focus:outline-none focus:border-slate-400 hover:border-slate-300 shadow-sm focus:shadow"
                                        value="<%= minPrice != null ? minPrice : "" %>">
                                </div>
                                <div>
                                    <label for="max-price" class="block text-sm font-medium text-gray-700 mb-1">Harga Maksimum</label>
                                    <input type="number" id="max-price" name="max-price" placeholder="Rp 1.000.000" class="w-full bg-transparent placeholder:text-slate-400 text-slate-700 text-sm border border-slate-200 rounded-md px-3 py-2 transition duration-300 ease focus:outline-none focus:border-slate-400 hover:border-slate-300 shadow-sm focus:shadow"
                                        value="<%= maxPrice != null ? maxPrice : "" %>">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Bookmark Filter -->
                    <hr class="my-4 border-gray-200">
                    <div x-data="{ open: true }" class="mb-4">
                        <button type="button" @click="open = !open" class="w-full flex justify-between items-center cursor-pointer">
                            <h3 class="font-bold text-lg">Bookmark</h3>
                            <svg class="w-6 h-6 transform transition-transform" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>
                        <div x-show="open" x-transition class="mt-4">
                            <div class="w-full text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-lg">
                                <div class="flex items-center ps-3 py-3">
                                    <input id="filter-bookmark" name="only-bookmarked" type="checkbox"
                                           class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2"
                                        <%= "on".equals(request.getParameter("only-bookmarked")) ? "checked" : "" %>>
                                    <label for="filter-bookmark" class="ms-2 text-sm font-medium text-gray-900">Hanya yang dibookmark</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="w-full bg-blue-600 text-white py-2 px-4 rounded-lg hover:bg-blue-700 transition-colors font-semibold">Apply Filters</button>
                </form>
            </div>
        </aside>

        <!-- products -->
        <main class="w-full md:w-3/4">
            <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 md:gap-6">
                <% if (products != null) { %>
                    <% for (Product product : products) { %>
                        <% request.setAttribute("product", product); %>
                        <jsp:include page="/WEB-INF/views/components/product_card.jsp"/>
                    <% } %>
                <% } %>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/layout_footer.jsp" %>