<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="java.util.ArrayList" %>

<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Product Management</h2>

    <!-- Search Section -->
    <div class="bg-white mb-4">
        <div class="p-4">
            <div class="flex items-center justify-between mb-3">
                <h3 class="text-lg font-semibold text-gray-800"><i class="fas fa-search mr-2"></i>Search the Product</h3>
                <button onclick="clearSearch()" id="clear-search-btn" class="hidden px-3 py-1 text-sm text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-2xl transition">
                    <i class="fas fa-times mr-1"></i>Clear Search
                </button>
            </div>
            <form onsubmit="searchProduct(event)" class="flex items-center space-x-3">
                <div class="relative flex-1">
                    <input type="text" id="product-search-query" name="searchQuery" placeholder="Search by ID, name, or category" 
                           class="w-full px-4 py-2 pr-12 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                <button type="submit" class="px-8 py-2 bg-indigo-600 text-white rounded-2xl hover:bg-indigo-700 border-indigo-600 transition-all duration-200 flex items-center justify-center min-w-[100px]">
                    <i class="fas fa-search mr-2"></i>
                    <span>Search</span>
                </button>
            </form>
        </div>
    </div>

    <!-- Search Results Info (Hidden by default) -->
    <div id="search-info" class="hidden mb-4 p-3 bg-blue-50 border border-blue-200 rounded-2xl">
        <div class="flex items-center text-blue-700">
            <i class="fas fa-info-circle mr-2"></i>
            <span class="text-sm">
                Search results for: "<span id="search-term-display"></span>" 
                (<span id="search-type-display"></span>) - Found: <span id="search-count">0</span> product(s)
            </span>
        </div>
    </div>

    <!-- Products List -->
    <div class="bg-white" id="products-list">
        <div class="p-4">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-semibold text-gray-800" id="products-title">
                    <i class="fas fa-box mr-2"></i>Product List
                </h3>
                <!-- Display total products count -->
                <div class="text-sm text-gray-600">
                    <span class="font-medium">Total Products : </span>
                    <span class="text-indigo-600 font-semibold">
                        <%
                            ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
                            out.print(products != null ? products.size() : 0);
                        %>
                    </span>
                </div>
            </div>

            <!-- Product Cards -->
            <div id="product-cards" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
                <%
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                            String img = product.getImageUrl();
                            String name = product.getName();
                            String category = product.getCategory().getName(); // Pastikan getter sesuai model
                            String price = String.format("%.2f", product.getPrice());
                %>
                <div class="bg-indigo-50 rounded-2xl shadow-md flex flex-col items-center p-8 transition hover:shadow-lg product-card cursor-pointer"
                    data-product-id="<%= product.getId() %>"
                    onclick="showProductDetailModal('<%= product.getId() %>', '<%= escapeJs(name) %>', '<%= escapeJs(category) %>', '<%= price %>')">
                    <!-- Product Image or Icon -->
                    <div class="w-72 h-72 bg-white rounded-xl flex items-center justify-center mb-4 overflow-hidden">
                        <%
                            if (img != null && !img.trim().isEmpty()) {
                        %>
                            <img src="<%= img %>" alt="<%= name %>" class="w-full h-full object-cover rounded-2xl">
                        <%
                            } else {
                        %>
                            <i class="fas fa-cube text-gray-400 text-4xl"></i>
                        <%
                            }
                        %>
                    </div>
                    <!-- Product Info -->
                    <div class="w-full text-left mt-2 product-info">
                        <div class="font-semibold text-gray-900 text-lg truncate"><%= name %></div>
                        <div class="text-sm text-gray-500 mt-1">ID : <%= product.getId() %></div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="col-span-full text-center py-8">
                    <i class="fas fa-box text-gray-400 text-4xl mb-3"></i>
                    <h4 class="text-lg font-semibold text-gray-700 mb-2">No Products Found</h4>
                    <p class="text-gray-500">No products are registered in the system.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<!-- Product Detail Modal -->
<div id="product-detail-modal" class="hidden fixed inset-0 bg-gray-200 bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-3xl p-6 w-full max-w-md mx-4 shadow-2xl">
        <div class="text-center">
            <div id="product-detail-content">

            </div>
            
            <div id="modal-buttons" class="flex justify-center space-x-3 mt-6">

            </div>

            <button onclick="hideProductDetailModal()" 
                    class="mt-4 w-full px-6 py-2 bg-gray-300 text-gray-700 rounded-2xl hover:bg-gray-400 transition font-medium">
                Close
            </button>
        </div>
    </div>
</div>

<%! 
    public static String escapeJs(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
%>

<script>
let currentProductId = null;
let currentProductName = null;
let searchResultIds = [];

document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('product-detail-modal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                hideProductDetailModal();
            }
        });
    }
});

function searchProduct(event) {
    event.preventDefault();

    const searchInput = document.getElementById('product-search-query');
    const searchQuery = searchInput.value.trim();
    
    if (searchQuery === '') {
        clearSearch();
        return;
    }

    fetch('${pageContext.request.contextPath}/admin?action=searchProduct&searchQuery=' + encodeURIComponent(searchQuery))
        .then(response => {
            return response.text();
        })
        .then(responseText => {
            const searchData = parseSearchResponse(responseText);
            
            if (searchData.success && searchData.ids.length > 0) {
                searchResultIds = searchData.ids;
                displaySearchResults(searchQuery, searchData.ids, searchData.searchType);
            } else {
                searchResultIds = [];
                displayNoResults(searchQuery, searchData.searchType || 'Unknown');
            }
        })
        .catch(error => {
            alert('Error occurred during search: ' + error.message);
        });
}

function parseSearchResponse(responseText) {
    try {
        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = responseText;
        
        const dataElement = tempDiv.querySelector('[data-search-result-ids]');
        
        if (dataElement) {
            const idsString = dataElement.getAttribute('data-search-result-ids');
            const searchType = dataElement.getAttribute('data-search-type');
            const searchTerm = dataElement.getAttribute('data-search-term');
            const searchSuccess = dataElement.getAttribute('data-search-success') === 'true';
        
            let ids = [];
            if (idsString && idsString.trim() !== '') {
                ids = idsString.split(',')
                    .map(id => parseInt(id.trim()))
                    .filter(id => !isNaN(id));
            }
            
            return {
                success: searchSuccess && ids.length > 0,
                ids: ids,
                searchType: searchType || 'Unknown',
                searchTerm: searchTerm || ''
            };
        } else {
            return {
                success: false,
                ids: [],
                searchType: 'Error',
                searchTerm: ''
            };
        }
    } catch (e) {
        return {
            success: false,
            ids: [],
            searchType: 'Error',
            searchTerm: ''
        };
    }
}

function displaySearchResults(searchTerm, resultIds, searchType) {
    const searchInfo = document.getElementById('search-info');
    document.getElementById('search-term-display').textContent = searchTerm;
    document.getElementById('search-type-display').textContent = searchType;
    document.getElementById('search-count').textContent = resultIds.length;
    searchInfo.classList.remove('hidden');
    
    const title = document.getElementById('products-title');
    title.innerHTML = `<i class="fas fa-box mr-2"></i>Search Results`;

    const allCards = document.querySelectorAll('.product-card');
    
    // Hide all cards
    allCards.forEach(card => {
        card.style.display = 'none';
        // Reset card style
        card.classList.remove('bg-yellow-100', 'border-2', 'border-yellow-300');
        card.classList.add('bg-indigo-50');
        // Hapus badge search sebelumnya
        const badge = card.querySelector('.search-result-badge');
        if (badge) badge.remove();
    });

    // Show matching cards
    resultIds.forEach(id => {
        allCards.forEach(card => {
            if (card.getAttribute('data-product-id') === String(id)) {
                card.style.display = 'flex'; // Pastikan flex agar layout tetap
                // Tambahkan badge kecil di bawah ID, rata kiri
                const productInfoContainer = card.querySelector('.product-info');
                if (productInfoContainer && !productInfoContainer.querySelector('.search-result-badge')) {
                    const badge = document.createElement('div');
                    badge.className = 'search-result-badge';
                    badge.innerHTML = `
                        <span class="inline-block mt-2 px-2 py-1 bg-yellow-200 text-yellow-800 text-xs rounded-full">
                            <i class="fas fa-search mr-1"></i>Search Result
                        </span>
                    `;
                    // Tempel badge di bawah info produk
                    productInfoContainer.appendChild(badge);
                }
            }
        });
    });
    
    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
}

function displayNoResults(searchTerm, searchType) {
    // Hide all cards
    const allCards = document.querySelectorAll('.product-card');
    allCards.forEach(card => {
        card.style.display = 'none';
    });
    
    // Show search info with 0 results
    const searchInfo = document.getElementById('search-info');
    document.getElementById('search-term-display').textContent = searchTerm;
    document.getElementById('search-type-display').textContent = searchType;
    document.getElementById('search-count').textContent = '0';
    searchInfo.classList.remove('hidden');
    
    // Update title
    const title = document.getElementById('products-title');
    title.innerHTML = `<i class="fas fa-box mr-2"></i>No Results Found`;

    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
    
    // Add no results message
    const productCards = document.getElementById('product-cards');
    const existingNoResults = productCards.querySelector('.no-results-message');
    if (!existingNoResults) {
        const noResultsDiv = document.createElement('div');
        noResultsDiv.className = 'no-results-message text-center py-8';
        noResultsDiv.innerHTML = `
            <i class="fas fa-search text-yellow-400 text-4xl mb-3"></i>
            <h4 class="text-lg font-semibold text-yellow-600 mb-2">No Products Found</h4>
            <p class="text-yellow-500">No products match your search criteria</p>
        `;
        productCards.appendChild(noResultsDiv);
    }
}

function clearSearch() {
    // Clear search input
    document.getElementById('product-search-query').value = '';
    
    // Hide search info
    document.getElementById('search-info').classList.add('hidden');
    
    // Reset title
    const title = document.getElementById('products-title');
    title.innerHTML = `<i class="fas fa-box mr-2"></i>Product List`;
    
    // Show all cards and reset styling
    const allCards = document.querySelectorAll('.product-card');
    allCards.forEach(card => {
        card.style.display = 'block';
        card.classList.remove('bg-yellow-100', 'border-2', 'border-yellow-300');
        card.classList.add('bg-indigo-100');
        
        // Remove search badges
        const badge = card.querySelector('.search-result-badge');
        if (badge) {
            badge.remove();
        }
        
        // Remove search icons
        const icon = card.querySelector('.search-result-icon');
        if (icon) {
            icon.remove();
        }
    });
    
    // Remove no results message
    const noResultsMsg = document.querySelector('.no-results-message');
    if (noResultsMsg) {
        noResultsMsg.remove();
    }
    
    // Hide clear search button
    document.getElementById('clear-search-btn').classList.add('hidden');
    
    // Clear search result IDs
    searchResultIds = [];
}

function showProductDetailModal(productId, productName, productCategory, productPrice) {
    currentProductId = productId;
    currentProductName = productName;
    
    document.getElementById('product-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">' + 
        productName + 
        '</h3>' +
        '<p class="text-sm text-gray-600 mb-4">ID : ' + productId + '</p>' +
        '<div class="text-left space-y-2">' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Name :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + productName + '</span>' +
            '</div>' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Category :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + productCategory + '</span>' +
            '</div>' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Price :</span>' +
                '<span class="text-gray-800 text-sm font-medium">$' + productPrice + '</span>' +
            '</div>' +
        '</div>';
    
    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="deleteProductFromModal()" ' +
        'class="w-full px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">' +
            '<i class="fas fa-trash mr-2"></i>Delete Product' +
        '</button>';
    
    document.getElementById('product-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function deleteProduct(productId, productName) {
    if (confirm(`Are you sure you want to delete product "${productName}"?`)) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'deleteProduct';
        form.appendChild(actionInput);
        
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = productId;
        form.appendChild(idInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

function deleteProductFromModal() {
    if (currentProductId && currentProductName) {
        deleteProduct(currentProductId, currentProductName);
        hideProductDetailModal();
    }
}

function hideProductDetailModal() {
    document.getElementById('product-detail-modal').classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
    currentProductId = null;
    currentProductName = null;
}
</script>
