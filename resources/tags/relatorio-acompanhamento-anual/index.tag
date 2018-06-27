<relatorio-acompanhamento-anual>

    <div class="card">
        <div class="card-header">
            <div class="card-title h3">
                <div class="float-left">Estátistica Acompanhamento Anual</div>
                <div class="float-right">
                    <a href="" class="btn btn-primary">Imprimir</a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="container">
                <form onsubmit="{ onSearch }" ref="formulario" class="form-inline">
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.descricao ? 'has-error' : '' }">
                                <label class="form-label" for="descricao">Ano</label>
                                <input type="text" name="ano" maxlength="4" value="{ dados.ano }" class="form-input" required>
                                <div class="form-input-hint" if="{ errors.ano }" each="{ e in errors.ano }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-6 col-md-12">
                            <div class="form-group { errors.descricao ? 'has-error' : '' }">
                                <form-select-locais-sessao required errors="{ errors.fk_local }" name="fk_local" val="{ dados.fk_local }"></form-select-locais-sessao>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <button type="submit" class="btn btn-primary" style="margin-top:30px">Pesquisar</button>
                        </div>
                    </div>
                </form>
            </div>
            <span if="{ grid && grid.length <= 0 }">
                Use o filtro para pesquisar.
            </span>

            <table show="{ grid && grid.length > 0 }" class="table">
                <tbody each="{ g in grid }">
                    {console.log(g)}
                    <tr class="bg-dark">
                        <th>{ g.descricao }</th>
                        <th>Jan</th>
                        <th>Fev</th>
                        <th>Mar</th>
                        <th>Abr</th>
                        <th>Mai</th>
                        <th>Jun</th>
                        <th>Jul</th>
                        <th>Ago</th>
                        <th>Set</th>
                        <th>Out</th>
                        <th>Nov</th>
                        <th>Dez</th>
                        <th>Total</th>
                    </tr>
                    <tr each="{ d in g.acompanhamento_item }">
                        <td>{ d.item }</td>
                        <td>
                            <span class="{ d.mes_1 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_1 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_2 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_2 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_3 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_3 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_4 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_4 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_5 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_5 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_6 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_6 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_7 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_7 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_8 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_8 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_9 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_9 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_10 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_10 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_11 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_11 }</span>
                        </td>
                        <td>
                            <span class="{ d.mes_12 == 0 ? 'text-gray' : 'text-dark' }">{ d.mes_12 }</span>
                        </td>
                        <td>
                            <b class="{ d.total_anual == 0 ? 'text-gray' : 'text-dark' }">{ d.total_anual }</b>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        var tag = this;
        tag.url = BASE_URL + '/relatorio-acompanhamento-anual'
        tag.grid = opts.grid || [];
        tag.loading = false;
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.session = APP.getSessiononSubmit
        tag.onSearch = onSearch;

        tag.mixin('ListagemMixin', {
            urlFetch: tag.url + '/buscar',
            callbackBeforeRequest: function(){
                tag.update({'loading': true});
                return true;
            }
        });

        function onSearch(event) {
            event.preventDefault();
            var form = event.target;
            var data = Serialize.toJson(form);

            Request.post(tag.url + '/buscar/', JSON.stringify(data),
                function (json) {
                    console.log(json);
                });
        }
    </script>
</relatorio-acompanhamento-anual>