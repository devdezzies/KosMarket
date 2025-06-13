package com.kosmarket.controllers;

import com.kosmarket.models.Member;
import com.kosmarket.models.Product;

import com.kosmarket.models.ProductCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "ProductControllerServlet", urlPatterns = "/product")
@MultipartConfig( // ← ini WAJIB ADA untuk handle upload file
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProductController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet");
        String menu = request.getParameter("menu");
        String idParam = request.getParameter("id");

        Product productModel = new Product();

        if ("product_view".equals(menu) && idParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                Product product = productModel.find(String.valueOf(productId));

                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/WEB-INF/views/product.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            } catch (NumberFormatException e) {
                System.out.println("[ERROR] Invalid product ID format: " + idParam);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else if ("product_post".equals(menu)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("isLoggedIn") == null || session.getAttribute("member") == null) {
                response.sendRedirect(request.getContextPath() + "/authentication");
                return;
            }
            Member currentMember = (Member) session.getAttribute("member");
            request.setAttribute("firstName", currentMember.getFirstName());
            request.setAttribute("lastName", currentMember.getLastName());

            List<ProductCategory> categories = ProductCategory.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
        } else {
            List<Product> products = productModel.get();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/products/index.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("doPost");
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
        String menu = request.getParameter("menu");
        HttpSession session = request.getSession(false);
        Member currentMember = (Member) session.getAttribute("member");
        int memberId = currentMember.getId();
        if ("add_product".equals(menu)) {
            // Ambil data dari form
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String itemCountStr = request.getParameter("itemCount");
            String location = request.getParameter("location"); // Fixed: bukan passwor
            String categoryIdStr = request.getParameter("categoryId");
            System.out.println(name);

            Part filePart = request.getPart("image"); // ambil file part dari form
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // ambil nama file asli
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads"; // folder tujuan

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir(); // buat folder jika belum ada

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // simpan file ke server

            String imageUrl = "https://images.unsplash.com/photo-1743844915361-13c93d59c965?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" + fileName; // url relatif, bisa diakses dari JSP


            try {
                // Validasi input
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Product name is required");
                    request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
                    return;
                }

                if (priceStr == null || priceStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Price is required");
                    request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
                    return;
                }

                if (itemCountStr == null || itemCountStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Item count is required");
                    request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
                    return;
                }

                // Parse angka
                double price = Double.parseDouble(priceStr);
                int itemCount = Integer.parseInt(itemCountStr);
                int categoryId = (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) ?
                        Integer.parseInt(categoryIdStr) : 1;

                // Buat produk baru
                Product newProduct = new Product();
                newProduct.setName(name);
                newProduct.setMemberId(memberId);
                newProduct.setDescription(description != null ? description : "");
                newProduct.setPrice(price);
                newProduct.setItemCount(itemCount);
                newProduct.setLocation(location != null ? location : "");
                newProduct.setImageUrl(imageUrl);
                newProduct.setCategoryId(categoryId);
                newProduct.setCreatedAt(createdAt);
                newProduct.insert();

                // Simpan ke database (assumed method exist// atau productModel.save(newProduct);
                System.out.println("[INFO] Product created: " + newProduct);
                request.getRequestDispatcher("/WEB-INF/views/home").forward(request, response);


            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid number format for price or item count");
                request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
            } catch (Exception e) {
                System.out.println("[ERROR] Failed to save product: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to save product: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/postProduct.jsp").forward(request, response);
            }
        }
    }
}