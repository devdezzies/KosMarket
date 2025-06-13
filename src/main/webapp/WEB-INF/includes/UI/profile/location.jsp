<%-- Created by IntelliJ IDEA. User: mrfer Date: 07/06/2025 Time: 15:55 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <%
            String error = request.getParameter("error");
            if ("phone".equals(error)) {
        %>
            <div class="mb-4 p-4 bg-red-100 text-red-800 rounded">
                Format nomor telepon tidak valid! Harus dimulai dengan 62 dan diikuti angka.
            </div>
        <%
            }
        %>
        
        <% String success = request.getParameter("success"); 
            if ("1".equals(success)) { 
        %>
            <div class="mb-4 p-4 bg-green-100 text-green-800 rounded">
                Lokasi berhasil diperbarui!
            </div>
        <% 
            } 
        %>
                <h1 class="text-2xl font-bold text-gray-900 mb-8">Alamat & Lokasi</h1>

                <!-- Location Form -->
                <form class="space-y-6" action="${pageContext.request.contextPath}/profile/me?page=location"
                    method="POST">

                    <!-- Phone Number -->
                    <div class="relative">
                        <label for="phone" class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
                        
                        <span class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-500 text-sm">+62</span>

                        <input type="tel" id="phone" name="phone"
                            value="${phone != null && phone.startsWith('62') ? phone.substring(2) : ''}" 
                            class="w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            pattern="^[0-9]{8,}$" minlength="8" maxlength="13"
                            placeholder="81234567890" required>
                        
                        <small class="text-gray-500">Nomor tanpa 0 di awal. Contoh: 81234567890</small>
                    </div>

                    <!-- City -->
                    <div>
                        <label for="city" class="block text-sm font-medium text-gray-700 mb-2">Kota</label>
                        <input type="text" id="city" name="city" value="${city}"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            required>
                    </div>

                    <!-- Street -->
                    <div>
                        <label for="street" class="block text-sm font-medium text-gray-700 mb-2">Alamat</label>
                        <input type="text" id="street" name="street" value="${street}"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            required>
                    </div>

                    <!-- Nomor Rumah -->
                    <div>
                        <label for="number" class="block text-sm font-medium text-gray-700 mb-2">Nomor Rumah</label>
                        <input type="text" id="number" name="number" value="${number}"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            required>
                    </div>

                    <!-- Postal Code -->
                    <div>
                        <label for="zipcode" class="block text-sm font-medium text-gray-700 mb-2">Kode Pos</label>
                        <input type="text" id="zipcode" name="zipcode" value="${zipCode}"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            required>
                    </div>

                    <!-- Submit Button -->
                    <div class="flex justify-end">
                        <button type="submit"
                            class="px-6 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
                            Submit
                        </button>
                    </div>
                </form>
                </div>