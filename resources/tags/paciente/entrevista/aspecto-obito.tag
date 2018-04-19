<paciente-entrevista-aspecto-obito>
    <fieldset>
        <legend>Aspectos relacionados ao óbito</legend>
        <div class="columns">
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.metodo_contraceptivo ? 'has-error' : '' }">
                    <label class="form-label" for="metodo_contraceptivo">Possuí cobertura de plano funerário?</label>
                    <select name="tfd" class="form-select">
                        <option value=""></option>
                        <option value="S">Sim</option>
                        <option value="N">Não</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.metodo_contraceptivo }" each="{ e in errors.metodo_contraceptivo }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.gestacao_planejada ? 'has-error' : '' }">
                    <label class="form-label" for="gestacao_planejada">Possui religião</label>
                    <select name="gestacao_planejada" class="form-select">
                        <option value=""></option>
                        <option value="S">Sim</option>
                        <option value="N">Não</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.gestacao_planejada }" each="{ e in errors.gestacao_planejada }">- { e }</div>
                </div>
            </div>
            <div class="column col-6 col-md-12">
                <div class="form-group { errors.motivo_nao_prenatal ? 'has-error' : '' }">
                    <label class="form-label" for="motivo_nao_prenatal">Localidade que deseja ser sepultado</label>
                    <input type="text" name="motivo_nao_prenatal" maxlength="100" value="{ dados.motivo_nao_prenatal }" class="form-input">
                    <div class="form-input-hint" if="{ errors.motivo_nao_prenatal }" each="{ e in errors.motivo_nao_prenatal }">- { e }</div>
                </div>
            </div>
        </div>
    </fieldset>
    <script>
        var tag = this;
        tag.dados = opts.dados || {};
        tag.errors = opts.errors || {};
    </script>
</paciente-entrevista-aspecto-obito>