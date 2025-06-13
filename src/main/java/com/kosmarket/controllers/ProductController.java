package com.kosmarket.controllers;

import com.kosmarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductControllerServlet", urlPatterns = "/product")
public class ProductController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        } else {
            List<Product> products = productModel.get();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/products/index.jsp").forward(request, response);
        }
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

    }

}