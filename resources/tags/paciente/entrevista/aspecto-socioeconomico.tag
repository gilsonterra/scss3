<paciente-entrevista-aspecto-socioeconomico>
    <fieldset>
        <legend>Aspectos Socioeconômicos</legend>
        <paciente-local-tipo dados="{ dados }" errors="{ errors }"></paciente-local-tipo>
        <div class="columns">
            <div class="column col-2 col-md-12">
                <div class="form-group { errors.situacao_funcional ? 'has-error' : '' }">
                    <label class="form-label" for="">Situação Funcional</label>
                    <select name="situacao_funcional" id="situacao_funcional" class="form-select">
                        <option value=""></option>
                        <option each="{ s in arraySituacaoFuncional }" value="{ s.codigo }" selected="{ dados.situacao_funcional.tipo == s.codigo }">{ s.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.situacao_funcional }" each="{ e in errors.situacao_funcional }">- { e }</div>
                </div>
            </div>
            <div class="column col-4 col-md-12">
                <div class="form-group { errors.fk_profissao ? 'has-error' : '' }">
                    <label class="form-label" for="fk_profissao">Profissão</label>
                    <input type="text" class="d-hide" name="fk_profissao" id="fk_profissao" value="{ dados.fk_profissao }">
                    <form-autocomplete id="inputSelectProfissao" on-blur="{ onBlurProfissao }" placeholder="Digite até 3 caracteres para pesquisar"
                        source="{ autoCompleteSource }" render-item="{ autoCompleteRenderItem }" on-select="{ autoCompleteOnSelect }"
                        val="{ dados.profissao ? dados.profissao.descricao : '' }"></form-autocomplete>
                    <div class="form-input-hint" if="{ errors.fk_profissao }" each="{ e in errors.fk_profissao }">- { e }</div>
                </div>
            </div>
            <div class="column col-6 col-md-12">
                <div class="form-group { errors.escolaridade ? 'has-error' : '' }">
                    <label class="form-label" for="escolaridade">Escolaridade</label>
                    <select name="escolaridade" id="escolaridade" class="form-select">
                        <option value=""></option>
                        <option each="{ e in arrayEscolaridade }" value="{ e.codigo }" selected="{ dados.escolaridade == e.codigo }">{ e.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.escolaridade }" each="{ e in errors.escolaridade }">- { e }</div>
                </div>
            </div>
        </div>
        <div class="columns">
            <div class="column col-2 col-md-12">
                <div class="form-group { errors.situacao_conjugal ? 'has-error' : '' }">
                    <label class="form-label" for="situacao_conjugal">Estado Civil</label>
                    <select name="situacao_conjugal" class="form-select">
                        <option value=""></option>
                        <option each="{ e in arrayEstadosCivis }" value="{ e.codigo }" selected="{ dados.situacao_conjugal == e.codigo }">{ e.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.situacao_conjugal }" each="{ e in errors.situacao_conjugal }">- { e }</div>
                </div>
            </div>
            <div class="column col-4 col-md-12">
                <div class="form-group { errors.nome_companheiro ? 'has-error' : '' }">
                    <label class="form-label" for="nome_companheiro">Nome do(a) esposo(a) ou companheiro(a)</label>
                    <input type="text" name="nome_companheiro" maxlength="100" value="{ dados.nome_companheiro }" class="form-input">
                    <div class="form-input-hint" if="{ errors.nome_companheiro }" each="{ e in errors.nome_companheiro }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.situacao_moradia ? 'has-error' : '' }">
                    <label class="form-label" for="situacao_moradia">Situação Moradia</label>
                    <select name="situacao_moradia" class="form-select" onchange="{ onChangeSituacaoMoradia }">
                        <option value=""></option>
                        <option each="{ s in arraySituacaoMoradia }" value="{ s.codigo }" selected="{ dados.situacao_moradia == s.codigo }">{ s.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.situacao_moradia }" each="{ e in errors.situacao_moradia }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.situacao_moradia_outros ? 'has-error' : '' }">
                    <label class="form-label" for="situacao_moradia_outros">Situação Moradia (Outro)</label>
                    <input type="text" name="situacao_moradia_outros" id="situacao_moradia_outros" maxlength="100" value="{ dados.situacao_moradia_outros }"
                        class="form-input" disabled>
                    <div class="form-input-hint" if="{ errors.situacao_moradia_outros }" each="{ e in errors.situacao_moradia_outros }">- { e }</div>
                </div>
            </div>
        </div>
        <div class="columns">
            <div class="column col-2 col-md-12">
                <div class="form-group { errors.filiado_rgps ? 'has-error' : '' }">
                    <label class="form-label" for="filiado_rgps" title="Filiado ao Regime Geral da Previdência Social?">
                        Filiado(a) ao RGPS
                    </label>
                    <select name="filiado_rgps" class="form-select">
                        <option value=""></option>
                        <option each="{ f in arrayFiliadoRgps }" value="{ f.codigo }" selected="{ dados.filiado_rgps == f.codigo }">{ f.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.filiado_rgps }" each="{ e in errors.filiado_rgps }">- { e }</div>
                </div>
            </div>
            <div class="column col-4 col-md-12">
                <div class="form-group { errors.outro_regime ? 'has-error' : '' }">
                    <label class="form-label" for="outro_regime">Filiado a qual regime?</label>
                    <input type="text" name="outro_regime" maxlength="100" value="{ dados.outro_regime }" class="form-input">
                    <div class="form-input-hint" if="{ errors.outro_regime }" each="{ e in errors.outro_regime }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.contribui_atualmente ? 'has-error' : '' }">
                    <label class="form-label" for="contribui_atualmente">Contribui atualmente?</label>
                    <select name="contribui_atualmente" class="form-select" onchange="{ onChangeContribuiAtualmente }">
                        <option value=""></option>
                        <option each="{ c in arrayContribuiAtualmente }" value="{ c.codigo }" selected="{ dados.contribui_atualmente == c.codigo }">{ c.descricao }</option>
                    </select>
                    <div class="form-input-hint" if="{ errors.contribui_atualmente }" each="{ e in errors.contribui_atualmente }">- { e }</div>
                </div>
            </div>
            <div class="column col-3 col-md-12">
                <div class="form-group { errors.tempo_contribuicao ? 'has-error' : '' }">
                    <label class="form-label" for="tempo_contribuicao">Há quanto tempo contribui?</label>
                    <div class="input-group">
                        <input type="number" ref="tempo_contribuicao" required="{ dados.contribui_atualmente == 'S' ? true : false }" disabled="{ dados.contribui_atualmente == 'S' ? false : true }"
                            name="tempo_contribuicao" min="0" max="40" maxlength="2" value="{ dados.tempo_contribuicao }" class="form-input">
                        <select class="form-select" ref="tempo_contribuicao_unidade" name="tempo_contribuicao_unidade" disabled="{ dados.contribui_atualmente == 'S' ? false : true }">
                            <option value=""></option>
                            <option each="{ u in arrayUnidadeTempoContribuicao }" value="{ u.codigo }" selected="{ dados.tempo_contribuicao_unidade == u.codigo }">{ u.descricao }</option>
                        </select>
                    </div>
                    <div class="form-input-hint" if="{ errors.tempo_contribuicao }" each="{ e in errors.tempo_contribuicao }">- { e }</div>
                </div>
            </div>
        </div>
    </fieldset>
    <script>
        var tag = this;
        tag.dados = opts.dados || {};
        tag.errors = opts.errors || {};
        tag.errors.on('atualiza', function (newErrors) {
            tag.update({
                'errors': newErrors
            });
        });
        tag.onBlurProfissao = onBlurProfissao;
        tag.onChangeContribuiAtualmente = onChangeContribuiAtualmente;
        tag.onChangeSituacaoMoradia = onChangeSituacaoMoradia;
        tag.autoCompleteSource = autoCompleteSource;
        tag.autoCompleteRenderItem = autoCompleteRenderItem;
        tag.autoCompleteOnSelect = autoCompleteOnSelect;
        tag.profissoes = [];
        tag.entrevistaObservable = opts.entrevistaObservable;
        tag.arrayEstadosCivis = [{
                'codigo': 'CA',
                'descricao': 'Casado'
            },
            {
                'codigo': 'DI',
                'descricao': 'Divorciado(a)'
            },
            {
                'codigo': 'SO',
                'descricao': 'Solteiro(a)'
            },
            {
                'codigo': 'SE',
                'descricao': 'Separado(a)'
            },
            {
                'codigo': 'UE',
                'descricao': 'União Estável'
            },
            {
                'codigo': 'VI',
                'descricao': 'Viúvo(a)'
            },
            {
                'codigo': 'NA',
                'descricao': 'NSA'
            },
            {
                'codigo': 'OU',
                'descricao': 'Outro'
            }
        ];
        tag.arraySituacaoMoradia = [{
                'codigo': 'P',
                'descricao': 'Própria'
            },
            {
                'codigo': 'C',
                'descricao': 'Cedida'
            },
            {
                'codigo': 'A',
                'descricao': 'Alugada'
            },
            {
                'codigo': 'F',
                'descricao': 'Financiada'
            },
            {
                'codigo': 'S',
                'descricao': 'Situação de Rua'
            },
            {
                'codigo': 'O',
                'descricao': 'Outro'
            }
        ];
        tag.arrayEscolaridade = [{
                'codigo': 'N',
                'descricao': 'NSA'
            },
            {
                'codigo': 'NSI',
                'descricao': 'NSI - Não Soube Informar'
            },
            {
                'codigo': 'NA',
                'descricao': 'Não Alfabetizado'
            },
            {
                'codigo': 'A',
                'descricao': 'Alfabetizado'
            },
            {
                'codigo': 'EI',
                'descricao': 'EI - Educação Infantil'
            },
            {
                'codigo': 'EFI',
                'descricao': 'EFI - Ensino Fundamental Incompleto'
            },
            {
                'codigo': 'EFC',
                'descricao': 'EFC - Ensino Fundamental Completo'
            },
            {
                'codigo': 'EMI',
                'descricao': 'EMI - Ensino Médio Incompleto'
            },
            {
                'codigo': 'EMC',
                'descricao': 'EMC - Ensino Médio Completo'
            },
            {
                'codigo': 'ESI',
                'descricao': 'ESI - Ensino Superior Incompleto'
            },
            {
                'codigo': 'ESC',
                'descricao': 'ESC - Ensino Superior Completo'
            },
            {
                'codigo': 'PG',
                'descricao': 'Pós-Graduação'
            }
        ];

        tag.arraySituacaoFuncional = [{
                'codigo': 'E',
                'descricao': 'Empregado'
            },
            {
                'codigo': 'D',
                'descricao': 'Desempregado'
            },
            {
                'codigo': 'A',
                'descricao': 'Autônomo'
            },
            {
                'codigo': 'P',
                'descricao': 'Previdênciário'
            },
            {
                'codigo': 'N',
                'descricao': 'NSI'
            },
            {
                'codigo': 'O',
                'descricao': 'Outro'
            }
        ];
        tag.arrayFiliadoRgps = [{
                'codigo': 'S',
                'descricao': 'Sim'
            },
            {
                'codigo': 'N',
                'descricao': 'Não'
            },
        ];
        tag.arrayContribuiAtualmente = [{
                'codigo': 'S',
                'descricao': 'Sim'
            },
            {
                'codigo': 'N',
                'descricao': 'Não'
            },
            {
                'codigo': 'NSI',
                'descricao': 'NSI - Não Se Aplica'
            }
        ];
        tag.arrayUnidadeTempoContribuicao = [{
                'codigo': 'M',
                'descricao': 'Mês'
            },
            {
                'codigo': 'A',
                'descricao': 'Ano(s)'
            }
        ]

        function autoCompleteSource(term, response) {
            var term = term.toLowerCase();
            APP.ajaxPostRequest(BASE_URL + '/profissao/buscar', JSON.stringify({
                'descricao': term
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
            document.getElementById('inputSelectProfissao').value = item.getAttribute('data-val');
            document.getElementById('fk_profissao').value = item.getAttribute('data-codigo');
            document.getElementById('escolaridade').focus();
        }

        function onBlurProfissao(event) {
            if (!event.target.value) {
                document.getElementById('fk_profissao').value = '';
            }
        }

        function onChangeContribuiAtualmente(event) {
            tag.dados.contribui_atualmente = event.target.value;
            if (event.target.value == 'S') {
                tag.refs.tempo_contribuicao.focus();
            } else {
                tag.refs.tempo_contribuicao.value = '';
                tag.refs.tempo_contribuicao_unidade.value = '';                
            }
            tag.update();
        }

        function onChangeSituacaoMoradia(event) {
            var situacaoMoradia = event.target.value;
            var inputSituacaoMoradiaOutro = document.getElementById('situacao_moradia_outros');

            if (situacaoMoradia == 'O') {
                inputSituacaoMoradiaOutro.disabled = false;
                inputSituacaoMoradiaOutro.focus();
            } else {
                inputSituacaoMoradiaOutro.value = '';
                inputSituacaoMoradiaOutro.disabled = true;
            }
        }


        function getProfissao() {
            APP.ajaxPostRequest(BASE_URL + '/profissao/buscar', {}, function (json) {
                tag.update({
                    'profissoes': json
                });
            });
        }
    </script>
</paciente-entrevista-aspecto-socioeconomico>