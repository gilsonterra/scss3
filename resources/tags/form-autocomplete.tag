<form-autocomplete>
    <div class="has-icon-left">
        <input type="search" onblur="{ onBlur }" id="{ opts.id }" placeholder="{ opts.placeholder }" name="{ opts.name }" maxlength="{ opts.maxlength ? opts.maxlength : 100 }"
            value="{ opts.val }" class="form-input" autocomplete="off" onClick="this.select();">
        <i class="form-icon icon icon-search"></i>
    </div>
    <script>
        var tag = this;
        tag.onBlur = opts.onBlur || null;
        tag.on('mount', onMount);

        function onMount() {
            var selector = tag.opts.id ? '#' + tag.opts.id : 'input[name="' + tag.opts.name + '"]';
            new autoComplete({
                selector: selector,
                minChars: 3,
                cache: false,
                source: function (term, response) {
                    return tag.opts.source(term, response);
                },
                renderItem: function (item, search) {
                    return tag.opts.renderItem(item, search);
                },
                onSelect: function (e, term, item) {
                    return tag.opts.onSelect(e, term, item);
                }
            });
        }
    </script>
</form-autocomplete>