// sprite id=7  frames=8
// sprite id=9  frames=1
// sprite id=10  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=11  frames=10
  // frame 1 DoAction
    stop();
// sprite id=13  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=14 spider_run frames=6
  // frame 1 DoAction
    linkId = "spider_run";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 30;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=21  frames=6
// sprite id=26  frames=2
// sprite id=27  frames=1
// sprite id=28  frames=1
// sprite id=29 killerbee3b frames=108
  // frame 1 DoAction
    linkId = "killerbee3b";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.beeframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.beeframe);
        init = true;
    }
  // frame 102 DoAction
    gotoLabel("loop");
    play();
  // frame 104 label kill
  // frame 104 DoAction
    detached = true;
  // frame 108 label off
  // frame 108 DoAction
    stop();
// sprite id=30 killerbee3a frames=108
  // frame 1 DoAction
    linkId = "killerbee3a";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.beeframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.beeframe);
        init = true;
    }
  // frame 102 DoAction
    gotoLabel("loop");
    play();
  // frame 104 label kill
  // frame 104 DoAction
    detached = true;
  // frame 108 label off
  // frame 108 DoAction
    stop();
// sprite id=31 killerbee2 frames=124
  // frame 1 DoAction
    linkId = "killerbee2";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
  // frame 118 DoAction
    gotoLabel("loop");
    play();
  // frame 120 label kill
  // frame 120 DoAction
    detached = true;
  // frame 124 label off
  // frame 124 DoAction
    stop();
// sprite id=32 killerbee1b frames=108
  // frame 1 DoAction
    linkId = "killerbee1b";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.beeframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.beeframe);
        init = true;
    }
  // frame 102 DoAction
    gotoLabel("loop");
    play();
  // frame 104 label kill
  // frame 104 DoAction
    detached = true;
  // frame 108 label off
  // frame 108 DoAction
    stop();
// sprite id=33 killerbee_still frames=108
  // frame 1 DoAction
    linkId = "killerbee_still";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
    stop();
  // frame 102 DoAction
    gotoLabel("loop");
    play();
  // frame 104 label kill
  // frame 104 DoAction
    detached = true;
  // frame 108 label off
  // frame 108 DoAction
    stop();
// sprite id=34 killerbee1a frames=108
  // frame 1 DoAction
    linkId = "killerbee1a";
    resume = function () {
            this.play();
            this.container.play();
        };
    if (_root.editor) {
        stop();
    }
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.beeframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.beeframe);
        init = true;
    }
  // frame 102 DoAction
    gotoLabel("loop");
    play();
  // frame 104 label kill
  // frame 104 DoAction
    detached = true;
  // frame 108 label off
  // frame 108 DoAction
    stop();
// sprite id=39  frames=12
// sprite id=41  frames=1
// sprite id=49  frames=14
  // frame 14 DoAction
    stop();
// sprite id=50 fire frames=194
  // frame 1 DoAction
    linkId = "fire";
    resume = function () {
            this.play();
            this.container.play();
        };
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 20 label loop
  // frame 21 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 188 DoAction
    gotoLabel("loop");
    play();
  // frame 190 label kill
  // frame 190 DoAction
    detached = true;
  // frame 194 label off
  // frame 194 DoAction
    stop();
// sprite id=53 d_eb_c_b frames=1
  // frame 1 DoAction
    linkId = "d_eb_c_b";
// sprite id=56 d_eb_b frames=1
  // frame 1 DoAction
    linkId = "d_eb_b";
// sprite id=59 d_eb_c frames=1
  // frame 1 DoAction
    linkId = "d_eb_c";
// sprite id=62 d_eb frames=1
  // frame 1 DoAction
    linkId = "d_eb";
// sprite id=65  frames=1
// sprite id=67  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=68 wackel_s frames=2
  // frame 1 DoAction
    linkId = "wackel_s";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle")
    this.force = 50;
  // frame 2 DoAction
    stop();
    init();
// sprite id=71  frames=1
// sprite id=72 tiltstone_s frames=2
  // frame 1 DoAction
    linkId = "tiltstone_s";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle")
    this.force = 50;
  // frame 2 DoAction
    stop();
    init();
// sprite id=75  frames=1
// sprite id=76  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=77 wackel_b frames=2
  // frame 1 DoAction
    linkId = "wackel_b";
    offset = 30;
    resume = function () {
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle")
    this.force = 400;
    this._name = "obstacle";
  // frame 2 DoAction
    stop();
    init();
// sprite id=80  frames=1
// sprite id=81 tiltstone_b frames=2
  // frame 1 DoAction
    linkId = "tiltstone_b";
    offset = 30;
    resume = function () {
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle")
    this.force = 400;
    this._name = "obstacle";
  // frame 2 DoAction
    stop();
    init();
// sprite id=84  frames=1
// sprite id=85  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=86 floe_b frames=2
  // frame 1 DoAction
    linkId = "floe_b";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 2 DoAction
    stop();
    init();
// sprite id=89  frames=1
// sprite id=90 floe frames=2
  // frame 1 DoAction
    linkId = "floe";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this.force = 400;
  // frame 2 DoAction
    stop();
    init();
// sprite id=93  frames=1
// sprite id=95  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 0;
// sprite id=96 p_ds frames=2
  // frame 1 DoAction
    linkId = "p_ds";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.force = 400;
    this.ease = true;
    this.moving = true;
    this.drop = true;
  // frame 2 DoAction
    stop();
    init();
// sprite id=99  frames=1
// sprite id=100 p_ds_b frames=2
  // frame 1 DoAction
    linkId = "p_ds_b";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("obstacle")
    this.force = 1000;
    this.ease = true;
    this.moving = true;
    this.drop = true;
  // frame 2 DoAction
    stop();
    init();
// sprite id=127  frames=111
  // frame 1 DoAction
    this._x = _parent._x - (random(70) + 2);
    gotoAndPlay(random(80) + 50);
// sprite id=128  frames=1
// sprite id=129  frames=1
// sprite id=131  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 4;
// sprite id=132 lava frames=1
  // frame 1 DoAction
    linkId = "lava";
    offset = 30;
    resume = function () {
            this.play();
        };
// sprite id=134  frames=1
// sprite id=137  frames=1
// sprite id=139  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=144  frames=10
// sprite id=145 spider_fall frames=132
  // frame 1 DoAction
    linkId = "spider_fall";
    offset = 0;
    obstacles = 2;
    if (_root.editor) {
        stop();
    }
    event = function () {
            gotoLabel("open");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.type = 31;
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 7 name None
    this.type = 90;
    this._name = "obstacle1";
  // frame 2 label wait
  // frame 2 DoAction
    stop();
  // frame 13 label open
  // frame 127 DoAction
    gotoLabel("wait");
  // frame 128 label kill
  // frame 128 DoAction
    detached = true;
  // frame 132 label off
  // frame 132 DoAction
    stop();
// sprite id=148  frames=1
// sprite id=149  frames=24
// sprite id=150  frames=10
  // frame 1 DoAction
    stop();
// sprite id=151 spider_web frames=6
  // frame 1 DoAction
    linkId = "spider_web";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=155  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 8;
// sprite id=156 n2_4 frames=1
  // frame 1 DoAction
    linkId = "n2_4";
// sprite id=158 n2_2 frames=1
  // frame 1 DoAction
    linkId = "n2_2";
// sprite id=160 n2_3 frames=1
  // frame 1 DoAction
    linkId = "n2_3";
// sprite id=162 n2_1 frames=1
  // frame 1 DoAction
    linkId = "n2_1";
// sprite id=165 n1_l frames=1
  // frame 1 DoAction
    linkId = "n1_l";
// sprite id=167 n1_r frames=1
  // frame 1 DoAction
    linkId = "n1_r";
// sprite id=170  frames=1
// sprite id=183  frames=6
// sprite id=196  frames=24
// sprite id=197  frames=1
// sprite id=198  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=201  frames=11
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("container1")
    this._visible = false;
// sprite id=202 snowspider frames=6
  // frame 1 DoAction
    linkId = "snowspider";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.type = 35;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=206  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = -1;
// sprite id=208  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = 1;
// sprite id=209  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=210 s_i_f frames=12
  // frame 1 label close
  // frame 1 DoAction
    linkId = "s_i_f";
    offset = 30;
    obstacles = 9;
    stop();
    event = function () {
            gotoLabel("open");
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle9";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle5";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 6 name None
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 8 name Some("obstacle4")
    this.glide = -0.4;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 10 name Some("obstacle6")
    this.glide = 0.4;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 12 name Some("obstacle7")
    this.glide = 0.8;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 14 name None
    this._name = "obstacle1";
    this.type = 90;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 16 name Some("obstacle8")
    this.glide = 0.8;
    this.slip = 0.3;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 18 name Some("obstacle3")
    this.glide = -0.8;
    this.massive = true;
  // frame 7 label open
  // frame 7 DoAction
    event = function () {
            gotoLabel("close");
        };
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle5")
    this._name = "obstacle8";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 6 name Some("obstacle1")
    this._name = "obstacle2";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 8 name Some("obstacle4")
    this._name = "obstacle6";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 10 name Some("obstacle2")
    this._name = "obstacle3";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 12 name Some("obstacle3")
    this._name = "obstacle5";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 14 name None
    this.type = 90;
    this._name = "obstacle1";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 16 name Some("obstacle2")
    this._name = "obstacle4";
  // frame 7 ClipAction ClipEventFlag(LOAD) on depth 18 name Some("obstacle5")
    this._name = "obstacle7";
// sprite id=213 s_i_b frames=6
  // frame 1 label close
  // frame 1 DoAction
    linkId = "s_i_b";
    offset = 30;
    stop();
// sprite id=224  frames=24
// sprite id=235  frames=24
// sprite id=246  frames=24
// sprite id=248  frames=1
// sprite id=249  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=250  frames=2
  // frame 1 DoAction
    stop();
// sprite id=252  frames=1
// sprite id=253  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=254  frames=10
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name Some("walk")
    this._visible = false;
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=255 pinkustack2x frames=6
  // frame 1 DoAction
    linkId = "pinkustack2x";
    offset = 0;
    motion = true;
    stack = 4;
    obstacles = 2;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 7 name None
    this.type = 31;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 9 name None
    this.type = 30;
    this._name = "obstacle2";
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=266  frames=24
// sprite id=268  frames=1
// sprite id=269  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=270  frames=2
  // frame 1 DoAction
    stop();
// sprite id=271  frames=10
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name Some("walk")
    this._visible = false;
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=272 pinkustack3x frames=6
  // frame 1 DoAction
    linkId = "pinkustack3x";
    offset = 0;
    motion = true;
    stack = 4;
    obstacles = 3;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 9 name None
    this.type = 31;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 11 name None
    this.type = 31;
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 13 name None
    this.type = 30;
    this._name = "obstacle3";
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=283  frames=24
// sprite id=285  frames=1
// sprite id=286  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=287  frames=2
  // frame 1 DoAction
    stop();
// sprite id=288  frames=10
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name Some("walk")
    this._visible = false;
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=289 pinkustack4x frames=6
  // frame 1 DoAction
    linkId = "pinkustack4x";
    offset = 0;
    motion = true;
    stack = 4;
    obstacles = 4;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 11 name None
    this.type = 31;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 13 name None
    this.type = 31;
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 15 name None
    this.type = 31;
    this._name = "obstacle3";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 17 name None
    this.type = 30;
    this._name = "obstacle4";
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=292  frames=1
// sprite id=298  frames=12
// sprite id=299  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=300  frames=10
  // frame 1 DoAction
    stop();
// sprite id=301 beycnake frames=6
  // frame 1 DoAction
    linkId = "beycnake";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 30;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=304  frames=1
// sprite id=313  frames=8
// sprite id=314  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=315  frames=10
  // frame 1 DoAction
    stop();
// sprite id=316 hellscorpion frames=6
  // frame 1 DoAction
    linkId = "hellscorpion";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=319  frames=1
// sprite id=327  frames=8
// sprite id=328  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=329  frames=10
  // frame 1 DoAction
    stop();
// sprite id=330 scorpion frames=6
  // frame 1 DoAction
    linkId = "scorpion";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=333  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 1;
// sprite id=334 s_c_t_r frames=1
  // frame 1 DoAction
    linkId = "s_c_t_r";
    obstacles = 7;
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle2")
    this.glide = 0.8;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle3")
    this.glide = 0.6;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 6 name Some("obstacle5")
    this.glide = 0.4;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 8 name Some("obstacle1")
    this.glide = 0.5;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 10 name Some("obstacle4")
    this.glide = 0.6;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 12 name Some("obstacle6")
    this.glide = 0.5;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 14 name None
    this._name = "obstacle7";
// sprite id=336 s_c_t_l frames=1
  // frame 1 DoAction
    linkId = "s_c_t_l";
    obstacles = 7;
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle2")
    this.glide = -0.8;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle3")
    this.glide = -0.6;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 6 name Some("obstacle5")
    this.glide = -0.4;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 8 name Some("obstacle1")
    this.glide = -0.5;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 10 name Some("obstacle4")
    this.glide = -0.6;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 12 name Some("obstacle6")
    this.glide = -0.5;
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 14 name None
    this._name = "obstacle7";
// sprite id=339 s_c_b1_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_l";
    offset = 30;
// sprite id=341 s_c_b1_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_r";
    offset = 30;
// sprite id=344 s_c_b_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b_r";
    offset = 30;
// sprite id=346 s_c_b_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b_l";
    offset = 30;
// sprite id=349 b2_t_r frames=1
  // frame 1 DoAction
    linkId = "b2_t_r";
    obstacles = 2;
    offset = 30;
// sprite id=352 b1_t_r frames=1
  // frame 1 DoAction
    linkId = "b1_t_r";
    obstacles = 2;
    offset = 30;
// sprite id=354 b2_t_l frames=1
  // frame 1 DoAction
    linkId = "b2_t_l";
    obstacles = 2;
    offset = 30;
// sprite id=356 b1_t_l frames=1
  // frame 1 DoAction
    linkId = "b1_t_l";
    obstacles = 2;
    offset = 30;
// sprite id=359 b2_b_l_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_l_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=361 b2_b_l_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_l_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=364 b2_b_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=367 b1_b_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=370 b2_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_l";
    offset = 30;
// sprite id=373 b1_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_l";
    offset = 30;
// sprite id=376 b2_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=379 b1_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=382 b2_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_r";
    offset = 30;
// sprite id=385 b1_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_r";
    offset = 30;
// sprite id=388 b2_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=391 b_l_s_s frames=1
  // frame 1 DoAction
    linkId = "b_l_s_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.4;
// sprite id=394 b_l_s frames=1
  // frame 1 DoAction
    linkId = "b_l_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.4;
// sprite id=397 b_s frames=1
  // frame 1 DoAction
    linkId = "b_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.4;
// sprite id=399 b1_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=401 b2_b_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=403 b1_b_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=406 t2_b frames=1
  // frame 1 DoAction
    linkId = "t2_b";
// sprite id=409 p_top_t frames=1
  // frame 1 DoAction
    linkId = "p_top_t";
// sprite id=411 t1_b frames=1
  // frame 1 DoAction
    linkId = "t1_b";
// sprite id=414 f_t_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_t_l";
// sprite id=416 f_t_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_t_r";
// sprite id=419 f_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_r";
// sprite id=422 f_s_t_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t_t";
// sprite id=425 f_s_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t";
// sprite id=427 f_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_l";
// sprite id=430 f_s_b frames=1
  // frame 1 DoAction
    linkId = "f_s_b";
    offset = 30;
// sprite id=433 f_b_t frames=1
  // frame 1 DoAction
    linkId = "f_b_t";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=436 f_l_b frames=1
  // frame 1 DoAction
    linkId = "f_l_b";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=439 f_b frames=1
  // frame 1 DoAction
    linkId = "f_b";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=442 f_r_t frames=1
  // frame 1 DoAction
    linkId = "f_r_t";
    offset = 30;
// sprite id=445 f_r frames=1
  // frame 1 DoAction
    linkId = "f_r";
    offset = 30;
// sprite id=447 f_l_t frames=1
  // frame 1 DoAction
    linkId = "f_l_t";
    offset = 30;
// sprite id=450 f_l_r frames=1
  // frame 1 DoAction
    linkId = "f_l_r";
    offset = 30;
// sprite id=452 f_l_l frames=1
  // frame 1 DoAction
    linkId = "f_l_l";
    offset = 30;
// sprite id=454 f_l frames=1
  // frame 1 DoAction
    linkId = "f_l";
    offset = 30;
// sprite id=457 s_rb frames=1
  // frame 1 DoAction
    linkId = "s_rb";
    offset = 30;
// sprite id=460 s_rb_s frames=1
  // frame 1 DoAction
    linkId = "s_rb_s";
    offset = 30;
// sprite id=463 s_r_t frames=1
  // frame 1 DoAction
    linkId = "s_r_t";
    offset = 30;
// sprite id=466 s_l_s frames=1
  // frame 1 DoAction
    linkId = "s_l_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=469 s_l_t_s frames=1
  // frame 1 DoAction
    linkId = "s_l_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=471 s_r_t_s frames=1
  // frame 1 DoAction
    linkId = "s_r_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=473 s_r_s frames=1
  // frame 1 DoAction
    linkId = "s_r_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=476 s_r frames=1
  // frame 1 DoAction
    linkId = "s_r";
    offset = 30;
// sprite id=478 s_l_t frames=1
  // frame 1 DoAction
    linkId = "s_l_t";
    offset = 30;
// sprite id=480 s_l frames=1
  // frame 1 DoAction
    linkId = "s_l";
    offset = 30;
// sprite id=483 s_b_r frames=1
  // frame 1 DoAction
    linkId = "s_b_r";
    offset = 30;
// sprite id=485 s_b_l frames=1
  // frame 1 DoAction
    linkId = "s_b_l";
    offset = 30;
// sprite id=488 s_b_s frames=1
  // frame 1 DoAction
    linkId = "s_b_s";
    offset = 30;
// sprite id=489 s_b frames=1
  // frame 1 DoAction
    linkId = "s_b";
    offset = 30;
// sprite id=492 s_b_r_t frames=1
  // frame 1 DoAction
    linkId = "s_b_r_t";
    offset = 30;
// sprite id=494 s_b_l_t frames=1
  // frame 1 DoAction
    linkId = "s_b_l_t";
    offset = 30;
// sprite id=497 s_st2 frames=1
  // frame 1 DoAction
    linkId = "s_st2";
    offset = 30;
// sprite id=500 s_st frames=1
  // frame 1 DoAction
    linkId = "s_st";
    offset = 30;
// sprite id=501 s_b_t frames=1
  // frame 1 DoAction
    linkId = "s_b_t";
    offset = 30;
// sprite id=503 wire frames=1
  // frame 1 DoAction
    linkId = "wire";
// sprite id=505  frames=1
// sprite id=506 be_b frames=1
  // frame 1 DoAction
    linkId = "be_b";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=507 be2 frames=1
  // frame 1 DoAction
    linkId = "be2";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=508 be1 frames=1
  // frame 1 DoAction
    linkId = "be1";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=509 be frames=1
  // frame 1 DoAction
    linkId = "be";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=510 bh frames=1
  // frame 1 DoAction
    linkId = "bh";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
// sprite id=535  frames=105
  // frame 1 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        gotoAndPlay(_root.coinframe);
        init = true;
    }
  // frame 21 label turn
  // frame 28 DoAction
  // frame 43 label glanz
  // frame 50 DoAction
// sprite id=536  frames=83
  // frame 1 DoAction
    stop();
  // frame 9 DoAction
    crystal.gotoAndPlay("turn");
  // frame 25 DoAction
    crystal.gotoAndPlay("glanz");
  // frame 49 DoAction
    crystal.gotoAndPlay("turn");
  // frame 66 DoAction
    crystal.gotoAndPlay("glanz");
// sprite id=537  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=539  frames=1
// sprite id=540  frames=11
  // frame 11 DoAction
    stop();
// sprite id=541  frames=45
// sprite id=542 c frames=32
  // frame 1 DoAction
    linkId = "c";
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 81;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 32 DoAction
    stop();
// sprite id=545  frames=1
// sprite id=548  frames=1
// sprite id=551  frames=1
// sprite id=554  frames=1
// sprite id=557  frames=1
// sprite id=560  frames=1
// sprite id=562  frames=1
// sprite id=565  frames=1
// sprite id=566  frames=21
// sprite id=569  frames=1
// sprite id=570  frames=19
// sprite id=573  frames=1
// sprite id=574  frames=7
// sprite id=576  frames=1
// sprite id=577  frames=26
// sprite id=578  frames=52
// sprite id=579  frames=70
// sprite id=580  frames=1
// sprite id=581  frames=77
  // frame 1 DoAction
    stop();
  // frame 73 DoAction
    stop();
// sprite id=582 g_l frames=16
  // frame 1 DoAction
    linkId = "g_l";
    offset = 30;
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 32 name None
    this.type = 89;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 8 DoAction
    stop();
  // frame 9 label off
  // frame 9 DoAction
    stop();
  // frame 9 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 89;
  // frame 13 label out
// sprite id=585  frames=1
// sprite id=586  frames=77
  // frame 1 DoAction
    stop();
  // frame 73 DoAction
    stop();
// sprite id=587 g frames=16
  // frame 1 DoAction
    linkId = "g";
    offset = 30;
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 32 name None
    this.type = 89;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 8 DoAction
    stop();
  // frame 9 label off
  // frame 9 DoAction
    stop();
  // frame 9 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 89;
  // frame 13 label out
// sprite id=593  frames=1
// sprite id=594  frames=44
// sprite id=595 ec frames=32
  // frame 1 DoAction
    linkId = "ec";
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.type = 82;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 32 label off
  // frame 32 DoAction
    stop();
// sprite id=596 e frames=32
  // frame 1 DoAction
    linkId = "e";
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 80;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 32 DoAction
    stop();
// sprite id=606  frames=12
// sprite id=613  frames=4
// sprite id=622  frames=4
// sprite id=632  frames=24
// sprite id=639  frames=10
// sprite id=640  frames=99
  // frame 99 DoAction
    stop();
    _parent.globalstart();
// sprite id=641  frames=1
// sprite id=644  frames=1
// sprite id=647  frames=1
// sprite id=650  frames=1
// sprite id=653  frames=1
// sprite id=656  frames=1
// sprite id=657  frames=16
// sprite id=658  frames=15
  // frame 15 DoAction
    stop();
// sprite id=659  frames=12
  // frame 1 DoAction
    stop();
// sprite id=660 actor frames=7
  // frame 1 DoAction
    notile = true;
    linkId = "dummy";
    resume = function () {
            this.container.container.play();
            if (this._currentframe > 1) {
                this.play();
            }
        };
    stop();
  // frame 5 DoAction
  // frame 7 DoAction
    gotoFrame(1);
    play();
// sprite id=663 d_ek frames=1
  // frame 1 DoAction
    linkId = "d_ek";
// sprite id=666 t_slide frames=1
  // frame 1 DoAction
    linkId = "t_slide";
// sprite id=669 d_is3 frames=1
  // frame 1 DoAction
    linkId = "d_is3";
// sprite id=672 d_is2 frames=1
  // frame 1 DoAction
    linkId = "d_is2";
// sprite id=675 d_is1 frames=1
  // frame 1 DoAction
    linkId = "d_is1";
// sprite id=678 d_kr1 frames=1
  // frame 1 DoAction
    linkId = "d_kr1";
// sprite id=681 d_sh3 frames=1
  // frame 1 DoAction
    linkId = "d_sh3";
// sprite id=684 d_sh2 frames=1
  // frame 1 DoAction
    linkId = "d_sh2";
// sprite id=687 d_sh1 frames=1
  // frame 1 DoAction
    linkId = "d_sh1";
// sprite id=690 d_kr2 frames=1
  // frame 1 DoAction
    linkId = "d_kr2";
// sprite id=693 d_sp frames=1
  // frame 1 DoAction
    linkId = "d_sp";
// sprite id=696 d_ir frames=1
  // frame 1 DoAction
    linkId = "d_ir";
// sprite id=701  frames=2
// sprite id=712  frames=63
// sprite id=713  frames=34
  // frame 1 DoAction
    stop();
  // frame 22 DoAction
    stop();
// sprite id=714 icebumblebee frames=54
  // frame 1 DoAction
    linkId = "icebumblebee";
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 15 name None
    this.type = 31;
  // frame 2 label loop
  // frame 54 DoAction
    gotoLabel("loop");
    play();
// sprite id=717 p_t_t_s_r frames=1
  // frame 1 DoAction
    linkId = "p_t_t_s_r";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=720 p_t_t_m frames=1
  // frame 1 DoAction
    linkId = "p_t_t_m";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=723 p_t_l_m frames=1
  // frame 1 DoAction
    linkId = "p_t_l_m";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=725 p_t_m frames=1
  // frame 1 DoAction
    linkId = "p_t_m";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=728 p_t_l_s frames=1
  // frame 1 DoAction
    linkId = "p_t_l_s";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=730 p_t_s_r frames=1
  // frame 1 DoAction
    linkId = "p_t_s_r";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=733 p_t_t_m_l frames=1
  // frame 1 DoAction
    linkId = "p_t_t_m_l";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=736 p_t_l_b frames=1
  // frame 1 DoAction
    linkId = "p_t_l_b";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=738 p_t_m_l frames=1
  // frame 1 DoAction
    linkId = "p_t_m_l";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=739 p_t_t_b_r frames=1
  // frame 1 DoAction
    linkId = "p_t_t_b_r";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=740 p_t_b_r frames=1
  // frame 1 DoAction
    linkId = "p_t_b_r";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=743 p_top_e_r frames=1
  // frame 1 DoAction
    linkId = "p_top_e_r";
    offset = 30;
// sprite id=746 p_top_es_r frames=1
  // frame 1 DoAction
    linkId = "p_top_es_r";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
    this.noBottom = true;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
// sprite id=749 p_top_s_r frames=1
  // frame 1 DoAction
    linkId = "p_top_s_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
    this.noBottom = true;
// sprite id=751 p_top_s_l frames=1
  // frame 1 DoAction
    linkId = "p_top_s_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
    this.noBottom = true;
// sprite id=753 p_top_es_l frames=1
  // frame 1 DoAction
    linkId = "p_top_es_l";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
    this.noBottom = true;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
// sprite id=755 p_top_e_l frames=1
  // frame 1 DoAction
    linkId = "p_top_e_l";
    offset = 30;
// sprite id=758 p_top_b frames=1
  // frame 1 DoAction
    linkId = "p_top_b";
    offset = 30;
// sprite id=761 p_f_l_b_r frames=1
  // frame 1 DoAction
    linkId = "p_f_l_b_r";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=764 p_f_l_s_r frames=1
  // frame 1 DoAction
    linkId = "p_f_l_s_r";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=766 p_f_l_s_l frames=1
  // frame 1 DoAction
    linkId = "p_f_l_s_l";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=768 p_f_l_b_l frames=1
  // frame 1 DoAction
    linkId = "p_f_l_b_l";
    if (offset == undefined) {
        offset = 30;
    }
// sprite id=772 p_b_l_t_b frames=1
  // frame 1 DoAction
    linkId = "p_b_l_t_b";
// sprite id=774 p_b_l_t frames=1
  // frame 1 DoAction
    linkId = "p_b_l_t";
