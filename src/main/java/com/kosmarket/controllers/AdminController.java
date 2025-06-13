package com.kosmarket.controllers;

import java.io.IOException;
import java.util.ArrayList;

import com.kosmarket.models.Admin;
import com.kosmarket.models.Member;
import com.kosmarket.models.ProductCategory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminControllerServlet", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null || !(boolean) session.getAttribute("isLoggedIn")) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        String pathInfo = request.getPathInfo();
        String section = request.getParameter("section"); // Tambahkan ini
        String action = request.getParameter("action");

        // Handle section parameter dari JavaScript fetch
        if (section != null) {
            switch (section) {     
                case "users":
                    handleUserManagement(request, response);
                    return;
                case "products":
                    handleProductManagement(request, response);
                    return;
                case "categories":
                    handleCategoryManagement(request, response);
                    return;
            }
        }
        
        // Handle pathInfo untuk URL routing
        if (pathInfo != null) {
            switch (pathInfo) {     
                case "/users":
                    handleUserManagement(request, response);
                    break;
                case "/products":
                    handleProductManagement(request, response);
                    break;
                case "/categories":
                    handleCategoryManagement(request, response);
                    break;
                default:
                    showAdminPage(request, response);
            }
        } else if (action != null) {
            handleActions(request, response, action);
        } else {
            showAdminPage(request, response);
        }
    }

    private void handleActions(HttpServletRequest request, HttpServletResponse response, String action) throws ServletException, IOException {   
        Admin admin = new Admin();
        
        switch (action) {
            case "addCategory":
                handleAddCategory(request, response, admin);
                break;
            case "updateCategory":  // Tambahkan ini
                handleUpdateCategory(request, response, admin);
                break;
            case "deleteCategory":
                handleDeleteCategory(request, response, admin);
                break;
            case "deleteMember":
                handleDeleteMember(request, response, admin);
                break;
            case "updateMember":
                handleUpdateMember(request, response, admin);
                break;
            // case "deleteProduct":
            //     handleDeleteProduct(request, response, admin);
            //     break;
            case "searchMemberByID":
                searchMemberByID(request, response);
                break;
            case "searchMemberByName":
                searchMemberByName(request, response);
                break;
            case "searchMemberByEmail":
                searchMemberByEmail(request, response);
                break;
            case "searchMemberByUsername":
                searchMemberByUsername(request, response);
                break;
            case "searchMember":
                searchMember(request, response);
                break;
            case "searchCategoryByID":
                searchCategoryByID(request, response);
                break;
            case "searchCategoryByName":
                searchCategoryByName(request, response);
                break;
            case "searchCategory":
                searchCategory(request, response);
                break;
            default:
                showAdminPage(request, response);
        }
    }

    private void showAdminPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
    }

    private void handleUserManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Member memberModel = new Member();
        ArrayList<Member> members = memberModel.get();

        request.setAttribute("members", members);

        // Check if this is a section request (AJAX/fetch dari JavaScript)
        String section = request.getParameter("section");
        if (section != null && section.equals("users")) {
            // Return only the user control content
            request.getRequestDispatcher("/WEB-INF/views/admin-usercontrol.jsp").forward(request, response);
        } else {
            // Return full admin page with user section active and auto-load users
            request.setAttribute("activeSection", "users");
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
        }
    }

    private void handleProductManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Product productModel = new Product();
        // ArrayList<Product> products = productModel.get();
        
        // request.setAttribute("products", products);
        // request.getRequestDispatcher("/WEB-INF/views/admin/admin-productcontrol.jsp").forward(request, response);
    }

    private void handleCategoryManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductCategory categoryModel = new ProductCategory();
        ArrayList<ProductCategory> categories = categoryModel.get();
        
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin-categorycontrol.jsp").forward(request, response);
    }

    private void handleAddCategory(HttpServletRequest request, HttpServletResponse response, Admin admin) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        try {
            if (name != null && !name.trim().isEmpty()) {
                boolean success = admin.addProductCategory(name.trim(), 
                    description != null ? description.trim() : "");
                
                if (success) {
                    request.setAttribute("successMessage", "Category added successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to add category.");
                }
            } else {
                request.setAttribute("errorMessage", "Category name is required.");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        handleCategoryManagement(request, response);
    }

    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response, Admin admin) 
            throws ServletException, IOException {
        String categoryIdStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        try {
            if (categoryIdStr != null && name != null && !name.trim().isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdStr);
                
                ProductCategory category = new ProductCategory();
                category.setId(categoryId);
                category.setName(name.trim());
                category.setDescription(description != null ? description.trim() : "");
                category.update();
                
                boolean success = category.getMessage().contains("rows affected");
                
                if (success) {
                    request.setAttribute("successMessage", "Category updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update category.");
                }
            } else {
                request.setAttribute("errorMessage", "Category ID and name are required.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        // Langsung render ulang partial kategori
        handleCategoryManagement(request, response);
    }

    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response, Admin admin) 
            throws ServletException, IOException {
        String categoryIdStr = request.getParameter("id");
        try {
            if (categoryIdStr != null) {
                int categoryId = Integer.parseInt(categoryIdStr);
                ProductCategory category = new ProductCategory();
                category.setId(categoryId);
                category.delete();

                if (category.getMessage().contains("rows affected")) {
                    request.setAttribute("successMessage", "Category deleted successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to delete category.");
                }
            } else {
                request.setAttribute("errorMessage", "Category ID is required.");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + escapeHtml(e.getMessage()));
        }
        // Langsung render ulang partial kategori
        handleCategoryManagement(request, response);
    }

    private void searchMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String chunkSearchQuery = request.getParameter("searchQuery");
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        if (chunkSearchQuery != null && !chunkSearchQuery.trim().isEmpty()) {
            String query = chunkSearchQuery.trim();
            ArrayList<Integer> resultIds = new ArrayList<>();
            String searchType = "Unknown";
            
            try {
                // Auto-detect search type based on input pattern
                if (query.matches("\\d+")) {
                    // Search by ID
                    searchType = "ID";
                    Member memberModel = new Member();
                    ArrayList<Member> members = memberModel.findById(Integer.parseInt(query));
                    for (Member member : members) {
                        resultIds.add(member.getId());
                    }
                } else if (query.contains("@") && query.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                    // Search by Email
                    searchType = "Email";
                    Member memberModel = new Member();
                    ArrayList<Member> members = memberModel.findByEmail(query);
                    for (Member member : members) {
                        resultIds.add(member.getId());
                    }
                } else if (query.matches("^[a-z0-9_]+$")) {
                    // Search by Username
                    searchType = "Username";
                    Member memberModel = new Member();
                    ArrayList<Member> members = memberModel.findByUsername(query);
                    for (Member member : members) {
                        resultIds.add(member.getId());
                    }
                } else if (query.matches("^[a-zA-Z\\s]+$")) {
                    // Search by Name
                    searchType = "Name";
                    Member memberModel = new Member();
                    ArrayList<Member> members = memberModel.findByName(query);
                    for (Member member : members) {
                        resultIds.add(member.getId());
                    }
                } else {
                    // Default to name search
                    searchType = "Name";
                    Member memberModel = new Member();
                    ArrayList<Member> members = memberModel.findByName(query);
                    for (Member member : members) {
                        resultIds.add(member.getId());
                    }
                }

                // Prepare response HTML
                StringBuilder idsString = new StringBuilder();
                for (int i = 0; i < resultIds.size(); i++) {
                    if (i > 0) idsString.append(",");
                    idsString.append(resultIds.get(i));
                }
                
                String responseHtml = "<div data-search-result-ids=\"" + idsString.toString() + "\" " +
                                    "data-search-type=\"" + searchType + "\" " +
                                    "data-search-term=\"" + escapeHtml(query) + "\" " +
                                    "data-search-success=\"true\">" +
                                    "Search completed. Found " + resultIds.size() + " results." +
                                    "</div>";
                
                response.getWriter().print(responseHtml);
                
            } catch (Exception e) {
                System.err.println("Search error: " + e.getMessage());
                e.printStackTrace();
                
                String errorResponse = "<div data-search-result-ids=\"\" " +
                                     "data-search-type=\"Error\" " +
                                     "data-search-term=\"" + escapeHtml(query) + "\" " +
                                     "data-search-success=\"false\">" +
                                     "Search error: " + escapeHtml(e.getMessage()) +
                                     "</div>";
                
                response.getWriter().print(errorResponse);
            }
        } else {
            String emptyResponse = "<div data-search-result-ids=\"\" " +
                                 "data-search-type=\"Empty\" " +
                                 "data-search-term=\"\" " +
                                 "data-search-success=\"false\">" +
                                 "Search query is required." +
                                 "</div>";
            
            response.getWriter().print(emptyResponse);
        }
    }

    // Helper method untuk escape HTML
    private String escapeHtml(String str) {
        if (str == null) return "";
        return str.replace("&", "&amp;")
                  .replace("<", "&lt;")
                  .replace(">", "&gt;")
                  .replace("\"", "&quot;")
                  .replace("'", "&#39;");
    }

    private void handleDeleteMember(HttpServletRequest request, HttpServletResponse response, Admin admin) 
        throws ServletException, IOException {
        String memberIdStr = request.getParameter("id");
        
        // Debug logging
        System.out.println("=== DELETE MEMBER DEBUG ===");
        System.out.println("Received ID parameter: " + memberIdStr);
        
        try {
            if (memberIdStr != null) {
                int memberId = Integer.parseInt(memberIdStr);
                System.out.println("Parsed member ID: " + memberId);
                
                // First try normal delete
                Member member = new Member();
                member.setId(memberId);
                member.delete();
                
                System.out.println("Delete message: " + member.getMessage());
                
                boolean success = member.getMessage().contains("rows affected");
                
                if (success) {
                    System.out.println("Delete successful!");
                    request.setAttribute("successMessage", "Member deleted successfully!");
                } else {
                    System.out.println("Delete failed - message: " + member.getMessage());
                    
                    // Check for foreign key constraint error - auto cascade delete
                    if (member.getMessage().contains("foreign key constraint")) {
                        System.out.println("Foreign key constraint detected, attempting cascade delete...");
                        
                        // Use cascade delete method
                        boolean cascadeSuccess = deleteMemberWithRelatedData(memberId);
                        
                        if (cascadeSuccess) {
                            System.out.println("Cascade delete successful!");
                            request.setAttribute("successMessage", "Member and all related data deleted successfully!");
                        } else {
                            System.out.println("Cascade delete failed!");
                            request.setAttribute("errorMessage", "Failed to delete member even with cascade delete.");
                        }
                    } else {
                        request.setAttribute("errorMessage", "Failed to delete member: " + member.getMessage());
                    }
                }
            } else {
                System.out.println("Member ID is null!");
                request.setAttribute("errorMessage", "Member ID is required.");
            }
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid member ID.");
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        // Redirect ke user management dengan benar
        response.sendRedirect(request.getContextPath() + "/admin?activeSection=users");
    }

    public boolean deleteMemberWithRelatedData(int memberId) {
        try {
            System.out.println("=== CASCADE DELETE DEBUG ===");
            System.out.println("Starting cascade delete for member ID: " + memberId);
            
            Member tempMember = new Member();
            
            // 1. Delete bookmark items first
            System.out.println("Step 1: Deleting bookmark items...");
            String deleteBookmarkItemsSQL = "DELETE bi FROM bookmarkitems bi " +
                                        "INNER JOIN bookmark b ON bi.bookmarkId = b.id " +
                                        "WHERE b.memberId = " + memberId;
            System.out.println("Executing: " + deleteBookmarkItemsSQL);
            
            int bookmarkItemsDeleted = tempMember.executeUpdate(deleteBookmarkItemsSQL);
            System.out.println("Bookmark items deleted: " + bookmarkItemsDeleted + " rows");
            
            // 2. Delete bookmarks
            System.out.println("Step 2: Deleting bookmarks...");
            String deleteBookmarksSQL = "DELETE FROM bookmark WHERE memberId = " + memberId;
            System.out.println("Executing: " + deleteBookmarksSQL);
            
            int bookmarksDeleted = tempMember.executeUpdate(deleteBookmarksSQL);
            System.out.println("Bookmarks deleted: " + bookmarksDeleted + " rows");
            
            // 3. Delete products posted by this member
            System.out.println("Step 3: Deleting products...");
            String deleteProductsSQL = "DELETE FROM product WHERE memberId = " + memberId;
            System.out.println("Executing: " + deleteProductsSQL);
            
            int productsDeleted = tempMember.executeUpdate(deleteProductsSQL);
            System.out.println("Products deleted: " + productsDeleted + " rows");
            
            // 4. Delete other related data if exists
            /*
            System.out.println("Step 4: Deleting orders...");
            String deleteOrdersSQL = "DELETE FROM orders WHERE memberId = " + memberId;
            int ordersDeleted = tempMember.executeUpdate(deleteOrdersSQL);
            System.out.println("Orders deleted: " + ordersDeleted + " rows");
            
            System.out.println("Step 5: Deleting reviews...");
            String deleteReviewsSQL = "DELETE FROM reviews WHERE memberId = " + memberId;
            int reviewsDeleted = tempMember.executeUpdate(deleteReviewsSQL);
            System.out.println("Reviews deleted: " + reviewsDeleted + " rows");
            
            System.out.println("Step 6: Deleting cart items...");
            String deleteCartSQL = "DELETE FROM cart WHERE memberId = " + memberId;
            int cartDeleted = tempMember.executeUpdate(deleteCartSQL);
            System.out.println("Cart items deleted: " + cartDeleted + " rows");
            */
            
            // 5. Finally delete the member
            System.out.println("Step 4: Deleting member...");
            Member member = new Member();
            member.setId(memberId);
            member.delete();
            
            System.out.println("Member delete result: " + member.getMessage());
            boolean success = member.getMessage().contains("rows affected");
            
            if (success) {
                System.out.println("CASCADE DELETE SUCCESSFUL for member ID: " + memberId);
            } else {
                System.out.println("CASCADE DELETE FAILED for member ID: " + memberId);
            }
            
            return success;
        } catch (Exception e) {
            System.err.println("Error in cascade delete: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void handleUpdateMember(HttpServletRequest request, HttpServletResponse response, Admin admin)
        throws ServletException, IOException {
        String memberIdStr = request.getParameter("id");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        try {
            if (memberIdStr != null && firstName != null && lastName != null && username != null && email != null) {
                int memberId = Integer.parseInt(memberIdStr);
                
                // Update member menggunakan Member model
                Member member = new Member();
                member.setId(memberId);
                member.setFirstName(firstName);
                member.setLastName(lastName);
                member.setUsername(username);
                member.setEmail(email);
                member.update();
                
                boolean success = member.getMessage().contains("rows affected");
                
                if (success) {
                    request.setAttribute("successMessage", "User updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update user.");
                }
            } else {
                request.setAttribute("errorMessage", "Missing required parameters.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid user ID.");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin?activeSection=users");
    }

    private void searchMemberByID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            try {
                int targetId = Integer.parseInt(searchQuery.trim());
                Member memberModel = new Member();
                ArrayList<Member> members = memberModel.findById(targetId);

                if (members != null && !members.isEmpty()) {
                    request.setAttribute("members", members);
                    request.setAttribute("searchResult", members.get(0));
                } else {
                    request.setAttribute("errorMessage", "User not found.");
                    request.setAttribute("members", new ArrayList<>());
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid user ID format.");
                request.setAttribute("members", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "User ID is required for search.");
            request.setAttribute("members", new ArrayList<>());
        }
        
        request.setAttribute("activeSection", "users");
        request.getRequestDispatcher("/WEB-INF/views/admin-usercontrol.jsp").forward(request, response);
    }

    private void searchMemberByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            Member memberModel = new Member();
            ArrayList<Member> members = memberModel.findByName(searchQuery.trim());

            if (members != null && !members.isEmpty()) {
                request.setAttribute("members", members);
                request.setAttribute("searchResult", members);
            } else {
                request.setAttribute("errorMessage", "No users found with the given name.");
                request.setAttribute("members", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "User name is required for search.");
            request.setAttribute("members", new ArrayList<>());
        }
        
        request.setAttribute("activeSection", "users");
        request.getRequestDispatcher("/WEB-INF/views/admin-usercontrol.jsp").forward(request, response);
    }

    private void searchMemberByEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            Member memberModel = new Member();
            ArrayList<Member> members = memberModel.findByEmail(searchQuery.trim());

            if (members != null && !members.isEmpty()) {
                request.setAttribute("members", members);
                request.setAttribute("searchResult", members);
            } else {
                request.setAttribute("errorMessage", "No users found with the given email.");
                request.setAttribute("members", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "User email is required for search.");
            request.setAttribute("members", new ArrayList<>());
        }
        
        request.setAttribute("activeSection", "users");
        request.getRequestDispatcher("/WEB-INF/views/admin-usercontrol.jsp").forward(request, response);
    }

    private void searchMemberByUsername(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            Member memberModel = new Member();
            ArrayList<Member> members = memberModel.findByUsername(searchQuery.trim());

            if (members != null && !members.isEmpty()) {
                request.setAttribute("members", members);
                request.setAttribute("searchResult", members);
            } else {
                request.setAttribute("errorMessage", "No users found with the given username.");
                request.setAttribute("members", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "User username is required for search.");
            request.setAttribute("members", new ArrayList<>());
        }
        
        request.setAttribute("activeSection", "users");
        request.getRequestDispatcher("/WEB-INF/views/admin-usercontrol.jsp").forward(request, response);
    }

    private void searchCategoryByID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            try {
                int targetId = Integer.parseInt(searchQuery.trim());
                ProductCategory categoryModel = new ProductCategory();
                ArrayList<ProductCategory> categories = categoryModel.findById(targetId);

                if (categories != null && !categories.isEmpty()) {
                    request.setAttribute("categories", categories);
                    request.setAttribute("searchResult", categories.get(0));
                } else {
                    request.setAttribute("errorMessage", "Category not found.");
                    request.setAttribute("categories", new ArrayList<>());
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid category ID format.");
                request.setAttribute("categories", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "Category ID is required for search.");
            request.setAttribute("categories", new ArrayList<>());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin-categorycontrol.jsp").forward(request, response);
    }

    private void searchCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String chunkSearchQuery = request.getParameter("searchQuery");

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        if (chunkSearchQuery != null && !chunkSearchQuery.trim().isEmpty()) {
            String query = chunkSearchQuery.trim();
            ArrayList<Integer> resultIds = new ArrayList<>();
            String searchType = "Unknown";

            try {
                // Auto-detect search type
                if (query.matches("\\d+")) {
                    // Search by ID
                    searchType = "ID";
                    ProductCategory categoryModel = new ProductCategory();
                    ArrayList<ProductCategory> categories = categoryModel.findById(Integer.parseInt(query));
                    for (ProductCategory cat : categories) {
                        resultIds.add(cat.getId());
                    }
                } else {
                    // Search by Name
                    searchType = "Name";
                    ProductCategory categoryModel = new ProductCategory();
                    ArrayList<ProductCategory> categories = categoryModel.findByName(query);
                    for (ProductCategory cat : categories) {
                        resultIds.add(cat.getId());
                    }
                }

                // Prepare response HTML
                StringBuilder idsString = new StringBuilder();
                for (int i = 0; i < resultIds.size(); i++) {
                    if (i > 0) idsString.append(",");
                    idsString.append(resultIds.get(i));
                }

                String responseHtml = "<div data-search-result-ids=\"" + idsString.toString() + "\" " +
                                    "data-search-type=\"" + searchType + "\" " +
                                    "data-search-term=\"" + escapeHtml(query) + "\" " +
                                    "data-search-success=\"true\">" +
                                    "Search completed. Found " + resultIds.size() + " results." +
                                    "</div>";

                response.getWriter().print(responseHtml);

            } catch (Exception e) {
                String errorResponse = "<div data-search-result-ids=\"\" " +
                                     "data-search-type=\"Error\" " +
                                     "data-search-term=\"" + escapeHtml(query) + "\" " +
                                     "data-search-success=\"false\">" +
                                     "Search error: " + escapeHtml(e.getMessage()) +
                                     "</div>";
                response.getWriter().print(errorResponse);
            }
        } else {
            String emptyResponse = "<div data-search-result-ids=\"\" " +
                             "data-search-type=\"Empty\" " +
                             "data-search-term=\"\" " +
                             "data-search-success=\"false\">" +
                             "Search query is required." +
                             "</div>";
            response.getWriter().print(emptyResponse);
        }
    }

    private void searchCategoryByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            ProductCategory categoryModel = new ProductCategory();
            ArrayList<ProductCategory> categories = categoryModel.findByName(searchQuery.trim());

            if (categories != null && !categories.isEmpty()) {
                request.setAttribute("categories", categories);
                request.setAttribute("searchResult", categories);
            } else {
                request.setAttribute("errorMessage", "No categories found with the given name.");
                request.setAttribute("categories", new ArrayList<>());
            }
        } else {
            request.setAttribute("errorMessage", "Category name is required for search.");
            request.setAttribute("categories", new ArrayList<>());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin-categorycontrol.jsp").forward(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

}