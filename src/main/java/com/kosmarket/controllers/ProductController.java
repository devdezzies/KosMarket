package com.kosmarket.controllers;

import com.kosmarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductControllerServlet", urlPatterns = "/products")
public class ProductController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product productModel = new Product();
        List<Product> products = productModel.get();

        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/products/index.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

    }

}