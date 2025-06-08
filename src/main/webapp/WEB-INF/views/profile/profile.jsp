<%--
  Created by IntelliJ IDEA.
  User: mrfer
  Date: 30/05/2025
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title>Setelan Profil - KosMarket</title>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
</head>
<body class="h-full font-[Quicksand] bg-gray-50">
<!-- Header -->
<header class="bg-white border-b border-gray-200 px-6 py-4">
    <div class="flex items-center justify-between max-w-7xl mx-auto">
        <!-- Logo -->
        <div class="flex items-center">
            <h1 class="text-xl font-bold text-gray-900">KosMarket</h1>
        </div>

        <!-- Search Bar -->
        <div class="flex-1 max-w-lg mx-8">
            <div class="relative">
                <input type="text"
                       placeholder="Cari barang..."
                       class="w-full px-4 py-2 pl-4 pr-10 text-sm border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                <button class="absolute right-3 top-1/2 transform -translate-y-1/2">
                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Header Icons -->
        <div class="flex items-center space-x-4">
            <button class="p-2 text-gray-400 hover:text-gray-600">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>
            <button class="p-2 text-gray-400 hover:text-gray-600">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5z"></path>
                </svg>
            </button>
            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center">
                <span class="text-sm font-medium text-gray-600">W</span>
            </div>
        </div>
    </div>
</header>

<%
    String pageParam = request.getParameter("page");
    if (pageParam == null) {
        pageParam = "me";
    }
%>

<div class="flex flex-col md:flex-row min-h-screen">
    <!-- Sidebar -->
    <aside id="sidebar"
           class="w-full md:w-64 bg-white border-r border-gray-200 px-6 py-8">

        <!-- Toggle Button Inside Sidebar -->
        <div class="flex justify-start md:hidden mb-4">
            <button id="menuToggle" class="text-gray-600 hover:text-gray-900">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 6h16M4 12h16M4 18h16"/>
                </svg>
            </button>
        </div>


        <div id="sidebarMenus" class="space-y-8 transition-all duration-300 ease-in-out">
            <!-- Account Section -->
            <div>
                <!-- Account Section -->
                <div class="mb-8">
                    <h3 class="text-sm font-semibold text-gray-900 mb-4">Akun</h3>
                    <nav class="space-y-2">
                        <a href="?page=me"
                           class="flex items-center px-3 py-2 text-sm font-medium rounded-lg
                   <%= "me".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 <%= "me".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                            Edit Profil
                        </a>

                        <a href="?page=products"
                           class="flex items-center px-3 py-2 text-sm font-medium rounded-lg
                   <%= "products".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 <%= "products".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                            </svg>
                            Produk Saya
                        </a>

                        <a href="?page=location"
                           class="flex items-center px-3 py-2 text-sm font-medium rounded-lg
                    <%= "location".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            Alamat & Lokasi
                        </a>

                        <a href="?page=bookmarks"
                           class="flex items-center px-3 py-2 text-sm font-medium rounded-lg
                    <%= "bookmarks".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"></path>
                            </svg>
                            Bookmarks
                        </a>
                    </nav>
                </div>
            </div>

            <!-- General Section -->
            <div>
                <div>
                    <h3 class="text-sm font-semibold text-gray-900 mb-4">Umum</h3>
                    <nav class="space-y-2">

                        <a href="?page=settings"
                           class="flex items-center px-3 py-2 text-sm font-medium rounded-lg
                    <%= "settings".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">
                            <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            Pengaturan
                        </a>

                        <a href="#"
                           class="flex items-center px-3 py-2 text-sm font-medium text-red-600 hover:text-red-700 hover:bg-red-50 rounded-lg">
                            <svg class="w-5 h-5 mr-3 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                            </svg>
                            Logout
                        </a>
                    </nav>
                </div>
            </div>
        </div>

<%--        <!-- Account Section -->--%>
<%--        <div class="mb-8">--%>
<%--            <h3 class="text-sm font-semibold text-gray-900 mb-4">Akun</h3>--%>
<%--            <nav class="space-y-2">--%>
<%--                <a href="?page=me"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium rounded-lg--%>
<%--                   <%= "me".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">--%>
<%--                    <svg class="w-5 h-5 mr-3 <%= "me".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>"--%>
<%--                         fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>--%>
<%--                    </svg>--%>
<%--                    Edit Profil--%>
<%--                </a>--%>

<%--                <a href="?page=products"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium rounded-lg--%>
<%--                   <%= "products".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">--%>
<%--                    <svg class="w-5 h-5 mr-3 <%= "products".equals(pageParam) ? "text-gray-500" : "text-gray-400" %>"--%>
<%--                         fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>--%>
<%--                    </svg>--%>
<%--                    Produk Saya--%>
<%--                </a>--%>

<%--                <a href="?page=location"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium rounded-lg--%>
<%--                    <%= "location".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">--%>
<%--                    <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>--%>
<%--                    </svg>--%>
<%--                    Alamat & Lokasi--%>
<%--                </a>--%>

<%--                <a href="?page=bookmarks"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium rounded-lg--%>
<%--                    <%= "bookmarks".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">--%>
<%--                    <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"></path>--%>
<%--                    </svg>--%>
<%--                    Bookmarks--%>
<%--                </a>--%>
<%--            </nav>--%>
<%--        </div>--%>

        <!-- General Section -->
<%--        <div>--%>
<%--            <h3 class="text-sm font-semibold text-gray-900 mb-4">Umum</h3>--%>
<%--            <nav class="space-y-2">--%>

<%--                <a href="?page=settings"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium rounded-lg--%>
<%--                    <%= "settings".equals(pageParam) ? "bg-gray-100 text-gray-900" : "text-gray-600 hover:text-gray-900 hover:bg-gray-50" %>">--%>
<%--                    <svg class="w-5 h-5 mr-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>--%>
<%--                    </svg>--%>
<%--                    Pengaturan--%>
<%--                </a>--%>

<%--                <a href="#"--%>
<%--                   class="flex items-center px-3 py-2 text-sm font-medium text-red-600 hover:text-red-700 hover:bg-red-50 rounded-lg">--%>
<%--                    <svg class="w-5 h-5 mr-3 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>--%>
<%--                    </svg>--%>
<%--                    Logout--%>
<%--                </a>--%>
<%--            </nav>--%>
<%--        </div>--%>
    </aside>

    <!-- Main Content -->
    <main class="w-full px-4 py-6 md:px-8">
        <div class="max-w-2xl mx-auto">
            <% if (pageParam.equals("me")) { %>
            <jsp:include page="/WEB-INF/includes/UI/profile/edit_profile.jsp"/>
            <% } else if (pageParam.equals("products")) { %>
            <jsp:include page="/WEB-INF/includes/UI/profile/your_products.jsp"/>
            <% } else if (pageParam.equals("location")) { %>
            <jsp:include page="/WEB-INF/includes/UI/profile/location.jsp"/>
            <% } else if (pageParam.equals("bookmarks")) { %>
            <jsp:include page="/WEB-INF/includes/UI/profile/bookmarks.jsp"/>
            <% } else if (pageParam.equals("settings")) { %>
            <jsp:include page="/WEB-INF/includes/UI/profile/settings.jsp"/>
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

</body>
</html>
