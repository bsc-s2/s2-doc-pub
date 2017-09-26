# 获取音视频元信息

## 描述
发送 GET 请求到 `/metadata/<bucket>/<key>` 以获取元信息。

## 请求
```
GET /metadata/test_bucket/test.mp4 HTTP/1.1
Content-Type: charset=UTF-8
Accept: */*
Host: transcoder-ss.bscstorage.com
x-amz-content-sha256: UNSIGNED-PAYLOAD
x-amz-date: 20170925T093131Z
Authorization: AWS4-HMAC-SHA256
               Credential=acc_yanhui/20170925/us-east-1/elastictranscoder/aws4_request,
               SignedHeaders=host;x-amz-content-sha256;x-amz-date,
               Signature=e9147d9d1461d7ca92c0805735490be7fd7d9d92ddee216ee47306a7d5fabcaa
```

## 请求参数

- bucket

bucket名字

- key

获取元信息的音视频文件的key

## 返回

```
Status:200

Content-length: '2253'
x-amz-s2-requester: test_bucket
server: openresty/1.11.2.4
connection: keep-alive
x-amz-request-id: 00361611-1709-2517-4651-00163e0630f7
date: Mon, 25 Sep 2017 09:46:51 GMT
content-type: application/json

{
    "audio_streams":    音频信息
        [
            {
                "sample_fmt": "fltp",   采样格式
                "codec_tag": "0x6134706d",  编码器标签
                "codec_type": "audio",  编码器类型
                "channels": 2,  音频数
                "bit_rate": "96001",    码率
                "codec_name": "aac",    编码器名
                "duration": "716.885011",   文件总时长
                "nb_frames": "30876",   帧数
                "codec_time_base": "1/44100",   编码器每帧时长
                "index": 1, 流索引号
                "start_pts": 0, 时间戳
                "profile": "LC", 编码的profile
                "tags": 标签信息
                    {
                        "handler_name": "SoundHandler", 处理器名字
                        "language": "und"   语言
                    },
                "r_frame_rate": "0/0",  真实基础帧率
                "start_time": "0.000000",   首帧时间
                "time_base": "1/44100", 每帧时长
                "codec_tag_string": "mp4a", 编码器标签名
                "duration_ts": 31614629, 单位为time_base的时长
                "codec_long_name": "AAC (Advanced Audio Coding)",   编码器名全称
                "bits_per_sample": 0,   采样码率
                "avg_frame_rate": "0/0",    平均帧率
                "channel_layout": "stereo", 声道
                "max_bit_rate": "96001", 最大码率
                "sample_rate": "44100"  采样率
            }
        ],

    "video_streams":    视频信息
        [
            {
                "profile": "High",  编码的profile
                "sample_aspect_ratio": "0:1",
                "codec_tag": "0x31637661",  编码器标签
                "refs": 1,
                "codec_type": "video",  编码器类型
                "coded_height": 720,    图像高度
                "bit_rate": "1500443",  码率
                "codec_name": "h264",   编码器名
                "duration": "716.800000",   时长
                "is_avc": "true",
                "nb_frames": "17920",   帧数
                "codec_time_base": "1/50",  编码器每帧时长
                "index": 0, 流索引号
                "start_pts": 0,
                "width": 1280,  帧宽度
                "coded_width": 1280,    图像宽度
                "pix_fmt": "yuv420p",   像素个数
                "chroma_location": "left",
                "tags":
                    {
                        "handler_name": "VideoHandler", 处理器名字
                        "language": "und"   语言
                    },
                "r_frame_rate": "25/1", 真实基础帧率
                "start_time": "0.000000",   首帧时间
                "time_base": "1/12800", 每帧时长
                "codec_tag_string": "avc1", 编码器标签名
                "duration_ts": 9175040, 单位为time_base的时长
                "codec_long_name": "H.264 / AVC / MPEG-4 AVC / MPEG-4 part 10", 编码器名全称
                "display_aspect_ratio": "0:1",
                "height": 720,  帧高度
                "avg_frame_rate": "25/1",   平均帧率
                "level": 40,    级别
                "bits_per_raw_sample": "8",
                "has_b_frames": 2,  记录缓存帧大小
                "nal_length_size": "4"
            }
        ],

    "format":
        {
            "tags": 标签信息
                {
                    "major_brand": "isom",
                    "minor_version": "512",
                    "compatible_brands": "isomiso2avc1mp41letv",
                    "encoder": "Lavf56.15.102"
                },
            "nb_streams": 2,    流的个数
            "start_time": "0.000000",   首帧时间
            "format_long_name": "QuickTime / MOV",  格式名全称
            "format_name": "mov,mp4,m4a,3gp,3g2,mj2",   格式名
            "bit_rate": "1607943",  码率
            "nb_programs": 0,
            "duration": "716.932000",   时长
            "size": "144098269" 文件大小
        },

    "other_streams": []
}
```
