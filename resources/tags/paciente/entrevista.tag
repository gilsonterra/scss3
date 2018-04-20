<paciente-entrevista>
    <form onsubmit="{ onSubmit }">
        <input type="hidden" name="codigo_paciente" value="{ paciente.codigo_paciente }">
        <input type="hidden" name="fk_profissional" value="{ session.codigo }">
        <div class="card">
            <div class="card-header">
                <div class="float-left">
                    <div class="card-title h5">Entrevista Social - Adulto</div>
                    <div class="card-subtitle text-gray h3">{ paciente.nome_social || paciente.nome_pac }</div>
                </div>
                <div class="float-right">
                    <button type="submit" if="{ !entrevista.num_doc }" class="btn btn-primary mr-1">Salvar</button>
                    <button type="submit" if="{ entrevista.num_doc }" class="btn btn-primary mr-1">Alterar</button>
                    <a href="{ url }/listar" if="{ !paciente.codigo_paciente }" class="btn btn-secondary">Cancelar</a>
                    <a href="{ BASE_URL }/paciente/visualizar/{ paciente.codigo_paciente }" if="{ paciente.codigo_paciente }" class="btn btn-secondary">Voltar</a>
                </div>
            </div>
            <div class="card-body">                
                <paciente-entrevista-aspecto-socioeconomico dados="{ entrevista }"></paciente-entrevista-aspecto-socioeconomico>
                <paciente-entrevista-info-gestacao if="{ tipo == 'CM' || tipo == 'M' }" dados="{ entrevista }"></paciente-entrevista-info-gestacao>
                <paciente-entrevista-info-contexto-hospitalar dados="{ entrevista }"></paciente-entrevista-info-contexto-hospitalar>
                <paciente-entrevista-aspecto-obito if="{ tipo == 'CP' }" dados="{ entrevista }"></paciente-entrevista-aspecto-obito>
                <paciente-entrevista-observacao dados="{ entrevista }"></paciente-entrevista-observacao>
            </div>
        </div>
    </form>

    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente/entrevista';
        tag.errors = opts.errors || {};
        tag.tipo = opts.tipo;
        tag.paciente = opts.paciente || {};
        tag.entrevista = opts.entrevista || {};
        tag.session = APP.getSession() || {};
        tag.onSubmit = onSubmit;

        function onSubmit(event) {
            event.preventDefault();
            var form = event.target;
            var data = APP.serializeJson(form);
            var serializeData = JSON.stringify(data);
            var url = tag.url + '/persistir/' + tag.paciente.codigo_paciente;

            if (tag.entrevista.codigo) {
                url += '/' + tag.entrevista.codigo;
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

                    if (json.errors) {
                        tag.update({
                            'errors': json.errors
                        });
                    }
                });
        }
    </script>
</paciente-entrevista>