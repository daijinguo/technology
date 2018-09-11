
# 初级入门篇

+ Android 音视频开发(一) : 通过三种方式绘制图片  
http://www.cnblogs.com/renhui/p/7456956.html

+ Android 音视频开发(二)：使用 AudioRecord 采集音频PCM并保存到文件  
http://www.cnblogs.com/renhui/p/7457321.html


+ Android 音视频开发(三)：使用 AudioTrack 播放PCM音频  
http://www.cnblogs.com/renhui/p/7463287.html

+ Android 音视频开发(四)：使用 Camera API 采集视频数据  
http://www.cnblogs.com/renhui/p/7472778.html

+ Android 音视频开发(五)：使用 MediaExtractor 和 MediaMuxer API 解析和封装 mp4 文件  
http://www.cnblogs.com/renhui/p/7474096.html

+ Android 音视频开发(六)： MediaCodec API 详解  
http://www.cnblogs.com/renhui/p/7478527.html

+ Android 音视频开发(七)： 音视频录制流程总结  
http://www.cnblogs.com/renhui/p/7520690.html

初级入门篇主要是接触Android多媒体展示相关的API，通过单独的列举和使用这些API，对Android音视频处理有一个基本的轮廓，虽然知识点相对来说是比较散的，但是点成线,线称面，基本的基础掌握了，通过学习Android音视频核心的API将音视频的流程串联起来，这样对于音视频的了解和控制就不仅仅局限于最外层的API了，而是能够通过相对底层的方式来加深对Android 音视频开发的认知。 


# 中级进阶篇

## OpenGL ES 学习记录

学习 Android 平台 OpenGL ES API，了解 OpenGL 开发的基本流程，使用 OpenGL 绘制基本图形，并了解相关的API的简单使用

+ Android OpenGL ES 开发（一）: OpenGL ES 介绍  
http://www.cnblogs.com/renhui/p/7994261.html

+ Android OpenGL ES 开发（二）: OpenGL ES 环境搭建  
http://www.cnblogs.com/renhui/p/7997557.html

+ Android OpenGL ES 开发（三）: OpenGL ES 定义形状  
http://www.cnblogs.com/renhui/p/8000345.html

+ Android OpenGL ES 开发（四）: OpenGL ES 绘制形状  
http://www.cnblogs.com/renhui/p/8004987.html

+ Android OpenGL ES 开发（五）: OpenGL ES 使用投影和相机视图  
http://www.cnblogs.com/renhui/p/8005512.html

+ Android OpenGL ES 开发（六）: OpenGL ES 添加运动效果  
http://www.cnblogs.com/renhui/p/8005518.html

+ Android OpenGL ES 开发（七）: OpenGL ES 响应触摸事件  
http://www.cnblogs.com/renhui/p/8005528.html

+ Android OpenGL ES 开发（八）: OpenGL ES 着色器语言GLSL  
http://www.cnblogs.com/renhui/p/8126121.html

+ Android OpenGL ES 开发（九）: OpenGL ES 纹理贴图  
http://www.cnblogs.com/renhui/p/8145734.html

+ Android OpenGL ES 开发（十）: 通过GLES20与着色器交互  
http://www.cnblogs.com/renhui/p/8302434.html


## 动手实践，积累实战经验：

- 使用 OpenGL 显示一张图片  
- GLSurfaceviw 绘制 Camera 预览画面及实现拍照 https://github.com/renhui/OpenGLES20Study
- 使用OpenGL ES 完成视频的录制，并实现视频水印效果 https://github.com/renhui/OpenGLVideoRecord/tree/master

## 个人学习成果展示：

音视频录制流程总结： 
https://github.com/renhui/AndroidRecorder
OpenGL ES 学习笔记：
https://github.com/renhui/OpenGLES20Study
OpenGL音视频录制项目：
https://github.com/renhui/OpenGLVideoRecord 

## OpenSL ES 学习记录

学习 Android 平台 OpenSL ES API，了解 OpenSL 开发的基本流程，使用OpenSL播放PCM数据，并了解相关API的简单使用。

+ Android OpenSL ES 开发：Android OpenSL 介绍和开发流程说明  
https://www.cnblogs.com/renhui/p/9567332.html

+ Android OpenSL ES 开发：使用 OpenSL 播放 PCM 数据  
https://www.cnblogs.com/renhui/p/9565464.html

+ Android OpenSL ES 开发：Android OpenSL 录制 PCM 音频数据  
https://www.cnblogs.com/renhui/p/9604550.html

+ Android OpenSL ES 开发：OpenSL ES利用SoundTouch实现PCM音频的变速和变调  
https://www.cnblogs.com/renhui/p/9620400.html



# 高级探究篇

1. 深入研究音视频相关的网络协议，如 rtmp，hls，以及封包格式，如：flv，mp4
2. 深入学习一些音视频领域的开源项目，如 webrtc，ffmpeg，ijkplayer，librtmp 等等
3. 将 ffmpeg 库移植到 Android 平台，结合上面积累的经验，编写一款简易的音视频播放器
4. 将 x264 库移植到 Android 平台，结合上面积累的经验，完成视频数据 H264 软编功能
5. 将 librtmp 库移植到 Android 平台，结合上面积累的经验，完成 Android RTMP 推流功能 

## FFmpeg 学习记录

+ FFmpeg命令行工具学习(一)：查看媒体文件头信息工具ffprobe  
http://www.cnblogs.com/renhui/p/9209664.html

+ FFmpeg命令行工具学习(二)：播放媒体文件的工具ffplay  
http://www.cnblogs.com/renhui/p/8458802.html

+ FFmpeg命令行工具学习(三)：媒体文件转换工具ffmpeg  
http://www.cnblogs.com/renhui/p/9223969.html



- FFmpeg 学习(一)：FFmpeg 简介  
http://www.cnblogs.com/renhui/p/6922971.html

- FFmpeg 学习(二)：Mac下安装FFmpeg  
http://www.cnblogs.com/renhui/p/8458150.html

- FFmpeg 学习(三)：将 FFmpeg 移植到 Android平台  
http://www.cnblogs.com/renhui/p/6934397.html

- FFmpeg 学习(四)：FFmpeg API 介绍与通用 API 分析  
http://www.cnblogs.com/renhui/p/9293057.html

- FFmpeg 学习(五)：FFmpeg 编解码 API 分析  
http://www.cnblogs.com/renhui/p/9328893.html

- FFmpeg 学习(六)：FFmpeg 核心模块 libavformat 与 libavcodec 分析  
http://www.cnblogs.com/renhui/p/9343098.html


## FFmpeg 结构体学习

- FFmpeg 结构体学习(一)： AVFormatContext 分析  
https://www.cnblogs.com/renhui/p/9361276.html

- FFmpeg 结构体学习(二)： AVStream 分析  
https://www.cnblogs.com/renhui/p/9469856.html

- FFmpeg 结构体学习(三)： AVPacket 分析  
https://www.cnblogs.com/renhui/p/9488751.html

- FFmpeg 结构体学习(四)： AVFrame 分析  
https://www.cnblogs.com/renhui/p/9493393.html

- FFmpeg 结构体学习(五)： AVCodec 分析  
https://www.cnblogs.com/renhui/p/9493690.html

- FFmpeg 结构体学习(六)： AVCodecContext 分析  
https://www.cnblogs.com/renhui/p/9494286.html

- FFmpeg 结构体学习(七)： AVIOContext 分析  
https://www.cnblogs.com/renhui/p/9494887.html

- FFmpeg 结构体学习(八)：FFMPEG中重要结构体之间的关系  
https://www.cnblogs.com/renhui/p/9494890.html



# 高级探究篇

`GPUImage`  
https://github.com/CyberAgent/android-gpuimage


`IjkPlayer`  
https://github.com/Bilibili/ijkplayer


`librestreaming`  
https://github.com/lakeinchina/librestreaming


`RTMPDump`  
http://rtmpdump.mplayerhq.hu/


`SoundTouch`  
http://www.surina.net/soundtouch/sourcecode.html


# 学习展望

完成上面的学习后，可以尝试做一款音视频相关的APP，这个APP尽可能多的用上你学习的知识，看看能做到什么程度。如果你能很好的做出来，并认真的把上面列举的所有的点都完成和整理了，相信你在Android音视频领域会越走越好。

推荐的学习资料：

`《雷霄骅的专栏》`  
http://blog.csdn.net/leixiaohua1020

`《Android音频开发》`  
http://ticktick.blog.51cto.com/823160/d-15

`《FFMPEG Tips》`  
http://ticktick.blog.51cto.com/823160/d-17

`《Learn OpenGL 中文》`  
https://learnopengl-cn.github.io/

`《Android Graphic 架构》`  
https://source.android.com/devices/graphics/

`《Jhuster的专栏》`  
http://blog.51cto.com/ticktick

`《ywl5320的专栏》`  
https://blog.csdn.net/ywl5320

