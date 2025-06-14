<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.kosmarket.models.ProductCategory" %>
<%@ page import="java.util.ArrayList" %>

<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Category Management</h2>

    <!-- Search Section -->
    <div class="bg-white mb-4">
        <div class="p-4">
            <div class="flex items-center justify-between mb-3">
                <h3 class="text-lg font-semibold text-gray-800"><i class="fas fa-search mr-2"></i>Search the Category</h3>
                <button onclick="clearSearch()" id="clear-search-btn" class="hidden px-3 py-1 text-sm text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-2xl transition">
                    <i class="fas fa-times mr-1"></i>Clear Search
                </button>
            </div>
            <form onsubmit="searchCategory(event)" class="flex items-center space-x-3">
                <div class="relative flex-1">
                    <input type="text" id="category-search-query" name="searchQuery" placeholder="Search by ID or Name" 
                           class="w-full px-4 py-2 pr-12 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                <button type="submit" class="px-8 py-2 bg-indigo-600 text-white rounded-2xl hover:bg-indigo-700 border-indigo-600 transition-all duration-200 flex items-center justify-center min-w-[100px]">
                    <i class="fas fa-search mr-2"></i>
                    <span>Search</span>
                </button>
                <!-- Add Category Button -->
                <button onclick="showAddCategoryModal()" 
                        class="px-4 py-2 bg-green-600 text-white rounded-2xl border-green-600 hover:bg-green-700 transition font-medium">
                    <i class="fas fa-plus mr-2"></i>Add Category
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
                (<span id="search-type-display"></span>) - Found: <span id="search-count">0</span> category(s)
            </span>
        </div>
    </div>

    <!-- Categories List -->
    <div class="bg-white" id="categories-list">
        <div class="p-4">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-semibold text-gray-800" id="categories-title">
                    <i class="fas fa-tags mr-2"></i>Active Categories
                </h3>
                <!-- Display total categories count -->
                <div class="text-sm text-gray-600">
                    <span class="font-medium">Total Categories : </span>
                    <span class="text-indigo-600 font-semibold">
                        <%
                            ArrayList<ProductCategory> categories = (ArrayList<ProductCategory>) request.getAttribute("categories");
                            out.print(categories != null ? categories.size() : 0);
                        %>
                    </span>
                </div>
            </div>

            <!-- Category Cards -->
            <div id="category-cards" class="space-y-3">
                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (ProductCategory category : categories) {
                %>
                <div class="bg-indigo-100 rounded-2xl p-4 category-card" 
                     data-category-id="<%= category.getId() %>"
                     data-search="<%= category.getId() %> <%= category.getName() %> <%= category.getDescription() %>">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <!-- Category Avatar -->
                            <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center">
                                <i class="fas fa-tag text-gray-600 text-lg"></i>
                            </div>
                            
                            <!-- Category Info -->
                            <div class="category-info">
                                <h3 class="font-semibold text-gray-800">
                                    <%= category.getName() %>
                                </h3>
                                <p class="text-sm text-gray-600">ID: <%= category.getId() %></p>
                                <p class="text-sm text-gray-600"><%= category.getDescription() %></p>
                            </div>
                        </div>
                    </div>
                    <!-- Action Buttons -->
                    <div class="flex justify-end space-x-2 p-1 mt-3">
                        <button onclick="showCategoryDetailModal('<%= category.getId() %>', '<%= category.getName() %>', '<%= category.getDescription() %>')" 
                                class="px-3 py-2 bg-indigo-600 text-white text-sm rounded-2xl hover:bg-indigo-700 transition">
                            <i class="fas fa-eye mr-1"></i>View
                        </button>
                        <button onclick="editCategoryDetailModal('<%= category.getId() %>', '<%= category.getName() %>', '<%= category.getDescription() %>')" 
                                class="px-3 py-2 bg-yellow-500 text-white text-sm rounded-2xl hover:bg-yellow-600 transition">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </button>
                        <button onclick="deleteCategory('<%= category.getId() %>', '<%= category.getName() %>')" 
                                class="px-3 py-2 bg-red-600 text-white text-sm rounded-2xl hover:bg-red-700 transition">
                            <i class="fas fa-trash mr-1"></i>Delete
                        </button>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="text-center py-8">
                    <i class="fas fa-tags text-gray-400 text-4xl mb-3"></i>
                    <h4 class="text-lg font-semibold text-gray-700 mb-2">No Categories Found</h4>
                    <p class="text-gray-500">No categories are registered in the system.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<!-- Category Detail Modal -->
<div id="category-detail-modal" class="hidden fixed inset-0 bg-gray-200 bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-3xl p-6 w-full max-w-md mx-4 shadow-2xl">
        <div class="text-center">
            <div id="category-detail-content">
                
            </div>
            
            <div id="modal-buttons" class="flex justify-center space-x-3 mt-6">
                
            </div>
            
            <button onclick="hideCategoryDetailModal()" 
                    class="mt-4 w-full px-6 py-2 bg-gray-300 text-gray-700 rounded-2xl hover:bg-gray-400 transition font-medium">
                Close
            </button>
        </div>
    </div>
</div>

<script>
let currentCategoryId = null;
let currentCategoryName = null;
let isEditMode = false;
let searchResultIds = [];

document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('category-detail-modal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                hideCategoryDetailModal();
            }
        });
    }
});

function searchCategory(event) {
    event.preventDefault();
    
    const searchInput = document.getElementById('category-search-query');
    const searchQuery = searchInput.value.trim();
    
    if (searchQuery === '') {
        clearSearch();
        return;
    }
    
    fetch('${pageContext.request.contextPath}/admin?action=searchCategory&searchQuery=' + encodeURIComponent(searchQuery))
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
    
    const title = document.getElementById('categories-title');
    title.innerHTML = `<i class="fas fa-search mr-2"></i>Search Results`;
    
    const allCards = document.querySelectorAll('.category-card');
    
    // Hide all cards
    allCards.forEach(card => {
        card.style.display = 'none';
        card.classList.remove('bg-yellow-100', 'border-2', 'border-yellow-300');
        card.classList.add('bg-indigo-100');
        const badge = card.querySelector('.search-result-badge');
        if (badge) badge.remove();
        const icon = card.querySelector('.search-result-icon');
        if (icon) icon.remove();
    });

    // Show matching cards
    resultIds.forEach(id => {
        allCards.forEach(card => {
            if (card.getAttribute('data-category-id') === String(id)) {
                card.style.display = 'block';
                card.classList.remove('bg-indigo-100');
                card.classList.add('bg-yellow-100', 'border-2', 'border-yellow-300');
                const categoryInfoContainer = card.querySelector('.category-info');
                if (categoryInfoContainer && !categoryInfoContainer.querySelector('.search-result-badge')) {
                    const badge = document.createElement('div');
                    badge.className = 'mt-1 search-result-badge';
                    badge.innerHTML = `
                        <span class="inline-block px-2 py-1 bg-yellow-200 text-yellow-800 text-xs rounded-full">
                            <i class="fas fa-search mr-1"></i>Search Result
                        </span>
                    `;
                    categoryInfoContainer.appendChild(badge);
                }
            }
        });
    });
    
    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
}

function displayNoResults(searchTerm, searchType) {
    // Hide all cards
    const allCards = document.querySelectorAll('.category-card');
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
    const title = document.getElementById('categories-title');
    title.innerHTML = `<i class="fas fa-search mr-2"></i>No Results Found`;
    
    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
    
    // Add no results message
    const categoryCards = document.getElementById('category-cards');
    const existingNoResults = categoryCards.querySelector('.no-results-message');
    if (!existingNoResults) {
        const noResultsDiv = document.createElement('div');
        noResultsDiv.className = 'no-results-message text-center py-8';
        noResultsDiv.innerHTML = `
            <i class="fas fa-search text-yellow-400 text-4xl mb-3"></i>
            <h4 class="text-lg font-semibold text-yellow-600 mb-2">No Categories Found</h4>
            <p class="text-yellow-500">No categories match your search criteria</p>
        `;
        categoryCards.appendChild(noResultsDiv);
    }
}

function clearSearch() {
    // Clear search input
    document.getElementById('category-search-query').value = '';
    
    // Hide search info
    document.getElementById('search-info').classList.add('hidden');
    
    // Reset title
    const title = document.getElementById('categories-title');
    title.innerHTML = `<i class="fas fa-tags mr-2"></i>Active Categories`;
    
    // Show all cards and reset styling
    const allCards = document.querySelectorAll('.category-card');
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

function showCategoryDetailModal(categoryId, categoryName, categoryDescription) {
    currentCategoryId = categoryId;
    currentCategoryName = categoryName;
    isEditMode = false;
    
    document.getElementById('category-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">' + 
        categoryName + 
        '</h3>' +
        '<p class="text-sm text-gray-600 mb-4">ID : ' + categoryId + '</p>' +
        '<div class="text-left space-y-2">' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Name :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + categoryName + '</span>' +
            '</div>' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Description :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + categoryDescription + '</span>' +
            '</div>' +
        '</div>';
    
    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="editCategoryDetailModal(\'' + categoryId + '\', \'' + categoryName + '\', \'' + categoryDescription + '\')" ' +
        'class="flex-1 px-4 py-2 bg-yellow-500 text-white rounded-2xl hover:bg-orange-600 transition font-medium">' +
            '<i class="fas fa-edit mr-2"></i>Edit Category' +
        '</button>' +
        '<button onclick="deleteCategoryFromModal()" ' +
        'class="flex-1 px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">' +
            '<i class="fas fa-trash mr-2"></i>Delete Category' +
        '</button>';
    
    document.getElementById('category-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}
function showAddCategoryModal() {
    currentCategoryId = null;
    currentCategoryName = null;
    isEditMode = false;
    
    document.getElementById('category-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">Add New Category</h3>' +
        '<p class="text-sm text-gray-600 mb-4">Create a new category</p>' +
        '<form id="add-category-form" class="text-left space-y-4">' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Category Name :</label>' +
                '<input type="text" id="add-categoryname" placeholder="Enter category name" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Description :</label>' +
                '<textarea id="add-description" placeholder="Enter category description" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500" rows="3"></textarea>' +
            '</div>' +
        '</form>';
    
    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="saveNewCategory()" ' +
        'class="flex-1 px-4 py-2 bg-green-600 text-white rounded-2xl hover:bg-green-700 transition font-medium">' +
            '<i class="fas fa-plus mr-2"></i>Add Category' +
        '</button>';
    
    document.getElementById('category-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function saveNewCategory() {
    const categoryName = document.getElementById('add-categoryname').value;
    const description = document.getElementById('add-description').value;
    
    if (!categoryName.trim() || !description.trim()) {
        alert('Please fill in all fields');
        return;
    }
    
    if (confirm('Are you sure you want to add this new category?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'addCategory';
        form.appendChild(actionInput);
        
        const inputs = [
            {name: 'name', value: categoryName},
            {name: 'description', value: description}
        ];
        
        inputs.forEach(input => {
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = input.name;
            hiddenInput.value = input.value;
            form.appendChild(hiddenInput);
        });
        
        document.body.appendChild(form);
        form.submit();
    }
}

function editCategoryDetailModal(categoryId, categoryName, categoryDescription) {
    currentCategoryId = categoryId;
    currentCategoryName = categoryName;
    isEditMode = true;

    document.getElementById('category-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">Edit Category</h3>' +
        '<p class="text-sm text-gray-600 mb-4">ID : ' + categoryId + '</p>' +
        '<form id="edit-category-form" class="text-left space-y-4">' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Category Name :</label>' +
                '<input type="text" id="edit-categoryname" value="' + categoryName + '" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Description :</label>' +
                '<textarea id="edit-description" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500" rows="3">' + categoryDescription + '</textarea>' +
            '</div>' +
        '</form>';

    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="saveCategoryChanges()" ' +
        'class="flex-1 px-4 py-2 bg-green-600 text-white rounded-2xl hover:bg-green-700 transition font-medium">' +
            '<i class="fas fa-save mr-2"></i>Save Changes' +
        '</button>' +
        '<button onclick="deleteCategoryFromModal()" ' +
        'class="flex-1 px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">' +
            '<i class="fas fa-trash mr-2"></i>Delete' +
        '</button>';

    document.getElementById('category-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function saveCategoryChanges() {
    const newCategoryName = document.getElementById('edit-categoryname').value;
    const newDescription = document.getElementById('edit-description').value;
    
    if (!newCategoryName.trim() || !newDescription.trim()) {
        alert('Please fill in all fields');
        return;
    }
    
    if (confirm('Are you sure you want to save these changes?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'updateCategory';
        form.appendChild(actionInput);
        
        const inputs = [
            {name: 'id', value: currentCategoryId},
            {name: 'name', value: newCategoryName},
            {name: 'description', value: newDescription}
        ];
        
        inputs.forEach(input => {
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = input.name;
            hiddenInput.value = input.value;
            form.appendChild(hiddenInput);
        });
        
        document.body.appendChild(form);
        form.submit();
    }
}

function deleteCategory(categoryId, categoryName) {
    if (confirm(`Are you sure you want to delete category "${categoryName}"?`)) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'deleteCategory';
        form.appendChild(actionInput);
        
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = categoryId;
        form.appendChild(idInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

function deleteCategoryFromModal() {
    if (currentCategoryId && currentCategoryName) {
        deleteCategory(currentCategoryId, currentCategoryName);
        hideCategoryDetailModal();
    }
}

function hideCategoryDetailModal() {
    document.getElementById('category-detail-modal').classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
    currentCategoryId = null;
    currentCategoryName = null;
    isEditMode = false;
}
</script>
