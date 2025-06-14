package com.kosmarket.controllers.profile;

import java.io.*;
import java.util.List;
import java.util.ArrayList;

import com.kosmarket.models.Address;
import com.kosmarket.models.Member;
import com.kosmarket.models.Product;
import com.kosmarket.models.ProductCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "ProfileControllerServlet", urlPatterns = "/profile/me")
public class ProfileController extends HttpServlet {
    
    public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page");
        if (page == null || page.isEmpty()) {
            page = request.getQueryString() != null && request.getQueryString().contains("page=")
                    ? request.getQueryString().split("page=")[1].split("&")[0]
                    : "";
        }

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        Member user = (Member) session.getAttribute("member");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        Address address = new Address().findAddressById(user.getAddressId());

        request.setAttribute("username", user.getUsername());
        request.setAttribute("firstName", user.getFirstName());
        request.setAttribute("lastName", user.getLastName());
        request.setAttribute("email", user.getEmail());
        request.setAttribute("profilePicture", user.getProfilePicture());

        if (address == null) {
            address = new Address();
            address.setStreet("");
            address.setNumber("");
            address.setZipCode(0);
            address.setCity("");
            address.setPhone("");
            address.update();
        } else {
            request.setAttribute("street", address.getStreet() == null ? "" : address.getStreet());
            request.setAttribute("number", address.getNumber() == null ? "" : address.getNumber());
            request.setAttribute("zipCode", address.getZipCode() == 0 ? "" : address.getZipCode());
            request.setAttribute("city", address.getCity() == null ? "" : address.getCity());
            request.setAttribute("phone", address.getPhone() == null ? "" : address.getPhone());
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            switch (page) {
                case "me":
                    handleProfilePost(request, response);
                    return;
                case "location":
                    handleLocationPost(request, response);
                    return;
                case "edit_product":
                    handleEditProductPost(request, response);
                    return;
                case "delete_product":
                    handleDeleteProductPost(request, response);
                    return;

            }
        } else if ("GET".equalsIgnoreCase(request.getMethod())) {
            switch (page) {
                case "products":
                    handleProductsGet(request, response);
                    break;
                case "edit_product":
                    handleEditProductGet(request, response);
                    break;
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp").forward(request, response);
    }

    private void handleProfilePost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        email = email.trim().toLowerCase();
        
        ArrayList<Member> existingMembers = new Member().findByEmail(email);
        if (!existingMembers.isEmpty()) {
            Member existing = existingMembers.get(0);
            if (existing.getId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/profile/me?page=me&error=email_exists");
                return;
            }
        }

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);

        user.update();

        session.setAttribute("member", user);

        response.sendRedirect(request.getContextPath() + "/profile/me?page=me&success=1");
        return;
    }

    private void handleLocationPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        Address address = new Address().findAddressById(user.getAddressId()); // TODO fix address id
        System.out.println("ADDR ID: " + user.getAddressId());

        String street = request.getParameter("street");
        String number = request.getParameter("number");
        int zipCode = Integer.parseInt(request.getParameter("zipCode") == null ? "-1" : request.getParameter("zipCode"));
        String city = request.getParameter("city");

        String phone = request.getParameter("phone");
        if (phone != null) {
            phone = phone.trim();

            phone = phone.replaceAll("[\\s\\-()]", "");

            if (!phone.startsWith("62")) {
                phone = "62" + phone.replaceFirst("^0+", "");
            }

            if (!phone.matches("^62[0-9]{8,}$")) {
                response.sendRedirect(request.getContextPath() + "/profile/me?page=location&error=phone");
                return;
            }
        }

        address.setStreet(street);
        address.setNumber(number);
        address.setZipCode(zipCode);
        address.setCity(city);
        address.setPhone(phone);

        address.update();
        session.setAttribute("address", address);

        response.sendRedirect(request.getContextPath() + "/profile/me?page=location&success=1");
        return;
    }

    private void handleEditProductPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=missing_productId");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=invalid_productId");
            return;
        }

        Product productModel = new Product();
        List<Product> allProducts = productModel.get();
        Product productToEdit = null;
        if (allProducts != null) {
            for (Product p : allProducts) {
                if (p.getId() == productId && p.getMemberId() == user.getId()) {
                    productToEdit = p;
                    break;
                }
            }
        }

        if (productToEdit == null) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=not_found");
            return;
        }

        String name = request.getParameter("name");
        String priceParam = request.getParameter("price");
        String description = request.getParameter("description");
        String itemCountParam = request.getParameter("itemCount");
        String categoryIdParam = request.getParameter("categoryId");

        if (name == null || name.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty() ||
            itemCountParam == null || itemCountParam.trim().isEmpty() ||
            categoryIdParam == null || categoryIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=edit_product&productId=" + productId + "&error=missing_fields");
            return;
        }

        double price;
        int itemCount;
        int categoryId;
        try {
            price = Double.parseDouble(priceParam);
            itemCount = Integer.parseInt(itemCountParam);
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=edit_product&productId=" + productId + "&error=invalid_number");
            return;
        }

        productToEdit.setName(name);
        productToEdit.setPrice(price);
        productToEdit.setDescription(description != null ? description : "");
        productToEdit.setItemCount(itemCount);
        productToEdit.setCategoryId(categoryId); // assuming you have this setter

        // TODO: Handle image upload if needed (request.getPart("image"))

        productToEdit.update();

        response.sendRedirect(request.getContextPath() + "/profile/me?page=edit_product&productId=" + productId + "&success=1");
    }

    private void handleDeleteProductPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/authentication");
            return;
        }

        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=missing_productId");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=invalid_productId");
            return;
        }

        Product productModel = new Product();
        Product productToDelete = productModel.find(String.valueOf(productId));
        if (productToDelete == null || productToDelete.getMemberId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/profile/me?page=products&error=not_found");
            return;
        }

        productToDelete.delete();

        response.sendRedirect(request.getContextPath() + "/profile/me?page=products&success=deleted");
    }

    private void handleProductsGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");
        Product productModel = new Product();

        String search = request.getParameter("search");
        request.setAttribute("search", search);
        List<Product> allProducts = productModel.get();
        
        List<Product> userProducts = new ArrayList<Product>();

        if (allProducts != null && user != null) {
            for (Product p : allProducts) {
                if (p.getMemberId() == user.getId()) {
                    userProducts.add(p);
                }
            }
        }

        request.setAttribute("products", userProducts);
    }

    private void handleEditProductGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member user = (Member) session.getAttribute("member");
        Product productModel = new Product();
        List<ProductCategory> categories = ProductCategory.getAll();
        List<Product> allProducts = productModel.get();
        List<Product> userProducts = new ArrayList<Product>();

        if (allProducts != null && user != null) {
            for (Product p : allProducts) {
                if (p.getMemberId() == user.getId()) {
                    userProducts.add(p);
                }
            }
        }

        request.setAttribute("categories", categories);
        request.setAttribute("products", userProducts);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

}