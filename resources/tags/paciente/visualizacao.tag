<paciente-visualizacao>
    <p>
        <div class="card">
            <div class="card-body">
                <div class="columns">
                    <div class="column col-6 col-md-12">
                        <label class="form-label">Paciente</label>
                        <span class="text-gray h3">{ (dados.nome_social && dados.nome_social.trim() != '') ? dados.nome_social : dados.nome_pac }</span>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="cod_prnt">Atualizado em:</label>
                            <b>{ dados.data_alteracao || dados.data_cadastro }</b>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="cod_prnt">Atualizado por:</label>
                            <b>{ dados.profissional ? dados.profissional.nome : '-' }</b>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="float-right">
                            <a href="{ url }/listar" class="btn btn-secondary">Cancelar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </p>
    <p>
        <paciente-visualizacao-identificacao dados="{ dados }"></paciente-visualizacao-identificacao>
    </p>
    <p>
        <paciente-visualizacao-acompanhamentos acompanhamentos="{ dados.acompanhamentos }" codigo-paciente="{ dados.codigo_paciente }"></paciente-visualizacao-acompanhamentos>
    </p>

    <p>
        <paciente-visualizacao-entrevistas entrevistas="{ dados.entrevistas }" codigo-paciente="{ dados.codigo_paciente }"></paciente-visualizacao-entrevistas>
    </p>


    <style>
        .form-group span {
            font-weight: bold;
            min-height: 15px;
        }
    </style>

    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente';
        tag.dados = opts.dados || {
            endereco_contato: {},
            endereco: {},
            entrevistas: [],
            acompanhamentos: []
        };
        tag.usuarioSessao = opts.usuarioSessao || {};
    </script>

</paciente-visualizacao>