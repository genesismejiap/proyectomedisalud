<section class="fullCenter">
  <form class="grid" method="post" action="index.php?page=sec_login{{if redirto}}&redirto={{redirto}}{{endif redirto}}">
    <section class="depth-1 row col-12 col-m-8 offset-m-2 col-xl-6 offset-xl-3" style="background:#0284c7; color:#ffffff; border-radius:1rem 1rem 0 0; padding:1.5rem;">
      <h1 class="col-12" style="color:#ffffff; margin:0; font-size:1.6rem;"><i class="fas fa-user-lock"></i> Iniciar Sesión - mediSalud</h1>
    </section>
    
    <section class="depth-1 py-4 row col-12 col-m-8 offset-m-2 col-xl-6 offset-xl-3" style="background:#ffffff; border-radius:0 0 1rem 1rem; border:1px solid #e2e8f0; padding:2rem;">
      
      <!-- CUADRO DE CREDENCIALES DEMO PARA DOCENTE -->
      <div class="col-12" style="background:#e0f2fe; border:1px solid #7dd3fc; border-radius:.75rem; padding:1rem; margin-bottom:1.5rem;">
        <strong style="color:#0369a1;"><i class="fas fa-key"></i> Credenciales de Prueba (Demostración Evaluador):</strong>
        <div style="font-size:.9rem; color:#0f172a; margin-top:.35rem;">
          <div>• <strong>Administrador:</strong> <code>admin@medisalud.com</code> | Pass: <code>P@ssword123</code></div>
          <div>• <strong>Cliente Demo:</strong> <code>cliente@medisalud.com</code> | Pass: <code>P@ssword123</code></div>
        </div>
      </div>

      <div class="row my-2" style="width:100%;">
        <label class="col-12 col-m-4 flex align-center" for="txtEmail" style="font-weight:700;">Correo Electrónico</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="email" id="txtEmail" name="txtEmail" value="{{txtEmail}}" placeholder="correo@ejemplo.com" required />
        </div>
        {{if errorEmail}}
          <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorEmail}}</div>
        {{endif errorEmail}}
      </div>

      <div class="row my-2" style="width:100%;">
        <label class="col-12 col-m-4 flex align-center" for="txtPswd" style="font-weight:700;">Contraseña</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="password" id="txtPswd" name="txtPswd" value="{{txtPswd}}" placeholder="••••••••" required />
        </div>
        {{if errorPswd}}
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorPswd}}</div>
        {{endif errorPswd}}
      </div>

      {{if generalError}}
      <div class="row my-2 col-12">
        <div class="error col-12" style="background:#fee2e2; border:1px solid #fca5a5; padding:.75rem; border-radius:.5rem; text-align:center;">{{generalError}}</div>
      </div>
      {{endif generalError}}

      <div class="row right flex-end px-4 my-3 col-12" style="justify-content:space-between; align-items:center;">
        <a href="index.php?page=Sec_Register" class="link">¿No tienes cuenta? Crear una</a>
        <button class="primary btn-primary" id="btnLogin" type="submit" style="padding:.75rem 1.5rem;">
          <i class="fas fa-sign-in-alt"></i> Ingresar
        </button>
      </div>
    </section>
  </form>
</section>
