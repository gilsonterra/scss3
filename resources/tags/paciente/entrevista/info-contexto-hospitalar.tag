<paciente-entrevista-info-contexto-hospitalar>
    <fieldset>
        <legend>Informações sobre o contexto hospitalar e da Rede de Saúde</legend>
        <div class="columns">
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.encaminhado ? 'has-error' : '' }">
                    <label class="form-label" for="encaminhado">Modo Encaminhamento</label>
                    <select name="encaminhado" class="form-select">
                        <option value=""></option>
                        <option each="{ e in arrayEncaminhado }" value="{ e.codigo }" selected="{ dados.encaminhado == e.codigo }">{ e.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.encaminhado }" each="{ e in errors.encaminhado }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.tfd ? 'has-error' : '' }">
                    <label class="form-label" for="tfd">Tratamento Fora do Domicílio (TFD)</label>
                    <select name="tfd" class="form-select">
                        <option value=""></option>
                        <option value="S">Sim</option>
                        <option value="N">Não</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.tfd }" each="{ e in errors.tfd }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.meio_transporte ? 'has-error' : '' }">
                    <label class="form-label" for="meio_transporte">Meio de Transporte</label>
                    <select name="meio_transporte" class="form-select" onchange="{ onChangeMeioTransporte }">
                        <option value=""></option>
                        <option each="{ m in arrayMeioTransporte }" value="{ m.codigo }" selected="{ dados.meio_transporte == m.codigo }">{ m.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.meio_transporte }" each="{ e in errors.meio_transporte }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.meio_transporte_outros ? 'has-error' : '' }">
                    <label class="form-label" for="meio_transporte_outros">Meio de Transporte (Outro)</label>
                    <input type="text" id="meio_transporte_outros" name="meio_transporte_outros" disabled="{ dados.meio_transporte == 'OU' ? 'true' : 'false' }"
                        maxlength="100" value="{ dados.meio_transporte_outros }" class="form-input">
                    <div class="form-input-hint" if="{ errors.meio_transporte_outros }" each="{ e in errors.meio_transporte_outros }">- { e }</div>
                </div>
            </div>
        </div>
    </fieldset>
    <script>
        var tag = this;
        tag.dados = opts.dados || {};
        tag.errors = opts.errors || {};
        tag.onChangeMeioTransporte = onChangeMeioTransporte;
        tag.arrayMeioTransporte = [{
                'codigo': 'ON',
                'descricao': 'Ônibus'
            },
            {
                'codigo': 'AM',
                'descricao': 'Ambulância'
            },
            {
                'codigo': 'CP',
                'descricao': 'Condução Própria'
            },
            {
                'codigo': 'CA',
                'descricao': 'Carona'
            },
            {
                'codigo': 'DE',
                'descricao': 'Deambulando'
            },
            {
                'codigo': 'OU',
                'descricao': 'Outro'
            }
        ];

        tag.arrayEncaminhado = [{
                'codigo': 'AM',
                'descricao': 'Ambulatório/HC'
            },
            {
                'codigo': 'UH',
                'descricao': 'Urgência/HC'
            },
            {
                'codigo': 'US',
                'descricao': 'Urgência/SMS'
            },
            {
                'codigo': 'ES',
                'descricao': 'Eletiva/SMS'
            },
            {
                'codigo': 'OU',
                'descricao': 'Outro'
            }
        ];

        function onChangeMeioTransporte(event) {
            var meioTransporte = event.target.value;
            var inputOutro = document.getElementById('meio_transporte_outros');

            if (meioTransporte == 'OU') {
                inputOutro.disabled = false;
                inputOutro.focus();
            } else {
                inputOutro.value = '';
                inputOutro.disabled = true;
            }
        }
    </script>
</paciente-entrevista-info-contexto-hospitalar>