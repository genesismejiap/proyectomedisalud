<section class="container-m px-4 py-5">
  {{if hasOrder}}
  <div class="row fullCenter">
    <div class="col-12 col-m-8 col-l-6">
      <div class="card depth-2" style="border-radius: 12px; overflow: hidden; background-color: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
        <div style="background-color: #28a745; color: white; padding: 2rem; text-align: center;">
          <svg style="width: 64px; height: 64px; margin-bottom: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <h1 style="margin: 0; font-size: 1.8rem; font-weight: 600;">¡Pago Completado!</h1>
          <p style="margin-top: 0.5rem; opacity: 0.9;">Tu orden ha sido procesada con éxito.</p>
        </div>
        
        <div class="px-4 py-4" style="background-color: #f8f9fa;">
          <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #e9ecef; padding-bottom: 1rem; margin-bottom: 1rem;">
            <div>
              <span style="display: block; color: #6c757d; font-size: 0.85rem; text-transform: uppercase; font-weight: 600;">Número de Orden</span>
              <strong style="font-size: 1.1rem; color: #343a40;">{{orderId}}</strong>
            </div>
            <div style="text-align: right;">
              <span style="display: block; color: #6c757d; font-size: 0.85rem; text-transform: uppercase; font-weight: 600;">Estado</span>
              <span style="display: inline-block; background-color: #d4edda; color: #155724; padding: 0.25rem 0.75rem; border-radius: 50px; font-weight: 600; font-size: 0.85rem;">{{status}}</span>
            </div>
          </div>

          <h3 style="color: #495057; font-size: 1.1rem; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">Detalles del Cliente</h3>
          <div style="margin-bottom: 1.5rem;">
            <p style="margin: 0 0 0.5rem 0;"><strong>Nombre:</strong> {{payerName}}</p>
            <p style="margin: 0 0 0.5rem 0;"><strong>Correo Electrónico:</strong> {{payerEmail}}</p>
          </div>

          <h3 style="color: #495057; font-size: 1.1rem; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">Dirección de Envío</h3>
          <div style="margin-bottom: 1.5rem;">
            <p style="margin: 0 0 0.5rem 0;"><strong>Destinatario:</strong> {{shippingName}}</p>
            <p style="margin: 0 0 0.5rem 0;"><strong>Dirección:</strong> {{shippingAddress}}</p>
            <p style="margin: 0 0 0.5rem 0;"><strong>País:</strong> {{country}}</p>
          </div>
          
        </div>
        
        <div style="padding: 1.5rem; text-align: center; background-color: #fff; border-top: 1px solid #e9ecef;">
          <a href="index.php?page=index" class="btn" style="display: inline-block; background-color: #007bff; color: white; padding: 0.75rem 2rem; border-radius: 50px; text-decoration: none; font-weight: 600; transition: background-color 0.2s;">Volver al Inicio</a>
        </div>
      </div>
    </div>
  </div>
  {{endif hasOrder}}

  {{ifnot hasOrder}}
  <div class="row fullCenter">
    <div class="col-12 col-m-8 col-l-6">
       <div class="card depth-2" style="border-radius: 12px; overflow: hidden; background-color: #fff; text-align: center; padding: 3rem 2rem;">
         <svg style="width: 64px; height: 64px; color: #dc3545; margin-bottom: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <h2 style="color: #343a40; margin-bottom: 1rem;">No se encontró información</h2>
          <p style="color: #6c757d; margin-bottom: 2rem;">No hay detalles de orden disponibles o la sesión ha expirado.</p>
          <a href="index.php?page=index" style="display: inline-block; background-color: #6c757d; color: white; padding: 0.75rem 2rem; border-radius: 50px; text-decoration: none; font-weight: 600;">Volver al Inicio</a>
       </div>
    </div>
  </div>
  {{endifnot hasOrder}}
</section>