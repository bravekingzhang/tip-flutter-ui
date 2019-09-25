# tipui_example

王者人生常用的一些flutter控件

#### TipColorText

显示html文本，可以只是多行，单行，超出部分..

```dart

TipColorText(
                    '我是普通文字<font color="#ff0000">我是红色字</font>又是积分积分普通字<font color="#00ff00">我是绿色字</font><font color="#0000ff">我是蓝色色字</font>',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

```

#### TipMarqueeWidget

显示跑马灯效果，只是html文本

```dart

TipMarqueeWidget(
                    text: '我是普通文字<font color="#ff0000">我是红色字</font>又是积分积分普通字<font color="#00ff00">我是绿色字</font><font color="#0000ff">我是蓝色色字</font>',
                  )

```


#### TipTextSwitch

类似于Android textSwitcher的效果，支持横向，支持纵向，支持显示html文本

```dart
List<String> runHouse = [
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>你总是盘旋在我</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>腾讯科技(深圳)有限公司(科兴科学园)</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>这些猫</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>科兴科学园</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>秋之凉</font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>科兴科学园</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'></font><font color='#ffffff'>通过不懈的努力攻下</font><font color='#fdcb32'>广东省</font><font color='#ffffff'>，成为擂主</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'>这些猫</font><font color='#ffffff'>，拿下</font><font color='#fdcb32'>2344</font><font color='#ffffff'>高分</font>",
      "<font color='#ffffff'>恭喜</font><font color='#fdcb32'></font><font color='#ffffff'>，拿下</font><font color='#fdcb32'>2405</font><font color='#ffffff'>高分</font>"
    ];
TipSwitchText(
                    runHouse,
                    scrollDirection: Axis.vertical,
                  )

```

## 效果展示

![](https://github.com/bravekingzhang/tip-flutter-ui/blob/master/art/2019-09-25%2012-26-56.2019-09-25%2012_27_41.gif)