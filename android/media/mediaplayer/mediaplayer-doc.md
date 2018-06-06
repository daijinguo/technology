![](pics/mediaplayer_state_diagram.gif)

	当使用 new 创建一个 MediaPlayer 对象或者调用了 reset() 函数方法后，播放器将进入 IDLE 状态。
	当调用了 release() 方法后将进入  END 状态。
	IDLE 和 END 状态是 MediaPlayer 对象的生命周期状态.


# MediaPlayer 使用

## MediaPlayer 对象的创建
创建的方式有: 
- 通过 new MediaPlayer 方式创建，这样创建后的 MediaPlayer 对象处于 IDLE 状态；
- 通过 MediaPlayer 提供的静态create函数系创建出来的 MediaPlayer 对象，而通过create函数出来 MediaPlayer 对象，如果创建成功则进入的是 ` Prepared` 状态，而不是 `Idle` 状态；



## IDLE 状态问题

两种进入 idle 状态的方式：

+ 方式1:  通过 new 一个 MediaPlayer 对象出来以后；
+ 方式2:  在已有的 MediaPlayer 对象上调用 reset 函数方法；

但是通过这两种方式进入 idle状态后调用如下的一些函数后还是有一些微妙的差别的：

| 函数                                                         |
| ------------------------------------------------------------ |
| `getCurrentPosition()` |
| `getDuration()`                                              |
| `getVideoHeight()`                                           |
| `getVideoWidth()`                                            |
| `setAudioAttributes(AudioAttributes)`                        |
| `setLooping(boolean)`                                        |
| `setVolume(float, float)`                                    |
|   `pause()`                                                           |
|    `start()`                                                          |
|`stop()` |
|`seekTo(long, int)` |
| `prepare()` |
|`prepareAsync()`|

当在方式1，即创建完 MediaPlayer 对象后立即调用上表中的函数，用户提供的回调函数 `OnErrorListener.onError() ` 将不会被内部播放引擎调用，并且 MediaPlayer  对象的状态不会改变；

当在方式2，即调用现有的 MediaPlayer 对象的 reset 方法后立即调用上表的函数，用户提供的回调函数 `OnErrorListener.onError() ` 将会被内部播放引擎调用，并且 MediaPlayer  对象的状态改变为 ERROR 状态；

```
用法建议：
	一旦 MediaPlayer 对象不再使用，请立即调用 release 函数，这样就可以立即释放与 MediaPlayer 相关的内部播放器的资源。这里的资源可能是独占资源（例如硬件加速组件）。调用 release 函数失败可能导致 MediaPlayer 对象后续的回调失败或者完全失败；
```

## END 状态

一旦 MediaPlayer 对象进入 END 状态，就意味整个 MediaPlayer 的生命周期结束，再也无法进入到其他的状态。
