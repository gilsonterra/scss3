<paciente-acompanhamento>
    <form onsubmit="{ onSubmit }">
        <input type="hidden" name="codigo_paciente" value="{ paciente.codigo_paciente }">
        <input type="hidden" name="fk_profissional" value="{ session.codigo }">
        <div class="card">
            <div class="card-header">
                <div class="float-left">
                    <div class="card-title h5">Intervenção</div>
                    <div class="card-subtitle text-gray h3">{ paciente.nome_social || paciente.nome_pac }</div>
                </div>
                <div class="float-right">
                    <button type="submit" if="{ !acompanhamento.codigo && !acompanhamento.somente_visualizar }" class="btn btn-primary mr-1">Salvar</button>
                    <button type="submit" if="{ acompanhamento.codigo && !acompanhamento.somente_visualizar }" class="btn btn-primary mr-1">Alterar</button>
                    <a href="{ url }/listar" if="{ !paciente.codigo_paciente }" class="btn btn-secondary">Cancelar</a>
                    <a href="{ BASE_URL }/paciente/visualizar/{ paciente.codigo_paciente }" if="{ paciente.codigo_paciente }" class="btn btn-secondary">Voltar</a>
                </div>
            </div>
            <div class="card-body">       
                <paciente-local-tipo dados="{ acompanhamento }" errors="{ errors }" somente-visualizar="{ acompanhamento.somente_visualizar }"></paciente-local-tipo>         
                <div class="columns">
                    <div class="column col-6 col-md-12">
                        <div class="form-group { errors.categoria_acompanhamento ? 'has-error' : '' }">
                            <label class="form-label" for="categoria_acompanhamento">Categoria</label>
                            <select class="form-select" onchange="{ onChangeCategoria }" disabled="{ acompanhamento.somente_visualizar }" required>
                                <option value=""></option>
                                <option each="{ c in acompanhamentoCategorias }" value="{ c.codigo }" selected="{ acompanhamento.acompanhamento_item ? acompanhamento.acompanhamento_item.categoria.codigo == c.codigo : '' }">{ c.descricao }</option>
                            </select>
                            <div class="form-input-hint" if="{ errors.categoria_acompanhamento }" each="{ e in errors.categoria_acompanhamento }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-6 col-md-12">
                        <div class="form-group { errors.fk_acompanhamento ? 'has-error' : '' }">
                            <label class="form-label" for="fk_acompanhamento">Acompanhamento</label>
                            <select name="fk_acompanhamento" class="form-select" disabled="{ acompanhamento.somente_visualizar }" required>
                                <option each="{ i in acompanhamentoItems }" value="{ i.codigo }" selected="{ acompanhamento.fk_acompanhamento == i.codigo }">{ i.descricao }</option>
                            </select>
                            <div class="form-input-hint" if="{ errors.fk_acompanhamento }" each="{ e in errors.fk_acompanhamento }">- { e }</div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-12 col-md-12">
                        <div class="form-group { errors.relato ? 'has-error' : '' }">
                            <label class="form-label" for="relato">Relato</label>
                            <textarea name="relato" rows="5" class="form-input" disabled="{ acompanhamento.somente_visualizar }" required>{ acompanhamento.relato }</textarea>
                            <div class="form-input-hint" if="{ errors.relato }" each="{ e in errors.relato }">- { e }</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente/acompanhamento';
        tag.errors = opts.errors || {};
        tag.paciente = opts.paciente || {};        
        tag.acompanhamento = opts.acompanhamento || {};
        tag.acompanhamentoCategorias = [];
        tag.acompanhamentosItems = [];
        tag.session = APP.getSession() || {};
        tag.onChangeCategoria = onChangeCategoria;
        tag.onSubmit = onSubmit;
        tag.on('mount', onMount);

        function onMount() {            
            _buscaAcompanhamentoCategoria();
        }

        function _buscaAcompanhamentoCategoria() {
            var data = {};
            data.tipo = 'U';
            APP.ajaxPostRequest(BASE_URL + '/acompanhamento-categoria/buscar', JSON.stringify(data),
                function (json) {
                    tag.update({
                        'acompanhamentoCategorias': json
                    });

                    if (tag.acompanhamento.acompanhamento_item && tag.acompanhamento.acompanhamento_item.categoria.codigo) {
                        _buscaAcompanhamentoItem(tag.acompanhamento.acompanhamento_item.categoria.codigo);
                    }
                }
            );
        }

        function _buscaAcompanhamentoItem(categoria) {
            var items = [];
            tag.acompanhamentoCategorias.map(function (item) {
                if (item.codigo == categoria) {
                    items = item.acompanhamento_item;
                }
            });

            tag.update({
                'acompanhamentoItems': items
            });
        }

        function onChangeCategoria(event) {
            var categoria = event.target.value;
            _buscaAcompanhamentoItem(categoria);
        }

        function onSubmit(event) {
            event.preventDefault();
            var form = event.target;
            var data = APP.serializeJson(form);
            var serializeData = JSON.stringify(data);
            var url = tag.url + '/persistir/' + tag.paciente.codigo_paciente;

            if (tag.acompanhamento.codigo) {
                url += '/' + tag.acompanhamento.codigo;
            }

            APP.ajaxPostRequest(url, serializeData,
                function (json) {
                    if (json.message) {
                        swal(json.message).then(function () {
                            if (json.message.type == 'success') {
                                window.location.href = BASE_URL + '/paciente/visualizar/' + tag.paciente.codigo_paciente;
                            }
                        });
                    }
                    tag.errors.trigger('atualiza', json.errors);
                    if (json.errors) {
                        tag.update({
                            'errors': json.errors
                        });
                    }
                });
        }
    </script>
</paciente-acompanhamento>