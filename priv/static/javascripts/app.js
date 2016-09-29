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
var Boot;

Boot = (function() {
  function Boot() {
    this.setupNoty();
    this.setupFlash();
    this.setupAutosize();
    this.setupConfirm();
  }

  Boot.prototype.setupNoty = function() {
    $.noty.defaults.timeout = 2500;
    $.noty.defaults.animation.open = 'animated flipInX';
    $.noty.defaults.animation.close = 'animated flipOutX';
    $.noty.defaults.maxVisible = 1;
    $.noty.defaults.killer = true;
    return $.noty.defaults.dismissQueue = false;
  };

  Boot.prototype.setupFlash = function() {
    var $flash, text, type;
    $flash = $('[data-flash]').filter(function(i, v) {
      return $(v).text() !== '';
    });
    if ($flash.length) {
      type = $flash.first().data('flash');
      text = $flash.first().html();
      return noty({
        type: type,
        text: text
      });
    }
  };

  Boot.prototype.setupAutosize = function() {
    if ($('.js-autosize').length) {
      return autosize($('.js-autosize'));
    }
  };

  Boot.prototype.setupConfirm = function() {
    return $('[data-confirm]').each(function() {
      var text, url;
      text = $(this).data('confirm');
      url = $(this).attr('href');
      return $(this).on('click', function(e) {
        e.preventDefault();
        return swal({
          title: $('#app-config').data('confirm-title') || '',
          text: text,
          type: 'warning',
          showCancelButton: true
        }, function() {
          return window.location.href = url;
        });
      });
    });
  };

  return Boot;

})();

new Boot();
});

;require.register("config.coffee", function(exports, require, module) {
module.exports = {
  keenio: {
    dev: {
      projectId: "57aeaf313831444167e1fa35",
      writeKey: "b90d7934bb1d121351a8cad5ec0b4687a81f86e47186d2812cf531f3e7bb62025622b50482fa18d03565d7815f0eaebab74a444af9b7dbfa94fc7621eec1e8ef786da80339a9b642402c893a52b8967a5b7241df69783d2c782ed66f82f1cc47",
      readKey: "410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac"
    }
  },
  env: (function(_this) {
    return function() {
      var $selector;
      $selector = $('#app-config[data-environment]');
      if ($selector.length) {
        return $selector.data('environment');
      } else {
        console.log("[WARNING] Environment not specified, fallback to prod");
        return 'prod';
      }
    };
  })(this)
};
});

;require.register("controllers/app/classified/new.coffee", function(exports, require, module) {
var Classified_New, Controller,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Controller = require('core/controller');

Classified_New = (function(superClass) {
  extend(Classified_New, superClass);

  function Classified_New() {
    this.initAutosize = bind(this.initAutosize, this);
    this.setCharsCount = bind(this.setCharsCount, this);
    this.changeCharsCount = bind(this.changeCharsCount, this);
    this.initCharsCount = bind(this.initCharsCount, this);
    this.initBirthdayMask = bind(this.initBirthdayMask, this);
    return Classified_New.__super__.constructor.apply(this, arguments);
  }

  Classified_New.prototype.before = function() {
    return this.on('keyup', '#classified_description', this.changeCharsCount);
  };

  Classified_New.prototype.run = function() {
    this.initBirthdayMask();
    this.initCharsCount();
    return this.initAutosize();
  };

  Classified_New.prototype.initBirthdayMask = function() {
    return $('#classified_birthday').inputmask('99/99/9999', {
      placeholder: "jj/mm/aaaa"
    });
  };

  Classified_New.prototype.initCharsCount = function() {
    var length;
    length = $('#classified_description').val().length;
    return this.setCharsCount(length);
  };

  Classified_New.prototype.changeCharsCount = function() {
    var count;
    count = $('#classified_description').val().length;
    return this.setCharsCount(count);
  };

  Classified_New.prototype.setCharsCount = function(number) {
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

  Classified_New.prototype.initAutosize = function() {
    return autosize($('#classified_description'));
  };

  return Classified_New;

})(Controller);

module.exports = Classified_New;
});

;require.register("controllers/app/classified/show.coffee", function(exports, require, module) {
var Classified_Show, Controller, Keenio,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Controller = require('core/controller');

Keenio = require('helpers/keenio');

Classified_Show = (function(superClass) {
  extend(Classified_Show, superClass);

  function Classified_Show() {
    return Classified_Show.__super__.constructor.apply(this, arguments);
  }

  Classified_Show.prototype.before = function() {
    return this.on('click', '#show-phone', this.onShowPhone);
  };

  Classified_Show.prototype.run = function() {
    var client;
    return client = new Keenio().client.addEvent("classified.show", {
      classified_id: $('#app').data('classified')
    });
  };

  Classified_Show.prototype.onShowPhone = function() {
    var $phone, client;
    $phone = $('#phone');
    $phone.html($phone.data('phone'));
    $(this).remove();
    return client = new Keenio().client.addEvent("classified.show_phone", {
      classified_id: $('#app').data('classified')
    });
  };

  return Classified_Show;

})(Controller);

module.exports = Classified_Show;
});

;require.register("controllers/dashboard/analytics/index.coffee", function(exports, require, module) {
var Controller, Dashboard_Analytics_Index, Keenio,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Controller = require('core/controller');

Keenio = require('helpers/keenio');

Dashboard_Analytics_Index = (function(superClass) {
  extend(Dashboard_Analytics_Index, superClass);

  function Dashboard_Analytics_Index() {
    return Dashboard_Analytics_Index.__super__.constructor.apply(this, arguments);
  }

  Dashboard_Analytics_Index.prototype.before = function() {
    return this.setupStats();
  };

  Dashboard_Analytics_Index.prototype.run = function() {};

  Dashboard_Analytics_Index.prototype.setupStats = function() {
    return Keen.ready((function(_this) {
      return function() {
        _this.showCount({
          eventCollection: 'classified.new',
          timeframe: 'this_10_years',
          selector: 'total-classified',
          title: 'Total Classified'
        });
        _this.showCount({
          eventCollection: 'classified.new',
          timeframe: 'this_7_days',
          selector: 'total-classified-7-days',
          title: 'Added this week'
        });
        _this.showCount({
          eventCollection: 'classified.new',
          timeframe: 'this_1_days',
          selector: 'total-classified-today',
          title: 'Added today'
        });
        _this.showCount({
          eventCollection: 'classified.show_phone',
          timeframe: 'this_10_years',
          selector: 'total-show-phone',
          title: 'Total phone shown (classified)'
        });
        return _this.showCount({
          eventCollection: 'classified.show',
          timeframe: 'this_10_years',
          selector: 'total-show',
          title: 'Total classified seen'
        });
      };
    })(this));
  };

  Dashboard_Analytics_Index.prototype.showCount = function(options) {
    var query;
    query = new Keen.Query('count', {
      eventCollection: options.eventCollection,
      timeframe: options.timeframe,
      timezone: "UTC"
    });
    return new Keenio().client.draw(query, document.getElementById(options.selector), {
      title: options.title,
      colors: ['#897FBA']
    });
  };

  return Dashboard_Analytics_Index;

})(Controller);

module.exports = Dashboard_Analytics_Index;
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

;require.register("helpers/keenio.coffee", function(exports, require, module) {
var Config, Helpers_Keenio;

Config = require('config');

Helpers_Keenio = (function() {
  function Helpers_Keenio() {
    this.keys = Config.keenio[Config.env()];
    this.client = new Keen({
      projectId: this.keys.projectId,
      readKey: this.keys.readKey,
      writeKey: this.keys.writeKey
    });
  }

  return Helpers_Keenio;

})();

module.exports = Helpers_Keenio;
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