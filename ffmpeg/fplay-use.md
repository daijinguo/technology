
ffplay 相关的快捷键

# 快捷键

通过 fplay 命令启动播放后出现的播放界面相关的快捷键

| 按键      | 作用         |
|:----------|:-----------|
| q or ESC  | 退出         |
| f         | 全屏         |
| p or 空格 | 暂停         |
| w         | 显示音频波形 |
| s         | 逐帧显示     |
| 左方向键  | 向后 10s     |
| 右方向键  | 向前 10s     |
| 上方向键  | 向后 1 分钟  |
| 下方向键  | 向前 1 分钟  |
| PgDn      | 向后 10 分钟 |
| PgUp      | 向前 10 分钟 |


# ffplay 命令参数

在 linux 系统上可以使用 man ffplay 命令来查看这里指定


## 设置屏幕显示宽高
```
ffplay -x 720 -y 680  OUTPUT.mp4
```
一般的 -x 和 -y 配合一起使用


## 设置全屏播放
```
ffplay -fs OUTPUT.mp4
```

## 关闭音频或者视频流
下面可以使用这样方式记忆: a表示audio,  v表示video,  n表示no关闭意思

### 关闭音频流
```
ffplay -an OUTPUT.mp4
```

### 关闭视频流
```
ffplay -vn OUTPUT.mp4
```

## 指定流播放
当视频中有多个流格式时，可以设置指定流播放


### 设置指定音频流播放

```
ffplay -ast 2 OUTPUT.mp4
```
其中 2 表示音频2号流


### 设置指定视频流播放

```
ffplay -vst 3 OUTPUT.mp4
```

### 设置指定字幕流播放

```
ffplay -sst 1 OUTPUT.mp4
```

### 从指定位置开始播放(单位: 秒)

```
ffplay -ss 45 OUTPUT.mp4
```
从第 45 秒开始播放


### 播放指定时长视频

```
ffplay -t 50 OUTPUT.mp4
```

### 不显示视频内容播放

```
ffplay -nodisp OUTPUT.mp4
```


## 总结一下命令参数

| 名称            | 是否需要参数 | 作用                                 |
|:----------------|-------------|------------------------------------|
| x               | 是           | 强制屏幕宽度                         |
| y               | 是           | 强制屏幕高度                         |
| s               | 是           | 强制屏幕大小                         |
| fs              | 否           | 全屏显示                             |
| an              | 否           | 关闭音频                             |
| vn              | 否           | 关闭视频                             |
| ast             | 是           | 指定播放音频流(指定 ID)              |
| vst             | 是           | 指定播放视频流(指定 ID)              |
| sst             | 是           | 指定播放字幕流(指定 ID)              |
| ss              | 是           | 从指定位置开始播放  单位: 秒         |
| t               | 是           | 播放指定时长的视频                   |
| nodisp          | 否           | 无显示屏幕                           |
| f               | 是           | 强制封装格式                         |
| pix_fmt         | 是           | 指定像素格式                         |
| stats           | 否           | 显示统计信息                         |
| idct            | 是           | IDCT 算法                            |
| ec              | 是           | 错误隐藏方式                         |
| sync            | 是           | 音视频同步方式(type=audio/video/ext) |
| autoexit        | 否           | 播放完成自动退出                     |
| exitonkeydown   | 否           | 按下按键退出                         |
| exitonmousedown | 否           | 按下鼠标退出                         |
| loop            | 是           | 指定循环次数                         |
| framedrop       | 否           | cpu 不够时可以丢帧                   |
| window_title    | 是           | 显示窗口标题                         |
| rdftspeed       | 是           | rdft 速度                            |
| showmode        | 是           | 显示方式(0-video  1-waves  2-RDFT)   |
| codec           | 是           | 强制解码器                           |


