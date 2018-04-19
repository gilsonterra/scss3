<profissional-form>
    <form ref="formulario" id="formulario" onsubmit="{ onSubmit }">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Cadastro Assistentes Sociais</div>
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary mr-1">Salvar</button>
                        <a href="{ url_profissional }/listar" class="btn btn-secondary">Cancelar</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="columns">
                    <div class="column col-8 col-md-12">
                        <div class="form-group { errors.nome ? 'has-error' : '' }">
                            <label class="form-label" for="nome">Nome</label>
                            <input type="text" name="nome" maxlength="100" value="{ dados.nome }" class="form-input" required autocomplete="off">
                            <div class="form-input-hint" if="{ errors.nome }" each="{ e in errors.nome }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group { errors.login ? 'has-error' : '' }">
                            <label class="form-label" for="login">Login</label>
                            <input type="text" name="login" maxlength="20" value="{ dados.login }" required class="form-input" autocomplete="off">
                            <div class="form-input-hint" if="{ errors.login }" each="{ e in errors.login }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="ativo">Status</label>
                            <select class="form-select" name="ativo">
                                <option value="1" selected="{ 1 == dados.ativo }">Ativo</option>
                                <option value="0" selected="{ 0 == dados.ativo }">Inativo</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-4 col-md-12">
                        <div class="form-group { errors.senha ? 'has-error' : '' }">
                            <label class="form-label" for="senha">Senha</label>
                            <input type="password" name="senha" maxlength="100" class="form-input" autocomplete="off">
                            <div class="form-input-hint" if="{ errors.senha }" each="{ e in errors.senha }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group { errors.confirmar_senha ? 'has-error' : '' }">
                            <label class="form-label" for="confirmar_senha">Confirmar Senha</label>
                            <input type="password" name="confirmar_senha" maxlength="100" class="form-input" autocomplete="off">
                            <div class="form-input-hint" if="{ errors.confirmar_senha }" each="{ e in errors.senha }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="admin">Administrador</label>
                            <select class="form-select" name="admin">
                                <option value="0" selected="{ 0 == dados.admin }">Não</option>
                                <option value="1" selected="{ 1 == dados.admin }">Sim</option>
                            </select>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="perfil">Perfil</label>
                            <select class="form-select" name="perfil">
                                <option value="as" selected="{ 'as' == dados.perfil }">Assistente Social</option>
                                <option value="sv" selected="{ 'sv' == dados.perfil }">Somente Visualização</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-12 col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title h5">Locais de Atuação</div>
                            </div>
                            <div class="card-body">
                                <div class="form-group { errors.locais ? 'has-error' : '' }">
                                    <form-autocomplete name="inputSelecionaLocal" placeholder="Digite até 3 caracteres para pesquisar" source="{ autoCompleteSource }"
                                        render-item="{ autoCompleteRenderItem }" on-select="{ autoCompleteOnSelect }"></form-autocomplete>                                    
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="form-input-hint { errors.locais ? 'text-error' : '' }" if="{ errors.locais }" each="{ e in errors.locais }">- { e }</div>
                                <span class="chip" each="{ local in locaisSelecionados }">
                                    { local.descricao }
                                    <button type="button" class="btn btn-clear" aria-label="Fechar" role="button" onclick="{ removeLocal }"></button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer"></div>
        </div>
    </form>
    <div id="divSelecionaLocal"></div>

    <script>
        var tag = this;
        tag.url_profissional = BASE_URL + '/profissional';
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.codigo = opts.dados ? opts.dados.codigo : '';
        tag.locaisSelecionados = opts.dados ? opts.dados.locais : [];
        tag.onSubmit = onSubmit;
        tag.addLocal = addLocal;
        tag.removeLocal = removeLocal;
        tag.autoCompleteSource = autoCompleteSource;
        tag.autoCompleteRenderItem = autoCompleteRenderItem;
        tag.autoCompleteOnSelect = autoCompleteOnSelect;

        function addLocal(event) {
            event.preventDefault();
            tag.locaisSelecionados.push(event.item.dado);
        }

        function removeLocal(event) {
            event.preventDefault();
            tag.locaisSelecionados.some(function (local) {
                if (event.item.local === local) {
                    tag.locaisSelecionados.splice(tag.locaisSelecionados.indexOf(local), 1);
                }
            });
        }

        function autoCompleteSource(term, response) {
            var term = term.toLowerCase();
            var codigosNotIn = tag.locaisSelecionados.map(function (e) {
                return e.codigo;
            });
            APP.ajaxPostRequest(BASE_URL + '/local/buscar', JSON.stringify({
                'descricao': term,
                'codigos_not_in': codigosNotIn
            }), function (json) {
                var res = json.map(function (item) {
                    return JSON.stringify(item);
                });
                response(res);
            });
        }

        function autoCompleteRenderItem(item, search) {
            var obj = JSON.parse(item);
            var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
            return '<div class="autocomplete-suggestion" data-codigo="' + obj.codigo + '" data-val="' +
                obj.descricao + '">' + obj.descricao.replace(re, "<b>$1</b>") + '</div>';
        }

        function autoCompleteOnSelect(event, term, item) {
            event.preventDefault();
            var local = {
                'codigo': item.getAttribute('data-codigo'),
                'descricao': item.getAttribute('data-val')
            }
            tag.locaisSelecionados.push(local);
            tag.update({
                'locaisSelecionados': tag.locaisSelecionados
            });
            tag.root.querySelector('input[name="inputSelecionaLocal"]').value = '';
        }

        function onSubmit(event) {
            event.preventDefault();
            var form = event.target;
            var data = APP.serializeJson(form);
            data['locais'] = tag.locaisSelecionados;

            APP.ajaxPostRequest(tag.url_profissional + '/persistir/' + tag.codigo, JSON.stringify(data),
                function (json) {
                    if (json.message) {
                        swal(json.message).then(function () {
                            if (json.message.type == 'success') {
                                window.location.href = tag.url_profissional + '/listar';
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
</profissional-form>