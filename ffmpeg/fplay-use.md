
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



