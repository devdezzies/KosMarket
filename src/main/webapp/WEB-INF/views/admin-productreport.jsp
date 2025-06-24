<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.kosmarket.models.ProductReport" %>
<%@ page import="com.kosmarket.models.Product" %>
<%@ page import="com.kosmarket.models.Member" %>
<%@ page import="java.util.ArrayList" %>

<div class="p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Product Report Management</h2>

    <!-- Reports List -->
    <div class="bg-white" id="reports-list">
        <div class="p-4">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-semibold text-gray-800" id="reports-title">
                    <i class="fas fa-flag mr-2"></i>Active Product Reports
                </h3>
                <!-- Display total reports count -->
                <div class="text-sm text-gray-600">
                    <span class="font-medium">Total Reports : </span>
                    <span class="text-indigo-600 font-semibold">
                        <%
                            ArrayList<ProductReport> reports = (ArrayList<ProductReport>) request.getAttribute("reports");
                            out.print(reports != null ? reports.size() : 0);
                        %>
                    </span>
                </div>
            </div>

            <!-- Report Cards -->
            <div id="report-cards" class="space-y-3">
                <%
                    if (reports != null && !reports.isEmpty()) {
                        for (ProductReport report : reports) {
                            Product product = report.getProduct();
                            Member reporter = report.getReporter();
                %>
                <div class="bg-red-100 rounded-2xl p-4 report-card">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <!-- Report Avatar -->
                            <div class="w-12 h-12 bg-red-300 rounded-full flex items-center justify-center">
                                <i class="fas fa-flag text-red-600 text-lg"></i>
                            </div>
                            <!-- Report Info -->
                            <div class="report-info">
                                <h3 class="font-semibold text-gray-800 flex items-center space-x-2">
                                    <span><%= product != null ? product.getName() : "Unknown Product" %> (ID Product : <%= report.getProductId() %>)</span>
                                </h3>
                                <p class="text-xs text-blue-500">
                                    <strong>Report ID : <%= report.getId() %></strong>
                                </p>
                                <p class="text-sm text-gray-600">
                                    Reported by : <%= reporter != null ? reporter.getName() : "Unknown" %> (ID: <%= report.getReporterId() %>)
                                </p>
                                <p class="text-sm text-gray-600">
                                    Reason : <span class="font-medium text-red-700"><%= report.getReason() %></span>
                                </p>
                                <p class="text-xs text-gray-500">
                                    Reported at : <%= report.getCreatedAt() %>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Action Buttons -->
                    <div class="flex justify-end space-x-2 p-1 mt-3">
                        <!-- Form Delete Report -->
                        <form action="${pageContext.request.contextPath}/admin" method="post" 
                              onsubmit="return confirm('Are you sure you want to delete this report?')" 
                              style="display: inline;">
                            <input type="hidden" name="action" value="deleteProductReport">
                            <input type="hidden" name="id" value="<%= report.getId() %>">
                            <button type="submit" 
                                    class="px-3 py-2 bg-red-600 text-white text-sm rounded-2xl hover:bg-red-700 transition">
                                <i class="fas fa-trash mr-1"></i>Delete Report (ID: <%= report.getId() %>)
                            </button>
                        </form>
                        
                        <!-- Form Delete Product -->
                        <%-- <form action="${pageContext.request.contextPath}/admin" method="post" 
                              onsubmit="return confirm('Are you sure you want to delete this product?')" 
                              style="display: inline;">
                            <input type="hidden" name="action" value="deleteProduct">
                            <input type="hidden" name="id" value="<%= product != null ? product.getId() : "" %>">
                            <button type="submit" 
                                    class="px-3 py-2 bg-yellow-600 text-white text-sm rounded-2xl hover:bg-yellow-700 transition">
                                <i class="fas fa-trash-alt mr-1"></i>Delete Product
                            </button>
                        </form> --%>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="text-center py-8">
                    <i class="fas fa-flag text-gray-400 text-4xl mb-3"></i>
                    <h4 class="text-lg font-semibold text-gray-700 mb-2">No Product Reports Found</h4>
                    <p class="text-gray-500">No product reports are registered in the system.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<!-- Report Detail Modal (optional, mirip modal kategori) -->
<div id="report-detail-modal" class="hidden fixed inset-0 bg-gray-200 bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-3xl p-6 w-full max-w-md mx-4 shadow-2xl">
        <div class="text-center">
            <div id="report-detail-content">
                <!-- Isi detail report akan diisi via JS -->
            </div>
            <div id="modal-buttons" class="flex justify-center space-x-3 mt-6">
                <!-- Tombol aksi -->
            </div>
            <button onclick="hideReportDetailModal()" 
                    class="mt-4 w-full px-6 py-2 bg-gray-300 text-gray-700 rounded-2xl hover:bg-gray-400 transition font-medium">
                Close
            </button>
        </div>
    </div>
</div>

<script>
function showReportDetailModal(reportId) {
    // Ambil data dari DOM atau AJAX jika perlu
    const card = document.querySelector(`.report-card[data-report-id='${reportId}']`);
    if (!card) return;
    const info = card.querySelector('.report-info').innerHTML;
    document.getElementById('report-detail-content').innerHTML = info;
    document.getElementById('modal-buttons').innerHTML = 
        `<button onclick="deleteReport('${reportId}')" class="flex-1 px-4 py-2 bg-red-600 text-white rounded-2xl hover:bg-red-700 transition font-medium">
            <i class="fas fa-trash mr-2"></i>Delete Report
        </button>`;
    document.getElementById('report-detail-modal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}
function hideReportDetailModal() {
    document.getElementById('report-detail-modal').classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
}
function deleteReport(reportId) {
    console.log("DEBUG: Report ID received:", reportId); // Debug log
    if (!reportId || reportId === 'null' || reportId === '0') {
        alert("Error: Report ID is invalid or missing!");
        return;
    }
    
    if (confirm('Are you sure you want to delete this report?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin';
        form.innerHTML = `
            <input type="hidden" name="action" value="deleteProductReport">
            <input type="hidden" name="id" value="${reportId}">
        `;
        document.body.appendChild(form);
        form.submit();
    }
}
</script>