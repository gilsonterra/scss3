<paciente-identificacao>
    <form onsubmit="{ onSubmit }">
        <input type="hidden" name="fk_profissional" value="{ session.codigo }">
        <div class="card">
            <div class="card-header">
                <div class="card-title h3">
                    <div class="float-left">Paciente</div>
                    <div class="float-right">
                        <button type="submit" if="{ !dados.codigo_paciente }" class="btn btn-primary mr-1">Salvar</button>
                        <button type="submit" if="{ dados.codigo_paciente }" class="btn btn-primary mr-1">Alterar</button>
                        <a href="{ BASE_URL }/paciente/listar" if="{ !dados.codigo_paciente }" class="btn btn-secondary">Cancelar</a>
                        <a href="{ BASE_URL }/paciente/visualizar/{ dados.codigo_paciente }" if="{ dados.codigo_paciente }" class="btn btn-secondary">Voltar</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <fieldset>
                    <legend>Identificação</legend>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.cod_prnt ? 'has-error' : '' }">
                                <label class="form-label" for="cod_prnt">Prontuário</label>
                                <input type="text" disabled name="cod_prnt" maxlength="20" value="{ dados.cod_prnt }" class="form-input">
                                <div class="form-input-hint" if="{ errors.cod_prnt }" each="{ e in errors.cod_prnt }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.nome_pac ? 'has-error' : '' }">
                                <label class="form-label" for="nome_pac">Nome</label>
                                <input type="text" name="nome_pac" maxlength="100" autofocus value="{ dados.nome_pac }" class="form-input" required>
                                <div class="form-input-hint" if="{ errors.nome_pac }" each="{ e in errors.nome_pac }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.nome_social ? 'has-error' : '' }">
                                <label class="form-label" for="nome_social">Nome Social</label>
                                <input type="text" name="nome_social" maxlength="100" value="{ dados.nome_social }" class="form-input">
                                <div class="form-input-hint" if="{ errors.nome_social }" each="{ e in errors.nome_social }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.sexo_pac ? 'has-error' : '' }">
                                <label class="form-label" for="sexo_pac">Sexo</label>
                                <select name="sexo_pac" class="form-select" required>
                                    <option value=""></option>
                                    <option value="F" selected="{ 'F' == dados.sexo_pac }">Feminino</option>
                                    <option value="M" selected="{ 'M' == dados.sexo_pac }">Masculino</option>
                                </select>
                                <div class="form-input-hint" if="{ errors.sexo_pac }" each="{ e in errors.sexo_pac }">- { e }</div>
                            </div>
                        </div>
                    </div>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.data_nasc_pac ? 'has-error' : '' }">
                                <label class="form-label" for="data_nasc_pac">Nascimento</label>
                                <input type="text" name="data_nasc_pac" maxlength="10" value="{ dados.data_nasc_pac }" class="form-input" required>
                                <div class="form-input-hint" if="{ errors.data_nasc_pac }" each="{ e in errors.data_nasc_pac }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.nome_mae_pac ? 'has-error' : '' }">
                                <label class="form-label" for="nome_mae_pac">Mãe</label>
                                <input type="text" name="nome_mae_pac" maxlength="100" value="{ dados.nome_mae_pac }" class="form-input">
                                <div class="form-input-hint" if="{ errors.nome_mae_pac }" each="{ e in errors.nome_mae_pac }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.nome_pai_pac ? 'has-error' : '' }">
                                <label class="form-label" for="nome_pai_pac">Pai</label>
                                <input type="text" name="nome_pai_pac" maxlength="100" value="{ dados.nome_pai_pac }" class="form-input">
                                <div class="form-input-hint" if="{ errors.nome_pai_pac }" each="{ e in errors.nome_pai_pac }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.cns ? 'has-error' : '' }">
                                <label class="form-label" for="cns">Cartão SUS</label>
                                <input type="text" name="cns" maxlength="100" value="{ dados.cns }" class="form-input">
                                <div class="form-input-hint" if="{ errors.cns }" each="{ e in errors.cns }">- { e }</div>
                            </div>
                        </div>
                    </div>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.grau_parentesco_acomp ? 'has-error' : '' }">
                                <label class="form-label" for="grau_parentesco_acomp">Grau Parentesco</label>
                                <input type="text" name="grau_parentesco_acomp" maxlength="100" value="{ dados.grau_parentesco_acomp }" class="form-input">
                                <div class="form-input-hint" if="{ errors.grau_parentesco_acomp }" each="{ e in errors.grau_parentesco_acomp }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.acompanhante ? 'has-error' : '' }">
                                <label class="form-label" for="acompanhante">Acompanhante</label>
                                <input type="text" name="acompanhante" maxlength="100" value="{ dados.acompanhante }" class="form-input">
                                <div class="form-input-hint" if="{ errors.acompanhante }" each="{ e in errors.acompanhante }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-6 col-md-12">
                            <div class="form-group { errors.procedencia ? 'has-error' : '' }">
                                <label class="form-label" for="procedencia">Procedência</label>
                                <input type="text" name="procedencia" maxlength="100" value="{ dados.procedencia }" class="form-input">
                                <div class="form-input-hint" if="{ errors.procedencia }" each="{ e in errors.procedencia }">- { e }</div>
                            </div>
                        </div>
                    </div>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group { errors.rg ? 'has-error' : '' }">
                                <label class="form-label" for="rg">RG</label>
                                <input type="text" name="rg" maxlength="10" value="{ dados.rg }" class="form-input">
                                <div class="form-input-hint" if="{ errors.rg }" each="{ e in errors.rg }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group { errors.rg_org_exp ? 'has-error' : '' }">
                                <label class="form-label" for="rg_org_exp">Órgão Expedidor</label>
                                <input type="text" name="rg_org_exp" maxlength="10" value="{ dados.rg_org_exp }" class="form-input">
                                <div class="form-input-hint" if="{ errors.rg_org_exp }" each="{ e in errors.rg_org_exp }">- { e }</div>
                            </div>
                        </div>
                        <div class="column col-6 col-md-12">
                            <div class="form-group { errors.cpf ? 'has-error' : '' }">
                                <label class="form-label" for="cpf">CPF</label>
                                <input type="text" name="cpf" id="cpf" maxlength="14" value="{ dados.cpf }" class="form-input">
                                <div class="form-input-hint" if="{ errors.cpf }" each="{ e in errors.cpf }">- { e }</div>
                            </div>
                        </div>
                    </div>
                    <div class="columns">
                        <div class="column col-12 col-md-12">
                            <div class="form-group { errors.observacoes ? 'has-error' : '' }">
                                <label class="form-label" for="observacoes">Observação</label>
                                <input type="text" name="observacoes" maxlength="500" value="{ dados.observacoes }" class="form-input">
                                <div class="form-input-hint" if="{ errors.observacoes }" each="{ e in errors.observacoes }">- { e }</div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Endereço Moradia</legend>
                    <form-select-uf uf-name="uf" municipio-name="cod_muni_ibge" cod-ibge="{ dados.cod_muni_ibge }" endereco-name="end_pac" endereco-val="{ dados.end_pac }"></form-select-uf>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac">Telefone</label>
                                <input type="text" name="fone_pac" maxlength="15" value="{ dados.fone_pac }" class="form-input fone">
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_nome">Nome</label>
                                <input type="text" name="fone_pac_nome" maxlength="100" value="{ dados.fone_pac_nome }" class="form-input">
                            </div>
                        </div>
                        <div class="column col-2 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_3">Telefone</label>
                                <input type="text" name="fone_pac_3" maxlength="15" value="{ dados.fone_pac_3 }" class="form-input fone">
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_3_nome">Nome</label>
                                <input type="text" name="fone_pac_3_nome" maxlength="100" value="{ dados.fone_pac_3_nome }" class="form-input">
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Endereço Contato</legend>
                    <form-select-uf uf-name="uf_cont" municipio-name="cod_muni_ibge_cont" cod-ibge="{ dados.cod_muni_ibge_cont }" endereco-name="end_pac_contato"
                        endereco-val="{ dados.end_pac_contato }"></form-select-uf>
                    <div class="columns">
                        <div class="column col-2 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_2">Telefone</label>
                                <input type="text" name="fone_pac_2" maxlength="15" value="{ dados.fone_pac_2 }" class="form-input fone">
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_2_nome">Nome</label>
                                <input type="text" name="fone_pac_2_nome" maxlength="100" value="{ dados.fone_pac_2_nome }" class="form-input">
                            </div>
                        </div>
                        <div class="column col-2 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_4">Telefone</label>
                                <input type="text" name="fone_pac_4" maxlength="15" value="{ dados.fone_pac_4 }" class="form-input fone">
                            </div>
                        </div>
                        <div class="column col-4 col-md-12">
                            <div class="form-group">
                                <label class="form-label" for="fone_pac_4_nome">Nome</label>
                                <input type="text" name="fone_pac_4_nome" maxlength="100" value="{ dados.fone_pac_4_nome }" class="form-input">
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </form>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente/identificacao';
        tag.errors = opts.errors || {};
        tag.dados = opts.dados || {};
        tag.codigo = opts.dados ? opts.dados.codigo_paciente : '';
        tag.onSubmit = onSubmit;
        tag.session = APP.getSession() || {};
        tag.estados = [];
        tag.estadosCont = [];
        tag.on('mount', onMount);

        function onMount() {
            _setMaskFone();
            VMasker(document.getElementById('cpf')).maskPattern('999.999.999-99');
        }

        function _setMaskFone() {
            var telMask = ['(99) 9999-99999', '(99) 99999-9999'];
            var tel = document.querySelectorAll('.fone');
            VMasker(tel).maskPattern(telMask[0]);
            tel.forEach(function (el) {
                el.addEventListener('input', _inputHandler.bind(undefined, telMask, 14), false);
            });
        }

        function _inputHandler(masks, max, event) {
            var c = event.target;
            var v = c.value.replace(/\D/g, '');
            var m = c.value.length > max ? 1 : 0;
            VMasker(c).unMask();
            VMasker(c).maskPattern(masks[m]);
            c.value = VMasker.toPattern(v, masks[m]);
        }

        function onSubmit(event) {
            event.preventDefault();

            var form = event.target;
            var data = Serialize.toJson(form);
            var dataParam = JSON.stringify(data);

            Request.post(tag.url + '/persistir/' + tag.codigo, dataParam, _onSuccess, _onError);
        }

        function _onSuccess(json) {
            if (json.message) {
                swal(json.message).then(function () {
                    if (json.message.type == 'success') {
                        window.location.href = BASE_URL + '/paciente/visualizar/' + json.message.data.codigo_paciente;
                    }
                });
            }

            if (json.errors) {
                tag.update({
                    'errors': json.errors
                });
            }
        }

        function _onError(errorText) {
            var json = JSON.parse(errorText);
            swal(json);
        }
    </script>
</paciente-identificacao>