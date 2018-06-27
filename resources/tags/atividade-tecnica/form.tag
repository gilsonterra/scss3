<atividade-tecnica-form>
    <form onsubmit="{ onSubmit }">                
        <input type="hidden" name="fk_profissional" value="{ session.codigo }">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Cadastro Atividade Técnica</div>
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary mr-1">Salvar</button>
                        <a href="{ url }/listar" class="btn btn-secondary">Cancelar</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group { errors.data_cadastro ? 'has-error' : '' }">
                            <label class="form-label" for="data_cadastro">Data Cadastro</label>
                            <input type="text" name="data_cadastro" id="data_cadastro" maxlength="10" value="{ dados.data_cadastro || APP.dataAtualPtBr() }" class="form-input date"
                                required>
                            <div class="form-input-hint" if="{ errors.data_cadastro }" each="{ e in errors.data_cadastro }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <form-select-locais-sessao errors="{ errors.fk_local }" name="fk_local"
                            val="{ dados.fk_local }"></form-select-locais-sessao>
                    </div>
                    <div class="column col-3 col-md-12">
                        <div class="form-group { errors.categoria_acompanhamento ? 'has-error' : '' }">
                            <label class="form-label" for="categoria_acompanhamento">Categoria</label>
                            <select class="form-select" onchange="{ onChangeCategoria }" required>
                                <option value=""></option>
                                <option each="{ c in acompanhamentoCategorias }" value="{ c.codigo }" selected="{ dados.acompanhamento_item ? dados.acompanhamento_item.categoria.codigo == c.codigo : '' }">{ c.descricao }</option>
                            </select>
                            <div class="form-input-hint" if="{ errors.categoria_acompanhamento }" each="{ e in errors.categoria_acompanhamento }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-3 col-md-12">
                        <div class="form-group { errors.fk_acompanhamento ? 'has-error' : '' }">
                            <label class="form-label" for="fk_acompanhamento">Acompanhamento</label>
                            <select name="fk_acompanhamento" class="form-select" required>
                                <option value=""></option>
                                <option each="{ i in acompanhamentoItems }" value="{ i.codigo }" selected="{ dados.fk_acompanhamento == i.codigo }">{ i.descricao }</option>
                            </select>
                            <div class="form-input-hint" if="{ errors.fk_acompanhamento }" each="{ e in errors.fk_acompanhamento }">- { e }</div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-12 col-md-12">
                        <div class="form-group { errors.relato ? 'has-error' : '' }">
                            <label class="form-label" for="relato">Relato</label>
                            <textarea name="relato" rows="5" class="form-input" required>{ dados.relato }</textarea>
                            <div class="form-input-hint" if="{ errors.relato }" each="{ e in errors.relato }">- { e }</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/atividade-tecnica';
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.codigo = opts.dados ? opts.dados.codigo : '';
        tag.acompanhamento = opts.acompanhamento || {};
        tag.acompanhamentoCategorias = [];
        tag.acompanhamentosItems = [];
        tag.session = APP.getSession() || {};
        tag.onSubmit = onSubmit;
        tag.onChangeCategoria = onChangeCategoria;
        tag.on('mount', onMount);

        function onMount() {                        
            _buscaAcompanhamentoCategoria();
            VMasker(document.getElementById('data_cadastro')).maskPattern('99/99/9999');
        }

        function _buscaAcompanhamentoCategoria() {
            var data = {};
            data.tipo = 'A';
            Request.post(BASE_URL + '/acompanhamento-categoria/buscar', JSON.stringify(data),
                function (json) {
                    tag.update({
                        'acompanhamentoCategorias': json
                    });

                    if (tag.dados.acompanhamento_item && tag.dados.acompanhamento_item.categoria.codigo) {
                        _buscaAcompanhamentoItem(tag.dados.acompanhamento_item.categoria.codigo);
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
            var data = Serialize.toJson(form);

            Request.post(tag.url + '/persistir/' + tag.codigo, JSON.stringify(data),
                function (json) {
                    if (json.message) {
                        swal(json.message).then(function () {
                            if (json.message.type == 'success') {
                                window.location.href = tag.url + '/listar';
                            }
                        });
                    }

                    if (json.errors) {
                        tag.update({
                            'errors': json.errors
                        });
                    }
                });
        }
    </script>
</atividade-tecnica-form>