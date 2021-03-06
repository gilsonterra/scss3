<paciente-visualizacao-identificacao>
    <div class="card">
        <div class="card-header">
            <div class="float-left">
                <div class="card-title h4 text-uppercase">
                    Identificação
                </div>
            </div>
            <div class="float-right">
                <a href="{ url }/editar/{ dados.codigo_paciente }" class="btn btn-primary mr-1">
                    <i class="icon icon-edit"></i>
                    Alterar Identificação
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="columns">
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="cod_prnt">Prontuário</label>
                        <span>{ dados.cod_prnt || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="nome_pac">Nome</label>
                        <span>{ dados.nome_pac || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="nome_social">Nome Social</label>
                        <span>{ dados.nome_social || '-' }</span>
                    </div>
                </div>
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="sexo_pac">Sexo</label>
                        <span>{ 'F' == dados.sexo_pac ? 'Feminino' : 'Masculino' }</span>
                    </div>
                </div>
            </div>
            <div class="columns">
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="data_nasc_pac">Nascimento</label>
                        <span>{ dados.data_nasc_pac || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="nome_mae_pac">Mãe</label>
                        <span>{ dados.nome_mae_pac || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="nome_pai_pac">Pai</label>
                        <span>{ dados.nome_pai_pac || '-' }</span>
                    </div>
                </div>
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="cns">Cartão SUS</label>
                        <span>{ dados.cns || '-' }</span>
                    </div>
                </div>
            </div>
            <div class="columns">
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="grau_parentesco_acomp">Grau Parentesco</label>
                        <span>{ dados.grau_parentesco_acomp || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="acompanhante">Acompanhante</label>
                        <span>{ dados.acompanhante || '-' }</span>
                    </div>
                </div>
                <div class="column col-6 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="procedencia">Procedência</label>
                        <span>{ dados.procedencia || '-' }</span>
                    </div>
                </div>
            </div>
            <div class="columns">
                <div class="column col-2 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="rg">RG</label>
                        <span>{ dados.rg || '-' }</span>
                    </div>
                </div>
                <div class="column col-4 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="rg_org_exp">Órgão Expedidor</label>
                        <span>{ dados.rg_org_exp || '-' }</span>
                    </div>
                </div>
                <div class="column col-6 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="cpf">CPF</label>
                        <span>{ dados.cpf || '-' }</span>
                    </div>
                </div>
            </div>
            <div class="columns">
                <div class="column col-12 col-md-12">
                    <div class="form-group">
                        <label class="form-label" for="observacoes">Observação</label>
                        <span>{ dados.observacoes || '-' }</span>
                    </div>
                </div>
            </div>
            </fieldset>
            <fieldset>
                <legend>Endereço Moradia</legend>
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label">UF</label>
                            <span>{ dados.endereco ? dados.endereco.uf_municipio : '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label">Município</label>
                            <span>{ dados.endereco ? dados.endereco.nome_municipio : '-' }</span>
                        </div>
                    </div>
                    <div class="column col-6 col-md-12">
                        <div class="form-group">
                            <label class="form-label">Endereço</label>
                            <span>{ dados.end_pac || '-' }</span>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac">Telefone</label>
                            <span>{ dados.fone_pac || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_nome">Nome</label>
                            <span>{ dados.fone_pac_nome || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_3">Telefone</label>
                            <span>{ dados.fone_pac_3 || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_3_nome">Nome</label>
                            <span>{ dados.fone_pac_3_nome || '-' }</span>
                        </div>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>Endereço Contato</legend>
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label">UF</label>
                            <span>{ dados.endereco_contato ? dados.endereco_contato.uf_municipio : '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label">Município</label>
                            <span>{ dados.endereco_contato ? dados.endereco_contato.nome_municipio : '-' }</span>
                        </div>
                    </div>
                    <div class="column col-6 col-md-12">
                        <div class="form-group">
                            <label class="form-label">Endereço</label>
                            <span>{ dados.end_pac_contato || '-' }</span>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_2">Telefone</label>
                            <span>{ dados.fone_pac_2 || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_2_nome">Nome</label>
                            <span>{ dados.fone_pac_2_nome || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-2 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_4">Telefone</label>
                            <span>{ dados.fone_pac_4 || '-' }</span>
                        </div>
                    </div>
                    <div class="column col-4 col-md-12">
                        <div class="form-group">
                            <label class="form-label" for="fone_pac_4_nome">Nome</label>
                            <span>{ dados.fone_pac_4_nome || '-' }</span>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <script>
        var tag = this;
        tag.url = BASE_URL + '/paciente/identificacao';
        tag.dados = opts.dados || {};
    </script>
</paciente-visualizacao-identificacao>