<atividade-tecnica-lista>
    <form onsubmit="{ onSearch }" ref="formulario">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Atividades Técnicas</div>
                    <div class="float-right">
                        <a href="{ url }/criar" class="btn btn-primary">Novo</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr class="bg-secondary">
                            <th style="width:110px;">Data</th>
                            <th>Local</th>
                            <th>Categoria</th>
                            <th>Atividade</th>
                            <th style="width:100px;"></th>
                        </tr>
                        <tr class="bg-secondary">
                            <th>
                                <input type="text" aria-label="Data" class="form-input" name="data_cadastro" maxlength="100" placeholder="Data" autocomplete="off">
                            </th>
                            <th>
                                <input type="text" aria-label="Local" class="form-input" name="local" maxlength="100" placeholder="Local" autocomplete="off">
                            </th>
                            <th>
                                <input type="text" aria-label="Categoria" class="form-input" name="categoria" maxlength="100" placeholder="Categoria" autocomplete="off">
                            </th>
                            <th>
                                <input type="text" aria-label="Atividade" class="form-input" name="atividade" maxlength="100" placeholder="Atividade" autocomplete="off">
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
                            <td>{ d.data_cadastro }</td>
                            <td>{ d.local.descricao }</td>
                            <td>{ d.acompanhamento_item.categoria.descricao }</td>
                            <td>{ d.acompanhamento_item.descricao }</td>
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
        tag.url = BASE_URL + '/atividade-tecnica'
        tag.grid = opts.grid || [];
        tag.loading = false;

        tag.mixin('ListagemMixin', {
            urlFetch: tag.url + '/buscar',

            callbackOnRequest: function (json) {
                tag.update({
                    'grid': json,
                    'loading': false
                });
            }
        });
    </script>
</atividade-tecnica-lista>