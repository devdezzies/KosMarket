<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KosMarket - Admin</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="min-h-screen font-[Quicksand] flex flex-col overflow-hidden px-4 md:px-6">
    <!-- Header -->
    <header class="bg-white px-4 md:px-6 py-4 flex justify-between items-center">
        <h1 class="text-lg md:text-xl font-semibold text-gray-800">KosMarket</h1>
        <div class="flex items-center space-x-2">
            <!-- Mobile menu toggle -->
            <button id="mobile-menu-btn" class="md:hidden p-2 rounded-md text-gray-600 hover:text-gray-900 hover:bg-gray-100">
                <i class="fas fa-bars text-xl"></i>
            </button>
            <span class="text-sm text-gray-600">Welcome, Admin</span>
            <a href="${pageContext.request.contextPath}/authentication?action=logout" 
               class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </div>
    </header>

    <div class="flex h-screen overflow-hidden">
        <!-- Mobile Overlay -->
        <div id="mobile-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-20 hidden md:hidden"></div>

        <!-- Sidebar -->
        <aside id="sidebar" class="fixed md:relative z-30 w-80 bg-white h-full border-r border-gray-200 transform transition-transform duration-300 ease-in-out overflow-y-auto -translate-x-full md:translate-x-0">
            <div class="p-4 md:p-6">
                <!-- Mobile close button -->
                <div class="flex justify-between items-center mb-4 md:hidden">
                    <h2 class="text-lg font-semibold text-gray-800">Menu</h2>
                    <button id="close-sidebar" class="p-2 rounded-md text-gray-600 hover:text-gray-900 hover:bg-gray-100">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>

                <div class="mt-4 md:mt-8">
                    <h3 class="text-lg md:text-xl font-semibold text-gray-800 mb-6">Admin Control</h3>
                </div>

                <!-- Navigation Tabs -->
                <div class="mb-6">
                    <div class="flex flex-col space-y-2">
                        <a onclick="selectMenu(this, 'users')" class="menu-item flex w-full rounded-full bg-white-200 px-4 py-3 text-sm/6 font-bold text-gray-700 hover:bg-gray-300 transition-colors items-center">
                            <i class="fas fa-users mr-3 flex-shrink-0"></i>
                            <span class="text-xs md:text-sm whitespace-nowrap">User Control</span>
                        </a>

                        <a onclick="selectMenu(this, 'products')" class="menu-item flex w-full rounded-full bg-white-200 px-4 py-3 text-sm/6 font-bold text-gray-700 hover:bg-gray-300 transition-colors items-center">
                            <i class="fas fa-shopping-cart mr-3 flex-shrink-0"></i>
                            <span class="text-xs md:text-sm whitespace-nowrap">Product Management</span>
                        </a>

                        <a onclick="selectMenu(this, 'categories')" class="menu-item flex w-full rounded-full bg-white-200 px-4 py-3 text-sm/6 font-bold text-gray-700 hover:bg-gray-300 transition-colors items-center">
                            <i class="fas fa-tags mr-3 flex-shrink-0"></i>
                            <span class="text-xs md:text-sm whitespace-nowrap">Category Management</span>
                        </a>
                    </div>
                </div>

                <!-- Overview Section -->
                <div class="mt-4 md:mt-8">
                    <h3 class="text-lg md:text-xl font-semibold text-gray-800 mb-6">Overview</h3>
                </div>      

                <div class="bg-gray-100 p-4 rounded-2xl mb-6">
                    <div class="space-y-3">
                        <!-- Dashboard Status -->
                        <div class="flex justify-between items-center">
                            <div class="flex items-center">
                                <div>
                                    <span class="text-xs font-medium text-gray-700">Server </span>
                                </div>
                            </div>
                            <span class="text-sm font-bold text-yellow-800">Local</span>
                        </div>
                        <!-- Database Status -->
                        <div class="flex justify-between items-center">
                            <div class="flex items-center">
                                <div>
                                    <span class="text-xs font-medium text-gray-700">Database Status</span>
                                </div>
                            </div>
                            <% if (request.getAttribute("dbConnection") != null && (Boolean)request.getAttribute("dbConnection")) { %>
                                <span class="text-sm font-bold text-green-600">Online</span>
                            <% } else { %>
                                <span class="text-sm font-bold text-red-600">Offline</span>
                            <% } %>
                        </div>
                        <!-- Product Count -->
                        <div class="flex justify-between items-center">
                            <div class="flex items-center">
                                <div>
                                    <span class="text-xs font-medium text-gray-700">Database Server</span>
                                </div>
                            </div>
                            <span class="text-sm font-bold text-gray-800">99%</span>
                        </div>
                        <!-- Category Count -->
                        <div class="flex justify-between items-center">
                            <div class="flex items-center">
                                <div>
                                    <span class="text-xs font-medium text-gray-700">Database Server</span>
                                </div>
                            </div>
                            <span class="text-sm font-bold text-gray-800">99%</span>
                        </div>

                    </div>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main id="main-content" class="flex-1 h-full overflow-y-auto">

            <!-- Default Message Section -->
            <div id="default-content" class="flex flex-col justify-center items-center h-full min-h-[70vh]">
                
                <div class="text-center mb-8">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-4">Welcome to Admin Space</h1>
                    <h3 class="text-lg md:text-xl font-medium text-gray-600">Select what you want to manage</h3>
                </div>

                <!-- Mobile Navigation Buttons -->
                <div class="md:hidden w-full max-w-sm px-4">
                    <div class="flex flex-col space-y-4">
                        <a onclick="selectMenu(this, 'users')" class="menu-item-mobile flex w-full rounded-full bg-white px-4 py-4 text-sm font-bold text-gray-700 hover:bg-gray-100 transition-colors items-center border border-gray-200">
                            <i class="fas fa-users mr-3 text-indigo-600 flex-shrink-0"></i>
                            <span class="whitespace-nowrap">User Control</span>
                        </a>

                        <a onclick="selectMenu(this, 'products')" class="menu-item-mobile flex w-full rounded-full bg-white px-4 py-4 text-sm font-bold text-gray-700 hover:bg-gray-100 transition-colors items-center border border-gray-200">
                            <i class="fas fa-shopping-cart mr-3 text-indigo-600 flex-shrink-0"></i>
                            <span class="whitespace-nowrap">Product Management</span>
                        </a>

                        <a onclick="selectMenu(this, 'categories')" class="menu-item-mobile flex w-full rounded-full bg-white px-4 py-4 text-sm font-bold text-gray-700 hover:bg-gray-100 transition-colors items-center border border-gray-200">
                            <i class="fas fa-tags mr-3 text-indigo-600 flex-shrink-0"></i>
                            <span class="whitespace-nowrap">Category Management</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Dynamic Content Area -->
            <div id="dynamic-content" class="hidden w-full h-full">

            </div>

        </main> 
    </div>

    <script>
    function selectMenu(selectedElement, section) {
        // For desktop menu items
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.className = 'menu-item flex w-full rounded-full px-4 py-3 text-sm/6 font-bold text-gray-700 hover:bg-gray-300 transition-colors items-center';
        });
        
        // For mobile menu items
        const mobileMenuItems = document.querySelectorAll('.menu-item-mobile');
        mobileMenuItems.forEach(item => {
            item.className = 'menu-item-mobile flex w-full rounded-full bg-white px-4 py-4 text-sm font-bold text-gray-700 hover:bg-gray-100 transition-colors items-center border border-gray-200';
        });
        
        // Add active styles to selected item
        if (selectedElement.classList.contains('menu-item')) {
            selectedElement.className = 'menu-item flex w-full rounded-full bg-indigo-600 px-4 py-3 text-sm/6 font-bold text-white shadow-xs hover:bg-indigo-500 active:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 transition-colors items-center';
        } else if (selectedElement.classList.contains('menu-item-mobile')) {
            selectedElement.className = 'menu-item-mobile flex w-full rounded-full bg-indigo-600 px-4 py-4 text-sm font-bold text-white hover:bg-indigo-500 transition-colors items-center border border-indigo-600';
        }
        
        // Close mobile sidebar after selection
        if (window.innerWidth < 768) {
            closeMobileSidebar();
        }
        
        // Load content based on section
        loadContent(section);
        
        console.log('Selected section:', section);
    }

    function loadContent(section) {
        const defaultContent = document.getElementById('default-content');
        const dynamicContent = document.getElementById('dynamic-content');
        
        // Hide default content and show dynamic content area
        defaultContent.classList.add('hidden');
        dynamicContent.classList.remove('hidden');
        
        // Clear previous content
        dynamicContent.innerHTML = '<div class="p-6"><div class="animate-pulse">Loading...</div></div>';

        if (section === 'users') {
            fetch('${pageContext.request.contextPath}/admin?section=users')
                .then(response => response.text())
                .then(html => {
                    dynamicContent.innerHTML = html;
                    // Execute scripts in loaded content
                    executeScripts(dynamicContent);
                })
                .catch(error => {
                    console.error('Error loading User Control:', error);
                    dynamicContent.innerHTML = '<div class="p-4"><h2 class="text-xl text-red-600">Error loading User Control content</h2></div>';
                });
        } else if (section === 'products') {
            fetch('${pageContext.request.contextPath}/admin?section=products')
                .then(response => response.text())
                .then(html => {
                    dynamicContent.innerHTML = html;
                    executeScripts(dynamicContent);
                })
                .catch(error => {
                    console.error('Error loading Product Control:', error);
                    dynamicContent.innerHTML = '<div class="p-4"><h2 class="text-xl text-red-600">Error loading Product Control content</h2></div>';
                });
        } else if (section === 'categories') {
            fetch('${pageContext.request.contextPath}/admin?section=categories')
                .then(response => response.text())
                .then(html => {
                    dynamicContent.innerHTML = html;
                    executeScripts(dynamicContent);
                })
                .catch(error => {
                    console.error('Error loading Category Control:', error);
                    dynamicContent.innerHTML = '<div class="p-4"><h2 class="text-xl text-red-600">Error loading Category Control content</h2></div>';
                });
        }
    }

    // Function to execute scripts in dynamically loaded content
    function executeScripts(container) {
        const scripts = container.querySelectorAll('script');
        scripts.forEach(script => {
            const newScript = document.createElement('script');
            if (script.src) {
                newScript.src = script.src;
            } else {
                newScript.textContent = script.textContent;
            }
            document.head.appendChild(newScript);
            document.head.removeChild(newScript);
        });
    }
    
    // Mobile sidebar functionality
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('sidebar');
    const mobileOverlay = document.getElementById('mobile-overlay');
    const closeSidebarBtn = document.getElementById('close-sidebar');

    function openMobileSidebar() {
        sidebar.classList.remove('-translate-x-full');


        document.body.classList.add('overflow-hidden');
    }

    function closeMobileSidebar() {
        sidebar.classList.add('-translate-x-full');
        mobileOverlay.classList.add('hidden');
        document.body.classList.remove('overflow-hidden');
    }

    mobileMenuBtn.addEventListener('click', openMobileSidebar);
    closeSidebarBtn.addEventListener('click', closeMobileSidebar);
    mobileOverlay.addEventListener('click', closeMobileSidebar);

    window.addEventListener('resize', () => {
        if (window.innerWidth >= 768) {
            closeMobileSidebar();
        }
    });

    // Check if there's an active section
    const activeSection = '<%= request.getAttribute("activeSection") != null ? request.getAttribute("activeSection") : "" %>';
    if (activeSection && activeSection !== '') {
        loadContent(activeSection);
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.classList.remove('bg-indigo-600', 'text-white');
            item.classList.add('bg-white-200', 'text-gray-700');
        });
        
        const activeMenuItem = document.querySelector(`[onclick*="${activeSection}"]`);
        if (activeMenuItem) {
            activeMenuItem.classList.remove('bg-white-200', 'text-gray-700');
            activeMenuItem.classList.add('bg-indigo-600', 'text-white');
        }
    }
    </script>
</body>
</html>
