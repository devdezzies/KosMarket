<%-- Created by IntelliJ IDEA. User: mrfer Date: 07/06/2025 Time: 15:55 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <% 
            String success=request.getParameter("success"); 
            if ("1".equals(success)) { 
        %>
            <div class="mb-4 p-4 bg-green-100 text-green-800 rounded">
                Profil berhasil diperbarui!
            </div>
        <% 
            } 
        %>

        <%
            String error = request.getParameter("error");
            if (error != null) {
                String errorMsg = "";
                if ("email_exists".equals(error)) {
                    errorMsg = "Email sudah digunakan oleh akun lain.";
                } else {
                    errorMsg = "Terjadi kesalahan saat memperbarui profil.";
                }
        %>
            <div class="mb-4 p-4 bg-red-100 text-red-800 rounded">
                <%= errorMsg %>
            </div>
        <%
            }
        %>

                <h1 class="text-2xl font-bold text-gray-900 mb-8">Edit Profil</h1>
                <div class="flex items-center mb-8">
                    <div class="relative">
                        <div
                            class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center overflow-hidden">
                            <img src="${profilePicture}" alt="Profile Picture"
                                class="w-full h-full object-cover rounded-full" />
                        </div>
                    </div>
                    <div class="ml-6">
                        <h2 class="text-lg font-semibold text-gray-900">${firstName} ${lastName}</h2>
                        <p class="text-sm text-gray-600">${email}</p>
                        <p class="text-sm text-gray-600">${username}</p>
                    </div>
                </div>

                <!-- Profile Form -->
                <form class="space-y-6" action="${pageContext.request.contextPath}/profile/me?page=me" method="POST">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- First Name -->
                        <div>
                            <label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">Nama
                                Awal</label>
                            <input type="text" id="firstName" name="firstName" value="${firstName}"
                                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                required>
                        </div>

                        <!-- Last Name -->
                        <div>
                            <label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">Nama
                                Akhir</label>
                            <input type="text" id="lastName" name="lastName" value="${lastName}"
                                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="email" name="email" value="${email}"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            required>
                    </div>

                    <!-- Submit Button -->
                    <div class="flex justify-end">
                        <button type="submit"
                            class="px-6 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
                            Kirim
                        </button>
                    </div>
                </form>