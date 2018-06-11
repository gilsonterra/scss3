var APP = {};

/**
 * Pega data atual em pt_br. Ex: 13/01/1988
 */
APP.dataAtualPtBr = function () {
    var today = new Date();
    var dd = today.getDate();

    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    return dd + '/' + mm + '/' + yyyy;
}

/**
 * Seta a sessão no localstorage
 * 
 * @param {object} data 
 */
APP.setSession = function (data) {
    window.localStorage.setItem('session', JSON.stringify(data));
}

/**
 * Pega a sessão do local storage
 */
APP.getSession = function () {
    var session = window.localStorage.getItem('session');
    return session ? JSON.parse(session) : {};
}

APP.escapeTwigJsonParse = function (reponse) {
    var result = reponse.replace(/&quot;/g, '"').replace(/(?:\r\n|\r|\n)/g, '');
    return JSON.parse(result);
}

/**
 * Carrega arquivos assincrono e dinâmicamente
 */
APP.load = (function () {
    // Function which returns a function: https://davidwalsh.name/javascript-functions
    function _load(tag) {
        return function (url) {
            // This promise will be used by Promise.all to determine success or failure
            return new Promise(function (resolve, reject) {
                var element = document.createElement(tag);
                var parent = 'body';
                var attr = 'src';

                // Important success and error for the promise
                element.onload = function () {
                    resolve(url);
                };
                element.onerror = function () {
                    reject(url);
                };

                // Need to set different attributes depending on tag type
                switch (tag) {
                    case 'script':
                        element.async = true;
                        break;
                    case 'link':
                        element.type = 'text/css';
                        element.rel = 'stylesheet';
                        attr = 'href';
                        parent = 'head';
                }

                // Inject into document to kick off loading
                element[attr] = url;
                document[parent].appendChild(element);
            });
        };
    }

    return {
        css: _load('link'),
        js: _load('script'),
        img: _load('img')
    }
})();


riot.mixin('ListagemMixin', {
    urlFetch: null,

    onSearch(event) {
        event.preventDefault();
        this.onRequest();
    },

    onPrev(event) {
        event.preventDefault();
        this.onRequest(this.grid.prev_page_url);
    },

    onNext(event) {
        event.preventDefault();
        this.onRequest(this.grid.next_page_url);
    },

    callbackBeforeRequest: function () {
        return true;
    },

    callbackOnRequest: function (json) {},

    onRequest(pageUrl) {
        var self = this;
        var pageUrl = pageUrl ? pageUrl : '';
        var form = this.refs.formulario;
        var data = Serialize.toJson(form);
        data.paginate = true;

        if (this.callbackBeforeRequest()) {
            Request.post(this.urlFetch + pageUrl, JSON.stringify(data), function (json) {
                self.callbackOnRequest(json);
            });
        }

    }
});