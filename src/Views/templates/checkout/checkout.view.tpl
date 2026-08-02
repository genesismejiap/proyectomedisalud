<div style="margin-bottom:1.5rem;">
    <h2 style="color:#0284c7; margin-bottom:.25rem;"><i class="fas fa-credit-card"></i> Pasarela de Pago mediSalud</h2>
    <p style="color:#64748b; margin:0;">Selecciona tu método de pago para completar la transacción.</p>
</div>

<div class="row" style="gap:1.5rem;">
    <div style="flex:1.5; min-width:300px;">
        <div class="card-box">
            <h3 style="margin-top:0; color:#0f172a; border-bottom:1px solid #e2e8f0; padding-bottom:.75rem;">
                <i class="fas fa-lock"></i> Selección de Método de Pago
            </h3>

            <form action="index.php?page=Checkout_Checkout" method="POST" id="paymentForm">
                <div style="margin-bottom:1.25rem;">
                    <label style="display:flex; align-items:center; gap:1rem; padding:1rem; border:2px solid #0284c7; border-radius:.75rem; background:#f0f9ff; cursor:pointer;">
                        <input type="radio" name="paymentMethod" value="PAYPAL_SANDBOX" checked style="width:auto;" />
                        <i class="fab fa-paypal" style="font-size:2rem; color:#003087;"></i>
                        <div>
                            <strong style="color:#0f172a; font-size:1.05rem;">PayPal Sandbox / Tarjeta Credit/Debit</strong>
                            <div style="font-size:.85rem; color:#64748b;">Simulación o procesamiento seguro mediante PayPal Sandbox</div>
                        </div>
                    </label>
                </div>

                <div style="margin-bottom:1.5rem;">
                    <label style="display:flex; align-items:center; gap:1rem; padding:1rem; border:1px solid #cbd5e1; border-radius:.75rem; background:#ffffff; cursor:pointer;">
                        <input type="radio" name="paymentMethod" value="EFECTIVO_CONTRAENTREGA" style="width:auto;" />
                        <i class="fas fa-money-bill-wave" style="font-size:1.8rem; color:#10b981;"></i>
                        <div>
                            <strong style="color:#0f172a; font-size:1.05rem;">Pago Contra Entrega (Efectivo / POS)</strong>
                            <div style="font-size:.85rem; color:#64748b;">Paga al recibir tus productos mediSalud en tu hogar</div>
                        </div>
                    </label>
                </div>

                <div style="background:#f8fafc; padding:1.25rem; border-radius:.75rem; border:1px solid #e2e8f0; margin-bottom:1.5rem;">
                    <h4 style="margin-top:0; color:#0369a1;"><i class="fas fa-shield-alt"></i> Garantía de Compra Segura</h4>
                    <p style="margin:0; font-size:.9rem; color:#475569;">Al confirmar el pago, la orden se registrará en el histórico de transacciones y el inventario de la farmacia será actualizado automáticamente.</p>
                </div>

                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <a href="index.php?page=Cart_Cart" class="btn btn-outline">
                        <i class="fas fa-arrow-left"></i> Volver al Carrito
                    </a>
                    <button type="submit" class="btn btn-success btn-lg" style="padding:.9rem 2rem; font-size:1.1rem;">
                        <i class="fas fa-check-circle"></i> Confirmar y Pagar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div style="flex:1; min-width:280px;">
        <div class="summary-card">
            <h3 style="margin-top:0; color:#0f172a; border-bottom:1px solid #bae6fd; padding-bottom:.75rem;">
                <i class="fas fa-list-alt"></i> Detalle de la Orden
            </h3>

            {{with cart}}
            {{foreach items}}
            <div style="display:flex; justify-content:space-between; align-items:center; padding:.5rem 0; border-bottom:1px solid #e0f2fe;">
                <div>
                    <strong style="color:#0f172a; font-size:.95rem;">{{productName}}</strong>
                    <div style="font-size:.8rem; color:#64748b;">{{crrctd}} x L. {{crrprc}}</div>
                </div>
                <span style="font-weight:700; color:#0284c7;">L. {{subtotal}}</span>
            </div>
            {{endfor items}}

            <div style="margin-top:1rem;">
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <strong>L. {{subtotal}}</strong>
                </div>
                <div class="summary-row">
                    <span>ISV (15%):</span>
                    <strong>L. {{isv}}</strong>
                </div>
                <div class="summary-total">
                    <span>Total Final:</span>
                    <span>L. {{total}}</span>
                </div>
            </div>
            {{endwith cart}}
        </div>
    </div>
</div>
