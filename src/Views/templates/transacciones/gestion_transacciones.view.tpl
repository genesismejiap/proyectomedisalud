<div style="margin-bottom:1.5rem;">
    <h2 style="color:#0284c7; margin-bottom:.25rem;"><i class="fas fa-file-invoice-dollar"></i> Gestión Global de Transacciones (Administrador)</h2>
    <p style="color:#64748b; margin:0;">Panel administrativo de auditoría de ventas e histórico general de compras.</p>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon" style="background:#dcfce7; color:#16a34a;"><i class="fas fa-money-bill-wave"></i></div>
        <div>
            <div class="stat-val">L. {{totalVentas}}</div>
            <div class="stat-lbl">Ventas Totales Registradas</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:#e0f2fe; color:#0284c7;"><i class="fas fa-shopping-bag"></i></div>
        <div>
            <div class="stat-val">{{totalTransacciones}}</div>
            <div class="stat-lbl">Transacciones Realizadas</div>
        </div>
    </div>
</div>

{{if hasTransacciones}}
<div class="card-box">
    <table class="medisalud-table">
        <thead>
            <tr>
                <th># ID</th>
                <th>Referencia</th>
                <th>Cliente / Usuario</th>
                <th>Fecha</th>
                <th>Método</th>
                <th>ISV</th>
                <th>Total</th>
                <th>Estado</th>
                <th style="text-align:right;">Acción</th>
            </tr>
        </thead>
        <tbody>
            {{foreach transacciones}}
            <tr>
                <td>#{{txnid}}</td>
                <td><strong style="color:#0284c7;">{{txnreference}}</strong></td>
                <td>
                    <strong>{{username}}</strong>
                    <div style="font-size:.8rem; color:#64748b;">{{useremail}}</div>
                </td>
                <td>{{fecha_formateada}}</td>
                <td><span class="product-stock-badge stock-ok">{{txnpaymethod}}</span></td>
                <td>L. {{txnisv}}</td>
                <td><strong style="color:#16a34a;">L. {{txntotal}}</strong></td>
                <td><span class="product-stock-badge stock-ok"><i class="fas fa-check"></i> {{txnstt}}</span></td>
                <td style="text-align:right;">
                    <a href="index.php?page=Transacciones_GestionTransacciones&txnid={{txnid}}" class="btn btn-outline btn-sm">
                        <i class="fas fa-search"></i> Ver Detalle
                    </a>
                </td>
            </tr>
            {{endfor transacciones}}
        </tbody>
    </table>
</div>
{{endif hasTransacciones}}

{{if hasSelected}}
<div style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(15,23,42,0.6); display:flex; align-items:center; justify-content:center; z-index:9999; backdrop-filter:blur(4px);">
    <div style="background:#ffffff; width:90%; max-width:650px; border-radius:1.5rem; padding:2rem; max-height:90vh; overflow-y:auto; box-shadow:0 20px 40px rgba(0,0,0,0.2);">
        <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #e2e8f0; padding-bottom:1rem; margin-bottom:1rem;">
            <h3 style="margin:0; color:#0284c7;"><i class="fas fa-receipt"></i> Auditoría de Transacción #{{selectedTxn.txnid}}</h3>
            <a href="index.php?page=Transacciones_GestionTransacciones" style="font-size:1.5rem; color:#64748b; text-decoration:none;">&times;</a>
        </div>

        {{with selectedTxn}}
        <div style="background:#f8fafc; padding:1rem; border-radius:.75rem; margin-bottom:1rem; font-size:.9rem; border:1px solid #e2e8f0;">
            <div><strong>Referencia:</strong> {{txnreference}}</div>
            <div><strong>Cliente:</strong> {{username}} ({{useremail}}) - ID: {{usercod}}</div>
            <div><strong>Fecha:</strong> {{fecha_formateada}}</div>
            <div><strong>Método de Pago:</strong> {{txnpaymethod}}</div>
            <div><strong>Estado:</strong> <span class="product-stock-badge stock-ok">{{txnstt}}</span></div>
        </div>
        {{endwith selectedTxn}}

        <h4 style="margin-bottom:.5rem; color:#0f172a;">Desglose de Ítems:</h4>
        <table class="medisalud-table" style="margin-bottom:1rem;">
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th>Cant.</th>
                    <th style="text-align:right;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                {{foreach selectedDetails}}
                <tr>
                    <td>{{prdname}}</td>
                    <td>L. {{prdprice}}</td>
                    <td>{{prdctd}}</td>
                    <td style="text-align:right;">L. {{prdsubtotal}}</td>
                </tr>
                {{endfor selectedDetails}}
            </tbody>
        </table>

        {{with selectedTxn}}
        <div style="text-align:right; font-size:1.1rem; color:#0369a1; padding-top:.5rem; border-top:2px solid #e2e8f0;">
            <div>Monto Neto: L. {{txnamount}}</div>
            <div>Impuesto ISV (15%): L. {{txnisv}}</div>
            <div style="font-size:1.3rem; font-weight:800; color:#0284c7; margin-top:.25rem;">Monto Total: L. {{txntotal}}</div>
        </div>
        {{endwith selectedTxn}}

        <div style="margin-top:1.5rem; text-align:right;">
            <a href="index.php?page=Transacciones_GestionTransacciones" class="btn btn-primary">Cerrar</a>
        </div>
    </div>
</div>
{{endif hasSelected}}
