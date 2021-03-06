<aviso-form>
    <form onsubmit="{ onSubmit }">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Cadastro Aviso</div>
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary mr-1">Salvar</button>
                        <a href="{ url }/listar" class="btn btn-secondary">Cancelar</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="columns">
                    <div class="column col-12 col-md-12">
                        <div class="form-group { errors.aviso ? 'has-error' : '' }">
                            <div id="aviso"></div>
                            <div class="form-input-hint" if="{ errors.aviso }" each="{ e in errors.aviso }">- { e }</div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="status">Status</label>
                            <select class="form-select" name="status" id="status">
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
        tag.url = BASE_URL + '/aviso';
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.codigo = opts.dados ? opts.dados.codigo : '';
        tag.onSubmit = onSubmit;
        tag.on('mount', onMount);
        tag.editor = null;

        function onMount() {
            tag.editor = window.pell.init({
                element: tag.root.querySelector('#aviso'),
                actions: [
                    'bold',
                    'italic',
                    'underline',
                    'heading1',
                    'heading2',
                    'quote',
                    'olist',
                    'ulist',
                    'link'
                ]
            });

            tag.editor.content.innerHTML = tag.opts.dados ? tag.dados.aviso : '';
        }

        function onSubmit(event) {
            event.preventDefault();
            var form = event.target;
            var data = {
                'status': tag.root.querySelector('#status').value,
                'aviso': tag.root.querySelector('#aviso').content.innerHTML
            }

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
</aviso-form>