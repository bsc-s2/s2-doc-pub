# 如何使用视音频转码服务

## 功能列表

### 支持的输入格式

- 容器格式

  3GP、AVI、FLV、MP4、M3U8、MPG、WMV、MKV、MOV、TS、 DIV、GIF、AMR、MP3

- 视频编码格式

  H.264、H.265、MPEG-1、MPEG-2、MPEG-4、VP8、VP9、Windows Media Video等

- 音频编码格式

  AAC、AC-3、MP2、MP3、SPEEX、Windows Media Audio

### 支持的输出格式

- 容器格式

  FLV、MP4、TS、M3U8、MPG、TS、GIF、MP3, MP2, AAC, WMV, WMA, AAC

- 视频编码格式

  H.264、H.265、GIF、MPEG-2, MS-MPEG4

- 音频编码格式

  AAC、MP2、MP3, Windows Media Video

- 编码格式兼容关系

|  编码格式   | 支持的容器    |
| ----------  | ---           |
| H.264       |  FLV, MP4, TS |
| H.265       |  FLV, MP4, TS |
| GIF         |  GIF          |
| MPEG2       |  MPG          |
| AAC         |  FLV, MP4, TS, AAC |
| MP2         |  MPG, MP2     |
| MP3         |  MP3, FLV, MP4, TS|
| MP3         |  MP3, FLV, MP4, TS|
| MS-MPEG4    |  WMV          |
| Windows Media Audio |  WMV, WMA |



### 转码方式

- 自动转码：

  通过提前配置转码模板和转码规则，对上传至某 Bucket 中的视频文件进行自动转码

- 主动转码：

  用户通过创建转码任务（需提前创建转码模板和管道）主动对单个文件进行转码 

### 转码功能

- 视频截图：对视频文件某一个时间点或者按照时间间隔截取 JPG/PNG 图片。
- 视频剪辑：截取视频中的一段时间进行转码。（正在开发中）
- 转分辨率
- 转视频码率
- 转音频码率
- 转音频采样率
- 转视频帧率
- 设置GOP（关键帧固定间距）
- HLS转码
- FastStart：通过将 MP4 文件的原信息从文件尾部移到头部，实现播放快速启动。


## 名词解释

### 转码模板（Preset）

转码模板用于预定义可以复用的转码规则。

###  任务（Job）

任务负责按照预先创建的模板对已经存储在Bucket中的多媒体文件进行转码。一个转码任务可以将一个输出转码成多种输出格式。
为了提高并行效率，建议为每个输出创建一个任务。

### 管道（Pipeline）

管道是用于管理任务的队列。当创建任务时，您需要选择一个管道用于存放将要创建的任务。您可以创建多个管道，用于执行不同任务。
比如您可以创建两个管道，一个用于用于处理普通任务，另一个只负责处理紧急任务。
每个管道中的任务可以并发执行，但并发数量有限（目前为5个任务）。转码系统按照每个管道中任务创建的顺序来依次执行。


## 如何使用转码系统

### 创建转码模板

在存储控制台的[视频处理->转码模板](http://console.bscstorage.com/#/video/template)模块中，通过 UI 来创建转码模板。

### 创建管道

使用[创建管道接口](/doc/transcoder/apis/pipeline/create_pipeline.html)创建管道。

### 创建任务

使用[创建任务接口](/doc/transcoder/apis/job/create_job.html)创建管道。
