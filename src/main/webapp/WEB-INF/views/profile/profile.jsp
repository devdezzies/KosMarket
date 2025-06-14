<%-- Created by IntelliJ IDEA. User: mrfer Date: 30/05/2025 Time: 16:14 To change this template use File | Settings |
    File Templates. --%>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="h-full bg-gray-50">

<head>
    <title>Setelan Profil - KosMarket</title>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
</head>

<body>
<div style="font-family: 'Quicksand', sans-serif;">

    <% String pageParam = request.getParameter("page"); if (pageParam == null) { pageParam = "me"; } %>

    <div class="flex flex-col md:flex-row min-h-screen">
        <!-- Sidebar -->
        <aside id="sidebar" class="w-full md:w-64 bg-white border-r border-gray-200 px-6 py-8">

            <!-- Toggle Button Inside Sidebar -->
            <div class="flex justify-start md:hidden mb-4">
                <button id="menuToggle" class="text-gray-600 hover:text-gray-900">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                </button>
            </div>

            <div id="sidebarMenus" class="space-y-8 transition-all duration-300 ease-in-out">
                <!-- Account Section -->
                <div class="mb-8">
                    <h3 class="text-sm font-semibold text-gray-900 mb-4">Akun</h3>
                    <nav class="space-y-2">
                        <a href="?page=me" class="flex items-center px-3 py-2 text-sm font-medium rounded-lg <%= "me".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 <%= "me".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z">
                                </path>
                            </svg>
                            Edit Profil
                        </a>

                        <a href="?page=products" class="flex items-center px-3 py-2 text-sm font-medium rounded-lg <%= "products".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 <%= "products".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                </path>
                            </svg>
                            Produk Saya
                        </a>

                        <a href="?page=location" class="flex items-center px-3 py-2 text-sm font-medium rounded-lg <%= "location".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z">
                                </path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            Alamat & Lokasi
                        </a>

                        <a href="${pageContext.request.contextPath}/authentication?menu=logout"
                           onclick="return confirm('Logout?');"
                           class="flex items-center px-3 py-2 text-sm font-medium text-red-600 hover:text-red-700 hover:bg-red-50 rounded-lg">
                            <svg class="w-5 h-5 mr-3 text-red-500" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      stroke-width="2"
                                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                                </path>
                            </svg>
                            Logout
                        </a>

                    </nav>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="w-full <%= "products".equals(pageParam) ? "" : "px-4 py-6 md:px-8" %>">
            <div class="max-w-2xl mx-auto">
                <% if (pageParam.equals("me")) { %>
                    <jsp:include page="/WEB-INF/includes/UI/profile/edit_profile.jsp" />
                <% } else if (pageParam.equals("products")) { %>
                    <jsp:include page="/WEB-INF/includes/UI/profile/your_products.jsp" />
                <% } else if (pageParam.equals("location")) { %>
                    <jsp:include page="/WEB-INF/includes/UI/profile/location.jsp" />
                <% } else if (pageParam.equals("edit_product")) { %>
                    <jsp:include page="/WEB-INF/includes/UI/profile/edit_product.jsp" />
                <% } else { %>
                    <div class="text-center text-gray-500 py-8">Halaman tidak ditemukan.</div>
                <% } %>
            </div>
        </main>
    </div>

    <!-- Sidebar Button -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const toggleBtn = document.getElementById('menuToggle');
            const menuSection = document.getElementById('sidebarMenus');

            toggleBtn.addEventListener('click', () => {
                menuSection.classList.toggle('hidden');
            });
        });
    </script>
</div>
</body>
</html>