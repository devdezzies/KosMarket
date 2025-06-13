package com.kosmarket.controllers;

import com.kosmarket.models.Product;
import com.kosmarket.models.ProductCategory;
import com.kosmarket.models.Bookmark;
import com.kosmarket.models.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeControllerServlet", urlPatterns = "/home")
public class HomeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product productModel = new Product();

        // Filtering logic
        String[] categories = request.getParameterValues("category");
        String minPrice = request.getParameter("min-price");
        String maxPrice = request.getParameter("max-price");
        String search = request.getParameter("search");
        String onlyBookmarked = request.getParameter("only-bookmarked");
        Member member = (Member) request.getSession().getAttribute("member");
        boolean filterBookmark = "on".equals(request.getParameter("only-bookmarked")) && member != null;

        List<String> conditions = new ArrayList<>();

        if (categories != null && categories.length > 0) {
            conditions.add("categoryId IN (" + String.join(",", categories) + ")");
        }

        if (minPrice != null && !minPrice.isEmpty()) {
            conditions.add("price >= " + minPrice);
        }

        if (maxPrice != null && !maxPrice.isEmpty()) {
            conditions.add("price <= " + maxPrice);
        }

        if (search != null && !search.isEmpty()) {
            conditions.add("name LIKE '%" + search + "%'");
        }

        // bookmark filter
        if (filterBookmark) {
            int memberId = member.getId();
            Bookmark bookmarkModel = new Bookmark();
            bookmarkModel.where("memberId = " + memberId);
            List<Bookmark> bookmarkList = bookmarkModel.get();

            List<String> bookmarkedProductIds = new ArrayList<>();
            for (Bookmark b : bookmarkList) {
                bookmarkedProductIds.add(String.valueOf(b.getProductId()));
            }

            if (!bookmarkedProductIds.isEmpty()) {
                conditions.add("id IN (" + String.join(",", bookmarkedProductIds) + ")");
            } else {
                // Kalau user ga punya bookmark, langsung kasih query yang hasilnya kosong
                conditions.add("1 = 0");
            }
        }

        if (!conditions.isEmpty()) {
            productModel.where(String.join(" AND ", conditions));
        }

        // Pass filter values back to the view to maintain state
        request.setAttribute("selectedCategories", categories != null ? java.util.Arrays.asList(categories) : new java.util.ArrayList<String>());
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("search", search);
        request.setAttribute("onlyBookmarked", filterBookmark);

        List<Product> products = productModel.get();
        request.setAttribute("products", products);

        ProductCategory categoryModel = new ProductCategory();
        List<ProductCategory> categoriesList = categoryModel.get();
        request.setAttribute("categories", categoriesList);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
