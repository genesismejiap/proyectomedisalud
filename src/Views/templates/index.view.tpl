<div class="medisalud-hero">
    <h2><i class="fas fa-prescription-bottle-alt"></i> Bienvenid@ a Farmacia mediSalud</h2>
    <p>Tu farmacia de confianza con productos inventariables de primera calidad, atención farmacéutica garantizada y entrega rápida a domicilio.</p>
    <div style="display:flex; gap:1rem; flex-wrap:wrap;">
        <a href="#catalogo" class="btn btn-primary btn-lg">
            <i class="fas fa-capsules"></i> Ver Catálogo de Productos
        </a>
        {{ifnot isLogged}}
        <a href="index.php?page=Sec_Login" class="btn btn-outline" style="color:#ffffff; border-color:#ffffff;">
            <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
        </a>
        {{endifnot isLogged}}
    </div>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-pills"></i></div>
        <div>
            <div class="stat-val">100%</div>
            <div class="stat-lbl">Productos Garantizados</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-truck-med"></i></div>
        <div>
            <div class="stat-val">Envíos</div>
            <div class="stat-lbl">Entrega Rápida y Segura</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-user-shield"></i></div>
        <div>
            <div class="stat-val">Seguridad</div>
            <div class="stat-lbl">Transacciones Cifradas</div>
        </div>
    </div>
</div>



<div id="catalogo" style="margin-bottom:1.5rem; margin-top:2rem;">
    <h2 style="color:#0284c7; margin-bottom:.25rem; font-size: 2rem; font-weight: 800;"><i class="fas fa-prescription-bottle-alt"></i> Catálogo de Productos</h2>
    <p style="color:#64748b; margin:0; font-size: 1.1rem;">Medicamentos, suplementos y productos de cuidado personal en inventario.</p>
</div>

<div class="catalog-filter-bar">
    <form action="index.php" method="GET" class="search-box">
        <input type="hidden" name="page" value="Index" />
        <input type="text" name="search" placeholder="Buscar medicamento o producto..." value="{{searchQuery}}" style="flex:1;" />
        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <div class="category-pills">
        {{foreach categories}}
        <a href="index.php?page=Index&category={{categoryName}}#catalogo" class="category-pill {{if selected}}active{{endif selected}}">
            {{categoryName}}
        </a>
        {{endfor categories}}
    </div>
</div>

<div class="product-grid">
    {{foreach productos}}
    <div class="product-card">
        <div class="product-card-img-wrapper">
            <img src="{{productImgUrl}}" alt="{{productName}}" class="product-card-img" onerror="this.src='https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80';" />
            <span class="product-category-badge">{{productCategory}}</span>
        </div>
        <div class="product-card-body">
            <h3 class="product-title">{{productName}}</h3>
            <p class="product-description">{{productDescription}}</p>
            
            <div class="product-footer">
                <div>
                    <div class="product-price">L. {{productPrice}}</div>
                    {{if hasStock}}
                    <span class="product-stock-badge stock-ok"><i class="fas fa-check-circle"></i> {{productStock}} disp.</span>
                    {{endif hasStock}}
                    {{ifnot hasStock}}
                    <span class="product-stock-badge stock-out"><i class="fas fa-times-circle"></i> Agotado</span>
                    {{endifnot hasStock}}
                </div>

                {{if hasStock}}
                <form action="index.php?page=Cart_Cart" method="POST" style="margin:0;">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="productId" value="{{productId}}" />
                    <input type="hidden" name="quantity" value="1" />
                    <button type="submit" class="btn btn-primary btn-sm">
                        <i class="fas fa-cart-plus"></i> Agregar
                    </button>
                </form>
                {{endif hasStock}}
            </div>
        </div>
    </div>
    {{endfor productos}}
</div>