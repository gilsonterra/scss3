var APP = {};

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
            if (xhr.status == 200) {
                resolve(JSON.parse(xhr.responseText));
            } else {
                reject(xhr.responseText);
            }
        }
    };

    xhr.send(options.data);
};

APP.ajaxHtmlRequest = function (url, options, resolve, reject) {
    var xhr = new XMLHttpRequest();

    xhr.open(options.method, url);
    xhr.setRequestHeader("X-Requested-With", 'XMLHttpRequest');

    if (options.contentType) {
        xhr.setRequestHeader("Content-Type", options.contentType);
    }

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                resolve(xhr.responseText);
            } else {
                reject(xhr.responseText);
            }
        }
    };

    xhr.send(options.data);
}

APP.ajaxPostRequest = function (url, data, resolve, reject) {
    APP.httpService(url, {
        method: 'POST',
        data: data,
        contentType: 'application/json'
    }, resolve, reject);
};

APP.ajaxGetRequest = function (url, resolve, reject) {
    APP.httpService(url, {
        method: 'GET',
        contentType: 'application/json'
    }, resolve, reject);
};


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


APP.serialize = function (form) {
    var field, l, s = [];
    if (typeof form == 'object' && form.nodeName == "FORM") {
        var len = form.elements.length;
        for (var i = 0; i < len; i++) {
            field = form.elements[i];
            if (field.name && !field.disabled && field.type != 'file' && field.type != 'reset' && field.type != 'submit' && field.type != 'button') {
                if (field.type == 'select-multiple') {
                    l = form.elements[i].options.length;
                    for (var j = 0; j < l; j++) {
                        if (field.options[j].selected)
                            s[s.length] = encodeURIComponent(field.name) + "=" + encodeURIComponent(field.options[j].value);
                    }
                } else if ((field.type != 'checkbox' && field.type != 'radio') || field.checked) {
                    s[s.length] = encodeURIComponent(field.name) + "=" + encodeURIComponent(field.value);
                }
            }
        }
    }
    return s.join('&').replace(/%20/g, '+');
}

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

APP.urlParams = function (json) {
    return Object.keys(json).map(function (key) {
        return key + '=' + json[key];
    }).join('&');
}


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


APP.setSession = function (data) {
    window.localStorage.setItem('session', JSON.stringify(data));
}

APP.getSession = function () {
    var session = window.localStorage.getItem('session');
    return session ? JSON.parse(session) : {};
}


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