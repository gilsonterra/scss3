var APP = {};

/**
 * Método requisição ajax 
 * 
 * @param {string} url 
 * @param {object} options 
 * @param {function} resolve 
 * @param {reject} reject 
 */
APP.httpService = function (url, options, resolve, reject) {
    var xhr = new XMLHttpRequest();

    xhr.open(options.method, url);

    if (options.contentType) {
        xhr.setRequestHeader("Content-Type", options.contentType);
    }

    xhr.setRequestHeader("X-Requested-With", 'XMLHttpRequest');

    if (reject == undefined) {
        reject = function (jsonText) {
            swal(JSON.parse(jsonText));
        }
    }

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            switch (xhr.status) {
                case 200:
                    resolve(JSON.parse(xhr.responseText));
                    break;

                case 401:
                    window.location.href = BASE_URL + '/login/entrar';                    
                    break;

                default:
                    reject(xhr.responseText);
                    break;
            }
        }
    };

    xhr.send(options.data);
};

/**
 *  Método requisição ajax POST
 * 
 * @param {string} url 
 * @param {object} data 
 * @param {function} resolve 
 * @param {function} reject 
 */
APP.ajaxPostRequest = function (url, data, resolve, reject) {
    APP.httpService(url, {
        method: 'POST',
        data: data,
        contentType: 'application/json'
    }, resolve, reject);
};

/**
 * Método requisição ajax GET
 * 
 * @param {string} url 
 * @param {function} resolve 
 * @param {function} reject 
 */
APP.ajaxGetRequest = function (url, resolve, reject) {
    APP.httpService(url, {
        method: 'GET',
        contentType: 'application/json'
    }, resolve, reject);
};

/**
 * Serializa formulário como array de objeto
 * 
 * @param {element} form 
 */
APP.serializeArray = function (form) {
    var field, l, s = [];
    if (typeof form == 'object' && form.nodeName == "FORM") {
        var len = form.elements.length;
        for (var i = 0; i < len; i++) {
            field = form.elements[i];
            if (field.name && !field.disabled && field.type != 'file' && field.type != 'reset' && field.type != 'submit' && field.type != 'button') {
                if (field.type == 'select-multiple') {
                    l = form.elements[i].options.length;
                    for (j = 0; j < l; j++) {
                        if (field.options[j].selected)
                            s[s.length] = {
                                name: field.name,
                                value: field.options[j].value
                            };
                    }
                } else if ((field.type != 'checkbox' && field.type != 'radio') || field.checked) {
                    s[s.length] = {
                        name: field.name,
                        value: field.value
                    };
                }
            }
        }
    }
    return s;
}

/**
 * Serializa formulário como objeto JSON
 * 
 * @param {element} form 
 */
APP.serializeJson = function (form) {
    var json = {};
    var array = APP.serializeArray(form);

    array.map(function (item) {
        if (item.name in json) {
            if (Array.isArray(json[item.name])) {
                json[item.name].push(item.value);
            } else {
                json[item.name] = [json[item.name], item.value];
            }
        } else {
            json[item.name] = item.value;
        }
    });

    return json;
}

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
 * @param {string: DD/MM/YYY } stringDate 
 */
APP.createDateObjectFromPtBr = function(stringDate){
    var params = stringDate.split('/');
    var date = new Date(params[2], Number(params[1]) - 1, params[0]);

    return date;
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