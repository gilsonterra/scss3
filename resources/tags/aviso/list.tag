<aviso-list>
    <form onsubmit="{ onSearch }" ref="formulario">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Avisos</div>
                    <div class="float-right">
                        <a href="{ url }/criar" class="btn btn-primary">Novo</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr class="bg-secondary">
                            <th style="width:110px;">Status</th>
                            <th>Aviso</th>
                            <th style="width:100px;"></th>
                        </tr>
                        <tr class="bg-secondary">
                            <th>
                                <select name="status" class="form-select">
                                    <option value="1">Ativo</option>
                                    <option value="0">Inativo</option>
                                </select>
                            </th>
                            <th>
                                <input type="text" class="form-input" name="aviso" maxlength="100" placeholder="Aviso">
                            </th>
                            <th>
                                <button type="submit" class="btn btn-secondary">
                                    <i class="icon icon-search"></i>
                                    Filtrar
                                </button>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each="{ d in grid.data }">
                            <td>
                                <span if="{ d.status == 1 }" class="text-success">Ativo</span>
                                <span if="{ d.status == 0 }" class="text-error">Inativo</span>
                            </td>
                            <td>
                                <raw html="{ d.aviso }"></raw>
                            </td>
                            <td>
                                <a href="{ url }/editar/{ d.codigo }" class="btn btn-link">Alterar</a>
                            </td>
                        </tr>
                        <tr if="{ grid.data.length == 0 }">
                            <td colspan="4">Nenhum registro encontrado.</td>
                        </tr>
                        <tr if="{ loading }">
                            <td colspan="4">
                                <div class="loading loading-lg"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <pagination grid="{ grid }" next="{ onNext }" prev="{ onPrev }"></pagination>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/aviso'
        tag.grid = opts.grid || [];
        tag.loading = false;

        tag.mixin('ListagemMixin', {
            urlFetch: tag.url + '/buscar',
        });
    </script>
</aviso-list>