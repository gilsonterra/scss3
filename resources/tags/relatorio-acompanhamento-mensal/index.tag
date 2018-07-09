<relatorio-acompanhamento-mensal>

    <div class="card">
        <div class="card-header">
            <div class="card-title h3">
                <div class="float-left">Estátistica Acompanhamento Mensal</div>
                <div class="float-right">
                    <button type="button" class="btn btn-primary" onclick="window.print();">
                        Imprimir
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="container">
                <form onsubmit="{ onSearch }" ref="formulario" class="form-inline">
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.ano ? 'has-error' : '' }">
                                <label class="form-label" for="ano">Ano</label>
                                <input type="text" id="ano" placeholder="AAAA" name="ano" maxlength="4" value="{ dados.ano }" class="form-input" required>
                                <div class="form-input-hint" if="{ errors.ano }" each="{ e in errors.ano }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.mes ? 'has-error' : '' }">
                                <label class="form-label" for="mes">Mês</label>
                                <select name="mes" id="mes" class="form-select" required>
                                    <option value=""></option>
                                    <option value="1">Janeiro</option>
                                    <option value="2">Fevereiro</option>
                                    <option value="3">Março</option>
                                    <option value="4">Abril</option>
                                    <option value="5">Maio</option>
                                    <option value="6">Junho</option>
                                    <option value="7">Julho</option>
                                    <option value="8">Agosto</option>
                                    <option value="9">Setembro</option>
                                    <option value="10">Outubro</option>
                                    <option value="11">Novembro</option>
                                    <option value="12">Dezembro</option>
                                </select>
                                <div class="form-input-hint" if="{ errors.mes }" each="{ e in errors.mes }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.descricao ? 'has-error' : '' }">
                                <form-select-locais-sessao required errors="{ errors.fk_local }" name="fk_local" val="{ dados.fk_local }"></form-select-locais-sessao>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <button type="submit" class="btn btn-secondary" style="margin-top:31px">
                                <i class="icon icon-search"></i>
                                Pesquisar
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="container" if="{ grid && grid.length <= 0 }">
                Use o filtro para pesquisar.
            </div>

            <table show="{ grid && grid.length > 0 }" class="table table-hover" each="{ g in grid }">
                <thead>
                    <tr class="bg-dark">
                        <th>{ g.descricao }</th>
                        <th class="dia">01</th>
                        <th class="dia">02</th>
                        <th class="dia">03</th>
                        <th class="dia">04</th>
                        <th class="dia">05</th>
                        <th class="dia">06</th>
                        <th class="dia">07</th>
                        <th class="dia">08</th>
                        <th class="dia">09</th>
                        <th class="dia">10</th>
                        <th class="dia">11</th>
                        <th class="dia">12</th>
                        <th class="dia">13</th>
                        <th class="dia">14</th>
                        <th class="dia">15</th>
                        <th class="dia">16</th>
                        <th class="dia">17</th>
                        <th class="dia">18</th>
                        <th class="dia">19</th>
                        <th class="dia">20</th>
                        <th class="dia">21</th>
                        <th class="dia">22</th>
                        <th class="dia">23</th>
                        <th class="dia">24</th>
                        <th class="dia">25</th>
                        <th class="dia">26</th>
                        <th class="dia">27</th>
                        <th class="dia">28</th>
                        <th class="dia">29</th>
                        <th class="dia">30</th>
                        <th class="dia">31</th>
                        <th class="dia">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr each="{ d in g.acompanhamento_item }">
                        <td>{ d.item }</td>
                        <td>
                            <span class="{ d.dia_1 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_1 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_2 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_2 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_3 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_3 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_4 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_4 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_5 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_5 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_6 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_6 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_7 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_7 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_8 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_8 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_9 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_9 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_10 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_10 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_11 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_11 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_12 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_12 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_13 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_13 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_14 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_14 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_15 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_15 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_16 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_16 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_17 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_17 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_18 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_18 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_19 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_19 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_20 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_20 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_21 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_21 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_22 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_22 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_23 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_23 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_24 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_24 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_25 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_25 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_26 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_26 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_27 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_27 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_28 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_28 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_29 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_29 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_30 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_30 }</span>
                        </td>
                        <td>
                            <span class="{ d.dia_31 == 0 ? 'text-gray' : 'text-dark' }">{ d.dia_31 }</span>
                        </td>
                        <td class="bg-secondary text-right">
                            <b class="{ d.total_anual == 0 ? 'text-gray' : 'text-dark' }">{ d.total_anual }</b>
                        </td>
                    </tr>
                    <tr class="bg-secondary">
                        <td>
                            <b>TOTAL</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_1 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_1 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_2 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_2 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_3 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_3 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_4 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_4 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_5 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_5 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_6 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_6 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_7 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_7 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_8 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_8 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_9 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_9 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_10 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_10 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_11 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_11 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_12 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_12 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_13 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_13 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_14 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_14 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_15 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_15 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_16 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_16 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_17 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_17 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_18 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_18 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_19 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_19 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_20 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_20 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_21 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_21 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_22 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_22 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_23 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_23 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_24 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_24 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_25 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_25 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_26 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_26 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_27 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_27 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_28 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_28 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_29 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_29 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_30 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_30 }</b>
                        </td>
                        <td>
                            <b class="{ g.totalizadores.dia_31 == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.dia_31 }</b>
                        </td>
                        <td class="text-right">
                            <b class="{ g.totalizadores.total_anual == 0 ? 'text-gray' : 'text-dark' }">{ g.totalizadores.total_anual }</b>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <style media="all">
        .dia {
            width: 10px;
        }

        .table {
            font-size: 12px !important;
        }
    </style>

    <script>
        var tag = this;
        tag.url = BASE_URL + '/relatorio-acompanhamento-mensal'
        tag.grid = opts.grid || [];
        tag.loading = false;
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.session = APP.getSessiononSubmit
        tag.on('mount', onMount);

        function onMount() {
            VMasker(document.getElementById('ano')).maskPattern('9999');
        }

        tag.mixin('ListagemMixin', {
            urlFetch: tag.url + '/buscar',
            callbackBeforeRequest: function () {
                tag.update({
                    'loading': true
                });
                return true;
            }
        });
    </script>
</relatorio-acompanhamento-mensal>