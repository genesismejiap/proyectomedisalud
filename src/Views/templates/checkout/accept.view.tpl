{{if hasOrder}}
<div class="receipt-box">
    <div class="receipt-header">
        <i class="fas fa-check-circle"></i>
        <h2 style="color:#0f172a; margin:.5rem 0 .25rem 0;">¡Transacción Realizada con Éxito!</h2>
        <p style="color:#64748b; margin:0;">Gracias por tu compra en Farmacia <strong>mediSalud</strong>.</p>
    </div>

    {{with transaction}}
    <div style="background:#f8fafc; border-radius:1rem; padding:1.25rem; margin-bottom:1.5rem; text-align:left; border:1px solid #e2e8f0;">
        <div style="display:flex; justify-content:space-between; margin-bottom:.5rem;">
            <span style="color:#64748b;">Referencia de Transacción:</span>
            <strong style="color:#0284c7;">{{txnreference}}</strong>
        </div>
        <div style="display:flex; justify-content:space-between; margin-bottom:.5rem;">
            <span style="color:#64748b;">Fecha y Hora:</span>
            <strong>{{fecha_formateada}}</strong>
        </div>
        <div style="display:flex; justify-content:space-between; margin-bottom:.5rem;">
            <span style="color:#64748b;">Cliente:</span>
            <strong>{{username}} ({{useremail}})</strong>
        </div>
        <div style="display:flex; justify-content:space-between; margin-bottom:.5rem;">
            <span style="color:#64748b;">Método de Pago:</span>
            <span class="product-stock-badge stock-ok">{{txnpaymethod}}</span>
        </div>
        <div style="display:flex; justify-content:space-between;">
            <span style="color:#64748b;">Estado de Transacción:</span>
            <span class="product-stock-badge stock-ok"><i class="fas fa-check"></i> {{txnstt}}</span>
        </div>
    </div>
    {{endwith transaction}}

    <h4 style="text-align:left; color:#0f172a; margin-bottom:.5rem;"><i class="fas fa-box-open"></i> Resumen de Productos Comprados:</h4>
    <table class="medisalud-table" style="margin-bottom:1.5rem;">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Precio Un.</th>
                <th>Cant.</th>
                <th style="text-align:right;">Subtotal</th>
            </tr>
        </thead>
        <tbody>
            {{foreach details}}
            <tr>
                <td style="text-align:left;"><strong>{{prdname}}</strong></td>
                <td>L. {{prdprice}}</td>
                <td>{{prdctd}}</td>
                <td style="text-align:right;">L. {{prdsubtotal}}</td>
            </tr>
            {{endfor details}}
        </tbody>
    </table>

    {{with transaction}}
    <div style="background:#e0f2fe; border-radius:.75rem; padding:1rem; text-align:right; margin-bottom:1.5rem; font-size:1.1rem; color:#0369a1;">
        <div>Subtotal: <strong>L. {{txnamount}}</strong></div>
        <div>ISV (15%): <strong>L. {{txnisv}}</strong></div>
        <div style="font-size:1.3rem; font-weight:800; color:#0284c7; margin-top:.5rem;">Total Pagado: L. {{txntotal}}</div>
    </div>
    {{endwith transaction}}

    <div style="display:flex; justify-content:center; gap:1rem;">
        <a href="index.php?page=Transacciones_MisTransacciones" class="btn btn-primary">
            <i class="fas fa-history"></i> Ver en Mis Compras
        </a>
        <a href="index.php?page=Checkout_Catalogo" class="btn btn-outline">
            <i class="fas fa-shopping-bag"></i> Seguir Comprando
        </a>
    </div>
</div>
{{endif hasOrder}}

{{if !hasOrder}}
<div class="card-box" style="text-align:center; padding:3rem;">
    <i class="fas fa-exclamation-triangle" style="font-size:3.5rem; color:#ef4444; margin-bottom:1rem;"></i>
    <h3 style="color:#b91c1c;">No se encontró la transacción</h3>
    <p style="color:#64748b;">{{errorMessage}}</p>
    <a href="index.php?page=Checkout_Catalogo" class="btn btn-primary">Regresar al Catálogo</a>
</div>
{{endif !hasOrder}}
