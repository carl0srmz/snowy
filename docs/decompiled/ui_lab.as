// sprite id=3  frames=1
// sprite id=5 VideoPlayer frames=1
// sprite id=8 Icon frames=1
// sprite id=9 FLVPlayback frames=2
  // frame 1 DoAction
    stop();
// ---- DoAction
button.useHandCursor = false;
// sprite id=28  frames=1
// sprite id=30  frames=1
// sprite id=32  frames=115
  // frame 1 DoAction
    stop();
  // frame 2 label open
  // frame 17 DoAction
    stop();
  // frame 39 label close
  // frame 56 DoAction
    stop();
// sprite id=35  frames=1
// sprite id=36  frames=28
// sprite id=47  frames=12
// sprite id=51  frames=1
// sprite id=54  frames=1
// sprite id=57  frames=1
// sprite id=58  frames=8
// sprite id=59  frames=13
  // frame 1 label normal
  // frame 1 DoAction
    stop();
  // frame 8 label speak
  // frame 8 DoAction
    stop();
// sprite id=60  frames=287
  // frame 1 DoAction
    blase._visible = false;
    stop();
    exit_button.onRollOver = null;
    exit_button.onRollOut = null;
  // frame 2 label open
  // frame 2 DoAction
    door.gotoAndPlay("open");
    exit_button.onRollOver = null;
    exit_button.onRollOut = null;
  // frame 31 DoAction
    door.gotoAndPlay("close");
    exit_button.onRollOver = function () {
            door.gotoAndPlay("open");
        };
    exit_button.onRollOut = function () {
            door.gotoAndPlay("close");
        };
  // frame 58 DoAction
    billy.gotoAndStop(1);
  // frame 83 DoAction
    schwabbel.gotoAndStop("speak");
    blase._visible = true;
    ticker.start();
  // frame 244 DoAction
    schwabbel.gotoAndStop("normal");
    stop();
// sprite id=62  frames=1
// sprite id=65  frames=1
// sprite id=68  frames=1
// sprite id=69  frames=8
// sprite id=70  frames=99
  // frame 1 label normal
  // frame 1 DoAction
    stop();
  // frame 9 label speak
// sprite id=71  frames=25
  // frame 1 DoAction
    pfeil2._visible = false;
  // frame 5 DoAction
    pfeil1._visible = false;
  // frame 7 DoAction
    stop();
// sprite id=76  frames=2
  // frame 1 DoAction
    stop();
// sprite id=78  frames=42
  // frame 1 label on
  // frame 1 DoAction
    stop();
    button._visible = true;
  // frame 10 label over
  // frame 10 DoAction
    button._visible = true;
    _parent.wallpapers.stop();
    _parent.handy.stop();
  // frame 37 DoAction
    init = true;
    _parent.stopTicker();
    _parent.text_txt.htmlText = "";
    _parent.gotoAndStop("blase");
    if ((_parent.wallpapers == undefined) || _parent.wallpapers.active) {
        _parent.wallpapers.gotoAndStop("empty");
    }
    _parent.wallpapers.init = undefined;
    _parent.handy.init = undefined;
    ticker_icons.start();
    stop();
  // frame 38 DoAction
    stop();
  // frame 39 label off
  // frame 39 DoAction
    button._visible = false;
// sprite id=85  frames=2
  // frame 1 DoAction
    stop();
// sprite id=88  frames=42
  // frame 1 label on
  // frame 1 DoAction
    stop();
    button._visible = true;
  // frame 10 label over
  // frame 10 DoAction
    button._visible = true;
  // frame 37 DoAction
    init = true;
    _parent.stopTicker();
    _parent.text_txt.htmlText = "";
    _parent.gotoAndStop("blase");
    if ((_parent.wallpapers == undefined) || _parent.wallpapers.active) {
        _parent.wallpapers.gotoAndStop("empty");
    }
    _parent.wallpapers.init = undefined;
    _parent.handy.init = undefined;
    ticker_icons.start();
    stop();
  // frame 38 DoAction
    stop();
  // frame 39 label off
  // frame 39 DoAction
    button._visible = false;
// sprite id=93  frames=2
  // frame 1 DoAction
    stop();
// sprite id=95  frames=38
  // frame 1 label on
  // frame 1 DoAction
    stop();
    button._visible = true;
  // frame 10 label over
  // frame 10 DoAction
    button._visible = true;
    _parent.wallpapers.stop();
    _parent.icons.stop();
  // frame 32 DoAction
    init = true;
    _parent.stopTicker();
    _parent.text_txt.htmlText = "";
    _parent.gotoAndStop("blase");
    if ((_parent.wallpapers == undefined) || _parent.wallpapers.active) {
        _parent.wallpapers.gotoAndStop("empty");
    }
    _parent.wallpapers.init = undefined;
    _parent.icons.init = undefined;
    stop();
    ticker_handy.start();
  // frame 33 DoAction
    stop();
    ticker_handy.start();
  // frame 35 label off
  // frame 35 DoAction
    button._visible = false;
// sprite id=100  frames=2
  // frame 1 DoAction
    stop();
// sprite id=105  frames=122
  // frame 1 label empty
  // frame 1 DoAction
    stop();
    wp_1._visible = false;
    wp_2._visible = false;
    wp_3._visible = false;
    pfeile.pfeil1._visible = false;
    pfeile.pfeil2._visible = false;
  // frame 2 DoAction
    stop();
    wp_1._visible = false;
    wp_2._visible = false;
    wp_3._visible = false;
  // frame 8 label over
  // frame 8 DoAction
    _parent.handy.stop();
    _parent.icons.stop();
    active = false;
  // frame 38 DoAction
    _parent.gotoAndStop("blase");
    _parent.stopTicker();
    _parent.text_txt.htmlText = "";
    _parent.danketyp.gotoAndPlay("speak");
    _parent.handy.init = undefined;
    _parent.icons.init = undefined;
    init = true;
    stop();
    ticker_wp1.start();
  // frame 39 DoAction
    stop();
    ticker_wp1.start();
  // frame 41 label active
  // frame 41 DoAction
    _parent.stopTicker();
    _parent.text_txt.htmlText = "";
    _parent.gotoAndStop("blase");
    active = true;
  // frame 49 DoAction
    _parent.danketyp.gotoAndPlay("speak");
    _parent.text_txt.htmlText = "";
    ticker_wp2.start();
  // frame 105 DoAction
    wp_1._visible = true;
    wp_2._visible = true;
    wp_3._visible = true;
  // frame 119 DoAction
    stop();
// sprite id=112  frames=1
// sprite id=113  frames=1
// sprite id=114  frames=227
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 28 name Some("download_576")
    this._visible = false;
  // frame 2 label start
  // frame 2 DoAction
  // frame 64 label blase
  // frame 71 DoAction
    danketyp.gotoAndPlay("speak");
    ticker_hello.start();
    stop();
  // frame 90 label normal
  // frame 90 DoAction
    pfeile_wallpaper.pfeil1._visible = false;
    pfeile_wallpaper.pfeil2._visible = false;
    pfeile_handy.pfeil1._visible = false;
    pfeile_handy.pfeil2._visible = false;
    pfeile_icons.pfeil1._visible = false;
    pfeile_icons.pfeil2._visible = false;
  // frame 95 DoAction
    danketyp.gotoAndPlay("speak");
    stop();
  // frame 100 label wallpaper_rover
  // frame 100 DoAction
    pfeile_wallpaper.pfeil1._visible = true;
    pfeile_wallpaper.pfeil2._visible = true;
    pfeile_icons.pfeil1._visible = false;
    pfeile_icons.pfeil2._visible = false;
    pfeile_handy.pfeil1._visible = false;
    pfeile_handy.pfeil2._visible = false;
    wallpaper_txt.htmlText = wallpaper_text;
  // frame 105 DoAction
    danketyp.gotoAndPlay("speak");
    stop();
  // frame 120 label wallpaper_dl
  // frame 125 DoAction
    danketyp.gotoAndPlay("speak");
    stop();
    wallpaper_txt.htmlText = wallpaper_select_text;
  // frame 150 label handy_rover
  // frame 150 DoAction
    pfeile_handy.pfeil1._visible = true;
    pfeile_handy.pfeil2._visible = true;
    pfeile_wallpaper.pfeil1._visible = false;
    pfeile_wallpaper.pfeil2._visible = false;
    pfeile_icons.pfeil1._visible = false;
    pfeile_icons.pfeil2._visible = false;
  // frame 155 DoAction
    danketyp.gotoAndPlay("speak");
    stop();
  // frame 170 label icons_rover
  // frame 170 DoAction
    pfeile_icons.pfeil1._visible = true;
    pfeile_icons.pfeil2._visible = true;
    pfeile_handy.pfeil1._visible = false;
    pfeile_handy.pfeil2._visible = false;
    pfeile_wallpaper.pfeil1._visible = false;
    pfeile_wallpaper.pfeil2._visible = false;
  // frame 175 DoAction
    danketyp.gotoAndPlay("speak");
    stop();
// sprite id=118  frames=1
// sprite id=121  frames=1
// sprite id=124  frames=1
// sprite id=125  frames=271
// sprite id=128  frames=1
// sprite id=131  frames=2
// sprite id=134  frames=31
  // frame 1 label off
  // frame 1 DoAction
    movie.pfeile.pfeil1._visible = false;
    movie.pfeile.pfeil2._visible = false;
    stop();
  // frame 15 label on
  // frame 15 DoAction
    movie.pfeile.pfeil1._visible = true;
    movie.pfeile.pfeil2._visible = true;
    stop();
// sprite id=138  frames=1
// sprite id=141  frames=1
// sprite id=143  frames=1
// sprite id=145  frames=18
  // frame 18 DoAction
    stop();
// sprite id=146  frames=305
// sprite id=149  frames=1
// sprite id=150  frames=173
// sprite id=153  frames=31
  // frame 1 label off
  // frame 1 DoAction
    movie.pfeile.pfeil1._visible = false;
    movie.pfeile.pfeil2._visible = false;
    stop();
  // frame 15 label on
  // frame 15 DoAction
    movie.pfeile.pfeil1._visible = true;
    movie.pfeile.pfeil2._visible = true;
    stop();
// sprite id=157  frames=1
// sprite id=160  frames=1
// sprite id=163  frames=1
// sprite id=164  frames=244
// sprite id=167  frames=31
  // frame 1 label off
  // frame 1 DoAction
    movie.pfeile.pfeil1._visible = false;
    movie.pfeile.pfeil2._visible = false;
    stop();
  // frame 15 label on
  // frame 15 DoAction
    movie.pfeile.pfeil1._visible = true;
    movie.pfeile.pfeil2._visible = true;
    stop();
// sprite id=170  frames=1
// sprite id=173  frames=1
// sprite id=176  frames=1
// sprite id=177  frames=160
// sprite id=180  frames=1
// sprite id=181  frames=6
// sprite id=184  frames=1
// sprite id=185  frames=8
// sprite id=186  frames=428
// sprite id=189  frames=1
// sprite id=192  frames=1
// sprite id=194  frames=1
// sprite id=195  frames=19
  // frame 1 label normal
  // frame 1 DoAction
    stop();
  // frame 9 label rover
  // frame 9 DoAction
    stop();
// sprite id=200  frames=1
// sprite id=203  frames=1
// sprite id=204  frames=15
  // frame 1 label ds
  // frame 1 DoAction
    stop();
  // frame 7 label wii
  // frame 7 DoAction
    stop();
// sprite id=205  frames=29
  // frame 1 label normal
  // frame 1 DoAction
    stop();
  // frame 9 label rover
  // frame 9 DoAction
    stop();
  // frame 16 label on
  // frame 16 DoAction
    stop();
// sprite id=207  frames=36
  // frame 1 DoAction
    stop();
    active = false;
    button._visible = true;
  // frame 15 label on
  // frame 15 DoAction
    titel.gotoAndStop("on");
    active = true;
    button._visible = false;
  // frame 23 DoAction
    stop();
  // frame 28 label off
  // frame 28 DoAction
    active = false;
    titel.gotoAndStop("normal");
// sprite id=208  frames=1
// sprite id=210  frames=19
  // frame 1 label normal
  // frame 1 DoAction
    stop();
  // frame 9 label rover
  // frame 9 DoAction
    stop();
// sprite id=211  frames=1
// sprite id=213  frames=1
// sprite id=215  frames=1
// sprite id=219  frames=1
// sprite id=221  frames=1
// sprite id=223  frames=1
// sprite id=225  frames=1
// sprite id=228  frames=54
  // frame 1 DoAction
    stop();
  // frame 18 label rout
  // frame 18 DoAction
    stop();
  // frame 27 label rover
  // frame 27 DoAction
    stop();
  // frame 36 label press
  // frame 46 label on
  // frame 46 DoAction
    stop();
// sprite id=230  frames=1
// sprite id=232  frames=1
// sprite id=234  frames=1
// sprite id=236  frames=1
  // frame 1 DoAction
    stop();
// sprite id=239  frames=1
// sprite id=243  frames=1
// sprite id=245  frames=1
// sprite id=249  frames=1
// sprite id=250  frames=99
  // frame 1 DoAction
    stop();
    gotoLabel("on_play");
  // frame 5 label on_pause
  // frame 5 DoAction
    stop();
    play_button._visible = true;
    pause_button._visible = false;
  // frame 18 label rout_play
  // frame 18 DoAction
    stop();
  // frame 27 label rover_play
  // frame 27 DoAction
    stop();
  // frame 36 label press_play
  // frame 46 label on_play
  // frame 46 DoAction
    stop();
    pause_button._visible = true;
    play_button._visible = false;
  // frame 55 label rout_pause
  // frame 55 DoAction
    stop();
  // frame 64 label rover_pause
  // frame 64 DoAction
    stop();
  // frame 76 label press_pause
  // frame 76 DoAction
    stop();
// sprite id=253  frames=1
// sprite id=254  frames=1
// sprite id=255  frames=1
// sprite id=257  frames=1
// sprite id=260  frames=1
// sprite id=261  frames=1
  // frame 1 DoAction
    button.useHandCursor = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name Some("screenshots")
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 57 name Some("info")
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 72 name Some("video")
    this._visible = false;
// sprite id=262  frames=100
  // frame 1 DoAction
    stop();
  // frame 15 label on
  // frame 39 DoAction
    stop();
  // frame 43 label off
  // frame 55 DoAction
    stop();
// sprite id=264  frames=1
// sprite id=265  frames=2
  // frame 1 DoAction
    stop();
// ======== DoInitAction sprite=1 __Packages.mx.video.FLVPlayback
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.FLVPlayback) {
    $r1 = function () {
            super();
            mx.events.EventDispatcher.initialize(this);
            if (this._autoPlay == undefined) {
                this._autoPlay = true;
            }
            if (this._autoRewind == undefined) {
                this._autoRewind = true;
            }
            if (this._autoSize == undefined) {
                this._autoSize = false;
            }
            if (this._bufferTime == undefined) {
                this._bufferTime = 0.1;
            }
            if (this._contentPath == undefined) {
                this._contentPath = "";
            }
            if (this._cuePoints == undefined) {
                this._cuePoints = null;
            }
            if (this._idleTimeout == undefined) {
                this._idleTimeout = mx.video.VideoPlayer.DEFAULT_IDLE_TIMEOUT_INTERVAL;
            }
            if (this._isLive == undefined) {
                this._isLive = false;
            }
            if (this._aspectRatio == undefined) {
                this._aspectRatio = true;
            }
            if (this._seekToPrevOffset == undefined) {
                this._seekToPrevOffset = mx.video.FLVPlayback.SEEK_TO_PREV_OFFSET_DEFAULT;
            }
            if (this._playheadUpdateInterval == undefined) {
                this._playheadUpdateInterval = mx.video.VideoPlayer.DEFAULT_UPDATE_PROGRESS_INTERVAL;
            }
            if (this._progressInterval == undefined) {
                this._progressInterval = mx.video.VideoPlayer.DEFAULT_UPDATE_TIME_INTERVAL;
            }
            if (this._totalTime == undefined) {
                this._totalTime = 0;
            }
            if (this._transform == undefined) {
                this._transform = null;
            }
            if (this._volume == undefined) {
                this._volume = 100;
            }
            if (this._skinAutoHide == undefined) {
                this._skinAutoHide = false;
            }
            if (this._bufferingBarHides == undefined) {
                this._bufferingBarHides = false;
            }
            $r0 = this._height;
            this.__height = $r0;
            this._prevHeight = $r0;
            this._origHeight = $r0;
            $r0 = this._width;
            this.__width = $r0;
            this._prevWidth = $r0;
            this._origWidth = $r0;
            this._scaleX = 100;
            this._scaleY = 100;
            this._xscale = 100;
            this._yscale = 100;
            this._preSeekTime = -1;
            this._firstStreamReady = false;
            this._firstStreamShown = false;
            this.createUIManager();
            this._activeVP = 0;
            this._visibleVP = 0;
            this._topVP = 0;
            this._vp = new Array();
            this._vpState = new Array();
            this._cpMgr = new Array();
            this.createVideoPlayer(0);
            this._vp[0].visible = false;
            this._vp[0].volume = 0;
            this.boundingBox_mc._visible = false;
            this.boundingBox_mc.unloadMovie();
            delete this.boundingBox_mc;
            if (_global.isLivePreview) {
                this.createLivePreviewMovieClip();
                this.setSize(this.__width, this.__height);
            }
            this._cpMgr[0].processCuePointsProperty(this._cuePoints);
            delete this._cuePoints;
            this._cuePoints = null;
        };
    mx.video.FLVPlayback = $r1;
    mx.video.FLVPlayback.extends(MovieClip);
    $r2 = $r1.prototype;
    $r2.setSize = function (w, h) {
            if (_global.isLivePreview) {
                if (this.preview_mc == undefined) {
                    this.createLivePreviewMovieClip();
                }
                this.preview_mc.box_mc._width = w;
                this.preview_mc.box_mc._height = h;
                if ((this.preview_mc.box_mc._width < this.preview_mc.icon_mc._width) || (this.preview_mc.box_mc._height < this.preview_mc.icon_mc._height)) {
                    this.preview_mc.icon_mc._visible = false;
                } else {
                    this.preview_mc.icon_mc._visible = true;
                    this.preview_mc.icon_mc._x = (this.preview_mc.box_mc._width - this.preview_mc.icon_mc._width) / 2;
                    this.preview_mc.icon_mc._y = (this.preview_mc.box_mc._height - this.preview_mc.icon_mc._height) / 2;
                }
            }
            if ((w == this.__get__width()) && (h == this.__get__height())) {
                return;
            }
            $r0 = w;
            this.__width = $r0;
            this._prevWidth = $r0;
            $r0 = h;
            this.__height = $r0;
            this._prevHeight = $r0;
            $r3 = 0;
            while ($r3 < this._vp.length) {
                if (!!!(this._vp[$r3] == undefined)) {
                    this._vp[$r3].setSize(w, h);
                }
                $r3 = $r3 + 1;
            }
            this.dispatchEvent({height: h, width: w, y: this.__get__y(), x: this.__get__x(), type: "resize"});
        };
    $r2.setScale = function (xs, ys) {
            if ((xs == this.__get__scaleX()) && (ys == this.__get__scaleY())) {
                return;
            }
            this._scaleX = xs;
            this._scaleY = ys;
            $r2 = 0;
            while ($r2 < this._vp.length) {
                if (!!!(this._vp[$r2] == undefined)) {
                    this._vp[$r2].setSize((this._origWidth * xs) / 100, (this._origHeight * ys) / 100);
                }
                $r2 = $r2 + 1;
            }
            this.dispatchEvent({height: this.__get__height(), width: this.__get__width(), y: this.__get__y(), x: this.__get__x(), type: "resize"});
        };
    $r2.handleEvent = function (e) {
            $r3 = e.state;
            if ((!(e.state == undefined) && (e.target._name == this._visibleVP)) && this.__get__scrubbing()) {
                $r3 = mx.video.FLVPlayback.SEEKING;
            }
            if (e.type == "metadataReceived") {
                this._cpMgr[e.target._name].processFLVCuePoints(e.info.cuePoints);
                this.dispatchEvent({vp: e.target._name, info: e.info, type: e.type});
            } else {
                if (e.type == "cuePoint") {
                    if (this._cpMgr[e.target._name].isFLVCuePointEnabled(e.info)) {
                        this.dispatchEvent({vp: e.target._name, info: e.info, type: e.type});
                    }
                } else {
                    if (e.type == "rewind") {
                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, auto: true, type: e.type});
                        this._cpMgr[e.target._name].resetASCuePointIndex(e.playheadTime);
                    } else {
                        if (e.type == "resize") {
                            this.dispatchEvent({vp: e.target._name, auto: true, height: this.__get__height(), width: this.__get__width(), y: this.__get__y(), x: this.__get__x(), type: e.type});
                            this._prevWidth = this.__width;
                            this._prevHeight = this.__height;
                        } else {
                            if (e.type == "playheadUpdate") {
                                this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: e.type});
                                if (!(this._preSeekTime < 0) && !(e.target.state == mx.video.FLVPlayback.SEEKING)) {
                                    $r5 = this._preSeekTime;
                                    this._preSeekTime = -1;
                                    this._cpMgr[e.target._name].resetASCuePointIndex(e.playheadTime);
                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "seek"});
                                    if ($r5 < e.playheadTime) {
                                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "fastForward"});
                                    } else {
                                        if ($r5 > e.playheadTime) {
                                            this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, auto: false, type: "rewind"});
                                        }
                                    }
                                }
                                this._cpMgr[e.target._name].dispatchASCuePoints();
                            } else {
                                if (e.type == "stateChange") {
                                    $r4 = e.target._name;
                                    if (($r4 == this._visibleVP) && this.__get__scrubbing()) {
                                        return;
                                    }
                                    if (e.state == mx.video.VideoPlayer.RESIZING) {
                                        return;
                                    }
                                    if (((this._vpState[$r4].prevState == mx.video.FLVPlayback.LOADING) && this._vpState[$r4].autoPlay) && (e.state == mx.video.FLVPlayback.STOPPED)) {
                                        return;
                                    }
                                    this._vpState[$r4].prevState = e.state;
                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: e.type});
                                    if (!!!(this._vp[e.target._name].state == $r3)) {
                                        return;
                                    }
                                    $r0 = $r3;
                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                                    goto L07aa;
                                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "buffering"});
                                                    goto L07aa;
                                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "paused"});
                                                    goto L07aa;
                                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "playing"});
                                                } else {
                                                    this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "stopped"});
                                                    goto L07aa;
                                                }
                                            } else {
                                                this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "playing"});
                                                goto L07aa;
                                                this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "stopped"});
                                                goto L07aa;
                                            }
                                        } else {
                                            this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "paused"});
                                            goto L07aa;
                                            this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "playing"});
                                            goto L07aa;
                                            this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "stopped"});
                                            goto L07aa;
                                        }
                                    } else {
                                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "buffering"});
                                        goto L07aa;
                                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "paused"});
                                        goto L07aa;
                                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "playing"});
                                        goto L07aa;
                                        this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: "stopped"});
                                        goto L07aa;
                                    }
                                } else {
                                    if (e.type == "progress") {
                                        this.dispatchEvent({vp: e.target._name, bytesTotal: e.bytesTotal, bytesLoaded: e.bytesLoaded, type: e.type});
                                    } else {
                                        if (e.type == "ready") {
                                            $r4 = e.target._name;
                                            if (!this._firstStreamReady) {
                                                if ($r4 == this._visibleVP) {
                                                    this._firstStreamReady = true;
                                                    if (this._uiMgr.__get__skinReady() && !this._firstStreamShown) {
                                                        this._uiMgr.__set__visible(true);
                                                        this.showFirstStream();
                                                    }
                                                }
                                            } else {
                                                if ((this._firstStreamShown && ($r3 == mx.video.FLVPlayback.STOPPED)) && this._vpState[$r4].autoPlay) {
                                                    this._vp[$r4].play();
                                                }
                                            }
                                            this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: e.type});
                                        } else {
                                            if ((e.type == "close") || (e.type == "complete")) {
                                                this.dispatchEvent({vp: e.target._name, playheadTime: e.playheadTime, state: $r3, type: e.type});
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
    $r2.load = function (contentPath, totalTime, isLive) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            if (((contentPath == undefined) || (contentPath == null)) || (contentPath == "")) {
                return;
            }
            this.__set__autoPlay(false);
            if (!!!(totalTime == undefined)) {
                this.__set__totalTime(totalTime);
            }
            if (!!!(isLive == undefined)) {
                this.__set__isLive(isLive);
            }
            this.__set__contentPath(contentPath);
        };
    $r2.play = function (contentPath, totalTime, isLive) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            if (contentPath == undefined) {
                this._vp[this._activeVP].play();
            } else {
                this.__set__autoPlay(true);
                if (!!!(totalTime == undefined)) {
                    this.__set__totalTime(totalTime);
                }
                if (!!!(isLive == undefined)) {
                    this.__set__isLive(isLive);
                }
                this.__set__contentPath(contentPath);
            }
        };
    $r2.pause = function () {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            this._vp[this._activeVP].pause();
        };
    $r2.stop = function () {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            this._vp[this._activeVP].stop();
        };
    $r2.seek = function (time) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            this._preSeekTime = this.playheadTime;
            this._vp[this._activeVP].seek(time);
        };
    $r2.seekSeconds = function (time) {
            this.seek(time);
        };
    $r2.seekPercent = function (percent) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            if (((((percent < 0) || (percent > 100)) || (this._vp[this._activeVP].totalTime == undefined)) || (this._vp[this._activeVP].totalTime == null)) || !(this._vp[this._activeVP].totalTime > 0)) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_SEEK);
            }
            this.seek((this._vp[this._activeVP].totalTime * percent) / 100);
        };
    $r2.__get__playheadPercentage = function () {
            if (((this._vp[this._activeVP].totalTime == undefined) || (this._vp[this._activeVP].totalTime == null)) || !(this._vp[this._activeVP].totalTime > 0)) {
                return;
            }
            return (this._vp[this._activeVP].playheadTime / this._vp[this._activeVP].totalTime) * 100;
        };
    $r2.__set__playheadPercentage = function (percent) {
            this.seekPercent(percent);
            return this.__get__playheadPercentage();
            <stack?>;
        };
    $r2.seekToNavCuePoint = function (timeNameOrCuePoint) {
            $r3 = undefined;
            $r0 = typeof timeNameOrCuePoint;
            if (!($r0 === "string")) {
                if (!($r0 === "number")) {
                    if (!($r0 === "object")) {
                        goto L007a;
                        $r3 = {name: timeNameOrCuePoint};
                        goto L007a;
                        $r3 = {time: timeNameOrCuePoint};
                    } else {
                        $r3 = timeNameOrCuePoint;
                        goto L007a;
                    }
                } else {
                    $r3 = {time: timeNameOrCuePoint};
                    goto L007a;
                    $r3 = timeNameOrCuePoint;
                    goto L007a;
                }
            } else {
                $r3 = {name: timeNameOrCuePoint};
                goto L007a;
                $r3 = {time: timeNameOrCuePoint};
                goto L007a;
                $r3 = timeNameOrCuePoint;
                goto L007a;
            }
            if ((($r3.name == null) || ($r3.name == undefined)) || !(typeof $r3.name == "string")) {
                this.seekToNextNavCuePoint($r3.time);
                return;
            }
            if (isNaN($r3.time)) {
                $r3.time = 0;
            }
            $r2 = this.findNearestCuePoint(timeNameOrCuePoint, mx.video.FLVPlayback.NAVIGATION);
            while (true) {
                if (!(!($r2 == null) && (($r2.time < $r3.time) || !this.isFLVCuePointEnabled($r2)))) break;
                $r2 = this.findNextCuePointWithName($r2);
            }
            if ($r2 == null) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_SEEK);
            }
            this.seek($r2.time);
        };
    $r2.seekToNextNavCuePoint = function (time) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            if (isNaN(time) || (time < 0)) {
                time = this._vp[this._activeVP].playheadTime + 0.001;
            }
            $r3 = undefined;
            $r3 = this.findNearestCuePoint(time, mx.video.FLVPlayback.NAVIGATION);
            if ($r3 == null) {
                this.seek(this._vp[this._activeVP].totalTime);
                return;
            }
            $r2 = $r3.index;
            if ($r3.time < time) {
                $r2 = $r2 + 1;
            }
            while (true) {
                if (!(($r2 < $r3.array.length) && !this.isFLVCuePointEnabled($r3.array[$r2]))) break;
                $r2 = $r2 + 1;
            }
            if (!!!($r2 < $r3.array.length)) {
                $r5 = this._vp[this._activeVP].totalTime;
                if ($r3.array[$r3.array.length - 1].time > $r5) {
                    $r5 = $r3.array[$r3.array.length - 1];
                }
                this.seek($r5);
            } else {
                this.seek($r3.array[$r2].time);
            }
        };
    $r2.seekToPrevNavCuePoint = function (time) {
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            if (isNaN(time) || (time < 0)) {
                time = this._vp[this._activeVP].playheadTime;
            }
            $r3 = this.findNearestCuePoint(time, mx.video.FLVPlayback.NAVIGATION);
            if ($r3 == null) {
                this.seek(0);
                return;
            }
            $r2 = $r3.index;
            while (true) {
                if (!(!($r2 < 0) && (!this.isFLVCuePointEnabled($r3.array[$r2]) || !($r3.array[$r2].time < (time - this._seekToPrevOffset))))) break;
                $r2 = $r2 - 1;
            }
            if ($r2 < 0) {
                this.seek(0);
            } else {
                this.seek($r3.array[$r2].time);
            }
        };
    $r2.addASCuePoint = function (timeOrCuePoint, name, parameters) {
            return this._cpMgr[this._activeVP].addASCuePoint(timeOrCuePoint, name, parameters);
        };
    $r2.removeASCuePoint = function (timeNameOrCuePoint) {
            return this._cpMgr[this._activeVP].removeASCuePoint(timeNameOrCuePoint);
        };
    $r2.findCuePoint = function (timeNameOrCuePoint, type) {
            $r0 = type;
            if (!($r0 === "event")) {
                if (!($r0 === "navigation")) {
                    if (!($r0 === "flv")) {
                        if (!($r0 === "actionscript")) {
                            if (!($r0 === "all")) {
                                goto L012d;
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].eventCuePoints, false, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].navCuePoints, false, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].flvCuePoints, false, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].asCuePoints, false, timeNameOrCuePoint);
                            }
                        }
                    }
                }
            } else {
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].eventCuePoints, false, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].navCuePoints, false, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].flvCuePoints, false, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].asCuePoints, false, timeNameOrCuePoint);
            }
            return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].allCuePoints, false, timeNameOrCuePoint);
        };
    $r2.findNearestCuePoint = function (timeNameOrCuePoint, type) {
            $r0 = type;
            if (!($r0 === "event")) {
                if (!($r0 === "navigation")) {
                    if (!($r0 === "flv")) {
                        if (!($r0 === "actionscript")) {
                            if (!($r0 === "all")) {
                                goto L012d;
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].eventCuePoints, true, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].navCuePoints, true, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].flvCuePoints, true, timeNameOrCuePoint);
                                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].asCuePoints, true, timeNameOrCuePoint);
                            }
                        }
                    }
                }
            } else {
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].eventCuePoints, true, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].navCuePoints, true, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].flvCuePoints, true, timeNameOrCuePoint);
                return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].asCuePoints, true, timeNameOrCuePoint);
            }
            return this._cpMgr[this._activeVP].getCuePoint(this._cpMgr[this._activeVP].allCuePoints, true, timeNameOrCuePoint);
        };
    $r2.findNextCuePointWithName = function (cuePoint) {
            return this._cpMgr[this._activeVP].getNextCuePointWithName(cuePoint);
        };
    $r2.setFLVCuePointEnabled = function (enabled, timeNameOrCuePoint) {
            return this._cpMgr[this._activeVP].setFLVCuePointEnabled(enabled, timeNameOrCuePoint);
        };
    $r2.isFLVCuePointEnabled = function (timeNameOrCuePoint) {
            return this._cpMgr[this._activeVP].isFLVCuePointEnabled(timeNameOrCuePoint);
        };
    $r2.getNextHighestDepth = function () {
            $r2 = super.getNextHighestDepth();
            return (!($r2 < 1000)) ? $r2 : 1000;
        };
    $r2.bringVideoPlayerToFront = function (index) {
            if ((index == this._topVP) || (this._vp[index] == undefined)) {
                return;
            }
            this._vp[this._topVP].swapDepths(this._vp[index].getDepth());
            this._topVP = index;
        };
    $r2.getVideoPlayer = function (index) {
            return this._vp[index];
        };
    $r2.closeVideoPlayer = function (index) {
            if (this._vp[index] == undefined) {
                return;
            }
            if (index == 0) {
                throw new mx.video.VideoError(mx.video.VideoError.DELETE_DEFAULT_PLAYER);
            }
            if (this._visibleVP == index) {
                this.__set__visibleVideoPlayerIndex(0);
            }
            if (this._activeVP == index) {
                this.__set__activeVideoPlayerIndex(0);
            }
            this._vp[index].close();
            this._vp[index].unloadMovie();
            delete this._vp[index];
            this._vp[index] = undefined;
        };
    $r2.__get__activeVideoPlayerIndex = function () {
            return this._activeVP;
        };
    $r2.__set__activeVideoPlayerIndex = function (i) {
            if (this._activeVP == i) {
                return;
            }
            if (!!!(this._vp[this._activeVP].onEnterFrame == undefined)) {
                this.doContentPathConnect();
            }
            this._activeVP = i;
            if (this._vp[this._activeVP] == undefined) {
                this.createVideoPlayer(this._activeVP);
                this._vp[this._activeVP].visible = false;
                this._vp[this._activeVP].volume = 0;
            }
            return this.__get__activeVideoPlayerIndex();
            <stack?>;
        };
    $r2.__get__autoPlay = function () {
            if (this._vpState[this._activeVP] == undefined) {
                return this._autoPlay;
            }
            return this._vpState[this._activeVP].autoPlay;
        };
    $r2.__set__autoPlay = function (flag) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._autoPlay = flag;
            }
            this._vpState[this._activeVP].autoPlay = flag;
            return this.__get__autoPlay();
            <stack?>;
        };
    $r2.__get__autoRewind = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._autoRewind;
            }
            return this._vp[this._activeVP].autoRewind;
        };
    $r2.__set__autoRewind = function (flag) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._autoRewind = flag;
            }
            this._vp[this._activeVP].autoRewind = flag;
            return this.__get__autoRewind();
            <stack?>;
        };
    $r2.__get__autoSize = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._autoSize;
            }
            return this._vp[this._activeVP].autoSize;
        };
    $r2.__set__autoSize = function (flag) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._autoSize = flag;
            }
            this._vp[this._activeVP].autoSize = flag;
            return this.__get__autoSize();
            <stack?>;
        };
    $r2.__get__bitrate = function () {
            return this.__get__ncMgr().getBitrate();
        };
    $r2.__set__bitrate = function (b) {
            this.__get__ncMgr().setBitrate(b);
            return this.__get__bitrate();
            <stack?>;
        };
    $r2.__get__buffering = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._vp[this._activeVP].state == mx.video.FLVPlayback.BUFFERING;
        };
    $r2.__get__bufferingBar = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._bufferingBar = this._uiMgr.getControl(mx.video.UIManager.BUFFERING_BAR);
            }
            return this._bufferingBar;
        };
    $r2.__set__bufferingBar = function (s) {
            this._bufferingBar = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.BUFFERING_BAR, s);
            }
            return this.__get__bufferingBar();
            <stack?>;
        };
    $r2.__get__bufferingBarHidesAndDisablesOthers = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._bufferingBarHides = this._uiMgr.bufferingBarHidesAndDisablesOthers;
            }
            return this._bufferingBarHides;
        };
    $r2.__set__bufferingBarHidesAndDisablesOthers = function (b) {
            this._bufferingBarHides = b;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__bufferingBarHidesAndDisablesOthers(b);
            }
            return this.__get__bufferingBarHidesAndDisablesOthers();
            <stack?>;
        };
    $r2.__get__backButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._backButton = this._uiMgr.getControl(mx.video.UIManager.BACK_BUTTON);
            }
            return this._backButton;
        };
    $r2.__set__backButton = function (s) {
            this._backButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.BACK_BUTTON, s);
            }
            return this.__get__backButton();
            <stack?>;
        };
    $r2.__get__bufferTime = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._bufferTime;
            }
            return this._vp[this._activeVP].bufferTime;
        };
    $r2.__set__bufferTime = function (aTime) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._bufferTime = aTime;
            }
            this._vp[this._activeVP].bufferTime = aTime;
            return this.__get__bufferTime();
            <stack?>;
        };
    $r2.__get__bytesLoaded = function () {
            return this._vp[this._activeVP].bytesLoaded;
        };
    $r2.__get__bytesTotal = function () {
            return this._vp[this._activeVP].bytesTotal;
        };
    $r2.__get__contentPath = function () {
            if ((this._vp[this._activeVP] == undefined) || !(this._vp[this._activeVP].onEnterFrame == undefined)) {
                return this._contentPath;
            }
            return this._vp[this._activeVP].url;
        };
    $r2.__set__contentPath = function (url) {
            if (_global.isLivePreview) {
                return;
            }
            if (this._vp[this._activeVP] == undefined) {
                if (url == this._contentPath) {
                    return;
                }
                this._contentPath = url;
            } else {
                if (this._vp[this._activeVP].url == url) {
                    return;
                }
                this._vpState[this._activeVP].minProgressPercent = undefined;
                if (!!!(this._vp[this._activeVP].onEnterFrame == undefined)) {
                    delete this._vp[this._activeVP].onEnterFrame;
                    this._vp[this._activeVP].onEnterFrame = undefined;
                }
                this._cpMgr[this._activeVP].reset();
                if (this._vpState[this._activeVP].autoPlay && this._firstStreamShown) {
                    this._vp[this._activeVP].play(url, this._vpState[this._activeVP].isLive, this._vpState[this._activeVP].totalTime);
                } else {
                    this._vp[this._activeVP].load(url, this._vpState[this._activeVP].isLive, this._vpState[this._activeVP].totalTime);
                }
                this._vpState[this._activeVP].isLiveSet = false;
                this._vpState[this._activeVP].totalTimeSet = false;
            }
            return this.__get__contentPath();
            <stack?>;
        };
    $r2.__set__cuePoints = function (cp) {
            if (!!!(this._cuePoints == undefined)) {
                return;
            }
            this._cuePoints = cp;
            return this.__get__cuePoints();
            <stack?>;
        };
    $r2.__get__forwardButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._forwardButton = this._uiMgr.getControl(mx.video.UIManager.FORWARD_BUTTON);
            }
            return this._forwardButton;
        };
    $r2.__set__forwardButton = function (s) {
            this._forwardButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.FORWARD_BUTTON, s);
            }
            return this.__get__forwardButton();
            <stack?>;
        };
    $r2.__get__height = function () {
            if (_global.isLivePreview) {
                return this.__height;
            }
            if (!!!(this._vp[this._visibleVP] == undefined)) {
                this.__height = this._vp[this._visibleVP].height;
            }
            return this.__height;
        };
    $r2.__set__height = function (h) {
            this.setSize(this.__get__width(), h);
            return this.__get__height();
            <stack?>;
        };
    $r2.__get__idleTimeout = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._idleTimeout;
            }
            return this._vp[this._activeVP].idleTimeout;
        };
    $r2.__set__idleTimeout = function (aTime) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._idleTimeout = aTime;
            }
            this._vp[this._activeVP].idleTimeout = aTime;
            return this.__get__idleTimeout();
            <stack?>;
        };
    $r2.__get__isRTMP = function () {
            if (_global.isLivePreview) {
                return true;
            }
            if (this._vp[this._activeVP] == undefined) {
                return;
            }
            return this._vp[this._activeVP].isRTMP;
        };
    $r2.__get__isLive = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._isLive;
            } else {
                if (this._vpState[this._activeVP].isLiveSet) {
                    return this._vpState[this._activeVP].isLive;
                } else {
                    return this._vp[this._activeVP].isLive;
                }
            }
        };
    $r2.__set__isLive = function (flag) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._isLive = flag;
            }
            this._vpState[this._activeVP].isLive = flag;
            this._vpState[this._activeVP].isLiveSet = true;
            return this.__get__isLive();
            <stack?>;
        };
    $r2.__get__maintainAspectRatio = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._aspectRatio;
            }
            return this._vp[this._activeVP].maintainAspectRatio;
        };
    $r2.__set__maintainAspectRatio = function (flag) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._aspectRatio = flag;
            }
            this._vp[this._activeVP].maintainAspectRatio = flag;
            return this.__get__maintainAspectRatio();
            <stack?>;
        };
    $r2.__get__metadata = function () {
            if (this._vp[this._activeVP] == undefined) {
                return null;
            }
            return this._vp[this._activeVP].metadata;
        };
    $r2.__get__metadataLoaded = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._cpMgr[this._activeVP].metadataLoaded;
        };
    $r2.__get__muteButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._muteButton = this._uiMgr.getControl(mx.video.UIManager.MUTE_BUTTON);
            }
            return this._muteButton;
        };
    $r2.__set__muteButton = function (s) {
            this._muteButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.MUTE_BUTTON, s);
            }
            return this.__get__muteButton();
            <stack?>;
        };
    $r2.__get__ncMgr = function () {
            if (this._vp[this._activeVP] == undefined) {
                return null;
            }
            return this._vp[this._activeVP].ncMgr;
        };
    $r2.__get__pauseButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._pauseButton = this._uiMgr.getControl(mx.video.UIManager.PAUSE_BUTTON);
            }
            return this._pauseButton;
        };
    $r2.__set__pauseButton = function (s) {
            this._pauseButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.PAUSE_BUTTON, s);
            }
            return this.__get__pauseButton();
            <stack?>;
        };
    $r2.__get__paused = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._vp[this._activeVP].state == mx.video.FLVPlayback.PAUSED;
        };
    $r2.__get__playButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._playButton = this._uiMgr.getControl(mx.video.UIManager.PLAY_BUTTON);
            }
            return this._playButton;
        };
    $r2.__set__playButton = function (s) {
            this._playButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.PLAY_BUTTON, s);
            }
            return this.__get__playButton();
            <stack?>;
        };
    $r2.__get__playheadTime = function () {
            if (this._vp[this._activeVP] == undefined) {
                return 0;
            }
            return this._vp[this._activeVP].playheadTime;
        };
    $r2.__set__playheadTime = function (position) {
            this.seek(position);
            return this.__get__playheadTime();
            <stack?>;
        };
    $r2.__get__playheadUpdateInterval = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._playheadUpdateInterval;
            }
            return this._vp[this._activeVP].playheadUpdateInterval;
        };
    $r2.__set__playheadUpdateInterval = function (aTime) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._playheadUpdateInterval = aTime;
            }
            this._cpMgr[this._activeVP].playheadUpdateInterval = aTime;
            this._vp[this._activeVP].playheadUpdateInterval = aTime;
            return this.__get__playheadUpdateInterval();
            <stack?>;
        };
    $r2.__get__playing = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._vp[this._activeVP].state == mx.video.FLVPlayback.PLAYING;
        };
    $r2.__get__playPauseButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._playPauseButton = this._uiMgr.getControl(mx.video.UIManager.PLAY_PAUSE_BUTTON);
            }
            return this._playPauseButton;
        };
    $r2.__set__playPauseButton = function (s) {
            this._playPauseButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.PLAY_PAUSE_BUTTON, s);
            }
            return this.__get__playPauseButton();
            <stack?>;
        };
    $r2.__get__preferredHeight = function () {
            if (this._vp[this._activeVP] == undefined) {
                return 0;
            }
            return this._vp[this._activeVP].videoHeight;
        };
    $r2.__get__preferredWidth = function () {
            if (this._vp[this._activeVP] == undefined) {
                return 0;
            }
            return this._vp[this._activeVP].videoWidth;
        };
    $r2.__get__progressInterval = function () {
            if (this._vp[this._activeVP] == undefined) {
                return this._progressInterval;
            }
            return this._vp[this._activeVP].progressInterval;
        };
    $r2.__set__progressInterval = function (aTime) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._progressInterval = aTime;
            }
            this._vp[this._activeVP].progressInterval = aTime;
            return this.__get__progressInterval();
            <stack?>;
        };
    $r2.__get__scaleX = function () {
            if (!!!(this._vp[this._visibleVP] == undefined)) {
                this._scaleX = (this._vp[this._visibleVP].width / this._origWidth) * 100;
            }
            return this._scaleX;
        };
    $r2.__set__scaleX = function (xs) {
            this.setScale(xs, this.__get__scaleY());
            return this.__get__scaleX();
            <stack?>;
        };
    $r2.__get__scaleY = function () {
            if (!!!(this._vp[this._visibleVP] == undefined)) {
                this._scaleY = (this._vp[this._visibleVP].height / this._origHeight) * 100;
            }
            return this._scaleY;
        };
    $r2.__set__scaleY = function (ys) {
            this.setScale(this.__get__scaleX(), ys);
            return this.__get__scaleY();
            <stack?>;
        };
    $r2.__get__scrubbing = function () {
            $r2 = this.__get__seekBar();
            if (($r2 == undefined) || ($r2.isDragging == undefined)) {
                return false;
            }
            return $r2.isDragging;
        };
    $r2.__get__seekBar = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._seekBar = this._uiMgr.getControl(mx.video.UIManager.SEEK_BAR);
            }
            return this._seekBar;
        };
    $r2.__set__seekBar = function (s) {
            this._seekBar = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.SEEK_BAR, s);
            }
            return this.__get__seekBar();
            <stack?>;
        };
    $r2.__get__seekBarInterval = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._seekBarInterval = this._uiMgr.seekBarInterval;
            }
            return this._seekBarInterval;
        };
    $r2.__set__seekBarInterval = function (s) {
            this._seekBarInterval = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__seekBarInterval(this._seekBarInterval);
            }
            return this.__get__seekBarInterval();
            <stack?>;
        };
    $r2.__get__seekBarScrubTolerance = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._seekBarScrubTolerance = this._uiMgr.seekBarScrubTolerance;
            }
            return this._seekBarScrubTolerance;
        };
    $r2.__set__seekBarScrubTolerance = function (s) {
            this._seekBarScrubTolerance = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__seekBarScrubTolerance(this._seekBarScrubTolerance);
            }
            return this.__get__seekBarScrubTolerance();
            <stack?>;
        };
    $r2.__get__seekToPrevOffset = function () {
            return this._seekToPrevOffset;
        };
    $r2.__set__seekToPrevOffset = function (s) {
            this._seekToPrevOffset = s;
            return this.__get__seekToPrevOffset();
            <stack?>;
        };
    $r2.__get__skin = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._skin = this._uiMgr.skin;
            }
            return this._skin;
        };
    $r2.__set__skin = function (s) {
            this._skin = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__skin(s);
            }
            return this.__get__skin();
            <stack?>;
        };
    $r2.__get__skinAutoHide = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._skinAutoHide = this._uiMgr.skinAutoHide;
            }
            return this._skinAutoHide;
        };
    $r2.__set__skinAutoHide = function (b) {
            if (_global.isLivePreview) {
                return;
            }
            this._skinAutoHide = b;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__skinAutoHide(b);
            }
            return this.__get__skinAutoHide();
            <stack?>;
        };
    $r2.__get__transform = function () {
            return this._transform;
        };
    $r2.__set__transform = function (s) {
            this._transform = s;
            if (!!!(this._vp[this._activeVP] == undefined)) {
                this._vp[this._activeVP].transform = this._transform;
            }
            return this.__get__transform();
            <stack?>;
        };
    $r2.__get__state = function () {
            if (_global.isLivePreview) {
                return mx.video.FLVPlayback.STOPPED;
            }
            if (this._vp[this._activeVP] == undefined) {
                return mx.video.FLVPlayback.DISCONNECTED;
            }
            if ((this._activeVP == this._visibleVP) && this.__get__scrubbing()) {
                return mx.video.FLVPlayback.SEEKING;
            }
            $r3 = this._vp[this._activeVP].state;
            if ($r3 == mx.video.VideoPlayer.RESIZING) {
                return mx.video.FLVPlayback.LOADING;
            }
            if (((this._vpState[this._activeVP].prevState == mx.video.FLVPlayback.LOADING) && this._vpState[this._activeVP].autoPlay) && ($r3 == mx.video.FLVPlayback.STOPPED)) {
                return mx.video.FLVPlayback.LOADING;
            }
            return $r3;
        };
    $r2.__get__stateResponsive = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._vp[this._activeVP].stateResponsive;
        };
    $r2.__get__stopButton = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._stopButton = this._uiMgr.getControl(mx.video.UIManager.STOP_BUTTON);
            }
            return this._stopButton;
        };
    $r2.__set__stopButton = function (s) {
            this._stopButton = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.STOP_BUTTON, s);
            }
            return this.__get__stopButton();
            <stack?>;
        };
    $r2.__get__stopped = function () {
            if (this._vp[this._activeVP] == undefined) {
                return false;
            }
            return this._vp[this._activeVP].state == mx.video.FLVPlayback.STOPPED;
        };
    $r2.__get__totalTime = function () {
            if (_global.isLivePreview) {
                return 1;
            }
            if (this._vp[this._activeVP] == undefined) {
                return this._totalTime;
            } else {
                if (this._vpState[this._activeVP].totalTimeSet) {
                    return this._vpState[this._activeVP].totalTime;
                } else {
                    return this._vp[this._activeVP].totalTime;
                }
            }
        };
    $r2.__set__totalTime = function (aTime) {
            if ((this._activeVP == 0) || (this._activeVP == undefined)) {
                this._totalTime = aTime;
            }
            this._vpState[this._activeVP].totalTime = aTime;
            this._vpState[this._activeVP].totalTimeSet = true;
            return this.__get__totalTime();
            <stack?>;
        };
    $r2.__get__visible = function () {
            return this._visible;
        };
    $r2.__set__visible = function (v) {
            this._visible = v;
            return this.__get__visible();
            <stack?>;
        };
    $r2.__get__visibleVideoPlayerIndex = function () {
            return this._visibleVP;
        };
    $r2.__set__visibleVideoPlayerIndex = function (i) {
            if (this._visibleVP == i) {
                return;
            }
            $r2 = this._visibleVP;
            if (this._vp[i] == undefined) {
                this.createVideoPlayer(i);
            }
            $r5 = !(this._vp[i].height == this._vp[this._visibleVP].height) || !(this._vp[i].width == this._vp[this._visibleVP].width);
            this._vp[this._visibleVP].visible = false;
            this._vp[this._visibleVP].volume = 0;
            this._visibleVP = i;
            if (this._firstStreamShown) {
                this._uiMgr.setupSkinAutoHide($r2);
                this._vp[this._visibleVP].visible = true;
                if (!this.__get__scrubbing()) {
                    this._vp[this._visibleVP].volume = this._volume;
                }
            } else {
                if ((this._vp[this._visibleVP].stateResponsive && !(this._vp[this._visibleVP].state == mx.video.FLVPlayback.DISCONNECTED)) && this._uiMgr.__get__skinReady()) {
                    this._uiMgr.__set__visible(true);
                    this._uiMgr.setupSkinAutoHide($r2);
                    this._firstStreamReady = true;
                    this.showFirstStream();
                }
            }
            if (!(this._vp[$r2].height == this._vp[this._visibleVP].height) || !(this._vp[$r2].width == this._vp[this._visibleVP].width)) {
                this.dispatchEvent({vp: this._visibleVP, auto: false, height: this.__get__height(), width: this.__get__width(), y: this.__get__y(), x: this.__get__x(), type: "resize"});
            }
            this._uiMgr.handleEvent({vp: this._visibleVP, state: this._vp[this._visibleVP].state, type: "stateChange"});
            this._uiMgr.handleEvent({vp: this._visibleVP, playheadTime: this._vp[this._visibleVP].playheadTime, type: "playheadUpdate"});
            if (this._vp[this._visibleVP].isRTMP) {
                this._uiMgr.handleEvent({vp: this._visibleVP, type: "ready"});
            } else {
                this._uiMgr.handleEvent({vp: this._visibleVP, bytesTotal: this._vp[this._visibleVP].bytesTotal, bytesLoaded: this._vp[this._visibleVP].bytesLoaded, type: "progress"});
            }
            return this.__get__visibleVideoPlayerIndex();
            <stack?>;
        };
    $r2.__get__volume = function () {
            return this._volume;
        };
    $r2.__set__volume = function (aVol) {
            if (this._volume == aVol) {
                return;
            }
            this._volume = aVol;
            if (!this.__get__scrubbing()) {
                this._vp[this._visibleVP].volume = this._volume;
            }
            this.dispatchEvent({volume: aVol, type: "volumeUpdate"});
            return this.__get__volume();
            <stack?>;
        };
    $r2.__get__volumeBar = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._volumeBar = this._uiMgr.getControl(mx.video.UIManager.VOLUME_BAR);
            }
            return this._volumeBar;
        };
    $r2.__set__volumeBar = function (s) {
            this._volumeBar = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.setControl(mx.video.UIManager.VOLUME_BAR, s);
            }
            return this.__get__volumeBar();
            <stack?>;
        };
    $r2.__get__volumeBarInterval = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._volumeBarInterval = this._uiMgr.volumeBarInterval;
            }
            return this._volumeBarInterval;
        };
    $r2.__set__volumeBarInterval = function (s) {
            this._volumeBarInterval = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__volumeBarInterval(this._volumeBarInterval);
            }
            return this.__get__volumeBarInterval();
            <stack?>;
        };
    $r2.__get__volumeBarScrubTolerance = function () {
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._volumeBarScrubTolerance = this._uiMgr.volumeBarScrubTolerance;
            }
            return this._volumeBarScrubTolerance;
        };
    $r2.__set__volumeBarScrubTolerance = function (s) {
            this._volumeBarScrubTolerance = s;
            if (!(this._uiMgr == null) && !(this._uiMgr == undefined)) {
                this._uiMgr.__set__volumeBarScrubTolerance(this._volumeBarScrubTolerance);
            }
            return this.__get__volumeBarScrubTolerance();
            <stack?>;
        };
    $r2.__get__width = function () {
            if (_global.isLivePreview) {
                return this.__width;
            }
            if (!!!(this._vp[this._visibleVP] == undefined)) {
                this.__width = this._vp[this._visibleVP].width;
            }
            return this.__width;
        };
    $r2.__set__width = function (w) {
            this.setSize(w, this.__get__height());
            return this.__get__width();
            <stack?>;
        };
    $r2.__get__x = function () {
            return this._x;
        };
    $r2.__set__x = function (xpos) {
            this._x = xpos;
            return this.__get__x();
            <stack?>;
        };
    $r2.__get__y = function () {
            return this._y;
        };
    $r2.__set__y = function (ypos) {
            this._y = ypos;
            return this.__get__y();
            <stack?>;
        };
    $r2.createVideoPlayer = function (index) {
            if (_global.isLivePreview) {
                return;
            }
            $r4 = this.__get__width();
            $r5 = this.__get__height();
            this._vp[index] = mx.video.VideoPlayer(this.attachMovie("VideoPlayer", String(index), mx.video.FLVPlayback.VP_DEPTH_OFFSET + index));
            this._vp[index].setSize($r4, $r5);
            this._topVP = index;
            this._vp[index].autoRewind = this._autoRewind;
            this._vp[index].autoSize = this._autoSize;
            this._vp[index].bufferTime = this._bufferTime;
            this._vp[index].idleTimeout = this._idleTimeout;
            this._vp[index].maintainAspectRatio = this._aspectRatio;
            this._vp[index].playheadUpdateInterval = this._playheadUpdateInterval;
            this._vp[index].progressInterval = this._progressInterval;
            this._vp[index].transform = this._transform;
            this._vp[index].volume = this._volume;
            if (index == 0) {
                this._vpState[index] = {autoPlay: this._autoPlay, totalTimeSet: true, totalTime: this._totalTime, isLiveSet: true, isLive: this._isLive, id: index};
                if ((!(this._contentPath == null) && !(this._contentPath == undefined)) && !(this._contentPath == "")) {
                    this._vp[index].onEnterFrame = mx.utils.Delegate.create(this, this.doContentPathConnect);
                }
            } else {
                this._vpState[index] = {autoPlay: false, totalTimeSet: true, totalTime: 0, isLiveSet: true, isLive: false, id: index};
            }
            this._vp[index].addEventListener("resize", this);
            this._vp[index].addEventListener("close", this);
            this._vp[index].addEventListener("complete", this);
            this._vp[index].addEventListener("cuePoint", this);
            this._vp[index].addEventListener("playheadUpdate", this);
            this._vp[index].addEventListener("progress", this);
            this._vp[index].addEventListener("metadataReceived", this);
            this._vp[index].addEventListener("stateChange", this);
            this._vp[index].addEventListener("ready", this);
            this._vp[index].addEventListener("rewind", this);
            this._cpMgr[index] = new mx.video.CuePointManager(this, index);
            this._cpMgr[index].playheadUpdateInterval = this._playheadUpdateInterval;
        };
    $r2.createUIManager = function () {
            this._uiMgr = new mx.video.UIManager(this);
            this._uiMgr.__set__visible(false);
            if (!(this._backButton == undefined) && !(this._backButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.BACK_BUTTON, this._backButton);
            }
            if (!(this._bufferingBar == undefined) && !(this._bufferingBar == null)) {
                this._uiMgr.setControl(mx.video.UIManager.BUFFERING_BAR, this._bufferingBar);
            }
            this._uiMgr.__set__bufferingBarHidesAndDisablesOthers(this._bufferingBarHides);
            if (!(this._forwardButton == undefined) && !(this._forwardButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.FORWARD_BUTTON, this._forwardButton);
            }
            if (!(this._pauseButton == undefined) && !(this._pauseButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.PAUSE_BUTTON, this._pauseButton);
            }
            if (!(this._playButton == undefined) && !(this._playButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.PLAY_BUTTON, this._playButton);
            }
            if (!(this._playPauseButton == undefined) && !(this._playPauseButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.PLAY_PAUSE_BUTTON, this._playPauseButton);
            }
            if (!(this._stopButton == undefined) && !(this._stopButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.STOP_BUTTON, this._stopButton);
            }
            if (!(this._seekBar == undefined) && !(this._seekBar == null)) {
                this._uiMgr.setControl(mx.video.UIManager.SEEK_BAR, this._seekBar);
            }
            if (!(this._seekBarInterval == undefined) && !(this._seekBarInterval == null)) {
                this._uiMgr.__set__seekBarInterval(this._seekBarInterval);
            }
            if (!(this._seekBarScrubTolerance == undefined) && !(this._seekBarScrubTolerance == null)) {
                this._uiMgr.__set__seekBarScrubTolerance(this._seekBarScrubTolerance);
            }
            if (!(this._skin == undefined) && !(this._skin == null)) {
                this._uiMgr.__set__skin(this._skin);
            }
            if (!(this._skinAutoHide == undefined) && !(this._skinAutoHide == null)) {
                this._uiMgr.__set__skinAutoHide(this._skinAutoHide);
            }
            if (!(this._muteButton == undefined) && !(this._muteButton == null)) {
                this._uiMgr.setControl(mx.video.UIManager.MUTE_BUTTON, this._muteButton);
            }
            if (!(this._volumeBar == undefined) && !(this._volumeBar == null)) {
                this._uiMgr.setControl(mx.video.UIManager.VOLUME_BAR, this._volumeBar);
            }
            if (!(this._volumeBarInterval == undefined) && !(this._volumeBarInterval == null)) {
                this._uiMgr.__set__volumeBarInterval(this._volumeBarInterval);
            }
            if (!(this._volumeBarScrubTolerance == undefined) && !(this._volumeBarScrubTolerance == null)) {
                this._uiMgr.__set__volumeBarScrubTolerance(this._volumeBarScrubTolerance);
            }
        };
    $r2.createLivePreviewMovieClip = function () {
            this.preview_mc = this.createEmptyMovieClip("preview_mc", 10);
            this.preview_mc.createEmptyMovieClip("box_mc", 10);
            this.preview_mc.box_mc.beginFill(0);
            this.preview_mc.box_mc.moveTo(0, 0);
            this.preview_mc.box_mc.lineTo(0, 100);
            this.preview_mc.box_mc.lineTo(100, 100);
            this.preview_mc.box_mc.lineTo(100, 0);
            this.preview_mc.box_mc.lineTo(0, 0);
            this.preview_mc.box_mc.endFill();
            this.preview_mc.attachMovie("Icon", "icon_mc", 20);
        };
    $r2.doContentPathConnect = function () {
            delete this._vp[0].onEnterFrame;
            this._vp[0].onEnterFrame = undefined;
            if (_global.isLivePreview) {
                return;
            }
            if (this._vpState[0].autoPlay && this._firstStreamShown) {
                this._vp[0].play(this._contentPath, this._isLive, this._totalTime);
            } else {
                this._vp[0].load(this._contentPath, this._isLive, this._totalTime);
            }
            this._vpState[0].isLiveSet = false;
            this._vpState[0].totalTimeSet = false;
        };
    $r2.showFirstStream = function () {
            this._firstStreamShown = true;
            this._vp[this._visibleVP].visible = true;
            if (!this.__get__scrubbing()) {
                this._vp[this._visibleVP].volume = this._volume;
            }
            $r2 = 0;
            while ($r2 < this._vp.length) {
                if ((!(this._vp[$r2] == undefined) && (this._vp[$r2].state == mx.video.FLVPlayback.STOPPED)) && this._vpState[$r2].autoPlay) {
                    this._vp[$r2].play();
                }
                $r2 = $r2 + 1;
            }
        };
    $r2._scrubStart = function () {
            $r2 = this.__get__playheadTime();
            this._vp[this._visibleVP].volume = 0;
            this.dispatchEvent({vp: this._visibleVP, playheadTime: $r2, state: mx.video.FLVPlayback.SEEKING, type: "stateChange"});
            this.dispatchEvent({playheadTime: $r2, state: mx.video.FLVPlayback.SEEKING, type: "scrubStart"});
        };
    $r2._scrubFinish = function () {
            $r3 = this.__get__playheadTime();
            $r2 = this.__get__state();
            this._vp[this._visibleVP].volume = this._volume;
            if (!!!($r2 == mx.video.FLVPlayback.SEEKING)) {
                this.dispatchEvent({vp: this._visibleVP, playheadTime: $r3, state: $r2, type: "stateChange"});
            }
            this.dispatchEvent({playheadTime: $r3, state: $r2, type: "scrubFinish"});
        };
    $r2.skinError = function (message) {
            if (this._firstStreamReady && !this._firstStreamShown) {
                this.showFirstStream();
            }
            this.dispatchEvent({message: message, type: "skinError"});
        };
    $r2.skinLoaded = function () {
            if (this._firstStreamReady) {
                this._uiMgr.__set__visible(true);
                if (!this._firstStreamShown) {
                    this.showFirstStream();
                }
            } else {
                if (((this._contentPath == undefined) || (this._contentPath == null)) || (this._contentPath == "")) {
                    this._uiMgr.__set__visible(true);
                }
            }
            this.dispatchEvent({type: "skinLoaded"});
        };
    $r1.version = "1.0.0.103";
    $r1.DISCONNECTED = "disconnected";
    $r1.STOPPED = "stopped";
    $r1.PLAYING = "playing";
    $r1.PAUSED = "paused";
    $r1.BUFFERING = "buffering";
    $r1.LOADING = "loading";
    $r1.CONNECTION_ERROR = "connectionError";
    $r1.REWINDING = "rewinding";
    $r1.SEEKING = "seeking";
    $r1.ALL = "all";
    $r1.EVENT = "event";
    $r1.NAVIGATION = "navigation";
    $r1.FLV = "flv";
    $r1.ACTIONSCRIPT = "actionscript";
    $r1.VP_DEPTH_OFFSET = 100;
    $r1.SEEK_TO_PREV_OFFSET_DEFAULT = 1;
}
ASSetPropFlags(mx.video.FLVPlayback.prototype, null, 1);
// ======== DoInitAction sprite=10 __Packages.mx.video.VideoPlayer
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.VideoPlayer) {
    $r1 = function () {
            super();
            mx.events.EventDispatcher.initialize(this);
            this._state = mx.video.VideoPlayer.DISCONNECTED;
            this._cachedState = this._state;
            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
            this._cachedPlayheadTime = 0;
            this._metadata = null;
            this._startingPlay = false;
            this._invalidSeekTime = false;
            this._invalidSeekRecovery = false;
            this._currentPos = 0;
            this._atEnd = false;
            this._cmdQueue = new Array();
            this._readyDispatched = false;
            this._autoResizeDone = false;
            this._lastUpdateTime = -1;
            this._sawSeekNotify = false;
            this._updateTimeIntervalID = 0;
            this._updateTimeInterval = mx.video.VideoPlayer.DEFAULT_UPDATE_TIME_INTERVAL;
            this._updateProgressIntervalID = 0;
            this._updateProgressInterval = mx.video.VideoPlayer.DEFAULT_UPDATE_PROGRESS_INTERVAL;
            this._idleTimeoutIntervalID = 0;
            this._idleTimeoutInterval = mx.video.VideoPlayer.DEFAULT_IDLE_TIMEOUT_INTERVAL;
            this._autoResizeIntervalID = 0;
            this._rtmpDoStopAtEndIntervalID = 0;
            this._rtmpDoSeekIntervalID = 0;
            this._httpDoSeekIntervalID = 0;
            this._httpDoSeekCount = 0;
            this._finishAutoResizeIntervalID = 0;
            this._delayedBufferingIntervalID = 0;
            this._delayedBufferingInterval = mx.video.VideoPlayer.HTTP_DELAYED_BUFFERING_INTERVAL;
            if (this._isLive == undefined) {
                this._isLive = false;
            }
            if (this._autoSize == undefined) {
                this._autoSize = false;
            }
            if (this._aspectRatio == undefined) {
                this._aspectRatio = true;
            }
            if (this._autoPlay == undefined) {
                this._autoPlay = true;
            }
            if (this._autoRewind == undefined) {
                this._autoRewind = true;
            }
            if (this._bufferTime == undefined) {
                this._bufferTime = 0.1;
            }
            if (this._volume == undefined) {
                this._volume = 100;
            }
            this._sound = new Sound(this);
            this._sound.setVolume(this._volume);
            this.__visible = true;
            this._hiddenForResize = false;
            this._hiddenForResizeMetadataDelay = 0;
            this._contentPath = "";
        };
    mx.video.VideoPlayer = $r1;
    mx.video.VideoPlayer.extends(MovieClip);
    $r2 = $r1.prototype;
    $r2.setSize = function (w, h) {
            if (((w == this._video._width) && (h == this._video._height)) || this._autoSize) {
                return;
            }
            this._video._width = w;
            this._video._height = h;
            if (this._aspectRatio) {
                this.startAutoResize();
            }
        };
    $r2.setScale = function (xs, ys) {
            if (((xs == this._video._xscale) && (ys == this._video._yscale)) || this._autoSize) {
                return;
            }
            this._video._xscale = xs;
            this._video._yscale = ys;
            if (this._aspectRatio) {
                this.startAutoResize();
            }
        };
    $r2.play = function (url, isLive, totalTime) {
            if (!(url == null) && !(url == undefined)) {
                if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                    this._state = this._cachedState;
                } else {
                    if (!this.__get__stateResponsive()) {
                        this.queueCmd(mx.video.VideoPlayer.PLAY, url, isLive, totalTime);
                        return;
                    } else {
                        this.execQueuedCmds();
                    }
                }
                this._autoPlay = true;
                this._load(url, isLive, totalTime);
                return;
            }
            if (!this.isXnOK()) {
                if (((((this._state == mx.video.VideoPlayer.CONNECTION_ERROR) || (this._ncMgr == null)) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                    throw new mx.video.VideoError(mx.video.VideoError.NO_CONNECTION);
                } else {
                    this.flushQueuedCmds();
                    this.queueCmd(mx.video.VideoPlayer.PLAY);
                    this.setState(mx.video.VideoPlayer.LOADING);
                    this._cachedState = mx.video.VideoPlayer.LOADING;
                    this._ncMgr.reconnect();
                    return;
                }
            } else {
                if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                    this._state = this._cachedState;
                } else {
                    if (!this.__get__stateResponsive()) {
                        this.queueCmd(mx.video.VideoPlayer.PLAY);
                        return;
                    } else {
                        this.execQueuedCmds();
                    }
                }
            }
            if ((this._ns == null) || (this._ns == undefined)) {
                this._createStream();
                this._video.attachVideo(this._ns);
                this.attachAudio(this._ns);
            }
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                    if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                        if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                            goto L0000;
                            if (this._ncMgr.isRTMP()) {
                                this._play(0);
                                if (this._atEnd) {
                                    this._atEnd = false;
                                    this._currentPos = 0;
                                    this.setState(mx.video.VideoPlayer.REWINDING);
                                } else {
                                    if (this._currentPos > 0) {
                                        this._seek(this._currentPos);
                                        this._currentPos = 0;
                                    }
                                }
                            }
                            return;
                            if (this._ncMgr.isRTMP()) {
                                if (this._isLive) {
                                    this._play(-1);
                                    this.setState(mx.video.VideoPlayer.BUFFERING);
                                } else {
                                    this._play(0);
                                    if (this._atEnd) {
                                        this._atEnd = false;
                                        this._currentPos = 0;
                                        this._state = mx.video.VideoPlayer.BUFFERING;
                                        this.setState(mx.video.VideoPlayer.REWINDING);
                                    } else {
                                        if (this._currentPos > 0) {
                                            this._seek(this._currentPos);
                                            this._currentPos = 0;
                                            this.setState(mx.video.VideoPlayer.BUFFERING);
                                        } else {
                                            this.setState(mx.video.VideoPlayer.BUFFERING);
                                        }
                                    }
                                }
                            } else {
                                this._pause(false);
                                if (this._atEnd) {
                                    this._atEnd = false;
                                    this._seek(0);
                                    this._state = mx.video.VideoPlayer.BUFFERING;
                                    this.setState(mx.video.VideoPlayer.REWINDING);
                                } else {
                                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                                        this.setState(mx.video.VideoPlayer.BUFFERING);
                                    } else {
                                        this.setState(mx.video.VideoPlayer.PLAYING);
                                    }
                                }
                            }
                        } else {
                            this._pause(false);
                            if (!this._ncMgr.isRTMP()) {
                                if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                                    this.setState(mx.video.VideoPlayer.BUFFERING);
                                } else {
                                    this.setState(mx.video.VideoPlayer.PLAYING);
                                }
                            } else {
                                this.setState(mx.video.VideoPlayer.BUFFERING);
                            }
                            goto L0000;
                        }
                    }
                }
            } else {
                if (this._ncMgr.isRTMP()) {
                    this._play(0);
                    if (this._atEnd) {
                        this._atEnd = false;
                        this._currentPos = 0;
                        this.setState(mx.video.VideoPlayer.REWINDING);
                    } else {
                        if (this._currentPos > 0) {
                            this._seek(this._currentPos);
                            this._currentPos = 0;
                        }
                    }
                }
                return;
                if (this._ncMgr.isRTMP()) {
                    if (this._isLive) {
                        this._play(-1);
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                    } else {
                        this._play(0);
                        if (this._atEnd) {
                            this._atEnd = false;
                            this._currentPos = 0;
                            this._state = mx.video.VideoPlayer.BUFFERING;
                            this.setState(mx.video.VideoPlayer.REWINDING);
                        } else {
                            if (this._currentPos > 0) {
                                this._seek(this._currentPos);
                                this._currentPos = 0;
                                this.setState(mx.video.VideoPlayer.BUFFERING);
                            } else {
                                this.setState(mx.video.VideoPlayer.BUFFERING);
                            }
                        }
                    }
                } else {
                    this._pause(false);
                    if (this._atEnd) {
                        this._atEnd = false;
                        this._seek(0);
                        this._state = mx.video.VideoPlayer.BUFFERING;
                        this.setState(mx.video.VideoPlayer.REWINDING);
                    } else {
                        if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                            this.setState(mx.video.VideoPlayer.BUFFERING);
                        } else {
                            this.setState(mx.video.VideoPlayer.PLAYING);
                        }
                    }
                }
                goto L0000;
                this._pause(false);
                if (!this._ncMgr.isRTMP()) {
                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                    } else {
                        this.setState(mx.video.VideoPlayer.PLAYING);
                    }
                } else {
                    this.setState(mx.video.VideoPlayer.BUFFERING);
                }
                goto L0000;
            }
        };
    $r2.load = function (url, isLive, totalTime) {
            if ((url == null) || (url == undefined)) {
                throw new Error("null url sent to VideoPlayer.load");
            }
            if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                this._state = this._cachedState;
            } else {
                if (!this.__get__stateResponsive()) {
                    this.queueCmd(mx.video.VideoPlayer.LOAD, url, isLive, totalTime);
                    return;
                } else {
                    this.execQueuedCmds();
                }
            }
            this._autoPlay = false;
            this._load(url, isLive, totalTime);
        };
    $r2._load = function (url, isLive, totalTime) {
            this._prevVideoWidth = this.videoWidth;
            if (this._prevVideoWidth == undefined) {
                this._prevVideoWidth = this._video.width;
                if (this._prevVideoWidth == undefined) {
                    this._prevVideoWidth = 0;
                }
            }
            this._prevVideoHeight = this.videoHeight;
            if (this._prevVideoHeight == undefined) {
                this._prevVideoHeight = this._video.height;
                if (this._prevVideoHeight == undefined) {
                    this._prevVideoHeight = 0;
                }
            }
            this._autoResizeDone = false;
            this._cachedPlayheadTime = 0;
            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
            this._metadata = null;
            this._startingPlay = false;
            this._invalidSeekTime = false;
            this._invalidSeekRecovery = false;
            this._isLive = (!(isLive == undefined)) ? isLive : false;
            this._contentPath = url;
            this._currentPos = 0;
            this._streamLength = totalTime;
            this._atEnd = false;
            this._videoWidth = undefined;
            this._videoHeight = undefined;
            this._readyDispatched = false;
            this._lastUpdateTime = -1;
            this._sawSeekNotify = false;
            clearInterval(this._updateTimeIntervalID);
            this._updateTimeIntervalID = 0;
            clearInterval(this._updateProgressIntervalID);
            this._updateProgressIntervalID = 0;
            clearInterval(this._idleTimeoutIntervalID);
            this._idleTimeoutIntervalID = 0;
            clearInterval(this._autoResizeIntervalID);
            this._autoResizeIntervalID = 0;
            clearInterval(this._rtmpDoStopAtEndIntervalID);
            this._rtmpDoStopAtEndIntervalID = 0;
            clearInterval(this._rtmpDoSeekIntervalID);
            this._rtmpDoSeekIntervalID = 0;
            clearInterval(this._httpDoSeekIntervalID);
            this._httpDoSeekIntervalID = 0;
            clearInterval(this._finishAutoResizeIntervalID);
            this._finishAutoResizeIntervalID = 0;
            clearInterval(this._delayedBufferingIntervalID);
            this._delayedBufferingIntervalID = 0;
            this.closeNS(false);
            if ((this._ncMgr == null) || (this._ncMgr == undefined)) {
                this.createINCManager();
            }
            $r2 = this._ncMgr.connectToURL(this._contentPath);
            this.setState(mx.video.VideoPlayer.LOADING);
            this._cachedState = mx.video.VideoPlayer.LOADING;
            if ($r2) {
                this._createStream();
                this._setUpStream();
            }
            if (!this._ncMgr.isRTMP()) {
                clearInterval(this._updateProgressIntervalID);
                this._updateProgressIntervalID = setInterval(this, "doUpdateProgress", this._updateProgressInterval);
            }
        };
    $r2.pause = function () {
            if (!this.isXnOK()) {
                if (((((this._state == mx.video.VideoPlayer.CONNECTION_ERROR) || (this._ncMgr == null)) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                    throw new mx.video.VideoError(mx.video.VideoError.NO_CONNECTION);
                } else {
                    return;
                }
            } else {
                if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                    this._state = this._cachedState;
                } else {
                    if (!this.__get__stateResponsive()) {
                        this.queueCmd(mx.video.VideoPlayer.PAUSE);
                        return;
                    } else {
                        this.execQueuedCmds();
                    }
                }
            }
            if ((((this._state == mx.video.VideoPlayer.PAUSED) || (this._state == mx.video.VideoPlayer.STOPPED)) || (this._ns == null)) || (this._ns == undefined)) {
                return;
            }
            this._pause(true);
            this.setState(mx.video.VideoPlayer.PAUSED);
        };
    $r2.stop = function () {
            if (!this.isXnOK()) {
                if (((((this._state == mx.video.VideoPlayer.CONNECTION_ERROR) || (this._ncMgr == null)) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                    throw new mx.video.VideoError(mx.video.VideoError.NO_CONNECTION);
                } else {
                    return;
                }
            } else {
                if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                    this._state = this._cachedState;
                } else {
                    if (!this.__get__stateResponsive()) {
                        this.queueCmd(mx.video.VideoPlayer.STOP);
                        return;
                    } else {
                        this.execQueuedCmds();
                    }
                }
            }
            if (((this._state == mx.video.VideoPlayer.STOPPED) || (this._ns == null)) || (this._ns == undefined)) {
                return;
            }
            if (this._ncMgr.isRTMP()) {
                if (this._autoRewind && !this._isLive) {
                    this._currentPos = 0;
                    this._play(0, 0);
                    this._state = mx.video.VideoPlayer.STOPPED;
                    this.setState(mx.video.VideoPlayer.REWINDING);
                } else {
                    this.closeNS(true);
                    this.setState(mx.video.VideoPlayer.STOPPED);
                }
            } else {
                this._pause(true);
                if (this._autoRewind) {
                    this._seek(0);
                    this._state = mx.video.VideoPlayer.STOPPED;
                    this.setState(mx.video.VideoPlayer.REWINDING);
                } else {
                    this.setState(mx.video.VideoPlayer.STOPPED);
                }
            }
        };
    $r2.seek = function (time) {
            if (this._invalidSeekTime) {
                return;
            }
            if (isNaN(time) || (time < 0)) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_SEEK);
            }
            if (!this.isXnOK()) {
                if (((((this._state == mx.video.VideoPlayer.CONNECTION_ERROR) || (this._ncMgr == null)) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                    throw new mx.video.VideoError(mx.video.VideoError.NO_CONNECTION);
                } else {
                    this.flushQueuedCmds();
                    this.queueCmd(mx.video.VideoPlayer.SEEK, null, false, time);
                    this.setState(mx.video.VideoPlayer.LOADING);
                    this._cachedState = mx.video.VideoPlayer.LOADING;
                    this._ncMgr.reconnect();
                    return;
                }
            } else {
                if (this._state == mx.video.VideoPlayer.EXEC_QUEUED_CMD) {
                    this._state = this._cachedState;
                } else {
                    if (!this.__get__stateResponsive()) {
                        this.queueCmd(mx.video.VideoPlayer.SEEK, null, false, time);
                        return;
                    } else {
                        this.execQueuedCmds();
                    }
                }
            }
            if ((this._ns == null) || (this._ns == undefined)) {
                this._createStream();
                this._video.attachVideo(this._ns);
                this.attachAudio(this._ns);
            }
            if (this._atEnd && (time < this.__get__playheadTime())) {
                this._atEnd = false;
            }
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                    if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                        if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                            goto L0000;
                            this._state = mx.video.VideoPlayer.BUFFERING;
                            this._seek(time);
                            this.setState(mx.video.VideoPlayer.SEEKING);
                        } else {
                            if (this._ncMgr.isRTMP()) {
                                this._play(0);
                                this._pause(true);
                            }
                            this._seek(time);
                            this._state = mx.video.VideoPlayer.PAUSED;
                            this.setState(mx.video.VideoPlayer.SEEKING);
                            goto L0000;
                        }
                    }
                }
            } else {
                this._state = mx.video.VideoPlayer.BUFFERING;
                this._seek(time);
                this.setState(mx.video.VideoPlayer.SEEKING);
                goto L0000;
                if (this._ncMgr.isRTMP()) {
                    this._play(0);
                    this._pause(true);
                }
                this._seek(time);
                this._state = mx.video.VideoPlayer.PAUSED;
                this.setState(mx.video.VideoPlayer.SEEKING);
                goto L0000;
            }
        };
    $r2.close = function () {
            this.closeNS(true);
            if ((!(this._ncMgr == null) && !(this._ncMgr == undefined)) && this._ncMgr.isRTMP()) {
                this._ncMgr.close();
            }
            this.setState(mx.video.VideoPlayer.DISCONNECTED);
            this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: this._state, type: "close"});
        };
    $r2.__get__x = function () {
            return this._x;
        };
    $r2.__set__x = function (xpos) {
            this._x = xpos;
            return this.__get__x();
            <stack?>;
        };
    $r2.__get__y = function () {
            return this._y;
        };
    $r2.__set__y = function (ypos) {
            this._y = ypos;
            return this.__get__y();
            <stack?>;
        };
    $r2.__get__scaleX = function () {
            return this._video._xscale;
        };
    $r2.__set__scaleX = function (xs) {
            this.setScale(xs, this.__get__scaleY());
            return this.__get__scaleX();
            <stack?>;
        };
    $r2.__get__scaleY = function () {
            return this._video._yscale;
        };
    $r2.__set__scaleY = function (ys) {
            this.setScale(this.__get__scaleX(), ys);
            return this.__get__scaleY();
            <stack?>;
        };
    $r2.__get__width = function () {
            return this._video._width;
        };
    $r2.__set__width = function (w) {
            this.setSize(w, this._video._height);
            return this.__get__width();
            <stack?>;
        };
    $r2.__get__height = function () {
            return this._video._height;
        };
    $r2.__set__height = function (h) {
            this.setSize(this._video._width, h);
            return this.__get__height();
            <stack?>;
        };
    $r2.__get__videoWidth = function () {
            if (this._readyDispatched) {
                this._videoWidth = this._video.width;
            }
            return this._videoWidth;
        };
    $r2.__get__videoHeight = function () {
            if (this._readyDispatched) {
                this._videoHeight = this._video.height;
            }
            return this._videoHeight;
        };
    $r2.__get__visible = function () {
            if (!this._hiddenForResize) {
                this.__visible = this._visible;
            }
            return this.__visible;
        };
    $r2.__set__visible = function (v) {
            this.__visible = v;
            if (!this._hiddenForResize) {
                this._visible = this.__visible;
            }
            return this.__get__visible();
            <stack?>;
        };
    $r2.__get__autoSize = function () {
            return this._autoSize;
        };
    $r2.__set__autoSize = function (flag) {
            if (!!!(this._autoSize == flag)) {
                this._autoSize = flag;
                if (this._autoSize) {
                    this.startAutoResize();
                }
            }
            return this.__get__autoSize();
            <stack?>;
        };
    $r2.__get__maintainAspectRatio = function () {
            return this._aspectRatio;
        };
    $r2.__set__maintainAspectRatio = function (flag) {
            if (!!!(this._aspectRatio == flag)) {
                this._aspectRatio = flag;
                if (this._aspectRatio && !this._autoSize) {
                    this.startAutoResize();
                }
            }
            return this.__get__maintainAspectRatio();
            <stack?>;
        };
    $r2.__get__autoRewind = function () {
            return this._autoRewind;
        };
    $r2.__set__autoRewind = function (flag) {
            this._autoRewind = flag;
            return this.__get__autoRewind();
            <stack?>;
        };
    $r2.__get__playheadTime = function () {
            $r2 = (!((this._ns == null) || (this._ns == undefined))) ? this._ns.time : this._currentPos;
            if (!!!(this._metadata.audiodelay == undefined)) {
                $r2 = $r2 - this._metadata.audiodelay;
                if ($r2 < 0) {
                    $r2 = 0;
                }
            }
            return $r2;
        };
    $r2.__set__playheadTime = function (position) {
            this.seek(position);
            return this.__get__playheadTime();
            <stack?>;
        };
    $r2.__get__url = function () {
            return this._contentPath;
        };
    $r2.__get__volume = function () {
            return this._volume;
        };
    $r2.__set__volume = function (aVol) {
            this._volume = aVol;
            if (!this._hiddenForResize) {
                this._sound.setVolume(this._volume);
            }
            return this.__get__volume();
            <stack?>;
        };
    $r2.__get__transform = function () {
            return this._sound.getTransform();
        };
    $r2.__set__transform = function (s) {
            this._sound.setTransform(s);
            return this.__get__transform();
            <stack?>;
        };
    $r2.__get__isRTMP = function () {
            if ((this._ncMgr == null) || (this._ncMgr == undefined)) {
                return;
            }
            return this._ncMgr.isRTMP();
        };
    $r2.__get__isLive = function () {
            return this._isLive;
        };
    $r2.__get__state = function () {
            return this._state;
        };
    $r2.__get__stateResponsive = function () {
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.DISCONNECTED)) {
                if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                    if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                        if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                            if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                            } else {
                                return true;
                            }
                        } else {
                            return true;
                        }
                    } else {
                        return true;
                    }
                } else {
                    return true;
                }
            } else {
                return true;
            }
            return false;
        };
    $r2.__get__bytesLoaded = function () {
            if (((this._ns == null) || (this._ns == undefined)) || this._ncMgr.isRTMP()) {
                return -1;
            }
            return this._ns.bytesLoaded;
        };
    $r2.__get__bytesTotal = function () {
            if (((this._ns == null) || (this._ns == undefined)) || this._ncMgr.isRTMP()) {
                return -1;
            }
            return this._ns.bytesTotal;
        };
    $r2.__get__totalTime = function () {
            return this._streamLength;
        };
    $r2.__get__bufferTime = function () {
            return this._bufferTime;
        };
    $r2.__set__bufferTime = function (aTime) {
            this._bufferTime = aTime;
            if (!(this._ns == null) && !(this._ns == undefined)) {
                this._ns.setBufferTime(this._bufferTime);
            }
            return this.__get__bufferTime();
            <stack?>;
        };
    $r2.__get__idleTimeout = function () {
            return this._idleTimeoutInterval;
        };
    $r2.__set__idleTimeout = function (aTime) {
            this._idleTimeoutInterval = aTime;
            if (this._idleTimeoutIntervalID > 0) {
                clearInterval(this._idleTimeoutIntervalID);
                this._idleTimeoutIntervalID = setInterval(this, "doIdleTimeout", this._idleTimeoutInterval);
            }
            return this.__get__idleTimeout();
            <stack?>;
        };
    $r2.__get__playheadUpdateInterval = function () {
            return this._updateTimeInterval;
        };
    $r2.__set__playheadUpdateInterval = function (aTime) {
            this._updateTimeInterval = aTime;
            if (this._updateTimeIntervalID > 0) {
                clearInterval(this._updateTimeIntervalID);
                this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
            }
            return this.__get__playheadUpdateInterval();
            <stack?>;
        };
    $r2.__get__progressInterval = function () {
            return this._updateProgressInterval;
        };
    $r2.__set__progressInterval = function (aTime) {
            this._updateProgressInterval = aTime;
            if (this._updateProgressIntervalID > 0) {
                clearInterval(this._updateProgressIntervalID);
                this._updateProgressIntervalID = setInterval(this, "doUpdateProgress", this._updateProgressInterval);
            }
            return this.__get__progressInterval();
            <stack?>;
        };
    $r2.__get__ncMgr = function () {
            if ((this._ncMgr == null) || (this._ncMgr == undefined)) {
                this.createINCManager();
            }
            return this._ncMgr;
        };
    $r2.__get__metadata = function () {
            return this._metadata;
        };
    $r2.doUpdateTime = function () {
            $r2 = this.__get__playheadTime();
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                    if (!($r0 === mx.video.VideoPlayer.DISCONNECTED)) {
                        if (!($r0 === mx.video.VideoPlayer.CONNECTION_ERROR)) {
                        } else {
                            clearInterval(this._updateTimeIntervalID);
                            this._updateTimeIntervalID = 0;
                            goto L00cf;
                        }
                    } else {
                        clearInterval(this._updateTimeIntervalID);
                        this._updateTimeIntervalID = 0;
                        goto L00cf;
                    }
                } else {
                    clearInterval(this._updateTimeIntervalID);
                    this._updateTimeIntervalID = 0;
                    goto L00cf;
                }
            } else {
                clearInterval(this._updateTimeIntervalID);
                this._updateTimeIntervalID = 0;
                goto L00cf;
            }
            if (!!!(this._lastUpdateTime == $r2)) {
                this.dispatchEvent({playheadTime: $r2, state: this._state, type: "playheadUpdate"});
                this._lastUpdateTime = $r2;
            }
        };
    $r2.doUpdateProgress = function () {
            if ((this._ns == null) || (this._ns == undefined)) {
                return;
            }
            if (!(this._ns.bytesTotal < 0) && !(this._ns.bytesTotal < 0)) {
                this.dispatchEvent({bytesTotal: this._ns.bytesTotal, bytesLoaded: this._ns.bytesLoaded, type: "progress"});
            }
            if (((this._state == mx.video.VideoPlayer.DISCONNECTED) || (this._state == mx.video.VideoPlayer.CONNECTION_ERROR)) || (this._ns.bytesLoaded == this._ns.bytesTotal)) {
                clearInterval(this._updateProgressIntervalID);
                this._updateProgressIntervalID = 0;
            }
        };
    $r2.rtmpOnStatus = function (info) {
            if (this._state == mx.video.VideoPlayer.CONNECTION_ERROR) {
                return;
            }
            $r0 = info.code;
            if (!($r0 === "NetStream.Play.Stop")) {
                if (!($r0 === "NetStream.Buffer.Empty")) {
                    if (!($r0 === "NetStream.Buffer.Flush")) {
                        if (!($r0 === "NetStream.Buffer.Full")) {
                            if (!($r0 === "NetStream.Pause.Notify")) {
                                if (!($r0 === "NetStream.Play.Start")) {
                                    if (!($r0 === "NetStream.Play.Reset")) {
                                        if (!($r0 === "NetStream.Seek.Notify")) {
                                            if (!($r0 === "Netstream.Play.UnpublishNotify")) {
                                                if (!($r0 === "Netstream.Play.PublishNotify")) {
                                                    if (!($r0 === "NetStream.Play.StreamNotFound")) {
                                                        if (!($r0 === "NetStream.Play.Failed")) {
                                                            if (!($r0 === "NetStream.Failed")) {
                                                                goto L0000;
                                                                if (this._startingPlay) {
                                                                    return;
                                                                }
                                                                $r0 = this._state;
                                                                if (!($r0 === mx.video.VideoPlayer.RESIZING)) {
                                                                    if (!($r0 === mx.video.VideoPlayer.LOADING)) {
                                                                        if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                                                                            if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                                                                                goto L01b0;
                                                                                if (this._hiddenForResize) {
                                                                                    this.finishAutoResize();
                                                                                }
                                                                            } else {
                                                                                goto L0294;
                                                                                if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                                                                    this._cachedPlayheadTime = this.playheadTime;
                                                                                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                                    this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                                                                                } else {
                                                                                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                                                                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                                                                        goto L028f;
                                                                                    }
                                                                                }
                                                                                goto L0294;
                                                                            }
                                                                        } else {
                                                                            goto L0294;
                                                                            if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                                                                this._cachedPlayheadTime = this.playheadTime;
                                                                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                                this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                                                                            } else {
                                                                                if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                                                                    this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                                                                    goto L028f;
                                                                                }
                                                                            }
                                                                            goto L0294;
                                                                        }
                                                                    } else {
                                                                        goto L0294;
                                                                        if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                                                            this._cachedPlayheadTime = this.playheadTime;
                                                                            clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                            this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                                                                        } else {
                                                                            if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                                                                this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                                                                goto L028f;
                                                                            }
                                                                        }
                                                                        goto L0294;
                                                                    }
                                                                } else {
                                                                    if (this._hiddenForResize) {
                                                                        this.finishAutoResize();
                                                                    }
                                                                    goto L0294;
                                                                    goto L0294;
                                                                }
                                                                if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                                                    this._cachedPlayheadTime = this.playheadTime;
                                                                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                    this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                                                                } else {
                                                                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                                                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                                                        goto L028f;
                                                                    }
                                                                }
                                                                goto L0294;
                                                                goto L0000;
                                                                $r0 = this._bufferState;
                                                                if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP)) {
                                                                    if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL)) {
                                                                        goto L034f;
                                                                        this.rtmpDoStopAtEnd(true);
                                                                    } else {
                                                                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                                                                            this.setState(mx.video.VideoPlayer.BUFFERING);
                                                                        }
                                                                        goto L0354;
                                                                        goto L0354;
                                                                    }
                                                                } else {
                                                                    this.rtmpDoStopAtEnd(true);
                                                                    goto L0354;
                                                                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                                                                        this.setState(mx.video.VideoPlayer.BUFFERING);
                                                                    }
                                                                    goto L0354;
                                                                }
                                                                goto L0354;
                                                                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                                                goto L0000;
                                                                if (this._sawSeekNotify && (this._state == mx.video.VideoPlayer.SEEKING)) {
                                                                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                                                    this.setStateFromCachedState();
                                                                    this.doUpdateTime();
                                                                }
                                                                $r0 = this._bufferState;
                                                                if (!($r0 === mx.video.VideoPlayer.BUFFER_EMPTY)) {
                                                                } else {
                                                                    if (!this._hiddenForResize) {
                                                                        if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                                                            this.setState(mx.video.VideoPlayer.PLAYING);
                                                                        } else {
                                                                            if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                                                                this._cachedState = mx.video.VideoPlayer.PLAYING;
                                                                            }
                                                                        }
                                                                    }
                                                                    this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                                                                    goto L053a;
                                                                }
                                                                goto L053a;
                                                                goto L0000;
                                                                if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                                                                    this.finishAutoResize();
                                                                }
                                                                goto L0000;
                                                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                this._rtmpDoStopAtEndIntervalID = 0;
                                                                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                                                if (this._startingPlay) {
                                                                    this._startingPlay = false;
                                                                    this._cachedPlayheadTime = this.playheadTime;
                                                                } else {
                                                                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                                                                        this.setState(mx.video.VideoPlayer.BUFFERING);
                                                                    }
                                                                }
                                                                goto L0000;
                                                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                                                this._rtmpDoStopAtEndIntervalID = 0;
                                                                if (this._state == mx.video.VideoPlayer.REWINDING) {
                                                                    clearInterval(this._rtmpDoSeekIntervalID);
                                                                    this._rtmpDoSeekIntervalID = 0;
                                                                    if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                                                        this.setStateFromCachedState();
                                                                    } else {
                                                                        this._cachedPlayheadTime = this.playheadTime;
                                                                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                                                    }
                                                                }
                                                                goto L0000;
                                                                if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                                                    this.setStateFromCachedState();
                                                                    this.doUpdateTime();
                                                                } else {
                                                                    this._sawSeekNotify = true;
                                                                    if (this._rtmpDoSeekIntervalID == 0) {
                                                                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                                                    }
                                                                }
                                                                goto L0000;
                                                                goto L0000;
                                                                goto L0000;
                                                                if (!this._ncMgr.connectAgain()) {
                                                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                                }
                                                            } else {
                                                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                                goto L0000;
                                                            }
                                                        } else {
                                                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                            goto L0000;
                                                        }
                                                    } else {
                                                        if (!this._ncMgr.connectAgain()) {
                                                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                        }
                                                        goto L0000;
                                                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                        goto L0000;
                                                    }
                                                } else {
                                                    goto L0000;
                                                    if (!this._ncMgr.connectAgain()) {
                                                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                    }
                                                    goto L0000;
                                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                    goto L0000;
                                                }
                                            } else {
                                                goto L0000;
                                                goto L0000;
                                                if (!this._ncMgr.connectAgain()) {
                                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                }
                                                goto L0000;
                                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                                goto L0000;
                                            }
                                        } else {
                                            if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                                this.setStateFromCachedState();
                                                this.doUpdateTime();
                                            } else {
                                                this._sawSeekNotify = true;
                                                if (this._rtmpDoSeekIntervalID == 0) {
                                                    this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                                }
                                            }
                                            goto L0000;
                                            goto L0000;
                                            goto L0000;
                                            if (!this._ncMgr.connectAgain()) {
                                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                            }
                                            goto L0000;
                                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                            goto L0000;
                                        }
                                    } else {
                                        clearInterval(this._rtmpDoStopAtEndIntervalID);
                                        this._rtmpDoStopAtEndIntervalID = 0;
                                        if (this._state == mx.video.VideoPlayer.REWINDING) {
                                            clearInterval(this._rtmpDoSeekIntervalID);
                                            this._rtmpDoSeekIntervalID = 0;
                                            if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                                this.setStateFromCachedState();
                                            } else {
                                                this._cachedPlayheadTime = this.playheadTime;
                                                this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                            }
                                        }
                                        goto L0000;
                                        if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                            this.setStateFromCachedState();
                                            this.doUpdateTime();
                                        } else {
                                            this._sawSeekNotify = true;
                                            if (this._rtmpDoSeekIntervalID == 0) {
                                                this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                            }
                                        }
                                        goto L0000;
                                        goto L0000;
                                        goto L0000;
                                        if (!this._ncMgr.connectAgain()) {
                                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                        }
                                        goto L0000;
                                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                        goto L0000;
                                    }
                                } else {
                                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                                    this._rtmpDoStopAtEndIntervalID = 0;
                                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                    if (this._startingPlay) {
                                        this._startingPlay = false;
                                        this._cachedPlayheadTime = this.playheadTime;
                                    } else {
                                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                                            this.setState(mx.video.VideoPlayer.BUFFERING);
                                        }
                                    }
                                    goto L0000;
                                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                                    this._rtmpDoStopAtEndIntervalID = 0;
                                    if (this._state == mx.video.VideoPlayer.REWINDING) {
                                        clearInterval(this._rtmpDoSeekIntervalID);
                                        this._rtmpDoSeekIntervalID = 0;
                                        if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                            this.setStateFromCachedState();
                                        } else {
                                            this._cachedPlayheadTime = this.playheadTime;
                                            this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                        }
                                    }
                                    goto L0000;
                                    if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                        this.setStateFromCachedState();
                                        this.doUpdateTime();
                                    } else {
                                        this._sawSeekNotify = true;
                                        if (this._rtmpDoSeekIntervalID == 0) {
                                            this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                        }
                                    }
                                    goto L0000;
                                    goto L0000;
                                    goto L0000;
                                    if (!this._ncMgr.connectAgain()) {
                                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                    }
                                    goto L0000;
                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                    goto L0000;
                                }
                            } else {
                                if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                                    this.finishAutoResize();
                                }
                                goto L0000;
                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                this._rtmpDoStopAtEndIntervalID = 0;
                                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                if (this._startingPlay) {
                                    this._startingPlay = false;
                                    this._cachedPlayheadTime = this.playheadTime;
                                } else {
                                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                                        this.setState(mx.video.VideoPlayer.BUFFERING);
                                    }
                                }
                                goto L0000;
                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                this._rtmpDoStopAtEndIntervalID = 0;
                                if (this._state == mx.video.VideoPlayer.REWINDING) {
                                    clearInterval(this._rtmpDoSeekIntervalID);
                                    this._rtmpDoSeekIntervalID = 0;
                                    if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                        this.setStateFromCachedState();
                                    } else {
                                        this._cachedPlayheadTime = this.playheadTime;
                                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                    }
                                }
                                goto L0000;
                                if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                    this.setStateFromCachedState();
                                    this.doUpdateTime();
                                } else {
                                    this._sawSeekNotify = true;
                                    if (this._rtmpDoSeekIntervalID == 0) {
                                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                    }
                                }
                                goto L0000;
                                goto L0000;
                                goto L0000;
                                if (!this._ncMgr.connectAgain()) {
                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                }
                                goto L0000;
                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                goto L0000;
                            }
                        } else {
                            if (this._sawSeekNotify && (this._state == mx.video.VideoPlayer.SEEKING)) {
                                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                this.setStateFromCachedState();
                                this.doUpdateTime();
                            }
                            $r0 = this._bufferState;
                            if (!($r0 === mx.video.VideoPlayer.BUFFER_EMPTY)) {
                            } else {
                                if (!this._hiddenForResize) {
                                    if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                        this.setState(mx.video.VideoPlayer.PLAYING);
                                    } else {
                                        if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                            this._cachedState = mx.video.VideoPlayer.PLAYING;
                                        }
                                    }
                                }
                                this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                                goto L053a;
                            }
                            goto L053a;
                            goto L0000;
                            if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                                this.finishAutoResize();
                            }
                            goto L0000;
                            clearInterval(this._rtmpDoStopAtEndIntervalID);
                            this._rtmpDoStopAtEndIntervalID = 0;
                            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                            if (this._startingPlay) {
                                this._startingPlay = false;
                                this._cachedPlayheadTime = this.playheadTime;
                            } else {
                                if (this._state == mx.video.VideoPlayer.PLAYING) {
                                    this.setState(mx.video.VideoPlayer.BUFFERING);
                                }
                            }
                            goto L0000;
                            clearInterval(this._rtmpDoStopAtEndIntervalID);
                            this._rtmpDoStopAtEndIntervalID = 0;
                            if (this._state == mx.video.VideoPlayer.REWINDING) {
                                clearInterval(this._rtmpDoSeekIntervalID);
                                this._rtmpDoSeekIntervalID = 0;
                                if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                    this.setStateFromCachedState();
                                } else {
                                    this._cachedPlayheadTime = this.playheadTime;
                                    this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                }
                            }
                            goto L0000;
                            if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                                this.setStateFromCachedState();
                                this.doUpdateTime();
                            } else {
                                this._sawSeekNotify = true;
                                if (this._rtmpDoSeekIntervalID == 0) {
                                    this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                                }
                            }
                            goto L0000;
                            goto L0000;
                            goto L0000;
                            if (!this._ncMgr.connectAgain()) {
                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                            }
                            goto L0000;
                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                            goto L0000;
                        }
                    } else {
                        if (this._sawSeekNotify && (this._state == mx.video.VideoPlayer.SEEKING)) {
                            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                            this.setStateFromCachedState();
                            this.doUpdateTime();
                        }
                        $r0 = this._bufferState;
                        if (!($r0 === mx.video.VideoPlayer.BUFFER_EMPTY)) {
                        } else {
                            if (!this._hiddenForResize) {
                                if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                    this.setState(mx.video.VideoPlayer.PLAYING);
                                } else {
                                    if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                        this._cachedState = mx.video.VideoPlayer.PLAYING;
                                    }
                                }
                            }
                            this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                            goto L053a;
                        }
                        goto L053a;
                        goto L0000;
                        if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                            this.finishAutoResize();
                        }
                        goto L0000;
                        clearInterval(this._rtmpDoStopAtEndIntervalID);
                        this._rtmpDoStopAtEndIntervalID = 0;
                        this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                        if (this._startingPlay) {
                            this._startingPlay = false;
                            this._cachedPlayheadTime = this.playheadTime;
                        } else {
                            if (this._state == mx.video.VideoPlayer.PLAYING) {
                                this.setState(mx.video.VideoPlayer.BUFFERING);
                            }
                        }
                        goto L0000;
                        clearInterval(this._rtmpDoStopAtEndIntervalID);
                        this._rtmpDoStopAtEndIntervalID = 0;
                        if (this._state == mx.video.VideoPlayer.REWINDING) {
                            clearInterval(this._rtmpDoSeekIntervalID);
                            this._rtmpDoSeekIntervalID = 0;
                            if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                                this.setStateFromCachedState();
                            } else {
                                this._cachedPlayheadTime = this.playheadTime;
                                this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                            }
                        }
                        goto L0000;
                        if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                            this.setStateFromCachedState();
                            this.doUpdateTime();
                        } else {
                            this._sawSeekNotify = true;
                            if (this._rtmpDoSeekIntervalID == 0) {
                                this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                            }
                        }
                        goto L0000;
                        goto L0000;
                        goto L0000;
                        if (!this._ncMgr.connectAgain()) {
                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                        }
                        goto L0000;
                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                        goto L0000;
                    }
                } else {
                    $r0 = this._bufferState;
                    if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP)) {
                        if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL)) {
                            goto L034f;
                            this.rtmpDoStopAtEnd(true);
                        } else {
                            if (this._state == mx.video.VideoPlayer.PLAYING) {
                                this.setState(mx.video.VideoPlayer.BUFFERING);
                            }
                            goto L0354;
                            goto L0354;
                        }
                    } else {
                        this.rtmpDoStopAtEnd(true);
                        goto L0354;
                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                            this.setState(mx.video.VideoPlayer.BUFFERING);
                        }
                        goto L0354;
                    }
                    goto L0354;
                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                    goto L0000;
                    if (this._sawSeekNotify && (this._state == mx.video.VideoPlayer.SEEKING)) {
                        this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                        this.setStateFromCachedState();
                        this.doUpdateTime();
                    }
                    $r0 = this._bufferState;
                    if (!($r0 === mx.video.VideoPlayer.BUFFER_EMPTY)) {
                    } else {
                        if (!this._hiddenForResize) {
                            if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                this.setState(mx.video.VideoPlayer.PLAYING);
                            } else {
                                if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                    this._cachedState = mx.video.VideoPlayer.PLAYING;
                                }
                            }
                        }
                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                        goto L053a;
                    }
                    goto L053a;
                    goto L0000;
                    if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                        this.finishAutoResize();
                    }
                    goto L0000;
                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                    this._rtmpDoStopAtEndIntervalID = 0;
                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                    if (this._startingPlay) {
                        this._startingPlay = false;
                        this._cachedPlayheadTime = this.playheadTime;
                    } else {
                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                            this.setState(mx.video.VideoPlayer.BUFFERING);
                        }
                    }
                    goto L0000;
                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                    this._rtmpDoStopAtEndIntervalID = 0;
                    if (this._state == mx.video.VideoPlayer.REWINDING) {
                        clearInterval(this._rtmpDoSeekIntervalID);
                        this._rtmpDoSeekIntervalID = 0;
                        if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                            this.setStateFromCachedState();
                        } else {
                            this._cachedPlayheadTime = this.playheadTime;
                            this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                        }
                    }
                    goto L0000;
                    if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                        this.setStateFromCachedState();
                        this.doUpdateTime();
                    } else {
                        this._sawSeekNotify = true;
                        if (this._rtmpDoSeekIntervalID == 0) {
                            this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                        }
                    }
                    goto L0000;
                    goto L0000;
                    goto L0000;
                    if (!this._ncMgr.connectAgain()) {
                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                    }
                    goto L0000;
                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                    goto L0000;
                }
            } else {
                if (this._startingPlay) {
                    return;
                }
                $r0 = this._state;
                if (!($r0 === mx.video.VideoPlayer.RESIZING)) {
                    if (!($r0 === mx.video.VideoPlayer.LOADING)) {
                        if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                            if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                                goto L01b0;
                                if (this._hiddenForResize) {
                                    this.finishAutoResize();
                                }
                            } else {
                                goto L0294;
                                if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                    this._cachedPlayheadTime = this.playheadTime;
                                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                                    this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                                } else {
                                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                        goto L028f;
                                    }
                                }
                                goto L0294;
                            }
                        } else {
                            goto L0294;
                            if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                                this._cachedPlayheadTime = this.playheadTime;
                                clearInterval(this._rtmpDoStopAtEndIntervalID);
                                this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                            } else {
                                if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                    this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                    goto L028f;
                                }
                            }
                            goto L0294;
                        }
                    } else {
                        goto L0294;
                        if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                            this._cachedPlayheadTime = this.playheadTime;
                            clearInterval(this._rtmpDoStopAtEndIntervalID);
                            this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                        } else {
                            if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                                this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                                goto L028f;
                            }
                        }
                        goto L0294;
                    }
                } else {
                    if (this._hiddenForResize) {
                        this.finishAutoResize();
                    }
                    goto L0294;
                    goto L0294;
                }
                if ((this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) || !(this._bufferTime > 0.1)) {
                    this._cachedPlayheadTime = this.playheadTime;
                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                    this._rtmpDoStopAtEndIntervalID = setInterval(this, "rtmpDoStopAtEnd", mx.video.VideoPlayer.RTMP_DO_STOP_AT_END_INTERVAL);
                } else {
                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_FULL) {
                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP;
                        goto L028f;
                    }
                }
                goto L0294;
                goto L0000;
                $r0 = this._bufferState;
                if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL_SAW_PLAY_STOP)) {
                    if (!($r0 === mx.video.VideoPlayer.BUFFER_FULL)) {
                        goto L034f;
                        this.rtmpDoStopAtEnd(true);
                    } else {
                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                            this.setState(mx.video.VideoPlayer.BUFFERING);
                        }
                        goto L0354;
                        goto L0354;
                    }
                } else {
                    this.rtmpDoStopAtEnd(true);
                    goto L0354;
                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                    }
                    goto L0354;
                }
                goto L0354;
                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                goto L0000;
                if (this._sawSeekNotify && (this._state == mx.video.VideoPlayer.SEEKING)) {
                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                    this.setStateFromCachedState();
                    this.doUpdateTime();
                }
                $r0 = this._bufferState;
                if (!($r0 === mx.video.VideoPlayer.BUFFER_EMPTY)) {
                } else {
                    if (!this._hiddenForResize) {
                        if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                            this.setState(mx.video.VideoPlayer.PLAYING);
                        } else {
                            if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                this._cachedState = mx.video.VideoPlayer.PLAYING;
                            }
                        }
                    }
                    this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                    goto L053a;
                }
                goto L053a;
                goto L0000;
                if ((this._state == mx.video.VideoPlayer.RESIZING) && this._hiddenForResize) {
                    this.finishAutoResize();
                }
                goto L0000;
                clearInterval(this._rtmpDoStopAtEndIntervalID);
                this._rtmpDoStopAtEndIntervalID = 0;
                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                if (this._startingPlay) {
                    this._startingPlay = false;
                    this._cachedPlayheadTime = this.playheadTime;
                } else {
                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                    }
                }
                goto L0000;
                clearInterval(this._rtmpDoStopAtEndIntervalID);
                this._rtmpDoStopAtEndIntervalID = 0;
                if (this._state == mx.video.VideoPlayer.REWINDING) {
                    clearInterval(this._rtmpDoSeekIntervalID);
                    this._rtmpDoSeekIntervalID = 0;
                    if ((this.__get__playheadTime() == 0) || (this.__get__playheadTime() < this._cachedPlayheadTime)) {
                        this.setStateFromCachedState();
                    } else {
                        this._cachedPlayheadTime = this.playheadTime;
                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                    }
                }
                goto L0000;
                if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                    this.setStateFromCachedState();
                    this.doUpdateTime();
                } else {
                    this._sawSeekNotify = true;
                    if (this._rtmpDoSeekIntervalID == 0) {
                        this._rtmpDoSeekIntervalID = setInterval(this, "rtmpDoSeek", mx.video.VideoPlayer.RTMP_DO_SEEK_INTERVAL);
                    }
                }
                goto L0000;
                goto L0000;
                goto L0000;
                if (!this._ncMgr.connectAgain()) {
                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                }
                goto L0000;
                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                goto L0000;
            }
        };
    $r2.httpOnStatus = function (info) {
            $r0 = info.code;
            if (!($r0 === "NetStream.Play.Stop")) {
                if (!($r0 === "NetStream.Seek.InvalidTime")) {
                    if (!($r0 === "NetStream.Buffer.Empty")) {
                        if (!($r0 === "NetStream.Buffer.Full")) {
                            if (!($r0 === "NetStream.Buffer.Flush")) {
                                if (!($r0 === "NetStream.Seek.Notify")) {
                                    if (!($r0 === "NetStream.Play.StreamNotFound")) {
                                        goto L0000;
                                        clearInterval(this._delayedBufferingIntervalID);
                                        this._delayedBufferingIntervalID = 0;
                                        if (this._invalidSeekTime) {
                                            this._invalidSeekTime = false;
                                            this._invalidSeekRecovery = true;
                                            this.setState(this._cachedState);
                                            this.seek(this.__get__playheadTime());
                                        } else {
                                            $r0 = this._state;
                                            if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                                                if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                                                    if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                                                    } else {
                                                        this.httpDoStopAtEnd();
                                                        goto L0171;
                                                    }
                                                } else {
                                                    this.httpDoStopAtEnd();
                                                    goto L0171;
                                                }
                                            } else {
                                                this.httpDoStopAtEnd();
                                                goto L0171;
                                            }
                                        }
                                        goto L0000;
                                        if (this._invalidSeekRecovery) {
                                            this._invalidSeekTime = false;
                                            this._invalidSeekRecovery = false;
                                            this.setState(this._cachedState);
                                            this.seek(0);
                                        } else {
                                            this._invalidSeekTime = true;
                                        }
                                        goto L0000;
                                        this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                                            clearInterval(this._delayedBufferingIntervalID);
                                            this._delayedBufferingIntervalID = setInterval(this, "doDelayedBuffering", this._delayedBufferingInterval);
                                        }
                                        goto L0000;
                                        clearInterval(this._delayedBufferingIntervalID);
                                        this._delayedBufferingIntervalID = 0;
                                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                                        if (!this._hiddenForResize) {
                                            if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                                this.setState(mx.video.VideoPlayer.PLAYING);
                                            } else {
                                                if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                                    this._cachedState = mx.video.VideoPlayer.PLAYING;
                                                }
                                            }
                                        }
                                        goto L0000;
                                        this._invalidSeekRecovery = false;
                                        $r0 = this._state;
                                        if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                                            if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                                            } else {
                                                if (this._httpDoSeekIntervalID == 0) {
                                                    this._httpDoSeekCount = 0;
                                                    this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                                }
                                                goto L0445;
                                            }
                                        } else {
                                            if (this._httpDoSeekIntervalID == 0) {
                                                this._httpDoSeekCount = 0;
                                                this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                            }
                                            goto L0445;
                                        }
                                    } else {
                                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                        goto L0000;
                                    }
                                } else {
                                    this._invalidSeekRecovery = false;
                                    $r0 = this._state;
                                    if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                                        if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                                        } else {
                                            if (this._httpDoSeekIntervalID == 0) {
                                                this._httpDoSeekCount = 0;
                                                this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                            }
                                            goto L0445;
                                        }
                                    } else {
                                        if (this._httpDoSeekIntervalID == 0) {
                                            this._httpDoSeekCount = 0;
                                            this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                        }
                                        goto L0445;
                                    }
                                    goto L0000;
                                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                    goto L0000;
                                }
                            } else {
                                clearInterval(this._delayedBufferingIntervalID);
                                this._delayedBufferingIntervalID = 0;
                                this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                                if (!this._hiddenForResize) {
                                    if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                        this.setState(mx.video.VideoPlayer.PLAYING);
                                    } else {
                                        if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                            this._cachedState = mx.video.VideoPlayer.PLAYING;
                                        }
                                    }
                                }
                                goto L0000;
                                this._invalidSeekRecovery = false;
                                $r0 = this._state;
                                if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                                    if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                                    } else {
                                        if (this._httpDoSeekIntervalID == 0) {
                                            this._httpDoSeekCount = 0;
                                            this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                        }
                                        goto L0445;
                                    }
                                } else {
                                    if (this._httpDoSeekIntervalID == 0) {
                                        this._httpDoSeekCount = 0;
                                        this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                    }
                                    goto L0445;
                                }
                                goto L0000;
                                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                                goto L0000;
                            }
                        } else {
                            clearInterval(this._delayedBufferingIntervalID);
                            this._delayedBufferingIntervalID = 0;
                            this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                            if (!this._hiddenForResize) {
                                if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                    this.setState(mx.video.VideoPlayer.PLAYING);
                                } else {
                                    if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                        this._cachedState = mx.video.VideoPlayer.PLAYING;
                                    }
                                }
                            }
                            goto L0000;
                            this._invalidSeekRecovery = false;
                            $r0 = this._state;
                            if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                                if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                                } else {
                                    if (this._httpDoSeekIntervalID == 0) {
                                        this._httpDoSeekCount = 0;
                                        this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                    }
                                    goto L0445;
                                }
                            } else {
                                if (this._httpDoSeekIntervalID == 0) {
                                    this._httpDoSeekCount = 0;
                                    this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                }
                                goto L0445;
                            }
                            goto L0000;
                            this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                            goto L0000;
                        }
                    } else {
                        this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                        if (this._state == mx.video.VideoPlayer.PLAYING) {
                            clearInterval(this._delayedBufferingIntervalID);
                            this._delayedBufferingIntervalID = setInterval(this, "doDelayedBuffering", this._delayedBufferingInterval);
                        }
                        goto L0000;
                        clearInterval(this._delayedBufferingIntervalID);
                        this._delayedBufferingIntervalID = 0;
                        this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                        if (!this._hiddenForResize) {
                            if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                                this.setState(mx.video.VideoPlayer.PLAYING);
                            } else {
                                if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                    this._cachedState = mx.video.VideoPlayer.PLAYING;
                                }
                            }
                        }
                        goto L0000;
                        this._invalidSeekRecovery = false;
                        $r0 = this._state;
                        if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                            if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                            } else {
                                if (this._httpDoSeekIntervalID == 0) {
                                    this._httpDoSeekCount = 0;
                                    this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                                }
                                goto L0445;
                            }
                        } else {
                            if (this._httpDoSeekIntervalID == 0) {
                                this._httpDoSeekCount = 0;
                                this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                            }
                            goto L0445;
                        }
                        goto L0000;
                        this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                        goto L0000;
                    }
                } else {
                    if (this._invalidSeekRecovery) {
                        this._invalidSeekTime = false;
                        this._invalidSeekRecovery = false;
                        this.setState(this._cachedState);
                        this.seek(0);
                    } else {
                        this._invalidSeekTime = true;
                    }
                    goto L0000;
                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                    if (this._state == mx.video.VideoPlayer.PLAYING) {
                        clearInterval(this._delayedBufferingIntervalID);
                        this._delayedBufferingIntervalID = setInterval(this, "doDelayedBuffering", this._delayedBufferingInterval);
                    }
                    goto L0000;
                    clearInterval(this._delayedBufferingIntervalID);
                    this._delayedBufferingIntervalID = 0;
                    this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                    if (!this._hiddenForResize) {
                        if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                            this.setState(mx.video.VideoPlayer.PLAYING);
                        } else {
                            if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                                this._cachedState = mx.video.VideoPlayer.PLAYING;
                            }
                        }
                    }
                    goto L0000;
                    this._invalidSeekRecovery = false;
                    $r0 = this._state;
                    if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                        if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                        } else {
                            if (this._httpDoSeekIntervalID == 0) {
                                this._httpDoSeekCount = 0;
                                this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                            }
                            goto L0445;
                        }
                    } else {
                        if (this._httpDoSeekIntervalID == 0) {
                            this._httpDoSeekCount = 0;
                            this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                        }
                        goto L0445;
                    }
                    goto L0000;
                    this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                    goto L0000;
                }
            } else {
                clearInterval(this._delayedBufferingIntervalID);
                this._delayedBufferingIntervalID = 0;
                if (this._invalidSeekTime) {
                    this._invalidSeekTime = false;
                    this._invalidSeekRecovery = true;
                    this.setState(this._cachedState);
                    this.seek(this.__get__playheadTime());
                } else {
                    $r0 = this._state;
                    if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                        if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                            if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                            } else {
                                this.httpDoStopAtEnd();
                                goto L0171;
                            }
                        } else {
                            this.httpDoStopAtEnd();
                            goto L0171;
                        }
                    } else {
                        this.httpDoStopAtEnd();
                        goto L0171;
                    }
                }
                goto L0000;
                if (this._invalidSeekRecovery) {
                    this._invalidSeekTime = false;
                    this._invalidSeekRecovery = false;
                    this.setState(this._cachedState);
                    this.seek(0);
                } else {
                    this._invalidSeekTime = true;
                }
                goto L0000;
                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                if (this._state == mx.video.VideoPlayer.PLAYING) {
                    clearInterval(this._delayedBufferingIntervalID);
                    this._delayedBufferingIntervalID = setInterval(this, "doDelayedBuffering", this._delayedBufferingInterval);
                }
                goto L0000;
                clearInterval(this._delayedBufferingIntervalID);
                this._delayedBufferingIntervalID = 0;
                this._bufferState = mx.video.VideoPlayer.BUFFER_FULL;
                if (!this._hiddenForResize) {
                    if (((this._state == mx.video.VideoPlayer.LOADING) && (this._cachedState == mx.video.VideoPlayer.PLAYING)) || (this._state == mx.video.VideoPlayer.BUFFERING)) {
                        this.setState(mx.video.VideoPlayer.PLAYING);
                    } else {
                        if (this._cachedState == mx.video.VideoPlayer.BUFFERING) {
                            this._cachedState = mx.video.VideoPlayer.PLAYING;
                        }
                    }
                }
                goto L0000;
                this._invalidSeekRecovery = false;
                $r0 = this._state;
                if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                    if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                    } else {
                        if (this._httpDoSeekIntervalID == 0) {
                            this._httpDoSeekCount = 0;
                            this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                        }
                        goto L0445;
                    }
                } else {
                    if (this._httpDoSeekIntervalID == 0) {
                        this._httpDoSeekCount = 0;
                        this._httpDoSeekIntervalID = setInterval(this, "httpDoSeek", mx.video.VideoPlayer.HTTP_DO_SEEK_INTERVAL);
                    }
                    goto L0445;
                }
                goto L0000;
                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
                goto L0000;
            }
        };
    $r2.ncConnected = function () {
            if ((((this._ncMgr == null) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
            } else {
                this._createStream();
                this._setUpStream();
            }
        };
    $r2.ncReconnected = function () {
            if ((((this._ncMgr == null) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) {
                this.setState(mx.video.VideoPlayer.CONNECTION_ERROR);
            } else {
                this._ns = null;
                this._state = mx.video.VideoPlayer.STOPPED;
                this.execQueuedCmds();
            }
        };
    $r2.onMetaData = function (info) {
            if (!!!(this._metadata == null)) {
                return;
            }
            this._metadata = info;
            if (((this._streamLength == undefined) || (this._streamLength == null)) || !(this._streamLength > 0)) {
                this._streamLength = info.duration;
            }
            if (isNaN(this._videoWidth) || !(this._videoWidth > 0)) {
                this._videoWidth = info.width;
            }
            if (isNaN(this._videoHeight) || !(this._videoHeight > 0)) {
                this._videoHeight = info.height;
            }
            this.dispatchEvent({info: info, type: "metadataReceived"});
        };
    $r2.onCuePoint = function (info) {
            if (!this._hiddenForResize || (!isNaN(this._hiddenRewindPlayheadTime) && (this.__get__playheadTime() < this._hiddenRewindPlayheadTime))) {
                this.dispatchEvent({info: info, type: "cuePoint"});
            }
        };
    $r2.setState = function (s) {
            if (s == this._state) {
                return;
            }
            this._hiddenRewindPlayheadTime = undefined;
            this._cachedState = this._state;
            this._cachedPlayheadTime = this.playheadTime;
            this._state = s;
            $r2 = this._state;
            this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "stateChange"});
            if (!this._readyDispatched) {
                $r0 = $r2;
                if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                    if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                        if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                            if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                            } else {
                                this._readyDispatched = true;
                                this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "ready"});
                                goto L015e;
                            }
                        } else {
                            this._readyDispatched = true;
                            this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "ready"});
                            goto L015e;
                        }
                    } else {
                        this._readyDispatched = true;
                        this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "ready"});
                        goto L015e;
                    }
                } else {
                    this._readyDispatched = true;
                    this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "ready"});
                    goto L015e;
                }
            }
            if (!(this._cachedState === mx.video.VideoPlayer.REWINDING)) {
            } else {
                this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: $r2, type: "rewind"});
                if (this._ncMgr.isRTMP() && ($r2 == mx.video.VideoPlayer.STOPPED)) {
                    this.closeNS();
                }
                goto L0212;
            }
            $r0 = $r2;
            if (!($r0 === mx.video.VideoPlayer.STOPPED)) {
                if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                    if (!($r0 === mx.video.VideoPlayer.SEEKING)) {
                        if (!($r0 === mx.video.VideoPlayer.REWINDING)) {
                            if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                                if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                                    if (!($r0 === mx.video.VideoPlayer.LOADING)) {
                                        if (!($r0 === mx.video.VideoPlayer.RESIZING)) {
                                            goto L03f7;
                                            if (this._ncMgr.isRTMP() && (this._idleTimeoutIntervalID == 0)) {
                                                this._idleTimeoutIntervalID = setInterval(this, "doIdleTimeout", this._idleTimeoutInterval);
                                            }
                                            goto L03f7;
                                            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                                            if (this._updateTimeIntervalID == 0) {
                                                this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                            if (this._updateTimeIntervalID == 0) {
                                this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
                            }
                            clearInterval(this._idleTimeoutIntervalID);
                            this._idleTimeoutIntervalID = 0;
                            goto L03f7;
                        }
                    } else {
                        this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                        if (this._updateTimeIntervalID == 0) {
                            this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
                        }
                        clearInterval(this._idleTimeoutIntervalID);
                        this._idleTimeoutIntervalID = 0;
                        goto L03f7;
                    }
                } else {
                    if (this._ncMgr.isRTMP() && (this._idleTimeoutIntervalID == 0)) {
                        this._idleTimeoutIntervalID = setInterval(this, "doIdleTimeout", this._idleTimeoutInterval);
                    }
                    goto L03f7;
                    this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                    if (this._updateTimeIntervalID == 0) {
                        this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
                    }
                    clearInterval(this._idleTimeoutIntervalID);
                    this._idleTimeoutIntervalID = 0;
                    goto L03f7;
                }
            } else {
                if (this._ncMgr.isRTMP() && (this._idleTimeoutIntervalID == 0)) {
                    this._idleTimeoutIntervalID = setInterval(this, "doIdleTimeout", this._idleTimeoutInterval);
                }
                goto L03f7;
                this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
                if (this._updateTimeIntervalID == 0) {
                    this._updateTimeIntervalID = setInterval(this, "doUpdateTime", this._updateTimeInterval);
                }
                clearInterval(this._idleTimeoutIntervalID);
                this._idleTimeoutIntervalID = 0;
                goto L03f7;
            }
            this.execQueuedCmds();
        };
    $r2.setStateFromCachedState = function () {
            $r0 = this._cachedState;
            if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                if (!($r0 === mx.video.VideoPlayer.PAUSED)) {
                    if (!($r0 === mx.video.VideoPlayer.BUFFERING)) {
                        goto L00f7;
                        this.setState(this._cachedState);
                    } else {
                        if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                            this.setState(mx.video.VideoPlayer.BUFFERING);
                        } else {
                            this.setState(this._cachedState);
                        }
                        goto L0000;
                        this.setState(mx.video.VideoPlayer.STOPPED);
                        goto L0000;
                    }
                } else {
                    this.setState(this._cachedState);
                    goto L0000;
                    if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                    } else {
                        this.setState(this._cachedState);
                    }
                    goto L0000;
                }
            } else {
                this.setState(this._cachedState);
                goto L0000;
                if (this._bufferState == mx.video.VideoPlayer.BUFFER_EMPTY) {
                    this.setState(mx.video.VideoPlayer.BUFFERING);
                } else {
                    this.setState(this._cachedState);
                }
                goto L0000;
            }
            this.setState(mx.video.VideoPlayer.STOPPED);
            goto L0000;
        };
    $r2.createINCManager = function () {
            if ((this.ncMgrClassName == null) || (this.ncMgrClassName == undefined)) {
                this.ncMgrClassName = mx.video.VideoPlayer.DEFAULT_INCMANAGER;
            }
            var ncMgrConstructor = eval(this.ncMgrClassName);
            this._ncMgr = new ncMgrConstructor();
            this._ncMgr.setVideoPlayer(this);
        };
    $r2.rtmpDoStopAtEnd = function (force) {
            if (this._rtmpDoStopAtEndIntervalID > 0) {
                $r0 = this._state;
                if (!($r0 === mx.video.VideoPlayer.DISCONNECTED)) {
                    if (!($r0 === mx.video.VideoPlayer.CONNECTION_ERROR)) {
                    } else {
                        clearInterval(this._rtmpDoStopAtEndIntervalID);
                        this._rtmpDoStopAtEndIntervalID = 0;
                        return;
                    }
                } else {
                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                    this._rtmpDoStopAtEndIntervalID = 0;
                    return;
                }
                if (force || (this._cachedPlayheadTime == this.__get__playheadTime())) {
                    clearInterval(this._rtmpDoStopAtEndIntervalID);
                    this._rtmpDoStopAtEndIntervalID = 0;
                } else {
                    this._cachedPlayheadTime = this.playheadTime;
                    return;
                }
            }
            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
            this._atEnd = true;
            this.setState(mx.video.VideoPlayer.STOPPED);
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            this.doUpdateTime();
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: this._state, type: "complete"});
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            if ((this._autoRewind && !this._isLive) && !(this.__get__playheadTime() == 0)) {
                this._atEnd = false;
                this._currentPos = 0;
                this._play(0, 0);
                this.setState(mx.video.VideoPlayer.REWINDING);
            } else {
                this.closeNS();
            }
        };
    $r2.rtmpDoSeek = function () {
            if (!(this._state == mx.video.VideoPlayer.REWINDING) && !(this._state == mx.video.VideoPlayer.SEEKING)) {
                clearInterval(this._rtmpDoSeekIntervalID);
                this._rtmpDoSeekIntervalID = 0;
                this._sawSeekNotify = false;
            } else {
                if (!!!(this.__get__playheadTime() == this._cachedPlayheadTime)) {
                    clearInterval(this._rtmpDoSeekIntervalID);
                    this._rtmpDoSeekIntervalID = 0;
                    this._sawSeekNotify = false;
                    this.setStateFromCachedState();
                    this.doUpdateTime();
                }
            }
        };
    $r2.httpDoStopAtEnd = function () {
            this._atEnd = true;
            if (((this._streamLength == undefined) || (this._streamLength == null)) || !(this._streamLength > 0)) {
                this._streamLength = this._ns.time;
            }
            this._pause(true);
            this.setState(mx.video.VideoPlayer.STOPPED);
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            this.doUpdateTime();
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            this.dispatchEvent({playheadTime: this.__get__playheadTime(), state: this._state, type: "complete"});
            if (!!!(this._state == mx.video.VideoPlayer.STOPPED)) {
                return;
            }
            if (this._autoRewind) {
                this._atEnd = false;
                this._pause(true);
                this._seek(0);
                this.setState(mx.video.VideoPlayer.REWINDING);
            }
        };
    $r2.httpDoSeek = function () {
            $r2 = (this._state == mx.video.VideoPlayer.REWINDING) || (this._state == mx.video.VideoPlayer.SEEKING);
            if (($r2 && (this._httpDoSeekCount < mx.video.VideoPlayer.HTTP_DO_SEEK_MAX_COUNT)) && ((this._cachedPlayheadTime == this.__get__playheadTime()) || this._invalidSeekTime)) {
                this._httpDoSeekCount = this._httpDoSeekCount + 1;
                return;
            }
            this._httpDoSeekCount = 0;
            clearInterval(this._httpDoSeekIntervalID);
            this._httpDoSeekIntervalID = 0;
            if (!$r2) {
                return;
            }
            this.setStateFromCachedState();
            if (this._invalidSeekTime) {
                this._invalidSeekTime = false;
                this._invalidSeekRecovery = true;
                this.seek(this.__get__playheadTime());
            } else {
                this.doUpdateTime();
            }
        };
    $r2.closeNS = function (updateCurrentPos) {
            if (!(this._ns == null) && !(this._ns == undefined)) {
                if (updateCurrentPos) {
                    clearInterval(this._updateTimeIntervalID);
                    this._updateTimeIntervalID = 0;
                    this.doUpdateTime();
                    this._currentPos = this._ns.time;
                }
                delete this._ns.onStatus;
                this._ns.onStatus = null;
                this._ns.close();
                this._ns = null;
            }
        };
    $r2.doDelayedBuffering = function () {
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.LOADING)) {
                if (!($r0 === mx.video.VideoPlayer.RESIZING)) {
                    if (!($r0 === mx.video.VideoPlayer.PLAYING)) {
                        goto L00c4;
                    } else {
                        clearInterval(this._delayedBufferingIntervalID);
                        this._delayedBufferingIntervalID = 0;
                        this.setState(mx.video.VideoPlayer.BUFFERING);
                        goto L0000;
                        clearInterval(this._delayedBufferingIntervalID);
                        this._delayedBufferingIntervalID = 0;
                        goto L0000;
                    }
                } else {
                    goto L0000;
                    clearInterval(this._delayedBufferingIntervalID);
                    this._delayedBufferingIntervalID = 0;
                    this.setState(mx.video.VideoPlayer.BUFFERING);
                    goto L0000;
                }
            } else {
                goto L0000;
                clearInterval(this._delayedBufferingIntervalID);
                this._delayedBufferingIntervalID = 0;
                this.setState(mx.video.VideoPlayer.BUFFERING);
                goto L0000;
            }
            clearInterval(this._delayedBufferingIntervalID);
            this._delayedBufferingIntervalID = 0;
            goto L0000;
        };
    $r2._pause = function (doPause) {
            this._ns.pause(doPause);
        };
    $r2._play = function () {
            this._startingPlay = true;
            $r0 = arguments.length;
            if (!($r0 === 0)) {
                if (!($r0 === 1)) {
                    if (!($r0 === 2)) {
                        goto L016a;
                        this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? 0 : -1, -1);
                        goto L0000;
                        this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, -1);
                    } else {
                        this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, arguments[1]);
                        goto L0000;
                        throw new Error("bad args to _play");
                    }
                } else {
                    this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, -1);
                    goto L0000;
                    this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, arguments[1]);
                    goto L0000;
                    throw new Error("bad args to _play");
                }
            } else {
                this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? 0 : -1, -1);
                goto L0000;
                this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, -1);
                goto L0000;
                this._ns.play(this._ncMgr.getStreamName(), !this._isLive ? arguments[0] : -1, arguments[1]);
                goto L0000;
            }
            throw new Error("bad args to _play");
        };
    $r2._seek = function (time) {
            if (!(this._metadata.audiodelay == undefined) && ((time + this._metadata.audiodelay) < this._streamLength)) {
                time = time + this._metadata.audiodelay;
            }
            this._ns.seek(time);
            this._invalidSeekTime = false;
            this._bufferState = mx.video.VideoPlayer.BUFFER_EMPTY;
            this._sawSeekNotify = false;
        };
    $r2.isXnOK = function () {
            if (this._state == mx.video.VideoPlayer.LOADING) {
                return true;
            }
            if (this._state == mx.video.VideoPlayer.CONNECTION_ERROR) {
                return false;
            }
            if (!!!(this._state == mx.video.VideoPlayer.DISCONNECTED)) {
                if (((((this._ncMgr == null) || (this._ncMgr == undefined)) || (this._ncMgr.getNetConnection() == null)) || (this._ncMgr.getNetConnection() == undefined)) || !this._ncMgr.getNetConnection().isConnected) {
                    this.setState(mx.video.VideoPlayer.DISCONNECTED);
                    return false;
                }
                return true;
            }
            return false;
        };
    $r2.startAutoResize = function () {
            $r0 = this._state;
            if (!($r0 === mx.video.VideoPlayer.DISCONNECTED)) {
                if (!($r0 === mx.video.VideoPlayer.CONNECTION_ERROR)) {
                } else {
                    return;
                }
            } else {
                return;
            }
            this._autoResizeDone = false;
            if ((this.__get__stateResponsive() && !(this._videoWidth == undefined)) && !(this._videoHeight == undefined)) {
                this.doAutoResize();
            } else {
                clearInterval(this._autoResizeIntervalID);
                this._autoResizeIntervalID = setInterval(this, "doAutoResize", mx.video.VideoPlayer.AUTO_RESIZE_INTERVAL);
                goto L0000;
            }
        };
    $r2.doAutoResize = function () {
            if (this._autoResizeIntervalID > 0) {
                $r0 = this._state;
                if (!($r0 === mx.video.VideoPlayer.RESIZING)) {
                    if (!($r0 === mx.video.VideoPlayer.LOADING)) {
                        if (!($r0 === mx.video.VideoPlayer.DISCONNECTED)) {
                            if (!($r0 === mx.video.VideoPlayer.CONNECTION_ERROR)) {
                                goto L00d9;
                            } else {
                                clearInterval(this._autoResizeIntervalID);
                                this._autoResizeIntervalID = 0;
                                return;
                                if (!this.__get__stateResponsive()) {
                                    return;
                                }
                            }
                        } else {
                            clearInterval(this._autoResizeIntervalID);
                            this._autoResizeIntervalID = 0;
                            return;
                            if (!this.__get__stateResponsive()) {
                                return;
                            }
                        }
                    } else {
                        goto L00f6;
                        clearInterval(this._autoResizeIntervalID);
                        this._autoResizeIntervalID = 0;
                        return;
                    }
                } else {
                    goto L00f6;
                    clearInterval(this._autoResizeIntervalID);
                    this._autoResizeIntervalID = 0;
                    return;
                }
                if (!this.__get__stateResponsive()) {
                    return;
                }
                if (((!(this._video.width == this._prevVideoWidth) || !(this._video.height == this._prevVideoHeight)) || !(this._bufferState < mx.video.VideoPlayer.BUFFER_FULL)) || (this._ns.time > mx.video.VideoPlayer.AUTO_RESIZE_PLAYHEAD_TIMEOUT)) {
                    if ((this._hiddenForResize && (this._metadata == null)) && (this._hiddenForResizeMetadataDelay < mx.video.VideoPlayer.AUTO_RESIZE_METADATA_DELAY_MAX)) {
                        this._hiddenForResizeMetadataDelay = this._hiddenForResizeMetadataDelay + 1;
                        return;
                    }
                    this._videoWidth = this._video.width;
                    this._videoHeight = this._video.height;
                    clearInterval(this._autoResizeIntervalID);
                    this._autoResizeIntervalID = 0;
                } else {
                    return;
                }
            }
            if ((!this._autoSize && !this._aspectRatio) || this._autoResizeDone) {
                this.setState(this._cachedState);
                return;
            }
            this._autoResizeDone = true;
            if (this._autoSize) {
                this._video._width = this._videoWidth;
                this._video._height = this._videoHeight;
            } else {
                if (this._aspectRatio) {
                    $r3 = (this._videoWidth * this.__get__height()) / this._videoHeight;
                    $r2 = (this._videoHeight * this.__get__width()) / this._videoWidth;
                    if ($r2 < this.__get__height()) {
                        this._video._height = $r2;
                    } else {
                        if ($r3 < this.__get__width()) {
                            this._video._width = $r3;
                        }
                    }
                }
            }
            if (this._hiddenForResize) {
                this._hiddenRewindPlayheadTime = this.playheadTime;
                if (this._state == mx.video.VideoPlayer.LOADING) {
                    this._cachedState = mx.video.VideoPlayer.PLAYING;
                }
                if (!this._ncMgr.isRTMP()) {
                    this._pause(true);
                    this._seek(0);
                    clearInterval(this._finishAutoResizeIntervalID);
                    this._finishAutoResizeIntervalID = setInterval(this, "finishAutoResize", mx.video.VideoPlayer.FINISH_AUTO_RESIZE_INTERVAL);
                } else {
                    if (!this._isLive) {
                        this._currentPos = 0;
                        this._play(0, 0);
                        this.setState(mx.video.VideoPlayer.RESIZING);
                    } else {
                        if (this._autoPlay) {
                            clearInterval(this._finishAutoResizeIntervalID);
                            this._finishAutoResizeIntervalID = setInterval(this, "finishAutoResize", mx.video.VideoPlayer.FINISH_AUTO_RESIZE_INTERVAL);
                        } else {
                            this.finishAutoResize();
                        }
                    }
                }
            } else {
                this.dispatchEvent({height: this._height, width: this._width, y: this._y, x: this._x, type: "resize"});
            }
        };
    $r2.finishAutoResize = function () {
            clearInterval(this._finishAutoResizeIntervalID);
            this._finishAutoResizeIntervalID = 0;
            if (this.__get__stateResponsive()) {
                return;
            }
            this._visible = this.__visible;
            this._sound.setVolume(this._volume);
            this._hiddenForResize = false;
            this.dispatchEvent({height: this._height, width: this._width, y: this._y, x: this._x, type: "resize"});
            if (this._autoPlay) {
                if (this._ncMgr.isRTMP()) {
                    if (!this._isLive) {
                        this._currentPos = 0;
                        this._play(0);
                    }
                    if (this._state == mx.video.VideoPlayer.RESIZING) {
                        this.setState(mx.video.VideoPlayer.LOADING);
                        this._cachedState = mx.video.VideoPlayer.PLAYING;
                    }
                } else {
                    this._pause(false);
                    this._cachedState = mx.video.VideoPlayer.PLAYING;
                }
            } else {
                this.setState(mx.video.VideoPlayer.STOPPED);
            }
        };
    $r2._createStream = function () {
            this._ns = new NetStream(this._ncMgr.getNetConnection());
            this._ns.mc = this;
            if (this._ncMgr.isRTMP()) {
                this._ns.onStatus = function (info) {
                                this.mc.rtmpOnStatus(info);
                            };
            } else {
                this._ns.onStatus = function (info) {
                                this.mc.httpOnStatus(info);
                            };
            }
            this._ns.onMetaData = function (info) {
                        this.mc.onMetaData(info);
                    };
            this._ns.onCuePoint = function (info) {
                        this.mc.onCuePoint(info);
                    };
            this._ns.setBufferTime(this._bufferTime);
        };
    $r2._setUpStream = function () {
            this._video.attachVideo(this._ns);
            this.attachAudio(this._ns);
            if (!isNaN(this._ncMgr.getStreamLength()) && !(this._ncMgr.getStreamLength() < 0)) {
                this._streamLength = this._ncMgr.getStreamLength();
            }
            if (!isNaN(this._ncMgr.getStreamWidth()) && !(this._ncMgr.getStreamWidth() < 0)) {
                this._videoWidth = this._ncMgr.getStreamWidth();
            } else {
                this._videoWidth = undefined;
            }
            if (!isNaN(this._ncMgr.getStreamHeight()) && !(this._ncMgr.getStreamHeight() < 0)) {
                this._videoHeight = this._ncMgr.getStreamHeight();
            } else {
                this._videoHeight = undefined;
            }
            if (((this._autoSize || this._aspectRatio) && !(this._videoWidth == undefined)) && !(this._videoHeight == undefined)) {
                this._prevVideoWidth = undefined;
                this._prevVideoHeight = undefined;
                this.doAutoResize();
            }
            if ((!this._autoSize && !this._aspectRatio) || (!(this._videoWidth == undefined) && !(this._videoHeight == undefined))) {
                if (this._autoPlay) {
                    if (!this._ncMgr.isRTMP()) {
                        this._cachedState = mx.video.VideoPlayer.BUFFERING;
                        this._play();
                    } else {
                        if (this._isLive) {
                            this._cachedState = mx.video.VideoPlayer.BUFFERING;
                            this._play(-1);
                        } else {
                            this._cachedState = mx.video.VideoPlayer.BUFFERING;
                            this._play(0);
                        }
                    }
                } else {
                    this._cachedState = mx.video.VideoPlayer.STOPPED;
                    if (this._ncMgr.isRTMP()) {
                        this._play(0, 0);
                    } else {
                        this._play();
                        this._pause(true);
                        this._seek(0);
                    }
                }
            } else {
                this._hiddenForResize = true;
                this._hiddenForResizeMetadataDelay = 0;
                this.__visible = this._visible;
                this._visible = false;
                this._volume = this._sound.getVolume();
                this._sound.setVolume(0);
                this._play(0);
                if (this._currentPos > 0) {
                    this._seek(this._currentPos);
                    this._currentPos = 0;
                }
            }
            clearInterval(this._autoResizeIntervalID);
            this._autoResizeIntervalID = setInterval(this, "doAutoResize", mx.video.VideoPlayer.AUTO_RESIZE_INTERVAL);
        };
    $r2.doIdleTimeout = function () {
            clearInterval(this._idleTimeoutIntervalID);
            this._idleTimeoutIntervalID = 0;
            this.close();
        };
    $r2.flushQueuedCmds = function () {
            while (this._cmdQueue.length > 0) {
                this._cmdQueue.pop();
            }
        };
    $r2.execQueuedCmds = function () {
            while (true) {
                if (!(((this._cmdQueue.length > 0) && (this.__get__stateResponsive() || (this._state == mx.video.VideoPlayer.CONNECTION_ERROR))) && ((!(this._cmdQueue[0].url == null) && !(this._cmdQueue[0].url == undefined)) || (!(this._state == mx.video.VideoPlayer.DISCONNECTED) && !(this._state == mx.video.VideoPlayer.CONNECTION_ERROR))))) break;
                $r2 = this._cmdQueue.shift();
                this._cachedState = this._state;
                this._state = mx.video.VideoPlayer.EXEC_QUEUED_CMD;
                $r0 = $r2.type;
                if (!($r0 === mx.video.VideoPlayer.PLAY)) {
                    if (!($r0 === mx.video.VideoPlayer.LOAD)) {
                        if (!($r0 === mx.video.VideoPlayer.PAUSE)) {
                            if (!($r0 === mx.video.VideoPlayer.STOP)) {
                                if (!($r0 === mx.video.VideoPlayer.SEEK)) {
                                    goto L02a2;
                                    this.play($r2.url, $r2.isLive, $r2.time);
                                    goto L02a2;
                                    this.load($r2.url, $r2.isLive, $r2.time);
                                    goto L02a2;
                                    this.pause();
                                    goto L02a2;
                                    this.stop();
                                } else {
                                    this.seek($r2.time);
                                    goto L02a2;
                                }
                            } else {
                                this.stop();
                                goto L02a2;
                                this.seek($r2.time);
                                goto L02a2;
                            }
                        } else {
                            this.pause();
                            goto L02a2;
                            this.stop();
                            goto L02a2;
                            this.seek($r2.time);
                            goto L02a2;
                        }
                    } else {
                        this.load($r2.url, $r2.isLive, $r2.time);
                        goto L02a2;
                        this.pause();
                        goto L02a2;
                        this.stop();
                        goto L02a2;
                        this.seek($r2.time);
                        goto L02a2;
                    }
                } else {
                    this.play($r2.url, $r2.isLive, $r2.time);
                    goto L02a2;
                    this.load($r2.url, $r2.isLive, $r2.time);
                    goto L02a2;
                    this.pause();
                    goto L02a2;
                    this.stop();
                    goto L02a2;
                    this.seek($r2.time);
                    goto L02a2;
                }
            }
        };
    $r2.queueCmd = function (type, url, isLive, time) {
            this._cmdQueue.push({time: time, isLive: false, url: url, type: type});
        };
    $r1.version = "1.0.0.103";
    $r1.DISCONNECTED = "disconnected";
    $r1.STOPPED = "stopped";
    $r1.PLAYING = "playing";
    $r1.PAUSED = "paused";
    $r1.BUFFERING = "buffering";
    $r1.LOADING = "loading";
    $r1.CONNECTION_ERROR = "connectionError";
    $r1.REWINDING = "rewinding";
    $r1.SEEKING = "seeking";
    $r1.RESIZING = "resizing";
    $r1.EXEC_QUEUED_CMD = "execQueuedCmd";
    $r1.BUFFER_EMPTY = "bufferEmpty";
    $r1.BUFFER_FULL = "bufferFull";
    $r1.BUFFER_FULL_SAW_PLAY_STOP = "bufferFullSawPlayStop";
    $r1.DEFAULT_INCMANAGER = "mx.video.NCManager";
    $r1.DEFAULT_UPDATE_TIME_INTERVAL = 250;
    $r1.DEFAULT_UPDATE_PROGRESS_INTERVAL = 250;
    $r1.DEFAULT_IDLE_TIMEOUT_INTERVAL = 300000;
    $r1.AUTO_RESIZE_INTERVAL = 100;
    $r1.AUTO_RESIZE_PLAYHEAD_TIMEOUT = 0.5;
    $r1.AUTO_RESIZE_METADATA_DELAY_MAX = 5;
    $r1.FINISH_AUTO_RESIZE_INTERVAL = 250;
    $r1.RTMP_DO_STOP_AT_END_INTERVAL = 500;
    $r1.RTMP_DO_SEEK_INTERVAL = 100;
    $r1.HTTP_DO_SEEK_INTERVAL = 250;
    $r1.HTTP_DO_SEEK_MAX_COUNT = 4;
    $r1.CLOSE_NS_INTERVAL = 0.25;
    $r1.HTTP_DELAYED_BUFFERING_INTERVAL = 100;
    $r1.PLAY = 0;
    $r1.LOAD = 1;
    $r1.PAUSE = 2;
    $r1.STOP = 3;
    $r1.SEEK = 4;
}
ASSetPropFlags(mx.video.VideoPlayer.prototype, null, 1);
// ======== DoInitAction sprite=11 __Packages.mx.video.INCManager
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.INCManager) {
    _global.mx.video.INCManager = function () {
        };
}
<stack?>;
// ======== DoInitAction sprite=12 __Packages.mx.events.EventDispatcher
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.events) {
    _global.mx.events = new Object();
}
<stack?>;
if (!_global.mx.events.EventDispatcher) {
    $r1 = function () {
        };
    mx.events.EventDispatcher = $r1;
    $r2 = $r1.prototype;
    $r1._removeEventListener = function (queue, event, handler) {
            if (!!!(queue == undefined)) {
                $r4 = queue.length;
                $r1 = undefined;
                $r1 = 0;
                while ($r1 < $r4) {
                    $r2 = queue[$r1];
                    if ($r2 == handler) {
                        queue.splice($r1, 1);
                        return;
                    }
                    $r1 = $r1 + 1;
                }
            }
        };
    $r1.initialize = function (object) {
            if (mx.events.EventDispatcher._fEventDispatcher == undefined) {
                mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
            }
            object.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
            object.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
            object.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
            object.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
        };
    $r2.dispatchQueue = function (queueObj, eventObj) {
            $r7 = "__q_" + eventObj.type;
            $r4 = queueObj[$r7];
            if (!!!($r4 == undefined)) {
                $r5 = undefined;
                while (true) {
                    $r0 = /*enumerate*/ $r4;
                    if ($r0 == null) break;
                    $r5 = $r0;
                    $r1 = $r4[$r5];
                    $r3 = typeof $r1;
                    if (($r3 == "object") || ($r3 == "movieclip")) {
                        if (!!!($r1.handleEvent == undefined)) {
                            $r1.handleEvent(eventObj);
                        }
                        if (!!!($r1[eventObj.type] == undefined)) {
                            if (mx.events.EventDispatcher.exceptions[eventObj.type] == undefined) {
                                $r1[eventObj.type](eventObj);
                            }
                        }
                    } else {
                        $r1.apply(queueObj, [eventObj]);
                    }
                }
            }
        };
    $r2.dispatchEvent = function (eventObj) {
            if (eventObj.target == undefined) {
                eventObj.target = this;
            }
            this[eventObj.type + "Handler"](eventObj);
            this.dispatchQueue(this, eventObj);
        };
    $r2.addEventListener = function (event, handler) {
            $r3 = "__q_" + event;
            if (this[$r3] == undefined) {
                this[$r3] = new Array();
            }
            _global.ASSetPropFlags(this, $r3, 1);
            mx.events.EventDispatcher._removeEventListener(this[$r3], event, handler);
            this[$r3].push(handler);
        };
    $r2.removeEventListener = function (event, handler) {
            $r2 = "__q_" + event;
            mx.events.EventDispatcher._removeEventListener(this[$r2], event, handler);
        };
    $r1._fEventDispatcher = undefined;
    $r1.exceptions = {load: 1, draw: 1, move: 1};
}
ASSetPropFlags(mx.events.EventDispatcher.prototype, null, 1);
// ======== DoInitAction sprite=13 __Packages.mx.video.VideoError
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.VideoError) {
    $r1 = function (errCode, msg) {
            super();
            this._code = errCode;
            this.message = ((("" + errCode) + ": ") + mx.video.VideoError.ERROR_MSG[errCode - mx.video.VideoError.BASE_ERROR_CODE]) + ((!(msg == undefined)) ? (": " + msg) : "");
            this.name = "VideoError";
        };
    mx.video.VideoError = $r1;
    mx.video.VideoError.extends(Error);
    $r2 = $r1.prototype;
    $r2.__get__code = function () {
            return this._code;
        };
    $r1.version = "1.0.0.103";
    $r1.BASE_ERROR_CODE = 1000;
    $r1.NO_CONNECTION = 1000;
    $r1.NO_CUE_POINT_MATCH = 1001;
    $r1.ILLEGAL_CUE_POINT = 1002;
    $r1.INVALID_SEEK = 1003;
    $r1.INVALID_CONTENT_PATH = 1004;
    $r1.INVALID_XML = 1005;
    $r1.NO_BITRATE_MATCH = 1006;
    $r1.DELETE_DEFAULT_PLAYER = 1007;
    $r1.ERROR_MSG = ["Unable to make connection to server or to find FLV on server", "No matching cue point found", "Illegal cue point", "Invalid seek", "Invalid contentPath", "Invalid xml", "No bitrate match, must be no default flv", "Cannot delete default VideoPlayer"];
}
ASSetPropFlags(mx.video.VideoError.prototype, null, 1);
// ======== DoInitAction sprite=14 __Packages.mx.video.UIManager
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.UIManager) {
    $r1 = function (vc) {
            this._vc = vc;
            this._skin = undefined;
            this._skinAutoHide = false;
            this._skinReady = true;
            this.__visible = true;
            this._bufferingBarHides = false;
            this._controlsEnabled = true;
            this._lastScrubPos = 0;
            this._lastVolumePos = 0;
            this.cachedSoundLevel = this._vc.volume;
            this._isMuted = false;
            this.controls = new Array();
            this.customClips = undefined;
            this.skin_mc = undefined;
            this.skinLoader = undefined;
            this.layout_mc = undefined;
            this.border_mc = undefined;
            this._seekBarIntervalID = 0;
            this._seekBarInterval = mx.video.UIManager.SEEK_BAR_INTERVAL_DEFAULT;
            this._seekBarScrubTolerance = mx.video.UIManager.SEEK_BAR_SCRUB_TOLERANCE_DEFAULT;
            this._volumeBarIntervalID = 0;
            this._volumeBarInterval = mx.video.UIManager.VOLUME_BAR_INTERVAL_DEFAULT;
            this._volumeBarScrubTolerance = mx.video.UIManager.VOLUME_BAR_SCRUB_TOLERANCE_DEFAULT;
            this._bufferingDelayIntervalID = 0;
            this._bufferingDelayInterval = mx.video.UIManager.BUFFERING_DELAY_INTERVAL_DEFAULT;
            this._bufferingOn = false;
            this._skinAutoHideIntervalID = 0;
            this._vc.addEventListener("metadataReceived", this);
            this._vc.addEventListener("playheadUpdate", this);
            this._vc.addEventListener("progress", this);
            this._vc.addEventListener("stateChange", this);
            this._vc.addEventListener("ready", this);
            this._vc.addEventListener("resize", this);
            this._vc.addEventListener("volumeUpdate", this);
        };
    mx.video.UIManager = $r1;
    $r2 = $r1.prototype;
    $r2.handleEvent = function (e) {
            if (!(e.vp == undefined) && !(e.vp == this._vc.__get__visibleVideoPlayerIndex())) {
                return;
            }
            $r9 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            if (e.type == "stateChange") {
                if (e.state == mx.video.FLVPlayback.BUFFERING) {
                    if (!this._bufferingOn) {
                        clearInterval(this._bufferingDelayIntervalID);
                        this._bufferingDelayIntervalID = setInterval(this, "doBufferingDelay", this._bufferingDelayInterval);
                    }
                } else {
                    clearInterval(this._bufferingDelayIntervalID);
                    this._bufferingDelayIntervalID = 0;
                    this._bufferingOn = false;
                }
                if (e.state == mx.video.FLVPlayback.LOADING) {
                    this._progressPercent = !this._vc.getVideoPlayer(e.vp).__get__isRTMP() ? 0 : 100;
                    $r2 = mx.video.UIManager.SEEK_BAR;
                    while (!!!($r2 > mx.video.UIManager.VOLUME_BAR)) {
                        $r4 = this.controls[$r2];
                        if (!!!($r4.progress_mc == undefined)) {
                            this.positionBar($r4, "progress", this._progressPercent);
                        }
                        $r2 = $r2 + 1;
                    }
                }
                $r2 = 0;
                while ($r2 < mx.video.UIManager.NUM_CONTROLS) {
                    if (this.controls[$r2] == undefined) {
                    } else {
                        this.setEnabledAndVisibleForState($r2, e.state);
                        if ($r2 < mx.video.UIManager.NUM_BUTTONS) {
                            this.skinButtonControl(this.controls[$r2]);
                        }
                    }
                    $r2 = $r2 + 1;
                }
            } else {
                if ((e.type == "ready") || (e.type == "metadataReceived")) {
                    $r2 = 0;
                    while ($r2 < mx.video.UIManager.NUM_CONTROLS) {
                        if (this.controls[$r2] == undefined) {
                        } else {
                            this.setEnabledAndVisibleForState($r2, this._vc.__get__state());
                            if ($r2 < mx.video.UIManager.NUM_BUTTONS) {
                                this.skinButtonControl(this.controls[$r2]);
                            }
                        }
                        $r2 = $r2 + 1;
                    }
                    if (this._vc.getVideoPlayer(e.vp).__get__isRTMP()) {
                        this._progressPercent = 100;
                        $r2 = mx.video.UIManager.SEEK_BAR;
                        while (!!!($r2 > mx.video.UIManager.VOLUME_BAR)) {
                            $r4 = this.controls[$r2];
                            if (!!!($r4.progress_mc == undefined)) {
                                this.positionBar($r4, "progress", this._progressPercent);
                            }
                            $r2 = $r2 + 1;
                        }
                    }
                } else {
                    if (e.type == "resize") {
                        this.layoutSkin();
                        this.setupSkinAutoHide();
                    } else {
                        if (e.type == "volumeUpdate") {
                            if (this._isMuted && (e.volume > 0)) {
                                this._isMuted = false;
                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                            }
                            $r5 = this.controls[mx.video.UIManager.VOLUME_BAR];
                            $r5.percentage = !this._isMuted ? e.volume : this.cachedSoundLevel;
                            if ($r5.percentage < 0) {
                                $r5.percentage = 0;
                            } else {
                                if ($r5.percentage > 100) {
                                    $r5.percentage = 100;
                                }
                            }
                            this.positionHandle(mx.video.UIManager.VOLUME_BAR);
                        } else {
                            if ((e.type == "playheadUpdate") && !(this.controls[mx.video.UIManager.SEEK_BAR] == undefined)) {
                                if (!this._vc.__get__isLive() && (this._vc.__get__totalTime() > 0)) {
                                    $r6 = (e.playheadTime / this._vc.__get__totalTime()) * 100;
                                    if ($r6 < 0) {
                                        $r6 = 0;
                                    } else {
                                        if ($r6 > 100) {
                                            $r6 = 100;
                                        }
                                    }
                                    $r10 = this.controls[mx.video.UIManager.SEEK_BAR];
                                    $r10.percentage = $r6;
                                    this.positionHandle(mx.video.UIManager.SEEK_BAR);
                                }
                            } else {
                                if (e.type == "progress") {
                                    this._progressPercent = (e.bytesTotal > 0) ? ((e.bytesLoaded / e.bytesTotal) * 100) : 100;
                                    $r7 = this._vc._vpState[e.vp].minProgressPercent;
                                    if (!isNaN($r7) && ($r7 > this._progressPercent)) {
                                        this._progressPercent = $r7;
                                    }
                                    if (this._vc.__get__totalTime() > 0) {
                                        $r8 = (this._vc.__get__playheadTime() / this._vc.__get__totalTime()) * 100;
                                        if ($r8 > this._progressPercent) {
                                            this._progressPercent = $r8;
                                            this._vc._vpState[e.vp].minProgressPercent = this._progressPercent;
                                        }
                                    }
                                    $r2 = mx.video.UIManager.SEEK_BAR;
                                    while (!!!($r2 > mx.video.UIManager.VOLUME_BAR)) {
                                        $r4 = this.controls[$r2];
                                        if (!!!($r4.progress_mc == undefined)) {
                                            this.positionBar($r4, "progress", this._progressPercent);
                                        }
                                        $r2 = $r2 + 1;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            this._vc.__set__activeVideoPlayerIndex($r9);
        };
    $r2.__get__bufferingBarHidesAndDisablesOthers = function () {
            return this._bufferingBarHides;
        };
    $r2.__set__bufferingBarHidesAndDisablesOthers = function (b) {
            this._bufferingBarHides = b;
            return this.__get__bufferingBarHidesAndDisablesOthers();
            <stack?>;
        };
    $r2.__get__controlsEnabled = function () {
            return this._controlsEnabled;
        };
    $r2.__set__controlsEnabled = function (flag) {
            if (this._controlsEnabled == flag) {
                return;
            }
            this._controlsEnabled = flag;
            $r2 = 0;
            while ($r2 < mx.video.UIManager.NUM_BUTTONS) {
                if (this.controls[$r2] == undefined) {
                } else {
                    this.controls[$r2].releaseCapture();
                    this.controls[$r2].enabled = this._controlsEnabled && this.controls[$r2].myEnabled;
                    this.skinButtonControl(this.controls[$r2]);
                }
                $r2 = $r2 + 1;
            }
            return this.__get__controlsEnabled();
            <stack?>;
        };
    $r2.__get__skin = function () {
            return this._skin;
        };
    $r2.__set__skin = function (s) {
            if (s == this._skin) {
                return;
            }
            if (!!!(this._skin == undefined)) {
                this.removeSkin();
            }
            this._skin = s;
            this._skinReady = ((this._skin == undefined) || (this._skin == null)) || (this._skin == "");
            if (!this._skinReady) {
                this.downloadSkin();
            }
            return this.__get__skin();
            <stack?>;
        };
    $r2.__get__skinAutoHide = function () {
            return this._skinAutoHide;
        };
    $r2.__set__skinAutoHide = function (b) {
            if (b == this._skinAutoHide) {
                return;
            }
            this._skinAutoHide = b;
            this.setupSkinAutoHide();
            return this.__get__skinAutoHide();
            <stack?>;
        };
    $r2.__get__skinReady = function () {
            return this._skinReady;
        };
    $r2.__get__seekBarInterval = function () {
            return this._seekBarInterval;
        };
    $r2.__set__seekBarInterval = function (s) {
            if (this._seekBarInterval == s) {
                return;
            }
            this._seekBarInterval = s;
            if (this._seekBarIntervalID > 0) {
                clearInterval(this._seekBarIntervalID);
                this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
            }
            return this.__get__seekBarInterval();
            <stack?>;
        };
    $r2.__get__volumeBarInterval = function () {
            return this._volumeBarInterval;
        };
    $r2.__set__volumeBarInterval = function (s) {
            if (this._volumeBarInterval == s) {
                return;
            }
            this._volumeBarInterval = s;
            if (this._volumeBarIntervalID > 0) {
                clearInterval(this._volumeBarIntervalID);
                this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
            }
            return this.__get__volumeBarInterval();
            <stack?>;
        };
    $r2.__get__bufferingDelayInterval = function () {
            return this._bufferingDelayInterval;
        };
    $r2.__set__bufferingDelayInterval = function (s) {
            if (this._bufferingDelayInterval == s) {
                return;
            }
            this._bufferingDelayInterval = s;
            if (this._bufferingDelayIntervalID > 0) {
                clearInterval(this._bufferingDelayIntervalID);
                this._bufferingDelayIntervalID = setInterval(this, "doBufferingDelay", this._bufferingDelayIntervalID);
            }
            return this.__get__bufferingDelayInterval();
            <stack?>;
        };
    $r2.__get__volumeBarScrubTolerance = function () {
            return this._volumeBarScrubTolerance;
        };
    $r2.__set__volumeBarScrubTolerance = function (s) {
            this._volumeBarScrubTolerance = s;
            return this.__get__volumeBarScrubTolerance();
            <stack?>;
        };
    $r2.__get__seekBarScrubTolerance = function () {
            return this._seekBarScrubTolerance;
        };
    $r2.__set__seekBarScrubTolerance = function (s) {
            this._seekBarScrubTolerance = s;
            return this.__get__seekBarScrubTolerance();
            <stack?>;
        };
    $r2.__get__visible = function () {
            return this.__visible;
        };
    $r2.__set__visible = function (v) {
            if (this.__visible == v) {
                return;
            }
            this.__visible = v;
            if (!this.__visible) {
                this.skin_mc._visible = false;
            } else {
                this.setupSkinAutoHide();
            }
            return this.__get__visible();
            <stack?>;
        };
    $r2.getControl = function (index) {
            return this.controls[index];
        };
    $r2.setControl = function (index, s) {
            if (s == null) {
                s = undefined;
            }
            if (s == this.controls[index]) {
                return;
            }
            $r0 = index;
            if (!($r0 === mx.video.UIManager.PAUSE_BUTTON)) {
                if (!($r0 === mx.video.UIManager.PLAY_BUTTON)) {
                    if (!($r0 === mx.video.UIManager.PLAY_PAUSE_BUTTON)) {
                        if (!($r0 === mx.video.UIManager.MUTE_BUTTON)) {
                            goto L01d9;
                            this.resetPlayPause();
                            goto L01d9;
                            if (!!!(s._parent == this.layout_mc)) {
                                this.resetPlayPause();
                                this.setControl(mx.video.UIManager.PAUSE_BUTTON, s.pause_mc);
                                this.setControl(mx.video.UIManager.PLAY_BUTTON, s.play_mc);
                            }
                        } else {
                            if (!!!(s._parent == this.layout_mc)) {
                                this.setControl(mx.video.UIManager.MUTE_ON_BUTTON, s.on_mc);
                                this.setControl(mx.video.UIManager.MUTE_OFF_BUTTON, s.off_mc);
                            }
                            goto L01d9;
                        }
                    } else {
                        if (!!!(s._parent == this.layout_mc)) {
                            this.resetPlayPause();
                            this.setControl(mx.video.UIManager.PAUSE_BUTTON, s.pause_mc);
                            this.setControl(mx.video.UIManager.PLAY_BUTTON, s.play_mc);
                        }
                        goto L01d9;
                        if (!!!(s._parent == this.layout_mc)) {
                            this.setControl(mx.video.UIManager.MUTE_ON_BUTTON, s.on_mc);
                            this.setControl(mx.video.UIManager.MUTE_OFF_BUTTON, s.off_mc);
                        }
                        goto L01d9;
                    }
                } else {
                    this.resetPlayPause();
                    goto L01d9;
                    if (!!!(s._parent == this.layout_mc)) {
                        this.resetPlayPause();
                        this.setControl(mx.video.UIManager.PAUSE_BUTTON, s.pause_mc);
                        this.setControl(mx.video.UIManager.PLAY_BUTTON, s.play_mc);
                    }
                    goto L01d9;
                    if (!!!(s._parent == this.layout_mc)) {
                        this.setControl(mx.video.UIManager.MUTE_ON_BUTTON, s.on_mc);
                        this.setControl(mx.video.UIManager.MUTE_OFF_BUTTON, s.off_mc);
                    }
                    goto L01d9;
                }
            } else {
                this.resetPlayPause();
                goto L01d9;
                if (!!!(s._parent == this.layout_mc)) {
                    this.resetPlayPause();
                    this.setControl(mx.video.UIManager.PAUSE_BUTTON, s.pause_mc);
                    this.setControl(mx.video.UIManager.PLAY_BUTTON, s.play_mc);
                }
                goto L01d9;
                if (!!!(s._parent == this.layout_mc)) {
                    this.setControl(mx.video.UIManager.MUTE_ON_BUTTON, s.on_mc);
                    this.setControl(mx.video.UIManager.MUTE_OFF_BUTTON, s.off_mc);
                }
                goto L01d9;
            }
            if (!!!(index < mx.video.UIManager.NUM_BUTTONS)) {
                this.controls[index] = s;
                $r0 = index;
                if (!($r0 === mx.video.UIManager.SEEK_BAR)) {
                    if (!($r0 === mx.video.UIManager.VOLUME_BAR)) {
                        if (!($r0 === mx.video.UIManager.BUFFERING_BAR)) {
                            goto L0400;
                            this.addBarControl(mx.video.UIManager.SEEK_BAR);
                            goto L0400;
                            this.addBarControl(mx.video.UIManager.VOLUME_BAR);
                            this.controls[mx.video.UIManager.VOLUME_BAR].percentage = this._vc.volume;
                        } else {
                            this.controls[mx.video.UIManager.BUFFERING_BAR].uiMgr = this;
                            this.controls[mx.video.UIManager.BUFFERING_BAR].controlIndex = mx.video.UIManager.BUFFERING_BAR;
                            if (this.controls[mx.video.UIManager.BUFFERING_BAR]._parent == this.skin_mc) {
                                this.finishAddBufferingBar();
                            } else {
                                this.controls[mx.video.UIManager.BUFFERING_BAR].onEnterFrame = function () {
                                                                this.uiMgr.finishAddBufferingBar();
                                                            };
                            }
                            goto L0400;
                        }
                    } else {
                        this.addBarControl(mx.video.UIManager.VOLUME_BAR);
                        this.controls[mx.video.UIManager.VOLUME_BAR].percentage = this._vc.volume;
                        goto L0400;
                        this.controls[mx.video.UIManager.BUFFERING_BAR].uiMgr = this;
                        this.controls[mx.video.UIManager.BUFFERING_BAR].controlIndex = mx.video.UIManager.BUFFERING_BAR;
                        if (this.controls[mx.video.UIManager.BUFFERING_BAR]._parent == this.skin_mc) {
                            this.finishAddBufferingBar();
                        } else {
                            this.controls[mx.video.UIManager.BUFFERING_BAR].onEnterFrame = function () {
                                                        this.uiMgr.finishAddBufferingBar();
                                                    };
                        }
                        goto L0400;
                    }
                } else {
                    this.addBarControl(mx.video.UIManager.SEEK_BAR);
                    goto L0400;
                    this.addBarControl(mx.video.UIManager.VOLUME_BAR);
                    this.controls[mx.video.UIManager.VOLUME_BAR].percentage = this._vc.volume;
                    goto L0400;
                    this.controls[mx.video.UIManager.BUFFERING_BAR].uiMgr = this;
                    this.controls[mx.video.UIManager.BUFFERING_BAR].controlIndex = mx.video.UIManager.BUFFERING_BAR;
                    if (this.controls[mx.video.UIManager.BUFFERING_BAR]._parent == this.skin_mc) {
                        this.finishAddBufferingBar();
                    } else {
                        this.controls[mx.video.UIManager.BUFFERING_BAR].onEnterFrame = function () {
                                                this.uiMgr.finishAddBufferingBar();
                                            };
                    }
                    goto L0400;
                }
                this.setEnabledAndVisibleForState(index, this._vc.__get__state());
            } else {
                this.removeButtonControl(index);
                this.controls[index] = s;
                this.addButtonControl(index);
            }
        };
    $r2.resetPlayPause = function () {
            if (this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined) {
                return;
            }
            $r2 = mx.video.UIManager.PAUSE_BUTTON;
            while (!!!($r2 > mx.video.UIManager.PLAY_BUTTON)) {
                this.removeButtonControl($r2);
                $r2 = $r2 + 1;
            }
            this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] = undefined;
        };
    $r2.addButtonControl = function (index) {
            $r3 = this.controls[index];
            if ($r3 == undefined) {
                return;
            }
            $r5 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            $r3.id = index;
            $r3.state = mx.video.UIManager.UP_STATE;
            $r3.uiMgr = this;
            this.setEnabledAndVisibleForState(index, this._vc.__get__state());
            $r3.onRollOver = function () {
                        this.state = mx.video.UIManager.OVER_STATE;
                        this.uiMgr.skinButtonControl(this);
                    };
            $r3.onRollOut = function () {
                        this.state = mx.video.UIManager.UP_STATE;
                        this.uiMgr.skinButtonControl(this);
                    };
            if ((index == mx.video.UIManager.SEEK_BAR_HANDLE) || (index == mx.video.UIManager.VOLUME_BAR_HANDLE)) {
                $r3.onPress = function () {
                                if (_root.focusManager) {
                                    this._focusrect = false;
                                    Selection.setFocus(this);
                                }
                                this.state = mx.video.UIManager.DOWN_STATE;
                                this.uiMgr.dispatchMessage(this);
                                this.uiMgr.skinButtonControl(this);
                            };
                $r3.onRelease = function () {
                                this.state = mx.video.UIManager.OVER_STATE;
                                this.uiMgr.handleRelease(this.controlIndex);
                                this.uiMgr.skinButtonControl(this);
                            };
                $r3.onReleaseOutside = function () {
                                this.state = mx.video.UIManager.UP_STATE;
                                this.uiMgr.handleRelease(this.controlIndex);
                                this.uiMgr.skinButtonControl(this);
                            };
            } else {
                $r3.onPress = function () {
                                if (_root.focusManager) {
                                    this._focusrect = false;
                                    Selection.setFocus(this);
                                }
                                this.state = mx.video.UIManager.DOWN_STATE;
                                this.uiMgr.skinButtonControl(this);
                            };
                $r3.onRelease = function () {
                                this.state = mx.video.UIManager.OVER_STATE;
                                this.uiMgr.dispatchMessage(this);
                                this.uiMgr.skinButtonControl(this);
                            };
                $r3.onReleaseOutside = function () {
                                this.state = mx.video.UIManager.UP_STATE;
                                this.uiMgr.skinButtonControl(this);
                            };
            }
            if ($r3._parent == this.skin_mc) {
                this.skinButtonControl($r3);
            } else {
                $r3.onEnterFrame = function () {
                                this.uiMgr.skinButtonControl(this);
                            };
            }
            this._vc.__set__activeVideoPlayerIndex($r5);
        };
    $r2.removeButtonControl = function (index) {
            if (this.controls[index] == undefined) {
                return;
            }
            this.controls[index].uiMgr = undefined;
            this.controls[index].onRollOver = undefined;
            this.controls[index].onRollOut = undefined;
            this.controls[index].onPress = undefined;
            this.controls[index].onRelease = undefined;
            this.controls[index].onReleaseOutside = undefined;
            this.controls[index] = undefined;
        };
    $r2.downloadSkin = function () {
            if (this.skinLoader == undefined) {
                this.skinLoader = new MovieClipLoader();
                this.skinLoader.addListener(this);
            }
            if (this.skin_mc == undefined) {
                this.skin_mc = this._vc.createEmptyMovieClip("skin_mc", this._vc.getNextHighestDepth());
            }
            this.skin_mc._visible = false;
            this.skin_mc._x = Stage.width + 100;
            this.skin_mc._y = Stage.height + 100;
            this.skinLoader.loadClip(this._skin, this.skin_mc);
        };
    $r2.onLoadError = function (target_mc, errorCode) {
            this._skinReady = true;
            this._vc.skinError("Unable to load skin swf");
        };
    $r2.onLoadInit = function () {
            try {
                this.skin_mc._visible = false;
                this.skin_mc._x = 0;
                this.skin_mc._y = 0;
                this.layout_mc = this.skin_mc.layout_mc;
                if (this.layout_mc == undefined) {
                    throw new Error("No layout_mc");
                }
                this.layout_mc._visible = false;
                this.customClips = new Array();
                this.setCustomClips("bg");
                if (!!!(this.layout_mc.playpause_mc == undefined)) {
                    this.setSkin(mx.video.UIManager.PLAY_PAUSE_BUTTON, this.layout_mc.playpause_mc);
                } else {
                    this.setSkin(mx.video.UIManager.PAUSE_BUTTON, this.layout_mc.pause_mc);
                    this.setSkin(mx.video.UIManager.PLAY_BUTTON, this.layout_mc.play_mc);
                }
                this.setSkin(mx.video.UIManager.STOP_BUTTON, this.layout_mc.stop_mc);
                this.setSkin(mx.video.UIManager.BACK_BUTTON, this.layout_mc.back_mc);
                this.setSkin(mx.video.UIManager.FORWARD_BUTTON, this.layout_mc.forward_mc);
                this.setSkin(mx.video.UIManager.MUTE_BUTTON, this.layout_mc.volumeMute_mc);
                this.setSkin(mx.video.UIManager.SEEK_BAR, this.layout_mc.seekBar_mc);
                this.setSkin(mx.video.UIManager.VOLUME_BAR, this.layout_mc.volumeBar_mc);
                this.setSkin(mx.video.UIManager.BUFFERING_BAR, this.layout_mc.bufferingBar_mc);
                this.setCustomClips("fg");
                this.layoutSkin();
                this.setupSkinAutoHide();
                this.skin_mc._visible = this.__visible;
                this._skinReady = true;
                this._vc.skinLoaded();
                $r4 = this._vc.__get__activeVideoPlayerIndex();
                this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
                $r3 = this._vc.__get__state();
                $r2 = 0;
                while ($r2 < mx.video.UIManager.NUM_CONTROLS) {
                    if (this.controls[$r2] == undefined) {
                    } else {
                        this.setEnabledAndVisibleForState($r2, $r3);
                        if ($r2 < mx.video.UIManager.NUM_BUTTONS) {
                            this.skinButtonControl(this.controls[$r2]);
                        }
                    }
                    $r2 = $r2 + 1;
                }
                this._vc.__set__activeVideoPlayerIndex($r4);
                goto L0000;
            } catch (Register(0)) {
                if (!(Error($r0) == null)) {
                    var err = Error($r0);
                    this._vc.skinError(err.message);
                    this.removeSkin();
                } else {
                    <stack?>;
                    throw $r0;
                }
            }
        };
    $r2.layoutSkin = function () {
            if (this.layout_mc == undefined) {
                return;
            }
            $r3 = this.layout_mc.video_mc;
            if ($r3 == undefined) {
                throw new Error("No layout_mc.video_mc");
            }
            this.placeholderLeft = $r3._x;
            this.placeholderRight = $r3._x + $r3._width;
            this.placeholderTop = $r3._y;
            this.placeholderBottom = $r3._y + $r3._height;
            this.videoLeft = 0;
            this.videoRight = this._vc.width;
            this.videoTop = 0;
            this.videoBottom = this._vc.height;
            if ((!isNaN(this.layout_mc.minWidth) && (this.layout_mc.minWidth > 0)) && (this.layout_mc.minWidth > this.videoRight)) {
                this.videoLeft = this.videoLeft - ((this.layout_mc.minWidth - this.videoRight) / 2);
                this.videoRight = this.layout_mc.minWidth + this.videoLeft;
            }
            if ((!isNaN(this.layout_mc.minHeight) && (this.layout_mc.minHeight > 0)) && (this.layout_mc.minHeight > this.videoBottom)) {
                this.videoTop = this.videoTop - ((this.layout_mc.minHeight - this.videoBottom) / 2);
                this.videoBottom = this.layout_mc.minHeight + this.videoTop;
            }
            $r2 = undefined;
            $r2 = 0;
            while ($r2 < this.customClips.length) {
                this.layoutControl(this.customClips[$r2]);
                $r2 = $r2 + 1;
            }
            $r2 = 0;
            while ($r2 < mx.video.UIManager.NUM_CONTROLS) {
                this.layoutControl(this.controls[$r2]);
                $r2 = $r2 + 1;
            }
        };
    $r2.layoutControl = function (ctrl) {
            if (ctrl == undefined) {
                return;
            }
            if (ctrl.skin.anchorRight) {
                if (ctrl.skin.anchorLeft) {
                    ctrl._x = (ctrl.skin._x - this.placeholderLeft) + this.videoLeft;
                    ctrl._width = (((ctrl.skin._x + ctrl.skin._width) - this.placeholderRight) + this.videoRight) - ctrl._x;
                    if (!!!(ctrl.origWidth == undefined)) {
                        ctrl.origWidth = undefined;
                    }
                } else {
                    ctrl._x = (ctrl.skin._x - this.placeholderRight) + this.videoRight;
                }
            } else {
                ctrl._x = (ctrl.skin._x - this.placeholderLeft) + this.videoLeft;
            }
            if (ctrl.skin.anchorTop) {
                if (ctrl.skin.anchorBottom) {
                    ctrl._y = (ctrl.skin._y - this.placeholderTop) + this.videoTop;
                    ctrl._height = (((ctrl.skin._y + ctrl.skin._height) - this.placeholderBottom) + this.videoBottom) - ctrl._y;
                    if (!!!(ctrl.origHeight == undefined)) {
                        ctrl.origHeight = undefined;
                    }
                } else {
                    ctrl._y = (ctrl.skin._y - this.placeholderTop) + this.videoTop;
                }
            } else {
                ctrl._y = (ctrl.skin._y - this.placeholderBottom) + this.videoBottom;
            }
            $r0 = ctrl.controlIndex;
            if (!($r0 === mx.video.UIManager.SEEK_BAR)) {
                if (!($r0 === mx.video.UIManager.VOLUME_BAR)) {
                    if (!($r0 === mx.video.UIManager.BUFFERING_BAR)) {
                        goto L0343;
                        if (!!!(ctrl.progress_mc == undefined)) {
                            if (this._progressPercent == undefined) {
                                this._progressPercent = !this._vc.__get__isRTMP() ? 0 : 100;
                            }
                            this.positionBar(ctrl, "progress", this._progressPercent);
                        }
                        this.positionHandle(ctrl.controlIndex);
                    } else {
                        if (!!!(ctrl.fill_mc == undefined)) {
                            this.positionMaskedFill(ctrl, ctrl.fill_mc, 100);
                        }
                        goto L0343;
                    }
                } else {
                    if (!!!(ctrl.progress_mc == undefined)) {
                        if (this._progressPercent == undefined) {
                            this._progressPercent = !this._vc.__get__isRTMP() ? 0 : 100;
                        }
                        this.positionBar(ctrl, "progress", this._progressPercent);
                    }
                    this.positionHandle(ctrl.controlIndex);
                    goto L0343;
                    if (!!!(ctrl.fill_mc == undefined)) {
                        this.positionMaskedFill(ctrl, ctrl.fill_mc, 100);
                    }
                    goto L0343;
                }
            } else {
                if (!!!(ctrl.progress_mc == undefined)) {
                    if (this._progressPercent == undefined) {
                        this._progressPercent = !this._vc.__get__isRTMP() ? 0 : 100;
                    }
                    this.positionBar(ctrl, "progress", this._progressPercent);
                }
                this.positionHandle(ctrl.controlIndex);
                goto L0343;
                if (!!!(ctrl.fill_mc == undefined)) {
                    this.positionMaskedFill(ctrl, ctrl.fill_mc, 100);
                }
                goto L0343;
            }
            if (!!!(ctrl.layoutSelf == undefined)) {
                ctrl.layoutSelf();
            }
        };
    $r2.removeSkin = function () {
            if (!!!(this.skin_mc == undefined)) {
                $r2 = 0;
                while ($r2 < mx.video.UIManager.NUM_BUTTONS) {
                    this.removeButtonControl($r2);
                    $r2 = $r2 + 1;
                }
                $r2 = mx.video.UIManager.NUM_BUTTONS;
                while ($r2 < mx.video.UIManager.NUM_CONTROLS) {
                    this.controls[$r2] = undefined;
                    $r2 = $r2 + 1;
                }
                this.skin_mc.unloadMovie();
                this.layout_mc = undefined;
                this.border_mc = undefined;
            }
        };
    $r2.setCustomClips = function (prefix) {
            $r4 = 1;
            while (!false) {
                var $old1 = $r4;
                $r4 = $r4 + 1;
                $r2 = this.layout_mc[(prefix + $old1) + "_mc"];
                if ($r2 == undefined) {
                    break;
                }
                $r3 = $r2.mc;
                if ($r3 == undefined) {
                    $r3 = $r2._parent._parent[$r2._name];
                }
                if ($r3 == undefined) {
                    throw new Error("Bad clip in skin: " + $r2);
                }
                $r3.skin = $r2;
                this.customClips.push($r3);
                if ((prefix == "bg") && ($r4 == 2)) {
                    this.border_mc = $r3;
                }
            }
        };
    $r2.setSkin = function (index, s) {
            if (s == undefined) {
                return;
            }
            $r2 = s.mc;
            if ($r2 == undefined) {
                $r2 = s._parent._parent[s._name];
            }
            if ($r2 == undefined) {
                throw new Error("Bad clip in skin: " + s);
            }
            $r2.skin = s;
            if (index < mx.video.UIManager.NUM_BUTTONS) {
                this.setupSkinStates($r2);
            } else {
                $r0 = index;
                if (!($r0 === mx.video.UIManager.PLAY_PAUSE_BUTTON)) {
                    if (!($r0 === mx.video.UIManager.MUTE_BUTTON)) {
                        if (!($r0 === mx.video.UIManager.SEEK_BAR)) {
                            if (!($r0 === mx.video.UIManager.VOLUME_BAR)) {
                                if (!($r0 === mx.video.UIManager.BUFFERING_BAR)) {
                                    goto L035e;
                                    this.setupSkinStates($r2.play_mc);
                                    this.setupSkinStates($r2.pause_mc);
                                    goto L035e;
                                    this.setupSkinStates($r2.on_mc);
                                    this.setupSkinStates($r2.off_mc);
                                    goto L035e;
                                    $r4 = (!(index == mx.video.UIManager.SEEK_BAR)) ? "volumeBar" : "seekBar";
                                    if ($r2.handle_mc == undefined) {
                                        $r2.handle_mc = $r2.skin.seekBarHandle_mc;
                                        if ($r2.handle_mc == undefined) {
                                            $r2.handle_mc = $r2.skin._parent._parent[$r4 + "Handle_mc"];
                                        }
                                    }
                                    if ($r2.progress_mc == undefined) {
                                        $r2.progress_mc = $r2.skin.progress_mc;
                                        if ($r2.progress_mc == undefined) {
                                            $r2.progress_mc = $r2.skin._parent._parent[$r4 + "Progress_mc"];
                                        }
                                    }
                                    if ($r2.fullness_mc == undefined) {
                                        $r2.fullness_mc = $r2.skin.fullness_mc;
                                        if ($r2.fullness_mc == undefined) {
                                            $r2.fullness_mc = $r2.skin._parent._parent[$r4 + "Fullness_mc"];
                                        }
                                    }
                                } else {
                                    if ($r2.fill_mc == undefined) {
                                        $r2.fill_mc = $r2.skin.fill_mc;
                                        if ($r2.fill_mc == undefined) {
                                            $r2.fill_mc = $r2.skin._parent._parent.bufferingBarFill_mc;
                                        }
                                    }
                                    goto L035e;
                                }
                            } else {
                                $r4 = (!(index == mx.video.UIManager.SEEK_BAR)) ? "volumeBar" : "seekBar";
                                if ($r2.handle_mc == undefined) {
                                    $r2.handle_mc = $r2.skin.seekBarHandle_mc;
                                    if ($r2.handle_mc == undefined) {
                                        $r2.handle_mc = $r2.skin._parent._parent[$r4 + "Handle_mc"];
                                    }
                                }
                                if ($r2.progress_mc == undefined) {
                                    $r2.progress_mc = $r2.skin.progress_mc;
                                    if ($r2.progress_mc == undefined) {
                                        $r2.progress_mc = $r2.skin._parent._parent[$r4 + "Progress_mc"];
                                    }
                                }
                                if ($r2.fullness_mc == undefined) {
                                    $r2.fullness_mc = $r2.skin.fullness_mc;
                                    if ($r2.fullness_mc == undefined) {
                                        $r2.fullness_mc = $r2.skin._parent._parent[$r4 + "Fullness_mc"];
                                    }
                                }
                                goto L035e;
                                if ($r2.fill_mc == undefined) {
                                    $r2.fill_mc = $r2.skin.fill_mc;
                                    if ($r2.fill_mc == undefined) {
                                        $r2.fill_mc = $r2.skin._parent._parent.bufferingBarFill_mc;
                                    }
                                }
                                goto L035e;
                            }
                        } else {
                            $r4 = (!(index == mx.video.UIManager.SEEK_BAR)) ? "volumeBar" : "seekBar";
                            if ($r2.handle_mc == undefined) {
                                $r2.handle_mc = $r2.skin.seekBarHandle_mc;
                                if ($r2.handle_mc == undefined) {
                                    $r2.handle_mc = $r2.skin._parent._parent[$r4 + "Handle_mc"];
                                }
                            }
                            if ($r2.progress_mc == undefined) {
                                $r2.progress_mc = $r2.skin.progress_mc;
                                if ($r2.progress_mc == undefined) {
                                    $r2.progress_mc = $r2.skin._parent._parent[$r4 + "Progress_mc"];
                                }
                            }
                            if ($r2.fullness_mc == undefined) {
                                $r2.fullness_mc = $r2.skin.fullness_mc;
                                if ($r2.fullness_mc == undefined) {
                                    $r2.fullness_mc = $r2.skin._parent._parent[$r4 + "Fullness_mc"];
                                }
                            }
                            goto L035e;
                            if ($r2.fill_mc == undefined) {
                                $r2.fill_mc = $r2.skin.fill_mc;
                                if ($r2.fill_mc == undefined) {
                                    $r2.fill_mc = $r2.skin._parent._parent.bufferingBarFill_mc;
                                }
                            }
                            goto L035e;
                        }
                    } else {
                        this.setupSkinStates($r2.on_mc);
                        this.setupSkinStates($r2.off_mc);
                        goto L035e;
                        $r4 = (!(index == mx.video.UIManager.SEEK_BAR)) ? "volumeBar" : "seekBar";
                        if ($r2.handle_mc == undefined) {
                            $r2.handle_mc = $r2.skin.seekBarHandle_mc;
                            if ($r2.handle_mc == undefined) {
                                $r2.handle_mc = $r2.skin._parent._parent[$r4 + "Handle_mc"];
                            }
                        }
                        if ($r2.progress_mc == undefined) {
                            $r2.progress_mc = $r2.skin.progress_mc;
                            if ($r2.progress_mc == undefined) {
                                $r2.progress_mc = $r2.skin._parent._parent[$r4 + "Progress_mc"];
                            }
                        }
                        if ($r2.fullness_mc == undefined) {
                            $r2.fullness_mc = $r2.skin.fullness_mc;
                            if ($r2.fullness_mc == undefined) {
                                $r2.fullness_mc = $r2.skin._parent._parent[$r4 + "Fullness_mc"];
                            }
                        }
                        goto L035e;
                        if ($r2.fill_mc == undefined) {
                            $r2.fill_mc = $r2.skin.fill_mc;
                            if ($r2.fill_mc == undefined) {
                                $r2.fill_mc = $r2.skin._parent._parent.bufferingBarFill_mc;
                            }
                        }
                        goto L035e;
                    }
                } else {
                    this.setupSkinStates($r2.play_mc);
                    this.setupSkinStates($r2.pause_mc);
                    goto L035e;
                    this.setupSkinStates($r2.on_mc);
                    this.setupSkinStates($r2.off_mc);
                    goto L035e;
                    $r4 = (!(index == mx.video.UIManager.SEEK_BAR)) ? "volumeBar" : "seekBar";
                    if ($r2.handle_mc == undefined) {
                        $r2.handle_mc = $r2.skin.seekBarHandle_mc;
                        if ($r2.handle_mc == undefined) {
                            $r2.handle_mc = $r2.skin._parent._parent[$r4 + "Handle_mc"];
                        }
                    }
                    if ($r2.progress_mc == undefined) {
                        $r2.progress_mc = $r2.skin.progress_mc;
                        if ($r2.progress_mc == undefined) {
                            $r2.progress_mc = $r2.skin._parent._parent[$r4 + "Progress_mc"];
                        }
                    }
                    if ($r2.fullness_mc == undefined) {
                        $r2.fullness_mc = $r2.skin.fullness_mc;
                        if ($r2.fullness_mc == undefined) {
                            $r2.fullness_mc = $r2.skin._parent._parent[$r4 + "Fullness_mc"];
                        }
                    }
                    goto L035e;
                    if ($r2.fill_mc == undefined) {
                        $r2.fill_mc = $r2.skin.fill_mc;
                        if ($r2.fill_mc == undefined) {
                            $r2.fill_mc = $r2.skin._parent._parent.bufferingBarFill_mc;
                        }
                    }
                    goto L035e;
                }
            }
            this.setControl(index, $r2);
        };
    $r2.setupSkinStates = function (ctrl) {
            if (ctrl.up_mc == undefined) {
                ctrl.up_mc = ctrl;
                ctrl.over_mc = ctrl;
                ctrl.down_mc = ctrl;
                ctrl.disabled_mc = ctrl;
            } else {
                ctrl._x = 0;
                ctrl._y = 0;
                ctrl.up_mc._x = 0;
                ctrl.up_mc._y = 0;
                ctrl.up_mc._visible = true;
                if (ctrl.over_mc == undefined) {
                    ctrl.over_mc = ctrl.up_mc;
                } else {
                    ctrl.over_mc._x = 0;
                    ctrl.over_mc._y = 0;
                    ctrl.over_mc._visible = false;
                }
                if (ctrl.down_mc == undefined) {
                    ctrl.down_mc = ctrl.up_mc;
                } else {
                    ctrl.down_mc._x = 0;
                    ctrl.down_mc._y = 0;
                    ctrl.down_mc._visible = false;
                }
                if (ctrl.disabled_mc == undefined) {
                    ctrl.disabled_mc_mc = ctrl.up_mc;
                } else {
                    ctrl.disabled_mc._x = 0;
                    ctrl.disabled_mc._y = 0;
                    ctrl.disabled_mc._visible = false;
                }
            }
        };
    $r2.skinButtonControl = function (ctrl) {
            if (!!!(ctrl.onEnterFrame == undefined)) {
                delete ctrl.onEnterFrame;
                ctrl.onEnterFrame = undefined;
            }
            if (ctrl.enabled) {
                $r0 = ctrl.state;
                if (!($r0 === mx.video.UIManager.UP_STATE)) {
                    if (!($r0 === mx.video.UIManager.OVER_STATE)) {
                        if (!($r0 === mx.video.UIManager.DOWN_STATE)) {
                            goto L0204;
                            if (ctrl.up_mc == undefined) {
                                ctrl.up_mc = ctrl.attachMovie(ctrl.upLinkageID, "up_mc", ctrl.getNextHighestDepth());
                            }
                            this.applySkinState(ctrl, ctrl.up_mc);
                            goto L0204;
                            if (ctrl.over_mc == undefined) {
                                if (ctrl.overLinkageID == undefined) {
                                    ctrl.over_mc = ctrl.up_mc;
                                } else {
                                    ctrl.over_mc = ctrl.attachMovie(ctrl.overLinkageID, "over_mc", ctrl.getNextHighestDepth());
                                }
                            }
                            this.applySkinState(ctrl, ctrl.over_mc);
                        } else {
                            if (ctrl.down_mc == undefined) {
                                if (ctrl.downLinkageID == undefined) {
                                    ctrl.down_mc = ctrl.up_mc;
                                } else {
                                    ctrl.down_mc = ctrl.attachMovie(ctrl.downLinkageID, "down_mc", ctrl.getNextHighestDepth());
                                }
                            }
                            this.applySkinState(ctrl, ctrl.down_mc);
                            goto L0204;
                        }
                    } else {
                        if (ctrl.over_mc == undefined) {
                            if (ctrl.overLinkageID == undefined) {
                                ctrl.over_mc = ctrl.up_mc;
                            } else {
                                ctrl.over_mc = ctrl.attachMovie(ctrl.overLinkageID, "over_mc", ctrl.getNextHighestDepth());
                            }
                        }
                        this.applySkinState(ctrl, ctrl.over_mc);
                        goto L0204;
                        if (ctrl.down_mc == undefined) {
                            if (ctrl.downLinkageID == undefined) {
                                ctrl.down_mc = ctrl.up_mc;
                            } else {
                                ctrl.down_mc = ctrl.attachMovie(ctrl.downLinkageID, "down_mc", ctrl.getNextHighestDepth());
                            }
                        }
                        this.applySkinState(ctrl, ctrl.down_mc);
                        goto L0204;
                    }
                } else {
                    if (ctrl.up_mc == undefined) {
                        ctrl.up_mc = ctrl.attachMovie(ctrl.upLinkageID, "up_mc", ctrl.getNextHighestDepth());
                    }
                    this.applySkinState(ctrl, ctrl.up_mc);
                    goto L0204;
                    if (ctrl.over_mc == undefined) {
                        if (ctrl.overLinkageID == undefined) {
                            ctrl.over_mc = ctrl.up_mc;
                        } else {
                            ctrl.over_mc = ctrl.attachMovie(ctrl.overLinkageID, "over_mc", ctrl.getNextHighestDepth());
                        }
                    }
                    this.applySkinState(ctrl, ctrl.over_mc);
                    goto L0204;
                    if (ctrl.down_mc == undefined) {
                        if (ctrl.downLinkageID == undefined) {
                            ctrl.down_mc = ctrl.up_mc;
                        } else {
                            ctrl.down_mc = ctrl.attachMovie(ctrl.downLinkageID, "down_mc", ctrl.getNextHighestDepth());
                        }
                    }
                    this.applySkinState(ctrl, ctrl.down_mc);
                    goto L0204;
                }
            } else {
                ctrl.state = mx.video.UIManager.UP_STATE;
                if (ctrl.disabled_mc == undefined) {
                    if (ctrl.disabledLinkageID == undefined) {
                        ctrl.disabled_mc = ctrl.up_mc;
                    } else {
                        ctrl.disabled_mc = ctrl.attachMovie(ctrl.disabledLinkageID, "disabled_mc", ctrl.getNextHighestDepth());
                    }
                }
                this.applySkinState(ctrl, ctrl.disabled_mc);
            }
            if (!!!(ctrl.placeholder_mc == undefined)) {
                ctrl.placeholder_mc.unloadMovie();
                delete ctrl.placeholder_mc;
                ctrl.placeholder_mc = undefined;
            }
        };
    $r2.applySkinState = function (ctrl, state) {
            if (!!!(state == ctrl.currentState_mc)) {
                if (!!!(state == undefined)) {
                    state._visible = true;
                }
                if (!!!(ctrl.currentState_mc == undefined)) {
                    ctrl.currentState_mc._visible = false;
                }
                ctrl.currentState_mc = state;
            }
        };
    $r2.addBarControl = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            $r2.isDragging = false;
            $r2.percentage = 0;
            $r2.uiMgr = this;
            $r2.controlIndex = controlIndex;
            if ($r2._parent == this.skin_mc) {
                this.finishAddBarControl(controlIndex);
            } else {
                $r2.onEnterFrame = function () {
                                this.uiMgr.finishAddBarControl(this.controlIndex);
                            };
            }
        };
    $r2.finishAddBarControl = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            delete $r2.onEnterFrame;
            $r2.onEnterFrame = undefined;
            if (!!!($r2.addBarControl == undefined)) {
                $r2.addBarControl();
            }
            this.calcBarMargins($r2, "handle", true);
            this.calcBarMargins($r2, "progress", false);
            this.calcBarMargins($r2.progress_mc, "fill", false);
            this.calcBarMargins($r2.progress_mc, "mask", false);
            this.calcBarMargins($r2, "fullness", false);
            this.calcBarMargins($r2.fullness_mc, "fill", false);
            this.calcBarMargins($r2.fullness_mc, "mask", false);
            $r2.origWidth = $r2._width;
            $r2.origHeight = $r2._height;
            this.fixUpBar($r2, "progress");
            if (!!!($r2.progress_mc == undefined)) {
                this.fixUpBar($r2, "progressBarFill");
                if (this._progressPercent == undefined) {
                    this._progressPercent = !this._vc.__get__isRTMP() ? 0 : 100;
                }
                this.positionBar($r2, "progress", this._progressPercent);
            }
            this.fixUpBar($r2, "fullness");
            if (!!!($r2.fullness_mc == undefined)) {
                this.fixUpBar($r2, "fullnessBarFill");
            }
            this.fixUpBar($r2, "handle");
            $r2.handle_mc.controlIndex = controlIndex;
            $r0 = controlIndex;
            if (!($r0 === mx.video.UIManager.SEEK_BAR)) {
                if (!($r0 === mx.video.UIManager.VOLUME_BAR)) {
                    goto L02b4;
                    this.setControl(mx.video.UIManager.SEEK_BAR_HANDLE, $r2.handle_mc);
                } else {
                    this.setControl(mx.video.UIManager.VOLUME_BAR_HANDLE, $r2.handle_mc);
                    goto L02b4;
                }
            } else {
                this.setControl(mx.video.UIManager.SEEK_BAR_HANDLE, $r2.handle_mc);
                goto L02b4;
                this.setControl(mx.video.UIManager.VOLUME_BAR_HANDLE, $r2.handle_mc);
                goto L02b4;
            }
            this.positionHandle(controlIndex);
        };
    $r2.fixUpBar = function (ctrl, type) {
            if (!(ctrl[type + "LinkageID"] == undefined) && (ctrl[type + "LinkageID"].length > 0)) {
                $r1 = undefined;
                if (!!ctrl[type + "Below"]) {
                    $r1 = -1;
                    while (!!!(ctrl._parent.getInstanceAtDepth($r1) == undefined)) {
                        $r1 = $r1 - 1;
                    }
                } else {
                    ctrl[type + "Below"] = false;
                    $r1 = ctrl._parent.getNextHighestDepth();
                }
                ctrl[type + "_mc"] = ctrl._parent.attachMovie(ctrl[type + "LinkageID"], type + "_mc", $r1);
            }
        };
    $r2.calcBarMargins = function (ctrl, type, symmetricMargins) {
            $r2 = ctrl[type + "_mc"];
            if ($r2 == undefined) {
                return;
            }
            if ((ctrl[type + "LeftMargin"] == undefined) && ($r2._parent == ctrl._parent)) {
                ctrl[type + "LeftMargin"] = $r2._x - ctrl._x;
            }
            if (ctrl[type + "RightMargin"] == undefined) {
                if (symmetricMargins) {
                    ctrl[type + "RightMargin"] = ctrl[type + "LeftMargin"];
                } else {
                    if ($r2._parent == ctrl._parent) {
                        ctrl[type + "RightMargin"] = ((ctrl._width - $r2._width) - $r2._x) + ctrl._x;
                    }
                }
            }
            if ((ctrl[type + "TopMargin"] == undefined) && ($r2._parent == ctrl._parent)) {
                ctrl[type + "TopMargin"] = $r2._y - ctrl._y;
            }
            if (ctrl[type + "BottomMargin"] == undefined) {
                if (symmetricMargins) {
                    ctrl[type + "BottomMargin"] = ctrl[type + "TopMargin"];
                } else {
                    if ($r2._parent == ctrl._parent) {
                        ctrl[type + "BottomMargin"] = ((ctrl._height - $r2._height) - $r2._y) + ctrl._y;
                    }
                }
            }
            if (ctrl[type + "X"] == undefined) {
                if ($r2._parent == ctrl._parent) {
                    ctrl[type + "X"] = $r2._x - ctrl._x;
                } else {
                    if ($r2._parent == ctrl) {
                        ctrl[type + "X"] = $r2._x;
                    }
                }
            }
            if (ctrl[type + "Y"] == undefined) {
                if ($r2._parent == ctrl._parent) {
                    ctrl[type + "Y"] = $r2._y - ctrl._y;
                } else {
                    if ($r2._parent == ctrl) {
                        ctrl[type + "Y"] = $r2._y;
                    }
                }
            }
            ctrl[type + "XScale"] = $r2._xscale;
            ctrl[type + "YScale"] = $r2._yscale;
            ctrl[type + "Width"] = $r2._width;
            ctrl[type + "Height"] = $r2._height;
        };
    $r2.finishAddBufferingBar = function () {
            $r2 = this.controls[mx.video.UIManager.BUFFERING_BAR];
            delete $r2.onEnterFrame;
            $r2.onEnterFrame = undefined;
            this.calcBarMargins($r2, "fill", true);
            this.fixUpBar($r2, "fill");
            if (!!!($r2.fill_mc == undefined)) {
                this.positionMaskedFill($r2, $r2.fill_mc, 100);
            }
        };
    $r2.positionMaskedFill = function (ctrl, fill, percent) {
            $r5 = fill._parent;
            $r3 = ctrl.mask_mc;
            if ($r3 == undefined) {
                $r3 = $r5.createEmptyMovieClip(ctrl._name + "Mask_mc", $r5.getNextHighestDepth());
                ctrl.mask_mc = $r3;
                $r3.beginFill(16777215);
                $r3.lineTo(0, 0);
                $r3.lineTo(1, 0);
                $r3.lineTo(1, 1);
                $r3.lineTo(0, 1);
                $r3.lineTo(0, 0);
                $r3.endFill();
                fill.setMask($r3);
                $r3._x = ctrl.fillX;
                $r3._y = ctrl.fillY;
                $r3._width = ctrl.fillWidth;
                $r3._height = ctrl.fillHeight;
                $r3._visible = false;
                this.calcBarMargins(ctrl, "mask", true);
            }
            if ($r5 == ctrl) {
                if (fill.slideReveal) {
                    fill._x = (ctrl.maskX - ctrl.fillWidth) + ((ctrl.fillWidth * percent) / 100);
                } else {
                    $r3._width = (ctrl.fillWidth * percent) / 100;
                }
            } else {
                if ($r5 == ctrl._parent) {
                    if (fill.slideReveal) {
                        $r3._x = ctrl._x + ctrl.maskLeftMargin;
                        $r3._y = ctrl._y + ctrl.maskTopMargin;
                        $r3._width = (ctrl._width - ctrl.maskRightMargin) - ctrl.maskLeftMargin;
                        $r3._height = (ctrl._height - ctrl.maskTopMargin) - ctrl.maskBottomMargin;
                        fill._x = ($r3._x - ctrl.fillWidth) + ((ctrl.maskWidth * percent) / 100);
                        fill._y = ctrl._y + ctrl.fillTopMargin;
                    } else {
                        fill._x = ctrl._x + ctrl.fillLeftMargin;
                        fill._y = ctrl._y + ctrl.fillTopMargin;
                        $r3._x = fill._x;
                        $r3._y = fill._y;
                        $r3._width = (((ctrl._width - ctrl.fillRightMargin) - ctrl.fillLeftMargin) * percent) / 100;
                        $r3._height = (ctrl._height - ctrl.fillTopMargin) - ctrl.fillBottomMargin;
                    }
                }
            }
        };
    $r2.startHandleDrag = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            $r5 = $r2.handle_mc;
            if (($r2.startHandleDrag == undefined) || !$r2.startHandleDrag()) {
                $r3 = $r2._y + $r2.handleY;
                $r4 = (!($r2.origWidth == undefined)) ? $r2.origWidth : $r2._width;
                $r5.startDrag(false, $r2._x + $r2.handleLeftMargin, $r3, ($r2._x + $r4) - $r2.handleRightMargin, $r3);
            }
            $r2.isDragging = true;
        };
    $r2.stopHandleDrag = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            $r3 = $r2.handle_mc;
            if (($r2.stopHandleDrag == undefined) || !$r2.stopHandleDrag()) {
                $r3.stopDrag();
            }
            $r2.isDragging = false;
        };
    $r2.positionHandle = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            $r3 = $r2.handle_mc;
            if ($r3 == undefined) {
                return;
            }
            if (!($r2.positionHandle == undefined) && $r2.positionHandle()) {
                return;
            }
            $r4 = (!($r2.origWidth == undefined)) ? $r2.origWidth : $r2._width;
            $r5 = ($r4 - $r2.handleRightMargin) - $r2.handleLeftMargin;
            $r3._x = ($r2._x + $r2.handleLeftMargin) + (($r5 * $r2.percentage) / 100);
            $r3._y = $r2._y + $r2.handleY;
            if (!!!($r2.fullness_mc == undefined)) {
                this.positionBar($r2, "fullness", $r2.percentage);
            }
        };
    $r2.positionBar = function (ctrl, type, percent) {
            if (!(ctrl.positionBar == undefined) && ctrl.positionBar(type, percent)) {
                return;
            }
            $r2 = ctrl[type + "_mc"];
            if ($r2._parent == ctrl) {
                if ($r2.fill_mc == undefined) {
                    $r2._xscale = (ctrl[type + "XScale"] * percent) / 100;
                } else {
                    this.positionMaskedFill($r2, $r2.fill_mc, percent);
                }
            } else {
                $r2._x = ctrl._x + ctrl[type + "LeftMargin"];
                $r2._y = ctrl._y + ctrl[type + "Y"];
                if ($r2.fill_mc == undefined) {
                    $r2._width = (((ctrl._width - ctrl[type + "LeftMargin"]) - ctrl[type + "RightMargin"]) * percent) / 100;
                } else {
                    this.positionMaskedFill($r2, $r2.fill_mc, percent);
                }
            }
        };
    $r2.calcPercentageFromHandle = function (controlIndex) {
            $r2 = this.controls[controlIndex];
            $r5 = $r2.handle_mc;
            if (($r2.calcPercentageFromHandle == undefined) || !$r2.calcPercentageFromHandle()) {
                $r3 = (!($r2.origWidth == undefined)) ? $r2.origWidth : $r2._width;
                $r6 = ($r3 - $r2.handleRightMargin) - $r2.handleLeftMargin;
                $r4 = $r5._x - ($r2._x + $r2.handleLeftMargin);
                $r2.percentage = ($r4 / $r6) * 100;
                if (!!!($r2.fullness_mc == undefined)) {
                    this.positionBar($r2, "fullness", $r2.percentage);
                }
            }
            if ($r2.percentage < 0) {
                $r2.percentage = 0;
            }
            if ($r2.percentage > 100) {
                $r2.percentage = 100;
            }
        };
    $r2.handleRelease = function (controlIndex) {
            $r3 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            if (controlIndex == mx.video.UIManager.SEEK_BAR) {
                this.seekBarListener(true);
            } else {
                if (controlIndex == mx.video.UIManager.VOLUME_BAR) {
                    this.volumeBarListener(true);
                }
            }
            this.stopHandleDrag(controlIndex);
            this._vc.__set__activeVideoPlayerIndex($r3);
            if (controlIndex == mx.video.UIManager.SEEK_BAR) {
                this._vc._scrubFinish();
            }
        };
    $r2.seekBarListener = function (finish) {
            $r3 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            $r4 = this.controls[mx.video.UIManager.SEEK_BAR];
            this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
            $r2 = $r4.percentage;
            if (finish) {
                clearInterval(this._seekBarIntervalID);
                this._seekBarIntervalID = 0;
                if (!!!($r2 == this._lastScrubPos)) {
                    this._vc.seekPercent($r2);
                }
                this._vc.addEventListener("playheadUpdate", this);
                if (this._playAfterScrub) {
                    this._vc.play();
                }
            } else {
                if (this._vc.getVideoPlayer(this._vc.__get__visibleVideoPlayerIndex()).__get__state() == mx.video.VideoPlayer.SEEKING) {
                } else {
                    if (((!(this._seekBarScrubTolerance > 0) || (Math.abs($r2 - this._lastScrubPos) > this._seekBarScrubTolerance)) || ($r2 < this._seekBarScrubTolerance)) || ($r2 > (100 - this._seekBarScrubTolerance))) {
                        if (!!!($r2 == this._lastScrubPos)) {
                            this._lastScrubPos = $r2;
                            this._vc.seekPercent($r2);
                        }
                    }
                }
            }
            this._vc.__set__activeVideoPlayerIndex($r3);
        };
    $r2.volumeBarListener = function (finish) {
            $r3 = this.controls[mx.video.UIManager.VOLUME_BAR];
            this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
            $r2 = $r3.percentage;
            if (finish) {
                clearInterval(this._volumeBarIntervalID);
                this._volumeBarIntervalID = 0;
                this._vc.addEventListener("volumeUpdate", this);
            }
            if ((((finish || !(this._volumeBarScrubTolerance > 0)) || (Math.abs($r2 - this._lastVolumePos) > this._volumeBarScrubTolerance)) || ($r2 < this._volumeBarScrubTolerance)) || ($r2 > (100 - this._volumeBarScrubTolerance))) {
                if (!!!($r2 == this._lastVolumePos)) {
                    if (this._isMuted) {
                        this.cachedSoundLevel = $r2;
                    } else {
                        this._vc.__set__volume($r2);
                    }
                }
            }
        };
    $r2.doBufferingDelay = function () {
            clearInterval(this._bufferingDelayIntervalID);
            this._bufferingDelayIntervalID = 0;
            $r2 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            if (this._vc.__get__state() == mx.video.FLVPlayback.BUFFERING) {
                this._bufferingOn = true;
                this.handleEvent({vp: this._vc.__get__visibleVideoPlayerIndex(), state: mx.video.FLVPlayback.BUFFERING, type: "stateChange"});
            }
            this._vc.__set__activeVideoPlayerIndex($r2);
        };
    $r2.dispatchMessage = function (ctrl) {
            if (ctrl.id == mx.video.UIManager.SEEK_BAR_HANDLE) {
                this._vc._scrubStart();
            }
            $r2 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            $r0 = ctrl.id;
            if (!($r0 === mx.video.UIManager.PAUSE_BUTTON)) {
                if (!($r0 === mx.video.UIManager.PLAY_BUTTON)) {
                    if (!($r0 === mx.video.UIManager.STOP_BUTTON)) {
                        if (!($r0 === mx.video.UIManager.SEEK_BAR_HANDLE)) {
                            if (!($r0 === mx.video.UIManager.VOLUME_BAR_HANDLE)) {
                                if (!($r0 === mx.video.UIManager.BACK_BUTTON)) {
                                    if (!($r0 === mx.video.UIManager.FORWARD_BUTTON)) {
                                        if (!($r0 === mx.video.UIManager.MUTE_ON_BUTTON)) {
                                            if (!($r0 === mx.video.UIManager.MUTE_OFF_BUTTON)) {
                                                goto L05de;
                                                this._vc.pause();
                                                goto L05ed;
                                                this._vc.play();
                                                goto L05ed;
                                                this._vc.stop();
                                                goto L05ed;
                                                this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
                                                this._lastScrubPos = this.controls[mx.video.UIManager.SEEK_BAR].percentage;
                                                this._vc.removeEventListener("playheadUpdate", this);
                                                if (this._vc.__get__playing() || this._vc.__get__buffering()) {
                                                    this._playAfterScrub = true;
                                                } else {
                                                    if (!!!(this._vc.__get__state() == mx.video.VideoPlayer.SEEKING)) {
                                                        this._playAfterScrub = false;
                                                    }
                                                }
                                                this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
                                                this.startHandleDrag(mx.video.UIManager.SEEK_BAR, mx.video.UIManager.SEEK_BAR_HANDLE);
                                                this._vc.pause();
                                                goto L05ed;
                                                this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                                                this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                                                this._vc.removeEventListener("volumeUpdate", this);
                                                this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                                                this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                                                goto L05ed;
                                                this._vc.seekToPrevNavCuePoint();
                                                goto L05ed;
                                                this._vc.seekToNextNavCuePoint();
                                            } else {
                                                if (!this._isMuted) {
                                                    this._isMuted = true;
                                                    this.cachedSoundLevel = this._vc.volume;
                                                    this._vc.__set__volume(0);
                                                } else {
                                                    this._isMuted = false;
                                                    this._vc.__set__volume(this.cachedSoundLevel);
                                                }
                                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                                                goto L05ed;
                                                throw new Error("Unknown ButtonControl");
                                            }
                                        } else {
                                            if (!this._isMuted) {
                                                this._isMuted = true;
                                                this.cachedSoundLevel = this._vc.volume;
                                                this._vc.__set__volume(0);
                                            } else {
                                                this._isMuted = false;
                                                this._vc.__set__volume(this.cachedSoundLevel);
                                            }
                                            this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                            this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                            this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                            this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                                            goto L05ed;
                                            throw new Error("Unknown ButtonControl");
                                        }
                                    } else {
                                        this._vc.seekToNextNavCuePoint();
                                        goto L05ed;
                                        if (!this._isMuted) {
                                            this._isMuted = true;
                                            this.cachedSoundLevel = this._vc.volume;
                                            this._vc.__set__volume(0);
                                        } else {
                                            this._isMuted = false;
                                            this._vc.__set__volume(this.cachedSoundLevel);
                                        }
                                        this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                        this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                        this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                        this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                                        goto L05ed;
                                        throw new Error("Unknown ButtonControl");
                                    }
                                } else {
                                    this._vc.seekToPrevNavCuePoint();
                                    goto L05ed;
                                    this._vc.seekToNextNavCuePoint();
                                    goto L05ed;
                                    if (!this._isMuted) {
                                        this._isMuted = true;
                                        this.cachedSoundLevel = this._vc.volume;
                                        this._vc.__set__volume(0);
                                    } else {
                                        this._isMuted = false;
                                        this._vc.__set__volume(this.cachedSoundLevel);
                                    }
                                    this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                    this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                    this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                    this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                                    goto L05ed;
                                    throw new Error("Unknown ButtonControl");
                                }
                            } else {
                                this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                                this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                                this._vc.removeEventListener("volumeUpdate", this);
                                this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                                this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                                goto L05ed;
                                this._vc.seekToPrevNavCuePoint();
                                goto L05ed;
                                this._vc.seekToNextNavCuePoint();
                                goto L05ed;
                                if (!this._isMuted) {
                                    this._isMuted = true;
                                    this.cachedSoundLevel = this._vc.volume;
                                    this._vc.__set__volume(0);
                                } else {
                                    this._isMuted = false;
                                    this._vc.__set__volume(this.cachedSoundLevel);
                                }
                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                                goto L05ed;
                                throw new Error("Unknown ButtonControl");
                            }
                        } else {
                            this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
                            this._lastScrubPos = this.controls[mx.video.UIManager.SEEK_BAR].percentage;
                            this._vc.removeEventListener("playheadUpdate", this);
                            if (this._vc.__get__playing() || this._vc.__get__buffering()) {
                                this._playAfterScrub = true;
                            } else {
                                if (!!!(this._vc.__get__state() == mx.video.VideoPlayer.SEEKING)) {
                                    this._playAfterScrub = false;
                                }
                            }
                            this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
                            this.startHandleDrag(mx.video.UIManager.SEEK_BAR, mx.video.UIManager.SEEK_BAR_HANDLE);
                            this._vc.pause();
                            goto L05ed;
                            this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                            this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                            this._vc.removeEventListener("volumeUpdate", this);
                            this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                            this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                            goto L05ed;
                            this._vc.seekToPrevNavCuePoint();
                            goto L05ed;
                            this._vc.seekToNextNavCuePoint();
                            goto L05ed;
                            if (!this._isMuted) {
                                this._isMuted = true;
                                this.cachedSoundLevel = this._vc.volume;
                                this._vc.__set__volume(0);
                            } else {
                                this._isMuted = false;
                                this._vc.__set__volume(this.cachedSoundLevel);
                            }
                            this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                            this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                            this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                            this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                            goto L05ed;
                            throw new Error("Unknown ButtonControl");
                        }
                    } else {
                        this._vc.stop();
                        goto L05ed;
                        this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
                        this._lastScrubPos = this.controls[mx.video.UIManager.SEEK_BAR].percentage;
                        this._vc.removeEventListener("playheadUpdate", this);
                        if (this._vc.__get__playing() || this._vc.__get__buffering()) {
                            this._playAfterScrub = true;
                        } else {
                            if (!!!(this._vc.__get__state() == mx.video.VideoPlayer.SEEKING)) {
                                this._playAfterScrub = false;
                            }
                        }
                        this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
                        this.startHandleDrag(mx.video.UIManager.SEEK_BAR, mx.video.UIManager.SEEK_BAR_HANDLE);
                        this._vc.pause();
                        goto L05ed;
                        this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                        this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                        this._vc.removeEventListener("volumeUpdate", this);
                        this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                        this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                        goto L05ed;
                        this._vc.seekToPrevNavCuePoint();
                        goto L05ed;
                        this._vc.seekToNextNavCuePoint();
                        goto L05ed;
                        if (!this._isMuted) {
                            this._isMuted = true;
                            this.cachedSoundLevel = this._vc.volume;
                            this._vc.__set__volume(0);
                        } else {
                            this._isMuted = false;
                            this._vc.__set__volume(this.cachedSoundLevel);
                        }
                        this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                        this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                        this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                        this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                        goto L05ed;
                        throw new Error("Unknown ButtonControl");
                    }
                } else {
                    this._vc.play();
                    goto L05ed;
                    this._vc.stop();
                    goto L05ed;
                    this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
                    this._lastScrubPos = this.controls[mx.video.UIManager.SEEK_BAR].percentage;
                    this._vc.removeEventListener("playheadUpdate", this);
                    if (this._vc.__get__playing() || this._vc.__get__buffering()) {
                        this._playAfterScrub = true;
                    } else {
                        if (!!!(this._vc.__get__state() == mx.video.VideoPlayer.SEEKING)) {
                            this._playAfterScrub = false;
                        }
                    }
                    this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
                    this.startHandleDrag(mx.video.UIManager.SEEK_BAR, mx.video.UIManager.SEEK_BAR_HANDLE);
                    this._vc.pause();
                    goto L05ed;
                    this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                    this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                    this._vc.removeEventListener("volumeUpdate", this);
                    this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                    this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                    goto L05ed;
                    this._vc.seekToPrevNavCuePoint();
                    goto L05ed;
                    this._vc.seekToNextNavCuePoint();
                    goto L05ed;
                    if (!this._isMuted) {
                        this._isMuted = true;
                        this.cachedSoundLevel = this._vc.volume;
                        this._vc.__set__volume(0);
                    } else {
                        this._isMuted = false;
                        this._vc.__set__volume(this.cachedSoundLevel);
                    }
                    this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                    this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                    this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                    this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                    goto L05ed;
                    throw new Error("Unknown ButtonControl");
                }
            } else {
                this._vc.pause();
                goto L05ed;
                this._vc.play();
                goto L05ed;
                this._vc.stop();
                goto L05ed;
                this.calcPercentageFromHandle(mx.video.UIManager.SEEK_BAR);
                this._lastScrubPos = this.controls[mx.video.UIManager.SEEK_BAR].percentage;
                this._vc.removeEventListener("playheadUpdate", this);
                if (this._vc.__get__playing() || this._vc.__get__buffering()) {
                    this._playAfterScrub = true;
                } else {
                    if (!!!(this._vc.__get__state() == mx.video.VideoPlayer.SEEKING)) {
                        this._playAfterScrub = false;
                    }
                }
                this._seekBarIntervalID = setInterval(this, "seekBarListener", this._seekBarInterval, false);
                this.startHandleDrag(mx.video.UIManager.SEEK_BAR, mx.video.UIManager.SEEK_BAR_HANDLE);
                this._vc.pause();
                goto L05ed;
                this.calcPercentageFromHandle(mx.video.UIManager.VOLUME_BAR);
                this._lastVolumePos = this.controls[mx.video.UIManager.VOLUME_BAR].percentage;
                this._vc.removeEventListener("volumeUpdate", this);
                this._volumeBarIntervalID = setInterval(this, "volumeBarListener", this._volumeBarInterval, false);
                this.startHandleDrag(mx.video.UIManager.VOLUME_BAR, mx.video.UIManager.VOLUME_BAR_HANDLE);
                goto L05ed;
                this._vc.seekToPrevNavCuePoint();
                goto L05ed;
                this._vc.seekToNextNavCuePoint();
                goto L05ed;
                if (!this._isMuted) {
                    this._isMuted = true;
                    this.cachedSoundLevel = this._vc.volume;
                    this._vc.__set__volume(0);
                } else {
                    this._isMuted = false;
                    this._vc.__set__volume(this.cachedSoundLevel);
                }
                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_OFF_BUTTON, mx.video.FLVPlayback.PLAYING);
                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_OFF_BUTTON]);
                this.setEnabledAndVisibleForState(mx.video.UIManager.MUTE_ON_BUTTON, mx.video.FLVPlayback.PLAYING);
                this.skinButtonControl(this.controls[mx.video.UIManager.MUTE_ON_BUTTON]);
                goto L05ed;
            }
            throw new Error("Unknown ButtonControl");
            this._vc.__set__activeVideoPlayerIndex($r2);
        };
    $r2.setEnabledAndVisibleForState = function (index, state) {
            $r5 = this._vc.__get__activeVideoPlayerIndex();
            this._vc.__set__activeVideoPlayerIndex(this._vc.visibleVideoPlayerIndex);
            $r3 = state;
            if (($r3 == mx.video.FLVPlayback.BUFFERING) && !this._bufferingOn) {
                $r3 = mx.video.FLVPlayback.PLAYING;
            }
            $r0 = index;
            if (!($r0 === mx.video.UIManager.VOLUME_BAR)) {
                if (!($r0 === mx.video.UIManager.VOLUME_BAR_HANDLE)) {
                    if (!($r0 === mx.video.UIManager.MUTE_ON_BUTTON)) {
                        if (!($r0 === mx.video.UIManager.MUTE_OFF_BUTTON)) {
                            goto L0238;
                            this.controls[index].myEnabled = true;
                            this.controls[index].enabled = this._controlsEnabled;
                            goto L033b;
                            this.controls[index].myEnabled = !this._isMuted;
                            if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                                this.controls[index]._visible = this.controls[index].myEnabled;
                            }
                        } else {
                            this.controls[index].myEnabled = this._isMuted;
                            if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                                this.controls[index]._visible = this.controls[index].myEnabled;
                            }
                            goto L033b;
                            $r0 = $r3;
                            if (!($r0 === mx.video.FLVPlayback.LOADING)) {
                                if (!($r0 === mx.video.FLVPlayback.CONNECTION_ERROR)) {
                                    if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                        if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                            goto L031b;
                                            this.controls[index].myEnabled = false;
                                            goto L0336;
                                            this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                        } else {
                                            goto L0336;
                                            this.controls[index].myEnabled = true;
                                            goto L0336;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                        goto L0336;
                                        goto L0336;
                                        this.controls[index].myEnabled = true;
                                        goto L0336;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L0336;
                                    this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                    goto L0336;
                                    goto L0336;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0336;
                                this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                goto L0336;
                                goto L0336;
                            }
                            this.controls[index].myEnabled = true;
                            goto L0336;
                            goto L033b;
                        }
                    } else {
                        this.controls[index].myEnabled = !this._isMuted;
                        if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                            this.controls[index]._visible = this.controls[index].myEnabled;
                        }
                        goto L033b;
                        this.controls[index].myEnabled = this._isMuted;
                        if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                            this.controls[index]._visible = this.controls[index].myEnabled;
                        }
                        goto L033b;
                        $r0 = $r3;
                        if (!($r0 === mx.video.FLVPlayback.LOADING)) {
                            if (!($r0 === mx.video.FLVPlayback.CONNECTION_ERROR)) {
                                if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                    if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                        goto L031b;
                                        this.controls[index].myEnabled = false;
                                        goto L0336;
                                        this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                    } else {
                                        goto L0336;
                                        this.controls[index].myEnabled = true;
                                        goto L0336;
                                    }
                                } else {
                                    this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                    goto L0336;
                                    goto L0336;
                                    this.controls[index].myEnabled = true;
                                    goto L0336;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0336;
                                this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                                goto L0336;
                                goto L0336;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0336;
                            this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                            goto L0336;
                            goto L0336;
                        }
                        this.controls[index].myEnabled = true;
                        goto L0336;
                        goto L033b;
                    }
                } else {
                    this.controls[index].myEnabled = true;
                    this.controls[index].enabled = this._controlsEnabled;
                    goto L033b;
                    this.controls[index].myEnabled = !this._isMuted;
                    if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                        this.controls[index]._visible = this.controls[index].myEnabled;
                    }
                    goto L033b;
                    this.controls[index].myEnabled = this._isMuted;
                    if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                        this.controls[index]._visible = this.controls[index].myEnabled;
                    }
                    goto L033b;
                }
            } else {
                this.controls[index].myEnabled = true;
                this.controls[index].enabled = this._controlsEnabled;
                goto L033b;
                this.controls[index].myEnabled = !this._isMuted;
                if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                    this.controls[index]._visible = this.controls[index].myEnabled;
                }
                goto L033b;
                this.controls[index].myEnabled = this._isMuted;
                if (!!!(this.controls[mx.video.UIManager.MUTE_BUTTON] == undefined)) {
                    this.controls[index]._visible = this.controls[index].myEnabled;
                }
                goto L033b;
            }
            $r0 = $r3;
            if (!($r0 === mx.video.FLVPlayback.LOADING)) {
                if (!($r0 === mx.video.FLVPlayback.CONNECTION_ERROR)) {
                    if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                        if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                            goto L031b;
                            this.controls[index].myEnabled = false;
                            goto L0336;
                            this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                        } else {
                            goto L0336;
                            this.controls[index].myEnabled = true;
                            goto L0336;
                        }
                    } else {
                        this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                        goto L0336;
                        goto L0336;
                        this.controls[index].myEnabled = true;
                        goto L0336;
                    }
                } else {
                    this.controls[index].myEnabled = false;
                    goto L0336;
                    this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                    goto L0336;
                    goto L0336;
                }
            } else {
                this.controls[index].myEnabled = false;
                goto L0336;
                this.controls[index].myEnabled = !(this._vc.__get__contentPath() == undefined);
                goto L0336;
                goto L0336;
            }
            this.controls[index].myEnabled = true;
            goto L0336;
            goto L033b;
            $r0 = index;
            if (!($r0 === mx.video.UIManager.SEEK_BAR)) {
                if (!($r0 === mx.video.UIManager.BUFFERING_BAR)) {
                    if (!($r0 === mx.video.UIManager.PAUSE_BUTTON)) {
                        if (!($r0 === mx.video.UIManager.PLAY_BUTTON)) {
                            if (!($r0 === mx.video.UIManager.STOP_BUTTON)) {
                                if (!($r0 === mx.video.UIManager.BACK_BUTTON)) {
                                    if (!($r0 === mx.video.UIManager.FORWARD_BUTTON)) {
                                        goto L0d50;
                                        $r0 = $r3;
                                        if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                                    if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                                        if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                                            if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                                goto L055e;
                                                                this.controls[index].myEnabled = true;
                                                            } else {
                                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                                goto L0579;
                                                                this.controls[index].myEnabled = false;
                                                                goto L0579;
                                                            }
                                                        } else {
                                                            this.controls[index].myEnabled = true;
                                                            goto L0579;
                                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                            goto L0579;
                                                        }
                                                    } else {
                                                        this.controls[index].myEnabled = true;
                                                        goto L0579;
                                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                        goto L0579;
                                                    }
                                                } else {
                                                    this.controls[index].myEnabled = true;
                                                    goto L0579;
                                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                    goto L0579;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = true;
                                                goto L0579;
                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                goto L0579;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = true;
                                            goto L0579;
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0579;
                                        }
                                        this.controls[index].myEnabled = false;
                                        goto L0579;
                                        if (this.controls[index].myEnabled) {
                                            this.controls[index].myEnabled = !isNaN(this._vc.__get__totalTime()) && (this._vc.__get__totalTime() > 0);
                                        }
                                        this.controls[index].handle_mc.myEnabled = this.controls[index].myEnabled;
                                        this.controls[index].handle_mc.enabled = this.controls[index].handle_mc.myEnabled;
                                        this.controls[index].handle_mc._visible = this.controls[index].myEnabled;
                                        $r4 = ((!this._bufferingBarHides || this.controls[index].myEnabled) || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined)) || !this.controls[mx.video.UIManager.BUFFERING_BAR]._visible;
                                        this.controls[index]._visible = $r4;
                                        this.controls[index].progress_mc._visible = $r4;
                                        this.controls[index].progress_mc.fill_mc._visible = $r4;
                                        this.controls[index].fullness_mc._visible = $r4;
                                        this.controls[index].progress_mc.fill_mc._visible = $r4;
                                        goto L0d50;
                                        $r0 = $r3;
                                        if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                                    if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                                        if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                                        } else {
                                                            this.controls[index].myEnabled = false;
                                                            goto L087c;
                                                        }
                                                    } else {
                                                        this.controls[index].myEnabled = false;
                                                        goto L087c;
                                                    }
                                                } else {
                                                    this.controls[index].myEnabled = false;
                                                    goto L087c;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = false;
                                                goto L087c;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = false;
                                            goto L087c;
                                        }
                                        this.controls[index].myEnabled = true;
                                        goto L087c;
                                        this.controls[index]._visible = this.controls[index].myEnabled;
                                        this.controls[index].fill_mc._visible = this.controls[index].myEnabled;
                                        goto L0d50;
                                        $r0 = $r3;
                                        if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                                    if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                            if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                                goto L0a23;
                                                                this.controls[index].myEnabled = false;
                                                                goto L0a23;
                                                                this.controls[index].myEnabled = true;
                                                            } else {
                                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                                goto L0a23;
                                                            }
                                                        } else {
                                                            this.controls[index].myEnabled = true;
                                                            goto L0a23;
                                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                            goto L0a23;
                                                        }
                                                    } else {
                                                        this.controls[index].myEnabled = false;
                                                        goto L0a23;
                                                        this.controls[index].myEnabled = true;
                                                        goto L0a23;
                                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                        goto L0a23;
                                                    }
                                                } else {
                                                    this.controls[index].myEnabled = false;
                                                    goto L0a23;
                                                    this.controls[index].myEnabled = true;
                                                    goto L0a23;
                                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                    goto L0a23;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = false;
                                                goto L0a23;
                                                this.controls[index].myEnabled = true;
                                                goto L0a23;
                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                goto L0a23;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = false;
                                            goto L0a23;
                                            this.controls[index].myEnabled = true;
                                            goto L0a23;
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0a23;
                                        }
                                        if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                                            this.controls[index]._visible = this.controls[index].myEnabled;
                                        }
                                        goto L0d50;
                                        $r0 = $r3;
                                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                        goto L0b8a;
                                                        this.controls[index].myEnabled = false;
                                                        goto L0b8a;
                                                        this.controls[index].myEnabled = true;
                                                    } else {
                                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                        goto L0b8a;
                                                    }
                                                } else {
                                                    this.controls[index].myEnabled = true;
                                                    goto L0b8a;
                                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                    goto L0b8a;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = true;
                                                goto L0b8a;
                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                goto L0b8a;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = false;
                                            goto L0b8a;
                                            this.controls[index].myEnabled = true;
                                            goto L0b8a;
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0b8a;
                                        }
                                        if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                                            this.controls[index]._visible = !this.controls[mx.video.UIManager.PAUSE_BUTTON]._visible;
                                        }
                                        goto L0d50;
                                        $r0 = $r3;
                                        if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                        if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                            goto L0cda;
                                                            this.controls[index].myEnabled = false;
                                                        } else {
                                                            this.controls[index].myEnabled = true;
                                                            goto L0cda;
                                                        }
                                                    } else {
                                                        this.controls[index].myEnabled = true;
                                                        goto L0cda;
                                                    }
                                                } else {
                                                    this.controls[index].myEnabled = true;
                                                    goto L0cda;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = false;
                                                goto L0cda;
                                                this.controls[index].myEnabled = true;
                                                goto L0cda;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = false;
                                            goto L0cda;
                                            this.controls[index].myEnabled = true;
                                            goto L0cda;
                                        }
                                    } else {
                                        if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                                        } else {
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0d50;
                                        }
                                    }
                                } else {
                                    if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                                    } else {
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0d50;
                                    }
                                }
                            } else {
                                $r0 = $r3;
                                if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                    if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                                if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                    goto L0cda;
                                                    this.controls[index].myEnabled = false;
                                                } else {
                                                    this.controls[index].myEnabled = true;
                                                    goto L0cda;
                                                }
                                            } else {
                                                this.controls[index].myEnabled = true;
                                                goto L0cda;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = true;
                                            goto L0cda;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = false;
                                        goto L0cda;
                                        this.controls[index].myEnabled = true;
                                        goto L0cda;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L0cda;
                                    this.controls[index].myEnabled = true;
                                    goto L0cda;
                                }
                                goto L0d50;
                                if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                                } else {
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0d50;
                                }
                            }
                        } else {
                            $r0 = $r3;
                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                    if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                        if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                            goto L0b8a;
                                            this.controls[index].myEnabled = false;
                                            goto L0b8a;
                                            this.controls[index].myEnabled = true;
                                        } else {
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0b8a;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = true;
                                        goto L0b8a;
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0b8a;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0b8a;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0b8a;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0b8a;
                                this.controls[index].myEnabled = true;
                                goto L0b8a;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0b8a;
                            }
                            if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                                this.controls[index]._visible = !this.controls[mx.video.UIManager.PAUSE_BUTTON]._visible;
                            }
                            goto L0d50;
                            $r0 = $r3;
                            if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                                if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                    if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                            if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                goto L0cda;
                                                this.controls[index].myEnabled = false;
                                            } else {
                                                this.controls[index].myEnabled = true;
                                                goto L0cda;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = true;
                                            goto L0cda;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = true;
                                        goto L0cda;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L0cda;
                                    this.controls[index].myEnabled = true;
                                    goto L0cda;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0cda;
                                this.controls[index].myEnabled = true;
                                goto L0cda;
                            }
                            goto L0d50;
                            if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                            } else {
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0d50;
                            }
                        }
                    } else {
                        $r0 = $r3;
                        if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                    if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                            if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                                goto L0a23;
                                                this.controls[index].myEnabled = false;
                                                goto L0a23;
                                                this.controls[index].myEnabled = true;
                                            } else {
                                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                                goto L0a23;
                                            }
                                        } else {
                                            this.controls[index].myEnabled = true;
                                            goto L0a23;
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0a23;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = false;
                                        goto L0a23;
                                        this.controls[index].myEnabled = true;
                                        goto L0a23;
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0a23;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L0a23;
                                    this.controls[index].myEnabled = true;
                                    goto L0a23;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0a23;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0a23;
                                this.controls[index].myEnabled = true;
                                goto L0a23;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0a23;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0a23;
                            this.controls[index].myEnabled = true;
                            goto L0a23;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0a23;
                        }
                        if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                            this.controls[index]._visible = this.controls[index].myEnabled;
                        }
                        goto L0d50;
                        $r0 = $r3;
                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                        goto L0b8a;
                                        this.controls[index].myEnabled = false;
                                        goto L0b8a;
                                        this.controls[index].myEnabled = true;
                                    } else {
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0b8a;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0b8a;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0b8a;
                                }
                            } else {
                                this.controls[index].myEnabled = true;
                                goto L0b8a;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0b8a;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0b8a;
                            this.controls[index].myEnabled = true;
                            goto L0b8a;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0b8a;
                        }
                        if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                            this.controls[index]._visible = !this.controls[mx.video.UIManager.PAUSE_BUTTON]._visible;
                        }
                        goto L0d50;
                        $r0 = $r3;
                        if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                            if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                                if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                        if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                            goto L0cda;
                                            this.controls[index].myEnabled = false;
                                        } else {
                                            this.controls[index].myEnabled = true;
                                            goto L0cda;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = true;
                                        goto L0cda;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0cda;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0cda;
                                this.controls[index].myEnabled = true;
                                goto L0cda;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0cda;
                            this.controls[index].myEnabled = true;
                            goto L0cda;
                        }
                        goto L0d50;
                        if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                        } else {
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0d50;
                        }
                    }
                } else {
                    $r0 = $r3;
                    if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                        if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                            if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                    if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                    } else {
                                        this.controls[index].myEnabled = false;
                                        goto L087c;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L087c;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L087c;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L087c;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L087c;
                    }
                    this.controls[index].myEnabled = true;
                    goto L087c;
                    this.controls[index]._visible = this.controls[index].myEnabled;
                    this.controls[index].fill_mc._visible = this.controls[index].myEnabled;
                    goto L0d50;
                    $r0 = $r3;
                    if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                        if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                            if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                        if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                            goto L0a23;
                                            this.controls[index].myEnabled = false;
                                            goto L0a23;
                                            this.controls[index].myEnabled = true;
                                        } else {
                                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                            goto L0a23;
                                        }
                                    } else {
                                        this.controls[index].myEnabled = true;
                                        goto L0a23;
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0a23;
                                    }
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L0a23;
                                    this.controls[index].myEnabled = true;
                                    goto L0a23;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0a23;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0a23;
                                this.controls[index].myEnabled = true;
                                goto L0a23;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0a23;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0a23;
                            this.controls[index].myEnabled = true;
                            goto L0a23;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0a23;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L0a23;
                        this.controls[index].myEnabled = true;
                        goto L0a23;
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0a23;
                    }
                    if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                        this.controls[index]._visible = this.controls[index].myEnabled;
                    }
                    goto L0d50;
                    $r0 = $r3;
                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                        if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                            if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                    goto L0b8a;
                                    this.controls[index].myEnabled = false;
                                    goto L0b8a;
                                    this.controls[index].myEnabled = true;
                                } else {
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0b8a;
                                }
                            } else {
                                this.controls[index].myEnabled = true;
                                goto L0b8a;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0b8a;
                            }
                        } else {
                            this.controls[index].myEnabled = true;
                            goto L0b8a;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0b8a;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L0b8a;
                        this.controls[index].myEnabled = true;
                        goto L0b8a;
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0b8a;
                    }
                    if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                        this.controls[index]._visible = !this.controls[mx.video.UIManager.PAUSE_BUTTON]._visible;
                    }
                    goto L0d50;
                    $r0 = $r3;
                    if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                        if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                            if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                                if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                        goto L0cda;
                                        this.controls[index].myEnabled = false;
                                    } else {
                                        this.controls[index].myEnabled = true;
                                        goto L0cda;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0cda;
                                }
                            } else {
                                this.controls[index].myEnabled = true;
                                goto L0cda;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0cda;
                            this.controls[index].myEnabled = true;
                            goto L0cda;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L0cda;
                        this.controls[index].myEnabled = true;
                        goto L0cda;
                    }
                    goto L0d50;
                    if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                    } else {
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0d50;
                    }
                }
            } else {
                $r0 = $r3;
                if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                            if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                        goto L055e;
                                        this.controls[index].myEnabled = true;
                                    } else {
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0579;
                                        this.controls[index].myEnabled = false;
                                        goto L0579;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0579;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0579;
                                }
                            } else {
                                this.controls[index].myEnabled = true;
                                goto L0579;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0579;
                            }
                        } else {
                            this.controls[index].myEnabled = true;
                            goto L0579;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0579;
                        }
                    } else {
                        this.controls[index].myEnabled = true;
                        goto L0579;
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0579;
                    }
                } else {
                    this.controls[index].myEnabled = true;
                    goto L0579;
                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                    goto L0579;
                }
                this.controls[index].myEnabled = false;
                goto L0579;
                if (this.controls[index].myEnabled) {
                    this.controls[index].myEnabled = !isNaN(this._vc.__get__totalTime()) && (this._vc.__get__totalTime() > 0);
                }
                this.controls[index].handle_mc.myEnabled = this.controls[index].myEnabled;
                this.controls[index].handle_mc.enabled = this.controls[index].handle_mc.myEnabled;
                this.controls[index].handle_mc._visible = this.controls[index].myEnabled;
                $r4 = ((!this._bufferingBarHides || this.controls[index].myEnabled) || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined)) || !this.controls[mx.video.UIManager.BUFFERING_BAR]._visible;
                this.controls[index]._visible = $r4;
                this.controls[index].progress_mc._visible = $r4;
                this.controls[index].progress_mc.fill_mc._visible = $r4;
                this.controls[index].fullness_mc._visible = $r4;
                this.controls[index].progress_mc.fill_mc._visible = $r4;
                goto L0d50;
                $r0 = $r3;
                if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                    if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                            if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                if (!($r0 === mx.video.FLVPlayback.SEEKING)) {
                                } else {
                                    this.controls[index].myEnabled = false;
                                    goto L087c;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L087c;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L087c;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L087c;
                    }
                } else {
                    this.controls[index].myEnabled = false;
                    goto L087c;
                }
                this.controls[index].myEnabled = true;
                goto L087c;
                this.controls[index]._visible = this.controls[index].myEnabled;
                this.controls[index].fill_mc._visible = this.controls[index].myEnabled;
                goto L0d50;
                $r0 = $r3;
                if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                    if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                            if (!($r0 === mx.video.FLVPlayback.REWINDING)) {
                                if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                    if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                        goto L0a23;
                                        this.controls[index].myEnabled = false;
                                        goto L0a23;
                                        this.controls[index].myEnabled = true;
                                    } else {
                                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                        goto L0a23;
                                    }
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0a23;
                                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                    goto L0a23;
                                }
                            } else {
                                this.controls[index].myEnabled = false;
                                goto L0a23;
                                this.controls[index].myEnabled = true;
                                goto L0a23;
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0a23;
                            }
                        } else {
                            this.controls[index].myEnabled = false;
                            goto L0a23;
                            this.controls[index].myEnabled = true;
                            goto L0a23;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0a23;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L0a23;
                        this.controls[index].myEnabled = true;
                        goto L0a23;
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0a23;
                    }
                } else {
                    this.controls[index].myEnabled = false;
                    goto L0a23;
                    this.controls[index].myEnabled = true;
                    goto L0a23;
                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                    goto L0a23;
                }
                if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                    this.controls[index]._visible = this.controls[index].myEnabled;
                }
                goto L0d50;
                $r0 = $r3;
                if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                    if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                            if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                goto L0b8a;
                                this.controls[index].myEnabled = false;
                                goto L0b8a;
                                this.controls[index].myEnabled = true;
                            } else {
                                this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                                goto L0b8a;
                            }
                        } else {
                            this.controls[index].myEnabled = true;
                            goto L0b8a;
                            this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                            goto L0b8a;
                        }
                    } else {
                        this.controls[index].myEnabled = true;
                        goto L0b8a;
                        this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                        goto L0b8a;
                    }
                } else {
                    this.controls[index].myEnabled = false;
                    goto L0b8a;
                    this.controls[index].myEnabled = true;
                    goto L0b8a;
                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                    goto L0b8a;
                }
                if (!!!(this.controls[mx.video.UIManager.PLAY_PAUSE_BUTTON] == undefined)) {
                    this.controls[index]._visible = !this.controls[mx.video.UIManager.PAUSE_BUTTON]._visible;
                }
                goto L0d50;
                $r0 = $r3;
                if (!($r0 === mx.video.FLVPlayback.DISCONNECTED)) {
                    if (!($r0 === mx.video.FLVPlayback.STOPPED)) {
                        if (!($r0 === mx.video.FLVPlayback.PAUSED)) {
                            if (!($r0 === mx.video.FLVPlayback.PLAYING)) {
                                if (!($r0 === mx.video.FLVPlayback.BUFFERING)) {
                                    goto L0cda;
                                    this.controls[index].myEnabled = false;
                                } else {
                                    this.controls[index].myEnabled = true;
                                    goto L0cda;
                                }
                            } else {
                                this.controls[index].myEnabled = true;
                                goto L0cda;
                            }
                        } else {
                            this.controls[index].myEnabled = true;
                            goto L0cda;
                        }
                    } else {
                        this.controls[index].myEnabled = false;
                        goto L0cda;
                        this.controls[index].myEnabled = true;
                        goto L0cda;
                    }
                } else {
                    this.controls[index].myEnabled = false;
                    goto L0cda;
                    this.controls[index].myEnabled = true;
                    goto L0cda;
                }
                goto L0d50;
                if (!($r3 === mx.video.FLVPlayback.BUFFERING)) {
                } else {
                    this.controls[index].myEnabled = !this._bufferingBarHides || (this.controls[mx.video.UIManager.BUFFERING_BAR] == undefined);
                    goto L0d50;
                }
            }
            this.controls[index].enabled = this._controlsEnabled && this.controls[index].myEnabled;
            this._vc.__set__activeVideoPlayerIndex($r5);
        };
    $r2.setupSkinAutoHide = function () {
            $r2 = this._vc.getVideoPlayer(this._vc.__get__visibleVideoPlayerIndex());
            if (this._skinAutoHide && !(this.skin_mc == undefined)) {
                this.skinAutoHideHitTest();
                if (this._skinAutoHideIntervalID == 0) {
                    this._skinAutoHideIntervalID = setInterval(this, "skinAutoHideHitTest", mx.video.UIManager.SKIN_AUTO_HIDE_INTERVAL);
                }
            } else {
                this.skin_mc._visible = this.__visible;
                clearInterval(this._skinAutoHideIntervalID);
                this._skinAutoHideIntervalID = 0;
            }
        };
    $r2.skinAutoHideHitTest = function () {
            if (!this.__visible) {
                this.skin_mc._visible = false;
            } else {
                $r4 = this._vc.getVideoPlayer(this._vc.__get__visibleVideoPlayerIndex());
                $r3 = $r4.hitTest(_root._xmouse, _root._ymouse, true);
                if (!$r3 && !(this.border_mc == undefined)) {
                    $r3 = this.border_mc.hitTest(_root._xmouse, _root._ymouse, true);
                }
                this.skin_mc._visible = $r3;
            }
        };
    $r1.version = "1.0.0.103";
    $r1.PAUSE_BUTTON = 0;
    $r1.PLAY_BUTTON = 1;
    $r1.STOP_BUTTON = 2;
    $r1.SEEK_BAR_HANDLE = 3;
    $r1.BACK_BUTTON = 4;
    $r1.FORWARD_BUTTON = 5;
    $r1.MUTE_ON_BUTTON = 6;
    $r1.MUTE_OFF_BUTTON = 7;
    $r1.VOLUME_BAR_HANDLE = 8;
    $r1.NUM_BUTTONS = 9;
    $r1.PLAY_PAUSE_BUTTON = 9;
    $r1.MUTE_BUTTON = 10;
    $r1.BUFFERING_BAR = 11;
    $r1.SEEK_BAR = 12;
    $r1.VOLUME_BAR = 13;
    $r1.NUM_CONTROLS = 14;
    $r1.UP_STATE = 0;
    $r1.OVER_STATE = 1;
    $r1.DOWN_STATE = 2;
    $r1.SKIN_AUTO_HIDE_INTERVAL = 200;
    $r1.VOLUME_BAR_INTERVAL_DEFAULT = 250;
    $r1.VOLUME_BAR_SCRUB_TOLERANCE_DEFAULT = 0;
    $r1.SEEK_BAR_INTERVAL_DEFAULT = 250;
    $r1.SEEK_BAR_SCRUB_TOLERANCE_DEFAULT = 5;
    $r1.BUFFERING_DELAY_INTERVAL_DEFAULT = 1000;
}
ASSetPropFlags(mx.video.UIManager.prototype, null, 1);
// ======== DoInitAction sprite=15 __Packages.mx.utils.Delegate
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.utils) {
    _global.mx.utils = new Object();
}
<stack?>;
if (!_global.mx.utils.Delegate) {
    $r1 = function (f) {
            super();
            this.func = f;
        };
    mx.utils.Delegate = $r1;
    mx.utils.Delegate.extends(Object);
    $r2 = $r1.prototype;
    $r1.create = function (obj, func) {
            $r2 = function () {
                        $r2 = arguments.callee.target;
                        $r3 = arguments.callee.func;
                        return $r3.apply($r2, arguments);
                    };
            $r2.target = obj;
            $r2.func = func;
            return $r2;
        };
    $r2.createDelegate = function (obj) {
            return mx.utils.Delegate.create(obj, this.func);
        };
}
ASSetPropFlags(mx.utils.Delegate.prototype, null, 1);
// ======== DoInitAction sprite=16 __Packages.mx.video.SMILManager
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.SMILManager) {
    $r1 = function (owner) {
            this._owner = owner;
        };
    mx.video.SMILManager = $r1;
    $r2 = $r1.prototype;
    $r2.connectXML = function (url) {
            this._url = url;
            this.xml = new XML();
            this.xml.onLoad = mx.utils.Delegate.create(this, this.xmlOnLoad);
            this.xml.load(url);
            return false;
        };
    $r2.xmlOnLoad = function (success) {
            try {
                if (!success) {
                    this._owner.helperDone(this, false);
                } else {
                    this.baseURLAttr = new Array();
                    this.videoTags = new Array();
                    $r4 = this.xml.firstChild;
                    if ($r4.nodeName == null) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ("URL: \"" + this._url) + "\" No root node found; if file is an flv it must have .flv extension");
                    } else {
                        if (!!!($r4.nodeName.toLowerCase() == "smil")) {
                            throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, (("URL: \"" + this._url) + "\" Root node not smil: ") + $r4.nodeName);
                        }
                    }
                    $r5 = false;
                    $r3 = 0;
                    while ($r3 < $r4.childNodes.length) {
                        $r2 = $r4.childNodes[$r3];
                        if (!!!($r2.nodeType == mx.video.SMILManager.ELEMENT_NODE)) {
                        } else {
                            if ($r2.nodeName.toLowerCase() == "head") {
                                this.parseHead($r2);
                            } else {
                                if ($r2.nodeName.toLowerCase() == "body") {
                                    $r5 = true;
                                    this.parseBody($r2);
                                } else {
                                    throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ((((("URL: \"" + this._url) + "\" Tag ") + $r2.nodeName) + " not supported in ") + $r4.nodeName) + " tag.");
                                }
                            }
                        }
                        $r3 = $r3 + 1;
                    }
                    if (!$r5) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ("URL: \"" + this._url) + "\" Tag body is required.");
                    }
                    this._owner.helperDone(this, true);
                }
                goto L0000;
            } catch (Register(0)) {
                if (!(Error($r0) == null)) {
                    var err = Error($r0);
                    this._owner.helperDone(this, false);
                    throw err;
                } else {
                    <stack?>;
                    throw $r0;
                }
            }
        };
    $r2.parseHead = function (parentNode) {
            $r4 = false;
            $r3 = 0;
            while ($r3 < parentNode.childNodes.length) {
                $r2 = parentNode.childNodes[$r3];
                if (!!!($r2.nodeType == mx.video.SMILManager.ELEMENT_NODE)) {
                } else {
                    if ($r2.nodeName.toLowerCase() == "meta") {
                        while (true) {
                            $r0 = /*enumerate*/ $r2.attributes;
                            if ($r0 == null) break;
                            $r6 = $r0;
                            if ($r6.toLowerCase() == "base") {
                                this.baseURLAttr.push($r2.attributes[$r6]);
                            } else {
                                throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ((((("URL: \"" + this._url) + "\" Attribute ") + $r6) + " not supported in ") + $r2.nodeName) + " tag.");
                            }
                        }
                    } else {
                        if ($r2.nodeName.toLowerCase() == "layout") {
                            if (!$r4) {
                                this.parseLayout($r2);
                                $r4 = true;
                                goto L01ae;
                            }
                            goto L01b3;
                        }
                    }
                }
                $r3 = $r3 + 1;
            }
        };
    $r2.parseLayout = function (parentNode) {
            $r3 = 0;
            while ($r3 < parentNode.childNodes.length) {
                $r2 = parentNode.childNodes[$r3];
                if (!!!($r2.nodeType == mx.video.SMILManager.ELEMENT_NODE)) {
                } else {
                    if ($r2.nodeName.toLowerCase() == "root-layout") {
                        while (true) {
                            $r0 = /*enumerate*/ $r2.attributes;
                            if ($r0 == null) break;
                            $r5 = $r0;
                            if ($r5.toLowerCase() == "width") {
                                this.width = Number($r2.attributes[$r5]);
                            } else {
                                if ($r5.toLowerCase() == "height") {
                                    this.height = Number($r2.attributes[$r5]);
                                    goto L0118;
                                }
                            }
                        }
                        if (((isNaN(this.width) || (this.width < 0)) || isNaN(this.height)) || (this.height < 0)) {
                            throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ((("URL: \"" + this._url) + "\" Tag ") + $r2.nodeName) + " requires attributes id, width and height.  Width and height must be numbers greater than or equal to 0.");
                        }
                        this.width = Math.round(this.width);
                        this.height = Math.round(this.height);
                        return;
                        goto L021e;
                    }
                }
                $r3 = $r3 + 1;
            }
        };
    $r2.parseBody = function (parentNode) {
            $r6 = 0;
            $r3 = 0;
            while ($r3 < parentNode.childNodes.length) {
                $r2 = parentNode.childNodes[$r3];
                if (!!!($r2.nodeType == mx.video.SMILManager.ELEMENT_NODE)) {
                } else {
                    $r6 = $r6 + 1;
                    if ($r6 > 1) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ((("URL: \"" + this._url) + "\" Tag ") + parentNode.nodeName) + " is required to contain exactly one tag.");
                    }
                    if ($r2.nodeName.toLowerCase() == "switch") {
                        this.parseSwitch($r2);
                    } else {
                        if (($r2.nodeName.toLowerCase() == "video") || ($r2.nodeName.toLowerCase() == "ref")) {
                            $r5 = this.parseVideo($r2);
                            this.videoTags.push($r5);
                            goto L0190;
                        }
                    }
                }
                $r3 = $r3 + 1;
            }
            if (this.videoTags.length < 1) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ("URL: \"" + this._url) + "\" At least one video of ref tag is required.");
            }
        };
    $r2.parseSwitch = function (parentNode) {
            $r4 = 0;
            while ($r4 < parentNode.childNodes.length) {
                $r5 = parentNode.childNodes[$r4];
                if (!!!($r5.nodeType == mx.video.SMILManager.ELEMENT_NODE)) {
                } else {
                    if (($r5.nodeName.toLowerCase() == "video") || ($r5.nodeName.toLowerCase() == "ref")) {
                        $r3 = this.parseVideo($r5);
                        if ($r3.bitrate == undefined) {
                            this.videoTags.push($r3);
                        } else {
                            $r6 = false;
                            $r2 = 0;
                            while ($r2 < this.videoTags.length) {
                                if ((this.videoTags[$r2].bitrate == undefined) || ($r3.bitrate < this.videoTags[$r4].bitrate)) {
                                    $r6 = true;
                                    this.videoTags.splice($r2, 0, this.videoTags);
                                    break;
                                }
                                $r2 = $r2 + 1;
                            }
                            if (!$r6) {
                                this.videoTags.push($r3);
                            }
                        }
                        goto L01d3;
                    }
                }
                $r4 = $r4 + 1;
            }
        };
    $r2.parseVideo = function (node) {
            $r3 = new Object();
            while (true) {
                $r0 = /*enumerate*/ node.attributes;
                if ($r0 == null) break;
                $r4 = $r0;
                if ($r4.toLowerCase() == "src") {
                    $r3.src = node.attributes[$r4];
                } else {
                    if ($r4.toLowerCase() == "system-bitrate") {
                        $r3.bitrate = Number(node.attributes[$r4]);
                    } else {
                        if ($r4.toLowerCase() == "dur") {
                            $r3.dur = Number(node.attributes[$r4]);
                            goto L00d6;
                        }
                    }
                }
            }
            if ($r3.src == undefined) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, ((("URL: \"" + this._url) + "\" Attribute src is required in ") + node.nodeName) + " tag.");
            }
            return $r3;
        };
    $r1.version = "1.0.0.103";
    $r1.ELEMENT_NODE = 1;
}
ASSetPropFlags(mx.video.SMILManager.prototype, null, 1);
// ======== DoInitAction sprite=17 __Packages.mx.video.NCManager
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.NCManager) {
    $r1 = function () {
            this.initNCInfo();
            this.initOtherInfo();
            this._timeoutIntervalId = 0;
            this._tryNCIntervalId = 0;
            this._timeout = this.DEFAULT_TIMEOUT;
        };
    mx.video.NCManager = $r1;
    $r2 = $r1.prototype;
    $r2.initNCInfo = function () {
            this._isRTMP = undefined;
            this._serverName = undefined;
            this._wrappedURL = undefined;
            this._portNumber = undefined;
            this._appName = undefined;
        };
    $r2.initOtherInfo = function () {
            this._contentPath = undefined;
            this._streamName = undefined;
            this._streamLength = undefined;
            this._streamWidth = undefined;
            this._streamHeight = undefined;
            this._streams = undefined;
            this._autoSenseBW = false;
            this._payload = 0;
            this._connTypeCounter = 0;
            this.cleanConns();
        };
    $r2.getTimeout = function () {
            return this._timeout;
        };
    $r2.setTimeout = function (t) {
            this._timeout = t;
            if (!!!(this._timeoutIntervalId == 0)) {
                clearInterval(this._timeoutIntervalId);
                this._timeoutIntervalId = setInterval(this, "_onFCSConnectTimeOut", this._timeout);
            }
        };
    $r2.getBitrate = function () {
            return this._bitrate;
        };
    $r2.setBitrate = function (b) {
            if ((this._isRTMP == undefined) || !this._isRTMP) {
                this._bitrate = b;
            }
        };
    $r2.getVideoPlayer = function () {
            return this._owner;
        };
    $r2.setVideoPlayer = function (v) {
            this._owner = v;
        };
    $r2.getNetConnection = function () {
            return this._nc;
        };
    $r2.getStreamName = function () {
            return this._streamName;
        };
    $r2.isRTMP = function () {
            return this._isRTMP;
        };
    $r2.getStreamLength = function () {
            return this._streamLength;
        };
    $r2.getStreamWidth = function () {
            return this._streamWidth;
        };
    $r2.getStreamHeight = function () {
            return this._streamHeight;
        };
    $r2.connectToURL = function (url) {
            this.initOtherInfo();
            this._contentPath = url;
            if (((this._contentPath == null) || (this._contentPath == undefined)) || (this._contentPath == "")) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_CONTENT_PATH);
            }
            $r2 = this.parseURL(this._contentPath);
            if (($r2.streamName == undefined) || ($r2.streamName == "")) {
                throw new mx.video.VideoError(mx.video.VideoError.INVALID_CONTENT_PATH, url);
            }
            if ($r2.isRTMP) {
                $r3 = this.canReuseOldConnection($r2);
                this._isRTMP = true;
                this._protocol = $r2.protocol;
                this._streamName = $r2.streamName;
                this._serverName = $r2.serverName;
                this._wrappedURL = $r2.wrappedURL;
                this._portNumber = $r2.portNumber;
                this._appName = $r2.appName;
                if ((((this._appName == undefined) || (this._appName == "")) || (this._streamName == undefined)) || (this._streamName == "")) {
                    throw new mx.video.VideoError(mx.video.VideoError.INVALID_CONTENT_PATH, url);
                }
                this._autoSenseBW = !(this._streamName.indexOf(",") == -1);
                return $r3 || this.connectRTMP();
            } else {
                if ($r2.streamName.slice(-4).toLowerCase() == ".flv") {
                    $r3 = this.canReuseOldConnection($r2);
                    this._isRTMP = false;
                    this._streamName = $r2.streamName;
                    return $r3 || this.connectHTTP();
                } else {
                    this._smilMgr = new mx.video.SMILManager(this);
                    return this._smilMgr.connectXML($r2.streamName);
                }
            }
        };
    $r2.connectAgain = function () {
            $r2 = this._appName.indexOf("/");
            if ($r2 < 0) {
                $r2 = this._streamName.indexOf("/");
                if (!!!($r2 < 0)) {
                    this._appName = this._appName + "/";
                    this._appName = this._appName + this._streamName.slice(0, $r2);
                    this._streamName = this._streamName.slice($r2 + 1);
                }
                return false;
            }
            $r3 = this._appName.slice($r2 + 1);
            $r3 = $r3 + "/";
            $r3 = $r3 + this._streamName;
            this._streamName = $r3;
            this._appName = this._appName.slice(0, $r2);
            this.close();
            this._payload = 0;
            this._connTypeCounter = 0;
            this.cleanConns();
            this.connectRTMP();
            return true;
        };
    $r2.reconnect = function () {
            if (!this._isRTMP) {
                throw new Error("Cannot call reconnect on an http connection");
            }
            this._nc.onStatus = function (info) {
                        this.mc.reconnectOnStatus(this, info);
                    };
            this._nc.onBWDone = function () {
                        this.mc.onReconnected();
                    };
            this._nc.connect(this._ncUri, false);
        };
    $r2.onReconnected = function () {
            delete this._nc.onStatus;
            delete this._nc.onBWDone;
            this._owner.ncReconnected();
        };
    $r2.close = function () {
            if (this._nc) {
                this._nc.close();
            }
        };
    $r2.helperDone = function (helper, success) {
            if (!!!(helper == this._smilMgr)) {
                return;
            }
            if (!success) {
                this._nc = undefined;
                this._owner.ncConnected();
                delete this._smilMgr;
                return;
            }
            this._streamWidth = this._smilMgr.width;
            this._streamHeight = this._smilMgr.height;
            $r2 = undefined;
            $r4 = this._smilMgr.baseURLAttr[0];
            if (!($r4 == undefined) && !($r4 == "")) {
                $r2 = this.parseURL($r4);
                this._isRTMP = $r2.isRTMP;
                this._streamName = $r2.streamName;
                if (this._isRTMP) {
                    this._protocol = $r2.protocol;
                    this._serverName = $r2.serverName;
                    this._portNumber = $r2.portNumber;
                    this._wrappedURL = $r2.wrappedURL;
                    this._appName = $r2.appName;
                    if ((this._appName == undefined) || (this._appName == "")) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, "Base RTMP URL must include application name: " + $r4);
                    }
                    if (this._smilMgr.baseURLAttr.length > 1) {
                        $r2 = this.parseURL(this._smilMgr.baseURLAttr[1]);
                        if (!!!($r2.serverName == undefined)) {
                            this.fallbackServerName = $r2.serverName;
                        }
                    }
                }
            }
            this._streams = this._smilMgr.videoTags;
            $r3 = 0;
            while ($r3 < this._streams.length) {
                $r4 = this._streams[$r3].src;
                $r2 = this.parseURL($r4);
                if (this._isRTMP == undefined) {
                    this._isRTMP = $r2.isRTMP;
                    if (this._isRTMP) {
                        this._protocol = $r2.protocol;
                        if (this._streams.length > 1) {
                            throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, "Cannot switch between multiple absolute RTMP URLs, must use meta tag base attribute.");
                        }
                        this._serverName = $r2.serverName;
                        this._portNumber = $r2.portNumber;
                        this._wrappedURL = $r2.wrappedURL;
                        this._appName = $r2.appName;
                        if ((this._appName == undefined) || (this._appName == "")) {
                            throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, "Base RTMP URL must include application name: " + $r4);
                        }
                    }
                } else {
                    if (((!(this._streamName == undefined) && !(this._streamName == "")) && !$r2.isRelative) && (this._streams.length > 1)) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_XML, "When using meta tag base attribute, cannot use absolute URLs for video or ref tag src attributes.");
                    }
                }
                this._streams[$r3].parseResults = $r2;
                $r3 = $r3 + 1;
            }
            this._autoSenseBW = this._streams.length > 1;
            if (!this._autoSenseBW) {
                if (!!!(this._streamName == undefined)) {
                    this._streamName = this._streamName + this._streams[0].parseResults.streamName;
                } else {
                    this._streamName = this._streams[0].parseResults.streamName;
                }
                this._streamLength = this._streams[0].dur;
            }
            if (this._isRTMP) {
                this.connectRTMP();
            } else {
                if (this._autoSenseBW) {
                    this.bitrateMatch();
                }
                this.connectHTTP();
                this._owner.ncConnected();
            }
        };
    $r2.bitrateMatch = function () {
            $r3 = undefined;
            if (isNaN(this._bitrate)) {
                $r3 = 0;
            } else {
                $r2 = 0;
                while ($r2 < this._streams.length) {
                    if (isNaN(this._streams[$r2].bitrate) || !(this._bitrate > this._streams[$r2].bitrate)) {
                        $r3 = $r2;
                        break;
                    }
                    $r2 = $r2 + 1;
                }
            }
            if (isNaN($r3)) {
                throw new mx.video.VideoError(mx.video.VideoError.NO_BITRATE_MATCH);
            }
            if (!!!(this._streamName == undefined)) {
                this._streamName = this._streamName + this._streams[$r3].src;
            } else {
                this._streamName = this._streams[$r3].src;
            }
            this._streamLength = this._streams[$r3].dur;
        };
    $r2.parseURL = function (url) {
            $r2 = new Object();
            $r3 = 0;
            $r4 = url.indexOf(":/", $r3);
            if (!!!($r4 < 0)) {
                $r4 = $r4 + 2;
                $r2.protocol = url.slice($r3, $r4);
                $r2.isRelative = false;
            } else {
                $r2.isRelative = true;
            }
            if (!($r2.protocol == undefined) && ((($r2.protocol == "rtmp:/") || ($r2.protocol == "rtmpt:/")) || ($r2.protocol == "rtmps:/"))) {
                $r2.isRTMP = true;
                $r3 = $r4;
                if (url.charAt($r3) == "/") {
                    $r3 = $r3 + 1;
                    $r7 = url.indexOf(":", $r3);
                    $r8 = url.indexOf("/", $r3);
                    if ($r8 < 0) {
                        if ($r7 < 0) {
                            $r2.serverName = url.slice($r3);
                        } else {
                            $r4 = $r7;
                            $r2.portNumber = url.slice($r3, $r4);
                            $r3 = $r4 + 1;
                            $r2.serverName = url.slice($r3);
                        }
                        return $r2;
                    }
                    if (!($r7 < 0) && ($r7 < $r8)) {
                        $r4 = $r7;
                        $r2.serverName = url.slice($r3, $r4);
                        $r3 = $r4 + 1;
                        $r4 = $r8;
                        $r2.portNumber = url.slice($r3, $r4);
                    } else {
                        $r4 = $r8;
                        $r2.serverName = url.slice($r3, $r4);
                    }
                    $r3 = $r4 + 1;
                }
                if (url.charAt($r3) == "?") {
                    $r9 = url.slice($r3 + 1);
                    $r6 = this.parseURL($r9);
                    if (($r6.protocol == undefined) || !$r6.isRTMP) {
                        throw new mx.video.VideoError(mx.video.VideoError.INVALID_CONTENT_PATH, url);
                    }
                    $r2.wrappedURL = "?";
                    $r2.wrappedURL = $r2.wrappedURL + $r6.protocol;
                    if (!!!($r6.server == undefined)) {
                        $r2.wrappedURL = $r2.wrappedURL + "/";
                        $r2.wrappedURL = $r2.wrappedURL + $r6.server;
                    }
                    if (!!!($r6.wrappedURL == undefined)) {
                        $r2.wrappedURL = $r2.wrappedURL + "/?";
                        $r2.wrappedURL = $r2.wrappedURL + $r6.wrappedURL;
                    }
                    $r2.appName = $r6.appName;
                    $r2.streamName = $r6.streamName;
                    return $r2;
                }
                $r4 = url.indexOf("/", $r3);
                if ($r4 < 0) {
                    $r2.appName = url.slice($r3);
                    return $r2;
                }
                $r2.appName = url.slice($r3, $r4);
                $r3 = $r4 + 1;
                $r4 = url.indexOf("/", $r3);
                if ($r4 < 0) {
                    $r2.streamName = url.slice($r3);
                    return $r2;
                }
                $r2.appName = $r2.appName + "/";
                $r2.appName = $r2.appName + url.slice($r3, $r4);
                $r3 = $r4 + 1;
                $r2.streamName = url.slice($r3);
            } else {
                $r2.isRTMP = false;
                $r2.streamName = url;
            }
            return $r2;
        };
    $r2.canReuseOldConnection = function (parseResults) {
            if ((this._nc == undefined) || (this._nc == null)) {
                return false;
            }
            if (!parseResults.isRTMP) {
                if (!this._isRTMP) {
                    return true;
                }
                this._owner.close();
                this._nc = null;
                this.initNCInfo();
                return false;
            }
            if (this._isRTMP) {
                if (((((parseResults.serverName == this._serverName) && (parseResults.appName == this._appName)) && (parseResults.protocol == this._protocol)) && (parseResults.portNumber == this._portNumber)) && (parseResults.wrappedURL == this._wrappedURL)) {
                    return true;
                }
                this._owner.close();
                this._nc = null;
            }
            this.initNCInfo();
            return false;
        };
    $r2.connectHTTP = function () {
            this._nc = new NetConnection();
            this._nc.connect(null);
            return true;
        };
    $r2.connectRTMP = function () {
            clearInterval(this._timeoutIntervalId);
            this._timeoutIntervalId = setInterval(this, "_onFCSConnectTimeOut", this._timeout);
            this._tryNC = new Array();
            $r2 = 0;
            while ($r2 < mx.video.NCManager.RTMP_CONN.length) {
                this._tryNC[$r2] = new NetConnection();
                this._tryNC[$r2].mc = this;
                this._tryNC[$r2].pending = false;
                this._tryNC[$r2].connIndex = $r2;
                this._tryNC[$r2].onBWDone = function (p_bw) {
                                this.mc.onConnected(this, p_bw);
                            };
                this._tryNC[$r2].onBWCheck = function () {
                                $r0 = this.mc._payload + 1;
                                this.mc._payload = $r0;
                                return $r0;
                            };
                this._tryNC[$r2].onStatus = function (info) {
                                this.mc.connectOnStatus(this, info);
                            };
                $r2 = $r2 + 1;
            }
            this.nextConnect();
            return false;
        };
    $r2.nextConnect = function () {
            clearInterval(this._tryNCIntervalId);
            this._tryNCIntervalId = 0;
            $r4 = undefined;
            $r3 = undefined;
            if (this._connTypeCounter == 0) {
                $r4 = this._protocol;
                if (!!!(this._portNumber == undefined)) {
                    $r3 = this._portNumber;
                } else {
                    $r2 = 0;
                    while ($r2 < mx.video.NCManager.RTMP_CONN.length) {
                        if ($r4 == mx.video.NCManager.RTMP_CONN[$r2].protocol) {
                            $r3 = mx.video.NCManager.RTMP_CONN[$r2].port;
                            break;
                        }
                        $r2 = $r2 + 1;
                    }
                }
            } else {
                $r4 = mx.video.NCManager.RTMP_CONN[this._connTypeCounter].protocol;
                $r3 = mx.video.NCManager.RTMP_CONN[this._connTypeCounter].port;
            }
            $r5 = (($r4 + ((!(this._serverName == undefined)) ? (((("/" + this._serverName) + ":") + $r3) + "/") : "")) + ((!(this._wrappedURL == undefined)) ? (this._wrappedURL + "/") : "")) + this._appName;
            this._tryNC[this._connTypeCounter].pending = true;
            this._tryNC[this._connTypeCounter].connect($r5, this._autoSenseBW);
            if (this._connTypeCounter < (mx.video.NCManager.RTMP_CONN.length - 1)) {
                this._connTypeCounter = this._connTypeCounter + 1;
                this._tryNCIntervalId = setInterval(this, "nextConnect", 1500);
            }
        };
    $r2.cleanConns = function () {
            clearInterval(this._tryNCIntervalId);
            this._tryNCIntervalId = 0;
            if (!!!(this._tryNC == undefined)) {
                $r2 = 0;
                while ($r2 < this._tryNC.length) {
                    if (!!!(this._tryNC[$r2] == undefined)) {
                        delete this._tryNC[$r2].onStatus;
                        if (this._tryNC[$r2].pending) {
                            this._tryNC[$r2].onStatus = function (info) {
                                                        this.mc.disconnectOnStatus(this, info);
                                                    };
                        } else {
                            delete this._tryNC[$r2].onStatus;
                            this._tryNC[$r2].close();
                        }
                    }
                    delete this._tryNC[$r2];
                    $r2 = $r2 + 1;
                }
                delete this._tryNC;
            }
        };
    $r2.tryFallBack = function () {
            if (((this._serverName == this.fallbackServerName) || (this.fallbackServerName == undefined)) || (this.fallbackServerName == null)) {
                delete this._nc;
                this._nc = undefined;
                this._owner.ncConnected();
            } else {
                this._connTypeCounter = 0;
                this.cleanConns();
                this._serverName = this.fallbackServerName;
                this.connectRTMP();
            }
        };
    $r2.onConnected = function (p_nc, p_bw) {
            clearInterval(this._timeoutIntervalId);
            this._timeoutIntervalId = 0;
            delete p_nc.onBWDone;
            delete p_nc.onBWCheck;
            delete p_nc.onStatus;
            this._nc = p_nc;
            this._ncUri = this._nc.uri;
            if (this._autoSenseBW) {
                this._bitrate = p_bw * 1024;
                if (!!!(this._streams == undefined)) {
                    this.bitrateMatch();
                } else {
                    if (!!!(this._streamName.indexOf(",") == -1)) {
                        $r3 = this._streamName.split(",");
                        $r2 = 0;
                        while ($r2 < $r3.length) {
                            $r4 = mx.video.NCManager.stripFrontAndBackWhiteSpace($r3[$r2]);
                            if (($r2 + 1) < $r3.length) {
                                if (!!!(p_bw > Number($r3[$r2 + 1]))) {
                                    this._streamName = $r4;
                                    break;
                                }
                            } else {
                                this._streamName = $r4;
                                break;
                            }
                            $r2 = $r2 + 2;
                        }
                    }
                }
            }
            if (this._streamName.slice(-4).toLowerCase() == ".flv") {
                this._streamName = this._streamName.slice(0, -4);
            }
            if (!this._owner.__get__isLive() && (this._streamLength == undefined)) {
                $r6 = new Object();
                $r6.mc = this;
                $r6.onResult = function (length) {
                                this.mc.getStreamLengthResult(length);
                            };
                this._nc.call("getStreamLength", $r6, this._streamName);
            } else {
                this._owner.ncConnected();
            }
        };
    $r2.connectOnStatus = function (target, info) {
            target.pending = false;
            if (info.code == "NetConnection.Connect.Success") {
                this._nc = this._tryNC[target.connIndex];
                this._tryNC[target.connIndex] = undefined;
                this.cleanConns();
            } else {
                if (((info.code == "NetConnection.Connect.Failed") || (info.code == "NetConnection.Connect.Rejected")) && (target.connIndex == (mx.video.NCManager.RTMP_CONN.length - 1))) {
                    if (!this.connectAgain()) {
                        this.tryFallBack();
                    }
                    goto L0000;
                }
            }
        };
    $r2.reconnectOnStatus = function (target, info) {
            if ((info.code == "NetConnection.Connect.Failed") || (info.code == "NetConnection.Connect.Rejected")) {
                delete this._nc;
                this._nc = undefined;
                this._owner.ncReconnected();
            }
        };
    $r2.disconnectOnStatus = function (target, info) {
            if (info.code == "NetConnection.Connect.Success") {
                delete target.onStatus;
                target.close();
            }
        };
    $r2.getStreamLengthResult = function (length) {
            this._streamLength = length;
            this._owner.ncConnected();
        };
    $r2._onFCSConnectTimeOut = function () {
            this.cleanConns();
            this._nc = undefined;
            if (!this.connectAgain()) {
                this._owner.ncConnected();
            }
        };
    $r1.stripFrontAndBackWhiteSpace = function (p_str) {
            $r1 = undefined;
            $r2 = p_str.length;
            $r4 = 0;
            $r5 = $r2;
            $r1 = 0;
            while ($r1 < $r2) {
                $r0 = p_str.charCodeAt($r1);
                if (!($r0 === 9)) {
                    if (!($r0 === 10)) {
                        if (!($r0 === 13)) {
                            if (!($r0 === 32)) {
                            } else {
                                goto L00ba;
                            }
                        } else {
                            goto L00ba;
                        }
                    } else {
                        goto L00ba;
                    }
                } else {
                    goto L00ba;
                }
                $r4 = $r1;
                break;
                $r1 = $r1 + 1;
            }
            $r1 = $r2;
            while (!!!($r1 < 0)) {
                $r0 = p_str.charCodeAt($r1);
                if (!($r0 === 9)) {
                    if (!($r0 === 10)) {
                        if (!($r0 === 13)) {
                            if (!($r0 === 32)) {
                            } else {
                                goto L015a;
                            }
                        } else {
                            goto L015a;
                        }
                    } else {
                        goto L015a;
                    }
                } else {
                    goto L015a;
                }
                $r5 = $r1 + 1;
                break;
                $r1 = $r1 - 1;
            }
            if (!!!($r5 > $r4)) {
                return "";
            }
            return p_str.slice($r4, $r5);
        };
    $r1.version = "1.0.0.103";
    $r2.DEFAULT_TIMEOUT = 60000;
    $r1.RTMP_CONN = [{port: "1935", protocol: "rtmp:/"}, {port: "443", protocol: "rtmp:/"}, {port: "80", protocol: "rtmpt:/"}, {port: "443", protocol: "rtmps:/"}];
}
ASSetPropFlags(mx.video.NCManager.prototype, null, 1);
// ======== DoInitAction sprite=18 __Packages.mx.video.CuePointManager
if (!_global.mx) {
    _global.mx = new Object();
}
<stack?>;
if (!_global.mx.video) {
    _global.mx.video = new Object();
}
<stack?>;
if (!_global.mx.video.CuePointManager) {
    $r1 = function (owner, id) {
            this._owner = owner;
            this._id = id;
            this.reset();
            this._asCuePointTolerance = this._owner.getVideoPlayer(this._id).__get__playheadUpdateInterval() / 2000;
            this._linearSearchTolerance = mx.video.CuePointManager.DEFAULT_LINEAR_SEARCH_TOLERANCE;
        };
    mx.video.CuePointManager = $r1;
    $r2 = $r1.prototype;
    $r2.reset = function () {
            this._metadataLoaded = false;
            this.allCuePoints = null;
            this.asCuePoints = null;
            this._disabledCuePoints = null;
            this.flvCuePoints = null;
            this.navCuePoints = null;
            this.eventCuePoints = null;
            this._asCuePointIndex = 0;
        };
    $r2.__get__metadataLoaded = function () {
            return this._metadataLoaded;
        };
    $r2.__set__playheadUpdateInterval = function (aTime) {
            this._asCuePointTolerance = aTime / 2000;
            return this.__get__playheadUpdateInterval();
            <stack?>;
        };
    $r2.__get__id = function () {
            return this._id;
        };
    $r2.addASCuePoint = function (timeOrCuePoint, name, parameters) {
            $r3 = undefined;
            if (typeof timeOrCuePoint == "object") {
                $r3 = mx.video.CuePointManager.deepCopyObject(timeOrCuePoint);
            } else {
                $r3 = {parameters: mx.video.CuePointManager.deepCopyObject(parameters), name: name, time: timeOrCuePoint};
            }
            $r7 = isNaN($r3.time) || ($r3.time < 0);
            if ($r7) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number");
            }
            $r6 = ($r3.name == undefined) || ($r3.name == null);
            if ($r6) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "name cannot be undefined or null");
            }
            $r2 = undefined;
            $r3.type = "actionscript";
            if (((this.asCuePoints == null) || (this.asCuePoints == undefined)) || (this.asCuePoints.length < 1)) {
                $r2 = 0;
                this.asCuePoints = new Array();
                this.asCuePoints.push($r3);
            } else {
                $r2 = this.getCuePointIndex(this.asCuePoints, true, $r3.time);
                $r2 = (!(this.asCuePoints[$r2].time > $r3.time)) ? ($r2 + 1) : 0;
                this.asCuePoints.splice($r2, 0, $r3);
            }
            if (((this.allCuePoints == null) || (this.allCuePoints == undefined)) || (this.allCuePoints.length < 1)) {
                $r2 = 0;
                this.allCuePoints = new Array();
                this.allCuePoints.push($r3);
            } else {
                $r2 = this.getCuePointIndex(this.allCuePoints, true, $r3.time);
                $r2 = (!(this.allCuePoints[$r2].time > $r3.time)) ? ($r2 + 1) : 0;
                this.allCuePoints.splice($r2, 0, $r3);
            }
            $r5 = this._owner.getVideoPlayer(this._id).__get__playheadTime();
            if ($r5 > 0) {
                if (this._asCuePointIndex == $r2) {
                    if ($r5 > this.asCuePoints[$r2].time) {
                        this._asCuePointIndex = this._asCuePointIndex + 1;
                    }
                } else {
                    if (this._asCuePointIndex > $r2) {
                        this._asCuePointIndex = this._asCuePointIndex + 1;
                    }
                }
            } else {
                this._asCuePointIndex = 0;
            }
            $r4 = mx.video.CuePointManager.deepCopyObject(this.asCuePoints[$r2]);
            $r4.array = this.asCuePoints;
            $r4.index = $r2;
            return $r4;
        };
    $r2.removeASCuePoint = function (timeNameOrCuePoint) {
            if (((this.asCuePoints == null) || (this.asCuePoints == undefined)) || (this.asCuePoints.length < 1)) {
                return null;
            }
            $r3 = undefined;
            $r0 = typeof timeNameOrCuePoint;
            if (!($r0 === "string")) {
                if (!($r0 === "number")) {
                    if (!($r0 === "object")) {
                        goto L00c4;
                        $r3 = {name: timeNameOrCuePoint};
                        goto L00c4;
                        $r3 = {time: timeNameOrCuePoint};
                    } else {
                        $r3 = timeNameOrCuePoint;
                        goto L00c4;
                    }
                } else {
                    $r3 = {time: timeNameOrCuePoint};
                    goto L00c4;
                    $r3 = timeNameOrCuePoint;
                    goto L00c4;
                }
            } else {
                $r3 = {name: timeNameOrCuePoint};
                goto L00c4;
                $r3 = {time: timeNameOrCuePoint};
                goto L00c4;
                $r3 = timeNameOrCuePoint;
                goto L00c4;
            }
            $r2 = this.getCuePointIndex(this.asCuePoints, false, $r3.time, $r3.name);
            if ($r2 < 0) {
                return null;
            }
            $r3 = this.asCuePoints[$r2];
            this.asCuePoints.splice($r2, 1);
            $r2 = this.getCuePointIndex(this.allCuePoints, false, $r3.time, $r3.name);
            if ($r2 > 0) {
                this.allCuePoints.splice($r2, 1);
            }
            if (this._owner.getVideoPlayer(this._id).__get__playheadTime() > 0) {
                if (this._asCuePointIndex > $r2) {
                    this._asCuePointIndex = this._asCuePointIndex - 1;
                }
            } else {
                this._asCuePointIndex = 0;
            }
            return $r3;
        };
    $r2.setFLVCuePointEnabled = function (enabled, timeNameOrCuePoint) {
            $r4 = undefined;
            $r0 = typeof timeNameOrCuePoint;
            if (!($r0 === "string")) {
                if (!($r0 === "number")) {
                    if (!($r0 === "object")) {
                        goto L007a;
                        $r4 = {name: timeNameOrCuePoint};
                        goto L007a;
                        $r4 = {time: timeNameOrCuePoint};
                    } else {
                        $r4 = timeNameOrCuePoint;
                        goto L007a;
                    }
                } else {
                    $r4 = {time: timeNameOrCuePoint};
                    goto L007a;
                    $r4 = timeNameOrCuePoint;
                    goto L007a;
                }
            } else {
                $r4 = {name: timeNameOrCuePoint};
                goto L007a;
                $r4 = {time: timeNameOrCuePoint};
                goto L007a;
                $r4 = timeNameOrCuePoint;
                goto L007a;
            }
            $r12 = isNaN($r4.time) || ($r4.time < 0);
            $r11 = ($r4.name == undefined) || ($r4.name == null);
            if ($r12 && $r11) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number and/or name must not be undefined or null");
            }
            $r6 = 0;
            $r2 = undefined;
            $r5 = undefined;
            if ($r12) {
                if (!this._metadataLoaded) {
                    if (this._disabledCuePointsByNameOnly[$r4.name] == undefined) {
                        if (!enabled) {
                            if (((this._disabledCuePointsByNameOnly == null) || (this._disabledCuePointsByNameOnly == undefined)) || (this._disabledCuePointsByNameOnly.length < 0)) {
                                this._disabledCuePointsByNameOnly = new Object();
                            }
                            this._disabledCuePointsByNameOnly[$r4.name] = new Array();
                        }
                    } else {
                        if (enabled) {
                            this._disabledCuePointsByNameOnly[$r4.name] = undefined;
                        }
                        return -1;
                    }
                    this.removeCuePoints(this._disabledCuePoints, $r4);
                    return -1;
                }
                if (enabled) {
                    $r6 = this.removeCuePoints(this._disabledCuePoints, $r4);
                } else {
                    $r3 = undefined;
                    $r2 = this.getCuePointIndex(this.flvCuePoints, true, -1, $r4.name);
                    while (!!!($r2 < 0)) {
                        $r3 = this.flvCuePoints[$r2];
                        $r5 = this.getCuePointIndex(this._disabledCuePoints, true, $r3.time);
                        if (($r5 < 0) || !(this._disabledCuePoints[$r5].time == $r3.time)) {
                            this._disabledCuePoints = this.insertCuePoint($r5, this._disabledCuePoints, {time: $r3.time, name: $r3.name});
                            $r6 = $r6 + 1;
                        }
                        $r2 = this.getNextCuePointIndexWithName($r3.name, this.flvCuePoints, $r2);
                    }
                }
                return $r6;
            }
            $r2 = this.getCuePointIndex(this._disabledCuePoints, false, $r4.time, $r4.name);
            if ($r2 < 0) {
                if (enabled) {
                    if (!this._metadataLoaded) {
                        $r2 = this.getCuePointIndex(this._disabledCuePoints, false, $r4.time);
                        if ($r2 < 0) {
                            $r5 = this.getCuePointIndex(this._disabledCuePointsByNameOnly[$r4.name], true, $r4.time);
                            if (!!!(mx.video.CuePointManager.cuePointCompare($r4.time, null, this._disabledCuePointsByNameOnly[$r4.name]) == 0)) {
                                this._disabledCuePointsByNameOnly[$r4.name] = this.insertCuePoint($r5, this._disabledCuePointsByNameOnly[$r4.name], $r4);
                            }
                        } else {
                            this._disabledCuePoints.splice($r2, 1);
                        }
                    }
                    return !this._metadataLoaded ? -1 : 0;
                }
            } else {
                if (enabled) {
                    this._disabledCuePoints.splice($r2, 1);
                    $r6 = 1;
                } else {
                    $r6 = 0;
                }
                return !this._metadataLoaded ? -1 : $r6;
            }
            if (this._metadataLoaded) {
                $r2 = this.getCuePointIndex(this.flvCuePoints, false, $r4.time, $r4.name);
                if ($r2 < 0) {
                    return 0;
                }
                if ($r11) {
                    $r4.name = this.flvCuePoints[$r2].name;
                }
            }
            $r5 = this.getCuePointIndex(this._disabledCuePoints, true, $r4.time);
            this._disabledCuePoints = this.insertCuePoint($r5, this._disabledCuePoints, $r4);
            $r6 = 1;
            return !this._metadataLoaded ? -1 : 1;
        };
    $r2.removeCuePoints = function (cuePointArray, cuePoint) {
            $r2 = undefined;
            $r4 = undefined;
            $r5 = 0;
            $r2 = this.getCuePointIndex(cuePointArray, true, -1, cuePoint.name);
            while (!!!($r2 < 0)) {
                $r4 = cuePointArray[$r2];
                cuePointArray.splice($r2, 1);
                $r2 = $r2 - 1;
                $r5 = $r5 + 1;
                $r2 = this.getNextCuePointIndexWithName($r4.name, cuePointArray, $r2);
            }
            return $r5;
        };
    $r2.insertCuePoint = function (insertIndex, cuePointArray, cuePoint) {
            if (insertIndex < 0) {
                cuePointArray = new Array();
                cuePointArray.push(cuePoint);
            } else {
                if (cuePointArray[insertIndex].time > cuePoint.time) {
                    insertIndex = 0;
                } else {
                    insertIndex = insertIndex + 1;
                }
                cuePointArray.splice(insertIndex, 0, cuePoint);
            }
            return cuePointArray;
        };
    $r2.isFLVCuePointEnabled = function (timeNameOrCuePoint) {
            if (!this._metadataLoaded) {
                return true;
            }
            $r3 = undefined;
            $r0 = typeof timeNameOrCuePoint;
            if (!($r0 === "string")) {
                if (!($r0 === "number")) {
                    if (!($r0 === "object")) {
                        goto L008f;
                        $r3 = {name: timeNameOrCuePoint};
                        goto L008f;
                        $r3 = {time: timeNameOrCuePoint};
                    } else {
                        $r3 = timeNameOrCuePoint;
                        goto L008f;
                    }
                } else {
                    $r3 = {time: timeNameOrCuePoint};
                    goto L008f;
                    $r3 = timeNameOrCuePoint;
                    goto L008f;
                }
            } else {
                $r3 = {name: timeNameOrCuePoint};
                goto L008f;
                $r3 = {time: timeNameOrCuePoint};
                goto L008f;
                $r3 = timeNameOrCuePoint;
                goto L008f;
            }
            $r5 = isNaN($r3.time) || ($r3.time < 0);
            $r6 = ($r3.name == undefined) || ($r3.name == null);
            if ($r5 && $r6) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number and/or name must not be undefined or null");
            }
            if ($r5) {
                $r2 = this.getCuePointIndex(this.flvCuePoints, true, -1, $r3.name);
                if ($r2 < 0) {
                    return true;
                }
                while (!!!($r2 < 0)) {
                    if (this.getCuePointIndex(this._disabledCuePoints, false, this.flvCuePoints[$r2].time, this.flvCuePoints[$r2].name) < 0) {
                        return true;
                    }
                    $r2 = this.getNextCuePointIndexWithName($r3.name, this.flvCuePoints, $r2);
                }
                return false;
            }
            return this.getCuePointIndex(this._disabledCuePoints, false, $r3.time, $r3.name) < 0;
        };
    $r2.dispatchASCuePoints = function () {
            $r5 = this._owner.getVideoPlayer(this._id).__get__playheadTime();
            if ((this._owner.getVideoPlayer(this._id).__get__stateResponsive() && !(this.asCuePoints == null)) && !(this.asCuePoints == undefined)) {
                while (true) {
                    if (!((this._asCuePointIndex < this.asCuePoints.length) && !(this.asCuePoints[this._asCuePointIndex].time > ($r5 + this._asCuePointTolerance)))) break;
                    var $old1 = this._asCuePointIndex;
                    this._asCuePointIndex = this._asCuePointIndex + 1;
                    this._owner.dispatchEvent({vp: this._id, info: mx.video.CuePointManager.deepCopyObject(this.asCuePoints[$old1]), type: "cuePoint"});
                }
            }
        };
    $r2.resetASCuePointIndex = function (time) {
            if ((!(time > 0) || (this.asCuePoints == null)) || (this.asCuePoints == undefined)) {
                this._asCuePointIndex = 0;
                return;
            }
            $r2 = this.getCuePointIndex(this.asCuePoints, true, time);
            this._asCuePointIndex = (!(this.asCuePoints[$r2].time < time)) ? $r2 : ($r2 + 1);
        };
    $r2.processFLVCuePoints = function (metadataCuePoints) {
            this._metadataLoaded = true;
            if (((metadataCuePoints == undefined) || (metadataCuePoints == null)) || (metadataCuePoints.length < 1)) {
                this.flvCuePoints = null;
                this.navCuePoints = null;
                this.eventCuePoints = null;
                return;
            }
            this.flvCuePoints = metadataCuePoints;
            this.navCuePoints = new Array();
            this.eventCuePoints = new Array();
            $r5 = undefined;
            $r6 = -1;
            $r2 = undefined;
            $r4 = this._disabledCuePoints;
            $r3 = 0;
            this._disabledCuePoints = new Array();
            $r9 = 0;
            while (true) {
                var $old2 = $r9;
                $r9 = $r9 + 1;
                $r2 = this.flvCuePoints[$old2];
                if (!!($r2 == undefined)) break;
                if (($r6 > 0) && !($r6 < $r2.time)) {
                    this.flvCuePoints = null;
                    this.navCuePoints = null;
                    this.eventCuePoints = null;
                    this._disabledCuePoints = null;
                    this._disabledCuePointsByNameOnly = null;
                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "Unsorted cuePoint found after time: " + $r6);
                }
                $r6 = $r2.time;
                while (true) {
                    if (!(($r3 < $r4.length) && (mx.video.CuePointManager.cuePointCompare($r4[$r3].time, null, $r2) < 0))) break;
                    $r3 = $r3 + 1;
                }
                if (!(this._disabledCuePointsByNameOnly[$r2.name] == undefined) || (($r3 < $r4.length) && (mx.video.CuePointManager.cuePointCompare($r4[$r3].time, $r4[$r3].name, $r2) == 0))) {
                    this._disabledCuePoints.push({name: $r2.name, time: $r2.time});
                }
                if ($r2.type == "navigation") {
                    this.navCuePoints.push($r2);
                } else {
                    if ($r2.type == "event") {
                        this.eventCuePoints.push($r2);
                    }
                }
                if (((this.allCuePoints == null) || (this.allCuePoints == undefined)) || (this.allCuePoints.length < 1)) {
                    this.allCuePoints = new Array();
                    this.allCuePoints.push($r2);
                } else {
                    $r5 = this.getCuePointIndex(this.allCuePoints, true, $r2.time);
                    $r5 = (!(this.allCuePoints[$r5].time > $r2.time)) ? ($r5 + 1) : 0;
                    this.allCuePoints.splice($r5, 0, $r2);
                }
            }
            delete this._disabledCuePointsByNameOnly;
            this._disabledCuePointsByNameOnly = null;
            delete this._disabledCuePointsByNameOnly;
            this._disabledCuePointsByNameOnly = null;
        };
    $r2.processCuePointsProperty = function (cuePoints) {
            if (((cuePoints == undefined) || (cuePoints == null)) || (cuePoints.length == 0)) {
                return;
            }
            $r4 = 0;
            $r8 = undefined;
            $r6 = undefined;
            $r7 = undefined;
            $r5 = undefined;
            $r9 = undefined;
            $r2 = 0;
            while ($r2 < (cuePoints.length - 1)) {
                $r0 = $r4;
                if (!($r0 === 6)) {
                    if (!($r0 === 0)) {
                        if (!($r0 === 1)) {
                            if (!($r0 === 2)) {
                                if (!($r0 === 3)) {
                                    if (!($r0 === 4)) {
                                        if (!($r0 === 5)) {
                                            goto L069d;
                                            this.addOrDisable($r9, $r5);
                                            $r4 = 0;
                                            var $old27 = $r2;
                                            $r2 = $r2 + 1;
                                            if (!!!(cuePoints[$old27] == "t")) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                            }
                                            if (isNaN(cuePoints[$r2])) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number");
                                            }
                                            $r5 = new Object();
                                            $r5.time = cuePoints[$r2] / 1000;
                                            $r4 = $r4 + 1;
                                            goto L069d;
                                            var $old28 = $r2;
                                            $r2 = $r2 + 1;
                                            if (!!!(cuePoints[$old28] == "n")) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                            }
                                            if ((cuePoints[$r2] == undefined) || (cuePoints[$r2] == null)) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "name cannot be null or undefined");
                                            }
                                            $r5.name = this.unescape(cuePoints[$r2]);
                                            $r4 = $r4 + 1;
                                            goto L069d;
                                            var $old29 = $r2;
                                            $r2 = $r2 + 1;
                                            if (!!!(cuePoints[$old29] == "t")) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                            }
                                            if (isNaN(cuePoints[$r2])) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be number");
                                            }
                                            $r0 = cuePoints[$r2];
                                            if (!($r0 === 0)) {
                                                if (!($r0 === 1)) {
                                                    if (!($r0 === 2)) {
                                                        goto L03f8;
                                                        $r5.type = "event";
                                                        goto L042a;
                                                        $r5.type = "navigation";
                                                    } else {
                                                        $r5.type = "actionscript";
                                                        goto L042a;
                                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                                    }
                                                } else {
                                                    $r5.type = "navigation";
                                                    goto L042a;
                                                    $r5.type = "actionscript";
                                                    goto L042a;
                                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                                }
                                            } else {
                                                $r5.type = "event";
                                                goto L042a;
                                                $r5.type = "navigation";
                                                goto L042a;
                                                $r5.type = "actionscript";
                                                goto L042a;
                                            }
                                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                            $r4 = $r4 + 1;
                                            goto L069d;
                                            var $old30 = $r2;
                                            $r2 = $r2 + 1;
                                            if (!!!(cuePoints[$old30] == "d")) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                            }
                                            if (isNaN(cuePoints[$r2])) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "disabled must be number");
                                            }
                                            $r9 = !(cuePoints[$r2] == 0);
                                            $r4 = $r4 + 1;
                                            goto L069d;
                                            var $old31 = $r2;
                                            $r2 = $r2 + 1;
                                            if (!!!(cuePoints[$old31] == "p")) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                            }
                                            if (isNaN(cuePoints[$r2])) {
                                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                                            }
                                            $r8 = cuePoints[$r2];
                                            $r4 = $r4 + 1;
                                            if ($r8 == 0) {
                                                $r4 = $r4 + 1;
                                            } else {
                                                $r5.parameters = new Object();
                                            }
                                        } else {
                                            var $old32 = $r2;
                                            $r2 = $r2 + 1;
                                            $r6 = cuePoints[$old32];
                                            $r7 = cuePoints[$r2];
                                            if (typeof $r6 == "string") {
                                                $r6 = this.unescape($r6);
                                            }
                                            if (typeof $r7 == "string") {
                                                $r7 = this.unescape($r7);
                                            }
                                            $r5.parameters[$r6] = $r7;
                                            $r8 = $r8 - 1;
                                            if ($r8 == 0) {
                                                $r4 = $r4 + 1;
                                            }
                                            goto L069d;
                                        }
                                    } else {
                                        var $old33 = $r2;
                                        $r2 = $r2 + 1;
                                        if (!!!(cuePoints[$old33] == "p")) {
                                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                        }
                                        if (isNaN(cuePoints[$r2])) {
                                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                                        }
                                        $r8 = cuePoints[$r2];
                                        $r4 = $r4 + 1;
                                        if ($r8 == 0) {
                                            $r4 = $r4 + 1;
                                        } else {
                                            $r5.parameters = new Object();
                                        }
                                        goto L069d;
                                        var $old34 = $r2;
                                        $r2 = $r2 + 1;
                                        $r6 = cuePoints[$old34];
                                        $r7 = cuePoints[$r2];
                                        if (typeof $r6 == "string") {
                                            $r6 = this.unescape($r6);
                                        }
                                        if (typeof $r7 == "string") {
                                            $r7 = this.unescape($r7);
                                        }
                                        $r5.parameters[$r6] = $r7;
                                        $r8 = $r8 - 1;
                                        if ($r8 == 0) {
                                            $r4 = $r4 + 1;
                                        }
                                        goto L069d;
                                    }
                                } else {
                                    var $old35 = $r2;
                                    $r2 = $r2 + 1;
                                    if (!!!(cuePoints[$old35] == "d")) {
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                    }
                                    if (isNaN(cuePoints[$r2])) {
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "disabled must be number");
                                    }
                                    $r9 = !(cuePoints[$r2] == 0);
                                    $r4 = $r4 + 1;
                                    goto L069d;
                                    var $old36 = $r2;
                                    $r2 = $r2 + 1;
                                    if (!!!(cuePoints[$old36] == "p")) {
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                    }
                                    if (isNaN(cuePoints[$r2])) {
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                                    }
                                    $r8 = cuePoints[$r2];
                                    $r4 = $r4 + 1;
                                    if ($r8 == 0) {
                                        $r4 = $r4 + 1;
                                    } else {
                                        $r5.parameters = new Object();
                                    }
                                    goto L069d;
                                    var $old37 = $r2;
                                    $r2 = $r2 + 1;
                                    $r6 = cuePoints[$old37];
                                    $r7 = cuePoints[$r2];
                                    if (typeof $r6 == "string") {
                                        $r6 = this.unescape($r6);
                                    }
                                    if (typeof $r7 == "string") {
                                        $r7 = this.unescape($r7);
                                    }
                                    $r5.parameters[$r6] = $r7;
                                    $r8 = $r8 - 1;
                                    if ($r8 == 0) {
                                        $r4 = $r4 + 1;
                                    }
                                    goto L069d;
                                }
                            } else {
                                var $old38 = $r2;
                                $r2 = $r2 + 1;
                                if (!!!(cuePoints[$old38] == "t")) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                }
                                if (isNaN(cuePoints[$r2])) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be number");
                                }
                                $r0 = cuePoints[$r2];
                                if (!($r0 === 0)) {
                                    if (!($r0 === 1)) {
                                        if (!($r0 === 2)) {
                                            goto L03f8;
                                            $r5.type = "event";
                                            goto L042a;
                                            $r5.type = "navigation";
                                        } else {
                                            $r5.type = "actionscript";
                                            goto L042a;
                                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                        }
                                    } else {
                                        $r5.type = "navigation";
                                        goto L042a;
                                        $r5.type = "actionscript";
                                        goto L042a;
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                    }
                                } else {
                                    $r5.type = "event";
                                    goto L042a;
                                    $r5.type = "navigation";
                                    goto L042a;
                                    $r5.type = "actionscript";
                                    goto L042a;
                                }
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                $r4 = $r4 + 1;
                                goto L069d;
                                var $old39 = $r2;
                                $r2 = $r2 + 1;
                                if (!!!(cuePoints[$old39] == "d")) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                }
                                if (isNaN(cuePoints[$r2])) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "disabled must be number");
                                }
                                $r9 = !(cuePoints[$r2] == 0);
                                $r4 = $r4 + 1;
                                goto L069d;
                                var $old40 = $r2;
                                $r2 = $r2 + 1;
                                if (!!!(cuePoints[$old40] == "p")) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                                }
                                if (isNaN(cuePoints[$r2])) {
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                                }
                                $r8 = cuePoints[$r2];
                                $r4 = $r4 + 1;
                                if ($r8 == 0) {
                                    $r4 = $r4 + 1;
                                } else {
                                    $r5.parameters = new Object();
                                }
                                goto L069d;
                                var $old41 = $r2;
                                $r2 = $r2 + 1;
                                $r6 = cuePoints[$old41];
                                $r7 = cuePoints[$r2];
                                if (typeof $r6 == "string") {
                                    $r6 = this.unescape($r6);
                                }
                                if (typeof $r7 == "string") {
                                    $r7 = this.unescape($r7);
                                }
                                $r5.parameters[$r6] = $r7;
                                $r8 = $r8 - 1;
                                if ($r8 == 0) {
                                    $r4 = $r4 + 1;
                                }
                                goto L069d;
                            }
                        } else {
                            var $old42 = $r2;
                            $r2 = $r2 + 1;
                            if (!!!(cuePoints[$old42] == "n")) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                            }
                            if ((cuePoints[$r2] == undefined) || (cuePoints[$r2] == null)) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "name cannot be null or undefined");
                            }
                            $r5.name = this.unescape(cuePoints[$r2]);
                            $r4 = $r4 + 1;
                            goto L069d;
                            var $old43 = $r2;
                            $r2 = $r2 + 1;
                            if (!!!(cuePoints[$old43] == "t")) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                            }
                            if (isNaN(cuePoints[$r2])) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be number");
                            }
                            $r0 = cuePoints[$r2];
                            if (!($r0 === 0)) {
                                if (!($r0 === 1)) {
                                    if (!($r0 === 2)) {
                                        goto L03f8;
                                        $r5.type = "event";
                                        goto L042a;
                                        $r5.type = "navigation";
                                    } else {
                                        $r5.type = "actionscript";
                                        goto L042a;
                                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                    }
                                } else {
                                    $r5.type = "navigation";
                                    goto L042a;
                                    $r5.type = "actionscript";
                                    goto L042a;
                                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                                }
                            } else {
                                $r5.type = "event";
                                goto L042a;
                                $r5.type = "navigation";
                                goto L042a;
                                $r5.type = "actionscript";
                                goto L042a;
                            }
                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                            $r4 = $r4 + 1;
                            goto L069d;
                            var $old44 = $r2;
                            $r2 = $r2 + 1;
                            if (!!!(cuePoints[$old44] == "d")) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                            }
                            if (isNaN(cuePoints[$r2])) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "disabled must be number");
                            }
                            $r9 = !(cuePoints[$r2] == 0);
                            $r4 = $r4 + 1;
                            goto L069d;
                            var $old45 = $r2;
                            $r2 = $r2 + 1;
                            if (!!!(cuePoints[$old45] == "p")) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                            }
                            if (isNaN(cuePoints[$r2])) {
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                            }
                            $r8 = cuePoints[$r2];
                            $r4 = $r4 + 1;
                            if ($r8 == 0) {
                                $r4 = $r4 + 1;
                            } else {
                                $r5.parameters = new Object();
                            }
                            goto L069d;
                            var $old46 = $r2;
                            $r2 = $r2 + 1;
                            $r6 = cuePoints[$old46];
                            $r7 = cuePoints[$r2];
                            if (typeof $r6 == "string") {
                                $r6 = this.unescape($r6);
                            }
                            if (typeof $r7 == "string") {
                                $r7 = this.unescape($r7);
                            }
                            $r5.parameters[$r6] = $r7;
                            $r8 = $r8 - 1;
                            if ($r8 == 0) {
                                $r4 = $r4 + 1;
                            }
                            goto L069d;
                        }
                    }
                } else {
                    this.addOrDisable($r9, $r5);
                    $r4 = 0;
                    var $old47 = $r2;
                    $r2 = $r2 + 1;
                    if (!!!(cuePoints[$old47] == "t")) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                    }
                    if (isNaN(cuePoints[$r2])) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number");
                    }
                    $r5 = new Object();
                    $r5.time = cuePoints[$r2] / 1000;
                    $r4 = $r4 + 1;
                    goto L069d;
                    var $old48 = $r2;
                    $r2 = $r2 + 1;
                    if (!!!(cuePoints[$old48] == "n")) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                    }
                    if ((cuePoints[$r2] == undefined) || (cuePoints[$r2] == null)) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "name cannot be null or undefined");
                    }
                    $r5.name = this.unescape(cuePoints[$r2]);
                    $r4 = $r4 + 1;
                    goto L069d;
                    var $old49 = $r2;
                    $r2 = $r2 + 1;
                    if (!!!(cuePoints[$old49] == "t")) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                    }
                    if (isNaN(cuePoints[$r2])) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be number");
                    }
                    $r0 = cuePoints[$r2];
                    if (!($r0 === 0)) {
                        if (!($r0 === 1)) {
                            if (!($r0 === 2)) {
                                goto L03f8;
                                $r5.type = "event";
                                goto L042a;
                                $r5.type = "navigation";
                            } else {
                                $r5.type = "actionscript";
                                goto L042a;
                                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                            }
                        } else {
                            $r5.type = "navigation";
                            goto L042a;
                            $r5.type = "actionscript";
                            goto L042a;
                            throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                        }
                    } else {
                        $r5.type = "event";
                        goto L042a;
                        $r5.type = "navigation";
                        goto L042a;
                        $r5.type = "actionscript";
                        goto L042a;
                    }
                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "type must be 0, 1 or 2");
                    $r4 = $r4 + 1;
                    goto L069d;
                    var $old50 = $r2;
                    $r2 = $r2 + 1;
                    if (!!!(cuePoints[$old50] == "d")) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                    }
                    if (isNaN(cuePoints[$r2])) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "disabled must be number");
                    }
                    $r9 = !(cuePoints[$r2] == 0);
                    $r4 = $r4 + 1;
                    goto L069d;
                    var $old51 = $r2;
                    $r2 = $r2 + 1;
                    if (!!!(cuePoints[$old51] == "p")) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected cuePoint parameter format");
                    }
                    if (isNaN(cuePoints[$r2])) {
                        throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "num params must be number");
                    }
                    $r8 = cuePoints[$r2];
                    $r4 = $r4 + 1;
                    if ($r8 == 0) {
                        $r4 = $r4 + 1;
                    } else {
                        $r5.parameters = new Object();
                    }
                    goto L069d;
                    var $old52 = $r2;
                    $r2 = $r2 + 1;
                    $r6 = cuePoints[$old52];
                    $r7 = cuePoints[$r2];
                    if (typeof $r6 == "string") {
                        $r6 = this.unescape($r6);
                    }
                    if (typeof $r7 == "string") {
                        $r7 = this.unescape($r7);
                    }
                    $r5.parameters[$r6] = $r7;
                    $r8 = $r8 - 1;
                    if ($r8 == 0) {
                        $r4 = $r4 + 1;
                    }
                    goto L069d;
                }
                $r2 = $r2 + 1;
            }
            if ($r4 == 6) {
                this.addOrDisable($r9, $r5);
            } else {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "unexpected end of cuePoint param string");
            }
        };
    $r2.addOrDisable = function (disable, cuePoint) {
            if (disable) {
                if (cuePoint.type == "actionscript") {
                    throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "Cannot disable actionscript cue points");
                }
                this.setFLVCuePointEnabled(false, cuePoint);
            } else {
                if (cuePoint.type == "actionscript") {
                    this.addASCuePoint(cuePoint);
                }
            }
        };
    $r2.unescape = function (origStr) {
            $r3 = origStr;
            $r1 = 0;
            while ($r1 < mx.video.CuePointManager.cuePointsReplace.length) {
                var $old1 = $r1;
                $r1 = $r1 + 1;
                $r2 = $r3.split(mx.video.CuePointManager.cuePointsReplace[$old1]);
                if ($r2.length > 1) {
                    $r3 = $r2.join(mx.video.CuePointManager.cuePointsReplace[$r1]);
                }
                $r1 = $r1 + 1;
            }
            return $r3;
        };
    $r2.getCuePointIndex = function (cuePointArray, closeIsOK, time, name, start, len) {
            if (((cuePointArray == null) || (cuePointArray == undefined)) || (cuePointArray.length < 1)) {
                return -1;
            }
            $r13 = isNaN(time) || (time < 0);
            $r16 = (name == undefined) || (name == null);
            if ($r13 && $r16) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number and/or name must not be undefined or null");
            }
            if ((start == undefined) || (start == null)) {
                start = 0;
            }
            if ((len == undefined) || (len == null)) {
                len = cuePointArray.length;
            }
            if (!$r16 && (closeIsOK || $r13)) {
                $r8 = undefined;
                $r2 = undefined;
                if ($r13) {
                    $r8 = start;
                } else {
                    $r8 = this.getCuePointIndex(cuePointArray, closeIsOK, time);
                }
                $r2 = $r8;
                while (!!!($r2 < start)) {
                    if (cuePointArray[$r2].name == name) {
                        break;
                    }
                    $r2 = $r2 - 1;
                }
                if (!!!($r2 < start)) {
                    return $r2;
                }
                $r2 = $r8 + 1;
                while ($r2 < len) {
                    if (cuePointArray[$r2].name == name) {
                        break;
                    }
                    $r2 = $r2 + 1;
                }
                if ($r2 < len) {
                    return $r2;
                }
                return -1;
            }
            $r6 = undefined;
            if (!!!(len > this._linearSearchTolerance)) {
                $r11 = start + len;
                $r3 = start;
                while ($r3 < $r11) {
                    $r6 = mx.video.CuePointManager.cuePointCompare(time, name, cuePointArray[$r3]);
                    if ($r6 == 0) {
                        return $r3;
                    }
                    if ($r6 < 0) {
                        break;
                    }
                    $r3 = $r3 + 1;
                }
                if (closeIsOK) {
                    if ($r3 > 0) {
                        return $r3 - 1;
                    }
                    return 0;
                }
                return -1;
            }
            $r12 = Math.floor(len / 2);
            $r15 = start + $r12;
            $r6 = mx.video.CuePointManager.cuePointCompare(time, name, cuePointArray[$r15]);
            if ($r6 < 0) {
                return this.getCuePointIndex(cuePointArray, closeIsOK, time, name, start, $r12);
            }
            if ($r6 > 0) {
                return this.getCuePointIndex(cuePointArray, closeIsOK, time, name, $r15 + 1, ($r12 - 1) + (len % 2));
            }
            return $r15;
        };
    $r2.getNextCuePointIndexWithName = function (name, array, index) {
            if ((name == undefined) || (name == null)) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "name cannot be undefined or null");
            }
            if ((array == null) || (array == undefined)) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "cuePoint.array undefined");
            }
            if ((isNaN(index) || (index < -1)) || !(index < array.length)) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "cuePoint.index must be number between -1 and cuePoint.array.length");
            }
            $r1 = undefined;
            $r1 = index + 1;
            while ($r1 < array.length) {
                if (array[$r1].name == name) {
                    break;
                }
                $r1 = $r1 + 1;
            }
            if ($r1 < array.length) {
                return $r1;
            }
            return -1;
        };
    $r1.cuePointCompare = function (time, name, cuePoint) {
            $r2 = Math.round(time * 1000);
            $r3 = Math.round(cuePoint.time * 1000);
            if ($r2 < $r3) {
                return -1;
            }
            if ($r2 > $r3) {
                return 1;
            }
            if (!(name == null) || !(name == undefined)) {
                if (name == cuePoint.name) {
                    return 0;
                }
                if (name < cuePoint.name) {
                    return -1;
                }
                return 1;
            }
            return 0;
        };
    $r2.getCuePoint = function (cuePointArray, closeIsOK, timeNameOrCuePoint) {
            $r3 = undefined;
            $r0 = typeof timeNameOrCuePoint;
            if (!($r0 === "string")) {
                if (!($r0 === "number")) {
                    if (!($r0 === "object")) {
                        goto L007a;
                        $r3 = {name: timeNameOrCuePoint};
                        goto L007a;
                        $r3 = {time: timeNameOrCuePoint};
                    } else {
                        $r3 = timeNameOrCuePoint;
                        goto L007a;
                    }
                } else {
                    $r3 = {time: timeNameOrCuePoint};
                    goto L007a;
                    $r3 = timeNameOrCuePoint;
                    goto L007a;
                }
            } else {
                $r3 = {name: timeNameOrCuePoint};
                goto L007a;
                $r3 = {time: timeNameOrCuePoint};
                goto L007a;
                $r3 = timeNameOrCuePoint;
                goto L007a;
            }
            $r2 = this.getCuePointIndex(cuePointArray, closeIsOK, $r3.time, $r3.name);
            if ($r2 < 0) {
                return null;
            }
            $r3 = mx.video.CuePointManager.deepCopyObject(cuePointArray[$r2]);
            $r3.array = cuePointArray;
            $r3.index = $r2;
            return $r3;
        };
    $r2.getNextCuePointWithName = function (cuePoint) {
            if ((cuePoint == null) || (cuePoint == undefined)) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "cuePoint parameter undefined");
            }
            if (isNaN(cuePoint.time) || (cuePoint.time < 0)) {
                throw new mx.video.VideoError(mx.video.VideoError.ILLEGAL_CUE_POINT, "time must be number");
            }
            $r3 = this.getNextCuePointIndexWithName(cuePoint.name, cuePoint.array, cuePoint.index);
            if ($r3 < 0) {
                return null;
            }
            $r4 = mx.video.CuePointManager.deepCopyObject(cuePoint.array[$r3]);
            $r4.array = cuePoint.array;
            $r4.index = $r3;
            return $r4;
        };
    $r1.deepCopyObject = function (obj, recurseLevel) {
            if (((obj == undefined) || (obj == null)) || !(typeof obj == "object")) {
                return obj;
            }
            if (recurseLevel == undefined) {
                recurseLevel = 0;
            }
            $r2 = new Object();
            while (true) {
                $r0 = /*enumerate*/ obj;
                if ($r0 == null) break;
                $r4 = $r0;
                if ((recurseLevel == 0) && (($r4 == "array") || ($r4 == "index"))) {
                } else {
                    if (typeof obj[$r4] == "object") {
                        $r2[$r4] = mx.video.CuePointManager.deepCopyObject(obj[$r4], recurseLevel + 1);
                    } else {
                        $r2[$r4] = obj[$r4];
                    }
                }
            }
            return $r2;
        };
    $r1.DEFAULT_LINEAR_SEARCH_TOLERANCE = 50;
    $r1.cuePointsReplace = ["&quot;", "\"", "&#39;", "'", "&#44;", ",", "&amp;", "&"];
}
ASSetPropFlags(mx.video.CuePointManager.prototype, null, 1);
// ======== DoInitAction sprite=5 VideoPlayer
Object.registerClass("VideoPlayer", mx.video.VideoPlayer);
// ======== DoInitAction sprite=9 FLVPlayback
Object.registerClass("FLVPlayback", mx.video.FLVPlayback);
