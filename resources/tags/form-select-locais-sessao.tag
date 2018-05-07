<form-select-locais-sessao>
    <div class="form-group { opts.errors ? 'has-error' : '' }">
        <label class="form-label" for="{ opts.name }">Local</label>
        <select name="{ opts.name }" class="form-select" disabled="{ opts.somenteVisualizar }" required>
            <option value=""></option>
            <option each="{ l in session.locais }" value="{ l.codigo }" selected="{ opts.val == l.codigo  }">{ l.descricao }</option>
        </select>
        <div class="form-input-hint" if="{ opts.errors }" each="{ e in opts.errors }">- { e }</div>
    </div>
    <script>
        var tag = this;
        tag.session = APP.getSession() || {};        
    </script>
</form-select-locais-sessao>