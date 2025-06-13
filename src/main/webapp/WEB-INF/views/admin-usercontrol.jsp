<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.kosmarket.models.Member" %>
<%@ page import="java.util.ArrayList" %>

<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Member Management</h2>

    <!-- Search Section -->
    <div class="bg-white mb-4">
        <div class="p-4">
            <div class="flex items-center justify-between mb-3">
                <h3 class="text-lg font-semibold text-gray-800"><i class="fas fa-search mr-2"></i>Search the Member</h3>
                <button onclick="clearSearch()" id="clear-search-btn" class="hidden px-3 py-1 text-sm text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-2xl transition">
                    <i class="fas fa-times mr-1"></i>Clear Search
                </button>
            </div>
            <form onsubmit="searchMember(event)" class="flex items-center space-x-3">
                <div class="relative flex-1">
                    <input type="text" id="member-search-query" name="searchQuery" placeholder="Search by ID, name, username, or email" 
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
                (<span id="search-type-display"></span>) - Found: <span id="search-count">0</span> member(s)
            </span>
        </div>
    </div>

    <!-- Members List -->
    <div class="bg-white" id="members-list">
        <div class="p-4">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-semibold text-gray-800" id="members-title">
                    <i class="fas fa-users mr-2"></i>Active Member
                </h3>
                <!-- Display total members count -->
                <div class="text-sm text-gray-600">
                    <span class="font-medium">Total Members : </span>
                    <span class="text-indigo-600 font-semibold">
                        <%
                            ArrayList<Member> members = (ArrayList<Member>) request.getAttribute("members");
                            out.print(members != null ? members.size() : 0);
                        %>
                    </span>
                </div>
            </div>

            <!-- Member Cards -->
            <div id="member-cards" class="space-y-3">
                <%
                    if (members != null && !members.isEmpty()) {
                        for (Member member : members) {
                %>
                <div class="bg-indigo-100 rounded-2xl p-4 member-card" 
                     data-member-id="<%= member.getId() %>"
                     data-search="<%= member.getId() %> <%= member.getFirstName() %> <%= member.getLastName() %> <%= member.getUsername() %> <%= member.getEmail() %>">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <!-- Member Avatar -->
                            <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center">
                                <i class="fas fa-user text-gray-600 text-lg"></i>
                            </div>
                            
                            <!-- Member Info -->
                            <div class="member-info">
                                <h3 class="font-semibold text-gray-800">
                                    <%= member.getFirstName() %> <%= member.getLastName() %>
                                </h3>
                                <p class="text-sm text-gray-600">ID: <%= member.getId() %></p>
                                <p class="text-sm text-gray-600">@<%= member.getUsername() %></p>
                                <p class="text-sm text-gray-600"><%= member.getEmail() %></p>
                            </div>
                        </div>
                    </div>
                    <!-- Action Buttons -->
                    <div class="flex justify-end space-x-2 p-1 mt-3">
                        <button onclick="showUserDetailModal('<%= member.getId() %>', '<%= member.getFirstName() %>', '<%= member.getLastName() %>', '<%= member.getUsername() %>', '<%= member.getEmail() %>')" 
                                class="px-3 py-2 bg-indigo-500 text-white text-sm rounded-2xl hover:bg-indigo-600 transition">
                            <i class="fas fa-eye mr-1"></i>View
                        </button>
                        <button onclick="editUserDetailModal('<%= member.getId() %>', '<%= member.getFirstName() %>', '<%= member.getLastName() %>', '<%= member.getUsername() %>', '<%= member.getEmail() %>')" 
                                class="px-3 py-2 bg-yellow-500 text-white text-sm rounded-2xl hover:bg-yellow-600 transition">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </button>
                        <button onclick="deleteMember('<%= member.getId() %>', '<%= member.getFirstName() %> <%= member.getLastName() %>')" 
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
                    <i class="fas fa-users text-gray-400 text-4xl mb-3"></i>
                    <h4 class="text-lg font-semibold text-gray-700 mb-2">No Members Found</h4>
                    <p class="text-gray-500">No members are registered in the system.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<!-- User Detail Modal -->
<div id="user-detail-modal" class="hidden fixed inset-0 bg-gray-200 bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-3xl p-6 w-full max-w-md mx-4 shadow-2xl">
        <div class="text-center">
            <div id="user-detail-content">
                
            </div>
            
            <div id="modal-buttons" class="flex justify-center space-x-3 mt-6">
                
            </div>
            
            <button onclick="hideUserDetailModal()" 
                    class="mt-4 w-full px-6 py-2 bg-gray-300 text-gray-700 rounded-2xl hover:bg-gray-400 transition font-medium">
                Close
            </button>
        </div>
    </div>
</div>

<script>
let currentUserId = null;
let currentUserName = null;
let isEditMode = false;
let searchResultIds = [];

document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('user-detail-modal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                hideUserDetailModal();
            }
        });
    }
});

function searchMember(event) {
    event.preventDefault();
    
    const searchInput = document.getElementById('member-search-query');
    const searchQuery = searchInput.value.trim();
    
    if (searchQuery === '') {
        clearSearch();
        return;
    }
    
    fetch('${pageContext.request.contextPath}/admin?action=searchMember&searchQuery=' + encodeURIComponent(searchQuery))
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
    
    const title = document.getElementById('members-title');
    title.innerHTML = `<i class="fas fa-user mr-2"></i>Search Results`;

    const allCards = document.querySelectorAll('.member-card');
    
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
            if (card.getAttribute('data-member-id') === String(id)) {
                card.style.display = 'block';
                card.classList.remove('bg-indigo-100');
                card.classList.add('bg-yellow-100', 'border-2', 'border-yellow-300');
                const memberInfoContainer = card.querySelector('.member-info');
                if (memberInfoContainer && !memberInfoContainer.querySelector('.search-result-badge')) {
                    const badge = document.createElement('div');
                    badge.className = 'mt-1 search-result-badge';
                    badge.innerHTML = `
                        <span class="inline-block px-2 py-1 bg-yellow-200 text-yellow-800 text-xs rounded-full">
                            <i class="fas fa-search mr-1"></i>Search Result
                        </span>
                    `;
                    memberInfoContainer.appendChild(badge);
                }
            }
        });
    });
    
    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
}

function displayNoResults(searchTerm, searchType) {
    // Hide all cards
    const allCards = document.querySelectorAll('.member-card');
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
    const title = document.getElementById('members-title');
    title.innerHTML = `<i class="fas fa-user mr-2"></i>No Results Found`;

    // Show clear search button
    document.getElementById('clear-search-btn').classList.remove('hidden');
    
    // Add no results message
    const memberCards = document.getElementById('member-cards');
    const existingNoResults = memberCards.querySelector('.no-results-message');
    if (!existingNoResults) {
        const noResultsDiv = document.createElement('div');
        noResultsDiv.className = 'no-results-message text-center py-8';
        noResultsDiv.innerHTML = `
            <i class="fas fa-search text-yellow-400 text-4xl mb-3"></i>
            <h4 class="text-lg font-semibold text-yellow-600 mb-2">No Members Found</h4>
            <p class="text-yellow-500">No members match your search criteria</p>
        `;
        memberCards.appendChild(noResultsDiv);
    }
}

function clearSearch() {
    // Clear search input
    document.getElementById('member-search-query').value = '';
    
    // Hide search info
    document.getElementById('search-info').classList.add('hidden');
    
    // Reset title
    const title = document.getElementById('members-title');
    title.innerHTML = `<i class="fas fa-users mr-2"></i>Active Member`;
    
    // Show all cards and reset styling
    const allCards = document.querySelectorAll('.member-card');
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

function showUserDetailModal(userId, firstName, lastName, username, email) {
    currentUserId = userId;
    currentUserName = firstName + ' ' + lastName;
    isEditMode = false;
    
    document.getElementById('user-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">' + 
        firstName + ' ' + lastName + 
        '</h3>' +
        '<p class="text-sm text-gray-600 mb-4">ID : ' + userId + '</p>' +
        '<div class="text-left space-y-2">' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Username :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + username + '</span>' +
            '</div>' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Email :</span>' +
                '<span class="text-gray-800 text-sm font-medium">' + email + '</span>' +
            '</div>' +
            '<div class="flex justify-between">' +
                '<span class="text-gray-600 text-sm">Date Registered :</span>' +
                '<span class="text-gray-800 text-sm font-medium">2024-01-15</span>' +
            '</div>' +
        '</div>';
    
    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="editUserDetailModal(\'' + userId + '\', \'' + firstName + '\', \'' + lastName + '\', \'' + username + '\', \'' + email + '\')" ' +
        'class="flex-1 px-4 py-2 bg-yellow-500 text-white rounded-2xl hover:bg-orange-600 transition font-medium">' +
            '<i class="fas fa-edit mr-2"></i>Edit User' +
        '</button>' +
        '<button onclick="deleteMemberFromModal()" ' +
        'class="flex-1 px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">' +
            '<i class="fas fa-trash mr-2"></i>Delete User' +
        '</button>';
    
    document.getElementById('user-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function editUserDetailModal(userId, firstName, lastName, username, email) {
    currentUserId = userId;
    currentUserName = firstName + ' ' + lastName;
    isEditMode = true;

    document.getElementById('user-detail-content').innerHTML = 
        '<h3 class="text-lg font-semibold text-gray-800 mb-1">Edit User</h3>' +
        '<p class="text-sm text-gray-600 mb-4">ID : ' + userId + '</p>' +
        '<form id="edit-user-form" class="text-left space-y-4">' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">First Name :</label>' +
                '<input type="text" id="edit-firstname" value="' + firstName + '" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Last Name :</label>' +
                '<input type="text" id="edit-lastname" value="' + lastName + '" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Username:</label>' +
                '<input type="text" id="edit-username" value="' + username + '" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
            '<div>' +
                '<label class="block text-gray-600 text-sm mb-1">Email :</label>' +
                '<input type="email" id="edit-email" value="' + email + '" ' +
                'class="w-full px-3 py-2 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">' +
            '</div>' +
        '</form>';

    document.getElementById('modal-buttons').innerHTML = 
        '<button onclick="saveUserChanges()" ' +
        'class="flex-1 px-4 py-2 bg-green-600 text-white rounded-2xl hover:bg-green-700 transition font-medium">' +
            '<i class="fas fa-save mr-2"></i>Save Changes' +
        '</button>' +
        '<button onclick="deleteMemberFromModal()" ' +
        'class="flex-1 px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">' +
            '<i class="fas fa-trash mr-2"></i>Delete' +
        '</button>';

    document.getElementById('user-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function saveUserChanges() {
    const newFirstName = document.getElementById('edit-firstname').value;
    const newLastName = document.getElementById('edit-lastname').value;
    const newUsername = document.getElementById('edit-username').value;
    const newEmail = document.getElementById('edit-email').value;
    
    if (!newFirstName.trim() || !newLastName.trim() || !newUsername.trim() || !newEmail.trim()) {
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
        actionInput.value = 'updateMember';
        form.appendChild(actionInput);
        
        const inputs = [
            {name: 'id', value: currentUserId},
            {name: 'firstName', value: newFirstName},
            {name: 'lastName', value: newLastName},
            {name: 'username', value: newUsername},
            {name: 'email', value: newEmail}
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

function deleteMember(userId, userName) {
    if (confirm(`Are you sure you want to delete member "${userName}"?`)) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'deleteMember';
        form.appendChild(actionInput);
        
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = userId;
        form.appendChild(idInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

function deleteMemberFromModal() {
    if (currentUserId && currentUserName) {
        deleteMember(currentUserId, currentUserName);
        hideUserDetailModal();
    }
}

function hideUserDetailModal() {
    document.getElementById('user-detail-modal').classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
    currentUserId = null;
    currentUserName = null;
    isEditMode = false;
}
</script>
