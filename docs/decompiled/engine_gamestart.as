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
// ======== DoInitAction sprite=4 __Packages.Game
if (!_global.Game) {
    $r1 = function (movie, config, level) {
            super(movie, config);
            this.level = level;
            this.width = 480;
            this.height = 360;
            _quality = "low";
            $r3 = new Object();
            $r3.parent = this;
            $r3.onKeyDown = com.extratoxic.events.Delegate.create(this, "onKeyPressed");
            Key.addListener($r3);
            $r4 = new com.extratoxic.utils.Rectangle(movie, 999, 0, 0, 480, 360, 0);
            movie.setMask($r4.getMovie());
            this.confXML = new XML();
            this.confXML.ignoreWhite = true;
            this.soundXML = new XML();
            this.soundXML.ignoreWhite = true;
            this.levelXML = new XML();
            this.levelXML.ignoreWhite = true;
            this.xmlLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(config, this.confXML));
            this.xmlLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "loadIntro");
            this.xmlLoader.load();
        };
    _global.Game = $r1;
    _global.Game.extends(com.extratoxic.core.Frame);
    $r2 = $r1.prototype;
    $r2.loadIntro = function (Void) {
            this.__set___path(com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "path"));
            this.actorPath = this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "actors");
            this.levelPath = this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "levels");
            this.soundPath = this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "sounds");
            this.introScreen = this.createMovie(4);
            this.introLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "loader"), this.introScreen));
            this.introLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "loadMain");
            this.introLoader.load();
        };
    $r2.loadMain = function (Void) {
            this.introScreen.output_txt.text = this.introScreen.output_txt.text + "loadMain";
            _global.output = this.introScreen.output_txt;
            this.mainScreen = this.createMovie(3);
            this.mainLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.soundPath + "sounds.xml", this.soundXML, 1), new com.extratoxic.utils.Loader(this.__get___path() + com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "main"), this.mainScreen, com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, "main_kb")));
            this.mainLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "start");
            this.mainLoader.onLoading = com.extratoxic.events.Delegate.create(this, "preloading", this.mainLoader, 0.1);
            this.mainLoader.load();
        };
    $r2.preloading = function (loader, factor, offset) {
            this.introScreen.loaderbar._xscale = (loader._percent * factor) + offset;
        };
    $r2.loadLevelXML = function (source) {
            this.levelXML = new XML();
            this.levelXML.ignoreWhite = true;
            this.levelXMLoader = new com.extratoxic.utils.LoadStack(new com.extratoxic.utils.Loader(this.levelPath + source, this.levelXML, 30));
            this.levelXMLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "loadLevel");
            this.levelXMLoader.onLoading = com.extratoxic.events.Delegate.create(this, "preloading", this.levelXMLoader, 0.1, 10);
            this.levelXMLoader.load();
        };
    $r2.loadLevel = function (Void) {
            this.levelLoader = new com.extratoxic.utils.LoadStack();
            this.levelLoader.onLoadStackComplete = com.extratoxic.events.Delegate.create(this, "startLevel");
            this.levelLoader.onLoading = com.extratoxic.events.Delegate.create(this, "preloading", this.levelLoader, 0.9, 20);
            this.layers = new Object();
            this.soundPlayer = new com.extratoxic.audio.SoundPackage(this.movie, 5);
            this.soundMusic = new com.extratoxic.audio.SoundPackage(this.movie);
            this.soundEffects = new com.extratoxic.audio.SoundPackage(this.movie);
            $r10 = this.levelXML.firstChild.attributes.background + ".swf";
            $r9 = this.levelXML.firstChild.attributes.music;
            $r8 = this.levelXML.firstChild.attributes.effects;
            this.levelLoader.push(new com.extratoxic.utils.Loader((this.levelPath + "backgrounds/") + $r10, this.mainScreen.background, 15), new com.extratoxic.utils.Loader(this.soundPath + com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, "player"), this.soundPlayer.getMovie(), com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, "player_kb")), new com.extratoxic.utils.Loader(this.soundPath + com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, $r9), this.soundMusic.getMovie(), com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, $r9 + "_kb")), new com.extratoxic.utils.Loader(this.soundPath + com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, $r8), this.soundEffects.getMovie(), com.extratoxic.utils.XMLUtil.getValueByName(this.soundXML, $r8 + "_kb")));
            $r3 = this.levelXML.firstChild.childNodes;
            $r5 = 0;
            while (true) {
                $r0 = /*enumerate*/ $r3;
                if ($r0 == null) break;
                $r7 = $r0;
                if ($r3[$r7].nodeName == "layer") {
                    $r2 = $r3[$r7].attributes.name;
                    $r5 = $r5 + 10000;
                    this.layers[$r2] = {movie: this.platform.createEmptyMovieClip($r2, $r5)};
                    if ($r2 == "base") {
                        $r6 = $r5 + 900;
                        this.basemovie = this.layers[$r2].movie;
                    }
                    $r4 = $r3[$r7].attributes.source;
                    this.levelLoader.push(new com.extratoxic.utils.Loader(this.levelPath + $r4, this.layers[$r2].movie, com.extratoxic.utils.XMLUtil.getValueByName(this.confXML, $r4 + "_kb")));
                }
            }
            this.levelLoader.load();
        };
    $r2.startLevel = function (Void) {
            this.introScreen.loaderbar._xscale = 100;
            this.enemyUtil = new utils.EnemyUtil(this.basemovie);
            utils.PlatformUtil.soundEffects = this.soundEffects;
            this.music = this.soundMusic.getNewSoundFile("track");
            this.music_start = this.soundEffects.getNewSoundFile("start");
            this.scroll = new com.extratoxic.game.Scroll(this.width, this.height);
            $r9 = parseInt(this.levelXML.firstChild.attributes.d);
            $r8 = parseInt(this.levelXML.firstChild.attributes.sh);
            if ($r8.toString() == "NaN") {
                $r8 = 190;
            }
            this.hero = new actors.Hero(this.basemovie, this.basemovie.attachMovie("actor", "hero", $r9), this.scroll, $r8, this.soundPlayer);
            this.hero.setOutput(this.mainScreen.crystals, this.mainScreen, this.mainScreen.energy);
            this.hero.initialize(this.music);
            $r7 = parseInt(this.levelXML.firstChild.attributes.sx);
            $r6 = parseInt(this.levelXML.firstChild.attributes.sy);
            if ($r7 == undefined) {
                $r7 = 200;
            }
            if ($r6 == undefined) {
                $r6 = 500;
            }
            this.hero.setPos($r7, $r6);
            this.hero.globalstart = com.extratoxic.events.Delegate.create(this, "start");
            this.hero.globalstop = com.extratoxic.events.Delegate.create(this, "stop");
            this.hero.globalreset = com.extratoxic.events.Delegate.create(this, "globalreset");
            this.hero.globalfinish = com.extratoxic.events.Delegate.create(this, "globalfinish");
            this.hero.stopMusic = com.extratoxic.events.Delegate.create(this, "stopMusic");
            _level0.globalreset = com.extratoxic.events.Delegate.create(this, "globalreset");
            _level0.globalstop = com.extratoxic.events.Delegate.create(this, "final");
            while (true) {
                $r0 = /*enumerate*/ this.layers;
                if ($r0 == null) break;
                $r5 = $r0;
                if ($r5 == "base") {
                    this.layers[$r5].handleTiles = new com.extratoxic.game.tilemap.HandleTiles(this.layers[$r5].movie, com.extratoxic.utils.XMLUtil.getNodeByAttribute(this.levelXML, "name", $r5), this.width, this.height, this.enemyUtil);
                    $r4 = true;
                    this.baselayer = this.layers[$r5].handleTiles;
                    if (!!_global.c[_global.world - 1]) {
                        this.baselayer.offTiles.ec = true;
                    }
                    if (!!!(_global.level_complete == undefined)) {
                        this.baselayer.offTiles.g = true;
                        this.baselayer.offTiles.g_l = true;
                    }
                    this.baselayer.initialize();
                } else {
                    this.layers[$r5].handleTiles = new com.extratoxic.game.tilemap.HandleTiles(this.layers[$r5].movie, com.extratoxic.utils.XMLUtil.getNodeByAttribute(this.levelXML, "name", $r5), this.width, this.height);
                    $r4 = false;
                }
                this.layers[$r5].handleTiles.setPos(0, 0);
                this.layers[$r5].handleTiles.setOffset(0, 0);
                this.scroll.addLayer(this.layers[$r5].handleTiles, $r4);
            }
            this.mainScreen.vorhang.gotoAndPlay(2);
            com.extratoxic.events.Run.attach(this);
            this.scroll.initialize();
            this.scroll.setPos(100, 400);
            this.scroll.start();
            this.hero.start();
            if (_level0.musicvol == undefined) {
                _level0.musicvol = 100;
            }
            this.music_start.setVolume(_level0.musicvol);
            if (this.level == "level_25") {
                this.startMusic();
                this.mainScreen.crystals._visible = false;
            } else {
                this.music_start.onSoundComplete = com.extratoxic.events.Delegate.create(this, "startMusic");
                this.music_start.start();
                this.mainScreen.crystals._visible = true;
            }
            _level0.music_start = this.music_start;
            _level0.music = this.music;
            _root.coinframe = 0;
            _root.cointotal = 105;
            _root.waterframe = 0;
            _root.watertotal = 43;
            _root.beeframe = 2;
            _root.beetotal = 102;
            _root.cloudframe = 2;
            _root.cloudtotal = 219;
            this.introScreen.unloadMovie();
            if ((_level0._url.indexOf("http://") == -1) || !(_level0._url.indexOf("extratoxic") == -1)) {
                this.showFPS = this.getFPS;
            }
            this.mainScreen.fps;
        };
    $r2.startMusic = function (Void) {
            this.music.setVolume(_level0.musicvol);
            this.music.start(0, 999);
        };
    $r2.stopMusic = function (Void) {
            this.music_start.onSoundComplete = null;
            this.music.stop();
        };
    $r2.start = function (Void) {
            if (!!!(this.platform == undefined)) {
                this.platform.removeMovieClip();
            }
            _global.cancelGame = com.extratoxic.events.Delegate.create(this, "cancel");
            this.platform = this.mainScreen.platform;
            this.controlUtil = new utils.ControlUtil(this.layers, this.platform);
            utils.VideoUtil.setOutput(this.mainScreen.output_txt);
            if (this.level == undefined) {
                this.level = "level_1";
            }
            this.loadLevelXML(this.level + ".xml");
        };
    $r2.stop = function (Void) {
            this.music.stop();
            this.controlUtil.pauseGame("hero");
        };
    $r2.final = function (Void) {
            this.music.stop();
            this.controlUtil.pauseGame("hero");
        };
    $r2.cancel = function (Void) {
            this.controlUtil.pauseGame("hero");
            this.mainScreen.vorhang.gotoAndPlay("closefast");
            this.mainScreen.vorhang.finish = _global.gameOver.cancel;
            this.music.fadeOut();
        };
    $r2.globalfinish = function (Void) {
            this.mainScreen.vorhang.finish = _global.gameOver.finish;
            this.mainScreen.vorhang.gotoAndPlay("close");
            this.controlUtil.pauseGame();
        };
    $r2.globalreset = function (Void) {
            this.mainScreen.vorhang.finish = _global.gameOver.cancel;
            this.mainScreen.vorhang.gotoAndPlay("close_fast");
            this.controlUtil.pauseGame();
        };
    $r2.onKeyPressed = function () {
            $r1 = Key.getCode();
        };
    $r2.process = function () {
            this.mainScreen.fps.text = this.showFPS();
            this.mainScreen.vtiles.text = this.baselayer.visTilesNum;
            var $old1 = _root.coinframe;
            _root.coinframe = _root.coinframe + 1;
            if (!!!($old1 < _root.cointotal)) {
                _root.coinframe = 1;
            }
            var $old2 = _root.waterframe;
            _root.waterframe = _root.waterframe + 1;
            if (!!!($old2 < _root.watertotal)) {
                _root.waterframe = 1;
            }
            var $old3 = _root.beeframe;
            _root.beeframe = _root.beeframe + 1;
            if (!!!($old3 < _root.beetotal)) {
                _root.beeframe = 2;
            }
            var $old4 = _root.cloudframe;
            _root.cloudframe = _root.cloudframe + 1;
            if (!!!($old4 < _root.cloudtotal)) {
                _root.cloudframe = 2;
            }
        };
}
ASSetPropFlags(_global.Game.prototype, null, 1);
// ======== DoInitAction sprite=5 __Packages.com.extratoxic.audio.SoundPackage
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
// ======== DoInitAction sprite=6 __Packages.com.extratoxic.audio.SoundFile
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
// ======== DoInitAction sprite=7 __Packages.com.extratoxic.game.Scroll
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game) {
    _global.com.extratoxic.game = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game.Scroll) {
    $r1 = function (width, height) {
            super();
            this.width = width;
            this.height = height;
            this.x = 0;
            this.y = 0;
            this.offsets = new Array();
        };
    com.extratoxic.game.Scroll = $r1;
    com.extratoxic.game.Scroll.extends(Array);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            $r2 = this.length;
            while (true) {
                $r2 = $r2 - 1;
                if (!($r2 > -1)) break;
                this.offsets[$r2] = {y: (1 / (this[this.reference].height - this.height)) * (this[$r2].height - this.height), x: (1 / (this[this.reference].width - this.width)) * (this[$r2].width - this.width)};
            }
            this.offsets[0] = {y: 1, x: 1};
        };
    $r2.process = function () {
            $r2 = this.length;
            while (true) {
                $r2 = $r2 - 1;
                if (!($r2 > -1)) break;
                this[$r2].setPos(this.x * this.offsets[$r2].x, this.y * this.offsets[$r2].y);
            }
            if (this[this.reference].x < this[this.reference].lx) {
                $r2 = this.length;
                while (true) {
                    $r2 = $r2 - 1;
                    if (!($r2 > -1)) break;
                    this[$r2].x = this[$r2].lx;
                }
            } else {
                if ((this[this.reference].x + this.width) > this[this.reference].width) {
                    $r2 = this.length;
                    while (true) {
                        $r2 = $r2 - 1;
                        if (!($r2 > -1)) break;
                        this[$r2].x = this[$r2].width - this.width;
                    }
                }
            }
            if (this[this.reference].y < this[this.reference].ly) {
                $r2 = this.length;
                while (true) {
                    $r2 = $r2 - 1;
                    if (!($r2 > -1)) break;
                    this[$r2].y = this[$r2].ly;
                }
            } else {
                if ((this[this.reference].y + this.height) > this[this.reference].height) {
                    $r2 = this.length;
                    while (true) {
                        $r2 = $r2 - 1;
                        if (!($r2 > -1)) break;
                        this[$r2].y = this[$r2].height - this.height;
                    }
                }
            }
        };
    $r2.addLayer = function (layer, isReference) {
            this.push(layer);
            if (isReference) {
                this.reference = this.length - 1;
            }
        };
    $r2.move = function (x, y) {
            this.x = this.x + x;
            this.y = this.y + y;
        };
    $r2.setPos = function (x, y) {
            this.x = x;
            this.y = y;
        };
    $r2.start = function (Void) {
            com.extratoxic.events.Run.attach(this);
        };
    $r2.stop = function (Void) {
            com.extratoxic.events.Run.detach(this);
        };
    $r2.toString = function () {
            return (((("[Scroll] width:" + this.width) + " height:") + this.height) + " layer:") + this.length;
        };
}
ASSetPropFlags(com.extratoxic.game.Scroll.prototype, null, 1);
// ======== DoInitAction sprite=8 __Packages.com.extratoxic.game.tilemap.HandleTiles
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game) {
    _global.com.extratoxic.game = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game.tilemap) {
    _global.com.extratoxic.game.tilemap = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game.tilemap.HandleTiles) {
    $r1 = function (movie, map, screenwidth, screenheight, enemyUtil) {
            this.movie = movie;
            this.map = map;
            delete this.movie.loaded;
            this.offTiles = new Array();
            this.screenwidth = screenwidth;
            this.screenheight = screenheight;
            this.enemyUtil = enemyUtil;
            com.extratoxic.game.tilemap.HandleTiles.idcnt = 0;
            $r0 = 0;
            this.yv = $r0;
            this.xv = $r0;
            this.tx = new Array();
            this.ty = new Array();
            this.tw = new Array();
            this.th = new Array();
            this.tids = new Array();
            this.tiles = new Array();
        };
    com.extratoxic.game.tilemap.HandleTiles = $r1;
    $r2 = $r1.prototype;
    $r2.setMap = function (map) {
            this.lx = int(map.firstChild.attributes.x);
            this.ly = int(map.firstChild.attributes.y);
            this.width = int(map.firstChild.attributes.width);
            this.height = int(map.firstChild.attributes.height);
            while (true) {
                $r0 = /*enumerate*/ map.firstChild.childNodes;
                if ($r0 == null) break;
                $r4 = $r0;
                $r2 = map.firstChild.childNodes[$r4].attributes;
                this.addTile(new com.extratoxic.game.tilemap.Tile($r2.id, int($r2.x), int($r2.y), int($r2.w), int($r2.h), int($r2.d), int($r2.o) + this.OFFSET, int($r2.e)));
            }
        };
    $r2.addTile = function (newtile) {
            $r3 = newtile.id;
            $r2 = newtile;
            if (this.offTiles[$r2.linkId]) {
                $r2.off = true;
            }
            this.tx[$r3] = ($r2.x - $r2.width) - $r2.offset;
            this.ty[$r3] = ($r2.y - $r2.height) - $r2.offset;
            this.tw[$r3] = $r2.width + ($r2.offset * 2);
            this.th[$r3] = $r2.height + ($r2.offset * 2);
            this.tids[$r3] = $r2.linkId;
            this.tiles[$r3] = $r2;
            $r2.parent = this.movie;
            if (!!!(this.enemyUtil.getClasses($r2.linkId) == undefined)) {
                $r2.enemyUtil = this.enemyUtil;
            }
        };
    $r2.removeTile = function (id) {
            this.tx[id] = undefined;
            this.ty[id] = undefined;
            this.tw[id] = undefined;
            this.th[id] = undefined;
            this.tids[id] = undefined;
            this.tiles[id] = undefined;
        };
    $r2.initialize = function (Void) {
            this.setMap(this.map);
            $r0 = null;
            this.oay = $r0;
            this.oax = $r0;
            this.vts = new Array();
            this.visTilesNum = 0;
            this.xp = new Array();
            this.yp = new Array();
            $r2 = 0;
            while ($r2 < this.tids.length) {
                this.xp[$r2] = this.tx[$r2] + this.tw[$r2];
                this.yp[$r2] = this.ty[$r2] + this.th[$r2];
                $r2 = $r2 + 1;
            }
            this.registerObjects();
            this.start();
        };
    $r2.registerObjects = function (Void) {
            this.vtiles = new Array();
            $r4 = 0;
            while ($r4 < this.tids.length) {
                $r8 = Math.max(int(this.tx[$r4] / this.screenwidth), 0);
                $r6 = Math.max(int(this.ty[$r4] / this.screenheight), 0);
                $r7 = Math.max(int(this.xp[$r4] / this.screenwidth), 0);
                $r5 = Math.max(int(this.yp[$r4] / this.screenheight), 0);
                $r2 = $r8;
                while (!!!($r2 > $r7)) {
                    $r3 = $r6;
                    while (!!!($r3 > $r5)) {
                        if (this.vtiles[$r2] == undefined) {
                            this.vtiles[$r2] = new Array();
                        }
                        if (this.vtiles[$r2][$r3] == undefined) {
                            this.vtiles[$r2][$r3] = new Array();
                        }
                        this.vtiles[$r2][$r3][$r4] = true;
                        $r3 = $r3 + 1;
                    }
                    $r2 = $r2 + 1;
                }
                $r4 = $r4 + 1;
            }
        };
    $r2.getLimits = function (Void) {
            return {height: this.height, width: this.width, y: this.ly, x: this.lx};
        };
    $r2.process = function () {
            this.x = this.x + this.xv;
            this.y = this.y + this.yv;
            $r0 = 0;
            this.yv = $r0;
            this.xv = $r0;
            $r8 = int(this.x);
            $r7 = int(this.y);
            $r5 = int($r8 / this.screenwidth);
            $r4 = int($r7 / this.screenheight);
            if (($r5 == this.oax) && ($r4 == this.oay)) {
                while (true) {
                    $r0 = /*enumerate*/ this.movie;
                    if ($r0 == null) break;
                    $r15 = $r0;
                    if (this.movie[$r15].notile || this.movie[$r15].t) {
                        continue;
                    }
                    if (this.tiles[$r15].motion) {
                        $r3 = this.tiles[$r15].id;
                        $r2 = this.tiles[$r15];
                        this.tx[$r3] = (int($r2.movie._x) - $r2.width) - $r2.offset;
                        this.ty[$r3] = (int($r2.movie._y) - $r2.height) - $r2.offset;
                        this.xp[$r3] = this.tx[$r3] + this.tw[$r3];
                        this.yp[$r3] = this.ty[$r3] + this.th[$r3];
                        $r2.x = int($r2.movie._x);
                        $r2.y = int($r2.movie._y) - 0;
                    }
                    if ((!this.vts[$r15] && !this.movie[$r15].detached) && (this.movie[$r15].notile == undefined)) {
                        this.tiles[$r15].off = this.movie[$r15].off;
                        this.tiles[$r15].detached = this.movie[$r15].detached;
                        this.visTilesNum = this.visTilesNum - this.tiles[$r15].detach();
                    }
                }
            } else {
                this.oax = $r5;
                this.oay = $r4;
                this.vt = new Array();
                while (true) {
                    $r0 = /*enumerate*/ this.vtiles[$r5][$r4];
                    if ($r0 == null) break;
                    $r15 = $r0;
                    this.vt[$r15] = true;
                }
                while (true) {
                    $r0 = /*enumerate*/ this.vtiles[$r5 + 1][$r4];
                    if ($r0 == null) break;
                    $r15 = $r0;
                    this.vt[$r15] = true;
                }
                while (true) {
                    $r0 = /*enumerate*/ this.vtiles[$r5][$r4 + 1];
                    if ($r0 == null) break;
                    $r15 = $r0;
                    this.vt[$r15] = true;
                }
                while (true) {
                    $r0 = /*enumerate*/ this.vtiles[$r5 + 1][$r4 + 1];
                    if ($r0 == null) break;
                    $r15 = $r0;
                    this.vt[$r15] = true;
                }
            }
            $r12 = this.tx;
            $r10 = this.ty;
            $r11 = this.xp;
            $r9 = this.yp;
            $r13 = $r8 + this.screenwidth;
            $r14 = $r7 + this.screenheight;
            this.vts = new Array();
            while (true) {
                $r0 = /*enumerate*/ this.vt;
                if ($r0 == null) break;
                $r15 = $r0;
                if ($r11[$r15] > $r8) {
                    if ($r12[$r15] < $r13) {
                        if ($r9[$r15] > $r7) {
                            if ($r10[$r15] < $r14) {
                                this.vts[$r15] = true;
                                if (!this.movie[$r15]) {
                                    $r6 = this.tiles[$r15].attach();
                                    this.vts[$r15] = $r6;
                                    this.visTilesNum = this.visTilesNum + $r6;
                                }
                            }
                        }
                    }
                }
            }
            this.movie._x = this.xo - this.x;
            this.movie._y = this.yo - this.y;
        };
    $r2.start = function (Void) {
            com.extratoxic.events.Run.attach(this);
        };
    $r2.stop = function (Void) {
            com.extratoxic.events.Run.detach(this);
        };
    $r2.setPos = function (x, y) {
            this.x = x;
            this.y = y;
        };
    $r2.setOffset = function (xo, yo) {
            this.xo = xo;
            this.yo = yo;
        };
    $r2.move = function (xv, yv) {
            this.xv = this.xv + xv;
            this.yv = this.yv + yv;
        };
    $r2.toString = function () {
            return ("[HandleTiles with " + this.tiles.length) + " tiles]";
        };
    $r1.idcnt = 0;
    $r2.OFFSET = 30;
}
ASSetPropFlags(com.extratoxic.game.tilemap.HandleTiles.prototype, null, 1);
// ======== DoInitAction sprite=9 __Packages.com.extratoxic.game.tilemap.Tile
if (!_global.com) {
    _global.com = new Object();
}
<stack?>;
if (!_global.com.extratoxic) {
    _global.com.extratoxic = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game) {
    _global.com.extratoxic.game = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game.tilemap) {
    _global.com.extratoxic.game.tilemap = new Object();
}
<stack?>;
if (!_global.com.extratoxic.game.tilemap.Tile) {
    $r1 = function (linkId, x, y, width, height, depth, offset) {
            this.linkId = linkId;
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
            this.depth = depth;
            this.offset = offset;
            this.off = false;
            this.active = false;
            this.motion = false;
            var $old1 = com.extratoxic.game.tilemap.HandleTiles.idcnt;
            com.extratoxic.game.tilemap.HandleTiles.idcnt = com.extratoxic.game.tilemap.HandleTiles.idcnt + 1;
            this.id = $old1;
        };
    com.extratoxic.game.tilemap.Tile = $r1;
    $r2 = $r1.prototype;
    $r2.attach = function (tx) {
            if (this.enemyUtil == undefined) {
                if (!this.detached) {
                    this.movie = this.parent.attachMovie(this.linkId, this.id.toString(), this.depth, {_y: this.y, _x: this.x});
                    utils.PlatformUtil.create(this.movie, this);
                    if (this.off) {
                        this.movie.gotoAndStop("off");
                        this.movie.off = true;
                    }
                    return true;
                }
            } else {
                if (!this.off && !this.active) {
                    this.movie = this.parent.attachMovie(this.linkId, this.id.toString(), this.depth, {_y: this.y, _x: this.x});
                    this.movie.id = this.id;
                    this.enemyUtil.create(this.movie, this);
                    return true;
                }
            }
            return false;
        };
    $r2.detach = function (Void) {
            if (!!!(this.enemyUtil == undefined)) {
                this.dir = this.movie.actor.dir;
                this.enemyUtil.remove(this.movie);
            }
            this.movie.removeMovieClip();
            return true;
        };
}
ASSetPropFlags(com.extratoxic.game.tilemap.Tile.prototype, null, 1);
// ======== DoInitAction sprite=10 __Packages.utils.PlatformUtil
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.PlatformUtil) {
    $r1 = function () {
        };
    utils.PlatformUtil = $r1;
    $r2 = $r1.prototype;
    $r1.create = function (movie, tile) {
            $r0 = tile.linkId;
            if (!($r0 === "floe")) {
                if (!($r0 === "floe_b")) {
                    if (!($r0 === "wackel_s")) {
                        if (!($r0 === "wackel_b")) {
                            if (!($r0 === "moby")) {
                                if (!($r0 === "stamm_s")) {
                                    if (!($r0 === "p_ds")) {
                                        if (!($r0 === "p_ds_b")) {
                                            if (!($r0 === "p_c_l")) {
                                                if (!($r0 === "p_c_l_b")) {
                                                    if (!($r0 === "tiltstone_b")) {
                                                        if (!($r0 === "tiltstone_s")) {
                                                            goto L0000;
                                                            utils.PlatformUtil.move_tilting(movie, utils.PlatformUtil.soundEffects.getNewSound("splash"));
                                                            goto L0000;
                                                            utils.PlatformUtil.move_tilting(movie, utils.PlatformUtil.soundEffects.getNewSound("splash2"));
                                                            goto L0000;
                                                            utils.PlatformUtil.move_wackel(movie);
                                                            goto L0000;
                                                            utils.PlatformUtil.move_wackel(movie);
                                                            goto L0000;
                                                            movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                                                            goto L0000;
                                                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                                            goto L0000;
                                                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                                            goto L0000;
                                                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                                            goto L0000;
                                                            utils.PlatformUtil.move_cloud(movie);
                                                            goto L0000;
                                                            utils.PlatformUtil.move_cloud(movie);
                                                            goto L0000;
                                                            utils.PlatformUtil.move_wackel(movie);
                                                        } else {
                                                            utils.PlatformUtil.move_wackel(movie);
                                                            goto L0000;
                                                        }
                                                    } else {
                                                        utils.PlatformUtil.move_wackel(movie);
                                                        goto L0000;
                                                        utils.PlatformUtil.move_wackel(movie);
                                                        goto L0000;
                                                    }
                                                } else {
                                                    utils.PlatformUtil.move_cloud(movie);
                                                    goto L0000;
                                                    utils.PlatformUtil.move_wackel(movie);
                                                    goto L0000;
                                                    utils.PlatformUtil.move_wackel(movie);
                                                    goto L0000;
                                                }
                                            } else {
                                                utils.PlatformUtil.move_cloud(movie);
                                                goto L0000;
                                                utils.PlatformUtil.move_cloud(movie);
                                                goto L0000;
                                                utils.PlatformUtil.move_wackel(movie);
                                                goto L0000;
                                                utils.PlatformUtil.move_wackel(movie);
                                                goto L0000;
                                            }
                                        } else {
                                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                            goto L0000;
                                            utils.PlatformUtil.move_cloud(movie);
                                            goto L0000;
                                            utils.PlatformUtil.move_cloud(movie);
                                            goto L0000;
                                            utils.PlatformUtil.move_wackel(movie);
                                            goto L0000;
                                            utils.PlatformUtil.move_wackel(movie);
                                            goto L0000;
                                        }
                                    } else {
                                        utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                        goto L0000;
                                        utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                        goto L0000;
                                        utils.PlatformUtil.move_cloud(movie);
                                        goto L0000;
                                        utils.PlatformUtil.move_cloud(movie);
                                        goto L0000;
                                        utils.PlatformUtil.move_wackel(movie);
                                        goto L0000;
                                        utils.PlatformUtil.move_wackel(movie);
                                        goto L0000;
                                    }
                                } else {
                                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                    goto L0000;
                                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                    goto L0000;
                                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                    goto L0000;
                                    utils.PlatformUtil.move_cloud(movie);
                                    goto L0000;
                                    utils.PlatformUtil.move_cloud(movie);
                                    goto L0000;
                                    utils.PlatformUtil.move_wackel(movie);
                                    goto L0000;
                                    utils.PlatformUtil.move_wackel(movie);
                                    goto L0000;
                                }
                            } else {
                                movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                                goto L0000;
                                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                goto L0000;
                                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                goto L0000;
                                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                                goto L0000;
                                utils.PlatformUtil.move_cloud(movie);
                                goto L0000;
                                utils.PlatformUtil.move_cloud(movie);
                                goto L0000;
                                utils.PlatformUtil.move_wackel(movie);
                                goto L0000;
                                utils.PlatformUtil.move_wackel(movie);
                                goto L0000;
                            }
                        } else {
                            utils.PlatformUtil.move_wackel(movie);
                            goto L0000;
                            movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                            goto L0000;
                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                            goto L0000;
                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                            goto L0000;
                            utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                            goto L0000;
                            utils.PlatformUtil.move_cloud(movie);
                            goto L0000;
                            utils.PlatformUtil.move_cloud(movie);
                            goto L0000;
                            utils.PlatformUtil.move_wackel(movie);
                            goto L0000;
                            utils.PlatformUtil.move_wackel(movie);
                            goto L0000;
                        }
                    } else {
                        utils.PlatformUtil.move_wackel(movie);
                        goto L0000;
                        utils.PlatformUtil.move_wackel(movie);
                        goto L0000;
                        movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                        goto L0000;
                        utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                        goto L0000;
                        utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                        goto L0000;
                        utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                        goto L0000;
                        utils.PlatformUtil.move_cloud(movie);
                        goto L0000;
                        utils.PlatformUtil.move_cloud(movie);
                        goto L0000;
                        utils.PlatformUtil.move_wackel(movie);
                        goto L0000;
                        utils.PlatformUtil.move_wackel(movie);
                        goto L0000;
                    }
                } else {
                    utils.PlatformUtil.move_tilting(movie, utils.PlatformUtil.soundEffects.getNewSound("splash2"));
                    goto L0000;
                    utils.PlatformUtil.move_wackel(movie);
                    goto L0000;
                    utils.PlatformUtil.move_wackel(movie);
                    goto L0000;
                    movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                    goto L0000;
                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                    goto L0000;
                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                    goto L0000;
                    utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                    goto L0000;
                    utils.PlatformUtil.move_cloud(movie);
                    goto L0000;
                    utils.PlatformUtil.move_cloud(movie);
                    goto L0000;
                    utils.PlatformUtil.move_wackel(movie);
                    goto L0000;
                    utils.PlatformUtil.move_wackel(movie);
                    goto L0000;
                }
            } else {
                utils.PlatformUtil.move_tilting(movie, utils.PlatformUtil.soundEffects.getNewSound("splash"));
                goto L0000;
                utils.PlatformUtil.move_tilting(movie, utils.PlatformUtil.soundEffects.getNewSound("splash2"));
                goto L0000;
                utils.PlatformUtil.move_wackel(movie);
                goto L0000;
                utils.PlatformUtil.move_wackel(movie);
                goto L0000;
                movie.sprudel = utils.PlatformUtil.soundEffects.getNewSound("sprudel");
                goto L0000;
                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                goto L0000;
                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                goto L0000;
                utils.PlatformUtil.move_stamm(movie, utils.PlatformUtil.soundEffects.getNewSound("blub"));
                goto L0000;
                utils.PlatformUtil.move_cloud(movie);
                goto L0000;
                utils.PlatformUtil.move_cloud(movie);
                goto L0000;
                utils.PlatformUtil.move_wackel(movie);
                goto L0000;
                utils.PlatformUtil.move_wackel(movie);
                goto L0000;
            }
        };
    $r1.move_cloud = function (movie, sound) {
            movie.MAX_VEL = 2;
            movie.s_splash = sound;
            movie.s_splash.setVolume(30);
            movie.init = function () {
                        this.obstacle.MAX_VEL = 2;
                        this.obstacle.level = this.obstacle._y;
                        this.obstacle.tide = 0;
                        this.obstacle.vy = this.obstacle.tide;
                        this.obstacle.ease = true;
                        this.obstacle.offset = this.platform._y - this.obstacle.level;
                        this.obstacle.limit = this.obstacle._y + 30;
                        this.obstacle.push = function (vy) {
                                        if (this.pause) {
                                            return;
                                        }
                                        $r2 = vy * 2;
                                        if (!!!(this._y > this.limit)) {
                                            this.vy = this.vy - vy;
                                        }
                                        if ($r2 > 0.3) {
                                            this._parent.s_splash.start();
                                        }
                                    };
                        this.obstacle.onEnterFrame = function () {
                                        if (this._y < this.level) {
                                            if (this.vy > 0.2) {
                                                this.vy = this.vy * 0.5;
                                            }
                                            $r2 = 50;
                                        } else {
                                            $r2 = 100;
                                        }
                                        $r3 = (this._y - this.level) / $r2;
                                        this.vy = this.vy + $r3;
                                        if (this.vy > this.MAX_VEL) {
                                            this.vy = this.MAX_VEL;
                                        } else {
                                            if (this.vy < (0 - this.MAX_VEL)) {
                                                this.vy = 0 - this.MAX_VEL;
                                            }
                                        }
                                        this._y = this._y - this.vy;
                                        this._parent.platform._y = this._y + this.offset;
                                        if (this._y > this.limit) {
                                            this._y = this.limit;
                                        }
                                    };
                    };
        };
    $r1.move_stamm = function (movie, sound) {
            movie.MAX_VEL = utils.PlatformUtil.MAX_VEL;
            movie.s_splash = sound;
            movie.s_splash.setVolume(30);
            movie.init = function () {
                        this.obstacle.MAX_VEL = this.MAX_VEL;
                        this.obstacle.level = this.obstacle._y;
                        this.obstacle.tide = 0.3;
                        this.obstacle.vy = this.obstacle.tide;
                        this.obstacle.ease = true;
                        this.obstacle.offset = this.platform._y - this.obstacle.level;
                        this.obstacle.push = function (vy) {
                                        if (this.pause) {
                                            return;
                                        }
                                        $r2 = vy / 15;
                                        this.vy = this.vy - vy;
                                        if ($r2 > 0.3) {
                                            this._parent.s_splash.start();
                                        }
                                    };
                        this.obstacle.onEnterFrame = function () {
                                        if (this._y < this.level) {
                                            if (this.vy > 0.2) {
                                                this.vy = this.vy * 0.95;
                                            }
                                            $r2 = 50;
                                        } else {
                                            $r2 = 100;
                                        }
                                        $r3 = (this._y - this.level) / $r2;
                                        this.vy = this.vy + $r3;
                                        if (this.vy > utils.PlatformUtil.MAX_VEL) {
                                            this.vy = utils.PlatformUtil.MAX_VEL;
                                        } else {
                                            if (this.vy < (0 - utils.PlatformUtil.MAX_VEL)) {
                                                this.vy = 0 - utils.PlatformUtil.MAX_VEL;
                                            }
                                        }
                                        this._y = this._y - this.vy;
                                        this._parent.platform._y = this._y + this.offset;
                                    };
                    };
        };
    $r1.move_tilting = function (movie, sound) {
            movie.MAX_VEL = utils.PlatformUtil.MAX_VEL;
            movie.s_splash = sound;
            movie.s_splash.setVolume(30);
            movie.init = function () {
                        this.obstacle.pause = false;
                        this.obstacle.pivot = int(this.obstacle._width / 2);
                        this.obstacle.angle = 0;
                        this.obstacle.drift = 0;
                        this.obstacle.dir = 1;
                        this.obstacle.impact = 0;
                        this.obstacle.weight = 0;
                        this.obstacle.slip = 0;
                        this.obstacle.glide = 0;
                        this.obstacle.MAX_ANGLE = 20;
                        this.obstacle.MAX_MOVE = 0.5;
                        this.obstacle.level = this.obstacle._y;
                        this.obstacle.tide = 0.3;
                        this.obstacle.vy = this.obstacle.tide;
                        this.obstacle.ease = true;
                        this.obstacle.offset = this.platform._y - this.obstacle.level;
                        if (this.obstacle.force == undefined) {
                            this.obstacle.force = 1000;
                        }
                        this.obstacle.impact = function (x, weight) {
                                        if (this.pause) {
                                            return;
                                        }
                                        $r2 = (x + this.pivot) / this.force;
                                        this.drift = this.drift + ($r2 * weight);
                                        if (this.drift > this.MAX_MOVE) {
                                            this.drift = this.MAX_MOVE;
                                        } else {
                                            if (this.drift < (0 - this.MAX_MOVE)) {
                                                this.drift = 0 - this.MAX_MOVE;
                                            }
                                        }
                                    };
                        this.obstacle.push = function (vy) {
                                        if (this.pause) {
                                            return;
                                        }
                                        $r2 = vy / 15;
                                        if (this._y < ((this.level + $r2) + 8)) {
                                            this.vy = this.vy - vy;
                                        }
                                        if ($r2 > 0.3) {
                                            this._parent.s_splash.start();
                                        }
                                    };
                        this.obstacle.onEnterFrame = function () {
                                        if (this.pause) {
                                            return;
                                        }
                                        if (this._y < this.level) {
                                            if (this.vy > 0.2) {
                                                this.vy = this.vy * 0.95;
                                            }
                                            $r2 = 50;
                                        } else {
                                            $r2 = 100;
                                        }
                                        $r3 = (this._y - this.level) / $r2;
                                        this.vy = this.vy + $r3;
                                        if (this.vy > utils.PlatformUtil.MAX_VEL) {
                                            this.vy = utils.PlatformUtil.MAX_VEL;
                                        } else {
                                            if (this.vy < (0 - utils.PlatformUtil.MAX_VEL)) {
                                                this.vy = 0 - utils.PlatformUtil.MAX_VEL;
                                            }
                                        }
                                        this._y = this._y - this.vy;
                                        this._parent.platform._y = this._y + this.offset;
                                        if (this._rotation < 0) {
                                            this.dir = -1;
                                            this.drift = this.drift + 0.05;
                                        } else {
                                            this.dir = 1;
                                            this.drift = this.drift - 0.05;
                                        }
                                        this.drift = this.drift * 0.95;
                                        this.angle = this.angle + this.drift;
                                        this.slip = this.angle / 180;
                                        this.glide = this.angle / 100;
                                        if ((this.glide < 0.1) && (this.glide > -0.01)) {
                                            this.glide = 0;
                                        }
                                        if (this.angle > this.MAX_ANGLE) {
                                            this.angle = this.MAX_ANGLE;
                                        } else {
                                            if (this.angle < (0 - this.MAX_ANGLE)) {
                                                this.angle = 0 - this.MAX_ANGLE;
                                            }
                                        }
                                        $r0 = this.angle;
                                        this._rotation = $r0;
                                        this._parent.platform._rotation = $r0;
                                    };
                    };
        };
    $r1.move_wackel = function (movie, sound) {
            movie.MAX_VEL = utils.PlatformUtil.MAX_VEL;
            movie.s_splash = sound;
            movie.s_splash.setVolume(30);
            if (movie.obstacle == undefined) {
                movie.mc = movie.obstacle1;
            } else {
                movie.mc = movie.obstacle;
            }
            movie.init = function () {
                        this.mc.pause = false;
                        this.mc.pivot = int(this.mc._width / 2);
                        this.mc.angle = 0;
                        this.mc.drift = 0;
                        this.mc.dir = 1;
                        this.mc.impact = 0;
                        this.mc.weight = 0;
                        this.mc.slip = 0;
                        this.mc.glide = 0;
                        this.mc.MAX_ANGLE = 40;
                        this.mc.MAX_MOVE = 1.5;
                        if (this.mc.force == undefined) {
                            this.mc.force = 1000;
                        }
                        this.mc.impact = function (x, weight) {
                                        if (this.pause) {
                                            return;
                                        }
                                        $r2 = (x + this.pivot) / this.force;
                                        this.drift = this.drift + ($r2 * weight);
                                        if (this.drift > this.MAX_MOVE) {
                                            this.drift = this.MAX_MOVE;
                                        } else {
                                            if (this.drift < (0 - this.MAX_MOVE)) {
                                                this.drift = 0 - this.MAX_MOVE;
                                            }
                                        }
                                    };
                        this.mc.onEnterFrame = function () {
                                        if (this.pause) {
                                            return;
                                        }
                                        if (this._rotation < 0) {
                                            this.dir = -1;
                                            this.drift = this.drift + 0.05;
                                        } else {
                                            this.dir = 1;
                                            this.drift = this.drift - 0.05;
                                        }
                                        this.drift = this.drift * 0.95;
                                        this.angle = this.angle + this.drift;
                                        this.slip = this.angle / 70;
                                        this.glide = this.angle / 100;
                                        if ((this.glide < 0.1) && (this.glide > -0.01)) {
                                            this.glide = 0;
                                        }
                                        if (this.angle > this.MAX_ANGLE) {
                                            this.angle = this.MAX_ANGLE;
                                        } else {
                                            if (this.angle < (0 - this.MAX_ANGLE)) {
                                                this.angle = 0 - this.MAX_ANGLE;
                                            }
                                        }
                                        $r0 = this.angle;
                                        this._rotation = $r0;
                                        this._parent.platform._rotation = $r0;
                                        $r2 = this.getBounds(this._parent);
                                        this._parent.obstacle2._x = $r2.xMin + 0;
                                        this._parent.obstacle3._x = $r2.xMax - 0;
                                    };
                    };
        };
    $r1.MAX_VEL = 1;
}
ASSetPropFlags(utils.PlatformUtil.prototype, null, 1);
// ======== DoInitAction sprite=11 __Packages.utils.EnemyUtil
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.EnemyUtil) {
    $r1 = function (layer) {
            this.layer = layer;
            this.classes = {elpix: actors.ElPix, pinkustack4x: actors.PinkuStack4x, pinkustack3x: actors.PinkuStack3x, pinkustack2x: actors.PinkuStack2x, hellscorpion: actors.HellScorpion, scorpion: actors.Scorpion, beycnake: actors.Beycnake, eagle: actors.Eagle, speedywood: actors.SpeedyWood, snowspider: actors.SnowSpider, spider_run: actors.SpiderRun, spider_web: actors.SpiderWeb, treeguy: actors.Treeguy, joggybear: actors.Joggybear, pinkumom: actors.PinkuMom, speedy: actors.Speedy, purpu: actors.Purpu, orange: actors.Orange, pinku: actors.Pinku, iceball: actors.Iceball};
        };
    utils.EnemyUtil = $r1;
    $r2 = $r1.prototype;
    $r2.create = function (movie, tile) {
            if (typeof tile == "string") {
                $r4 = tile;
            } else {
                $r4 = tile.linkId;
            }
            $r3 = this.getClasses($r4);
            movie.actor = new $r3[undefined](this.layer, movie, tile);
            movie.init = function () {
                        this.actor.setPos(this._x, this._y);
                        this.actor.initialize();
                        this.actor.start();
                    };
        };
    $r2.remove = function (movie) {
            movie.actor.stop();
            movie.actor.box.removeMovieClip();
            delete movie.actor;
        };
    $r2.getClasses = function (enemy) {
            if (!!!(enemy == undefined)) {
                return this.classes[enemy];
            }
            return this.classes;
        };
}
ASSetPropFlags(utils.EnemyUtil.prototype, null, 1);
// ======== DoInitAction sprite=12 __Packages.actors.Char
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Char) {
    $r1 = function (layer, actor) {
            this.layer = layer;
            this.actor = actor;
            this.dir = 1;
            this.newdir = 1;
            this.lockmove = 0;
            this.jumptime = 0;
            this.jumps = 0;
            this.jumpstage = 0;
            this.jumpcnt = 0;
            this.walks = 0;
            this.slides = 0;
            this.r_action_up = true;
            $r0 = 0;
            this.vy = $r0;
            this.vx = $r0;
            this.pivot = int(this.box / 2);
        };
    actors.Char = $r1;
    $r2 = $r1.prototype;
    $r2.createBox = function (h, hoffset, voffset, xoff) {
            $r2 = Math.floor(this.actor._width / 2) - 4;
            if (xoff == undefined) {
                $r3 = 0;
            } else {
                $r3 = xoff;
            }
            $r0 = actors.Char.depthcnt + 1;
            actors.Char.depthcnt = $r0;
            this.box = this.layer.createEmptyMovieClip(this.actor._name + "_box", $r0);
            this.box.beginFill(0, 0);
            this.box.moveTo((0 - $r2) + $r3, h - voffset);
            this.box.lineTo($r2 + $r3, h - voffset);
            this.box.lineTo($r2 + $r3, ((0 - this.actor._height) + hoffset) - voffset);
            this.box.lineTo((0 - $r2) + $r3, ((0 - this.actor._height) + hoffset) - voffset);
            this.box.endFill();
            this.box.notile = true;
            this.box.name = this.actor._name;
            this.boxheight = this.box._height;
        };
    $r2.start = function (Void) {
            com.extratoxic.events.Run.attach(this);
        };
    $r2.stop = function (Void) {
            com.extratoxic.events.Run.detach(this);
        };
    $r2.process = function () {
        };
    $r2.adjust = function (Void) {
            $r6 = this.collisionUtil.resolve(this.vx, this.vy, this.action_up);
            this.onGround = false;
            this.hitLadder = false;
            this.uponLadder = false;
            this.hitTop = false;
            $r10 = false;
            $r7 = this.box.getBounds(this.layer);
            $r3 = 0;
            while ($r3 < $r6.length) {
                $r9 = $r6[$r3][0];
                $r2 = $r6[$r3][1];
                $r4 = $r6[$r3][2];
                $r8 = $r6[$r3][3];
                $r5 = $r2.getBounds(this.layer);
                if ($r2._name == undefined) {
                } else {
                    $r0 = $r9;
                    if (!($r0 === this.A_SNAPBOTTOM)) {
                        if (!($r0 === this.A_SNAPTOP)) {
                            if (!($r0 === this.A_SNAPLEFT)) {
                                if (!($r0 === this.A_SNAPRIGHT)) {
                                    if (!($r0 === this.A_HITLADDER)) {
                                        if (!($r0 === this.A_HITENEMY)) {
                                            if (!($r0 === this.A_DEADLY)) {
                                                if (!($r0 === this.A_PICKUP)) {
                                                    goto L054e;
                                                    if (this.uponLadder && this.action_down) {
                                                    } else {
                                                        this.onGround = true;
                                                        this.oy = ($r5.yMin - $r7.yMax) + this.TOLERANCE;
                                                        if ((this.move == this.M_CROUCH) || (this.move == this.M_SLIDE)) {
                                                            if (!($r2.glide == undefined) && (Math.abs($r2.glide) > 0.05)) {
                                                                if ($r2.dir == this.dir) {
                                                                    this.vx = this.vx + $r2.glide;
                                                                }
                                                                this.slides = 1;
                                                            }
                                                        }
                                                        if (!!!($r2.slip == undefined)) {
                                                            if (!this.enemy) {
                                                                this.vx = this.vx + $r2.slip;
                                                            }
                                                        }
                                                        if (!!!($r4 == undefined)) {
                                                            this.ox = this.ox + $r4;
                                                        }
                                                        if (!!!($r8 == undefined)) {
                                                            this.oy = this.oy + $r8;
                                                        }
                                                        if (this.vy > 0) {
                                                            this.vy = 0;
                                                        }
                                                        this.ly = (this.y + this.vy) + this.oy;
                                                        goto L054e;
                                                        this.oy = ($r5.yMax - $r7.yMin) + this.TOLERANCE;
                                                        this.vy = 0;
                                                        this.ly = (this.y + this.vy) + this.oy;
                                                        this.hitTop = true;
                                                        goto L054e;
                                                        this.ox = ($r5.xMin - $r7.xMax) - this.TOLERANCE;
                                                        this.vx = 0;
                                                        this.lx = (this.x + this.vx) + this.ox;
                                                        this.event_boundLeft();
                                                        this.walks = 0;
                                                        goto L054e;
                                                        this.ox = ($r5.xMax - $r7.xMin) + this.TOLERANCE;
                                                        this.vx = 0;
                                                        this.lx = (this.x + this.vx) + this.ox;
                                                        this.event_boundRight();
                                                        this.walks = 0;
                                                        goto L054e;
                                                        if ($r4) {
                                                            this.uponLadder = true;
                                                        } else {
                                                            this.hitLadder = true;
                                                            this.onLadder = true;
                                                        }
                                                        goto L054e;
                                                        this.event_hitEnemy($r2, $r4, $r10);
                                                        $r10 = true;
                                                        goto L054e;
                                                        this.event_die();
                                                        goto L054e;
                                                        this.event_pickup($r2);
                                                        goto L054e;
                                                    }
                                                } else {
                                                    this.event_pickup($r2);
                                                    goto L054e;
                                                }
                                            } else {
                                                this.event_die();
                                                goto L054e;
                                                this.event_pickup($r2);
                                                goto L054e;
                                            }
                                        } else {
                                            this.event_hitEnemy($r2, $r4, $r10);
                                            $r10 = true;
                                            goto L054e;
                                            this.event_die();
                                            goto L054e;
                                            this.event_pickup($r2);
                                            goto L054e;
                                        }
                                    } else {
                                        if ($r4) {
                                            this.uponLadder = true;
                                        } else {
                                            this.hitLadder = true;
                                            this.onLadder = true;
                                        }
                                        goto L054e;
                                        this.event_hitEnemy($r2, $r4, $r10);
                                        $r10 = true;
                                        goto L054e;
                                        this.event_die();
                                        goto L054e;
                                        this.event_pickup($r2);
                                        goto L054e;
                                    }
                                } else {
                                    this.ox = ($r5.xMax - $r7.xMin) + this.TOLERANCE;
                                    this.vx = 0;
                                    this.lx = (this.x + this.vx) + this.ox;
                                    this.event_boundRight();
                                    this.walks = 0;
                                    goto L054e;
                                    if ($r4) {
                                        this.uponLadder = true;
                                    } else {
                                        this.hitLadder = true;
                                        this.onLadder = true;
                                    }
                                    goto L054e;
                                    this.event_hitEnemy($r2, $r4, $r10);
                                    $r10 = true;
                                    goto L054e;
                                    this.event_die();
                                    goto L054e;
                                    this.event_pickup($r2);
                                    goto L054e;
                                }
                            } else {
                                this.ox = ($r5.xMin - $r7.xMax) - this.TOLERANCE;
                                this.vx = 0;
                                this.lx = (this.x + this.vx) + this.ox;
                                this.event_boundLeft();
                                this.walks = 0;
                                goto L054e;
                                this.ox = ($r5.xMax - $r7.xMin) + this.TOLERANCE;
                                this.vx = 0;
                                this.lx = (this.x + this.vx) + this.ox;
                                this.event_boundRight();
                                this.walks = 0;
                                goto L054e;
                                if ($r4) {
                                    this.uponLadder = true;
                                } else {
                                    this.hitLadder = true;
                                    this.onLadder = true;
                                }
                                goto L054e;
                                this.event_hitEnemy($r2, $r4, $r10);
                                $r10 = true;
                                goto L054e;
                                this.event_die();
                                goto L054e;
                                this.event_pickup($r2);
                                goto L054e;
                            }
                        } else {
                            this.oy = ($r5.yMax - $r7.yMin) + this.TOLERANCE;
                            this.vy = 0;
                            this.ly = (this.y + this.vy) + this.oy;
                            this.hitTop = true;
                            goto L054e;
                            this.ox = ($r5.xMin - $r7.xMax) - this.TOLERANCE;
                            this.vx = 0;
                            this.lx = (this.x + this.vx) + this.ox;
                            this.event_boundLeft();
                            this.walks = 0;
                            goto L054e;
                            this.ox = ($r5.xMax - $r7.xMin) + this.TOLERANCE;
                            this.vx = 0;
                            this.lx = (this.x + this.vx) + this.ox;
                            this.event_boundRight();
                            this.walks = 0;
                            goto L054e;
                            if ($r4) {
                                this.uponLadder = true;
                            } else {
                                this.hitLadder = true;
                                this.onLadder = true;
                            }
                            goto L054e;
                            this.event_hitEnemy($r2, $r4, $r10);
                            $r10 = true;
                            goto L054e;
                            this.event_die();
                            goto L054e;
                            this.event_pickup($r2);
                            goto L054e;
                        }
                    } else {
                        if (this.uponLadder && this.action_down) {
                        } else {
                            this.onGround = true;
                            this.oy = ($r5.yMin - $r7.yMax) + this.TOLERANCE;
                            if ((this.move == this.M_CROUCH) || (this.move == this.M_SLIDE)) {
                                if (!($r2.glide == undefined) && (Math.abs($r2.glide) > 0.05)) {
                                    if ($r2.dir == this.dir) {
                                        this.vx = this.vx + $r2.glide;
                                    }
                                    this.slides = 1;
                                }
                            }
                            if (!!!($r2.slip == undefined)) {
                                if (!this.enemy) {
                                    this.vx = this.vx + $r2.slip;
                                }
                            }
                            if (!!!($r4 == undefined)) {
                                this.ox = this.ox + $r4;
                            }
                            if (!!!($r8 == undefined)) {
                                this.oy = this.oy + $r8;
                            }
                            if (this.vy > 0) {
                                this.vy = 0;
                            }
                            this.ly = (this.y + this.vy) + this.oy;
                            goto L054e;
                            this.oy = ($r5.yMax - $r7.yMin) + this.TOLERANCE;
                            this.vy = 0;
                            this.ly = (this.y + this.vy) + this.oy;
                            this.hitTop = true;
                            goto L054e;
                            this.ox = ($r5.xMin - $r7.xMax) - this.TOLERANCE;
                            this.vx = 0;
                            this.lx = (this.x + this.vx) + this.ox;
                            this.event_boundLeft();
                            this.walks = 0;
                            goto L054e;
                            this.ox = ($r5.xMax - $r7.xMin) + this.TOLERANCE;
                            this.vx = 0;
                            this.lx = (this.x + this.vx) + this.ox;
                            this.event_boundRight();
                            this.walks = 0;
                            goto L054e;
                            if ($r4) {
                                this.uponLadder = true;
                            } else {
                                this.hitLadder = true;
                                this.onLadder = true;
                            }
                            goto L054e;
                            this.event_hitEnemy($r2, $r4, $r10);
                            $r10 = true;
                            goto L054e;
                            this.event_die();
                            goto L054e;
                            this.event_pickup($r2);
                            goto L054e;
                        }
                    }
                }
                $r3 = $r3 + 1;
            }
        };
    $r2.calculate = function (Void) {
            this.box._x = this.x;
            this.box._y = this.y;
            this.move = this.M_STAND;
            if (this.onGround && this.r_action_up) {
                this.r_action_up = false;
                this.jumps = 1;
                this.jumpstage = 0;
                this.jumpcnt = 0;
            }
            if (this.onLadder) {
                $r0 = 0;
                this.vy = $r0;
                this.vx = $r0;
            } else {
                this.vy = this.vy + this.GRAVITY;
            }
            if (this.walks < 50) {
                $r2 = this.WALK_MAX_ACC;
            } else {
                $r2 = this.RUN_MAX_ACC;
            }
            if (this.action_left && (!this.action_down || this.onLadder)) {
                if (this.onLadder) {
                    this.vx = 0 - this.CLIMB_SPEED;
                } else {
                    if (this.vx > (0 - $r2)) {
                        this.vx = this.vx - this.WALK_ACC;
                    }
                    if (this.dir == 1) {
                        this.move = this.M_FLIP;
                        this.walks = 0;
                    } else {
                        if (this.walks > 60) {
                            this.move = this.M_RUN;
                            if (this.walks == 61) {
                                this.s_steps.start(0, 999);
                            }
                        } else {
                            this.move = this.M_WALK;
                        }
                        this.walks = this.walks + 1;
                    }
                }
                this.newdir = -1;
            } else {
                if (this.action_right && (!this.action_down || this.onLadder)) {
                    if (this.onLadder) {
                        this.vx = this.CLIMB_SPEED;
                    } else {
                        if (this.vx < $r2) {
                            this.vx = this.vx + this.WALK_ACC;
                        }
                        if (this.dir == -1) {
                            this.move = this.M_FLIP;
                            this.walks = 0;
                        } else {
                            if (this.walks > 60) {
                                this.move = this.M_RUN;
                                if (this.walks == 61) {
                                    this.s_steps.start(0, 999);
                                }
                            } else {
                                this.move = this.M_WALK;
                            }
                            this.walks = this.walks + 1;
                        }
                    }
                    this.newdir = 1;
                } else {
                    if (this.slides > 0) {
                        this.vx = this.vx * this.FRICTION_SLIDE;
                    } else {
                        this.vx = this.vx * this.FRICTION;
                    }
                    this.walks = 0;
                }
            }
            if (this.action_up) {
                this.slides = 0;
                if (this.hitLadder && !this.hitTop) {
                    this.onLadder = true;
                    this.vy = 0 - this.CLIMB_SPEED;
                } else {
                    $r0 = this.jumps + 1;
                    this.jumps = $r0;
                    if ($r0 < 3) {
                        this.jumpstage = 1;
                    } else {
                        if (this.jumps < 5) {
                            this.jumpstage = 2;
                        } else {
                            if (this.jumps < 7) {
                                if (this.move == this.M_RUN) {
                                    this.jumpstage = 4;
                                } else {
                                    this.jumpstage = 3;
                                }
                            }
                        }
                    }
                    if (this.jumps == 2) {
                        this.s_jump.start();
                    }
                }
            } else {
                if (this.action_down) {
                    if (this.hitLadder || this.uponLadder) {
                        this.onLadder = true;
                        this.vy = this.CLIMB_SPEED;
                        if (this.uponLadder) {
                            this.hitLadder = true;
                        }
                    } else {
                        if (this.onGround) {
                            this.move = this.M_CROUCH;
                            if (!!!(this.box._height == int(this.boxheight / 2))) {
                                this.box._height = int(this.boxheight / 2);
                            }
                            if (!this.l_action_down) {
                                this.s_crouch.start();
                            }
                        }
                    }
                } else {
                    this.slides = 0;
                    this.r_action_up = true;
                }
            }
            if (this.jumpstage > 0) {
                var $old1 = this.jumpcnt;
                this.jumpcnt = this.jumpcnt + 1;
                if (!!!($old1 > this.jumpstage)) {
                    this.vy = this.vy - 5;
                    this.collisionUtil.onMovable = undefined;
                }
            }
            if (this.slides > 0) {
                this.move = this.M_SLIDE;
                $r0 = this.slides + 1;
                this.slides = $r0;
                if ($r0 > 50) {
                    this.slides = 0;
                }
            }
            if (this.vy < (0 - this.TOLERANCE)) {
                this.move = this.M_JUMP;
            } else {
                if ((this.vy > this.GRAVITY) && (this.slides == 0)) {
                    this.move = this.M_FALL;
                    this.jumps = 11;
                }
            }
            if (this.move == this.M_STAND) {
                if (Math.abs(this.vx) > 0.5) {
                    this.move = this.M_WALK;
                }
            }
            if (this.onLadder) {
                if (this.hitLadder) {
                    this.move = this.M_CLIMB;
                } else {
                    this.onLadder = false;
                }
            }
            if (!!!(this.move == this.M_FALL)) {
                this.s_steps.stop();
            }
            if (!(this.move == this.M_CROUCH) && !(this.move == this.M_SLIDE)) {
                if (!!!(this.box._height == this.boxheight)) {
                    this.box._height = this.boxheight;
                }
            }
            this.vx = int(this.vx * 1000) / 1000;
            if (this.vx > this.RUN_MAX_ACC) {
                this.vx = this.RUN_MAX_ACC;
            } else {
                if (this.vx < (0 - this.RUN_MAX_ACC)) {
                    this.vx = 0 - this.RUN_MAX_ACC;
                }
            }
            if ((this.vx < 0.1) && (this.vx > -0.1)) {
                this.vx = 0;
            }
            if (this.vy > this.MAX_VEL) {
                this.vy = this.MAX_VEL;
            } else {
                if (this.vy < (0 - this.MAX_VEL)) {
                    this.vy = 0 - this.MAX_VEL;
                }
            }
        };
    $r2.position = function (Void) {
            this.x = this.x + (this.vx + this.ox);
            this.y = this.y + (this.vy + this.oy);
        };
    $r2.saveStates = function (Void) {
            this.move = 0;
            $r0 = 0;
            this.oy = $r0;
            this.ox = $r0;
            this.lx = this.x;
            this.ly = this.y;
        };
    $r2.animate = function (Void) {
            if (this.lockmove < 1) {
                this.actor.container.gotoAndStop(this.move);
            } else {
                this.lockmove = this.lockmove - 1;
            }
            if (this.move == this.M_CLIMB) {
                if ((this.vx == 0) && (this.vy == 0)) {
                    this.actor.container.container.stop();
                } else {
                    this.actor.container.container.play();
                }
            }
            if (!!!(this.dir == this.newdir)) {
                this.lockmove = Math.abs(int(this.vx)) + 4;
                this.dir = this.newdir;
                if (!this.enemy) {
                    this.actor._xscale = this.actor._xscale * -1;
                } else {
                    this.actor.container._xscale = this.actor.container._xscale * -1;
                }
            }
        };
    $r2.setPos = function (x, y) {
            this.x = x;
            this.y = y;
        };
    $r2.getMovie = function (Void) {
            return this.actor;
        };
    $r2.event_hit = function (bx, by) {
            $r0 = this.energy - 1;
            this.energy = $r0;
            if ($r0 == 0) {
                this.event_die();
                return true;
            } else {
                this.event_hitEffect();
                return false;
            }
        };
    $r2.event_die = function (bx, by) {
            this.actor.container.gotoAndStop(this.M_DIE);
            if (this.enemy) {
                this.actor.gotoAndStop("off");
                this.actor.detached = true;
                this.box.removeMovieClip();
            } else {
                this.actor.gotoAndStop(1);
                this.globalstop();
            }
            this.event_dieEffect();
            this.animate = null;
            this.stop();
        };
    $r1.depthcnt = 30999;
    $r2.weight = 1;
    $r2.M_STAND = 1;
    $r2.M_WALK = 2;
    $r2.M_JUMP = 3;
    $r2.M_FALL = 4;
    $r2.M_CROUCH = 5;
    $r2.M_FLIP = 6;
    $r2.M_RUN = 7;
    $r2.M_SLIDE = 8;
    $r2.M_CLIMB = 9;
    $r2.M_DIE = 10;
    $r2.M_HURT = 11;
    $r2.GRAVITY = 1.2;
    $r2.FRICTION = 0.9;
    $r2.FRICTION_SLIDE = 0.975;
    $r2.JUMP_FORCE = 23;
    $r2.MAX_JUMPS_WALK = 7;
    $r2.MAX_JUMPS_RUN = 9;
    $r2.WALK_ACC = 0.6;
    $r2.WALK_MAX_ACC = 7;
    $r2.RUN_MAX_ACC = 10;
    $r2.RUN_STEPS = 60;
    $r2.CLIMB_SPEED = 2;
    $r2.ABYSS = 1000;
    $r2.MAX_VEL = 16;
    $r2.TOLERANCE = 0.1;
    $r2.A_SNAPTOP = 1;
    $r2.A_SNAPBOTTOM = 2;
    $r2.A_SNAPRIGHT = 3;
    $r2.A_SNAPLEFT = 4;
    $r2.A_HITLADDER = 5;
    $r2.A_HITENEMY = 6;
    $r2.A_DEADLY = 7;
    $r2.A_PICKUP = 8;
}
ASSetPropFlags(actors.Char.prototype, null, 1);
// ======== DoInitAction sprite=13 __Packages.utils.CollisionUtil
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.CollisionUtil) {
    $r1 = function (box, layer, enemy, weight) {
            this.box = box;
            this.layer = layer;
            this.enemy = enemy;
            this.weight = weight;
            this.onMovable = undefined;
            this.pivot = int(box._width / 2);
        };
    utils.CollisionUtil = $r1;
    $r2 = $r1.prototype;
    $r2.resolve = function (vx, vy, action_up) {
            return this.resolveCollisions(this.getCollisions(), vx, vy, action_up);
        };
    $r2.getCollisions = function () {
            $r4 = new Array();
            while (true) {
                $r0 = /*enumerate*/ this.layer;
                if ($r0 == null) break;
                $r5 = $r0;
                $r3 = this.layer[$r5].obstacle;
                if (!!!($r3 == undefined)) {
                    if (this.enemy) {
                        if ((this.box.name == this.layer[$r5]._name) || $r3.hero) {
                            $r3 = null;
                            continue;
                        }
                    }
                    if (this.box.hitTest($r3)) {
                        $r4.push($r3);
                    }
                } else {
                    if (!!!(this.layer[$r5].obstacles == undefined)) {
                        $r2 = 1;
                        while (!!!($r2 > this.layer[$r5].obstacles)) {
                            $r3 = this.layer[$r5]["obstacle" + $r2];
                            if (!!!($r3 == undefined)) {
                                if (this.box.hitTest($r3)) {
                                    $r4.push($r3);
                                }
                            }
                            $r2 = $r2 + 1;
                        }
                    }
                }
            }
            return $r4;
        };
    $r2.resolveCollisions = function (collisions, vx, vy, action_up) {
            $r4 = this.box.getBounds(this.layer);
            $r22 = collisions.length;
            $r7 = new Array();
            $r19 = false;
            $r18 = false;
            $r17 = false;
            $r8 = 0;
            while ($r8 < $r22) {
                $r2 = collisions[$r8];
                $r21 = $r2._parent;
                $r3 = $r2.type;
                $r5 = 0;
                $r15 = undefined;
                $r14 = undefined;
                if ($r2.enemy && !this.enemy) {
                } else {
                    $r20 = $r2.getBounds(this.layer);
                    if (!($r3 < this.P_PICKUPS.start) && !($r3 > this.P_PICKUPS.end)) {
                        $r7.push([this.A_PICKUP, $r2]);
                    } else {
                        if (!($r3 < this.O_OBSTACLES.start) && !($r3 > this.E_ENEMIES.end)) {
                            $r12 = false;
                            if ($r3 == this.O_DEADLY) {
                                $r7.push([this.A_DEADLY, $r2]);
                            }
                            if ($r3 == this.O_BEVEL) {
                                if (!(($r4.xMin + this.pivot) < ($r20.xMin - 1)) && !(($r4.xMax - this.pivot) > ($r20.xMax + 1))) {
                                    if ($r2.dir == 1) {
                                        $r26 = (100 * (($r4.xMax - this.pivot) - $r20.xMin)) / ($r20.xMax - $r20.xMin);
                                    } else {
                                        $r26 = (100 * (($r20.xMax - $r4.xMax) + this.pivot)) / ($r20.xMax - $r20.xMin);
                                    }
                                    $r25 = (($r20.yMax - $r20.yMin) * $r26) / 100;
                                    $r10 = ($r4.yMax - vy) - $r20.yMin;
                                    $r13 = (((this.MAX_VEL / 2) + this.TOLERANCE) + this.GRAVITY) + 2;
                                    if (!($r10 < ($r25 - $r13)) && !($r10 > ($r25 + $r13))) {
                                        $r14 = $r25 + this.TOLERANCE;
                                        if (!!!(vy < (0 - (this.GRAVITY + this.TOLERANCE)))) {
                                            $r5 = this.A_SNAPBOTTOM;
                                            if ($r2.tilting) {
                                                $r16 = this.box.getBounds($r2._parent);
                                                $r2.impact($r16.xMax - this.pivot, this.weight);
                                            }
                                            if ($r2.ease) {
                                                if (this.onMovable == undefined) {
                                                    $r2.push(vy);
                                                }
                                            }
                                            if ($r2.moving) {
                                                this.onMovable = $r2;
                                                $r17 = true;
                                            }
                                        }
                                    }
                                }
                            } else {
                                $r9 = 0;
                                if ($r2.flying) {
                                    $r9 = 5;
                                }
                                if (!!!(($r4.yMax - $r20.yMin) > (((this.MAX_VEL + this.GRAVITY) + this.TOLERANCE) + $r9))) {
                                    if ($r2.drop) {
                                        $r2.push(vy);
                                    }
                                    if (!!!(vy < this.GRAVITY)) {
                                        if (!$r2.noTop && !$r19) {
                                            $r5 = this.A_SNAPBOTTOM;
                                            $r18 = true;
                                            if ($r2.ease) {
                                                if (this.onMovable == undefined) {
                                                    $r2.push(vy);
                                                }
                                            }
                                            if ($r2.moving) {
                                                this.onMovable = $r2;
                                                $r17 = true;
                                                if (!!!(this.onMovable.lx == undefined)) {
                                                    $r15 = this.onMovable.lx - this.onMovable.x;
                                                }
                                            }
                                            if ((!($r3 < this.E_ENEMIES.start) && !($r3 > this.E_ENEMIES.end)) && (vy > 1)) {
                                                $r12 = true;
                                                if (($r3 == 31) || this.enemy) {
                                                    $r5 = 0;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if ($r3 == this.O_LADDER) {
                                $r11 = !(($r4.yMax - $r20.yMin) > (vy + 5));
                                $r7.push([this.A_HITLADDER, $r2, $r11, 0]);
                                if (!$r11) {
                                } else {
                                    if (vy < 1) {
                                        if (($r3 == this.O_MASSIVE) && !(($r20.yMax - $r4.yMin) > (this.MAX_VEL + 2))) {
                                            if ((!$r2.noTop && !$r2.noBottom) && ($r5 == 0)) {
                                                if (!$r18) {
                                                    $r5 = this.A_SNAPTOP;
                                                    $r19 = true;
                                                }
                                            }
                                        }
                                    }
                                    if ($r5 == 0) {
                                        if ($r3 == this.O_MASSIVE) {
                                            if (($r4.yMax - $r20.yMin) > 3) {
                                                if (!!!(($r4.xMax - $r20.xMin) > (this.MAX_VEL + 2))) {
                                                    $r5 = this.A_SNAPLEFT;
                                                } else {
                                                    if (!!!(($r20.xMax - $r4.xMin) > (this.MAX_VEL + 2))) {
                                                        $r5 = this.A_SNAPRIGHT;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (!!!($r5 == 0)) {
                                        $r7.push([$r5, $r2, $r15, $r14]);
                                    }
                                    if (!($r3 < this.E_ENEMIES.start) && !($r3 > this.E_ENEMIES.end)) {
                                        $r7.push([this.A_HITENEMY, $r2, $r12]);
                                    }
                                }
                            } else {
                                if (vy < 1) {
                                    if (($r3 == this.O_MASSIVE) && !(($r20.yMax - $r4.yMin) > (this.MAX_VEL + 2))) {
                                        if ((!$r2.noTop && !$r2.noBottom) && ($r5 == 0)) {
                                            if (!$r18) {
                                                $r5 = this.A_SNAPTOP;
                                                $r19 = true;
                                            }
                                        }
                                    }
                                }
                                if ($r5 == 0) {
                                    if ($r3 == this.O_MASSIVE) {
                                        if (($r4.yMax - $r20.yMin) > 3) {
                                            if (!!!(($r4.xMax - $r20.xMin) > (this.MAX_VEL + 2))) {
                                                $r5 = this.A_SNAPLEFT;
                                            } else {
                                                if (!!!(($r20.xMax - $r4.xMin) > (this.MAX_VEL + 2))) {
                                                    $r5 = this.A_SNAPRIGHT;
                                                }
                                            }
                                        }
                                    }
                                }
                                if (!!!($r5 == 0)) {
                                    $r7.push([$r5, $r2, $r15, $r14]);
                                }
                                if (!($r3 < this.E_ENEMIES.start) && !($r3 > this.E_ENEMIES.end)) {
                                    $r7.push([this.A_HITENEMY, $r2, $r12]);
                                }
                            }
                        }
                    }
                }
                $r8 = $r8 + 1;
            }
            if (!(this.onMovable == undefined) && !$r17) {
                $r20 = this.onMovable.getBounds(this.layer);
                $r14 = 0;
                $r15 = 0;
                if (!!!(this.onMovable.lx == undefined)) {
                    $r15 = this.onMovable.lx - this.onMovable.x;
                }
                $r24 = this.pivot;
                if (this.onMovable.flying) {
                    $r24 = $r24 + (this.pivot - 0);
                }
                if (!(($r4.xMin + $r24) < ($r20.xMin - 1)) && !(($r4.xMax - $r24) > ($r20.xMax + 1))) {
                    if (this.onMovable.type == this.O_BEVEL) {
                        if ($r2.dir == 1) {
                            $r26 = (100 * (($r4.xMax - this.pivot) - $r20.xMin)) / ($r20.xMax - $r20.xMin);
                        } else {
                            $r26 = (100 * (($r20.xMax - $r4.xMax) + this.pivot)) / ($r20.xMax - $r20.xMin);
                        }
                        $r25 = (($r20.yMax - $r20.yMin) * $r26) / 100;
                        $r14 = $r25 - this.TOLERANCE;
                    }
                    $r7.push([this.A_SNAPBOTTOM, this.onMovable, $r15, $r14]);
                } else {
                    this.onMovable = undefined;
                }
            }
            return $r7;
        };
    $r2.hitColBox = function (Void) {
            $r4 = this.getCollisions();
            while (true) {
                $r0 = /*enumerate*/ this.layer;
                if ($r0 == null) break;
                $r3 = $r0;
                $r2 = this.layer[$r3].obstacle;
                if (!!!($r2 == undefined)) {
                    if ($r2.type == 0) {
                        if (this.box.hitTest($r2)) {
                            do {
                            } while (!(null == null));
                            return true;
                        }
                    }
                }
            }
            return false;
        };
    $r2.O_OBSTACLES = {end: 29, start: 0};
    $r2.E_ENEMIES = {end: 79, start: 30};
    $r2.P_PICKUPS = {end: 99, start: 80};
    $r2.O_MASSIVE = 0;
    $r2.O_FLOATING = 1;
    $r2.O_FLYING = 2;
    $r2.O_BEVEL = 3;
    $r2.O_DEADLY = 4;
    $r2.O_EASE = 5;
    $r2.O_LADDER = 8;
    $r2.GRAVITY = 1.2;
    $r2.MAX_VEL = 16;
    $r2.TOLERANCE = 0.1;
    $r2.A_SNAPTOP = 1;
    $r2.A_SNAPBOTTOM = 2;
    $r2.A_SNAPRIGHT = 3;
    $r2.A_SNAPLEFT = 4;
    $r2.A_HITLADDER = 5;
    $r2.A_HITENEMY = 6;
    $r2.A_DEADLY = 7;
    $r2.A_PICKUP = 8;
}
ASSetPropFlags(utils.CollisionUtil.prototype, null, 1);
// ======== DoInitAction sprite=14 __Packages.actors.Iceball
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Iceball) {
    $r1 = function (layer, actor) {
            super(layer, actor);
            actor.notile = true;
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.dir = -1;
            this.weight = 0.7;
        };
    actors.Iceball = $r1;
    actors.Iceball.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.createBox(-1, 5, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.dir = 1;
            this.ox = 2 * this.dir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.dir = -1;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
        };
    $r2.process = function () {
            this.saveStates();
            this.collisionUtil.onMovable = undefined;
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
            this.actor.container.container._rotation = this.actor.container.container._rotation + (this.vx * 2);
            if (this.actor._y > 3000) {
                this.event_die();
            }
        };
    $r2.WALKSPEED = 3;
}
ASSetPropFlags(actors.Iceball.prototype, null, 1);
// ======== DoInitAction sprite=15 __Packages.actors.Pinku
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Pinku) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Pinku = $r1;
    actors.Pinku.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            if ((this.depth > $r2.getDepth()) && !($r2.linkId == "pinkumom")) {
                if (random(2)) {
                    this.pause = 40;
                } else {
                    this.pause = 40;
                }
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.Pinku.prototype, null, 1);
// ======== DoInitAction sprite=16 __Packages.actors.Orange
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Orange) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Orange = $r1;
    actors.Orange.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            if ((this.depth > $r2.getDepth()) && !($r2.linkId == "pinkumom")) {
                if (random(2)) {
                    this.pause = 40;
                } else {
                    this.pause = 40;
                }
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.Orange.prototype, null, 1);
// ======== DoInitAction sprite=17 __Packages.actors.Purpu
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Purpu) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Purpu = $r1;
    actors.Purpu.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            if ((this.depth > $r2.getDepth()) && !($r2.linkId == "pinkumom")) {
                if (random(2)) {
                    this.pause = 40;
                } else {
                    this.pause = 40;
                }
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.Purpu.prototype, null, 1);
// ======== DoInitAction sprite=18 __Packages.actors.Speedy
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Speedy) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.35;
        };
    actors.Speedy = $r1;
    actors.Speedy.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            if ((this.depth > $r2.getDepth()) && !($r2.linkId == "pinkumom")) {
                if (random(2)) {
                    this.newdir = this.newdir * -1;
                    this.pause = 40;
                    this.ox = 2 * this.newdir;
                } else {
                    this.pause = 40;
                }
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 2;
}
ASSetPropFlags(actors.Speedy.prototype, null, 1);
// ======== DoInitAction sprite=19 __Packages.actors.PinkuMom
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.PinkuMom) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.nextPause = 80;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.7;
        };
    actors.PinkuMom = $r1;
    actors.PinkuMom.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            _global.attackPinku = undefined;
            this.createBox(-1, 0, 0, -40);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            if (this.angry > 0) {
                this.pause = 30;
                this.angry = 30;
            } else {
                this.newdir = 1;
                this.pause = 10;
            }
        };
    $r2.event_boundLeft = function (Void) {
            if (this.angry > 0) {
                this.pause = 30;
                this.angry = 30;
            } else {
                this.newdir = -1;
                this.pause = 10;
            }
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
        };
    $r2.process = function () {
            this.saveStates();
            if (!!!(_global.attackPinku == undefined)) {
                if (this.angry == 0) {
                    this.pause = 20;
                }
                this.target = _global.attackPinku;
                if (this.target._x < this.box._x) {
                    this.newdir = -1;
                } else {
                    this.newdir = 1;
                }
                this.angry = 200;
                this.nextPause = 210;
                _global.attackPinku = undefined;
            }
            if (this.nextPause == 0) {
                this.angry = 0;
                this.pause = 70;
                this.nextPause = random(60) + 100;
            }
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
                this.nextPause = this.nextPause - 1;
                if (this.angry > 0) {
                    this.vx = this.RUNSPEED * this.dir;
                    if (this.target._x < this.box._x) {
                        this.newdir = -1;
                    } else {
                        this.newdir = 1;
                    }
                    if (!!!(this.dir == this.newdir)) {
                        this.pause = 20;
                    }
                }
            } else {
                this.pause = this.pause - 1;
            }
            if (this.angry > 0) {
                this.angry = this.angry - 1;
                this.actor.container.container._visible = false;
                this.actor.container.container1._visible = true;
            } else {
                this.actor.container.container._visible = true;
                this.actor.container.container1._visible = false;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1;
    $r2.RUNSPEED = 5;
}
ASSetPropFlags(actors.PinkuMom.prototype, null, 1);
// ======== DoInitAction sprite=20 __Packages.actors.Joggybear
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Joggybear) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.dir = -1;
            this.weight = 0.7;
            this.throwcount = 1;
        };
    actors.Joggybear = $r1;
    actors.Joggybear.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.createBox(-1, 0, 0);
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            this.newdir = this.newdir * -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.process = function () {
            $r0 = this.throwcount - 1;
            this.throwcount = $r0;
            if ($r0 == 0) {
                this.throwIceball();
                this.throwcount = this.THROWTIME;
            }
        };
    $r2.throwIceball = function (Void) {
            $r0 = actors.Joggybear.depthcnt + 1;
            var $old1 = actors.Joggybear.depthcnt;
            actors.Joggybear.depthcnt = $r0;
            $r2 = this.layer.attachMovie("iceball", "iceball" + $r0, $old1, {_y: this.actor._y - 8, _x: this.actor._x - 35});
            this.tile.enemyUtil.create($r2, "iceball");
            if (actors.Joggybear.depthcnt > 50010) {
                actors.Joggybear.depthcnt = 50000;
            }
        };
    $r1.depthcnt = 6000;
    $r2.WALKSPEED = 0;
    $r2.THROWTIME = 100;
}
ASSetPropFlags(actors.Joggybear.prototype, null, 1);
// ======== DoInitAction sprite=21 __Packages.actors.Treeguy
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Treeguy) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Treeguy = $r1;
    actors.Treeguy.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 1;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 1;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor.obstacle._xscale = this.actor.container._xscale;
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 2;
}
ASSetPropFlags(actors.Treeguy.prototype, null, 1);
// ======== DoInitAction sprite=22 __Packages.actors.SpiderWeb
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.SpiderWeb) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 60;
            this.enemy = true;
            this.changedir = 10;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.SpiderWeb = $r1;
    actors.SpiderWeb.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.vdir = 1;
            this.victim = _global.chubbybox;
            this.createBox(-1, 10, -15, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
            if ((this.depth > $r2.getDepth()) && !($r2.linkId == "pinkumom")) {
                if (random(2)) {
                    this.newdir = this.newdir * -1;
                    this.pause = 40;
                    this.ox = 2 * this.newdir;
                    $r0 = 0;
                    this.vy = $r0;
                    this.vx = $r0;
                } else {
                    this.pause = 40;
                }
            }
        };
    $r2.process = function () {
            this.box._x = this.x;
            this.box._y = this.y;
            this.saveStates();
            $r3 = this.collisionUtil.hitColBox();
            if ($r3) {
                this.x = this.lx - (this.dir * 2);
                this.y = this.ly - (this.vdir * 2);
                this.box._x = this.x;
                this.box._y = this.y;
                this.changedir = 0;
                this.pause = 60;
            }
            if (this.changedir > 0) {
                this.changedir = this.changedir - 1;
            }
            if (this.changedir == 0) {
                if (this.victim._x > (this.x + 5)) {
                    this.dir = 1;
                } else {
                    if (this.victim._x < (this.x - 5)) {
                        this.dir = -1;
                    } else {
                        this.dir = 0;
                    }
                }
                if (this.victim._y > (this.y + 5)) {
                    this.vdir = 1;
                } else {
                    if (this.victim._y < (this.y - 5)) {
                        this.vdir = -1;
                    } else {
                        this.vdir = 0;
                    }
                }
                $r2 = 0;
                if ((this.vdir == -1) && (this.dir == 0)) {
                    $r2 = 0;
                } else {
                    if ((this.vdir == -1) && (this.dir == 1)) {
                        $r2 = 45;
                    } else {
                        if ((this.vdir == 0) && (this.dir == 1)) {
                            $r2 = 90;
                        } else {
                            if ((this.vdir == 1) && (this.dir == 1)) {
                                $r2 = 135;
                            } else {
                                if ((this.vdir == 1) && (this.dir == 0)) {
                                    $r2 = 180;
                                } else {
                                    if ((this.vdir == 1) && (this.dir == -1)) {
                                        $r2 = -135;
                                    } else {
                                        if ((this.vdir == 0) && (this.dir == -1)) {
                                            $r2 = -90;
                                        } else {
                                            if ((this.vdir == -1) && (this.dir == -1)) {
                                                $r2 = -45;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                this.actor.container._rotation = $r2;
                this.changedir = 10;
            }
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
                this.vy = this.WALKSPEED * this.vdir;
                this.actor.container.gotoAndStop(2);
            } else {
                this.actor.container.gotoAndStop(1);
                this.pause = this.pause - 1;
                $r0 = 0;
                this.vy = $r0;
                this.vx = $r0;
            }
            this.position();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 0.8;
}
ASSetPropFlags(actors.SpiderWeb.prototype, null, 1);
// ======== DoInitAction sprite=23 __Packages.actors.SpiderRun
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.SpiderRun) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.nextChange = 30;
            this.enemy = true;
            this.newdir = -1;
            this.speed = this.WALKSPEED;
            this.weight = 0.55;
        };
    actors.SpiderRun = $r1;
    actors.SpiderRun.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.tile.motion = true;
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
            if (this.pause > 0) {
                return;
            }
            $r4 = obstacle.type;
            $r2 = obstacle._parent;
        };
    $r2.randomMove = function (Void) {
            this.pause = random(20) + 5;
            if (random(2)) {
                this.newdir = this.newdir * -1;
                this.ox = 2 * this.newdir;
            }
            this.speed = (this.WALKSPEED + random(2)) - 1;
        };
    $r2.process = function () {
            this.saveStates();
            if (this.nextChange == 0) {
                this.randomMove();
                this.pause = 20;
                this.nextChange = random(60) + 40;
            } else {
                this.nextChange = this.nextChange - 1;
            }
            if (this.pause == 0) {
                this.vx = this.speed * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.speed = 0;
    $r2.WALKSPEED = 4;
}
ASSetPropFlags(actors.SpiderRun.prototype, null, 1);
// ======== DoInitAction sprite=24 __Packages.actors.SnowSpider
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.SnowSpider) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 9999;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.7;
        };
    actors.SnowSpider = $r1;
    actors.SnowSpider.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.createBox(-1, 0, 0, -40);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            if (this.angry > 0) {
                this.pause = 10;
                this.angry = 10;
            } else {
                this.newdir = 1;
                this.pause = 10;
            }
        };
    $r2.event_boundLeft = function (Void) {
            if (this.angry > 0) {
                this.pause = 10;
                this.angry = 10;
            } else {
                this.pause = 10;
                this.newdir = -1;
            }
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
        };
    $r2.event_hitEffect = function (Void) {
            this.target = _global.chubbybox;
            this.lockmove = 20;
            this.pause = 20;
            this.angry = 150;
            this.actor.container.gotoAndStop(this.M_HURT);
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
                if (this.angry > 0) {
                    this.vx = this.RUNSPEED * this.dir;
                    if (this.target._x < this.box._x) {
                        this.newdir = -1;
                    } else {
                        this.newdir = 1;
                    }
                    if (!!!(this.dir == this.newdir)) {
                        this.pause = 20;
                    }
                }
            } else {
                this.pause = this.pause - 1;
            }
            if (this.angry > 0) {
                this.angry = this.angry - 1;
                this.actor.container.container._visible = false;
                this.actor.container.container1._visible = true;
            } else {
                this.actor.container.container._visible = true;
                this.actor.container.container1._visible = false;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 2;
    $r2.RUNSPEED = 12;
}
ASSetPropFlags(actors.SnowSpider.prototype, null, 1);
// ======== DoInitAction sprite=25 __Packages.actors.SpeedyWood
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.SpeedyWood) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.35;
        };
    actors.SpeedyWood = $r1;
    actors.SpeedyWood.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 0;
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 5;
}
ASSetPropFlags(actors.SpeedyWood.prototype, null, 1);
// ======== DoInitAction sprite=26 __Packages.actors.Eagle
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Eagle) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Eagle = $r1;
    actors.Eagle.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_dieEffect = function (Void) {
            this.actor.container._x = this.ax;
            this.actor.container._y = this.ay;
            if (this.frame < 163) {
                this.actor.container._xscale = this.dir * -1;
            } else {
                this.actor.container._xscale = this.dir;
            }
        };
    $r2.process = function () {
            this.frame = this.actor._currentframe;
            this.ax = this.actor.container._x;
            this.ay = this.actor.container._y;
            this.dir = this.actor.container._xscale;
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.Eagle.prototype, null, 1);
// ======== DoInitAction sprite=27 __Packages.actors.Beycnake
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Beycnake) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Beycnake = $r1;
    actors.Beycnake.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1;
}
ASSetPropFlags(actors.Beycnake.prototype, null, 1);
// ======== DoInitAction sprite=28 __Packages.actors.Scorpion
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Scorpion) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.Scorpion = $r1;
    actors.Scorpion.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 2;
}
ASSetPropFlags(actors.Scorpion.prototype, null, 1);
// ======== DoInitAction sprite=29 __Packages.actors.HellScorpion
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.HellScorpion) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.HellScorpion = $r1;
    actors.HellScorpion.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            this.tile.motion = true;
            if (!!!(this.actor.dir == undefined)) {
                this.newdir = this.actor.dir;
            }
            if (!!!(this.actor.pause == undefined)) {
                this.pause = this.actor.pause;
            }
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 2;
}
ASSetPropFlags(actors.HellScorpion.prototype, null, 1);
// ======== DoInitAction sprite=30 __Packages.actors.PinkuStack2x
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.PinkuStack2x) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.PinkuStack2x = $r1;
    actors.PinkuStack2x.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.stack = 2;
            this.energy = this.stack;
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEffect = function (Void) {
            this.actor.container["p" + this.energy].gotoAndStop(2);
            this.actor["obstacle" + (this.energy + 1)].type = 9999;
            this.actor["obstacle" + (this.energy + 1)]._visible = false;
            this.actor["obstacle" + this.energy].type = 30;
            if (this.energy == 1) {
                this.actor.container.carry._visible = false;
                this.actor.container.walk._visible = true;
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.PinkuStack2x.prototype, null, 1);
// ======== DoInitAction sprite=31 __Packages.actors.PinkuStack3x
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.PinkuStack3x) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.PinkuStack3x = $r1;
    actors.PinkuStack3x.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.stack = 3;
            this.energy = this.stack;
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEffect = function (Void) {
            this.actor.container["p" + this.energy].gotoAndStop(2);
            this.actor["obstacle" + (this.energy + 1)].type = 9999;
            this.actor["obstacle" + (this.energy + 1)]._visible = false;
            this.actor["obstacle" + this.energy].type = 30;
            if (this.energy == 1) {
                this.actor.container.carry._visible = false;
                this.actor.container.walk._visible = true;
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.PinkuStack3x.prototype, null, 1);
// ======== DoInitAction sprite=32 __Packages.actors.PinkuStack4x
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.PinkuStack4x) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 1;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
        };
    actors.PinkuStack4x = $r1;
    actors.PinkuStack4x.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.tile.motion = true;
            this.stack = 4;
            this.energy = this.stack;
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.event_boundRight = function (Void) {
            this.newdir = 1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_boundLeft = function (Void) {
            this.newdir = -1;
            this.pause = 10;
            this.ox = 2 * this.newdir;
            this.vx = 0;
        };
    $r2.event_hitEffect = function (Void) {
            this.actor.container["p" + this.energy].gotoAndStop(2);
            this.actor["obstacle" + (this.energy + 1)].type = 9999;
            this.actor["obstacle" + (this.energy + 1)]._visible = false;
            this.actor["obstacle" + this.energy].type = 30;
            if (this.energy == 1) {
                this.actor.container.carry._visible = false;
                this.actor.container.walk._visible = true;
            }
        };
    $r2.process = function () {
            this.saveStates();
            if (this.pause == 0) {
                this.vx = this.WALKSPEED * this.dir;
            } else {
                this.pause = this.pause - 1;
            }
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.PinkuStack4x.prototype, null, 1);
// ======== DoInitAction sprite=33 __Packages.actors.ElPix
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.ElPix) {
    $r1 = function (layer, actor, tile) {
            super(layer, actor);
            this.tile = tile;
            this.depth = actor.getDepth();
            this.energymax = 8;
            this.energy = this.energymax;
            this.pause = 0;
            this.enemy = true;
            this.newdir = -1;
            this.weight = 0.55;
            this.untouchable = 0;
        };
    actors.ElPix = $r1;
    actors.ElPix.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (Void) {
            if (!!!(this.tile.dir == undefined)) {
                this.newdir = this.tile.dir;
            }
            this.energy_mc = this.actor._parent._parent._parent.energy.boss_energy;
            this.hold_left = this.actor.container.container.hold_left;
            this.hold_right = this.actor.container.container.hold_right;
            this.ship = this.actor.container.container.container;
            this.pipeline = this.WINGHOLD.concat();
            this.actor.throwPinku = com.extratoxic.events.Delegate.create(this, "throwPinku");
            this.actor.showEnergy = com.extratoxic.events.Delegate.create(this, "showEnergy");
            this.createBox(-1, 0, 0);
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
        };
    $r2.showEnergy = function (Void) {
            this.energy_mc._visible = true;
            this.energy_mc.play();
        };
    $r2.event_hitEffect = function (Void) {
            this.energy_mc["b_energy_" + (this.energy - 1).toString()].gotoAndPlay("lost");
            this.lockmove = 20;
            this.untouchable = this.UNTOUCHABLE_HIT;
            this.actor.stop();
            this.actor.container.container.gotoAndPlay("hurt");
            if (this.energy == 5) {
                this.ship.gotoAndPlay("left_break");
            } else {
                if (this.energy == 3) {
                    this.ship.gotoAndPlay("right_break");
                    this.pipeline = [];
                } else {
                    if (this.energy == 1) {
                        this.ship.gotoAndPlay("hit");
                        this.lockmove = 100;
                        this.untouchable = 0;
                        this.actor.obstacle.type = 88;
                        this.actor.obstacle._xscale = 500;
                        this.actor.obstacle._yscale = 500;
                        this.ship._parent.gotoAndStop(1);
                        this.stop();
                        this.killEnemies();
                        this.process = null;
                    }
                }
            }
        };
    $r2.event_hitEnemy = function (obstacle, hit) {
        };
    $r2.killEnemies = function (Void) {
            while (true) {
                $r0 = /*enumerate*/ this.layer;
                if ($r0 == null) break;
                $r3 = $r0;
                $r2 = this.layer[$r3];
                if (!!!($r2.actor == undefined)) {
                    $r2.actor.event_die();
                }
            }
        };
    $r2.process = function () {
            this.saveStates();
            this.move = 1;
            if (this.lockmove > 1) {
                this.lockmove = this.lockmove - 1;
                if (this.lockmove == 1) {
                    this.actor.play();
                }
            }
            if (this.untouchable > 0) {
                this.actor.obstacle.type = -1;
                this.untouchable = this.untouchable - 1;
                var $old2 = this.untouchable_hide;
                this.untouchable_hide = this.untouchable_hide - 1;
                if ($old2 == 0) {
                    this.actor.container._visible = !this.actor.container._visible;
                    this.untouchable_hide = this.UNTOUCHABLE_HIDE;
                }
                if (this.untouchable == 0) {
                    this.actor.container._visible = true;
                    this.untouchable_hide = this.UNTOUCHABLE_HIDE;
                }
            } else {
                this.actor.obstacle.type = 30;
            }
            this.actor._x = this.lx;
            this.actor._y = this.ly;
        };
    $r2.throwPinku = function (Void) {
            $r4 = this.pipeline.splice(random(this.pipeline.length), 1);
            if (!this.ship.right_break) {
                if ((this.actor.container._x > 0) || this.ship.left_break) {
                    $r3 = (this.actor.container._x + 150) + 160;
                    $r5 = this.actor.container._y + 210;
                }
            }
            if (!this.ship.left_break && (this.actor.container._x < 0)) {
                $r3 = this.actor.container._x + 180;
                $r5 = this.actor.container._y + 210;
            }
            if (this.ship.left_break && this.ship.right_break) {
                $r3 = (this.actor.container._x + 150) + 100;
                $r5 = this.actor.container._y + 210;
            }
            $r0 = actors.ElPix.depthcnt + 1;
            var $old1 = actors.ElPix.depthcnt;
            actors.ElPix.depthcnt = $r0;
            $r2 = this.layer.attachMovie($r4, "pinku" + $r0, $old1, {_y: $r5, _x: $r3});
            if (this.actor.container._x < 0) {
                $r2.dir = 1;
            }
            $r2.pause = 20;
            if (this.pipeline.length == 0) {
                if (!this.ship.right_break) {
                    this.pipeline = this.WINGHOLD.concat();
                } else {
                    this.pipeline = this.MAINHOLD.concat();
                }
            }
            this.tile.enemyUtil.create($r2, $r4.toString());
            if (actors.ElPix.depthcnt > 50010) {
                actors.ElPix.depthcnt = 50000;
            }
        };
    $r1.depthcnt = 6000;
    $r2.UNTOUCHABLE_HIT = 70;
    $r2.UNTOUCHABLE_HIDE = 2;
    $r2.untouchable_hide = actors.ElPix.prototype.UNTOUCHABLE_HIDE;
    $r2.PINKUS = new Array("pinku", "orange", "purpu", "speedywood", "scorpion", "spider_run", "beycnake");
    $r2.WINGHOLD = new Array("pinku", "orange", "purpu", "speedywood");
    $r2.MAINHOLD = new Array("beycnake", "scorpion", "spider_run", "beycnake");
    $r2.WALKSPEED = 1.2;
}
ASSetPropFlags(actors.ElPix.prototype, null, 1);
// ======== DoInitAction sprite=34 __Packages.com.extratoxic.events.Delegate
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
// ======== DoInitAction sprite=35 __Packages.utils.ControlUtil
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.ControlUtil) {
    $r1 = function (layers, platform) {
            this.layers = layers;
            this.platform = platform;
        };
    utils.ControlUtil = $r1;
    $r2 = $r1.prototype;
    $r2.pauseGame = function (exclude) {
            this.stopTimeline(this.platform, exclude);
            this.stopLayers();
            com.extratoxic.events.Run.hold();
        };
    $r2.resumeGame = function (Void) {
            this.startTimeline(this.platform);
            this.startLayers();
            com.extratoxic.events.Run.resume();
        };
    $r2.stopTimeline = function (movie, exclude) {
            while (true) {
                $r0 = /*enumerate*/ movie;
                if ($r0 == null) break;
                $r4 = $r0;
                if ((typeof movie[$r4] == "movieclip") && !(movie[$r4]._name == exclude)) {
                    if (!!!(movie[$r4].actor == undefined)) {
                        if (movie[$r4].resume == undefined) {
                            if (movie[$r4].out) {
                                movie[$r4].resume = null;
                            } else {
                                movie[$r4].resume = function () {
                                                                this.container.container.play();
                                                            };
                            }
                        }
                    }
                    if (!!!(movie[$r4].pause == undefined)) {
                        movie[$r4].pause = true;
                    }
                    movie[$r4].stop();
                    this.stopTimeline(movie[$r4], exclude);
                }
            }
        };
    $r2.startTimeline = function (movie) {
            while (true) {
                $r0 = /*enumerate*/ movie;
                if ($r0 == null) break;
                $r3 = $r0;
                if (!!!(movie[$r3].linkId == undefined)) {
                    movie[$r3].resume();
                }
                if (typeof movie[$r3] == "movieclip") {
                    if (!!!(movie[$r3].pause == undefined)) {
                        movie[$r3].pause = false;
                    }
                    this.startTimeline(movie[$r3]);
                }
            }
        };
    $r2.stopLayers = function (Void) {
            while (true) {
                $r0 = /*enumerate*/ this.layers;
                if ($r0 == null) break;
                $r2 = $r0;
                this.layers[$r2].handleTiles.stop();
            }
        };
    $r2.startLayers = function (Void) {
            while (true) {
                $r0 = /*enumerate*/ this.layers;
                if ($r0 == null) break;
                $r2 = $r0;
                this.layers[$r2].handleTiles.start();
            }
        };
}
ASSetPropFlags(utils.ControlUtil.prototype, null, 1);
// ======== DoInitAction sprite=36 __Packages.actors.Hero
if (!_global.actors) {
    _global.actors = new Object();
}
<stack?>;
if (!_global.actors.Hero) {
    $r1 = function (layer, actor, scroll, sh, sounds) {
            super(layer, actor);
            this.scroll = scroll;
            this.sh = sh;
            this.sounds = sounds;
            $r6 = _global.c;
            $r5 = 0;
            $r4 = 0;
            while (!!!($r4 > 3)) {
                if ($r6[$r4]) {
                    $r5 = $r5 + 1;
                }
                $r4 = $r4 + 1;
            }
            this.energymax = (3 + $r5) + 0;
            this.energy = this.energymax;
            this.crystals = 0;
            this.untouchable = 0;
            this.lockinput = 0;
            this.foundContainer = false;
            this.enemy = false;
            $r0 = 0;
            this.sox = $r0;
            this.soy = $r0;
            this.keyAction = false;
            this.weight = 1;
        };
    actors.Hero = $r1;
    actors.Hero.extends(actors.Char);
    $r2 = $r1.prototype;
    $r2.initialize = function (s_music) {
            this.s_music = s_music;
            this.createBox(1, 10, 4);
            _global.chubbybox = this.box;
            this.collisionUtil = new utils.CollisionUtil(this.box, this.layer, this.enemy, this.weight);
            this.s_jump = this.sounds.getNewSound("jump");
            this.s_jump.setVolume(50);
            this.s_hitEnemy = this.sounds.getNewSound("hitEnemy");
            this.s_hitEnemy.setVolume(70);
            this.s_hurt = this.sounds.getNewSound("hurt");
            this.s_hurt.setVolume(50);
            this.s_gameover = this.sounds.getNewSound("gameover");
            this.s_energy = this.sounds.getNewSound("energy");
            this.s_energy_container = this.sounds.getNewSound("energy_container");
            this.s_crystal = this.sounds.getNewSound("crystal");
            this.s_576 = this.sounds.getNewSound("c_576");
            this.s_crouch = this.sounds.getNewSound("crouch");
            this.s_steps = this.sounds.getNewSound("steps");
            this.s_finish = this.sounds.getNewSound("finish");
            this.s_finish_elpix = this.sounds.getNewSound("finish_elpix");
            $r3 = 1;
            while (!!!($r3 > 6)) {
                if ($r3 < this.energymax) {
                    this.energy_mc["energy_" + $r3].gotoAndStop(1);
                } else {
                    this.energy_mc["energy_" + $r3].gotoAndStop("empty");
                }
                $r3 = $r3 + 1;
            }
            this.energy_mc._visible = true;
        };
    $r2.setOutput = function (crystals_mc, chars_mc, energy_mc) {
            this.crystals_mc = crystals_mc;
            this.chars_mc = chars_mc;
            this.energy_mc = energy_mc;
        };
    $r2.process = function () {
            this.saveStates();
            this.checkInput();
            this.calculate();
            this.adjust();
            this.position();
            this.animate();
            if (this.lockinput > 0) {
                this.lockinput = this.lockinput - 1;
            }
            if (this.jumptime > 0) {
                this.jumptime = this.jumptime - 1;
            }
            if (this.untouchable > 0) {
                this.untouchable = this.untouchable - 1;
                if (this.untouchable == 0) {
                    this.actor.gotoAndStop(1);
                }
            }
            this.sox = this.sox + (this.vx / 2);
            $r2 = 50;
            if (this.sox > $r2) {
                this.sox = $r2;
            } else {
                if (this.sox < (0 - $r2)) {
                    this.sox = 0 - $r2;
                }
            }
            this.soy = this.soy + (this.vy / 10);
            if (this.soy > $r2) {
                this.soy = $r2;
            } else {
                if (this.soy < (0 - $r2)) {
                    this.soy = 0 - $r2;
                }
            }
            this.scroll.x = this.lx - (240 - this.sox);
            this.scroll.y = this.ly - (this.sh - this.soy);
            this.actor._x = this.lx;
            this.actor._y = this.ly;
            if (this.actor._y > 3000) {
                this.event_die();
            }
        };
    $r2.checkInput = function () {
            this.l_action_down = this.action_down;
            this.action_up = false;
            this.action_left = false;
            this.action_right = false;
            this.action_down = false;
            this.action_fire = false;
            if (this.lockinput) {
                return;
            }
            if (Key.isDown(37)) {
                this.action_left = true;
            } else {
                if (Key.isDown(39)) {
                    this.action_right = true;
                }
            }
            if (Key.isDown(38) || Key.isDown(32)) {
                this.action_up = true;
            } else {
                if (Key.isDown(40)) {
                    this.action_down = true;
                }
            }
        };
    $r2.event_hitEnemy = function (obstacle, hit, hitenemy) {
            $r3 = obstacle.type;
            $r4 = obstacle._parent;
            $r7 = false;
            if ($r3 == 36) {
                if ((this.untouchable == 0) && ((this.move == 3) || (this.move == 4))) {
                    this.vy = this.vy - (this.JUMP_FORCE / 2);
                    this.event_hit();
                }
                return;
            }
            if ((hit && !($r3 == 31)) || ((this.slides > 0) && !($r3 == 31))) {
                $r5 = $r4.actor.event_hit();
                if (!hitenemy) {
                    if (!!!(this.move == this.M_SLIDE)) {
                        if (!this.action_up) {
                            this.vy = this.vy - (this.JUMP_FORCE / 2);
                        } else {
                            this.jumps = 1;
                            this.jumpstage = 0;
                            this.jumpcnt = 0;
                        }
                        this.r_action_up = false;
                    }
                    this.s_hitEnemy.start();
                }
                if ($r3 == 30) {
                    _global.attackPinku = this.box;
                } else {
                    if ($r3 == 33) {
                        $r4.gotoAndPlay("hit");
                        this.vy = this.vy - (this.JUMP_FORCE / 6);
                    } else {
                        if ($r3 == 34) {
                            $r4.gotoAndPlay("hit");
                        } else {
                            if ($r3 == 35) {
                                this.vy = this.vy - (this.JUMP_FORCE + 5);
                            }
                        }
                    }
                }
            } else {
                if (this.untouchable == 0) {
                    this.event_hit();
                }
            }
        };
    $r2.event_hitEffect = function (Void) {
            this.energy_mc["energy_" + this.energy.toString()].gotoAndPlay("lost");
            this.lockmove = 20;
            this.lockinput = 20;
            this.untouchable = this.UNTOUCHABLE_HIT;
            this.actor.gotoAndPlay(2);
            this.actor.container.gotoAndStop(this.M_HURT);
            this.s_hurt.start();
        };
    $r2.event_dieEffect = function (Void) {
            $r2 = 1;
            while ($r2 < this.energy) {
                this.energy_mc["energy_" + $r2.toString()].gotoAndPlay("lost");
                $r2 = $r2 + 1;
            }
            this.s_hurt.start(0, 2);
            this.s_music.stop();
            this.s_steps.stop();
            this.s_gameover.onSoundComplete = this.globalreset;
            this.s_gameover.start();
        };
    $r2.event_pickup = function (obstacle) {
            $r7 = obstacle.type;
            $r4 = obstacle._parent;
            $r0 = $r7;
            if (!($r0 === this.I_ENERGY)) {
                if (!($r0 === this.I_CONTAINER)) {
                    if (!($r0 === this.I_CRYSTAL)) {
                        if (!($r0 === this.I_GOAL)) {
                            if (!($r0 === this.I_ELPIX)) {
                                if (!($r0 === this.I_EVENT)) {
                                    goto L0000;
                                    if (this.energy < this.energymax) {
                                        this.energy = this.energy + 1;
                                        this.energy_mc["energy_" + (this.energy - 1)].gotoAndPlay("fill");
                                    }
                                    this.s_energy.start();
                                    $r4.gotoAndPlay("kill");
                                    goto L0000;
                                    this.foundContainer = true;
                                    this.energymax = this.energymax + 1;
                                    this.energy = this.energymax;
                                    $r3 = 0;
                                    while ($r3 < this.energymax) {
                                        this.energy_mc["energy_" + $r3].gotoAndPlay("fill");
                                        $r3 = $r3 + 1;
                                    }
                                    this.s_energy_container.start();
                                    $r4.gotoAndPlay("kill");
                                    goto L0000;
                                    if (this.crystals < this.CRYSTAL_MAX) {
                                        this.crystals = this.crystals + 1;
                                        $r5 = this.crystals.toString();
                                        if ($r5.length == 1) {
                                            $r5 = "0" + $r5;
                                        }
                                        this.crystals_mc.crystals_txt.text = ($r5 + "/") + this.CRYSTAL_MAX;
                                        if (this.crystals == this.CRYSTAL_MAX) {
                                            _global.is576();
                                            if (_global.complete576) {
                                                this.s_576.start();
                                            } else {
                                                this.s_energy_container.start();
                                            }
                                            this.crystals_mc.gotoAndPlay("full");
                                        } else {
                                            this.crystals_mc.play();
                                            this.s_crystal.stop();
                                            this.s_crystal.start();
                                        }
                                    }
                                    $r4.gotoAndPlay("kill");
                                    goto L0000;
                                    this.s_finish.onSoundComplete = this.globalfinish;
                                    this.s_finish.start();
                                    _global.gameOver.goal = true;
                                    if (this.crystals == 24) {
                                        _global.gameOver.bonus = true;
                                    }
                                    _global.gameOver.container = this.foundContainer;
                                    this.stopMusic();
                                    if (!$r4.off) {
                                        $r4.container.play();
                                        $r4.gotoAndPlay("kill");
                                    } else {
                                        $r4.gotoAndStop("out");
                                    }
                                    this.animate = null;
                                    this.actor.container.gotoAndStop(12);
                                    this.lockinput = 200;
                                    goto L0000;
                                    this.s_finish_elpix.onSoundComplete = this.globalfinish;
                                    this.s_finish_elpix.start();
                                    _global.gameOver.goal = true;
                                    if (this.crystals == 24) {
                                        _global.gameOver.bonus = true;
                                    }
                                    _global.gameOver.container = this.foundContainer;
                                    this.stopMusic();
                                    this.animate = null;
                                    this.actor.container.gotoAndStop(13);
                                    obstacle.type = -1;
                                    obstacle._visible = false;
                                    this.lockinput = 200;
                                } else {
                                    $r4.event();
                                    goto L0000;
                                }
                            } else {
                                this.s_finish_elpix.onSoundComplete = this.globalfinish;
                                this.s_finish_elpix.start();
                                _global.gameOver.goal = true;
                                if (this.crystals == 24) {
                                    _global.gameOver.bonus = true;
                                }
                                _global.gameOver.container = this.foundContainer;
                                this.stopMusic();
                                this.animate = null;
                                this.actor.container.gotoAndStop(13);
                                obstacle.type = -1;
                                obstacle._visible = false;
                                this.lockinput = 200;
                                goto L0000;
                                $r4.event();
                                goto L0000;
                            }
                        } else {
                            this.s_finish.onSoundComplete = this.globalfinish;
                            this.s_finish.start();
                            _global.gameOver.goal = true;
                            if (this.crystals == 24) {
                                _global.gameOver.bonus = true;
                            }
                            _global.gameOver.container = this.foundContainer;
                            this.stopMusic();
                            if (!$r4.off) {
                                $r4.container.play();
                                $r4.gotoAndPlay("kill");
                            } else {
                                $r4.gotoAndStop("out");
                            }
                            this.animate = null;
                            this.actor.container.gotoAndStop(12);
                            this.lockinput = 200;
                            goto L0000;
                            this.s_finish_elpix.onSoundComplete = this.globalfinish;
                            this.s_finish_elpix.start();
                            _global.gameOver.goal = true;
                            if (this.crystals == 24) {
                                _global.gameOver.bonus = true;
                            }
                            _global.gameOver.container = this.foundContainer;
                            this.stopMusic();
                            this.animate = null;
                            this.actor.container.gotoAndStop(13);
                            obstacle.type = -1;
                            obstacle._visible = false;
                            this.lockinput = 200;
                            goto L0000;
                            $r4.event();
                            goto L0000;
                        }
                    } else {
                        if (this.crystals < this.CRYSTAL_MAX) {
                            this.crystals = this.crystals + 1;
                            $r5 = this.crystals.toString();
                            if ($r5.length == 1) {
                                $r5 = "0" + $r5;
                            }
                            this.crystals_mc.crystals_txt.text = ($r5 + "/") + this.CRYSTAL_MAX;
                            if (this.crystals == this.CRYSTAL_MAX) {
                                _global.is576();
                                if (_global.complete576) {
                                    this.s_576.start();
                                } else {
                                    this.s_energy_container.start();
                                }
                                this.crystals_mc.gotoAndPlay("full");
                            } else {
                                this.crystals_mc.play();
                                this.s_crystal.stop();
                                this.s_crystal.start();
                            }
                        }
                        $r4.gotoAndPlay("kill");
                        goto L0000;
                        this.s_finish.onSoundComplete = this.globalfinish;
                        this.s_finish.start();
                        _global.gameOver.goal = true;
                        if (this.crystals == 24) {
                            _global.gameOver.bonus = true;
                        }
                        _global.gameOver.container = this.foundContainer;
                        this.stopMusic();
                        if (!$r4.off) {
                            $r4.container.play();
                            $r4.gotoAndPlay("kill");
                        } else {
                            $r4.gotoAndStop("out");
                        }
                        this.animate = null;
                        this.actor.container.gotoAndStop(12);
                        this.lockinput = 200;
                        goto L0000;
                        this.s_finish_elpix.onSoundComplete = this.globalfinish;
                        this.s_finish_elpix.start();
                        _global.gameOver.goal = true;
                        if (this.crystals == 24) {
                            _global.gameOver.bonus = true;
                        }
                        _global.gameOver.container = this.foundContainer;
                        this.stopMusic();
                        this.animate = null;
                        this.actor.container.gotoAndStop(13);
                        obstacle.type = -1;
                        obstacle._visible = false;
                        this.lockinput = 200;
                        goto L0000;
                        $r4.event();
                        goto L0000;
                    }
                } else {
                    this.foundContainer = true;
                    this.energymax = this.energymax + 1;
                    this.energy = this.energymax;
                    $r3 = 0;
                    while ($r3 < this.energymax) {
                        this.energy_mc["energy_" + $r3].gotoAndPlay("fill");
                        $r3 = $r3 + 1;
                    }
                    this.s_energy_container.start();
                    $r4.gotoAndPlay("kill");
                    goto L0000;
                    if (this.crystals < this.CRYSTAL_MAX) {
                        this.crystals = this.crystals + 1;
                        $r5 = this.crystals.toString();
                        if ($r5.length == 1) {
                            $r5 = "0" + $r5;
                        }
                        this.crystals_mc.crystals_txt.text = ($r5 + "/") + this.CRYSTAL_MAX;
                        if (this.crystals == this.CRYSTAL_MAX) {
                            _global.is576();
                            if (_global.complete576) {
                                this.s_576.start();
                            } else {
                                this.s_energy_container.start();
                            }
                            this.crystals_mc.gotoAndPlay("full");
                        } else {
                            this.crystals_mc.play();
                            this.s_crystal.stop();
                            this.s_crystal.start();
                        }
                    }
                    $r4.gotoAndPlay("kill");
                    goto L0000;
                    this.s_finish.onSoundComplete = this.globalfinish;
                    this.s_finish.start();
                    _global.gameOver.goal = true;
                    if (this.crystals == 24) {
                        _global.gameOver.bonus = true;
                    }
                    _global.gameOver.container = this.foundContainer;
                    this.stopMusic();
                    if (!$r4.off) {
                        $r4.container.play();
                        $r4.gotoAndPlay("kill");
                    } else {
                        $r4.gotoAndStop("out");
                    }
                    this.animate = null;
                    this.actor.container.gotoAndStop(12);
                    this.lockinput = 200;
                    goto L0000;
                    this.s_finish_elpix.onSoundComplete = this.globalfinish;
                    this.s_finish_elpix.start();
                    _global.gameOver.goal = true;
                    if (this.crystals == 24) {
                        _global.gameOver.bonus = true;
                    }
                    _global.gameOver.container = this.foundContainer;
                    this.stopMusic();
                    this.animate = null;
                    this.actor.container.gotoAndStop(13);
                    obstacle.type = -1;
                    obstacle._visible = false;
                    this.lockinput = 200;
                    goto L0000;
                    $r4.event();
                    goto L0000;
                }
            } else {
                if (this.energy < this.energymax) {
                    this.energy = this.energy + 1;
                    this.energy_mc["energy_" + (this.energy - 1)].gotoAndPlay("fill");
                }
                this.s_energy.start();
                $r4.gotoAndPlay("kill");
                goto L0000;
                this.foundContainer = true;
                this.energymax = this.energymax + 1;
                this.energy = this.energymax;
                $r3 = 0;
                while ($r3 < this.energymax) {
                    this.energy_mc["energy_" + $r3].gotoAndPlay("fill");
                    $r3 = $r3 + 1;
                }
                this.s_energy_container.start();
                $r4.gotoAndPlay("kill");
                goto L0000;
                if (this.crystals < this.CRYSTAL_MAX) {
                    this.crystals = this.crystals + 1;
                    $r5 = this.crystals.toString();
                    if ($r5.length == 1) {
                        $r5 = "0" + $r5;
                    }
                    this.crystals_mc.crystals_txt.text = ($r5 + "/") + this.CRYSTAL_MAX;
                    if (this.crystals == this.CRYSTAL_MAX) {
                        _global.is576();
                        if (_global.complete576) {
                            this.s_576.start();
                        } else {
                            this.s_energy_container.start();
                        }
                        this.crystals_mc.gotoAndPlay("full");
                    } else {
                        this.crystals_mc.play();
                        this.s_crystal.stop();
                        this.s_crystal.start();
                    }
                }
                $r4.gotoAndPlay("kill");
                goto L0000;
                this.s_finish.onSoundComplete = this.globalfinish;
                this.s_finish.start();
                _global.gameOver.goal = true;
                if (this.crystals == 24) {
                    _global.gameOver.bonus = true;
                }
                _global.gameOver.container = this.foundContainer;
                this.stopMusic();
                if (!$r4.off) {
                    $r4.container.play();
                    $r4.gotoAndPlay("kill");
                } else {
                    $r4.gotoAndStop("out");
                }
                this.animate = null;
                this.actor.container.gotoAndStop(12);
                this.lockinput = 200;
                goto L0000;
                this.s_finish_elpix.onSoundComplete = this.globalfinish;
                this.s_finish_elpix.start();
                _global.gameOver.goal = true;
                if (this.crystals == 24) {
                    _global.gameOver.bonus = true;
                }
                _global.gameOver.container = this.foundContainer;
                this.stopMusic();
                this.animate = null;
                this.actor.container.gotoAndStop(13);
                obstacle.type = -1;
                obstacle._visible = false;
                this.lockinput = 200;
                goto L0000;
                $r4.event();
                goto L0000;
            }
        };
    $r2.CRYSTAL_MAX = 24;
    $r2.UNTOUCHABLE_HIT = 70;
    $r2.I_ENERGY = 80;
    $r2.I_CRYSTAL = 81;
    $r2.I_CONTAINER = 82;
    $r2.I_EVENT = 90;
    $r2.I_GOAL = 89;
    $r2.I_ELPIX = 88;
}
ASSetPropFlags(actors.Hero.prototype, null, 1);
// ======== DoInitAction sprite=37 __Packages.com.extratoxic.utils.LoadStack
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
// ======== DoInitAction sprite=38 __Packages.com.extratoxic.utils.Loader
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
// ======== DoInitAction sprite=39 __Packages.com.extratoxic.utils.Rectangle
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
if (!_global.com.extratoxic.utils.Rectangle) {
    $r1 = function (parent, depth, x, y, width, height, fill) {
            this.parent = parent;
            this.depth = depth;
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
            this.fill = fill;
            this.draw();
        };
    com.extratoxic.utils.Rectangle = $r1;
    $r2 = $r1.prototype;
    $r2.draw = function (Void) {
            this.movie = this.parent.createEmptyMovieClip("rect_" + this.depth, this.depth);
            this.movie._x = this.x;
            this.movie._y = this.y;
            this.movie.lineStyle(1, 16777215, 100);
            if (!!!(this.fill == undefined)) {
                this.movie.beginFill(this.fill, 100);
            }
            this.movie.moveTo(this.x, this.y);
            this.movie.lineTo(this.width, this.y);
            this.movie.lineTo(this.width, this.height);
            this.movie.lineTo(this.x, this.height);
            this.movie.lineTo(this.x, this.y);
            if (!!!(this.fill == undefined)) {
                this.movie.endFill();
            }
        };
    $r2.remove = function (Void) {
            this.movie.removeMovieClip();
        };
    $r2.getMovie = function (Void) {
            return this.movie;
        };
}
ASSetPropFlags(com.extratoxic.utils.Rectangle.prototype, null, 1);
// ======== DoInitAction sprite=40 __Packages.com.extratoxic.utils.XMLUtil
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
// ======== DoInitAction sprite=41 __Packages.utils.VideoUtil
if (!_global.utils) {
    _global.utils = new Object();
}
<stack?>;
if (!_global.utils.VideoUtil) {
    $r1 = function () {
        };
    utils.VideoUtil = $r1;
    $r2 = $r1.prototype;
    $r1.setOutput = function (txt) {
            utils.VideoUtil.output = txt;
        };
    $r1.initialize = function (container, url) {
            utils.VideoUtil.output.text = utils.VideoUtil.output.text + "initialize Video \n";
            utils.VideoUtil.output.text = utils.VideoUtil.output.text + (("	 url: " + url) + "\n");
            utils.VideoUtil.netconnect = new NetConnection();
            utils.VideoUtil.netconnect.connect(null);
            utils.VideoUtil.netstream = new NetStream(utils.VideoUtil.netconnect);
            utils.VideoUtil.netstream.onStatus = function (infoObject) {
                    };
            utils.VideoUtil.netstream.setBufferTime(5);
            container.videoscreen.attachVideo(utils.VideoUtil.netstream);
            utils.VideoUtil.netstream.onMetaData = function (infoObject) {
                        utils.VideoUtil.output.text = utils.VideoUtil.output.text + "MetaData -------------------------------\n";
                        while (true) {
                            $r0 = /*enumerate*/ infoObject;
                            if ($r0 == null) break;
                            $r2 = $r0;
                            utils.VideoUtil.output.text = utils.VideoUtil.output.text + ((($r2 + " = ") + infoObject[$r2]) + "\n");
                        }
                        utils.VideoUtil.output.text = utils.VideoUtil.output.text + "----------------------------------------\n";
                        utils.VideoUtil.output.text = utils.VideoUtil.output.text + ((">>" + infoObject.width) + "\n");
                        utils.VideoUtil.output.text = utils.VideoUtil.output.text + ((">>" + infoObject.height) + "\n");
                    };
            utils.VideoUtil.netstream.play(url);
        };
}
ASSetPropFlags(utils.VideoUtil.prototype, null, 1);
// ---- DoAction
stop();
config = "data/game.xml";
if (_level0.level == undefined) {
    _level0.level = "level_1";
}
game = new Game(this, config, _level0.level);
