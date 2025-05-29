        const searchInput = document.getElementById('searchInput');
        const productsList = document.getElementById('productsList');
        const noResults = document.getElementById('noResults');
        const productCount = document.getElementById('productCount');
        const productItems = document.querySelectorAll('.product-item');

        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            let visibleProducts = 0;

            productItems.forEach(item => {
                const productName = item.getAttribute('data-name').toLowerCase();
                const productCategory = item.getAttribute('data-category').toLowerCase();
                const productDescription = item.querySelector('.product-description').textContent.toLowerCase();

                if (productName.includes(searchTerm) || 
                    productCategory.includes(searchTerm) || 
                    productDescription.includes(searchTerm)) {
                    item.style.display = 'flex';
                    visibleProducts++;
                } else {
                    item.style.display = 'none';
                }
            });

            // Update product count
            if (visibleProducts === 0 && searchTerm !== '') {
                noResults.classList.add('show');
                productsList.style.display = 'none';
                productCount.style.display = 'none';
            } else {
                noResults.classList.remove('show');
                productsList.style.display = 'block';
                productCount.style.display = 'block';
                productCount.textContent = `${visibleProducts} producto${visibleProducts !== 1 ? 's' : ''} encontrado${visibleProducts !== 1 ? 's' : ''}`;
            }
        });

        function requestProduct(productName) {
            alert(`Solicitud enviada para: ${productName}\n\n¡Gracias por tu interés! Te contactaremos pronto.`);
        }

        // Initialize product count
        productCount.textContent = `${productItems.length} productos encontrados`;