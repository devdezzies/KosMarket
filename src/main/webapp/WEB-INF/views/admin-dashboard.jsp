<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Dashboard Overview</h2>
    
    <!-- Statistics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-indigo-100 p-6 rounded-2xl">
            <div class="flex items-center">
                <div class="p-3 bg-blue-100 rounded-full">
                    <i class="fas fa-users text-blue-600 text-xl"></i>
                </div>
                <div class="ml-4">
                    <p class="text-sm text-gray-600">Total Members</p>
                    <p class="text-2xl font-bold text-gray-800">${totalMembers}</p>
                </div>
            </div>
        </div>

        <div class="bg-indigo-100 p-6 rounded-2xl">
            <div class="flex items-center">
                <div class="p-3 bg-green-100 rounded-full">
                    <i class="fas fa-shopping-cart text-green-600 text-xl"></i>
                </div>
                <div class="ml-4">
                    <p class="text-sm text-gray-600">Total Products</p>
                    <p class="text-2xl font-bold text-gray-800">${totalProducts}</p>
                </div>
            </div>
        </div>

        <div class="bg-indigo-100 p-6 rounded-2xl">
            <div class="flex items-center">
                <div class="p-3 bg-purple-100 rounded-full">
                    <i class="fas fa-tags text-purple-600 text-xl"></i>
                </div>
                <div class="ml-4">
                    <p class="text-sm text-gray-600">Total Categories</p>
                    <p class="text-2xl font-bold text-gray-800">${totalCategories}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="bg-indigo-100 p-6 rounded-2xl">
        <h3 class="text-lg font-semibold text-gray-800 mb-4">Quick Actions</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button onclick="selectMenu(document.querySelector('.menu-item'), 'users')" class="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition text-center">
                <i class="fas fa-users text-blue-600 text-2xl mb-2"></i>
                <p class="font-medium">Manage Users</p>
                <p class="text-sm text-gray-600">View and manage members</p>
            </button>
            
            <button onclick="selectMenu(document.querySelector('.menu-item'), 'categories')" class="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition text-center">
                <i class="fas fa-tags text-purple-600 text-2xl mb-2"></i>
                <p class="font-medium">Manage Categories</p>
                <p class="text-sm text-gray-600">Add, edit, or remove categories</p>
            </button>
            
            <button onclick="selectMenu(document.querySelector('.menu-item'), 'products')" class="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition text-center">
                <i class="fas fa-shopping-cart text-green-600 text-2xl mb-2"></i>
                <p class="font-medium">Manage Products</p>
                <p class="text-sm text-gray-600">View and manage products</p>
            </button>
        </div>
    </div>
</div>
</html>