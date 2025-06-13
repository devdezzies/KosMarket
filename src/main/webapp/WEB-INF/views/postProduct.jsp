<%@ page import="com.kosmarket.models.ProductCategory" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/layout/layout_header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Product - KosMarket</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        'primary-dark': '#2563EB',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">



<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="lg:grid lg:grid-cols-12 lg:gap-8">

        <!-- Main Form Section -->
        <div class="lg:col-span-8">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">

                <!-- Form Header -->
                <div class="bg-gradient-to-r from-primary to-primary-dark px-6 py-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                        </div>
                        <div class="ml-3">
                            <h2 class="text-lg font-semibold text-white">Add New Product</h2>
                            <p class="text-blue-100 text-sm">Fill in the details below to list your product</p>
                        </div>
                    </div>
                </div>

                <!-- Messages -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="mx-6 mt-4">
                    <div class="bg-red-50 border-l-4 border-red-400 p-4">
                        <div class="flex">
                            <svg class="h-5 w-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                            </svg>
                            <div class="ml-3">
                                <p class="text-sm text-red-700"><%= request.getAttribute("errorMessage") %></p>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>

                <% if (request.getParameter("success") != null) { %>
                <div class="mx-6 mt-4">
                    <div class="bg-green-50 border-l-4 border-green-400 p-4">
                        <div class="flex">
                            <svg class="h-5 w-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <div class="ml-3">
                                <p class="text-sm text-green-700">Product added successfully!</p>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>

                <!-- Form Content -->
                <form action="product" method="post" enctype="multipart/form-data" class="p-6 space-y-6">
                    <input type="hidden" name="menu" value="add_product" >

                    <!-- Basic Information Section -->
                    <div class="space-y-6">
                        <div class="border-b border-gray-200 pb-4">
                            <h3 class="text-lg font-medium text-gray-900">Basic Information</h3>
                            <p class="text-sm text-gray-500">Provide essential details about your product</p>
                        </div>

                        <!-- Product Name -->
                        <div>
                            <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                                Product Name <span class="text-red-500">*</span>
                            </label>
                            <input type="text" id="name" name="name" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                                   placeholder="e.g., iPhone 13 Pro Max 256GB">
                            <p class="text-xs text-gray-500 mt-1">Use a clear, descriptive name that buyers will search for</p>
                        </div>

                        <!-- Price and Category Row -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Price -->
                            <div>
                                <label for="price" class="block text-sm font-medium text-gray-700 mb-2">
                                    Price (Rp) <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <span class="absolute left-3 top-3 text-gray-500 text-sm">Rp</span>
                                    <input type="number" id="price" name="price" min="0" step="100" required
                                           class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                                           placeholder="0">
                                </div>
                            </div>

                            <!-- Category -->
                            <div>
                                <label for="categoryId" class="block text-sm font-medium text-gray-700 mb-2">Category</label>
                                <%
                                    List<ProductCategory> categories =
                                            (List<com.kosmarket.models.ProductCategory>) request.getAttribute("categories");
                                %>

                                <select name="categoryId" class="border p-2 w-full">
                                    <%
                                        for (com.kosmarket.models.ProductCategory cat : categories) {
                                    %>
                                    <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                                    <%
                                        }
                                    %>
                                </select>

                            </div>
                        </div>
                    </div>

                    <!-- Product Details Section -->
                    <div class="space-y-6">
                        <div class="border-b border-gray-200 pb-4">
                            <h3 class="text-lg font-medium text-gray-900">Product Details</h3>
                            <p class="text-sm text-gray-500">Add more information to help buyers understand your product</p>
                        </div>

                        <!-- Description -->
                        <div>
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                            <textarea id="description" name="description" rows="4"
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent resize-none transition-all duration-200"
                                      placeholder="Describe your product features, condition, and any important details..."></textarea>
                            <div class="flex justify-between mt-1">
                                <p class="text-xs text-gray-500">Be detailed and honest about your product</p>
                                <span class="text-xs text-gray-400" id="char-count">0/500</span>
                            </div>
                        </div>

                        <!-- Quantity and Location Row -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Item Count -->
                            <div>
                                <label for="itemCount" class="block text-sm font-medium text-gray-700 mb-2">
                                    Quantity <span class="text-red-500">*</span>
                                </label>
                                <input type="number" id="itemCount" name="itemCount" min="1" value="1" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200">
                            </div>

                            <!-- Location -->
                            <div>
                                <label for="location" class="block text-sm font-medium text-gray-700 mb-2">Location</label>
                                <input type="text" id="location" name="location"
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all duration-200"
                                       placeholder="e.g., Jakarta Selatan">
                            </div>
                        </div>
                    </div>

                    <!-- Media Section -->
                    <div class="space-y-6">
                        <div class="border-b border-gray-200 pb-4">
                            <h3 class="text-lg font-medium text-gray-900">Product Images</h3>
                            <p class="text-sm text-gray-500">Add high-quality images to showcase your product</p>
                        </div>

                        <!-- Image URL -->
                        <div
                                id="drop-area"
                                class="flex flex-col items-center justify-center w-full border-2 border-dashed border-gray-300 rounded-xl p-6 cursor-pointer transition hover:border-blue-400"
                        >
                            <input type="file" name="image" id="fileElem" accept="image/*" hidden>
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-gray-400 mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 15a4 4 0 01.88-2.47m0 0A4 4 0 018 10h8a4 4 0 014 4v1m-1 4H5a2 2 0 01-2-2v-1a2 2 0 012-2h14a2 2 0 012 2v1a2 2 0 01-2 2z" />
                            </svg>
                            <p class="text-gray-500 text-sm">Drag & drop image here, or click to select</p>
                            <button type="button" id="fileSelect" class="mt-2 px-3 py-1.5 bg-blue-500 text-white text-sm rounded-md hover:bg-blue-600">Select Image</button>
                            <div id="preview" class="mt-4"></div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-col sm:flex-row gap-4 pt-6 border-t border-gray-200">
                        <button type="submit"
                                class="flex-1 bg-primary text-white py-3 px-6 rounded-lg hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2 transition-all duration-200 font-medium">
                            <span class="flex items-center justify-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                </svg>
                                Add Product
                            </span>
                        </button>
                        <a href="product"
                           class="flex-1 bg-gray-100 text-gray-700 py-3 px-6 rounded-lg hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-200 text-center font-medium">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Guidelines Sidebar -->
        <div class="lg:col-span-4 mt-8 lg:mt-0">
            <div class="space-y-6">

                <!-- Quick Tips -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <svg class="h-6 w-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                            </svg>
                        </div>
                        <h3 class="ml-3 text-lg font-semibold text-gray-900">Quick Tips</h3>
                    </div>
                    <div class="space-y-4">
                        <div class="flex items-start">
                            <div class="flex-shrink-0 h-2 w-2 bg-green-400 rounded-full mt-2"></div>
                            <p class="ml-3 text-sm text-gray-600">Use clear, high-quality images</p>
                        </div>
                        <div class="flex items-start">
                            <div class="flex-shrink-0 h-2 w-2 bg-green-400 rounded-full mt-2"></div>
                            <p class="ml-3 text-sm text-gray-600">Write detailed, honest descriptions</p>
                        </div>
                        <div class="flex items-start">
                            <div class="flex-shrink-0 h-2 w-2 bg-green-400 rounded-full mt-2"></div>
                            <p class="ml-3 text-sm text-gray-600">Set competitive prices</p>
                        </div>
                        <div class="flex items-start">
                            <div class="flex-shrink-0 h-2 w-2 bg-green-400 rounded-full mt-2"></div>
                            <p class="ml-3 text-sm text-gray-600">Choose the right category</p>
                        </div>
                    </div>
                </div>

                <!-- Guidelines -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <svg class="h-6 w-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="ml-3 text-lg font-semibold text-gray-900">Product Guidelines</h3>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <h4 class="font-medium text-gray-900 text-sm">Product Name</h4>
                            <p class="text-xs text-gray-600 mt-1">Include brand, model, key features. Keep it under 80 characters.</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900 text-sm">Pricing</h4>
                            <p class="text-xs text-gray-600 mt-1">Research market prices. Be competitive but fair.</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900 text-sm">Description</h4>
                            <p class="text-xs text-gray-600 mt-1">Include condition, features, dimensions, and any defects.</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900 text-sm">Images</h4>
                            <p class="text-xs text-gray-600 mt-1">Use bright, clear photos from multiple angles.</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    // Character counter for description

    const descriptionField = document.getElementById('description');
    const charCount = document.getElementById('char-count');
    const dropArea = document.getElementById("drop-area");
    const fileInput = document.getElementById("fileElem");
    const fileSelect = document.getElementById("fileSelect");
    const preview = document.getElementById("preview");

    // Trigger input file
    fileSelect.addEventListener("click", () => fileInput.click());

    // Handle manual selection
    fileInput.addEventListener("change", handleFiles);

    // Drag events
    ["dragenter", "dragover"].forEach(eventName => {
        dropArea.addEventListener(eventName, e => {
            e.preventDefault();
            dropArea.classList.add("border-blue-400", "bg-blue-50");
        });
    });

    ["dragleave", "drop"].forEach(eventName => {
        dropArea.addEventListener(eventName, e => {
            e.preventDefault();
            dropArea.classList.remove("border-blue-400", "bg-blue-50");
        });
    });

    // Drop files
    dropArea.addEventListener("drop", e => {
        const dt = e.dataTransfer;
        const files = dt.files;
        fileInput.files = files;
        handleFiles({ target: { files } });
    });

    function handleFiles(e) {
        const files = e.target.files;
        preview.innerHTML = "";
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const img = document.createElement("img");
            img.src = URL.createObjectURL(file);
            img.className = "mt-2 w-24 h-24 object-cover rounded-lg shadow";
            preview.appendChild(img);
        }
    }
    descriptionField.addEventListener('input', function() {
        const length = this.value.length;
        charCount.textContent = `${length}/500`;

        if (length > 500) {
            charCount.classList.add('text-red-500');
            charCount.classList.remove('text-gray-400');
        } else {
            charCount.classList.add('text-gray-400');
            charCount.classList.remove('text-red-500');
        }
    });

    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const name = document.getElementById('name').value.trim();
        const price = document.getElementById('price').value.trim();
        const itemCount = document.getElementById('itemCount').value.trim();

        if (!name) {
            alert('Product name is required!');
            e.preventDefault();
            return;
        }

        if (!price || parseFloat(price) <= 0) {
            alert('Valid price is required!');
            e.preventDefault();
            return;
        }

        if (!itemCount || parseInt(itemCount) <= 0) {
            alert('Valid quantity is required!');
            e.preventDefault();
            return;
        }
    });

    // Price formatting
    const priceInput = document.getElementById('price');
    priceInput.addEventListener('input', function() {
        let value = this.value.replace(/[^\d]/g, '');
        this.value = value;
    });
</script>

</body>
</html>