<%@page import="com.kosmarket.models.Member"%>
<%@ page import="java.util.List" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("/");
        return;
    }

    Member currentMember = (Member) session.getAttribute("member");
    String firstName = currentMember.getFirstName();
    String email = currentMember.getEmail();
    String search = (String) request.getAttribute("search");
    List<String> selectedCategories = (List<String>) request.getAttribute("selectedCategories");
    String minPrice = (String) request.getAttribute("minPrice");
    String maxPrice = (String) request.getAttribute("maxPrice");
%>
<nav class="bg-white text-gray-800 p-4 shadow-md font-sans sticky top-0 z-50 w-full">
    <div class="container mx-auto flex items-center justify-between flex-wrap">
        <a href="${pageContext.request.contextPath}/" class="font-bold text-2xl" style="font-family: 'Quicksand', sans-serif;">KosMarket</a>

        <!-- hamburger -->
        <div class="md:hidden">
            <button id="mobile-menu-button" class="text-gray-600 hover:text-blue-500 focus:outline-none">
                <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path>
                </svg>
            </button>
        </div>

        <!-- right side for desktop -->
        <div class="hidden md:flex items-center space-x-6">
            <!-- search bar -->
            <div class="relative w-full max-w-xl min-w-xl">
                <form action="/home" method="GET">
                    <% if (selectedCategories != null) {
                        for (String categoryId : selectedCategories) { %>
                    <input type="hidden" name="category" value="<%= categoryId %>">
                    <% }
                    } %>
                    <input type="hidden" name="min-price" value="<%= minPrice != null ? minPrice : "" %>">
                    <input type="hidden" name="max-price" value="<%= maxPrice != null ? maxPrice : "" %>">

                    <label for="search" type="hidden"></label><input type="text" id="search" name="search" placeholder="Cari apa hari ini..." class="w-full py-2 px-4 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-700" value="<%= search != null ? search : "" %>">
                    <div class="absolute inset-y-0 right-0 flex items-center pr-4 pointer-events-none">
                        <!-- search Icon -->
                        <button type="submit">
                            <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                            </svg>
                        </button>
                    </div>
                </form>
            </div>

            <!-- desktop icons -->
            <!-- post product button -->
            <a href="product?menu=product_post" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg transition-colors duration-200 flex items-center space-x-2">
                <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                </svg>
                <span class="font-medium">Post Product</span>
            </a>
            <!-- profile icon -->
            <div class="relative">
                <button id="profile-menu-button" class="text-gray-600 hover:text-blue-500 focus:outline-none cursor-pointer">
                    <div class="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center">
                        <svg class="h-6 w-6 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.5 20.118a7.5 7.5 0 0 1 15 0" />
                        </svg>
                    </div>
                </button>

                <!-- floating menu -->
                <div id="profile-menu" class="hidden absolute right-0 mt-2 w-64 bg-white rounded-lg shadow-lg py-2 z-10">
                    <div class="px-4 py-2">
                        <p class="font-bold text-gray-800"><%= firstName %></p>
                        <p class="text-sm text-gray-600"><%= email %></p>
                    </div>
                    <div class="border-t border-gray-200"></div>
                    <a href="${pageContext.request.contextPath}/account/edit" class="flex items-center px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer">
                        <svg class="h-5 w-5 mr-3 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10" />
                        </svg>
                        Edit profile
                    </a>
                    <a href="${pageContext.request.contextPath}/account/settings" class="flex items-center px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer">
                        <svg class="h-5 w-5 mr-3 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-1.003 1.11-1.226.554-.223 1.19-.223 1.745 0 .55.223 1.02.684 1.11 1.226l.092.548a4.873 4.873 0 00.62 1.434l.493.856c.23.397.63.693 1.08.79l.69.146a4.873 4.873 0 001.434-.62l.856-.493c.397-.23.832-.23 1.226 0l.548.316c.542.312.87.892.87 1.515v.39c0 .623-.328 1.203-.87 1.515l-.548.316a1.46 1.46 0 01-1.226 0l-.856-.493a4.873 4.873 0 00-1.434-.62l-.69.146c-.45.097-.85.393-1.08.79l-.493.856a4.873 4.873 0 00-.62 1.434l-.092.548c-.09.542-.56 1.003-1.11 1.226-.554.223-1.19-.223-1.745 0-.55-.223-1.02-.684-1.11-1.226l-.092-.548a4.873 4.873 0 00-.62-1.434l-.493-.856a1.46 1.46 0 01-1.08-.79l-.69-.146a4.873 4.873 0 00-1.434.62l-.856.493c-.397.23-.832.23-1.226 0l-.548-.316c-.542-.312-.87-.892-.87-1.515v-.39c0-.623.328-1.203.87-1.515l.548-.316a1.46 1.46 0 011.226 0l.856.493c.47-.27.98-.442 1.5-.533l.092-.548z" />
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        Account settings
                    </a>
                    <div class="border-t border-gray-200"></div>
                    <a href="${pageContext.request.contextPath}/authentication?menu=logout" class="flex items-center px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer">
                        <svg class="h-5 w-5 mr-3 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                        Sign out
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- mobile menu  -->
    <div id="mobile-menu" class="hidden md:hidden w-full mt-4">
        <!-- search bar for mobile -->
        <div class="relative mb-4">
            <input type="text" placeholder="Cari apa hari ini..." class="w-full py-2 px-4 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-700">
            <div class="absolute inset-y-0 right-0 flex items-center pr-4 pointer-events-none">
                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                </svg>
            </div>
        </div>

        <!-- mobile icons -->
        <div class="flex flex-col space-y-2">
            <!-- post product button for mobile -->
            <a href="product?menu=product_post" class="flex items-center p-3 rounded bg-blue-500 hover:bg-blue-600 text-white transition-colors duration-200">
                <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                </svg>
                <span class="ml-3 font-medium">Post Product</span>
            </a>
            <a href="${pageContext.request.contextPath}/account" class="flex items-center p-2 rounded hover:bg-gray-100">
                <div class="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center">
                    <svg class="h-6 w-6 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.5 20.118a7.5 7.5 0 0 1 15 0" />
                    </svg>
                </div>
                <span class="ml-2 text-gray-700">Account</span>
            </a>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            const mobileMenu = document.getElementById('mobile-menu');
            const profileMenuButton = document.getElementById('profile-menu-button');
            const profileMenu = document.getElementById('profile-menu');

            mobileMenuButton.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });

            profileMenuButton.addEventListener('click', (event) => {
                profileMenu.classList.toggle('hidden');
                event.stopPropagation();
            });

            document.addEventListener('click', (event) => {
                if (!profileMenu.contains(event.target) && !profileMenuButton.contains(event.target)) {
                    profileMenu.classList.add('hidden');
                }
            });
        });
    </script>
</nav>