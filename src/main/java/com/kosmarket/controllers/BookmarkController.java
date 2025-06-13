package com.kosmarket.controllers;

import com.kosmarket.models.Bookmark;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import com.kosmarket.models.Member;

@WebServlet(name = "BookmarkControllerServlet", urlPatterns = "/bookmark")
public class BookmarkController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");
        int memberId = member.getId();
        String productIdParam = request.getParameter("productId");

        try {
            int productId = Integer.parseInt(productIdParam);
            Bookmark bookmarkModel = new Bookmark();

            switch (action) {
                case "add":
                    if (!bookmarkModel.isBookmarked(memberId, productId)) {
                        bookmarkModel.addBookmark(memberId, productId);
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true, \"message\": \"Bookmark added\", \"action\": \"added\"}");
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"Already bookmarked\"}");
                    }
                    break;
                case "remove":
                    if (bookmarkModel.isBookmarked(memberId, productId)) {
                        bookmarkModel.removeBookmark(memberId, productId);
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true, \"message\": \"Bookmark removed\", \"action\": \"removed\"}");
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"Bookmark not found\"}");
                    }
                    break;
                case "toggle":
                    boolean isBookmarked = bookmarkModel.isBookmarked(memberId, productId);
                    if (isBookmarked) {
                        bookmarkModel.removeBookmark(memberId, productId);
                        response.getWriter().write("{\"success\": true, \"message\": \"Bookmark removed\", \"action\": \"removed\", \"isBookmarked\": false}");
                    } else {
                        bookmarkModel.addBookmark(memberId, productId);
                        response.getWriter().write("{\"success\": true, \"message\": \"Bookmark added\", \"action\": \"added\", \"isBookmarked\": true}");
                    }
                    response.setContentType("application/json");
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    break;
            }
        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid product ID format: " + productIdParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
}
