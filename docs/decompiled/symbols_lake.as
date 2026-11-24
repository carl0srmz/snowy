// sprite id=10  frames=12
// sprite id=17  frames=4
// sprite id=26  frames=4
// sprite id=36  frames=24
// sprite id=43  frames=10
// sprite id=44  frames=99
  // frame 99 DoAction
    stop();
    _parent.globalstart();
// sprite id=45  frames=1
// sprite id=48  frames=1
// sprite id=51  frames=1
// sprite id=54  frames=1
// sprite id=57  frames=1
// sprite id=60  frames=1
// sprite id=61  frames=16
// sprite id=62  frames=15
  // frame 15 DoAction
    stop();
// sprite id=63  frames=12
  // frame 1 DoAction
    stop();
// sprite id=64 actor frames=7
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
  // frame 2 DoAction
  // frame 5 DoAction
  // frame 7 DoAction
    gotoFrame(1);
    play();
// sprite id=67  frames=1
// sprite id=70  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
// sprite id=71 orca frames=151
  // frame 1 DoAction
    linkId = "orca";
    offset = 50;
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 2 label loop
  // frame 65 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.type = 31;
  // frame 143 DoAction
    gotoLabel("loop");
    play();
  // frame 147 label kill
  // frame 147 DoAction
    detached = true;
  // frame 151 label off
  // frame 151 DoAction
    stop();
// sprite id=74 d_ek frames=1
  // frame 1 DoAction
    linkId = "d_ek";
// sprite id=77 t_slide frames=1
  // frame 1 DoAction
    linkId = "t_slide";
// sprite id=80 d_is3 frames=1
  // frame 1 DoAction
    linkId = "d_is3";
// sprite id=83 d_is2 frames=1
  // frame 1 DoAction
    linkId = "d_is2";
// sprite id=86 d_is1 frames=1
  // frame 1 DoAction
    linkId = "d_is1";
// sprite id=89 d_kr1 frames=1
  // frame 1 DoAction
    linkId = "d_kr1";
// sprite id=92 d_sh3 frames=1
  // frame 1 DoAction
    linkId = "d_sh3";
// sprite id=95 d_sh2 frames=1
  // frame 1 DoAction
    linkId = "d_sh2";
// sprite id=98 d_sh1 frames=1
  // frame 1 DoAction
    linkId = "d_sh1";
// sprite id=101 d_kr2 frames=1
  // frame 1 DoAction
    linkId = "d_kr2";
// sprite id=104 d_sp frames=1
  // frame 1 DoAction
    linkId = "d_sp";
// sprite id=107 d_eb_b frames=1
  // frame 1 DoAction
    linkId = "d_eb_b";
// sprite id=110 d_eb frames=1
  // frame 1 DoAction
    linkId = "d_eb";
// sprite id=113 d_ir frames=1
  // frame 1 DoAction
    linkId = "d_ir";
// sprite id=116 f_t_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_t_l";
// sprite id=118 f_t_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_t_r";
// sprite id=121 f_t_r frames=1
  // frame 1 DoAction
    linkId = "f_t_r";
// sprite id=124 f_s_t_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t_t";
// sprite id=127 f_s_t frames=1
  // frame 1 DoAction
    linkId = "f_s_t";
// sprite id=129 f_t_l frames=1
  // frame 1 DoAction
    linkId = "f_t_l";
// sprite id=132 t2_b frames=1
  // frame 1 DoAction
    linkId = "t2_b";
// sprite id=135 t1_b frames=1
  // frame 1 DoAction
    linkId = "t1_b";
// sprite id=138  frames=1
// sprite id=139  frames=1
// sprite id=142  frames=1
// sprite id=145  frames=1
// sprite id=148  frames=1
// sprite id=151  frames=1
// sprite id=154  frames=1
// sprite id=157  frames=1
// sprite id=160  frames=1
// sprite id=163  frames=1
// sprite id=164  frames=72
  // frame 72 DoAction
    stop();
// sprite id=167  frames=1
// sprite id=170  frames=1
// sprite id=171  frames=8
// sprite id=174  frames=1
// sprite id=177  frames=1
// sprite id=178  frames=12
// sprite id=179  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=180  frames=10
  // frame 1 DoAction
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name Some("container1")
    this._visible = false;
  // frame 2 ClipAction ClipEventFlag(LOAD) on depth 1 name Some("container1")
    this._visible = false;
  // frame 7 label angry
  // frame 10 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = true;
// sprite id=181 pinkumom frames=6
  // frame 1 DoAction
    linkId = "pinkumom";
    offset = 0;
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.type = 32;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=193  frames=24
// sprite id=195  frames=1
// sprite id=196  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=197  frames=10
  // frame 1 DoAction
    stop();
// sprite id=198 orange frames=6
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
// sprite id=210  frames=24
// sprite id=212  frames=1
// sprite id=213  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=214  frames=10
  // frame 1 DoAction
    stop();
// sprite id=215 purpu frames=6
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
// sprite id=227  frames=16
// sprite id=229  frames=1
// sprite id=230  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=231  frames=10
  // frame 1 DoAction
    stop();
// sprite id=232 speedy frames=6
  // frame 1 DoAction
    linkId = "speedy";
    offset = 50;
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
// sprite id=244  frames=24
// sprite id=246  frames=1
// sprite id=247  frames=35
  // frame 35 DoAction
    stop();
    _parent._parent.out = true;
// sprite id=248  frames=10
  // frame 1 DoAction
    stop();
// sprite id=249 pinku frames=6
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
// sprite id=251 wire frames=1
  // frame 1 DoAction
    linkId = "wire";
// sprite id=255  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 0;
// sprite id=256 s_r_t frames=1
  // frame 1 DoAction
    linkId = "s_r_t";
    offset = 30;
// sprite id=259 s_l_s frames=1
  // frame 1 DoAction
    linkId = "s_l_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=262 s_l_t_s frames=1
  // frame 1 DoAction
    linkId = "s_l_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=264 s_r_t_s frames=1
  // frame 1 DoAction
    linkId = "s_r_t_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=266 s_r_s frames=1
  // frame 1 DoAction
    linkId = "s_r_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name None
    this.noTop = true;
// sprite id=269 s_r frames=1
  // frame 1 DoAction
    linkId = "s_r";
    offset = 30;
// sprite id=271 s_l_t frames=1
  // frame 1 DoAction
    linkId = "s_l_t";
    offset = 30;
// sprite id=273 s_l frames=1
  // frame 1 DoAction
    linkId = "s_l";
    offset = 30;
// sprite id=276  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 1;
// sprite id=277 f_s_b frames=1
  // frame 1 DoAction
    linkId = "f_s_b";
    offset = 30;
// sprite id=280 f_b_t frames=1
  // frame 1 DoAction
    linkId = "f_b_t";
    offset = 30;
// sprite id=283 f_b frames=1
  // frame 1 DoAction
    linkId = "f_b";
    offset = 30;
// sprite id=286 f_r_t frames=1
  // frame 1 DoAction
    linkId = "f_r_t";
    offset = 30;
// sprite id=289 f_r frames=1
  // frame 1 DoAction
    linkId = "f_r";
    offset = 30;
// sprite id=291 f_l_t frames=1
  // frame 1 DoAction
    linkId = "f_l_t";
    offset = 30;
// sprite id=293 f_l frames=1
  // frame 1 DoAction
    linkId = "f_l";
    offset = 30;
// sprite id=296  frames=1
// sprite id=298  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=299 wackel_s frames=2
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
// sprite id=302  frames=1
// sprite id=303  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=304 wackel_b frames=2
  // frame 1 DoAction
    linkId = "wackel_b";
    offset = 30;
    obstacles = 3;
    resume = function () {
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name Some("obstacle1")
    this.force = 400;
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 6 name None
    this._name = "obstacle3";
    this.enemy = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 8 name None
    this._name = "obstacle2";
    this.enemy = true;
  // frame 2 DoAction
    stop();
    init();
// sprite id=307  frames=1
// sprite id=308  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 3;
    this.tilting = true;
    this.moving = true;
// sprite id=309 floe_b frames=2
  // frame 1 DoAction
    linkId = "floe_b";
    offset = 30;
    resume = function () {
            this.play();
        };
  // frame 2 DoAction
    stop();
    init();
// sprite id=312  frames=1
// sprite id=313 floe frames=2
  // frame 1 DoAction
    linkId = "floe";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 4 name None
    this.force = 400;
  // frame 2 DoAction
    stop();
    init();
// sprite id=316 s_b_r frames=1
  // frame 1 DoAction
    linkId = "s_b_r";
    offset = 30;
// sprite id=318 s_b_l frames=1
  // frame 1 DoAction
    linkId = "s_b_l";
    offset = 30;
// sprite id=322  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = 1;
// sprite id=323 s_c_t_r frames=1
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
// sprite id=326  frames=1
  // frame 1 DoAction
    this.type = 3;
    this.dir = -1;
// sprite id=327 s_c_t_l frames=1
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
// sprite id=330 s_c_b1_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_l";
    offset = 30;
// sprite id=332 s_c_b1_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b1_r";
    offset = 30;
// sprite id=335 s_c_b_r frames=1
  // frame 1 DoAction
    linkId = "s_c_b_r";
    offset = 30;
// sprite id=337 s_c_b_l frames=1
  // frame 1 DoAction
    linkId = "s_c_b_l";
    offset = 30;
// sprite id=340 s_rb frames=1
  // frame 1 DoAction
    linkId = "s_rb";
    offset = 30;
// sprite id=343 s_rb_s frames=1
  // frame 1 DoAction
    linkId = "s_rb_s";
    offset = 30;
// sprite id=346 s_b_s frames=1
  // frame 1 DoAction
    linkId = "s_b_s";
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
// sprite id=359 b2_b_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=362 b1_b_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=365 b2_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_l";
    offset = 30;
// sprite id=368 b1_t_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_l";
    offset = 30;
// sprite id=371 b2_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_l";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=374 b1_b_e_l frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_l";
    if (offset == undefined) {
        offset = 30;
    }
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.3;
// sprite id=377 b2_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_t_e_r";
    offset = 30;
// sprite id=380 b1_t_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_t_e_r";
    offset = 30;
// sprite id=383 b2_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=386 b_s frames=1
  // frame 1 DoAction
    linkId = "b_s";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("obstacle")
    this.glide = -0.5;
    this.slip = -0.4;
// sprite id=388 b1_b_e_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_e_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=390 b2_b_r frames=1
  // frame 1 DoAction
    linkId = "b2_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=392 b1_b_r frames=1
  // frame 1 DoAction
    linkId = "b1_b_r";
    offset = 30;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 2 name Some("obstacle")
    this.glide = 0.5;
    this.slip = 0.3;
// sprite id=393 s_b frames=1
  // frame 1 DoAction
    linkId = "s_b";
    offset = 30;
// sprite id=396 s_b_r_t frames=1
  // frame 1 DoAction
    linkId = "s_b_r_t";
    offset = 30;
// sprite id=398 s_b_l_t frames=1
  // frame 1 DoAction
    linkId = "s_b_l_t";
    offset = 30;
// sprite id=401 s_st2 frames=1
  // frame 1 DoAction
    linkId = "s_st2";
    offset = 30;
// sprite id=404 s_st frames=1
  // frame 1 DoAction
    linkId = "s_st";
    offset = 30;
// sprite id=405 s_b_t frames=1
  // frame 1 DoAction
    linkId = "s_b_t";
    offset = 30;
// sprite id=430  frames=105
  // frame 1 DoAction
    if (!(_root.coinframe == 1) && (init == undefined)) {
        gotoAndPlay(_root.coinframe);
        init = true;
    }
  // frame 21 label turn
  // frame 28 DoAction
  // frame 43 label glanz
  // frame 50 DoAction
// sprite id=431  frames=83
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
// sprite id=433  frames=1
  // frame 1 DoAction
    if (!!!(this._name.indexOf("instance") == -1)) {
        this._name = "obstacle";
    }
// sprite id=435  frames=1
// sprite id=436  frames=11
  // frame 11 DoAction
    stop();
// sprite id=437  frames=45
// sprite id=438 c frames=32
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
// sprite id=444  frames=1
// sprite id=445  frames=44
// sprite id=446 ec frames=32
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
// sprite id=447 e frames=32
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
// sprite id=450  frames=1
// sprite id=453  frames=1
// sprite id=456  frames=1
// sprite id=459  frames=1
// sprite id=462  frames=1
// sprite id=465  frames=1
// sprite id=466  frames=18
// sprite id=469  frames=1
// sprite id=470  frames=25
// sprite id=471  frames=100
// sprite id=472  frames=36
  // frame 36 DoAction
    stop();
// sprite id=473  frames=10
  // frame 1 DoAction
    stop();
// sprite id=474 joggybear frames=6
  // frame 1 DoAction
    linkId = "joggybear";
    if (offset == undefined) {
        offset = 30;
    }
    motion = true;
    init();
    stop();
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name Some("obstacle")
    this.type = 30;
  // frame 2 label kill
  // frame 2 DoAction
    detached = true;
  // frame 6 label off
  // frame 6 DoAction
    stop();
// sprite id=477  frames=1
// sprite id=483 snowball frames=7
  // frame 1 DoAction
    stop();
  // frame 7 DoAction
    this.removeMovieClip();
// sprite id=486  frames=1
// sprite id=491  frames=2
// sprite id=498  frames=12
// sprite id=505  frames=4
// sprite id=506  frames=146
  // frame 145 DoAction
    stop();
// sprite id=507 moby frames=151
  // frame 1 DoAction
    linkId = "moby";
    offset = 100;
    obstacles = 5;
    stop();
    event = function () {
            gotoLabel("hit");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 11 name Some("obstacle2")
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 13 name None
    this._name = "obstacle1";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 15 name Some("obstacle3")
    this.massive = true;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 17 name None
    this.type = 90;
    this._name = "obstacle4";
  // frame 4 label hit
  // frame 5 DoAction
    sprudel.setVolume(300);
    sprudel.start();
  // frame 5 ClipAction ClipEventFlag(LOAD) on depth 17 name None
    this._name = "obstacle5";
  // frame 114 DoAction
    sprudel.stop();
  // frame 148 DoAction
    gotoFrame(0);
  // frame 151 label off
  // frame 151 DoAction
    stop();
// sprite id=510  frames=1
// sprite id=519  frames=42
// sprite id=524  frames=14
// sprite id=529  frames=17
  // frame 17 DoAction
    stop();
// sprite id=538  frames=28
  // frame 28 DoAction
    stop();
// sprite id=539 robbe frames=66
  // frame 1 DoAction
    linkId = "robbe";
    resume = function () {
            this.play();
            this.container.play();
        };
    stop();
    actor = new Object();
    actor.die = function () {
            gotoLabel("kill");
            play();
        };
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 5 name None
    this.type = 33;
  // frame 4 label hit
  // frame 63 DoAction
    gotoFrame(0);
  // frame 66 label off
  // frame 66 DoAction
    stop();
// sprite id=544  frames=12
// sprite id=552  frames=14
  // frame 14 DoAction
    stop();
// sprite id=553 evilfish frames=194
  // frame 1 DoAction
    linkId = "evilfish";
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
// sprite id=555  frames=1
// sprite id=557 videoscreen frames=2
  // frame 1 DoAction
    linkId = "videoscreen";
  // frame 2 DoAction
    stop();
// sprite id=559  frames=1
// sprite id=560 be_b frames=1
  // frame 1 DoAction
    linkId = "be_b";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=561 be frames=1
  // frame 1 DoAction
    linkId = "be";
    offset = 100;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 3 name None
    this.enemy = true;
// sprite id=562 bh frames=1
  // frame 1 DoAction
    linkId = "bh";
  // frame 1 ClipAction ClipEventFlag(LOAD) on depth 1 name None
    this._visible = false;
// sprite id=569  frames=43
  // frame 1 DoAction
    if (!(_root.waterframe == 1) && (init == undefined)) {
        gotoAndPlay(_root.waterframe);
        init = true;
    }
// sprite id=570  frames=1
  // frame 1 DoAction
    this._name = "obstacle";
    this.type = 4;
// sprite id=571 w frames=1
  // frame 1 DoAction
    linkId = "w";
    offset = 30;
    resume = function () {
            this.play();
        };
// sprite id=574  frames=1
// sprite id=577  frames=1
// sprite id=580  frames=1
// sprite id=583  frames=1
// sprite id=586  frames=1
// sprite id=589  frames=1
// sprite id=593  frames=1
// sprite id=594  frames=21
// sprite id=597  frames=1
// sprite id=598  frames=19
// sprite id=601  frames=1
// sprite id=602  frames=7
// sprite id=604  frames=1
// sprite id=605  frames=26
// sprite id=606  frames=52
// sprite id=607  frames=70
// sprite id=608  frames=1
// sprite id=609  frames=77
  // frame 1 DoAction
    stop();
  // frame 73 DoAction
    stop();
// sprite id=610 g frames=16
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
// sprite id=611  frames=1
// sprite id=612  frames=32
  // frame 32 DoAction
    stop();
// sprite id=613  frames=10
  // frame 1 DoAction
    stop();
// sprite id=614 iceball frames=6
  // frame 1 DoAction
    linkId = "iceball";
    notile = true;
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
// sprite id=617 s_i_f frames=12
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
// sprite id=620 s_i_b frames=6
  // frame 1 label close
  // frame 1 DoAction
    linkId = "s_i_b";
    offset = 30;
    stop();
