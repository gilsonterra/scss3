<paciente-visualizacao-entrevistas>
    <div class="card">
        <div class="card-header">
            <div class="float-left">
                <div class="card-title h4 text-uppercase badge" data-badge="{ entrevistas.length }">
                    Entrevistas
                </div>
            </div>
            <div class="float-right">
                <div class="dropdown mr-1">
                    <a href="javascript:;" class="btn btn-primary btn-menu dropdown-toggle" tabindex="0">
                        <i class="icon icon-plus"></i>
                        Nova Entrevista
                        <i class="icon icon-caret"></i>
                    </a>
                    <ul class="menu" style="min-width: 310px">
                        <li class="menu-item">
                            <a href="{ url }/criar/A/{ opts.codigoPaciente }">Adulto</a>
                        </li>
                        <li class="menu-item">
                            <a href="{ url }/criar/M/{ opts.codigoPaciente }">Adulto/Maternidade</a>
                        </li>
                        <li class="menu-item">
                            <a href="{ url }/criar/CP/{ opts.codigoPaciente }">Adulto/Cuidado Paliativos</a>
                        </li>
                        <li class="menu-item">
                            <div class="divider"></div>
                        </li>
                        <li class="menu-item">
                            <a href="{ url }/criar/C/{ opts.codigoPaciente }">Criança e Adolescente</a>
                        </li>
                        <li class="menu-item">
                            <a href="{ url }/criar/CM/{ opts.codigoPaciente }">Criança e Adolescente/Maternidade</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <td style="width:100px;">Data</td>
                        <td style="width:250px;" class=" hide-sm">Local</td>
                        <td style="width:100px;" class=" hide-sm">Profissional</td>
                        <td class=" hide-sm">Tipo</td>
                        <td style="width:80px;"></td>
                    </tr>
                </thead>
                <tbody>
                    <tr each="{ e in entrevistas }">
                        <td class="text-bold">{ e.data_cadastro }</td>
                        <td class="text-bold  hide-sm">{ e.local.descricao }</td>
                        <td class="text-bold  hide-sm">{ e.profissional.nome }</td>
                        <td class="text-bold  hide-sm">{ e.tipo_descricao }</td>
                        <td>
                            <div class="dropdown">
                                <a href="javascript:;" class="btn btn-link btn-menu dropdown-toggle" tabindex="0">
                                    Ações
                                    <i class="icon icon-caret"></i>
                                </a>
                                <ul class="menu">
                                    <li class="menu-item">
                                        <a href="{ url }/editar/{ e.tipo }/{ e.codigo_paciente }/{ e.num_doc }">Alterar</a>
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
        tag.url = BASE_URL + '/paciente/entrevista';
        tag.entrevistas = opts.entrevistas || [];
        tag.usuarioSessao = opts.usuarioSessao || {};
        tag.usuarioSessao = APP.getSession() || {};
        tag.excluir = excluir;

        function excluir(event) {
            swal({
                title: 'Tem certeza que deseja excluir essa entrevista?',
                text: "Se confirmar essa alteração não poderá ser desfeita.",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#DE5200',
                confirmButtonText: 'Sim, excluir!',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.value) {
                    _onRequestDelete(event.item.e);
                }
            });
        }

        function _onRequestDelete(entrevista) {
            var num_doc = entrevista.num_doc;
            APP.ajaxGetRequest(tag.url + '/excluir/' + num_doc,
                function (json) {
                    swal(json).then(function () {
                        if (json.type == 'success') {
                            tag.entrevistas.some(function (item) {
                                if (entrevista === item) {
                                    tag.entrevistas.splice(tag.entrevistas.indexOf(item), 1);
                                    tag.update();
                                }
                            });
                        }
                    });
                }
            );
        }
    </script>
</paciente-visualizacao-entrevistas>