<local-form>
    <form onsubmit="{ onSubmit }">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Cadastro Local Atuação</div>
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary mr-1">Salvar</button>
                        <a href="{ url }/listar" class="btn btn-secondary">Cancelar</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="columns">
                    <div class="column col-8 col-md-12">
                        <div class="form-group { errors.descricao ? 'has-error' : '' }">
                            <label class="form-label" for="descricao">Local</label>
                            <input type="text" name="descricao" maxlength="100" value="{ dados.descricao }" class="form-input" required>
                            <div class="form-input-hint" if="{ errors.descricao }" each="{ e in errors.descricao }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group { errors.ramal ? 'has-error' : '' }">
                            <label class="form-label" for="ramal">Ramal</label>
                            <input type="text" name="ramal" maxlength="4" value="{ dados.ramal }" class="form-input">
                            <div class="form-input-hint" if="{ errors.ramal }" each="{ e in errors.ramal }">- { e }</div>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="status">Status</label>
                            <select class="form-select" name="status">
                                <option value="1" selected="{ 1 == dados.status }">Ativo</option>
                                <option value="0" selected="{ 0 == dados.status }">Inativo</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/local';
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.codigo = opts.dados ? opts.dados.codigo : '';
        tag.onSubmit = onSubmit;

        function onSubmit(event) {
            event.preventDefault();
            var form = event.target;
            var data = APP.serializeJson(form);

            APP.ajaxPostRequest(tag.url + '/persistir/' + tag.codigo, JSON.stringify(data),
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
</local-form>