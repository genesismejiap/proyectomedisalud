<div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem;">
    <div>
        <h2 style="color:#0284c7; margin:0 0 .25rem 0;"><i class="fas fa-boxes"></i> Gestión de Productos Farmacéuticos</h2>
        <p style="color:#64748b; margin:0;">Mantenimiento de inventario, precios y estados del catálogo mediSalud.</p>
    </div>
    <a href="index.php?page=Mnt_Producto&mode=INS" class="btn btn-primary">
        <i class="fas fa-plus-circle"></i> Nuevo Producto
    </a>
</div>

{{if hasProductos}}
<div class="card-box">
    <table class="medisalud-table">
        <thead>
            <tr>
                <th># ID</th>
                <th>Imagen</th>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Estado</th>
                <th style="text-align:right;">Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td>#{{productId}}</td>
                <td>
                    <img src="{{productImgUrl}}" alt="{{productName}}" style="width:45px; height:45px; object-fit:cover; border-radius:.5rem;" onerror="this.src='https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80';" />
                </td>
                <td>
                    <strong>{{productName}}</strong>
                    <div style="font-size:.8rem; color:#64748b; max-width:250px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">{{productDescription}}</div>
                </td>
                <td><span class="category-pill" style="font-size:.78rem; padding:.2rem .6rem;">{{productCategory}}</span></td>
                <td><strong>L. {{productPrice}}</strong></td>
                <td>
                    {{if productStock}}
                    <span class="product-stock-badge stock-ok">{{productStock}} unid.</span>
                    {{endif productStock}}
                    {{ifnot productStock}}
                    <span class="product-stock-badge stock-out">0 unid.</span>
                    {{endifnot productStock}}
                </td>
                <td>
                    <span class="product-stock-badge stock-ok">{{productStatus}}</span>
                </td>
                <td style="text-align:right;">
                    <div style="display:flex; justify-content:flex-end; gap:.35rem;">
                        <a href="index.php?page=Mnt_Producto&mode=DSP&id={{productId}}" class="btn btn-outline btn-sm" title="Ver Detalle">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="index.php?page=Mnt_Producto&mode=UPD&id={{productId}}" class="btn btn-primary btn-sm" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="index.php?page=Mnt_Producto&mode=DEL&id={{productId}}" class="btn btn-danger btn-sm" title="Eliminar">
                            <i class="fas fa-trash"></i>
                        </a>
                    </div>
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>
</div>
{{endif hasProductos}}
