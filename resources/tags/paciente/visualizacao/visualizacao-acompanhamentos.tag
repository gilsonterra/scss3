<paciente-visualizacao-acompanhamentos>
    <div class="card">
        <div class="card-header">
            <div class="float-left">
                <div class="card-title h4 text-uppercase badge" data-badge="{ acompanhamentos.length }">
                    Intervenções
                </div>
            </div>
            <div class="float-right">
                <a href="{ url }/criar/{ opts.codigoPaciente }" class="btn btn-primary mr-1">
                    <i class="icon icon-plus"></i>
                    Nova Intervenção
                </a>
            </div>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <td style="width:100px;">Data</td>
                        <td style="width:250px;" class="hide-sm">Local</td>
                        <td style="width:100px;" class="hide-sm">Profissional</td>
                        <td class="hide-sm">Categoria</td>
                        <td class="hide-sm">Acompanhamento</td>
                        <td style="width:80px;"></td>
                    </tr>
                </thead>
                <tbody>
                    <tr each="{ a in acompanhamentos }">
                        <td class="text-bold">{ a.data_cadastro }</td>
                        <td class="text-bold hide-sm">{ a.local.descricao }</td>
                        <td class="text-bold hide-sm">{ a.profissional.nome }</td>
                        <td class="text-bold hide-sm">{ a.acompanhamento_item.categoria.descricao }</td>
                        <td class="text-bold hide-sm">{ a.acompanhamento_item.descricao }</td>
                        <td>
                            <div class="dropdown">
                                <a href="javascript:;" class="btn btn-link btn-menu dropdown-toggle" tabindex="0">
                                    Ações
                                    <i class="icon icon-caret"></i>
                                </a>
                                <ul class="menu">
                                    <li class="menu-item">
                                        <a href="{ url }/editar/{ a.codigo_paciente }/{ a.codigo }">
                                            <span if="{ a.somente_visualizar }">Visualizar</span>                                         
                                            <span if="{ !a.somente_visualizar }">Alterar</span>                                         
                                        </a>
                                    </li>
                                    <li class="menu-item" if="{ usuarioSessao.admin == '1' }">
                                        <a href="javascript:;" onclick="{ excluir }">Excluir</a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente/acompanhamento';
        tag.acompanhamentos = opts.acompanhamentos || [];
        tag.usuarioSessao = APP.getSession() || {};
        tag.excluir = excluir;

        function excluir(event) {
            swal({
                title: 'Tem certeza que deseja excluir essa intervenção?',
                text: "Se confirmar essa alteração não poderá ser desfeita.",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#DE5200',
                confirmButtonText: 'Sim, excluir!',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.value) {
                    _onRequestDelete(event.item.a);
                }
            });
        }

        function _onRequestDelete(acompanhamento) {
            var codigo = acompanhamento.codigo;
            Request.get(tag.url + '/excluir/' + codigo,
                function (json) {
                    swal(json).then(function () {
                        if (json.type == 'success') {
                            tag.acompanhamentos.some(function (item) {
                                if (acompanhamento === item) {
                                    tag.acompanhamentos.splice(tag.acompanhamentos.indexOf(item), 1);
                                    tag.update();
                                }
                            });
                        }
                    });
                }
            );
        }
    </script>
</paciente-visualizacao-acompanhamentos>