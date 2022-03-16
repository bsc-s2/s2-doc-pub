
## How to use video and audio transcoding service
### Function list
### Supported input formats

- container format

3GP、AVI、FLV、MP4、M3U8、MPG、WMV、MKV、MOV、TS、 DIV、GIF、AMR、MP3

- Video coding format

H.264、H.265、MPEG-1、MPEG-2、MPEG-4、VP8、VP9、Windows Media Video等

- Audio coding format

AAC、AC-3、MP2、MP3、SPEEX、Windows Media Audio
### **Supported output formats**
- Container format

FLV、MP4、TS、M3U8、MPG、TS、GIF、MP3、MP2、AAC、WMV、WMA、AAC、DASH

- Video coding format

H.264、H.265、GIF、MPEG-2、MS-MPEG4

- Audio coding format

AAC、MP2、MP3、Windows Media Video

- Encoding format compatibility relationship

|Coding format|Supported containers|
| :-: | :-: |
|H.264|FLV, MP4, TS|
|H.265|FLV, MP4, TS|
|GIF|GIF|
|MPEG2|MPG|
|AAC|FLV, MP4, TS, AAC|
|MP2|MPG, MP2|
|MP3|MP3, FLV, MP4, TS|
|MP3|MP3, FLV, MP4, TS|
|MS-MPEG4|WMV|
|Windows Media Audio|WMV, WMA|
### **Transform method**
- ` `Auto transcoding:

Automatically transcode video files uploaded to a bucket by configuring transcoding templates and transcoding rules in advance

- Active transcoding:

Users actively transcode a single file by creating transcoding tasks (transcoding templates and pipelines need to be created in advance)
### **Transcoding function**
- Video screenshot: capture JPG / PNG pictures at a certain time point or at a time interval of the video file.
- Video clip: capture a period of time in the video for transcoding. (under development)
- Rotational resolution
- To video bit rate
- To audio bit rate
- To audio sampling rate
- To video frame rate
- Set GOP (keyframe fixed spacing)
- HLS transcoding
- DASH transcoding
- FastStart：The fast start of playback is realized by moving the original information of MP4 file from the end of the file to the head.
## **Noun interpretation**
### **Transcoding template（Preset）**
Transcoding templates are used to predefine transcoding rules that can be reused.
### **Task（Job）**
The task is responsible for transcoding the multimedia files stored in the bucket according to the pre created template. A transcoding task can transcode an output into multiple output formats. To improve parallel efficiency, it is recommended to create a task for each output.
### **Pipeline**
A pipeline is a queue used to manage tasks. When creating a task, you need to select a pipe to store the task to be created. You can create multiple pipes to perform different tasks. For example, you can create two pipelines, one for ordinary tasks and the other for urgent tasks only. The tasks in each pipeline can be executed concurrently, but the number of concurrent tasks is limited (currently 5 tasks). The transcoding system executes in turn according to the order in which the tasks in each pipeline are created.
## **How to use transcoding system**
### **Create transcoding template**
In the Storage Console http://cwn-ss.bscstorage.com/#/video/template Module, create a transcoding template through the UI.
### **Create pipe**
use https://doc.bscstorage.com/doc/transcoder/apis/pipeline/create\_pipeline.html Create a pipe.。
### **Create task**
use https://doc.bscstorage.com/doc/transcoder/apis/job/create\_job.html Create a pipe.
