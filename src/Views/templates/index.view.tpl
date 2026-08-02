<div class="medisalud-hero">
    <h2><i class="fas fa-prescription-bottle-alt"></i> Bienvenid@ a Farmacia mediSalud</h2>
    <p>Tu farmacia de confianza con productos inventariables de primera calidad, atención farmacéutica garantizada y entrega rápida a domicilio.</p>
    <div style="display:flex; gap:1rem; flex-wrap:wrap;">
        <a href="index.php?page=Checkout_Catalogo" class="btn btn-primary btn-lg">
            <i class="fas fa-capsules"></i> Ver Catálogo de Productos
        </a>
        {{if !isLogged}}
        <a href="index.php?page=Sec_Login" class="btn btn-outline" style="color:#ffffff; border-color:#ffffff;">
            <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
        </a>
        {{endif !isLogged}}
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

<div class="card-box">
    <h3 style="margin-top:0; color:#0284c7;"><i class="fas fa-info-circle"></i> Acerca del Proyecto mediSalud</h3>
    <p>Este sistema e-commerce fue desarrollado bajo el patrón <strong>MVC (Model-View-Controller)</strong> con Programación Orientada a Objetos en PHP (framework <em>simplePHPMvcOop</em>).</p>
    <ul>
        <li><strong>Esquema de Seguridad:</strong> Autenticación de usuarios, roles (Admin/Cliente), permisos granulares y bitácora.</li>
        <li><strong>Catálogo Inventariable:</strong> Control dinámico de existencias en tiempo real.</li>
        <li><strong>Carretilla de Compra:</strong> Cálculo automático de totales con ISV (15%).</li>
        <li><strong>Pasarela de Pago:</strong> Simulación e integración Sandbox PayPal con registro automático de transacciones.</li>
        <li><strong>Histórico de Transacciones:</strong> Historial completo por cliente y panel administrativo de ventas.</li>
    </ul>
</div>