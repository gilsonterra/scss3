<paciente-list>
    <form onsubmit="{ onSearch }" ref="formulario" autocomplete="off">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Busca Paciente</div>
                    <div class="float-right">
                        <a href="{ url }/identificacao/criar" class="btn btn-primary">Novo</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr class="bg-secondary">
                            <th style="width:120px;">Prontuário</th>
                            <th>Nome</th>
                            <th class="hide-sm">Mãe</th>
                            <th class="hide-sm">Nome Social</th>
                            <th class="hide-sm" style="width:150px;">Nascimento</th>
                            <th style="width:100px;"></th>
                        </tr>
                        <tr class="bg-secondary">
                            <th>
                                <input type="text" class="form-input" arial-label="Prontuário" name="cod_prnt" maxlength="100" placeholder="Prontuário">
                            </th>
                            <th>
                                <input type="text" class="form-input" arial-label="Nome" name="nome_pac" maxlength="100" placeholder="Nome">
                            </th>
                            <th class="hide-sm">
                                <input type="text" class="form-input" arial-label="Mãe" name="nome_mae_pac" maxlength="100" placeholder="Mãe">
                            </th>
                            <th class="hide-sm">
                                <input type="text" class="form-input" arial-label="Nome Social" name="nome_social" maxlength="100" placeholder="Nome Social">
                            </th>
                            <th class="hide-sm">
                                <input type="text" class="form-input" arial-label="Nascimento" name="data_nasc_pac" maxlength="10" placeholder="Nascimento">
                            </th>
                            <th>
                                <button type="submit" class="btn btn-secondary" disabled="{ loading }">
                                    <i class="icon icon-search"></i>
                                    Filtrar
                                </button>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr hide="{ loading }" each="{ d in grid.data }">
                            <td>{ d.cod_prnt }</td>
                            <td>{ d.nome_pac }</td>
                            <td class="hide-sm">{ d.nome_mae_pac }</td>
                            <td class="hide-sm">{ d.nome_social }</td>
                            <td class="hide-sm">{ d.data_nasc_pac }</td>
                            <td>
                                <a href="{ url }/visualizar/{ d.codigo_paciente }" if="{ d.tipo == 'SCSS'}" title="Selecionar para alterar" class="btn btn-link">
                                    <span class="text-success">Alterar</span>
                                </a>
                                <a href="{ url }/importar-scac/{ d.cod_prnt }" if="{ d.tipo == 'SAMIS'}" title="Importar do SAMIS" class="btn btn-link">
                                    <span class="text-warning">Importar</span>
                                </a>
                            </td>
                        </tr>
                        <tr hide="{ loading }" if="{ grid.data && grid.data.length == 0 }">
                            <td colspan="6">Nenhum registro encontrado.</td>
                        </tr>
                        <tr hide="{ loading }" if="{ !grid.data }">
                            <td colspan="6">Preencha o filtro para pesquisar.</td>
                        </tr>
                        <tr show="{ loading }">
                            <td colspan="6">
                                <div class="loading loading-lg"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <div hide="{ loading }">
                    <pagination grid="{ grid }" next="{ onNext }" prev="{ onPrev }"></pagination>
                </div>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente'
        tag.grid = opts.grid || [];
        tag.loading = false;

        function _validationRequest(obj) {
            for (name in obj) {
                if (name != 'paginate' && (obj[name] != undefined && obj[name] != '')) {
                    return true;
                }
            }

            return false;
        }

        tag.mixin('ListagemMixin', {
            urlFetch: tag.url + '/buscar',

            callbackBeforeRequest: function () {
                var form = tag.refs.formulario;
                var data = Serialize.toJson(form);
                if (!_validationRequest(data)) {
                    swal('Aviso', 'Preencha pelo menos um campo do filtro!', 'info');
                    return false;
                } else {
                    tag.update({
                        'loading': true
                    });
                    return true;
                }
            }
        });
    </script>
</paciente-list>