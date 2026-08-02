<div style="margin-bottom:1.5rem;">
    <h2 style="color:#0284c7; margin-bottom:.25rem;"><i class="fas fa-box"></i> {{modeTitle}}</h2>
    <p style="color:#64748b; margin:0;">Formulario de mantenimiento de productos inventariables mediSalud.</p>
</div>

<div class="card-box" style="max-width:800px; margin:0 auto;">
    <form action="index.php?page=Mnt_Producto" method="POST">
        <input type="hidden" name="mode" value="{{mode}}" />
        <input type="hidden" name="productId" value="{{productId}}" />

        <div class="row" style="gap:1rem;">
            <div style="flex:2; min-width:280px; margin-bottom:1rem;">
                <label for="productName">Nombre del Producto *</label>
                <input type="text" id="productName" name="productName" value="{{productName}}" {{if readonly}}disabled{{endif readonly}} placeholder="Ej: Acetaminofén 500mg" required />
                {{if errorName}}<div class="error">{{errorName}}</div>{{endif errorName}}
            </div>

            <div style="flex:1; min-width:200px; margin-bottom:1rem;">
                <label for="productCategory">Categoría</label>
                <select id="productCategory" name="productCategory" {{if readonly}}disabled{{endif readonly}}>
                    {{foreach categoryOptions}}
                    <option value="{{value}}" {{if selected}}selected{{endif selected}}>{{text}}</option>
                    {{endfor categoryOptions}}
                </select>
            </div>
        </div>

        <div style="margin-bottom:1rem;">
            <label for="productDescription">Descripción del Producto</label>
            <textarea id="productDescription" name="productDescription" rows="3" {{if readonly}}disabled{{endif readonly}} placeholder="Detalle médico, presentación y posología recomendada...">{{productDescription}}</textarea>
        </div>

        <div class="row" style="gap:1rem;">
            <div style="flex:1; min-width:180px; margin-bottom:1rem;">
                <label for="productPrice">Precio de Venta (Lps) *</label>
                <input type="number" step="0.01" id="productPrice" name="productPrice" value="{{productPrice}}" {{if readonly}}disabled{{endif readonly}} required />
                {{if errorPrice}}<div class="error">{{errorPrice}}</div>{{endif errorPrice}}
            </div>

            <div style="flex:1; min-width:180px; margin-bottom:1rem;">
                <label for="productStock">Existencia / Stock Inventariable *</label>
                <input type="number" id="productStock" name="productStock" value="{{productStock}}" {{if readonly}}disabled{{endif readonly}} required />
                {{if errorStock}}<div class="error">{{errorStock}}</div>{{endif errorStock}}
            </div>

            <div style="flex:1; min-width:180px; margin-bottom:1rem;">
                <label for="productStatus">Estado</label>
                <select id="productStatus" name="productStatus" {{if readonly}}disabled{{endif readonly}}>
                    {{foreach statusOptions}}
                    <option value="{{value}}" {{if selected}}selected{{endif selected}}>{{text}}</option>
                    {{endfor statusOptions}}
                </select>
            </div>
        </div>

        <div style="margin-bottom:1.5rem;">
            <label for="productImgUrl">URL de Imagen del Producto</label>
            <input type="url" id="productImgUrl" name="productImgUrl" value="{{productImgUrl}}" {{if readonly}}disabled{{endif readonly}} placeholder="https://..." />
        </div>

        <div style="display:flex; justify-content:space-between; align-items:center; border-top:1px solid #e2e8f0; padding-top:1.5rem;">
            <a href="index.php?page=Mnt_Productos" class="btn btn-outline">
                <i class="fas fa-arrow-left"></i> Cancelar / Regresar
            </a>

            {{if !readonly}}
            <button type="submit" class="btn btn-primary btn-lg">
                <i class="fas fa-save"></i> Guardar Producto
            </button>
            {{endif !readonly}}

            {{if showDelete}}
            <button type="submit" class="btn btn-danger btn-lg">
                <i class="fas fa-trash"></i> Confirmar Eliminación
            </button>
            {{endif showDelete}}
        </div>
    </form>
</div>
