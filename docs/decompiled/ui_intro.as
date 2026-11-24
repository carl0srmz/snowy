// ---- DoAction
stop();
intro = true;
button.useHandCursor = false;
// sprite id=11  frames=1
// sprite id=14  frames=1
// sprite id=17  frames=1
// sprite id=22  frames=4
// sprite id=30  frames=12
// sprite id=33  frames=1
// sprite id=34  frames=44
  // frame 44 DoAction
    stop();
// sprite id=35  frames=13
  // frame 13 DoAction
    stop();
// sprite id=36  frames=399
  // frame 1 DoAction
    stop();
  // frame 24 label ende
  // frame 24 DoAction
    _root.titletheme.setVolume(100);
    _root.titletheme.start();
    _root.impressum.gotoAndStop("inactive");
  // frame 114 DoAction
    chubby.gotoAndStop(1);
  // frame 127 DoAction
    chubby.gotoAndPlay(3);
  // frame 275 DoAction
    chubby.gotoAndStop(1);
  // frame 293 DoAction
    chubby.gotoAndStop(1);
  // frame 310 DoAction
    chubby.gotoAndPlay(3);
  // frame 399 DoAction
    _root.startWorldmap();
    stop();
// ======== DoInitAction sprite=366 __Packages.com.extratoxic.utils.XMLUtil
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
// ======== DoInitAction sprite=367 __Packages.com.extratoxic.audio.SoundFile
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
                        this.counter = this.counter - 1;
                        if (this.counter == 0) {
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
// sprite id=45  frames=1
// sprite id=47  frames=1
// sprite id=50  frames=1
// sprite id=51  frames=132
  // frame 1 DoAction
    stop();
  // frame 25 label glanz
  // frame 93 DoAction
    stop();
  // frame 105 label break
  // frame 125 label broken
  // frame 125 DoAction
    stop();
// sprite id=52  frames=1
// sprite id=54  frames=1
  // frame 1 DoAction
    off_01_ort.text = com.extratoxic.utils.XMLUtil.getValueByName(_root.introXML, "00_off_01_ort");
    var tf = new TextFormat();
    tf.letterSpacing = 1;
    off_01_ort.setTextFormat(tf);
// sprite id=56  frames=1
// sprite id=58  frames=1
// sprite id=62  frames=1
// sprite id=64  frames=1
// sprite id=65  frames=128
// sprite id=68  frames=1
// sprite id=69  frames=70
  // frame 1 DoAction
    stop();
  // frame 2 label loop
  // frame 21 label speak
  // frame 70 DoAction
    gotoLabel("loop");
    play();
// sprite id=72  frames=1
// sprite id=73  frames=48
  // frame 2 DoAction
    zuck = random(45) + 3;
    gotoAndPlay(zuck);
  // frame 37 DoAction
    gotoFrame(0);
    play();
// sprite id=74  frames=1
// sprite id=77  frames=1
// sprite id=79  frames=1
// sprite id=81  frames=1
// sprite id=82  frames=37
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 17 label speak
  // frame 37 DoAction
    gotoLabel("speak");
    play();
// sprite id=84  frames=1
// sprite id=88  frames=9
  // frame 9 DoAction
    stop();
// sprite id=89  frames=79
  // frame 2 DoAction
    blinzel = random(70) + 3;
    gotoAndPlay(blinzel);
  // frame 64 DoAction
    gotoFrame(0);
    play();
// sprite id=91  frames=1
// sprite id=92  frames=24
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 18 label speak
  // frame 24 DoAction
    gotoLabel("speak");
    play();
// sprite id=93  frames=1
// sprite id=94  frames=31
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 8 label speak
  // frame 31 DoAction
    gotoLabel("speak");
    play();
// sprite id=96  frames=1
// sprite id=99  frames=1
// sprite id=100  frames=1
// sprite id=102  frames=1
// sprite id=105  frames=1
// sprite id=106  frames=35
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 19 label speak
  // frame 31 DoAction
    gotoLabel("speak");
    play();
// sprite id=110  frames=1
// sprite id=111  frames=26
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 18 label speak
  // frame 26 DoAction
    gotoLabel("speak");
    play();
// sprite id=112  frames=1
// sprite id=114  frames=1
// sprite id=116  frames=1
// sprite id=121  frames=51
  // frame 2 DoAction
    blinzel = random(40) + 2;
    gotoAndPlay(blinzel);
  // frame 35 DoAction
    gotoFrame(0);
    play();
// sprite id=122  frames=1
// sprite id=125  frames=1
// sprite id=126  frames=55
  // frame 1 DoAction
    bild.gotoAndPlay("broken");
    stop();
  // frame 28 label speak
  // frame 40 DoAction
    gotoLabel("speak");
    play();
// sprite id=129  frames=1
// sprite id=132  frames=1
// sprite id=134  frames=1
// sprite id=136  frames=1
// sprite id=138  frames=1
// sprite id=139  frames=128
  // frame 1 label hüfte
  // frame 2 DoAction
    stop();
  // frame 9 label hüfte_h
  // frame 10 DoAction
    stop();
  // frame 20 label frage
  // frame 34 label frage_loop
  // frame 74 DoAction
    gotoLabel("frage_loop");
    play();
  // frame 82 label kopffass
  // frame 83 DoAction
    stop();
  // frame 92 label hoch
  // frame 93 DoAction
    stop();
  // frame 108 label hoch_v
  // frame 109 DoAction
    stop();
// sprite id=140  frames=25
  // frame 1 label on
  // frame 12 DoAction
    gotoLabel("on");
    play();
  // frame 16 label off
  // frame 16 DoAction
    stop();
// sprite id=142  frames=1
// sprite id=144  frames=1
// sprite id=145  frames=27
  // frame 1 label on
  // frame 12 DoAction
    gotoLabel("on");
    play();
  // frame 17 label off
  // frame 17 DoAction
    stop();
// sprite id=147  frames=13
// sprite id=148  frames=27
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 9 label on
  // frame 9 DoAction
    bein_h.gotoAndPlay(9);
    stop();
// sprite id=150  frames=1
// sprite id=151  frames=29
  // frame 1 label on
  // frame 12 DoAction
    gotoLabel("on");
    play();
  // frame 16 label off
  // frame 16 DoAction
    stop();
// sprite id=153  frames=27
  // frame 1 label on
  // frame 7 DoAction
    gotoLabel("on");
    play();
  // frame 17 label off
  // frame 17 DoAction
    stop();
// sprite id=156  frames=39
  // frame 1 label off
  // frame 1 DoAction
  // frame 19 label on
  // frame 39 DoAction
    gotoLabel("on");
    play();
// sprite id=157  frames=1
// sprite id=160  frames=1
// sprite id=161  frames=26
  // frame 1 label on
  // frame 7 DoAction
    gotoLabel("on");
    play();
  // frame 17 label off
  // frame 17 DoAction
    stop();
// sprite id=165  frames=59
  // frame 1 DoAction
    blinzel = random(45) + 2;
    gotoAndPlay(blinzel);
  // frame 41 DoAction
    gotoFrame(0);
    play();
// sprite id=166  frames=1
// sprite id=167  frames=29
  // frame 1 label on
  // frame 12 DoAction
    gotoLabel("on");
    play();
  // frame 16 label off
  // frame 16 DoAction
    stop();
// sprite id=168  frames=1
// sprite id=170  frames=1
// sprite id=172  frames=1
// sprite id=174  frames=1
// sprite id=176  frames=1
// sprite id=177  frames=196
  // frame 1 label erklär
  // frame 9 label erklär_loop
  // frame 53 DoAction
    gotoLabel("erklär_loop");
    play();
  // frame 59 label zeig
  // frame 72 label zeig_loop
  // frame 140 DoAction
    gotoLabel("zeig_loop");
    play();
  // frame 149 label tasche
  // frame 154 DoAction
    stop();
// sprite id=178  frames=23
  // frame 1 label on
  // frame 12 DoAction
    gotoLabel("on");
    play();
  // frame 17 label off
  // frame 17 DoAction
    stop();
// sprite id=182  frames=26
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 19 label on
  // frame 26 DoAction
    gotoLabel("on");
    play();
// sprite id=186  frames=1
// sprite id=187  frames=34
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 22 label on
  // frame 34 DoAction
    gotoLabel("on");
    play();
// sprite id=188  frames=1
// sprite id=189  frames=1
// sprite id=195  frames=59
  // frame 2 DoAction
    blinzel = random(45) + 2;
    gotoAndPlay(blinzel);
  // frame 40 DoAction
    gotoFrame(0);
    play();
// sprite id=196  frames=30
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 18 label on
  // frame 30 DoAction
    gotoLabel("on");
    play();
// sprite id=198  frames=1
// sprite id=199  frames=1
// sprite id=206  frames=21
  // frame 1 DoAction
    stop();
  // frame 12 label lookatchubby
  // frame 12 DoAction
    stop();
// sprite id=208  frames=1
// sprite id=210  frames=1
// sprite id=212  frames=1
// sprite id=213  frames=42
  // frame 1 label on
  // frame 14 DoAction
    gotoLabel("on");
    play();
  // frame 29 label off
  // frame 29 DoAction
    stop();
// sprite id=215  frames=1
// sprite id=218  frames=1
// sprite id=222  frames=1
// sprite id=223  frames=23
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 11 label on
  // frame 23 DoAction
    gotoLabel("on");
    play();
// sprite id=225  frames=1
// sprite id=228  frames=58
  // frame 1 DoAction
    blinzel = random(45) + 2;
    gotoAndPlay(blinzel);
  // frame 42 DoAction
    gotoFrame(0);
    play();
  // frame 48 label close
// sprite id=230  frames=1
// sprite id=232  frames=241
  // frame 1 label front
  // frame 1 DoAction
    stop();
  // frame 19 label iso
  // frame 39 DoAction
    stop();
  // frame 49 label down
  // frame 59 DoAction
    stop();
  // frame 69 label finale
  // frame 83 DoAction
    augen.gotoAndPlay("close");
    _root.eyepling.start();
  // frame 92 DoAction
    augen.gotoAndPlay("close");
    _root.eyepling.start();
  // frame 121 label finale_up
  // frame 165 DoAction
    _parent._parent._parent.gotoAndPlay("ende");
    stop();
  // frame 196 label back
  // frame 196 DoAction
    stop();
// sprite id=233  frames=34
  // frame 1 label on
  // frame 14 DoAction
    gotoLabel("on");
    play();
  // frame 22 label off
  // frame 22 DoAction
    stop();
// sprite id=236  frames=1
// sprite id=238  frames=17
  // frame 1 DoAction
    stop();
  // frame 10 label formular
  // frame 10 DoAction
    stop();
// sprite id=239  frames=43
  // frame 1 label on
  // frame 25 DoAction
    gotoLabel("on");
    play();
  // frame 30 label off
  // frame 30 DoAction
    stop();
// sprite id=241  frames=1
// sprite id=242  frames=38
  // frame 1 label on
  // frame 14 DoAction
    gotoLabel("on");
    play();
  // frame 24 label back
  // frame 38 DoAction
    gotoLabel("back");
    play();
// sprite id=244  frames=1
// sprite id=246  frames=1
// sprite id=247  frames=278
  // frame 1 label still
  // frame 1 DoAction
    hand_r.gotoAndStop("off");
    hand.gotoAndStop("off");
    stop();
  // frame 28 label walk
  // frame 28 DoAction
    foot2.gotoAndPlay(9);
    hand_r.gotoAndPlay(13);
    hand.gotoAndPlay("on");
    kopf.gotoAndPlay("on");
    body.gotoAndPlay("on");
  // frame 30 DoAction
    stop();
  // frame 50 label foto
  // frame 79 DoAction
    stop();
  // frame 84 label back
  // frame 84 DoAction
    foot1.gotoAndPlay("back");
    foot2.gotoAndPlay(32);
    hand_r.gotoAndPlay(17);
    kopf.gotoAndPlay("on");
    kopf.kopf.gotoAndStop("back");
    body.gotoAndPlay("on");
    hand.hand.gotoAndStop("formular");
    hand.gotoAndPlay("on");
    stop();
  // frame 101 label sit
  // frame 101 DoAction
    hand_r.gotoAndStop("off");
    hand_r.hand.gotoAndStop("formular");
    kopf.gotoAndStop("off");
    body.gotoAndStop("off");
  // frame 139 DoAction
    kopf.kopf.gotoAndPlay("down");
  // frame 157 DoAction
    _parent._parent.play();
  // frame 158 label write
  // frame 245 DoAction
    gotoLabel("write");
    play();
  // frame 273 label finale
  // frame 273 DoAction
    kopf.kopf.gotoAndPlay("finale");
    stop();
// sprite id=250  frames=1
// sprite id=254  frames=1
// sprite id=259  frames=1
// sprite id=260  frames=363
  // frame 194 DoAction
    _root.bing.start();
  // frame 278 DoAction
    _parent.gotoAndPlay("go");
  // frame 363 label still
  // frame 363 DoAction
    stop();
// sprite id=262  frames=1
// sprite id=266  frames=1
// sprite id=269  frames=1
// sprite id=270  frames=21
  // frame 1 label off
  // frame 1 DoAction
    stop();
  // frame 13 label on
  // frame 21 DoAction
    gotoLabel("on");
    play();
// sprite id=272  frames=1
// sprite id=274  frames=1
// sprite id=276  frames=1
// sprite id=278  frames=1
// sprite id=279  frames=89
  // frame 1 label left
  // frame 1 DoAction
    stop();
  // frame 12 label formular
  // frame 33 DoAction
    stop();
  // frame 35 label take_formular
  // frame 60 DoAction
    _parent.gotoAndPlay("sit");
    stop();
  // frame 71 label right
  // frame 71 DoAction
    stop();
  // frame 79 label straight
  // frame 79 DoAction
    stop();
// sprite id=282  frames=1
// sprite id=285  frames=1
// sprite id=286  frames=40
  // frame 1 DoAction
    stop();
// sprite id=287  frames=565
  // frame 1 DoAction
    chubby.kopf.gotoAndStop("off");
    chubby.body.gotoAndStop("off");
    stop();
  // frame 20 label go
  // frame 20 DoAction
    chubby.gotoAndPlay("walk");
  // frame 40 DoAction
    chubby.gotoAndStop("still");
    chubby.body.gotoAndStop("off");
    chubby.kopf.gotoAndStop("off");
  // frame 48 DoAction
    chubby.kopf.kopf.gotoAndPlay("iso");
  // frame 74 DoAction
    chubby.gotoAndPlay("walk");
  // frame 148 DoAction
    chubby.gotoAndStop("still");
    chubby.body.gotoAndStop("off");
    chubby.kopf.gotoAndStop("off");
  // frame 178 DoAction
    _parent.play();
    stop();
  // frame 188 label finale
  // frame 188 DoAction
    chubby.kopf.kopf.gotoAndPlay("iso");
    chubby.kopf.gotoAndStop("off");
    lift.gotoAndStop("still");
    stop();
  // frame 202 label formular
  // frame 202 DoAction
    maria.gotoAndPlay("formular");
    stop();
  // frame 228 label sit
  // frame 228 DoAction
    chubby.gotoAndStop("back");
  // frame 307 DoAction
    chubby.gotoAndStop("still");
    chubby.body.gotoAndStop("off");
    chubby.kopf.gotoAndStop("off");
    chubby.kopf.kopf.gotoAndStop("front");
    chubby.hand_r.hand.gotoAndStop("formular");
    chubby.body.gotoAndStop("off");
  // frame 332 DoAction
    chubby.gotoAndPlay("sit");
    stop();
  // frame 333 label direktor_labortyp
  // frame 335 DoAction
    labortyp.kopf.gotoAndPlay("on");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.arm_v.gotoAndPlay("on");
    labortyp.arm_h.gotoAndPlay("on");
    labortyp.arm_v.arm.gotoAndStop("tasche");
    labortyp.arm_h.arm.gotoAndStop("tasche");
    labortyp.beine.gotoAndPlay("on");
  // frame 337 DoAction
    maria.gotoAndStop("straight");
  // frame 342 DoAction
    maria.gotoAndStop("right");
  // frame 354 DoAction
    maria.gotoAndStop("straight");
  // frame 377 DoAction
    direktor.kopf.gotoAndStop("off");
    direktor.beine.gotoAndStop("off");
    direktor.beine.bauch.gotoAndStop("off");
    direktor.body.gotoAndStop("off");
    direktor.kopf.kopf.nase.gotoAndStop("off");
    direktor.arm_v.gotoAndStop("off");
    direktor.arm_h.gotoAndStop("off");
    direktor.arm_v.arm.gotoAndPlay("hüfte");
    direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 392 DoAction
    labortyp.kopf.gotoAndStop("off");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.arm_v.gotoAndStop("off");
    labortyp.arm_h.gotoAndStop("off");
    labortyp.arm_v.arm.gotoAndStop("tasche");
    labortyp.arm_h.arm.gotoAndStop("tasche");
    labortyp.beine.gotoAndStop("off");
  // frame 395 DoAction
    stop();
  // frame 402 label lookatchubby
  // frame 426 DoAction
    labortyp.kopf.gotoAndPlay("on");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.arm_v.gotoAndPlay("on");
    labortyp.arm_h.gotoAndPlay("on");
    labortyp.arm_v.arm.gotoAndStop("tasche");
    labortyp.arm_h.arm.gotoAndStop("tasche");
    labortyp.beine.gotoAndPlay("on");
  // frame 450 DoAction
    labortyp.kopf.gotoAndStop("off");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.arm_v.gotoAndStop("off");
    labortyp.arm_h.gotoAndStop("off");
    labortyp.arm_v.arm.gotoAndStop("tasche");
    labortyp.arm_h.arm.gotoAndStop("tasche");
    labortyp.beine.gotoAndStop("off");
  // frame 482 DoAction
    maria.gotoAndStop("left");
  // frame 501 DoAction
    bild.gotoAndStop("lookatchubby");
  // frame 548 DoAction
    chubby.gotoAndPlay("finale");
    stop();
  // frame 557 label ende
  // frame 557 DoAction
    _root.leiste.gotoAndPlay("ende");
  // frame 564 DoAction
    stop();
// sprite id=289  frames=1
// sprite id=297  frames=31
  // frame 1 label foto
  // frame 1 DoAction
    id = this._name;
    gotoAndStop(id);
    stop();
  // frame 12 label foto2
  // frame 12 DoAction
    stop();
  // frame 20 label foto3
  // frame 20 DoAction
    stop();
// sprite id=299  frames=1
// sprite id=300  frames=1
// sprite id=301  frames=151
  // frame 1 DoAction
    stop();
  // frame 11 label foto_02
  // frame 77 DoAction
    stop();
  // frame 84 label foto_03
  // frame 149 DoAction
    stop();
// sprite id=304  frames=1
// sprite id=305  frames=5
// sprite id=308  frames=1
// sprite id=310  frames=2
// sprite id=315  frames=2
// sprite id=317  frames=157
  // frame 2 DoAction
    direktor.kopf.gotoAndPlay("on");
    direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    direktor.beine.gotoAndPlay("on");
    direktor.body.gotoAndPlay("on");
    direktor.kopf.kopf.ohr_v.gotoAndPlay("on");
    direktor.kopf.kopf.ohr_h.gotoAndPlay("on");
    direktor.kopf.kopf.nase.gotoAndPlay("on");
    direktor.arm_v.gotoAndPlay("on");
    direktor.arm_h.gotoAndPlay("on");
    direktor.arm_v.arm.gotoAndPlay("hüfte");
    direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 2 DoAction
    labortyp.kopf.gotoAndPlay("on");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.beine.gotoAndPlay("on");
    labortyp.arm_v.gotoAndPlay("on");
    labortyp.arm_h.gotoAndPlay("on");
    labortyp.arm_v.arm.gotoAndPlay("tasche");
    labortyp.arm_h.arm.gotoAndPlay("tasche");
  // frame 134 DoAction
    labortyp.kopf.gotoAndStop("off");
    labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    labortyp.beine.gotoAndStop("off");
    labortyp.arm_v.gotoAndStop("off");
    labortyp.arm_h.gotoAndStop("off");
    labortyp.arm_v.arm.gotoAndPlay("tasche");
    labortyp.arm_h.arm.gotoAndPlay("tasche");
  // frame 150 DoAction
    _parent.play();
    stop();
  // frame 150 DoAction
    direktor.kopf.gotoAndStop("off");
    direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    direktor.beine.gotoAndStop("off");
    direktor.beine.bauch.gotoAndStop("off");
    direktor.body.gotoAndStop("off");
    direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    direktor.kopf.kopf.nase.gotoAndStop("off");
    direktor.arm_v.gotoAndStop("off");
    direktor.arm_h.gotoAndStop("off");
    direktor.arm_v.arm.gotoAndPlay("hüfte");
    direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 153 label still
  // frame 153 DoAction
    stop();
// sprite id=320  frames=1
// sprite id=322  frames=1
// sprite id=326  frames=1
// sprite id=328  frames=1
// sprite id=331  frames=28
  // frame 1 DoAction
    stop();
  // frame 10 label back
  // frame 10 DoAction
    stop();
// sprite id=333  frames=1
// sprite id=334  frames=69
  // frame 1 label walk
  // frame 17 DoAction
    gotoLabel("walk");
    play();
  // frame 25 label still
  // frame 25 DoAction
    stop();
  // frame 41 label back
  // frame 41 DoAction
    body.gotoAndStop("back");
  // frame 57 DoAction
    gotoLabel("back");
    play();
  // frame 60 label back_still
  // frame 60 DoAction
    body.gotoAndStop("back");
    stop();
// sprite id=336  frames=1
// sprite id=346  frames=6
// sprite id=348  frames=554
  // frame 169 DoAction
    elpix.gotoAndStop("still");
    stop();
  // frame 190 label teleport
  // frame 205 DoAction
    stop();
  // frame 220 label back
  // frame 220 DoAction
    elpix.gotoAndStop("back_still");
  // frame 254 DoAction
    elpix.gotoAndPlay("back");
  // frame 415 DoAction
    stop();
// sprite id=349  frames=2300
  // frame 5 DoAction
  // frame 217 label 01_office_01_off
  // frame 217 DoAction
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
  // frame 233 DoAction
    _root.setText(_parent.txt.bla_txt, "01_office_01_off", "center", 1, 20);
  // frame 353 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out");
  // frame 440 DoAction
    bild.gotoAndPlay("glanz");
  // frame 571 label 01_office_02_direktor
  // frame 572 DoAction
    _root.loop1.start(0, 999);
    _root.loop1.setVolume(100);
  // frame 574 DoAction
    _parent.gotoAndPlay("shake");
    bild.gotoAndPlay("break");
  // frame 574 DoAction
    _parent.txt_maske.gotoAndPlay("wechsel_1zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_02_direktor", "center", 1, 40);
  // frame 657 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 668 label 01_office_03_direktor
  // frame 707 DoAction
    direktor.kopf.kopf.mund.gotoAndPlay("speak");
    direktor.kopf.kopf.nase.gotoAndPlay("speak");
    direktor.hand.gotoAndPlay("speak");
    direktor.kopf.gotoAndPlay("speak");
  // frame 707 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_03_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 709 label 01_office_04_labortyp
  // frame 709 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 709 DoAction
    _parent.b_weiter._visible = false;
  // frame 744 DoAction
    labortyp.kopf.mund.gotoAndPlay("speak");
    labortyp.gotoAndPlay("speak");
    labortyp.arm.gotoAndPlay("speak");
  // frame 744 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_04_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 746 label 01_office_05_direktor
  // frame 746 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 746 DoAction
    _parent.b_weiter._visible = false;
  // frame 749 DoAction
    office.direktor.kopf.gotoAndStop("off");
    office.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    office.direktor.beine.gotoAndStop("off");
    office.direktor.body.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    office.direktor.kopf.kopf.nase.gotoAndStop("off");
    office.direktor.arm_v.gotoAndStop("off");
    office.direktor.arm_h.gotoAndStop("off");
    office.direktor.arm_v.arm.gotoAndPlay("hüfte");
    office.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
    office.labortyp.kopf.gotoAndStop("off");
    office.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    office.labortyp.arm_v.gotoAndStop("off");
    office.labortyp.arm_h.gotoAndStop("off");
    office.labortyp.arm_v.arm.gotoAndPlay("tasche");
    office.labortyp.arm_h.arm.gotoAndPlay("tasche");
  // frame 781 DoAction
    office.direktor.kopf.gotoAndStop("off");
    office.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    office.direktor.beine.gotoAndStop("off");
    office.direktor.body.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    office.direktor.kopf.kopf.nase.gotoAndPlay("on");
    office.direktor.arm_v.gotoAndStop("off");
    office.direktor.arm_h.gotoAndStop("off");
    office.direktor.arm_v.arm.gotoAndPlay("kopffass");
    office.direktor.arm_h.arm.gotoAndPlay("frage");
  // frame 781 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_05_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 783 label 01_office_06_labortyp
  // frame 783 DoAction
    office.direktor.kopf.gotoAndStop("off");
    office.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    office.direktor.beine.gotoAndStop("off");
    office.direktor.body.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    office.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    office.direktor.kopf.kopf.nase.gotoAndStop("off");
    office.direktor.arm_v.gotoAndStop("off");
    office.direktor.arm_h.gotoAndStop("off");
    office.direktor.arm_v.arm.gotoAndPlay("hüfte");
    office.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 783 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 783 DoAction
    _parent.b_weiter._visible = false;
  // frame 816 DoAction
    office.labortyp.kopf.gotoAndPlay("on");
    office.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
    office.labortyp.arm_v.gotoAndStop("off");
    office.labortyp.arm_h.gotoAndStop("off");
    office.labortyp.arm_v.arm.gotoAndPlay("tasche");
    office.labortyp.arm_h.arm.gotoAndPlay("erklär");
  // frame 816 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_06_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 818 label 01_office_07_labortyp
  // frame 818 DoAction
    office.labortyp.kopf.gotoAndStop("off");
    office.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    office.labortyp.arm_v.gotoAndStop("off");
    office.labortyp.arm_h.gotoAndStop("off");
    office.labortyp.arm_v.arm.gotoAndPlay("tasche");
    office.labortyp.arm_h.arm.gotoAndPlay("tasche");
  // frame 818 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 818 DoAction
    _parent.b_weiter._visible = false;
  // frame 854 DoAction
    office.labortyp.kopf.gotoAndPlay("on");
    office.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
    office.labortyp.arm_v.gotoAndStop("off");
    office.labortyp.arm_h.gotoAndStop("off");
    office.labortyp.arm_v.arm.gotoAndPlay("tasche");
    office.labortyp.arm_h.arm.gotoAndPlay("erklär");
  // frame 854 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "01_office_07_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 856 label 02_lounge_03_off
  // frame 856 DoAction
    _root.loop1.fadeOut();
  // frame 856 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 856 DoAction
    _parent.b_weiter._visible = false;
  // frame 889 DoAction
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_03_off", "left", 3, 20);
  // frame 918 DoAction
    _root.loop2.setVolume(180);
    _root.loop2.fadeIn();
  // frame 1084 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out");
  // frame 1088 DoAction
    stop();
  // frame 1089 label 02_lounge_04_maria
  // frame 1089 DoAction
    lounge.maria.kopf.gotoAndPlay("on");
  // frame 1089 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_04_maria", "left", 3, 20, true);
    _root.setDelay(7);
  // frame 1091 label 02_lounge_05_chubby
  // frame 1091 DoAction
    lounge.maria.kopf.gotoAndStop("off");
  // frame 1091 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1091 DoAction
    _parent.b_weiter._visible = false;
  // frame 1141 DoAction
    lounge.chubby.kopf.gotoAndPlay("on");
    lounge.chubby.kopf.kopf.mund.gotoAndPlay("on");
  // frame 1141 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_05_chubby", "left", 4, 20, true);
    _root.setDelay(1);
  // frame 1143 DoAction
    lounge.chubby.gotoAndPlay("foto");
  // frame 1143 DoAction
    stop();
    _root.setDelay(7);
  // frame 1145 label 02_lounge_06_chubby
  // frame 1145 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1145 DoAction
    _parent.b_weiter._visible = false;
  // frame 1195 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_06_chubby", "left", 4, 20, true);
    _root.setDelay(7);
  // frame 1197 label 02_lounge_07_chubby
  // frame 1197 DoAction
    karriere.gotoAndPlay("foto_02");
  // frame 1197 DoAction
    _parent.b_weiter._visible = false;
  // frame 1228 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_07_chubby", "left", 4, 20, true);
    _root.setDelay(7);
  // frame 1230 label 02_lounge_08_chubby
  // frame 1230 DoAction
    karriere.gotoAndPlay("foto_03");
  // frame 1230 DoAction
    _parent.b_weiter._visible = false;
  // frame 1262 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "02_lounge_08_chubby", "left", 4, 20, true);
    _root.setDelay(7);
  // frame 1264 label 03_security_01_labortyp
  // frame 1264 DoAction
    _root.loop2.fadeOut();
  // frame 1264 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1264 DoAction
    _parent.b_weiter._visible = false;
  // frame 1325 DoAction
    _root.loop1.fadeIn();
    _root.loop1.setVolume(100);
  // frame 1367 DoAction
    stop();
  // frame 1380 DoAction
    security.labortyp.kopf.gotoAndPlay("on");
    security.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
    security.labortyp.arm_v.gotoAndStop("off");
    security.labortyp.arm_h.gotoAndStop("off");
    security.labortyp.arm_v.arm.gotoAndPlay("tasche");
    security.labortyp.arm_h.arm.gotoAndPlay("zeig");
  // frame 1380 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_01_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1382 label 03_security_02_labortyp
  // frame 1382 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1382 DoAction
    _parent.b_weiter._visible = false;
  // frame 1482 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_02_labortyp", "left", 2, 20, true);
    _root.setDelay(4);
  // frame 1484 label 03_security_07_labortyp
  // frame 1484 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1484 DoAction
    _parent.b_weiter._visible = false;
  // frame 1513 DoAction
    camera.gotoAndPlay("teleport");
  // frame 1513 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_07_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1515 label 03_security_08_labortyp
  // frame 1515 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1515 DoAction
    _parent.b_weiter._visible = false;
  // frame 1548 DoAction
    camera.gotoAndPlay("back");
  // frame 1548 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_08_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1550 label 03_security_09_direktor
  // frame 1550 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1550 DoAction
    _parent.b_weiter._visible = false;
  // frame 1553 DoAction
    security.gotoAndStop("still");
  // frame 1553 DoAction
    security.direktor.kopf.gotoAndStop("off");
    security.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    security.direktor.beine.gotoAndStop("off");
    security.direktor.beine.bauch.gotoAndStop("off");
    security.direktor.body.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    security.direktor.kopf.kopf.nase.gotoAndStop("off");
    security.direktor.arm_v.gotoAndStop("off");
    security.direktor.arm_h.gotoAndStop("off");
    security.direktor.arm_v.arm.gotoAndPlay("hüfte");
    security.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
    security.labortyp.kopf.gotoAndStop("off");
    security.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    security.labortyp.arm_v.gotoAndStop("off");
    security.labortyp.arm_h.gotoAndStop("off");
    security.labortyp.arm_v.arm.gotoAndStop("tasche");
    security.labortyp.arm_h.arm.gotoAndStop("tasche");
  // frame 1586 DoAction
    security.direktor.kopf.gotoAndStop("off");
    security.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    security.direktor.beine.gotoAndStop("off");
    security.direktor.body.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    security.direktor.kopf.kopf.nase.gotoAndPlay("on");
    security.direktor.arm_v.gotoAndStop("off");
    security.direktor.arm_h.gotoAndStop("off");
    security.direktor.arm_v.arm.gotoAndPlay("kopffass");
    security.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1586 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_09_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 1588 label 03_security_10_labortyp
  // frame 1588 DoAction
    security.direktor.kopf.gotoAndStop("off");
    security.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    security.direktor.beine.gotoAndStop("off");
    security.direktor.body.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    security.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    security.direktor.kopf.kopf.nase.gotoAndStop("off");
    security.direktor.arm_v.gotoAndStop("off");
    security.direktor.arm_h.gotoAndStop("off");
    security.direktor.arm_v.arm.gotoAndPlay("hüfte");
    security.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1588 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1588 DoAction
    _parent.b_weiter._visible = false;
  // frame 1624 DoAction
    security.labortyp.kopf.gotoAndPlay("on");
    security.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
    security.labortyp.arm_v.gotoAndStop("off");
    security.labortyp.arm_h.gotoAndStop("off");
    security.labortyp.arm_v.arm.gotoAndPlay("tasche");
    security.labortyp.arm_h.arm.gotoAndPlay("tasche");
  // frame 1624 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "03_security_10_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1626 label 04_lounge_01_maria
  // frame 1626 DoAction
    _root.loop1.fadeOut();
  // frame 1626 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1626 DoAction
    _parent.b_weiter._visible = false;
  // frame 1672 DoAction
    lounge.gotoAndStop("finale");
  // frame 1687 DoAction
    _root.loop2.setVolume(180);
    _root.loop2.fadeIn();
  // frame 1749 DoAction
    lounge.gotoAndPlay("formular");
    lounge.maria.kopf.gotoAndPlay("on");
  // frame 1749 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_01_maria", "left", 3, 20, true);
    _root.setDelay(7);
  // frame 1751 label 04_lounge_02_maria
  // frame 1751 DoAction
    lounge.maria.kopf.gotoAndStop("off");
    lounge.maria.gotoAndPlay("take_formular");
  // frame 1751 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1751 DoAction
    _parent.b_weiter._visible = false;
  // frame 1769 DoAction
    lounge.maria.kopf.gotoAndPlay("on");
  // frame 1769 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_02_maria", "left", 3, 20, true);
    _root.setDelay(7);
  // frame 1771 DoAction
    lounge.maria.kopf.gotoAndStop("off");
    stop();
  // frame 1771 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1771 DoAction
    _parent.b_weiter._visible = false;
  // frame 1819 label 04_lounge_03_direktor
  // frame 1819 DoAction
    lounge.gotoAndPlay("direktor_labortyp");
    lounge.direktor.kopf.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    lounge.direktor.beine.gotoAndPlay("on");
    lounge.direktor.body.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.ohr_v.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.ohr_h.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.nase.gotoAndPlay("on");
    lounge.direktor.arm_v.gotoAndPlay("on");
    lounge.direktor.arm_h.gotoAndPlay("on");
    lounge.direktor.arm_v.arm.gotoAndPlay("kopffass");
    lounge.direktor.arm_h.arm.gotoAndPlay("hoch");
    lounge.labortyp.kopf.gotoAndPlay("on");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.labortyp.arm_v.gotoAndPlay("on");
    lounge.labortyp.arm_h.gotoAndPlay("on");
    lounge.labortyp.arm_v.arm.gotoAndStop("tasche");
    lounge.labortyp.arm_h.arm.gotoAndStop("tasche");
    lounge.labortyp.beine.gotoAndPlay("on");
  // frame 1819 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_03_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 1821 label 04_lounge_04_labortyp
  // frame 1821 DoAction
    lounge.direktor.kopf.gotoAndStop("off");
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.direktor.beine.gotoAndStop("off");
    lounge.direktor.body.gotoAndStop("off");
    lounge.direktor.kopf.kopf.ohr_v.gotoAndStop("off");
    lounge.direktor.kopf.kopf.ohr_h.gotoAndStop("off");
    lounge.direktor.kopf.kopf.nase.gotoAndStop("off");
    lounge.direktor.arm_v.gotoAndStop("off");
    lounge.direktor.arm_h.gotoAndStop("off");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1821 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1821 DoAction
    _parent.b_weiter._visible = false;
  // frame 1855 DoAction
    lounge.labortyp.kopf.gotoAndPlay("on");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
  // frame 1855 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_04_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1857 label 04_lounge_05_direktor
  // frame 1857 DoAction
    lounge.labortyp.kopf.gotoAndStop("off");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
  // frame 1857 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1857 DoAction
    _parent.b_weiter._visible = false;
  // frame 1889 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.nase.gotoAndPlay("on");
    lounge.direktor.arm_v.arm.gotoAndPlay("hoch_v");
    lounge.direktor.arm_h.arm.gotoAndPlay("hoch");
  // frame 1889 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_05_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 1891 label 04_lounge_06_direktor
  // frame 1891 DoAction
    lounge.direktor.kopf.gotoAndStop("off");
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.direktor.kopf.kopf.nase.gotoAndStop("off");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1891 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1891 DoAction
    _parent.b_weiter._visible = false;
  // frame 1925 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.nase.gotoAndPlay("on");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("frage");
  // frame 1925 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_06_direktor", "left", 1, 20, true);
    _root.setDelay(7);
  // frame 1927 label 04_lounge_07_labortyp
  // frame 1927 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.direktor.kopf.kopf.nase.gotoAndStop("off");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1927 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1927 DoAction
    _parent.b_weiter._visible = false;
  // frame 1960 DoAction
    lounge.labortyp.kopf.gotoAndPlay("on");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
  // frame 1960 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_07_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 1962 label 04_lounge_08_direktor
  // frame 1962 DoAction
    lounge.labortyp.kopf.gotoAndStop("off");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
  // frame 1962 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1962 DoAction
    _parent.b_weiter._visible = false;
  // frame 1996 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.nase.gotoAndPlay("on");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("frage");
  // frame 1996 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_08_direktor", "left", 1, 20, true);
    _root.setDelay(5);
  // frame 1998 label 04_lounge_09_labortyp
  // frame 1998 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.direktor.kopf.kopf.nase.gotoAndStop("off");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 1998 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 1998 DoAction
    _parent.b_weiter._visible = false;
  // frame 2028 DoAction
    lounge.labortyp.kopf.gotoAndPlay("on");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
  // frame 2028 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_09_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 2030 label 04_lounge_10_labortyp
  // frame 2030 DoAction
    lounge.labortyp.kopf.gotoAndStop("off");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
  // frame 2030 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 2030 DoAction
    _parent.b_weiter._visible = false;
  // frame 2064 DoAction
    lounge.labortyp.kopf.gotoAndPlay("on");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndPlay("on");
  // frame 2064 DoAction
    stop();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_10_labortyp", "left", 2, 20, true);
    _root.setDelay(7);
  // frame 2066 label 04_lounge_11_direktor
  // frame 2066 DoAction
    lounge.labortyp.kopf.gotoAndStop("off");
    lounge.labortyp.kopf.kopf.kopf.mund.gotoAndStop("off");
  // frame 2066 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 2066 DoAction
    _parent.b_weiter._visible = false;
  // frame 2101 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndPlay("on");
    lounge.direktor.kopf.kopf.nase.gotoAndPlay("on");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 2101 DoAction
    stop();
    _root.loop2.fadeOut();
    _parent.txt_maske.gotoAndPlay("wechsel_3zeile");
    _root.setText(_parent.txt.bla_txt, "04_lounge_11_direktor", "left", 1, 20, true);
    _root.setDelay(5);
  // frame 2103 DoAction
    lounge.direktor.kopf.kopf.kopf.mund.gotoAndStop("off");
    lounge.direktor.kopf.kopf.nase.gotoAndStop("off");
    lounge.direktor.arm_v.arm.gotoAndPlay("hüfte");
    lounge.direktor.arm_h.arm.gotoAndPlay("hüfte_h");
  // frame 2103 DoAction
    _parent.txt_maske.gotoAndPlay("fade_out_fast");
  // frame 2103 DoAction
    _parent.b_weiter._visible = false;
  // frame 2107 DoAction
    _root.loop2.fadeOut(2);
  // frame 2107 DoAction
    lounge.gotoAndPlay("lookatchubby");
  // frame 2299 DoAction
    stop();
  // frame 2300 DoAction
    stop();
// sprite id=352  frames=1
// sprite id=354  frames=1
// sprite id=356  frames=60
  // frame 60 DoAction
    stop();
// sprite id=357  frames=1
// sprite id=358  frames=612
  // frame 1 DoAction
    stop();
  // frame 2 label wechsel
  // frame 2 DoAction
  // frame 232 DoAction
    stop();
  // frame 246 label fade_out
  // frame 303 DoAction
    stop();
  // frame 312 label fade_out_fast
  // frame 320 DoAction
    stop();
  // frame 330 label __wechsel_1zeile
  // frame 389 label wechsel_1zeile
  // frame 389 DoAction
    stop();
  // frame 398 label __wechsel_3zeile
  // frame 572 label wechsel_3zeile
  // frame 573 DoAction
    stop();
// sprite id=360  frames=1
// sprite id=361  frames=28
// sprite id=364  frames=1
// sprite id=365  frames=180
  // frame 1 DoAction
    b_weiter._visible = false;
  // frame 34 DoAction
    stop();
  // frame 59 label shake
  // frame 70 DoAction
    stop();
// ---- DoAction
this._lockroot = true;
piep1 = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("piep1", 1000));
piep1.attachSound("piep1");
piep1.setVolume(80);
piep2 = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("piep2", 1001));
piep2.attachSound("piep2");
piep2.setVolume(80);
piep3 = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("piep3", 1002));
piep3.attachSound("piep3");
piep3.setVolume(80);
piep4 = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("piep4", 1003));
piep4.attachSound("piep4");
piep4.setVolume(80);
bing = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("bing", 1004));
bing.attachSound("bing");
bing.setVolume(80);
eyepling = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("eyepling", 1005));
eyepling.attachSound("eyepling");
eyepling.setVolume(200);
loop1 = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("loop1", 2001));
loop1.attachSound("loop1");
loop1.setVolume(100);
loop2 = soundLounge.getNewSoundFile("track");
loop2.setVolume(100);
worldmap = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("loop4", 2003));
worldmap.attachSound("loop2");
worldmap.setVolume(100);
titletheme = new com.extratoxic.audio.SoundFile(snd.createEmptyMovieClip("title", 2004));
titletheme.attachSound("title");
titletheme.setVolume(100);
// ---- DoAction
function showWorldmap() {
    piep1.fadeOut();
    piep2.fadeOut();
    piep3.fadeOut();
    piep4.fadeOut();
    loop1.fadeOut();
    loop2.fadeOut();
    titletheme.fadeOut();
    worldmap.stop();
    worldmap.fadeIn();
    gotoLabel("worldmap");
}
function setText(txt, text, align, piepNum, size, showButton) {
    $r4 = com.extratoxic.utils.XMLUtil.getValueByName(_root.introXML, text);
    txt.text = "";
    txt.autoSize = true;
    $r2 = new TextFormat();
    $r2.letterSpacing = 2;
    if (size == undefined) {
        $r2.size = 20;
    } else {
        $r2.size = size;
    }
    txt.setTextFormat($r2);
    if (showButton) {
        $r5 = function () {
                    _root.stage.b_weiter._visible = true;
                };
    } else {
        $r5 = null;
    }
    $r6 = " ";
    if (!(text === "01_office_01_off")) {
    } else {
        $r6 = " +++++++++++++++++++ ";
        goto L010a;
    }
    _root["piep" + piepNum].setVolume(80);
    ticker(txt, $r4, $r2, $r5, _root["piep" + piepNum]);
}
function ticker(txt, text, tf, onSoundComplete, speech) {
    oef_ticker.pointer = 0;
    oef_ticker.text = text.split("<BR />").join("\n");
    oef_ticker.text = oef_ticker.text.split("<br />").join("\n");
    oef_ticker.txt = txt;
    oef_ticker.tf = tf;
    oef_ticker.onSoundComplete = onSoundComplete;
    oef_ticker.speech = speech;
    oef_ticker.speechVolume = speech.getVolume();
    speech.start(0, 99);
    oef_ticker.onEnterFrame = function () {
            this.pointer = this.pointer + 1;
            $r2 = this.text.charAt(this.pointer);
            if ($r2 == "\\") {
                $r0 = this.pointer + 2;
                this.pointer = $r0;
                $r2 = this.text.charAt($r0);
            }
            if ($r2 == " ") {
                this.speech.setVolume(0);
            } else {
                this.speech.setVolume(this.speechVolume);
            }
            txt.text = txt.text + $r2;
            txt.setTextFormat(this.tf);
            if (this.pointer == text.length) {
                this.speech.stop();
                this.onSoundComplete();
                this.onEnterFrame = null;
            }
        };
}
function setDelay(sec) {
    $r3 = _root.stage.b_weiter;
    $r3.counter = sec * 34;
    $r3.scene = _root.stage.szene;
    $r3.onEnterFrame = function () {
            $r0 = this.counter - 1;
            this.counter = $r0;
            if ($r0 == 0) {
                this.scene.play();
                this.onEnterFrame = null;
            }
        };
}
var oef_ticker = this.createEmptyMovieClip("oef_t", 99998);
var fps = 0;
var frame = 0;
var ms = getTimer();
this.onEnterFrame = function () {
    if ((getTimer() - ms) > 1000) {
        fps = frame;
        frame = 0;
        ms = getTimer();
    } else {
        frame = frame + 1;
    }
    fps_txt.text = fps;
};
// ---- DoAction
stop();
var tf = new TextFormat();
tf.letterSpacing = 2;
skip_txt.text = com.extratoxic.utils.XMLUtil.getValueByName(introXML, "05_buttons_02_skipintro");
skip_txt.setTextFormat(tf);
