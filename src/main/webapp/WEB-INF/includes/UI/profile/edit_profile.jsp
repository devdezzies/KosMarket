<%--
  Created by IntelliJ IDEA.
  User: mrfer
  Date: 07/06/2025
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <h1 class="text-2xl font-bold text-gray-900 mb-8">Edit Profil</h1>
    <div class="flex items-center mb-8">
        <div class="relative">
            <div class="w-20 h-20 bg-purple-200 rounded-full flex items-center justify-center">
                <span class="text-2xl font-bold text-purple-600">W</span>
            </div>
            <button class="absolute bottom-0 right-0 w-6 h-6 bg-gray-600 rounded-full flex items-center justify-center">
                <svg class="w-3 h-3 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path>
                </svg>
            </button>
        </div>
        <div class="ml-6">
            <h2 class="text-lg font-semibold text-gray-900">Walter White</h2>
            <p class="text-sm text-gray-600">walter.white@breakingbad.com</p>
        </div>
    </div>

    <!-- Profile Form -->
    <form class="space-y-6" action="/home" method="POST">>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- First Name -->
            <div>
                <label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">Nama Awal</label>
                <input type="text"
                       id="firstName"
                       name="firstName"
                       value="Walter"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <!-- Last Name -->
            <div>
                <label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">Nama Akhir</label>
                <input type="text"
                       id="lastName"
                       name="lastName"
                       value="White"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
        </div>

        <!-- Email -->
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
            <input type="email"
                   id="email"
                   name="email"
                   value="walter.white@breakingbad.com"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>

        <!-- Phone Number -->
        <div>
            <label for="phone" class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
            <input type="tel"
                   id="phone"
                   name="phone"
                   value="+62 896 9365 8270"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>

        <!-- Submit Button -->
        <div class="flex justify-end">
            <button type="submit"
                    class="px-6 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
                Kirim
            </button>
        </div>
    </form>
    </div>
</head>
<body>

</body>
</html>
