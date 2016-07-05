(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var expRe = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (expRe.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var hot = null;
    hot = hmr && hmr.createHot(name);
    var module = {id: name, exports: {}, hot: hot};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var expandAlias = function(name) {
    return aliases[name] ? expandAlias(aliases[name]) : name;
  };

  var _resolve = function(name, dep) {
    return expandAlias(expand(dirname(name), dep));
  };

  var require = function(name, loaderPath) {
    if (loaderPath == null) loaderPath = '/';
    var path = expandAlias(name);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    throw new Error("Cannot find module '" + name + "' from '" + loaderPath + "'");
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  var extRe = /\.[^.\/]+$/;
  var indexRe = /\/index(\.[^\/]+)?$/;
  var addExtensions = function(bundle) {
    if (extRe.test(bundle)) {
      var alias = bundle.replace(extRe, '');
      if (!has.call(aliases, alias) || aliases[alias].replace(extRe, '') === alias + '/index') {
        aliases[alias] = bundle;
      }
    }

    if (indexRe.test(bundle)) {
      var iAlias = bundle.replace(indexRe, '');
      if (!has.call(aliases, iAlias)) {
        aliases[iAlias] = bundle;
      }
    }
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          require.register(key, bundle[key]);
        }
      }
    } else {
      modules[bundle] = fn;
      delete cache[bundle];
      addExtensions(bundle);
    }
  };

  require.list = function() {
    var list = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        list.push(item);
      }
    }
    return list;
  };

  var hmr = globals._hmr && new globals._hmr(_resolve, require, modules, cache);
  require._cache = cache;
  require.hmr = hmr && hmr.wrap;
  require.brunch = true;
  globals.require = require;
})();

(function() {
var global = window;
var __makeRelativeRequire = function(require, mappings, pref) {
  var none = {};
  var tryReq = function(name, pref) {
    var val;
    try {
      val = require(pref + '/node_modules/' + name);
      return val;
    } catch (e) {
      if (e.toString().indexOf('Cannot find module') === -1) {
        throw e;
      }

      if (pref.indexOf('node_modules') !== -1) {
        var s = pref.split('/');
        var i = s.lastIndexOf('node_modules');
        var newPref = s.slice(0, i).join('/');
        return tryReq(name, newPref);
      }
    }
    return none;
  };
  return function(name) {
    if (name in mappings) name = mappings[name];
    if (!name) return;
    if (name[0] !== '.' && pref) {
      var val = tryReq(name, pref);
      if (val !== none) return val;
    }
    return require(name);
  }
};
require.register("boot.coffee", function(exports, require, module) {
$("#trigger-modal").animatedModal({
  color: '#F0F1F5',
  animatedIn: 'lightSpeedIn',
  animatedOut: 'bounceOutDown'
});
});

;require.register("config.coffee", function(exports, require, module) {
module.exports = {
  app: {
    name: 'My Gotham Application',
    version: 0.1
  }
};
});

;require.register("controllers/ad/new.coffee", function(exports, require, module) {
var AdNew, Controller,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Controller = require('core/controller');

AdNew = (function(superClass) {
  extend(AdNew, superClass);

  function AdNew() {
    this.initAutosize = bind(this.initAutosize, this);
    this.setCharsCount = bind(this.setCharsCount, this);
    this.changeCharsCount = bind(this.changeCharsCount, this);
    this.initCharsCount = bind(this.initCharsCount, this);
    this.initBirthdayMask = bind(this.initBirthdayMask, this);
    return AdNew.__super__.constructor.apply(this, arguments);
  }

  AdNew.prototype.before = function() {
    return this.on('keyup', '#ad_description', this.changeCharsCount);
  };

  AdNew.prototype.run = function() {
    this.initBirthdayMask();
    this.initCharsCount();
    return this.initAutosize();
  };

  AdNew.prototype.initBirthdayMask = function() {
    return $('#ad_birthday').inputmask('99/99/9999', {
      placeholder: "jj/mm/aaaa"
    });
  };

  AdNew.prototype.initCharsCount = function() {
    return this.setCharsCount(0);
  };

  AdNew.prototype.changeCharsCount = function() {
    var count;
    count = $('#ad_description').val().length;
    return this.setCharsCount(count);
  };

  AdNew.prototype.setCharsCount = function(number) {
    var $chars, minimum, text;
    $chars = $('#chars');
    minimum = $chars.data('min');
    text = $chars.data('text-number') + ': ' + number + ' (' + $chars.data('text-minimum') + ': ' + minimum + ')';
    $chars.html(text);
    if (number < minimum) {
      return $chars.css('color', '#E3000E');
    } else {
      return $chars.css('color', '#71BA51');
    }
  };

  AdNew.prototype.initAutosize = function() {
    return autosize($('#ad_description'));
  };

  return AdNew;

})(Controller);

module.exports = AdNew;
});

;require.register("controllers/example-controller.coffee", function(exports, require, module) {
var Controller, Example,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Controller = require('core/controller');

Example = (function(superClass) {
  extend(Example, superClass);

  function Example() {
    return Example.__super__.constructor.apply(this, arguments);
  }

  Example.prototype.before = function() {};

  Example.prototype.run = function() {};

  return Example;

})(Controller);

module.exports = Example;
});

;require.register("helpers.coffee", function(exports, require, module) {
_.mixin({
  isBatman: function(name) {
    if (name.toLowerCase() === "batman") {
      return true;
    }
    return false;
  }
});
});

;require.register("initialize.coffee", function(exports, require, module) {
var Bootstrap;

Bootstrap = require('core/bootstrap');

$(function() {
  var bootstrap;
  bootstrap = new Bootstrap();
  return bootstrap.run();
});
});

;require.register("validators.coffee", function(exports, require, module) {
Validator.errors;

Validator.attributes;
});

;require.register("core/bootstrap.coffee", function(exports, require, module) {
var Bootstrap;

Bootstrap = (function() {
  function Bootstrap() {}

  Bootstrap.prototype.run = function() {
    var controller, pathController;
    require('helpers');
    require('validators');
    require('boot');
    controller = $('#app').data('controller');
    if (controller == null) {
      return;
    }
    if (_.isEmpty(controller)) {
      return;
    }
    pathController = this._formatPath(controller);
    controller = require('controllers/' + pathController);
    controller = new controller($('#app').data());
    if (controller['before'] != null) {
      controller.before();
    }
    if (!controller._gothamStop) {
      return controller.run();
    }
  };

  Bootstrap.prototype._formatPath = function(str) {
    return str.split('.').join('/');
  };

  return Bootstrap;

})();

module.exports = Bootstrap;
});

;require.register("core/controller.coffee", function(exports, require, module) {
var Controller, View;

View = require('core/view');

Controller = (function() {
  Controller.prototype._gothamStop = false;

  function Controller(options) {
    this.options = options;
  }

  Controller.prototype.stop = function() {
    return this._gothamStop = true;
  };

  Controller.prototype.log = function(value) {
    return console.log(value);
  };

  Controller.prototype.on = function(trigger, selector, handler) {
    return $(selector).on(trigger, handler);
  };

  Controller.prototype.off = function(trigger, selector, handler) {
    return $(selector).off(trigger, handler);
  };

  Controller.prototype.delayed = function(trigger, selector, handler) {
    return $(document).on(trigger, selector, handler);
  };

  Controller.prototype.view = function(template, datas) {
    var view;
    view = new View();
    return view.render(template, datas);
  };

  return Controller;

})();

module.exports = Controller;
});

;require.register("core/view.coffee", function(exports, require, module) {
var View;

View = (function() {
  function View() {}

  View.prototype.render = function(template, datas) {
    template = template.split('.').join('/');
    template = require('views/' + template);
    return template(datas);
  };

  return View;

})();

module.exports = View;
});

;require.register("___globals___", function(exports, require, module) {
  
});})();require('___globals___');


//# sourceMappingURL=app.js.map