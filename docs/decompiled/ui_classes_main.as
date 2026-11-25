// ======== DoInitAction sprite=1 __Packages.com.extratoxic.core.Frame
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.core) {
    _global.com.extratoxic.core = new Object();
}
<stack?>;
if (!_global.com.extratoxic.core.Frame) {
    $r1 = function (movie, config, fps) {
            this.movie = movie;
            this.config = config;
            com.extratoxic.events.Run.initialize(movie, fps);
        };
    com.extratoxic.core.Frame = $r1;
    $r2 = $r1.prototype;
    $r2.createMovie = function (depth) {
            return this.movie.createEmptyMovieClip("layer_" + depth.toString(), depth);
        };
    $r2.__set___path = function (path) {
            this.path = path;
            return this.__get___path();
            <stack?>;
        };
    $r2.__get___path = function () {
            return this.path;
        };
    $r2.getFPS = function (Void) {
            if ((getTimer() - this.ms) > 1000) {
                this.fps = this.frame;
                this.frame = 0;
                this.ms = getTimer();
            } else {
                this.frame = this.frame + 1;
            }
            return this.fps;
        };
    $r2.fps = 0;
    $r2.frame = 0;
    $r2.ms = getTimer();
}
ASSetPropFlags(com.extratoxic.core.Frame.prototype, null, 1);
// ======== DoInitAction sprite=2 __Packages.com.extratoxic.events.Run
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events) {
    _global.com.extratoxic.events = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events.Run) {
    $r1 = function (movie) {
            AsBroadcaster.initialize(this);
            this.movie = movie;
            movie.fps = 34;
            movie.l = getTimer();
            this.start();
        };
    com.extratoxic.events.Run = $r1;
    $r2 = $r1.prototype;
    $r1.initialize = function (movie, framerate, fps) {
            if (com.extratoxic.events.Run.instance == undefined) {
                $r0 = new com.extratoxic.events.Run(movie, framerate, fps);
                com.extratoxic.events.Run.instance = $r0;
                return $r0;
            }
            delete com.extratoxic.events.Run.instance.movie.onEnterFrame;
            com.extratoxic.events.Run.instance.start();
        };
    $r1.hold = function (Void) {
            com.extratoxic.events.Run.instance.stop();
        };
    $r1.resume = function (Void) {
            com.extratoxic.events.Run.instance.start();
        };
    $r1.attach = function (obj) {
            return com.extratoxic.events.Run.instance.addListener(obj);
        };
    $r1.detach = function (obj) {
            return com.extratoxic.events.Run.instance.removeListener(obj);
        };
    $r1.reset = function (Void) {
            $r1 = com.extratoxic.events.Run.instance._listeners;
            while (true) {
                $r0 = /*enumerate*/ $r1;
                if ($r0 == null) break;
                $r2 = $r0;
                com.extratoxic.events.Run.instance.removeListener($r1[$r2]);
            }
            com.extratoxic.events.Run.resume();
        };
    $r2.start = function (Void) {
            this.movie.onEnterFrame = function () {
                        com.extratoxic.events.Run.instance.broadcastMessage("process");
                    };
        };
    $r2.stop = function (Void) {
            delete this.movie.onEnterFrame;
        };
}
ASSetPropFlags(com.extratoxic.events.Run.prototype, null, 1);
// ======== DoInitAction sprite=3 __Packages.com.extratoxic.events.Processable
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events) {
    _global.com.extratoxic.events = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events.Processable) {
    _global.com.extratoxic.events.Processable = function () {
        };
}
<stack?>;
// ======== DoInitAction sprite=4 __Packages.Control
if (!_global.Control) {
    $r1 = function (movie, config) {
            super(movie, config);
            _global.usecache = false;
            this.lang = _level0.l;
            if ((this.lang == undefined) || (((!(this.lang == "ned") && !(this.lang == "fra")) && !(this.lang == "eng")) && !(this.lang == "ger"))) {
                this.lang = "ger";
            }
            System.useCodepage = false;
            this.confXML = new XML();
            this.confXML.ignoreWhite = true;
            this.xmlLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(config, this.confXML));
            this.xmlLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "loadPreloader");
            this.xmlLoader.load();
        };
    _global.Control = $r1;
    _global.Control.extends(com.extratoxic.core.Frame);
    $r2 = $r1.prototype;
    $r2.loadPreloader = function (Void) {
            this.__set___path(com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "path"));
            this.textPath = ((this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "text")) + this.lang) + "/";
            this.mediaPath = this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "media");
            this.soundPath = this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "sounds");
            this.mediaPath = this.__get___path() + "K8dD6H3hDJ3DF/";
            this.preloaderScreen = this.createMovie(5);
            this.introLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "loader"), this.preloaderScreen));
            this.introLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "loadMain");
            this.introLoader.load();
        };
    $r2.loadMain = function (Void) {
            this.upixo = new Upixo();
            this.mainScreen = this.createMovie(3);
            this.introScreen = this.createMovie(4);
            this.worldmapXML = new XML();
            this.worldmapXML.ignoreWhite = true;
            this.impressumXML = new XML();
            this.impressumXML.ignoreWhite = true;
            this.contentXML = new XML();
            this.contentXML.ignoreWhite = true;
            this.gameXML = new XML();
            this.gameXML.ignoreWhite = true;
            this.introXML = new XML();
            this.introXML.ignoreWhite = true;
            this.helpXML = new XML();
            this.helpXML.ignoreWhite = true;
            this.soundLounge = new com.extratoxic.audio.SoundPackage(this.movie, 99);
            this.soundEffects = new com.extratoxic.audio.SoundPackage(this.movie);
            this.mainLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "main"), this.mainScreen, com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "main_kb")), new com.extratoxic.utils.Loader(this.textPath + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "worldmapxml"), this.worldmapXML, 2), new com.extratoxic.utils.Loader(this.textPath + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "impressumxml"), this.impressumXML, 3), new com.extratoxic.utils.Loader(this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "contentxml"), this.contentXML, 3), new com.extratoxic.utils.Loader(this.soundPath + "lounge.swf", this.soundLounge.getMovie(), 172), new com.extratoxic.utils.Loader(this.soundPath + "worldmap.swf", this.soundEffects.getMovie(), 10), new com.extratoxic.utils.Loader(this.textPath + "gamelevel.xml", this.gameXML, 1), new com.extratoxic.utils.Loader(this.textPath + "help.xml", this.helpXML, 3));
            if (!this.upixo.isVisited()) {
                this.introSound = this.createMovie(6);
                this.mainLoader.push(new com.extratoxic.utils.Loader(this.__get___path() + "intro.swf", this.introScreen, 100), new com.extratoxic.utils.Loader(this.textPath + "intro.xml", this.introXML, 5), new com.extratoxic.utils.Loader(this.soundPath + "intro.swf", this.introSound, 268));
            }
            this.mainLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "start");
            this.mainLoader.onLoading = com.extratoxic.events.Delegate.create(this, "preloading");
            this.mainLoader.load();
        };
    $r2.preloading = function (Void) {
            this.preloaderScreen.preloader.loaderbar._xscale = this.mainLoader._percent;
        };
    $r2.start = function (Void) {
            this.preloaderScreen.play();
            if (this.worldmap == undefined) {
                this.s_lounge = this.soundLounge.getNewSoundFile("track");
                this.worldmap = new Worldmap(this.mainScreen, this.lang, this.upixo);
                this.worldmap.setXML(this.worldmapXML, this.impressumXML, this.contentXML, this.gameXML, this.helpXML);
                this.worldmap.setPaths(this.__get___path(), this.textPath, this.soundPath, this.mediaPath);
                this.worldmap.setSounds(this.s_lounge, this.soundEffects);
                this.worldmap.showIntro = com.extratoxic.events.Delegate.create(this, "showIntro");
                this.worldmap.initialize();
            }
            this.introScreen.introXML = this.introXML;
            this.introScreen.snd = this.introSound;
            this.introScreen.soundLounge = this.soundLounge;
            this.introScreen.startWorldmap = com.extratoxic.events.Delegate.create(this, "startWorldmap");
            this.introScreen.play();
            this.mainScreen.worldmap._visible = false;
            if (this.introScreen.intro == undefined) {
                this.startWorldmap();
            }
        };
    $r2.startWorldmap = function (Void) {
            stopAllSounds();
            this.introScreen.unloadMovie();
            this.mainScreen.worldmap._visible = true;
            this.s_lounge.fadeIn();
        };
    $r2.showIntro = function (Void) {
            this.preloaderScreen.gotoAndStop(1);
            this.preloaderScreen._visible = true;
            this.preloaderScreen._x = 0;
            this.introSound = this.createMovie(6);
            this.mainLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.__get___path() + "intro.swf", this.introScreen, 100), new com.extratoxic.utils.Loader(this.textPath + "intro.xml", this.introXML, 5), new com.extratoxic.utils.Loader(this.soundPath + "intro.swf", this.introSound, 268));
            this.mainLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "start");
            this.mainLoader.onLoading = com.extratoxic.events.Delegate.create(this, "preloading");
            this.mainLoader.load();
        };
    $r2.process = function () {
        };
}
ASSetPropFlags(_global.Control.prototype, null, 1);
// ======== DoInitAction sprite=5 __Packages.Upixo
if (!_global.Upixo) {
    $r1 = function () {
            this.cookie = SharedObject.getLocal("upixo", "/");
            if (this.cookie.data.container == undefined) {
                this.cookie.data.container = [false, false, false, false];
            }
            this.cookie.flush();
        };
    _global.Upixo = $r1;
    $r2 = $r1.prototype;
    $r2.isVisited = function (Void) {
            return this.cookie.data.intro;
        };
    $r2.visited = function (Void) {
            $r2 = parseInt(this.cookie.data.visits);
            if ($r2.toString() == "NaN") {
                $r2 = 0;
            }
            $r2 = $r2 + 1;
            this.cookie.data.visits = $r2;
            this.cookie.data.intro = true;
            this.cookie.flush();
        };
    $r2.test = function (days, bonus) {
            $r3 = new Array();
            $r4 = new Array();
            $r2 = 0;
            while (!!!($r2 > 24)) {
                if ($r2 < days) {
                    $r3[$r2] = bonus;
                    $r4[$r2] = $r2;
                } else {
                    $r3[$r2] = undefined;
                }
                $r2 = $r2 + 1;
            }
            this.cookie.data.container[0] = true;
            this.cookie.data.container[1] = true;
            this.cookie.data.container[2] = true;
            this.cookie.data.container[3] = true;
            this.cookie.data.doors = $r3;
            this.cookie.data.lab = $r4;
            this.cookie.flush();
        };
    $r2.played = function (newday, bonus, container) {
            $r3 = newday;
            $r6 = this.cookie.data.doors;
            if ($r6 == undefined) {
                $r6 = new Array();
            }
            if (!$r6[$r3]) {
                $r6[$r3] = bonus;
            }
            $r4 = this.cookie.data.lab;
            if ($r4 == undefined) {
                $r4 = new Array();
            }
            $r2 = 0;
            while ($r2 < $r4.length) {
                if ($r4[$r2] == $r3) {
                    $r5 = true;
                }
                $r2 = $r2 + 1;
            }
            if (($r5 == undefined) && !($r2 == 24)) {
                $r4.splice(0, 0, $r3);
            }
            if (container) {
                if (!($r3 < 1) && !($r3 > 6)) {
                    this.cookie.data.container[0] = true;
                } else {
                    if (!($r3 < 7) && !($r3 > 12)) {
                        this.cookie.data.container[1] = true;
                    } else {
                        if (!($r3 < 13) && !($r3 > 18)) {
                            this.cookie.data.container[2] = true;
                        } else {
                            if (!($r3 < 19) && !($r3 > 24)) {
                                this.cookie.data.container[3] = true;
                            }
                        }
                    }
                }
            }
            this.cookie.data.doors = $r6;
            this.cookie.data.lab = $r4;
            this.cookie.flush();
        };
    $r2.checkContainer = function (day) {
            if ((!(day < 1) && !(day > 6)) && this.cookie.data.container[0]) {
                return true;
            } else {
                if ((!(day < 7) && !(day > 12)) && this.cookie.data.container[1]) {
                    return true;
                } else {
                    if ((!(day < 13) && !(day > 18)) && this.cookie.data.container[2]) {
                        return true;
                    } else {
                        if ((!(day < 19) && !(day > 24)) && this.cookie.data.container[3]) {
                            return true;
                        }
                    }
                }
            }
            return false;
        };
    $r2.readyForElPix = function (Void) {
            $r4 = true;
            $r3 = this.cookie.data.doors;
            $r2 = 0;
            while ($r2 < 24) {
                if ($r3[$r2] == undefined) {
                    $r4 = false;
                }
                $r2 = $r2 + 1;
            }
            return $r4;
        };
    $r2.is576 = function (level) {
            _global.complete576 = true;
            $r4 = this.cookie.data.doors;
            $r3 = 0;
            while ($r3 < 24) {
                if ((($r4[$r3] == undefined) || !$r4[$r3]) && !(level == $r3)) {
                    _global.complete576 = false;
                }
                $r3 = $r3 + 1;
            }
        };
    $r2.isComplete = function (Void) {
            $r3 = true;
            $r4 = this.cookie.data.doors;
            $r2 = 0;
            while ($r2 < 25) {
                if ($r4[$r2] == undefined) {
                    $r3 = false;
                }
                $r2 = $r2 + 1;
            }
            return $r3;
        };
    $r2.getContainer = function (Void) {
            return this.cookie.data.container;
        };
    $r2.showIntro = function (Void) {
            this.cookie.data.intro = false;
            this.cookie.flush();
        };
    $r2.getDoors = function (Void) {
            return this.cookie.data.doors;
        };
    $r2.getDoor = function (day) {
            return this.cookie.data.doors[day];
        };
    $r2.getLabList = function (Void) {
            return this.cookie.data.lab;
        };
    $r2.getStats = function (Void) {
            $r5 = this.cookie.data.doors;
            $r4 = "";
            $r3 = 0;
            while ($r3 < 24) {
                $r2 = $r3 + 1;
                if ($r2.toString().length == 1) {
                    $r2 = "0" + $r2;
                }
                if ($r5[$r3] == undefined) {
                    $r4 = $r4 + ($r2 + ". - | ");
                } else {
                    if (!$r5[$r3]) {
                        $r4 = $r4 + ($r2 + ". f | ");
                    } else {
                        if ($r5[$r3]) {
                            $r4 = $r4 + ($r2 + ". K | ");
                        }
                    }
                }
                if ((($r3 == 5) || ($r3 == 11)) || ($r3 == 17)) {
                    $r4 = $r4 + "\n";
                }
                $r3 = $r3 + 1;
            }
            $r7 = this.cookie.data.container;
            $r6 = "";
            $r3 = 0;
            while ($r3 < $r7.length) {
                if ($r7[$r3]) {
                    $r6 = $r6 + (("welt " + ($r3 + 1)) + " ja | ");
                } else {
                    $r6 = $r6 + (("welt " + ($r3 + 1)) + " nein | ");
                }
                $r3 = $r3 + 1;
            }
            return (((("visits: " + this.cookie.data.visits) + "\nlevel:\n") + $r4) + "\ncontainer: ") + $r6;
        };
    $r2.reset = function (Void) {
            this.cookie.clear();
        };
}
ASSetPropFlags(_global.Upixo.prototype, null, 1);
// ======== DoInitAction sprite=6 __Packages.com.extratoxic.utils.LoadStack
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils) {
    _global.com.extratoxic.utils = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils.LoadStack) {
    $r1 = function () {
            super();
            $r4 = 0;
            while ($r4 < arguments.length) {
                this.push(arguments[$r4]);
                $r4 = $r4 + 1;
            }
            var $old1 = com.extratoxic.utils.LoadStack.idcnt;
            com.extratoxic.utils.LoadStack.idcnt = com.extratoxic.utils.LoadStack.idcnt + 1;
            this.id = $old1;
            $r4 = 0;
            while ($r4 < this.length) {
                $r4 = $r4 + 1;
            }
            this.cache = false;
            this.isLoaded = false;
            loaded = false;
            this.pointer = 0;
            this.loading = false;
        };
    com.extratoxic.utils.LoadStack = $r1;
    com.extratoxic.utils.LoadStack.extends(Array);
    $r2 = $r1.prototype;
    $r2.__get___percent = function () {
            $r3 = 0;
            $r4 = 0;
            $r2 = 0;
            while ($r2 < this.length) {
                $r3 = $r3 + this[$r2]._total;
                $r4 = $r4 + this[$r2]._loaded;
                $r2 = $r2 + 1;
            }
            return int(($r4 * 100) / $r3);
        };
    $r2.load = function (Void) {
            if (!this.loading) {
                com.extratoxic.events.Run.attach(this);
            }
            this.loading = true;
            if (this.pointer < this.length) {
                var $old2 = this.pointer;
                this.pointer = this.pointer + 1;
                this.currentLoader = this[$old2];
                this.currentLoader.addListener(this);
                this.currentLoader.load();
            } else {
                this.loading = false;
                this.isLoaded = true;
                com.extratoxic.events.Run.detach(this);
                this.onLoadStackComplete();
            }
        };
    $r2.onLoaderComplete = function (Void) {
            this.currentLoader.removeListener(this);
            this.load();
        };
    $r2.stop = function (Void) {
            this.pointer = this.pointer - 1;
            this.currentLoader.removeListener(this);
            com.extratoxic.events.Run.detach(this);
            $r2 = 0;
            while ($r2 < this.length) {
                this[$r2].unloadMovie();
                $r2 = $r2 + 1;
            }
            this.loading = false;
            this.isLoaded = false;
        };
    $r2.process = function () {
            this.onLoading();
        };
    $r2.toString = function () {
            return ("[LoadStack lenght: " + this.length) + "]";
        };
    $r1.idcnt = 0;
}
ASSetPropFlags(com.extratoxic.utils.LoadStack.prototype, null, 1);
// ======== DoInitAction sprite=7 __Packages.com.extratoxic.utils.Loader
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils) {
    _global.com.extratoxic.utils = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils.Loader) {
    $r1 = function (url, container, total) {
            this.url = url;
            this.url_param = url;
            if (!!!(_level0._url.indexOf("http://") == -1)) {
                this.url_param = this.url_param + ("?t=" + new Date().getTime());
            }
            this.container = container;
            this.__set___total(total * 1024);
            this.__set___loaded(0);
            this.isLoaded = false;
            AsBroadcaster.initialize(this);
            this.addListener(this);
        };
    com.extratoxic.utils.Loader = $r1;
    $r2 = $r1.prototype;
    $r2.__set___total = function (bytes) {
            this.total = bytes;
            return this.__get___total();
            <stack?>;
        };
    $r2.__get___total = function () {
            return this.total;
        };
    $r2.__set___loaded = function (bytes) {
            this.loaded = bytes;
            return this.__get___loaded();
            <stack?>;
        };
    $r2.__get___loaded = function () {
            return this.loaded;
        };
    $r2.load = function (Void) {
            this.timeout = 0;
            if (_global.usecache && !(_level0._url.indexOf("http://") == -1)) {
                $r3 = new Date();
                $r0 = this.url + (("?t=" + $r3.getHours()) + $r3.getDate());
                this.url = $r0;
                this.url_param = $r0;
            }
            if (typeof this.container == "movieclip") {
                this.container.loadMovie(this.url_param);
            } else {
                if (this.container instanceof XML) {
                    this.container.load(this.url_param);
                }
            }
            com.extratoxic.events.Run.attach(this);
        };
    $r2.process = function () {
            $r3 = this.container.getBytesLoaded();
            $r2 = this.container.getBytesTotal();
            if (!(this.container._url.indexOf(this.url) == -1) && ($r2 > -1)) {
                this.__set___total($r2);
                this.__set___loaded($r3);
                if ((this.__get___loaded() == 0) && (this.__get___total() > 0)) {
                    $r0 = this.timeout + 1;
                    this.timeout = $r0;
                    if ($r0 > 200) {
                        this.load();
                    }
                }
                if ((typeof this.container == "movieclip") && (this.container.loaded == undefined)) {
                    this.container.loaded = true;
                }
                if (($r3 == $r2) && this.container.loaded) {
                    var $old1 = this.delay;
                    this.delay = this.delay - 1;
                    if ($old1 > 0) {
                        return;
                    }
                    this.isLoaded = true;
                    this.container.loaded = true;
                    delete this.container.t;
                    this.broadcastMessage("onLoaderComplete");
                    com.extratoxic.events.Run.detach(this);
                }
            }
        };
    $r2.toString = function () {
            return ("[Loader " + this.url) + "]";
        };
    $r2.timeout = 0;
    $r2.delay = 1;
}
ASSetPropFlags(com.extratoxic.utils.Loader.prototype, null, 1);
// ======== DoInitAction sprite=8 __Packages.Worldmap
if (!_global.Worldmap) {
    $r1 = function (movie, lang, upixo) {
            this.movie = movie;
            this.lang = lang;
            this.upixo = upixo;
        };
    _global.Worldmap = $r1;
    $r2 = $r1.prototype;
    $r2.initialize = function () {
            _level0.musicvol = 100;
            _global.gameOver = new Object();
            _global.is576 = com.extratoxic.events.Delegate.create(this, "is576");
            this.s_global = new Sound(_root);
            this.intializeTopics();
            this.initializeText();
            this.initializeButtons();
            this.s_piep = this.soundEffects.getNewSoundFile("piep2");
            this.s_rollover = this.soundEffects.getNewSoundFile("over");
            this.s_credits_pkg = new com.extratoxic.audio.SoundPackage(this.movie, 99);
            this.currentMovie = this.movie.worldmap;
            this.lastMovie = this.currentMovie;
            this.upixo.visited();
            this.movie.cookie_button.onPress = com.extratoxic.events.Delegate.create(this, "resetCookie");
            this.movie.worldmap._visible = true;
            this.loadDay();
            this.intervalId = _global.setInterval(this, "loadDay", 180000);
        };
    $r2.setCurrentdate = function (newdate) {
            if (parseInt(newdate).toString() == "NaN") {
                $r4 = new Date();
                newdate = $r4.getTime() / 1000;
                newdate = newdate + 432000;
            }
            this.currentdate = new Date(newdate * 1000);
            $r3 = new TextFormat();
            $r3.letterSpacing = 0.5;
            this.movie.worldmap.date_txt.text = this.getCurrentdate();
            this.movie.worldmap.date_txt.setTextFormat($r3);
            this.prepareDoors();
        };
    $r2.setXML = function (worldmapXML, impressumXML, contentXML, gameXML, helpXML) {
            this.worldmapXML = worldmapXML;
            this.impressumXML = impressumXML;
            this.contentXML = contentXML;
            this.gameXML = gameXML;
            this.helpXML = helpXML;
        };
    $r2.setPaths = function (_path, textPath, soundPath, mediaPath) {
            this._path = _path;
            this.textPath = textPath;
            this.soundPath = soundPath;
            this.mediaPath = mediaPath;
        };
    $r2.setSounds = function (s_lounge, soundEffects) {
            this.s_lounge = s_lounge;
            this.soundEffects = soundEffects;
        };
    $r2.intializeTopics = function (Void) {
            this.movie.impressum.loaded = true;
            this.movie.worldmap.loaded = true;
            this.movie.game.loaded = true;
        };
    $r2.initializeText = function (Void) {
            $r3 = new TextFormat();
            $r3.letterSpacing = 0.5;
            this.movie.worldmap.lab_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_03_labor");
            this.movie.worldmap.help_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_02_help");
            this.movie.worldmap.intro_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_01_intro");
            this.movie.worldmap.feedback_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_04_feedback");
            this.movie.worldmap.credits_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_06_credits");
            this.movie.credits.credits_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_06_credits");
            this.movie.worldmap.hinweis_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_info_01_date");
            this.movie.worldmap.lab_txt.setTextFormat($r3);
            this.movie.worldmap.help_txt.setTextFormat($r3);
            this.movie.worldmap.intro_txt.setTextFormat($r3);
            this.movie.worldmap.feedback_txt.setTextFormat($r3);
            this.movie.worldmap.credits_txt.setTextFormat($r3);
            this.movie.copyright_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_footer_02_copyright");
            this.movie.copyright_txt.setTextFormat($r3);
            $r3 = new TextFormat();
            $r3.letterSpacing = 1;
            this.movie.impressum_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_footer_01_impressum");
            this.movie.impressum_txt.setTextFormat($r3);
            $r3 = new TextFormat();
            $r3.letterSpacing = 0.5;
            this.movie.impressum.title_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_footer_01_impressum");
            this.movie.impressum.title_txt.setTextFormat($r3);
            $r2 = this.impressumXML.firstChild.firstChild.firstChild.toString();
            $r2 = $r2.split("\r\n").join("\r");
            $r2 = $r2.split("&amp;").join("&");
            $r2 = $r2.split("&lt;").join("<");
            $r2 = $r2.split("&gt;").join(">");
            $r2 = $r2.split("&quot;").join("\"");
            this.movie.impressum.impressum_txt.htmlText = $r2;
            this.movie.help.help_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_02_help");
            this.movie.help.help_txt.setTextFormat($r3);
            $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_story_02_copy1");
            this.movie.help.story.story1 = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_story_02_copy1");
            this.movie.help.story.story2 = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_story_03_copy2");
            this.movie.help.story.story_txt.htmlText = $r5;
            this.movie.help.kristall_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_legende_02_kristall");
            this.movie.help.tuer_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_legende_03_tuer");
            this.movie.help.tueroffen_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_legende_05_tueroffen");
            this.movie.help.tuerkristall_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_legende_04_tuerkristall");
            this.movie.help.labor_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_legende_06_labor");
            $r4 = com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_anzeige_01_headline");
            $r4 = $r4 + ("<br />" + com.extratoxic.utils.XMLUtil.getValueByName(this.helpXML, "help_anzeige_02_copy"));
            this.movie.help.hinweis_txt.htmlText = $r4;
            this.initializeFeedback();
        };
    $r2.initializeButtons = function (Void) {
            this.movie.game.sound_switch.sound_on = com.extratoxic.events.Delegate.create(this, "sound_on");
            this.movie.game.sound_switch.sound_off = com.extratoxic.events.Delegate.create(this, "sound_off");
            this.movie.impressum_bt.onPress = com.extratoxic.events.Delegate.create(this, "showImpressum", true);
            this.movie.worldmap.lab_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "lab");
            this.movie.worldmap.help_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "help");
            this.movie.worldmap.intro_bt.onPress = com.extratoxic.events.Delegate.create(this, "intro");
            this.movie.worldmap.feedback_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "feedback");
            this.movie.worldmap.credits_bt.onPress = com.extratoxic.events.Delegate.create(this, "loadCredits");
            this.movie.credits.close_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.worldmap.credits_bt._visible = true;
            this.movie.worldmap.credits_txt._visible = true;
            this.movie.game.close_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.game.report.lab_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "lab");
            this.movie.game.report.worldmap_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.help.close_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.feedback.close_bt.onPress = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.feedback.closeWindow = com.extratoxic.events.Delegate.create(this, "showTopic", "worldmap");
            this.movie.impressum.close_bt.onPress = com.extratoxic.events.Delegate.create(this, "showImpressum", false);
            this.movie.impressum.close1_bt.onPress = com.extratoxic.events.Delegate.create(this, "showImpressum", false);
        };
    $r2.sound_on = function (Void) {
            _level0.musicvol = 100;
            _level0.music_start.setVolume(_level0.musicvol);
            _level0.music.setVolume(_level0.musicvol);
        };
    $r2.sound_off = function (Void) {
            _level0.musicvol = 25;
            _level0.music_start.setVolume(_level0.musicvol);
            _level0.music.setVolume(_level0.musicvol);
        };
    $r2.loadCredits = function (Void) {
            $r2 = this.movie.credits;
            this.s_lounge.fadeTo(0);
            this.reload = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.soundPath + "credits.swf", this.s_credits_pkg.getMovie()), new com.extratoxic.utils.Loader(this._path + "credits.swf", this.movie.credits.container, 141));
            this.reload.onLoading = com.extratoxic.events.Delegate.create(this, "preloading");
            this.reload.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "initializeCredits");
            this.reload.load();
            this.movie.preloader.gotoAndPlay("fadein");
        };
    $r2.initializeCredits = function (Void) {
            this.showTopic("credits");
            this.movie.credits.container.worldmapXML = this.worldmapXML;
            this.movie.credits.container.bonus = com.extratoxic.events.Delegate.create(_root, "getURL", this.mediaPath + "27_SpecialDownloads/SpecialDownloads.zip", "_blank");
            this.s_credits = this.s_credits_pkg.getNewSoundFile("track");
            this.s_credits.start(0, 999);
            this.s_credits.fadeTo(100);
            this.movie.preloader.gotoAndPlay("fadeout");
            this.movie.credits.container.gotoAndStop(2);
        };
    $r2.downloadBonus = function (Void) {
        };
    $r2.initializeLab = function (Void) {
            this.lab = new Lab(this.movie.lab.lab, this.labContent, this.mediaPath, this.laborXML, this.lang, this.s_lounge, this.soundEffects);
            this.lab.getMovie().blase.exit_button.onPress = com.extratoxic.events.Delegate.create(this, "closeLab");
            this.lastMovie = this.currentMovie;
            this.currentMovie._visible = false;
            this.currentMovie = this.movie.lab;
            this.currentMovie._visible = true;
            this.movie.preloader.gotoAndPlay("fadeout");
            this.s_lounge.fadeTo(30);
            this.lab.initialize(this.lastGame);
        };
    $r2.intro = function (Void) {
            this.s_lounge.fadeTo(0);
            this.movie.worldmap._visible = false;
            this.showIntro();
        };
    $r2.loadLab = function (Void) {
            $r7 = this.movie.lab;
            this.reload = new com.extratoxic.utils.LoadStack();
            _global.usecache = true;
            if ($r7.loaded == undefined) {
                _global.usecache = false;
                this.laborXML = new XML();
                this.laborXML.ignoreWhite = true;
                this.reload.push(new com.extratoxic.utils.Loader(this._path + "lab.swf", $r7, 126), new com.extratoxic.utils.Loader(this.textPath + "labor.xml", this.laborXML, 1));
            }
            $r5 = this.upixo.getLabList();
            this.labContent = new Array();
            $r3 = 0;
            while ($r3 < $r5.length) {
                $r4 = com.extratoxic.utils.XMLUtil.getValueByName(this.contentXML, ($r5[$r3] + 1).toString());
                if (!($r4 == undefined) && !($r4 == "25_ElPix")) {
                    this.labContent[$r3] = {name: $r4};
                    this.labContent[$r3].infoXML = new XML();
                    this.labContent[$r3].infoXML.ignoreWhite = true;
                    this.labContent[$r3].mediaXML = new XML();
                    this.labContent[$r3].mediaXML.ignoreWhite = true;
                    this.reload.push(new com.extratoxic.utils.Loader((this.textPath + $r4) + ".xml", this.labContent[$r3].infoXML, 1), new com.extratoxic.utils.Loader((this.mediaPath + $r4) + "/media.xml", this.labContent[$r3].mediaXML, 1));
                }
                $r3 = $r3 + 1;
            }
            this.movie.preloader.gotoAndPlay("fadein");
            this.reload.onLoading = com.extratoxic.events.Delegate.create(this, "preloading");
            this.reload.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "initializeLab");
            this.reload.load();
        };
    $r2.closeLab = function (topic) {
            this.lab.reset();
            this.s_lounge.fadeTo(100);
            if (topic == undefined) {
                this.showTopic("worldmap");
            } else {
                this.showTopic();
            }
        };
    $r2.loadGame = function (level, restart) {
            this.s_lounge.fadeTo(0);
            _global.gameOver.cancel = com.extratoxic.events.Delegate.create(this, "restartGame", level);
            this.movie.game.report._visible = false;
            $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.contentXML, level.toString());
            $r6 = (((this.mediaPath + $r5) + "/") + $r5) + ".jpg";
            $r3 = level;
            if (!($r3 < 1) && !($r3 > 6)) {
                $r7 = "world_lake.png";
            } else {
                if (!($r3 < 7) && !($r3 > 12)) {
                    $r7 = "world_forest.png";
                } else {
                    if (!($r3 < 13) && !($r3 > 18)) {
                        $r7 = "world_mountains.png";
                    } else {
                        if (!($r3 < 19) && !($r3 > 25)) {
                            $r7 = "world_cave.png";
                        }
                    }
                }
            }
            this.reload = new com.extratoxic.utils.LoadStack();
            if (!restart) {
                this.gameinfoXML = new XML();
                this.gameinfoXML.ignoreWhite = true;
                this.reload.push(new com.extratoxic.utils.Loader((this.textPath + $r5) + ".xml", this.gameinfoXML, 1), new com.extratoxic.utils.Loader($r6, this.movie.game.artwork, 70), new com.extratoxic.utils.Loader((this._path + "levels/") + $r7, this.movie.game.bildchen, 5));
                this.reload.onLoading = com.extratoxic.events.Delegate.create(this, "preloading");
                this.reload.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "initializeGame", level);
                this.reload.load();
                this.movie.preloader.gotoAndPlay("fadein");
            } else {
                this.initializeGame(level);
            }
        };
    $r2.initializeGame = function (level) {
            this.movie.preloader.gotoAndPlay("fadeout");
            this.movie.game.reset = false;
            _global.gameOver.door = level - 1;
            _global.gameOver.goal = false;
            _global.gameOver.bonus = false;
            _global.gameOver.container = false;
            _global.c = this.upixo.getContainer();
            _global.level_complete = this.upixo.getDoor(level - 1);
            if (_global.level_complete == undefined) {
                _global.gameOver.finish = com.extratoxic.events.Delegate.create(this, "closeGame");
            } else {
                _global.gameOver.finish = com.extratoxic.events.Delegate.create(this, "replayGame");
            }
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.contentXML, level.toString());
            if (level.toString().length == 1) {
                $r7 = "0" + level;
            } else {
                $r7 = level;
            }
            $r3 = level;
            if (!($r3 < 1) && !($r3 > 6)) {
                _global.world = 1;
            } else {
                if (!($r3 < 7) && !($r3 > 12)) {
                    _global.world = 2;
                } else {
                    if (!($r3 < 13) && !($r3 > 18)) {
                        _global.world = 3;
                    } else {
                        if (!($r3 < 19) && !($r3 > 25)) {
                            _global.world = 4;
                        }
                    }
                }
            }
            this.movie.game.level_txt.text = "LEVEL " + $r7;
            $r6 = new TextFormat();
            $r6.letterSpacing = 0.5;
            $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.gameinfoXML, "navi");
            $r5 = $r5.split("<br />").join(" ");
            this.movie.game.game_txt.text = $r5;
            this.movie.game.game_txt.setTextFormat($r6);
            $r6 = new TextFormat();
            $r6.letterSpacing = 0.7;
            this.movie.game.tipp_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.gameXML, "gamelevel_tipp_01");
            this.movie.game.tipp_txt.setTextFormat($r6);
            this.movie.game.report.lab_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_03_labor");
            this.movie.game.report.worldmap_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_05_mainmap");
            if (!!!(_level0._url.indexOf("http://") == -1)) {
                $r8 = "?=" + new Date().getTime();
            } else {
                $r8 = "";
            }
            this.movie.game.container.loadMovie("gamestart.swf" + $r8);
        };
    $r2.restartGame = function (level) {
            this.resetGame();
            this.loadGame(level, true);
        };
    $r2.stopSchwabbel = function (Void) {
            this.movie.game.report.schwabbel.schwabbel.gotoAndStop(1);
        };
    $r2.closeGame = function () {
            if (!!!(_global.gameOver.door == 24)) {
                this.s_lounge.fadeTo(100);
                $r3 = new TextFormat();
                $r3.letterSpacing = 1;
                $r6 = this.movie.game.report.schwabbel.report_txt;
                $r6.htmlText = "";
                $r8 = com.extratoxic.utils.XMLUtil.getValueByName(this.gameinfoXML, "title");
                $r4 = com.extratoxic.utils.XMLUtil.getValueByName(this.gameXML, "gamelevel_finished_01_headline");
                $r4 = $r4.split("<games_name>").join($r8);
                $r5 = com.extratoxic.events.Delegate.create(this, "stopSchwabbel");
                this.s_piep.setVolume(100);
                this.ticker = new utils.Ticker($r4, $r6, $r3, this.s_piep, $r5);
                this.movie.game.report._visible = true;
                this.movie.game.report.schwabbel.speech = this.ticker;
                this.movie.game.report.schwabbel.gotoAndPlay("start");
            }
            this.lastGame = _global.gameOver.door;
            if (_global.gameOver.goal) {
                this.saveCookie();
            }
            if (this.upixo.readyForElPix()) {
                $r7 = com.extratoxic.utils.XMLUtil.getValueByName(this.gameXML, "gamelevel_24finished_01_elpix");
                this.movie.game.report.schwabbel.speech2 = new utils.Ticker($r7, this.movie.game.report.schwabbel.report_txt, $r3, this.s_piep, $r5);
            } else {
                this.movie.game.report.schwabbel.speech2 = undefined;
            }
            this.loadDay();
            this.movie.worldmap._visible = false;
            this.resetGame();
            if (!!!(this.lastGame == _global.gameOver.door)) {
                _global.usecache = false;
            }
            if (_global.gameOver.door == 24) {
                this.loadCredits();
            }
        };
    $r2.saveCookie = function (Void) {
            this.upixo.played(_global.gameOver.door, _global.gameOver.bonus, _global.gameOver.container);
        };
    $r2.replayGame = function () {
            this.saveCookie();
            this.loadDay();
            this.resetGame();
            this.showTopic("worldmap");
        };
    $r2.resetGame = function () {
            _global.usecache = true;
            this.movie.game.container.unloadMovie();
            this.movie.game.reset = true;
            com.extratoxic.events.Run.reset();
        };
    $r2.prepareDoors = function (Void) {
            $r5 = this.upixo.getDoors();
            $r7 = this.getDay();
            $r6 = this.upixo.readyForElPix();
            $r3 = 1;
            while (!!!($r3 > 25)) {
                $r2 = this.movie.worldmap["tuer_" + $r3];
                $r4 = $r2.button;
                $r2._visible = true;
                $r2.gotoAndStop($r3);
                $r2.level = "level_" + $r3;
                $r2.num = $r3;
                $r2.bg._visible = false;
                if ($r5[$r3 - 1] == undefined) {
                    $r2.crystal._visible = false;
                }
                if (!($r3 > $r7) || (($r3 == 25) && $r6)) {
                    if (!!!($r5[$r3 - 1] == undefined)) {
                        $r2.bg._visible = true;
                        $r2.black._visible = false;
                        $r2.crystal._visible = true;
                        if (!!$r5[$r3 - 1]) {
                            $r2.crystal.gotoAndStop(2);
                        }
                        $r4.onRollOver = null;
                        $r4.onRollOut = null;
                    } else {
                        $r4.onRollOver = function () {
                                                this._parent.tuer.gotoAndPlay("open");
                                            };
                        $r4.onRollOut = function () {
                                                this._parent.tuer.gotoAndPlay("close");
                                            };
                    }
                    this.s_rollover.setVolume(30);
                    $r2.tuer.s_rollover = this.s_rollover;
                    $r4.startGame = com.extratoxic.events.Delegate.create(this, "showTopic", "game", $r3);
                    $r4.onPress = function () {
                                        this.s_rollover.start();
                                        _level0.level = this._parent.level;
                                        this.startGame();
                                        this._parent.tuer.gotoAndPlay("close");
                                    };
                } else {
                    $r4.useHandCursor = false;
                }
                $r3 = $r3 + 1;
            }
            if (!$r6) {
                this.movie.worldmap.tuer_25._visible = false;
            }
            this.movie.worldmap.credits_bt._visible = true;
            this.movie.worldmap.credits_txt._visible = true;
        };
    $r2.showTopic = function (newtopic, num) {
            _quality = "high";
            this.ticker.stop();
            this.movie.game.report.schwabbel.speech = null;
            this.movie.game.report.schwabbel.speech2 = null;
            this.movie.game.artwork.unloadMovie();
            this.s_credits.fadeTo(0);
            if (newtopic == undefined) {
                newtopic = this.lastMovie._name;
            }
            if ((this.currentMovie._name == "game") && !this.movie.game.reset) {
                this.resetGame();
            }
            if (newtopic == "worldmap") {
                this.s_lounge.fadeTo(100);
            }
            if (newtopic == "lab") {
                this.loadLab();
            } else {
                this.lastMovie = this.currentMovie;
                this.currentMovie._visible = false;
                this.currentMovie = this.movie[newtopic];
                this.currentMovie._visible = true;
            }
            if (newtopic == "game") {
                this.loadGame(num);
            } else {
                if (newtopic == "feedback") {
                    this.initializeFeedback();
                }
            }
        };
    $r2.showImpressum = function (show) {
            if (show) {
                _quality = "high";
            } else {
                if (this.currentMovie._name == "game") {
                    _quality = "low";
                }
            }
            this.movie.impressum._visible = show;
        };
    $r2.initializeFeedback = function (Void) {
            $r2 = new TextFormat();
            $r2.letterSpacing = 0.5;
            this.movie.feedback.feedback_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_buttons_04_feedback");
            this.movie.feedback.feedback_txt.setTextFormat($r2);
            this.movie.feedback.head_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_01_head");
            this.movie.feedback.head_txt.setTextFormat($r2);
            this.movie.feedback.name_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_02_name");
            this.movie.feedback.name_txt.setTextFormat($r2);
            this.movie.feedback.hinweis_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_03_hinweis");
            this.movie.feedback.hinweis_txt.setTextFormat($r2);
            this.movie.feedback.send_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_04_send");
            this.movie.feedback.send_txt.setTextFormat($r2);
            this.movie.feedback.email_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_05_email");
            this.movie.feedback.email_txt.setTextFormat($r2);
            this.movie.feedback.message_txt.text = "";
            this.movie.feedback.message_txt.setTextFormat($r2);
            this.movie.feedback.send_bt.onPress = com.extratoxic.events.Delegate.create(this, "checkFeedback");
        };
    $r2.checkFeedback = function (Void) {
            $r3 = false;
            $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_02_name");
            $r6 = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_05_email");
            if (this.movie.feedback.name_txt.text == $r5) {
                this.movie.feedback.error_name.gotoAndPlay(2);
                $r3 = true;
            }
            if (this.movie.feedback.message_txt.text == "") {
                this.movie.feedback.error_message.gotoAndPlay(2);
                $r3 = true;
            }
            if (!(this.movie.feedback.email_txt.text == $r6) && !com.extratoxic.utils.Validate.email(this.movie.feedback.email_txt.text)) {
                this.movie.feedback.error_email.gotoAndPlay(2);
                $r3 = true;
            }
            if (!$r3) {
                $r2 = new LoadVars();
                $r4 = new LoadVars();
                $r2.name = this.movie.feedback.name_txt.text;
                $r2.message = this.movie.feedback.message_txt.text;
                $r2.email = this.movie.feedback.email_txt.text;
                $r2.stats = this.upixo.getStats();
                $r2.sendAndLoad("feedback.php", $r4, "POST");
                this.movie.feedback.message_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.worldmapXML, "mainmap_feedback_06_danke");
                this.movie.feedback.play();
            }
        };
    $r2.preloading = function (Void) {
            this.movie.preloader.preloader.loaderbar._xscale = this.reload._percent;
        };
    $r2.loadDay = function (Void) {
            this.lv = new LoadVars();
            this.lv.base = this;
            this.lv.onLoad = function (success) {
                        if (success) {
                            this.base.setCurrentdate(parseInt(this.currentdate));
                        } else {
                            this.base.setCurrentdate("error");
                        }
                    };
            this.lv.load("date.php?t=" + new Date().getTime());
        };
    $r2.getCurrentdate = function (Void) {
            $r2 = String(this.currentdate.getDate());
            if ($r2.length == 1) {
                $r2 = "0" + $r2;
            }
            $r3 = String(this.currentdate.getMonth() + 1);
            if ($r3.length == 1) {
                $r3 = "0" + $r3;
            }
            return ((($r2 + ".") + $r3) + ".") + this.currentdate.getFullYear();
        };
    $r2.getDay = function (Void) {
            return 24;
            $r2 = this.currentdate.getMonth() + 1;
            if (!!!($r2 == 11)) {
                return this.currentdate.getDate();
            } else {
                return 0;
            }
        };
    $r2.resetCookie = function (Void) {
            this.upixo.test(23, true);
        };
    $r2.is576 = function (Void) {
            this.upixo.is576(_global.gameOver.door);
        };
}
ASSetPropFlags(_global.Worldmap.prototype, null, 1);
// ======== DoInitAction sprite=9 __Packages.utils.Ticker
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.Ticker) {
    $r1 = function (text, txt, textFormat, sound, onSoundComplete) {
            this.text = text.split("<BR />").join("\n");
            this.text = this.text.split("<br />").join("\n");
            this.txt = txt;
            this.textFormat = textFormat;
            this.onSoundComplete = onSoundComplete;
            this.sound = sound;
            this.speechVolume = sound.getVolume();
        };
    utils.Ticker = $r1;
    $r2 = $r1.prototype;
    $r2.start = function (Void) {
            this.pointer = 0;
            this.sound.start(0, 99);
            com.extratoxic.events.Run.attach(this);
        };
    $r2.stop = function (Void) {
            this.sound.stop();
            com.extratoxic.events.Run.detach(this);
        };
    $r2.process = function () {
            var $old1 = this.pointer;
            this.pointer = this.pointer + 1;
            $r2 = this.text.charAt($old1);
            if ($r2 == "\\") {
                $r0 = this.pointer + 2;
                this.pointer = $r0;
                $r2 = this.text.charAt($r0);
            }
            if ($r2 == " ") {
                this.sound.setVolume(0);
            } else {
                this.sound.setVolume(this.speechVolume);
            }
            this.txt.text = this.txt.text + $r2;
            this.txt.setTextFormat(this.textFormat);
            if (this.pointer == this.text.length) {
                this.sound.stop();
                this.onSoundComplete();
                com.extratoxic.events.Run.detach(this);
            }
        };
}
ASSetPropFlags(utils.Ticker.prototype, null, 1);
// ======== DoInitAction sprite=10 __Packages.Lab
if (!_global.Lab) {
    $r1 = function (movie, labContent, mediaPath, laborXML, lang, s_lounge, soundEffects) {
            this.movie = movie;
            this.contentXML = this.contentXML;
            this.labContent = labContent;
            this.mediaPath = mediaPath;
            this.laborXML = laborXML;
            this.s_lounge = s_lounge;
            this.soundEffects = soundEffects;
            this.lang = lang;
            this.saved = labContent.length;
            this.game = 1;
            this.s_piep1 = soundEffects.getNewSoundFile("piep2");
            this.s_piep2 = soundEffects.getNewSoundFile("piep1");
            this.s_wusch = soundEffects.getNewSoundFile("wusch");
            this.ticker = new Array();
        };
    _global.Lab = $r1;
    $r2 = $r1.prototype;
    $r2.initialize = function (lastGame) {
            this.player = this.movie.player.player;
            this.video = this.player.video;
            this.navi = this.movie.navi.games;
            $r2 = 0;
            while ($r2 < this.MAX_GAMES) {
                $r3 = this.navi[$r2.toString()];
                if (!!!(this.labContent[$r2] == undefined)) {
                    if ($r2 == 0) {
                        $r3.gotoAndPlay("on");
                        this.game = 0;
                    }
                    $r3.button._visible = true;
                    $r3.button.onPress = com.extratoxic.events.Delegate.create(this, "showGame", $r2);
                    $r3.button.onRollOver = com.extratoxic.events.Delegate.create(this, "naviRollOver", $r2);
                    $r3.titel.title_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.labContent[$r2].infoXML, "navi");
                    this.labContent[$r2].platform = com.extratoxic.utils.XMLUtil.getValueByName(this.labContent[$r2].mediaXML, "platform");
                    $r3.titel.icon._visible = true;
                    $r3.titel.icon.gotoAndStop(this.labContent[$r2].platform);
                } else {
                    $r3.button._visible = false;
                    $r3.titel.title_txt.text = "";
                    $r3.titel.icon._visible = false;
                }
                $r2 = $r2 + 1;
            }
            if (!!!(this.labContent.length < 15)) {
                this.movie.navi.scroll_up.button.onPress = com.extratoxic.events.Delegate.create(this, "scrollNavi", "up");
                this.movie.navi.scroll_down.button.onPress = com.extratoxic.events.Delegate.create(this, "scrollNavi", "down");
            } else {
                this.movie.navi.scroll_up.button._visible = false;
                this.movie.navi.scroll_up.pfeil._visible = false;
                this.movie.navi.scroll_down.button._visible = false;
                this.movie.navi.scroll_down.pfeil._visible = false;
            }
            $r4 = new TextFormat();
            $r4.letterSpacing = 1;
            this.movie.info.movie.title_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_main_01_info");
            this.movie.screenshots.movie.title_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_main_02_screenshot");
            this.movie.video.movie.title_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_main_03_video");
            this.movie.info.movie.title_txt.setTextFormat($r4);
            this.movie.screenshots.movie.title_txt.setTextFormat($r4);
            this.movie.video.movie.title_txt.setTextFormat($r4);
            this.movie.info.movie.button.onPress = com.extratoxic.events.Delegate.create(this, "showPlayer", "info");
            this.movie.video.movie.button.onPress = com.extratoxic.events.Delegate.create(this, "showPlayer", "video");
            this.movie.screenshots.movie.button.onPress = com.extratoxic.events.Delegate.create(this, "showPlayer", "screenshots");
            if (this.saved == 24) {
                $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_greeting_03_elpix");
            } else {
                $r5 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_greeting_01_headline") + "<br />";
                $r5 = $r5 + com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_greeting_02_copy").split("<games_number>").join(this.saved);
            }
            if (this.labContent.length > 0) {
                $r6 = com.extratoxic.events.Delegate.create(this, "startDownloads");
            }
            this.ticker.schwabbel = new utils.Ticker($r5, this.movie.blase.blase.text_txt, new TextFormat(), this.s_piep1, $r6);
            this.movie.blase.blase.text_txt.htmlText = "";
            this.movie.blase.ticker = this.ticker.schwabbel;
            this.movie.blase.gotoAndPlay(2);
            this.initDownloads();
            if (this.labContent.length == 0) {
                this.movie.downloads._visible = false;
                this.movie.info.movie._visible = false;
                this.movie.video.movie._visible = false;
                this.movie.screenshots.movie._visible = false;
            } else {
                this.movie.downloads._visible = true;
                this.movie.info.movie._visible = true;
                this.movie.video.movie._visible = true;
                this.movie.screenshots.movie._visible = true;
            }
            if (com.extratoxic.utils.XMLUtil.getValueByName(this.labContent[this.game].mediaXML, "video") == undefined) {
                this.movie.video.movie._visible = false;
            } else {
                this.movie.video.movie._visible = true;
            }
        };
    $r2.reset = function (Void) {
            this.controlVideo("stop");
            this.ticker.schwabbel.stop();
            this.stopTicker();
            this.movie.play();
        };
    $r2.showPlayer = function (type) {
            this.controlVideo("stop");
            this.s_wusch.setVolume(50);
            this.s_wusch.start();
            this.player.screenshots._visible = false;
            this.player.info._visible = false;
            this.player.video._visible = false;
            this.player._parent.gotoAndPlay("on");
            $r2 = this.player[type];
            $r3 = this.labContent[this.game];
            $r0 = type;
            if (!($r0 === "info")) {
                if (!($r0 === "screenshots")) {
                    if (!($r0 === "video")) {
                        goto L0000;
                        $r2._visible = true;
                        $r5 = com.extratoxic.utils.XMLUtil.getValueByName($r3.infoXML, "navi").split("<br />").join(" ");
                        $r2.title_txt.htmlText = ("INFO: <font color=\"#000000\">" + $r5) + "</font>";
                        $r2.body_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName($r3.infoXML, "body");
                        $r4 = ($r3.name + "/") + com.extratoxic.utils.XMLUtil.getValueByName($r3.mediaXML, "artwork");
                        this.loader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.mediaPath + $r4, $r2.container));
                        this.loader.load();
                        goto L0000;
                        $r2._visible = true;
                        this.initScreenshots();
                    } else {
                        $r2._visible = true;
                        this.initVideo();
                        goto L0000;
                    }
                } else {
                    $r2._visible = true;
                    this.initScreenshots();
                    goto L0000;
                    $r2._visible = true;
                    this.initVideo();
                    goto L0000;
                }
            } else {
                $r2._visible = true;
                $r5 = com.extratoxic.utils.XMLUtil.getValueByName($r3.infoXML, "navi").split("<br />").join(" ");
                $r2.title_txt.htmlText = ("INFO: <font color=\"#000000\">" + $r5) + "</font>";
                $r2.body_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName($r3.infoXML, "body");
                $r4 = ($r3.name + "/") + com.extratoxic.utils.XMLUtil.getValueByName($r3.mediaXML, "artwork");
                this.loader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.mediaPath + $r4, $r2.container));
                this.loader.load();
                goto L0000;
                $r2._visible = true;
                this.initScreenshots();
                goto L0000;
                $r2._visible = true;
                this.initVideo();
                goto L0000;
            }
        };
    $r2.showGame = function (num) {
            this.controlVideo("stop");
            this.game = num;
            $r2 = 0;
            while ($r2 < this.MAX_GAMES) {
                $r3 = this.navi[$r2.toString()];
                if ($r3.active) {
                    $r3.gotoAndPlay("off");
                }
                if ($r2 == num) {
                    $r3.gotoAndPlay("on");
                    this.showPlayer("info");
                }
                $r2 = $r2 + 1;
            }
            this.initDownloads();
            if (com.extratoxic.utils.XMLUtil.getValueByName(this.labContent[this.game].mediaXML, "video") == undefined) {
                this.movie.video.movie._visible = false;
            } else {
                this.movie.video.movie._visible = true;
            }
        };
    $r2.initScreenshots = function (Void) {
            $r7 = this.player.screenshots;
            $r6 = this.labContent[this.game];
            $r12 = com.extratoxic.utils.XMLUtil.getValueByName($r6.infoXML, "navi").split("<br />").join(" ");
            $r7.title_txt.htmlText = ("SCREENSHOTS: <font color=\"#000000\">" + $r12) + "</font>";
            $r11 = com.extratoxic.utils.XMLUtil.getValueByName($r6.mediaXML, "ss_format");
            if (!!!($r11 == undefined)) {
                $r13 = $r11;
            } else {
                $r13 = $r6.platform;
            }
            if ($r13 == "ds") {
                $r8 = $r7.container_ds;
                $r10 = $r7.navi_ds;
                $r7.container_ds._visible = true;
                $r7.navi_ds._visible = true;
                $r7.container_wii._visible = false;
                $r7.navi_wii._visible = false;
            } else {
                $r8 = $r7.container_wii;
                $r10 = $r7.navi_wii;
                $r7.container_ds._visible = false;
                $r7.navi_ds._visible = false;
                $r7.container_wii._visible = true;
                $r7.navi_wii._visible = true;
            }
            this.shots = new Array();
            this.loader = new com.extratoxic.utils.LoadStack();
            this.cur_shot = 1;
            $r2 = 1;
            while (!!!($r2 > this.MAX_SHOTS)) {
                $r4 = com.extratoxic.utils.XMLUtil.getValueByName($r6.mediaXML, $r2.toString());
                if (!!!($r4 == undefined)) {
                    this.shots[$r2] = {name: $r4};
                    $r3 = $r8.createEmptyMovieClip("shot " + $r2, $r2);
                    $r5 = $r3.createEmptyMovieClip("shot" + $r2, $r2);
                    this.shots[$r2].mc = $r3;
                    if (!!!($r2 == 1)) {
                        $r3._visible = false;
                    }
                    this.loader.push(new com.extratoxic.utils.Loader(((this.mediaPath + $r6.name) + "/") + $r4, $r5));
                } else {
                    $r8["shot " + $r2].removeMovieClip();
                }
                $r2 = $r2 + 1;
            }
            this.loader.load();
            $r10.prev.button.onPress = com.extratoxic.events.Delegate.create(this, "showScreenshot", "prev", $r10.prev);
            $r10.next.button.onPress = com.extratoxic.events.Delegate.create(this, "showScreenshot", "next", $r10.next);
            $r10.display_txt.text = "1 / " + (this.shots.length - 1);
        };
    $r2.showScreenshot = function (step, mc) {
            this.shots[this.cur_shot].mc._visible = false;
            if (step == "prev") {
                $r0 = this.cur_shot - 1;
                this.cur_shot = $r0;
                if ($r0 < 1) {
                    this.cur_shot = this.shots.length - 1;
                }
            } else {
                $r0 = this.cur_shot + 1;
                this.cur_shot = $r0;
                if (!!!($r0 < this.shots.length)) {
                    this.cur_shot = 1;
                }
            }
            this.shots[this.cur_shot].mc._visible = true;
            mc.gotoAndStop("press");
            mc._parent.display_txt.text = (this.cur_shot + " / ") + (this.shots.length - 1);
        };
    $r2.initVideo = function (Void) {
            $r4 = this.labContent[this.game];
            $r2 = com.extratoxic.utils.XMLUtil.getValueByName($r4.mediaXML, "video");
            if ($r2.indexOf(".flv") == -1) {
                $r2 = (($r2 + "_") + this.lang) + ".flv";
            }
            $r5 = ((this.mediaPath + $r4.name) + "/") + $r2;
            $r6 = com.extratoxic.utils.XMLUtil.getValueByName($r4.infoXML, "navi").split("<br />").join(" ");
            this.video.title_txt.htmlText = ("VIDEO: <font color=\"#000000\">" + $r6) + "</font>";
            this.video.close_button.onPress = com.extratoxic.events.Delegate.create(this, "controlVideo", "stop");
            this.video.play_pause.play_button.onPress = com.extratoxic.events.Delegate.create(this, "controlVideo", "play");
            this.video.play_pause.pause_button.onPress = com.extratoxic.events.Delegate.create(this, "controlVideo", "pause");
            this.netConnection = new NetConnection();
            this.netConnection.connect(null);
            this.netStream = new NetStream(this.netConnection);
            this.netStream.base = this;
            this.netStream.container = this.video.container;
            this.netStream.onMetaData = function (obj) {
                        this.base.videoDuration = obj.duration;
                    };
            this.netStream.onStatus = function (infoObject) {
                        while (true) {
                            $r0 = /*enumerate*/ infoObject;
                            if ($r0 == null) break;
                            $r3 = $r0;
                        }
                        if (infoObject.code == "NetStream.Buffer.Empty") {
                            this.base.video.play_pause.gotoAndStop("on_play");
                        }
                        if (infoObject.code == "NetStream.Play.Stop") {
                            this.seek(0);
                        }
                        if (infoObject.code == "NetStream.Play.Start") {
                            this.container._visible = true;
                        }
                    };
            this.video.container.autoSize = false;
            this.video.container.attachVideo(this.netStream);
            this.netStream.setBufferTime(5);
            this.netStream.play($r5);
            this.videoDuration = 10;
            com.extratoxic.events.Run.attach(this);
            this.s_lounge.fadeTo(0);
        };
    $r2.process = function () {
            this.video.slider.progress._xscale = (this.netStream.bytesLoaded * 100) / this.netStream.bytesTotal;
            this.video.slider.pointer._x = ((this.netStream.time * 100) / this.videoDuration) * 3.18;
            if (!!!(this.netStream.time < this.videoDuration)) {
                this.netStream.seek(0);
                this.netStream.pause(false);
                this.video.play_pause.gotoAndStop("on_play");
            }
        };
    $r2.controlVideo = function (action) {
            if (action == "pause") {
                this.netStream.pause(true);
            } else {
                if (action == "play") {
                    this.netStream.pause(false);
                } else {
                    if (action == "stop") {
                        this.netStream.close();
                        this.s_lounge.fadeTo(30);
                        this.video.container._visible = false;
                        com.extratoxic.events.Run.detach(this);
                        this.netStream.close();
                    }
                }
            }
        };
    $r2.initDownloads = function (Void) {
            $r5 = this.labContent[this.game];
            $r4 = this.movie.downloads;
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_01_headline") + "<br /><br />";
            $r9 = $r9 + com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_02_copy");
            this.ticker.d_hello = new utils.Ticker($r9, $r4.text_txt, new TextFormat(), this.s_piep2);
            $r4.ticker_hello = this.ticker.d_hello;
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_03_wallpaper1");
            this.ticker.d_wp_1 = new utils.Ticker($r9, $r4.text_txt, new TextFormat(), this.s_piep2);
            $r4.wallpapers.ticker_wp1 = this.ticker.d_wp_1;
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_04_wallpaper2");
            this.ticker.d_wp_2 = new utils.Ticker($r9, $r4.text_txt, new TextFormat(), this.s_piep2);
            $r4.wallpapers.ticker_wp2 = this.ticker.d_wp_2;
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_05_mp3");
            this.ticker.d_handy = new utils.Ticker($r9, $r4.text_txt, new TextFormat(), this.s_piep2);
            $r4.handy.ticker_handy = this.ticker.d_handy;
            $r9 = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_06_icon");
            this.ticker.d_icons = new utils.Ticker($r9, $r4.text_txt, new TextFormat(), this.s_piep2);
            $r4.icons.ticker_icons = this.ticker.d_icons;
            $r4.stopTicker = com.extratoxic.events.Delegate.create(this, "stopTicker");
            $r4.wallpapers.wallpapers_txt.htmlText = com.extratoxic.utils.XMLUtil.getValueByName(this.laborXML, "labor_downloads_03_wallpaper");
            if (com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "wallpaper_language") == "true") {
                $r8 = ("_" + this.lang) + ".zip";
            } else {
                $r8 = ".zip";
            }
            $r12 = (((this.mediaPath + $r5.name) + "/") + com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "800x600")) + $r8;
            $r11 = (((this.mediaPath + $r5.name) + "/") + com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "1024x768")) + $r8;
            $r10 = (((this.mediaPath + $r5.name) + "/") + com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "1280x1024")) + $r8;
            $r4.wallpapers.wp_1.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", $r12, "_blank");
            $r4.wallpapers.wp_2.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", $r11, "_blank");
            $r4.wallpapers.wp_3.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", $r10, "_blank");
            $r6 = com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "handy");
            if (!!!($r6 == undefined)) {
                $r6 = ((this.mediaPath + $r5.name) + "/") + $r6;
                $r4.handy.button.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", $r6, "_blank");
                $r4.handy.gotoAndStop("on");
            } else {
                $r4.handy.gotoAndStop("off");
            }
            $r7 = com.extratoxic.utils.XMLUtil.getValueByName($r5.mediaXML, "icons");
            if (!!!($r7 == undefined)) {
                $r7 = ((this.mediaPath + $r5.name) + "/") + $r7;
                $r4.icons.button.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", $r7, "_blank");
                $r4.icons.gotoAndStop("on");
            } else {
                $r4.icons.gotoAndStop("off");
            }
            _global.gameOver.door = undefined;
            _global.is576();
            if (_global.complete576) {
                $r4.download_576._visible = true;
                $r4.download_576.button.onPress = com.extratoxic.events.Delegate.create(_root, "getURL", this.mediaPath + "26_576/MIS_Downloads.zip", "_blank");
            }
        };
    $r2.startDownloads = function (Void) {
            this.movie.downloads.gotoAndPlay("start");
        };
    $r2.stopTicker = function (Void) {
            this.ticker.schwabbel.onSoundComplete = null;
            while (true) {
                $r0 = /*enumerate*/ this.ticker;
                if ($r0 == null) break;
                $r2 = $r0;
                if (!!!($r2 == "schwabbel")) {
                    this.ticker[$r2].stop();
                }
            }
        };
    $r2.naviRollOver = function (num) {
            $r2 = 0;
            while ($r2 < this.MAX_GAMES) {
                $r3 = this.navi[$r2.toString()];
                if ($r2 == num) {
                    $r3.titel.gotoAndStop("rover");
                } else {
                    if (!!!($r2 == this.game)) {
                        $r3.titel.gotoAndStop("normal");
                    }
                }
                $r2 = $r2 + 1;
            }
        };
    $r2.scrollNavi = function (dir) {
            $r2 = 30;
            $r3 = -446.4 - $r2;
            $r4 = ($r3 - ((this.labContent.length - 14) * $r2)) + $r2;
            if ((dir == "up") && (this.navi._y < $r3)) {
                this.navi._y = this.navi._y + $r2;
            } else {
                if ((dir == "down") && !(this.navi._y < $r4)) {
                    this.navi._y = this.navi._y - $r2;
                }
            }
        };
    $r2.getMovie = function (Void) {
            return this.movie;
        };
    $r2.MAX_GAMES = 24;
    $r2.MAX_SHOTS = 10;
}
ASSetPropFlags(_global.Lab.prototype, null, 1);
// ======== DoInitAction sprite=11 __Packages.com.extratoxic.audio.SoundFile
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.audio) {
    _global.com.extratoxic.audio = new Object();
}
<stack?>;
if (!_global.com.extratoxic.audio.SoundFile) {
    $r1 = function (movie) {
            $r0 = movie;
            this.movie = $r0;
            super($r0);
        };
    com.extratoxic.audio.SoundFile = $r1;
    com.extratoxic.audio.SoundFile.extends(Sound);
    $r2 = $r1.prototype;
    $r2.start = function () {
            super.start.apply(this, arguments);
        };
    $r2.stop = function () {
            super.stop();
        };
    $r2.getMovie = function (Void) {
            return this.movie;
        };
    $r2.fadeOut = function (delay) {
            this.fade(-1, delay);
        };
    $r2.fadeIn = function (delay, volume) {
            this.fade(1, delay, volume);
        };
    $r2.fadeTo = function (volume) {
            this.movie.startVolume = this.getVolume();
            this.movie.endVolume = volume;
            this.movie.volume = this.getVolume();
            this.movie.snd = this;
            if (this.getVolume() == 0) {
                this.start(0, 999);
            }
            this.movie.onEnterFrame = function () {
                        this.snd.setVolume(this.volume);
                        if (this.volume > this.endVolume) {
                            this.volume = this.volume - 1;
                        } else {
                            if (this.volume < this.endVolume) {
                                this.volume = this.volume + 1;
                            } else {
                                if (this.volume == 0) {
                                    this.snd.stop();
                                }
                                this.onEnterFrame = null;
                            }
                        }
                    };
        };
    $r2.fade = function (mod, delay, volume) {
            if (delay == undefined) {
                delay = 0;
            }
            this.movie.mod = mod;
            this.movie.snd = this;
            this.movie.delay = delay;
            this.movie.counter = delay;
            this.movie.volume = this.getVolume();
            this.movie.endVolume = this.getVolume();
            if (mod == 1) {
                if (this.getVolume() == 0) {
                    this.movie.endVolume = 100;
                }
                this.movie.volume = 0;
                this.setVolume(0);
                this.start(0, 999);
            }
            this.movie.onEnterFrame = function () {
                        var $old1 = this.counter;
                        this.counter = this.counter - 1;
                        if ($old1 == 0) {
                            this.volume = this.volume + (this.mod * 2);
                            this.snd.setVolume(this.volume);
                            if ((!(this.volume > 0) && (this.mod == -1)) || (!(this.volume < this.endVolume) && (this.mod == 1))) {
                                if (this.mod == -1) {
                                    this.snd.stop();
                                }
                                this.onEnterFrame = null;
                            }
                            this.counter = this.delay;
                        }
                    };
        };
    $r2.setStringInterval = function (t, onStringIntervalComplete) {
            this.interval = t.split(" ");
            this.pointer = 0;
            this.volume = this.getVolume();
            this.onStringIntervalComplete = onStringIntervalComplete;
            this.nextStringInterval = function () {
                        $r0 = this.pointer + 1;
                        this.pointer = $r0;
                        $r3 = this.interval[$r0];
                        $r2 = Math.round($r3.length / 2);
                        if ($r2 > 0) {
                            this.onSoundComplete = function () {
                                                this.nextStringInterval();
                                            };
                            this.start(0, $r2);
                            if ($r3.charAt(0) == "+") {
                                this.setVolume(0);
                            } else {
                                this.setVolume(this.volume);
                            }
                        } else {
                            this.onStringIntervalComplete();
                        }
                    };
            this.onSoundComplete = function () {
                        this.nextStringInterval();
                    };
            this.start(0, this.interval[0].length);
        };
    $r1.MAX_CHANNELS = 8;
    $r2.channels = 0;
}
ASSetPropFlags(com.extratoxic.audio.SoundFile.prototype, null, 1);
// ======== DoInitAction sprite=12 __Packages.com.extratoxic.audio.SoundPackage
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.audio) {
    _global.com.extratoxic.audio = new Object();
}
<stack?>;
if (!_global.com.extratoxic.audio.SoundPackage) {
    $r1 = function (parent, depth) {
            if (parent.soundPackages == undefined) {
                $r0 = parent;
                this.parent = $r0;
                this.movie = $r0.createEmptyMovieClip("soundPackages", depth);
            } else {
                this.movie = parent.soundPackages;
            }
            $r0 = com.extratoxic.audio.SoundPackage.packageId + 1;
            var $old1 = com.extratoxic.audio.SoundPackage.packageId;
            com.extratoxic.audio.SoundPackage.packageId = $r0;
            this.child = this.movie.createEmptyMovieClip("package" + $r0, $old1);
        };
    com.extratoxic.audio.SoundPackage = $r1;
    $r2 = $r1.prototype;
    $r2.getMovie = function () {
            return this.child;
        };
    $r2.getNewSound = function (linkId) {
            $r0 = this.SoundId + 1;
            this.SoundId = $r0;
            $r3 = this.child.createEmptyMovieClip("sound" + this.SoundId, $r0);
            $r2 = new Sound($r3);
            $r2.attachSound(linkId);
            return $r2;
        };
    $r2.getNewSoundFile = function (linkId) {
            $r0 = this.SoundId + 1;
            this.SoundId = $r0;
            $r3 = this.child.createEmptyMovieClip("sound" + this.SoundId, $r0);
            $r2 = new com.extratoxic.audio.SoundFile($r3);
            $r2.attachSound(linkId);
            return $r2;
        };
    $r2.getNewSoundMovie = function (Void) {
            $r0 = this.SoundId + 1;
            this.SoundId = $r0;
            $r2 = this.child.createEmptyMovieClip("sound" + this.SoundId, $r0);
            return $r2;
        };
    $r1.packageId = 0;
    $r2.SoundId = 0;
}
ASSetPropFlags(com.extratoxic.audio.SoundPackage.prototype, null, 1);
// ======== DoInitAction sprite=13 __Packages.com.extratoxic.events.Delegate
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events) {
    _global.com.extratoxic.events = new Object();
}
<stack?>;
if (!_global.com.extratoxic.events.Delegate) {
    $r1 = function (obj, func) {
            this.obj = obj;
            if (func instanceof Function) {
                this.func = func;
            } else {
                this.func = obj[func];
            }
            this.args = arguments.splice(2);
        };
    com.extratoxic.events.Delegate = $r1;
    $r2 = $r1.prototype;
    $r1.create = function (obj, func) {
            var c = new com.extratoxic.events.Delegate(obj, func);
            c.setArguments(arguments.splice(2));
            return function () {
                        c.process();
                    };
        };
    $r2.process = function () {
            if (arguments.length) {
                this.func.apply(this.obj, arguments);
            } else {
                this.func.apply(this.obj, this.args);
            }
        };
    $r2.setArguments = function (args) {
            this.args = args;
        };
}
ASSetPropFlags(com.extratoxic.events.Delegate.prototype, null, 1);
// ======== DoInitAction sprite=14 __Packages.com.extratoxic.utils.XMLUtil
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils) {
    _global.com.extratoxic.utils = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils.XMLUtil) {
    $r1 = function () {
        };
    com.extratoxic.utils.XMLUtil = $r1;
    $r2 = $r1.prototype;
    $r1.getValueByName = function (xml, keyword) {
            com.extratoxic.utils.XMLUtil.value = undefined;
            com.extratoxic.utils.XMLUtil.parseValue(xml.firstChild, keyword);
            if (!!!(com.extratoxic.utils.XMLUtil.value == undefined)) {
                return com.extratoxic.utils.XMLUtil.value;
            } else {
                return;
            }
        };
    $r1.parseValue = function (xml, keyword) {
            if (xml.hasChildNodes()) {
                while (true) {
                    $r0 = /*enumerate*/ xml.childNodes;
                    if ($r0 == null) break;
                    $r2 = $r0;
                    if (xml.childNodes[$r2].attributes.name == keyword) {
                        $r0 = xml.childNodes[$r2].attributes.type;
                        if (!($r0 === "string")) {
                            if (!($r0 === "int")) {
                                if (!($r0 === "boolean")) {
                                    goto L016a;
                                    com.extratoxic.utils.XMLUtil.value = xml.childNodes[$r2].firstChild.nodeValue;
                                    goto L019f;
                                    com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                                } else {
                                    com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                                    goto L019f;
                                    com.extratoxic.utils.XMLUtil.value = xml.childNodes[$r2].firstChild.nodeValue;
                                }
                            } else {
                                com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                                goto L019f;
                                com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                                goto L019f;
                                com.extratoxic.utils.XMLUtil.value = xml.childNodes[$r2].firstChild.nodeValue;
                            }
                        } else {
                            com.extratoxic.utils.XMLUtil.value = xml.childNodes[$r2].firstChild.nodeValue;
                            goto L019f;
                            com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                            goto L019f;
                            com.extratoxic.utils.XMLUtil.value = parseInt(xml.childNodes[$r2].firstChild.nodeValue);
                            goto L019f;
                        }
                        com.extratoxic.utils.XMLUtil.value = xml.childNodes[$r2].firstChild.nodeValue;
                    } else {
                        com.extratoxic.utils.XMLUtil.parseValue(xml.childNodes[$r2], $r2);
                    }
                }
            }
        };
    $r1.getNodeByNodeName = function (xml, keyword) {
            com.extratoxic.utils.XMLUtil.parseNode(xml, keyword);
            if (!!!(com.extratoxic.utils.XMLUtil.value == undefined)) {
                return com.extratoxic.utils.XMLUtil.value;
            } else {
                return -1;
            }
        };
    $r1.parseNode = function (xml, keyword) {
            if (xml.hasChildNodes()) {
                while (true) {
                    $r0 = /*enumerate*/ xml.childNodes;
                    if ($r0 == null) break;
                    $r3 = $r0;
                    if (xml.childNodes[$r3].nodeName == keyword) {
                        com.extratoxic.utils.XMLUtil.value = new XML(xml.childNodes[$r3]);
                    } else {
                        com.extratoxic.utils.XMLUtil.parseNode(xml.childNodes[$r3], keyword);
                    }
                }
            }
        };
    $r1.getNodeByAttribute = function (xml, attr, keyword) {
            com.extratoxic.utils.XMLUtil.parseNodeByAttr(xml, attr, keyword);
            if (!!!(com.extratoxic.utils.XMLUtil.value == undefined)) {
                return com.extratoxic.utils.XMLUtil.value;
            } else {
                return -1;
            }
        };
    $r1.parseNodeByAttr = function (xml, attr, keyword) {
            if (xml.hasChildNodes()) {
                while (true) {
                    $r0 = /*enumerate*/ xml.childNodes;
                    if ($r0 == null) break;
                    $r4 = $r0;
                    if (xml.childNodes[$r4].attributes[attr] == keyword) {
                        com.extratoxic.utils.XMLUtil.value = new XML(xml.childNodes[$r4]);
                    } else {
                        com.extratoxic.utils.XMLUtil.parseNodeByAttr(xml.childNodes[$r4], attr, keyword);
                    }
                }
            }
        };
}
ASSetPropFlags(com.extratoxic.utils.XMLUtil.prototype, null, 1);
// ======== DoInitAction sprite=15 __Packages.com.extratoxic.utils.Validate
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils) {
    _global.com.extratoxic.utils = new Object();
}
<stack?>;
if (!_global.com.extratoxic.utils.Validate) {
    $r1 = function () {
        };
    com.extratoxic.utils.Validate = $r1;
    $r2 = $r1.prototype;
    $r1.email = function (email) {
            if (email.length < 6) {
                return false;
            }
            if ((email.split("@").length > 2) || (email.indexOf("@") < 0)) {
                return false;
            }
            if (email.lastIndexOf("@") > email.lastIndexOf(".")) {
                return false;
            }
            if (email.lastIndexOf(".") > (email.length - 3)) {
                return false;
            }
            if (!!!(email.lastIndexOf(".") > (email.lastIndexOf("@") + 1))) {
                return false;
            }
            return true;
        };
    $r1.integer = function (integer) {
            return !isNaN(integer);
        };
}
ASSetPropFlags(com.extratoxic.utils.Validate.prototype, null, 1);
// ---- DoAction
stop();
if (config == undefined) {
    config = "data/config.xml";
}
control = new Control(this, config);
