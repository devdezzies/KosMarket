<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">User Management</h2>

    <!-- Search Section -->
    <div class="bg-white rounded-lg mb-4">
        <div class="p-4">
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Search User</h3>
            <div class="relative">
                <input type="text" id="user-search" placeholder="Search users by name" class="w-full px-4 py-3 pr-12 border border-gray-300 rounded-2xl focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <button onclick="searchUsers()" class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600">
                    <i class="fas fa-search text-lg"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Users List -->
    <div class="bg-white rounded-2xl" id="users-list">
        <div class="p-4">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Active Users</h3>
            
            <!-- User Card 1 -->
            <div class="bg-indigo-50 rounded-lg p-4 user-card border border-indigo-200">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-4">
                        <!-- User Avatar -->
                        <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-gray-600 text-lg"></i>
                        </div>
                        
                        <!-- User Info -->
                        <div>
                            <h3 class="font-semibold text-gray-800">John Doe (johndoe)</h3>
                            <p class="text-sm text-gray-600">ID: 001</p>
                            <p class="text-sm text-gray-600">john.doe@example.com</p>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="flex space-x-2">
                        <button onclick="viewUser(1)" class="px-3 py-2 bg-blue-600 text-white text-sm rounded-lg hover:bg-blue-700 transition">
                            <i class="fas fa-eye mr-1"></i>Info
                        </button>
                        <button onclick="blockUser(1)" class="px-3 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition">
                            <i class="fas fa-ban mr-1"></i>Block
                        </button>
                        <button onclick="deleteUser(1)" class="px-3 py-2 bg-red-600 text-white text-sm rounded-lg hover:bg-red-700 transition">
                            <i class="fas fa-trash mr-1"></i>Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Empty State -->
    <div id="empty-state" class="hidden text-center py-12">
        <i class="fas fa-users text-gray-400 text-6xl mb-4"></i>
        <h3 class="text-xl font-semibold text-gray-600 mb-2">No Users Found</h3>
        <p class="text-gray-500">Try adjusting your search criteria.</p>
    </div>

    <%-- ` --%>
</div>

<!-- User Info Modal -->
<div id="user-info-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white rounded-lg max-w-md w-full p-6">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold text-gray-800">User Information</h3>
            <button onclick="hideUserInfoModal()" class="text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        
        <div id="user-info-content" class="space-y-4">
            <!-- User info will be loaded here -->
        </div>
        
        <div class="mt-6">
            <button onclick="hideUserInfoModal()" class="w-full px-4 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition">
                Close
            </button>
        </div>
    </div>
</div>

<script>
// Search users function
function searchUsers() {
    const searchTerm = document.getElementById('user-search').value.toLowerCase();
    const userCards = document.querySelectorAll('.user-card');
    let visibleCount = 0;
    
    userCards.forEach(card => {
        const userName = card.querySelector('h3').textContent.toLowerCase();
        const userDetails = card.textContent.toLowerCase();
        
        if (userDetails.includes(searchTerm)) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Show empty state if no users visible
    const emptyState = document.getElementById('empty-state');
    const usersList = document.getElementById('users-list');
    if (visibleCount === 0 && searchTerm !== '') {
        emptyState.classList.remove('hidden');
        usersList.classList.add('hidden');
    } else {
        emptyState.classList.add('hidden');
        usersList.classList.remove('hidden');
    }
}

function showUser() {
    const
}
// View user function
function viewUser(userId) {
    // Sample user data - in real app, fetch from server
    const userData = {
        1: { name: 'John Doe', username: 'johndoe', email: 'john.doe@example.com', joinDate: '2024-01-15', status: 'Active' },
        2: { name: 'Jane Smith', username: 'janesmith', email: 'jane.smith@example.com', joinDate: '2024-02-20', status: 'Active' },
        3: { name: 'Bob Johnson', username: 'bobjohnson', email: 'bob.johnson@example.com', joinDate: '2024-03-10', status: 'Active' },
        4: { name: 'Alice Wilson', username: 'alicewilson', email: 'alice.wilson@example.com', joinDate: '2024-03-25', status: 'Active' },
        5: { name: 'Mike Davis', username: 'mikedavis', email: 'mike.davis@example.com', joinDate: '2024-04-05', status: 'Active' }
    };
    
    const user = userData[userId];
    if (user) {
        document.getElementById('user-info-content').innerHTML = `
            <div class="text-center mb-4">
                <div class="w-20 h-20 bg-gray-300 rounded-full flex items-center justify-center mx-auto mb-2">
                    <i class="fas fa-user text-gray-600 text-2xl"></i>
                </div>
                <h4 class="text-lg font-semibold">${user.name}</h4>
            </div>
            
            <div class="space-y-3">
                <div class="flex justify-between">
                    <span class="text-gray-600">Username:</span>
                    <span class="font-medium">${user.username}</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Email:</span>
                    <span class="font-medium">${user.email}</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Join Date:</span>
                    <span class="font-medium">${user.joinDate}</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Status:</span>
                    <span class="font-medium text-green-600">${user.status}</span>
                </div>
            </div>
        `;
        
        showUserInfoModal();
    }
}

// Block user function
function blockUser(userId) {
    if (confirm('Are you sure you want to block this user?')) {
        alert(`User ${userId} will be blocked`);
        // Here you would send block request to server
        // fetch('/admin?action=blockUser&userId=' + userId, { method: 'POST' })
    }
}

// Delete user function
function deleteUser(userId) {
    if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
        alert(`User ${userId} will be deleted`);
        // Here you would send delete request to server
        // fetch('/admin?action=deleteUser&userId=' + userId, { method: 'POST' })
    }
}

// Modal functions
function showUserInfoModal() {
    document.getElementById('user-info-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}

function hideUserInfoModal() {
    document.getElementById('user-info-modal').classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
}

// Search on Enter key
document.getElementById('user-search').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        searchUsers();
    }
});

// Real-time search
document.getElementById('user-search').addEventListener('input', function() {
    searchUsers();
});
</script>