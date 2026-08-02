<div style="margin-bottom:1.5rem;">
    <h2 style="color:#0284c7; margin-bottom:.25rem;"><i class="fas fa-shopping-cart"></i> Carretilla de Compra</h2>
    <p style="color:#64748b; margin:0;">Revisa los productos seleccionados antes de proceder al pago.</p>
</div>

{{if hasItems}}
<div class="row" style="gap:1.5rem;">
    <div style="flex:2; min-width:300px;">
        <div class="card-box">
            <table class="medisalud-table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th style="text-align:center;">Cantidad</th>
                        <th>Subtotal</th>
                        <th style="text-align:right;">Acción</th>
                    </tr>
                </thead>
                <tbody>
                    {{foreach items}}
                    <tr>
                        <td>
                            <div style="display:flex; align-items:center; gap:1rem;">
                                <img src="{{productImgUrl}}" alt="{{productName}}" style="width:50px; height:50px; object-fit:cover; border-radius:.5rem;" />
                                <div>
                                    <strong style="color:#0f172a;">{{productName}}</strong>
                                    <div style="font-size:.8rem; color:#64748b;">Cat: {{productCategory}}</div>
                                </div>
                            </div>
                        </td>
                        <td>L. {{crrprc}}</td>
                        <td style="text-align:center;">
                            <form action="index.php?page=Cart_Cart" method="POST" style="display:inline-flex; align-items:center; gap:.25rem; margin:0;">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="productId" value="{{productId}}" />
                                <input type="number" name="quantity" value="{{crrctd}}" min="1" max="{{productStock}}" style="width:70px; padding:.4rem; text-align:center;" onchange="this.form.submit();" />
                            </form>
                        </td>
                        <td><strong>L. {{subtotal}}</strong></td>
                        <td style="text-align:right;">
                            <form action="index.php?page=Cart_Cart" method="POST" style="margin:0;">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="productId" value="{{productId}}" />
                                <button type="submit" class="btn btn-danger btn-sm" title="Eliminar">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    {{endfor items}}
                </tbody>
            </table>

            <div style="margin-top:1.5rem; display:flex; justify-content:space-between; align-items:center;">
                <a href="index.php?page=Checkout_Catalogo" class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Seguir Comprando
                </a>
                <form action="index.php?page=Cart_Cart" method="POST" style="margin:0;">
                    <input type="hidden" name="action" value="clear" />
                    <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fas fa-broom"></i> Vaciar Carretilla
                    </button>
                </form>
            </div>
        </div>
    </div>

    <div style="flex:1; min-width:280px;">
        <div class="summary-card">
            <h3 style="margin-top:0; color:#0f172a; border-bottom:1px solid #bae6fd; padding-bottom:.75rem;">
                <i class="fas fa-receipt"></i> Resumen del Pedido
            </h3>
            
            <div class="summary-row">
                <span>Cant. de Productos:</span>
                <strong>{{itemCount}} ítems</strong>
            </div>
            <div class="summary-row">
                <span>Subtotal:</span>
                <strong>L. {{subtotal}}</strong>
            </div>
            <div class="summary-row">
                <span>ISV (15%):</span>
                <strong>L. {{isv}}</strong>
            </div>
            <div class="summary-total">
                <span>Total a Pagar:</span>
                <span>L. {{total}}</span>
            </div>

            <div style="margin-top:1.5rem;">
                <a href="index.php?page=Checkout_Checkout" class="btn btn-success" style="width:100%; font-size:1.1rem; padding:1rem;">
                    <i class="fas fa-credit-card"></i> Proceder al Pago
                </a>
            </div>
        </div>
    </div>
</div>
{{endif hasItems}}

{{if !hasItems}}
<div class="card-box" style="text-align:center; padding:3rem 1.5rem;">
    <i class="fas fa-shopping-cart" style="font-size:4rem; color:#cbd5e1; margin-bottom:1rem;"></i>
    <h3 style="color:#475569; margin-bottom:.5rem;">Tu carretilla está vacía</h3>
    <p style="color:#64748b; margin-bottom:1.5rem;">Añade medicamentos o productos de nuestro catálogo para comenzar tu compra.</p>
    <a href="index.php?page=Checkout_Catalogo" class="btn btn-primary">
        <i class="fas fa-capsules"></i> Ir al Catálogo de Productos
    </a>
</div>
{{endif !hasItems}}
