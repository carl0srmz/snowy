// sprite id=3  frames=1
// sprite id=16  frames=6
// sprite id=29  frames=24
// sprite id=30  frames=1
// sprite id=31  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=34  frames=11
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("container1")
    this._visible = false;
// sprite id=36  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=37 snowspider frames=6
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
// sprite id=41  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 0;
// sprite id=43  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = -1;
// sprite id=45  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = 1;
// sprite id=47  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=48 s_i_f frames=12
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
// sprite id=51 s_i_b frames=6
  // frame 1 label close
  // frame 1 DoAction
    linkId = "s_i_b";
    offset = 30;
    stop();
// sprite id=62  frames=24
// sprite id=69  frames=4
// sprite id=70  frames=136
  // frame 24 DoAction
    this.onEnterFrame = function () {
            _parent.lasty = container._y;
            _parent._parent.obstacle._y = container._y - 34;
        };
  // frame 85 DoAction
    this.onEnterFrame = null;
// sprite id=72  frames=1
// sprite id=73  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=74  frames=10
  // frame 1 DoAction
    stop();
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=75 orange frames=6
  // frame 1 DoAction
    linkId = "orange";
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
// sprite id=86  frames=24
// sprite id=93  frames=4
// sprite id=94  frames=138
  // frame 24 DoAction
    this.onEnterFrame = function () {
            _parent.lasty = container._y;
            _parent._parent.obstacle._y = container._y - 34;
        };
  // frame 85 DoAction
    this.onEnterFrame = null;
// sprite id=96  frames=1
// sprite id=97  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=98  frames=10
  // frame 1 DoAction
    stop();
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=99 purpu frames=6
  // frame 1 DoAction
    linkId = "purpu";
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
// sprite id=106  frames=6
// sprite id=109  frames=1
// sprite id=110  frames=11
  // frame 1 label fly
  // frame 1 DoAction
    stop();
  // frame 6 label attack
  // frame 6 DoAction
    stop();
// sprite id=112  frames=1
// sprite id=113  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=114  frames=10
  // frame 1 DoAction
    stop();
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=115 eagle frames=329
  // frame 1 DoAction
    linkId = "eagle";
    offset = 0;
    init();
    play();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 30;
  // frame 2 label loop
  // frame 25 DoAction
    container.container.gotoAndStop("attack");
  // frame 92 DoAction
    container.container.gotoAndStop("fly");
  // frame 196 DoAction
    container.container.gotoAndStop("attack");
  // frame 259 DoAction
    container.container.gotoAndStop("fly");
  // frame 324 DoAction
    gotoLabel("loop");
    play();
  // frame 325 label kill
  // frame 325 DoAction
    detached = true;
  // frame 329 label off
  // frame 329 DoAction
    stop();
// sprite id=126  frames=24
// sprite id=133  frames=4
// sprite id=134  frames=135
  // frame 29 DoAction
    this.onEnterFrame = function () {
            _parent.lasty = container._y;
            _parent._parent.obstacle._y = container._y - 34;
        };
  // frame 90 DoAction
    this.onEnterFrame = null;
// sprite id=136  frames=1
// sprite id=137  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=138  frames=10
  // frame 1 DoAction
    stop();
  // frame 10 DoAction
    this.onEnterFrame = null;
    container._y = lasty;
// sprite id=139 pinku frames=6
  // frame 1 DoAction
    linkId = "pinku";
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
// sprite id=142  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 1;
// sprite id=143 s_c_t_r frames=1
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
// sprite id=145 s_c_t_l frames=1
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
// sprite id=148 s_c_b1_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_l";
    offset = 30;
// sprite id=150 s_c_b1_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_r";
    offset = 30;
// sprite id=153 s_c_b_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b_r";
    offset = 30;
// sprite id=155 s_c_b_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b_l";
    offset = 30;
// sprite id=158 b2_t_r frames=1
  // frame 1 DoAction
    linkId = "b2_t_r";
    obstacles = 2;
    offset = 30;
// sprite id=161 b1_t_r frames=1
  // frame 1 DoAction
    linkId = "b1_t_r";
    obstacles = 2;
    offset = 30;
// sprite id=163 b2_t_l frames=1
  // frame 1 DoAction
    linkId = "b2_t_l";
    obstacles = 2;
    offset = 30;
// sprite id=165 b1_t_l frames=1
  // frame 1 DoAction
    linkId = "b1_t_l";
    obstacles = 2;
    offset = 30;
// sprite id=168 b2_b_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=171 b1_b_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=174 b2_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_l";
    offset = 30;
// sprite id=177 b1_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_l";
    offset = 30;
// sprite id=180 b2_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=183 b1_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=186 b2_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_r";
    offset = 30;
// sprite id=189 b1_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_r";
    offset = 30;
// sprite id=192 b2_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=195 b_s frames=1
  // frame 1 DoAction
    linkId = "b_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.4;
// sprite id=197 b1_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=199 b2_b_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=201 b1_b_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=204 t2_b frames=1
  // frame 1 DoAction
    linkId = "t2_b";
// sprite id=207 t1_b frames=1
  // frame 1 DoAction
    linkId = "t1_b";
// sprite id=210 f_t_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_t_l";
// sprite id=212 f_t_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_t_r";
// sprite id=215 f_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_r";
// sprite id=218 f_s_t_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t_t";
// sprite id=221 f_s_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t";
// sprite id=223 f_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_l";
// sprite id=226 f_s_b frames=1
  // frame 1 DoAction
    linkId = "f_s_b";
    offset = 30;
// sprite id=229 f_b_t frames=1
  // frame 1 DoAction
    linkId = "f_b_t";
    offset = 30;
// sprite id=232 f_b frames=1
  // frame 1 DoAction
    linkId = "f_b";
    offset = 30;
// sprite id=235 f_r_t frames=1
  // frame 1 DoAction
    linkId = "f_r_t";
    offset = 30;
// sprite id=238 f_r frames=1
  // frame 1 DoAction
    linkId = "f_r";
    offset = 30;
// sprite id=240 f_l_t frames=1
  // frame 1 DoAction
    linkId = "f_l_t";
    offset = 30;
// sprite id=242 f_l frames=1
  // frame 1 DoAction
    linkId = "f_l";
    offset = 30;
// sprite id=245 s_rb frames=1
  // frame 1 DoAction
    linkId = "s_rb";
    offset = 30;
// sprite id=248 s_rb_s frames=1
  // frame 1 DoAction
    linkId = "s_rb_s";
    offset = 30;
// sprite id=251  frames=1
// sprite id=253  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 1;
    this.moving = true;
    this.flying = true;
    this.onEnterFrame = function () {
            x = lx;
            lx = this._x;
        };
// sprite id=254 p_c_c4_s frames=219
  // frame 1 DoAction
    linkId = "p_c_c4_s";
    offset = 30;
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.cloudframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.cloudframe);
        init = true;
    }
  // frame 219 DoAction
    gotoLabel("loop");
    play();
// sprite id=255 p_c_c2_s frames=219
  // frame 1 DoAction
    linkId = "p_c_c2_s";
    offset = 30;
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.cloudframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.cloudframe);
        init = true;
    }
  // frame 219 DoAction
    gotoLabel("loop");
    play();
// sprite id=256 p_c_c3_s frames=219
  // frame 1 DoAction
    linkId = "p_c_c3_s";
    offset = 30;
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.cloudframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.cloudframe);
        init = true;
    }
  // frame 219 DoAction
    gotoLabel("loop");
    play();
// sprite id=257 p_c_c1_s frames=219
  // frame 1 DoAction
    linkId = "p_c_c1_s";
    offset = 30;
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.cloudframe == 2) && (init == undefined)) {
        gotoAndPlay(_root.cloudframe);
        init = true;
    }
  // frame 219 DoAction
    gotoLabel("loop");
    play();
// sprite id=258 p_c_v2_s frames=105
  // frame 1 DoAction
    linkId = "p_c_v2_s";
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        var frame = _root.coinframe + 1;
        if (frame > 105) {
            frame = frame - 0;
        }
        init = true;
        gotoAndPlay(frame);
    }
  // frame 105 DoAction
    gotoLabel("loop");
    play();
// sprite id=259 p_c_h2_s frames=105
  // frame 1 DoAction
    linkId = "p_c_h2_s";
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        var frame = _root.coinframe + 1;
        if (frame > 105) {
            frame = frame - 0;
        }
        gotoAndPlay(frame);
        init = true;
    }
  // frame 105 DoAction
    gotoLabel("loop");
    play();
// sprite id=260 p_c_h1_s frames=105
  // frame 1 DoAction
    linkId = "p_c_h1_s";
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        var frame = _root.coinframe + 1;
        if (frame > 105) {
            frame = frame - 0;
        }
        gotoAndPlay(frame);
        init = true;
    }
  // frame 105 DoAction
    gotoLabel("loop");
    play();
// sprite id=261 p_c_v1_s frames=105
  // frame 1 DoAction
    linkId = "p_c_v1_s";
    if (_root.editor) {
        stop();
    }
  // frame 2 label loop
  // frame 2 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        var frame = _root.coinframe + 1;
        if (frame > 105) {
            frame = frame - 0;
        }
        gotoAndPlay(frame);
        init = true;
    }
  // frame 105 DoAction
    gotoLabel("loop");
    play();
// sprite id=264 s_r_t frames=1
  // frame 1 DoAction
    linkId = "s_r_t";
    offset = 30;
// sprite id=267 s_l_s frames=1
  // frame 1 DoAction
    linkId = "s_l_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=270 s_l_t_s frames=1
  // frame 1 DoAction
    linkId = "s_l_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=272 s_r_t_s frames=1
  // frame 1 DoAction
    linkId = "s_r_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=274 s_r_s frames=1
  // frame 1 DoAction
    linkId = "s_r_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=277 s_r frames=1
  // frame 1 DoAction
    linkId = "s_r";
    offset = 30;
// sprite id=279 s_l_t frames=1
  // frame 1 DoAction
    linkId = "s_l_t";
    offset = 30;
// sprite id=281 s_l frames=1
  // frame 1 DoAction
    linkId = "s_l";
    offset = 30;
// sprite id=284 s_b_r frames=1
  // frame 1 DoAction
    linkId = "s_b_r";
    offset = 30;
// sprite id=286 s_b_l frames=1
  // frame 1 DoAction
    linkId = "s_b_l";
    offset = 30;
// sprite id=289 s_b_s frames=1
  // frame 1 DoAction
    linkId = "s_b_s";
    offset = 30;
// sprite id=290 s_b frames=1
  // frame 1 DoAction
    linkId = "s_b";
    offset = 30;
// sprite id=293 s_b_r_t frames=1
  // frame 1 DoAction
    linkId = "s_b_r_t";
    offset = 30;
// sprite id=295 s_b_l_t frames=1
  // frame 1 DoAction
    linkId = "s_b_l_t";
    offset = 30;
// sprite id=298 s_st2 frames=1
  // frame 1 DoAction
    linkId = "s_st2";
    offset = 30;
// sprite id=301 s_st frames=1
  // frame 1 DoAction
    linkId = "s_st";
    offset = 30;
// sprite id=302 s_b_t frames=1
  // frame 1 DoAction
    linkId = "s_b_t";
    offset = 30;
// sprite id=304 wire frames=1
  // frame 1 DoAction
    linkId = "wire";
// sprite id=306  frames=1
// sprite id=307 be_b frames=1
  // frame 1 DoAction
    linkId = "be_b";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=308 be2 frames=1
  // frame 1 DoAction
    linkId = "be2";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=309 be1 frames=1
  // frame 1 DoAction
    linkId = "be1";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=310 be frames=1
  // frame 1 DoAction
    linkId = "be";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=311 bh frames=1
  // frame 1 DoAction
    linkId = "bh";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
// sprite id=336  frames=105
  // frame 1 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        gotoAndPlay(_root.coinframe);
        init = true;
    }
  // frame 21 label turn
  // frame 28 DoAction
  // frame 43 label glanz
  // frame 50 DoAction
// sprite id=337  frames=83
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
// sprite id=338  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=340  frames=1
// sprite id=341  frames=11
  // frame 11 DoAction
    stop();
// sprite id=342  frames=45
// sprite id=343 c frames=32
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
// sprite id=346  frames=1
// sprite id=349  frames=1
// sprite id=352  frames=1
// sprite id=355  frames=1
// sprite id=358  frames=1
// sprite id=361  frames=1
// sprite id=365  frames=1
// sprite id=366  frames=21
// sprite id=369  frames=1
// sprite id=370  frames=19
// sprite id=373  frames=1
// sprite id=374  frames=7
// sprite id=376  frames=1
// sprite id=377  frames=26
// sprite id=378  frames=52
// sprite id=379  frames=70
// sprite id=380  frames=1
// sprite id=381  frames=77
  // frame 1 DoAction
    stop();
  // frame 73 DoAction
    stop();
// sprite id=382 g frames=16
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
// sprite id=388  frames=1
// sprite id=389  frames=44
// sprite id=390 ec frames=32
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
// sprite id=391 e frames=32
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
// sprite id=401  frames=12
// sprite id=408  frames=4
// sprite id=417  frames=4
// sprite id=427  frames=24
// sprite id=434  frames=10
// sprite id=435  frames=99
  // frame 99 DoAction
    stop();
    _parent.globalstart();
// sprite id=436  frames=1
// sprite id=439  frames=1
// sprite id=442  frames=1
// sprite id=445  frames=1
// sprite id=448  frames=1
// sprite id=451  frames=1
// sprite id=452  frames=16
// sprite id=453  frames=15
  // frame 15 DoAction
    stop();
// sprite id=454  frames=12
  // frame 1 DoAction
    stop();
// sprite id=455 actor frames=7
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
// sprite id=458 d_ek frames=1
  // frame 1 DoAction
    linkId = "d_ek";
// sprite id=461 t_slide frames=1
  // frame 1 DoAction
    linkId = "t_slide";
// sprite id=464 d_is3 frames=1
  // frame 1 DoAction
    linkId = "d_is3";
// sprite id=467 d_is2 frames=1
  // frame 1 DoAction
    linkId = "d_is2";
// sprite id=470 d_is1 frames=1
  // frame 1 DoAction
    linkId = "d_is1";
// sprite id=473 d_kr1 frames=1
  // frame 1 DoAction
    linkId = "d_kr1";
// sprite id=476 d_sh3 frames=1
  // frame 1 DoAction
    linkId = "d_sh3";
// sprite id=479 d_sh2 frames=1
  // frame 1 DoAction
    linkId = "d_sh2";
// sprite id=482 d_sh1 frames=1
  // frame 1 DoAction
    linkId = "d_sh1";
// sprite id=485 d_kr2 frames=1
  // frame 1 DoAction
    linkId = "d_kr2";
// sprite id=488 d_sp frames=1
  // frame 1 DoAction
    linkId = "d_sp";
// sprite id=491 d_ir frames=1
  // frame 1 DoAction
    linkId = "d_ir";
// sprite id=494  frames=1
// sprite id=495 p_c_l_b frames=2
  // frame 1 DoAction
    linkId = "p_c_l_b";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.force = 200;
    this.ease = true;
    this.moving = true;
    this.drop = true;
    this.flying = true;
  // frame 2 DoAction
    stop();
    init();
// sprite id=496 p_c_l frames=2
  // frame 1 DoAction
    linkId = "p_c_l";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.force = 200;
    this.ease = true;
    this.moving = true;
    this.drop = true;
    this.flying = true;
  // frame 2 DoAction
    stop();
    init();
// sprite id=501  frames=2
// sprite id=512  frames=63
// sprite id=513  frames=34
  // frame 1 DoAction
    stop();
  // frame 22 DoAction
    stop();
// sprite id=514 icebumblebee frames=54
  // frame 1 DoAction
    linkId = "icebumblebee";
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 15 name None
    this.type = 31;
  // frame 2 label loop
  // frame 54 DoAction
    gotoLabel("loop");
    play();
// sprite id=517  frames=1
// sprite id=530  frames=30
// sprite id=531  frames=1
// sprite id=532 mammut_l frames=1205
  // frame 1 DoAction
    linkId = "mammut_l";
    obstacles = 4;
    if (_root.editor) {
        stop();
    } else {
        gotoFrame(449);
        play();
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.moving = true;
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 7 name Some("obstacle3")
    this.glide = -0.7;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 9 name Some("obstacle4")
    this.glide = 0.7;
  // frame 2 label loop
  // frame 1205 DoAction
    gotoLabel("loop");
    play();
// sprite id=533 mammut frames=409
  // frame 1 DoAction
    linkId = "mammut";
    obstacles = 4;
    if (_root.editor) {
        stop();
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.moving = true;
    this._name = "obstacle2";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 7 name Some("obstacle3")
    this.glide = -0.7;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 9 name Some("obstacle4")
    this.glide = 0.7;
  // frame 2 label loop
  // frame 409 DoAction
    gotoLabel("loop");
    play();
// sprite id=536 p_t_s_r frames=1
  // frame 1 DoAction
    linkId = "p_t_s_r";
    offset = 30;
    obstacles = 3;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=539 p_t_m_l frames=1
  // frame 1 DoAction
    linkId = "p_t_m_l";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
// sprite id=542 p_t_b_r frames=1
  // frame 1 DoAction
    linkId = "p_t_b_r";
    offset = 30;
    obstacles = 2;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this._name = "obstacle2";
    this.type = 36;
