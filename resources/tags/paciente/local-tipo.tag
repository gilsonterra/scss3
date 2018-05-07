<paciente-local-tipo>
    <div class="columns">
        <div class="column col-2 col-md-12">
            <div class="form-group { errors.data_cadastro ? 'has-error' : '' }">
                <label class="form-label" for="data_cadastro">Data Cadastro</label>
                <input type="text" disabled="{ dados.somente_visualizar }" name="data_cadastro" maxlength="10" value="{ dados.data_cadastro || APP.dataAtualPtBr() }" class="form-input date"
                    required>
                <div class="form-input-hint" if="{ errors.data_cadastro }" each="{ e in errors.data_cadastro }">- { e }</div>
            </div>
        </div>
        <div class="column col-4 col-md-12">
            <div class="form-group { errors.tipo_faturamento ? 'has-error' : '' }">
                <label class="form-label" for="tipo_faturamento">Tipo</label>
                <select name="tipo_faturamento" disabled="{ dados.somente_visualizar }"  id="tipo_faturamento" class="form-select" required>
                    <option value=""></option>
                    <option value="E" selected="{ dados.tipo_faturamento == 'E' }">EXTERNO</option>
                    <option value="I" selected="{ dados.tipo_faturamento == 'I'}">INTERNO</option>
                </select>
                <div class="form-input-hint" if="{ errors.tipo_faturamento }" each="{ e in errors.tipo_faturamento }">- { e }</div>
            </div>
        </div>
        <div class="column col-6 col-md-12">
            <form-select-locais-sessao somente-visualizar="{ dados.somente_visualizar }" errors="{ errors.fk_local }" name="fk_local" val="{ dados.fk_local }"></form-select-locais-sessao>
        </div>
    </div>
    <script>
        var tag = this;        
        tag.dados = opts.dados || {};        
        tag.errors = opts.errors || {};                
        tag.errors.on('atualiza', function(newErrors){                        
            tag.update({'errors': newErrors});            
        });

        tag.on('mount', onMount);

        function onMount(){
            VMasker(document.querySelector('.date')).maskPattern('99/99/9999');
        }
    </script>
</paciente-local-tipo>