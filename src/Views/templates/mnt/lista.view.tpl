<section>
    <h2>Gestión de Resultados WC 2026</h2>
</section>
<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Equipos</th>
                <th>Score</th>
                <th>Resumen</th>
                <th>
                    {{if RESULT_INS_MODE}}
                    <a href="index.php?page=Mnt-ResultForm&mode=INS">Crear</a>
                    {{endif RESULT_INS_MODE}}
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach resultados}}
            <tr>
                <td>{{equipo_a}} vrs {{equipo_b}}</td>
                <td>{{score_a}} -- {{score_b}}</td>
                <td>{{resumen}}</td>
                <td>
                    {{if ~RESULT_DSP_MODE}}
                    <a href="index.php?page=Mnt-ResultForm&mode=DSP&id={{id}}">Mostrar</a><br/>
                    {{endif ~RESULT_DSP_MODE}}
                    {{if ~RESULT_UPD_MODE}}
                    <a href="index.php?page=Mnt-ResultForm&mode=UPD&id={{id}}">Editar</a><br/>
                    {{endif ~RESULT_UPD_MODE}}
                    {{if ~RESULT_DEL_MODE}}
                    <a href="index.php?page=Mnt-ResultForm&mode=DEL&id={{id}}">Borrar</a>
                    {{endif ~RESULT_DEL_MODE}}
                </td>
            </tr>
            {{endfor resultados}}
        </tbody>
    </table>
</section>