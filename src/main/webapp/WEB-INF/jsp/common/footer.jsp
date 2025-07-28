                </div>
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer mt-auto">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0 text-muted">
                        &copy; 2024 Car Rental Management System. All rights reserved.
                    </p>
                </div>
                <div class="col-md-6 text-end">
                    <p class="mb-0 text-muted">
                        Version 1.0 | 
                        <a href="#" class="text-decoration-none">Support</a> | 
                        <a href="#" class="text-decoration-none">Documentation</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
    <script src="/webjars/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Auto-hide alerts after 5 seconds
        $(document).ready(function() {
            setTimeout(function() {
                $('.alert').fadeOut('slow');
            }, 5000);
        });

        // Confirmation dialogs for delete actions
        function confirmDelete(message) {
            return confirm(message || 'Are you sure you want to delete this item?');
        }

        // Form validation helper
        function validateForm(formId) {
            var form = document.getElementById(formId);
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
            return form.checkValidity();
        }

        // Date validation helper removed as per requirements

        // Search form auto-submit with debounce
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        // Initialize search functionality
        $(document).ready(function() {
            const searchInput = $('#searchInput');
            if (searchInput.length) {
                const debouncedSearch = debounce(function() {
                    $('#searchForm').submit();
                }, 500);
                
                searchInput.on('input', debouncedSearch);
            }
        });

        // Initialize tooltips
        $(document).ready(function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });

        // Initialize popovers
        $(document).ready(function() {
            var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                return new bootstrap.Popover(popoverTriggerEl);
            });
        });

        // Format currency
        function formatCurrency(amount) {
            return '₹' + new Intl.NumberFormat('en-IN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(amount);
        }

        // Format date
        function formatDate(dateString) {
            return new Date(dateString).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        }

        // Print functionality
        function printPage() {
            window.print();
        }

        // Export functionality (placeholder)
        function exportData(format) {
            alert('Export to ' + format + ' functionality will be implemented');
        }
    </script>

    <!-- Page-specific JavaScript -->
    <c:if test="${not empty pageScript}">
        <script>
            ${pageScript}
        </script>
    </c:if>

</body>
</html>
