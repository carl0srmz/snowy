// ---- DoAction
stop();
// ======== DoInitAction sprite=527 __Packages.com.extratoxic.utils.XMLUtil
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
// ---- DoAction
function setText(txt, text, align) {
    $r3 = com.extratoxic.utils.XMLUtil.getValueByName(_root.worldmapXML, text);
    txt.htmlText = $r3;
    $r2 = new TextFormat();
    $r2.letterSpacing = 0.5;
    txt.setTextFormat($r2);
}
stop();
this._lockroot = true;
_root.worldmapXML = worldmapXML;
// sprite id=5  frames=1
// sprite id=12  frames=10
  // frame 1 label still
  // frame 1 DoAction
    stop();
  // frame 5 label talk
  // frame 10 DoAction
    gotoLabel("talk");
    play();
// sprite id=20  frames=12
  // frame 1 label walk
  // frame 10 label stand
// sprite id=22  frames=1
// sprite id=38  frames=27
  // frame 1 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_02_danke");
  // frame 2 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_04_steve");
  // frame 3 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_06_christiane");
  // frame 4 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_08_nintendo");
  // frame 5 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_11_credits02");
  // frame 6 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_13_credits04");
  // frame 7 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_15_credits06");
  // frame 8 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_17_credits08");
  // frame 9 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_19_credits10");
  // frame 10 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_21_upixoheadline");
  // frame 11 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_23_upixo2");
  // frame 12 DoAction
    stop();
  // frame 13 DoAction
    stop();
  // frame 14 DoAction
    stop();
  // frame 15 DoAction
    stop();
  // frame 16 DoAction
    stop();
  // frame 17 DoAction
    stop();
  // frame 18 DoAction
    stop();
  // frame 19 DoAction
    stop();
  // frame 20 DoAction
    stop();
  // frame 21 DoAction
    stop();
  // frame 22 DoAction
    stop();
  // frame 23 DoAction
    stop();
  // frame 24 DoAction
    stop();
  // frame 25 DoAction
    stop();
  // frame 26 DoAction
    stop();
  // frame 27 DoAction
    stop();
// sprite id=39  frames=431
  // frame 431 DoAction
    txt.play();
// sprite id=58  frames=30
  // frame 1 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_03_extratoxic");
  // frame 2 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_05_bogac");
  // frame 3 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_07_fabian");
  // frame 4 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_09_creditsheadline");
    _root.setText(kristall1_txt, "mainmap_credits_10_credits01");
  // frame 5 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_12_credits03");
  // frame 6 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_14_credits05");
  // frame 7 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_16_credits07");
  // frame 8 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_18_credits09");
  // frame 9 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_20_credits11");
  // frame 10 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_22_upixo1");
  // frame 11 DoAction
    stop();
    _root.setText(kristall_txt, "mainmap_credits_24_upixo3");
  // frame 12 DoAction
    stop();
  // frame 13 DoAction
    stop();
  // frame 14 DoAction
    stop();
  // frame 15 DoAction
    stop();
  // frame 16 DoAction
    stop();
  // frame 17 DoAction
    stop();
  // frame 18 DoAction
    stop();
  // frame 19 DoAction
    stop();
  // frame 20 DoAction
    stop();
  // frame 21 DoAction
    stop();
  // frame 22 DoAction
    stop();
  // frame 23 DoAction
    stop();
  // frame 24 DoAction
    stop();
  // frame 25 DoAction
    stop();
  // frame 26 DoAction
    stop();
  // frame 27 DoAction
    stop();
  // frame 28 DoAction
    stop();
  // frame 29 DoAction
    stop();
  // frame 30 DoAction
    stop();
// sprite id=59  frames=431
  // frame 431 DoAction
    txt.play();
// sprite id=60  frames=216
  // frame 216 DoAction
    stop();
// sprite id=71  frames=24
// sprite id=76  frames=6
// sprite id=83  frames=12
// sprite id=100  frames=104
// sprite id=117  frames=106
// sprite id=134  frames=108
// sprite id=151  frames=108
// sprite id=162  frames=24
// sprite id=173  frames=24
// sprite id=184  frames=24
// sprite id=195  frames=24
// sprite id=206  frames=24
// sprite id=217  frames=24
// sprite id=228  frames=24
// sprite id=229  frames=1
// sprite id=240  frames=24
// sprite id=251  frames=24
// sprite id=262  frames=24
// sprite id=273  frames=24
// sprite id=278  frames=10
// sprite id=280  frames=1
// sprite id=281  frames=56
  // frame 56 DoAction
    stop();
// sprite id=292  frames=24
// sprite id=293  frames=500
  // frame 337 DoAction
    neander.gotoAndStop(1);
  // frame 434 DoAction
    neander.gotoAndPlay(4);
  // frame 497 DoAction
    _parent.play();
// sprite id=301  frames=8
// sprite id=304  frames=10
// sprite id=315  frames=24
// sprite id=324  frames=12
// sprite id=333  frames=12
// sprite id=334  frames=1
// sprite id=339  frames=12
// sprite id=340  frames=1
// sprite id=348  frames=12
// sprite id=349  frames=1
// sprite id=356  frames=6
// sprite id=359  frames=1
// sprite id=360  frames=6
// sprite id=363  frames=1
// sprite id=368  frames=2
// sprite id=375  frames=12
// sprite id=382  frames=4
// sprite id=383  frames=343
  // frame 342 DoAction
    stop();
// sprite id=384  frames=1
// sprite id=385  frames=391
  // frame 387 DoAction
    _parent.play();
// sprite id=388  frames=1
// sprite id=397  frames=42
// sprite id=403  frames=14
// sprite id=408  frames=17
  // frame 17 DoAction
    stop();
// sprite id=409  frames=76
  // frame 22 DoAction
    stop();
  // frame 63 label dotz
  // frame 75 DoAction
    stop();
// sprite id=410  frames=4
// sprite id=411  frames=321
  // frame 80 DoAction
    rob01.gotoAndPlay("dotz");
  // frame 135 DoAction
    rob02.gotoAndPlay("dotz");
  // frame 188 DoAction
    rob03.gotoAndPlay("dotz");
  // frame 240 DoAction
    rob04.gotoAndPlay("dotz");
  // frame 306 DoAction
    _parent.play();
// sprite id=438  frames=111
  // frame 1 DoAction
    this._x = _parent._x - (random(70) + 2);
    gotoAndPlay(random(80) + 50);
// sprite id=439  frames=1
// sprite id=440  frames=1
// sprite id=447  frames=6
// sprite id=452  frames=2
// sprite id=453  frames=1
// sprite id=454  frames=49
// sprite id=455  frames=1
// sprite id=460  frames=2
// sprite id=471  frames=27
// sprite id=472  frames=34
  // frame 22 DoAction
    stop();
// sprite id=473  frames=49
// sprite id=474  frames=1
// sprite id=477  frames=1
// sprite id=481  frames=1
// sprite id=484  frames=1
// sprite id=487  frames=1
// sprite id=490  frames=1
// sprite id=493  frames=1
// sprite id=496  frames=1
// sprite id=499  frames=1
// sprite id=500  frames=21
// sprite id=503  frames=1
// sprite id=504  frames=19
// sprite id=507  frames=1
// sprite id=508  frames=7
// sprite id=509  frames=1
// sprite id=510  frames=26
// sprite id=511  frames=52
// sprite id=512  frames=70
// sprite id=513  frames=1
// sprite id=514  frames=137
  // frame 1 DoAction
    stop();
  // frame 61 label open
  // frame 133 DoAction
    stop();
// sprite id=519  frames=1
// sprite id=520  frames=28
// sprite id=524  frames=3990
  // frame 2 DoAction
  // frame 48 DoAction
  // frame 73 DoAction
    chubby.gotoAndStop("stand");
  // frame 89 DoAction
    schwabbel.gotoAndPlay("talk");
    _root.setText(text_txt, "mainmap_credits_01a_schwabbel");
    stop();
    cnt = 170;
    this.onEnterFrame = function () {
            cnt = cnt - 1;
            if (cnt == 0) {
                play();
                delete this.onEnterFrame;
            }
        };
  // frame 95 DoAction
    _root.setText(text_txt, "mainmap_credits_01b_schwabbel");
    stop();
    cnt = 170;
    this.onEnterFrame = function () {
            cnt = cnt - 1;
            if (cnt == 0) {
                play();
                delete this.onEnterFrame;
            }
        };
  // frame 107 DoAction
    schwabbel.gotoAndStop("still");
  // frame 137 DoAction
    chubby.gotoAndPlay("walk");
  // frame 1524 DoAction
    stop();
  // frame 3244 DoAction
    stop();
  // frame 3275 DoAction
    stop();
  // frame 3989 DoAction
    chest.gotoAndPlay("open");
  // frame 3990 label download
  // frame 3990 DoAction
    chubby.gotoAndStop("stand");
    stop();
    _root.setText(kristall_txt, "mainmap_credits_25_download");
    _root.setText(creditsreplay_txt, "mainmap_credits_26_watchagain");
// sprite id=526  frames=1
