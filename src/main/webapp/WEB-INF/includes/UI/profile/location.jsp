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
    <h1 class="text-2xl font-bold text-gray-900 mb-8">Alamat & Lokasi</h1>

    <!-- Location Form -->
    <form class="space-y-6">

        <!-- Home Number -->
        <div>
            <label for="home_number" class="block text-sm font-medium text-gray-700 mb-2">Nomor Rumah</label>
            <input type="number"
                   id="home_number"
                   name="home_number"
                   value="+62 896 9365 8270"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>

        <!-- City -->
        <div>
            <label for="city" class="block text-sm font-medium text-gray-700 mb-2">Kota</label>
            <input type="text"
                   id="city"
                   name="city"
                   value="walter.white@breakingbad.com"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>

        <!-- Street -->
        <div>
            <label for="street" class="block text-sm font-medium text-gray-700 mb-2">Alamat</label>
            <input type="text"
                   id="street"
                   name="street"
                   value="Jl. Telkomunikasi No. 123"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>

        <!-- Postal Code -->
        <div>
            <label for="zipcode" class="block text-sm font-medium text-gray-700 mb-2">Kode Pos</label>
            <input type="text"
                   id="zipcode"
                   name="zipcode"
                   value="78123"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
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
</head>
<body>

</body>
</html>
