# 创建管道

## 描述
发送 POST 请求到 `/2012-09-25/pipelines/` 以创建管道。

## 请求
```
POST /2012-09-25/pipelines HTTP/1.1
Content-Type: application/json; charset=UTF-8
Accept: */*
Host: transcoder-ss.bscstorage.com
x-amz-date: 20170726T174952Z
Authorization: AWS4-HMAC-SHA256
               Credential=AccessKeyID/request-date/Transcoder endpoint/elastictranscoder/aws4_request,
               SignedHeaders=host;x-amz-date;x-amz-target,
               Signature=calculated-signature
Content-Length: number of characters in the JSON string
{
   "Name":" 管道名称",
   "InputBucket":"用于存放转码源文件的 Bucket 名称",
   "OutputBucket":"用于存放输出文件的 Bucket 名称",
   "ContentConfig":{
      "Permissions":[
         {
            "GranteeType":"Canonical|Email|Group",
            "Grantee":"用户名(Canonical)|用户邮箱(Email)|
                      AllUsers|AuthenticatedUsers|LogDelivery(Group)",
            "Access":[
               "Read|ReadAcp|WriteAcp|FullControl",
               ...
            ]
         },
         {...}
      ],
   },
   "SuccessCallbackUrl": "接受任务成功回调的 URL",
   "FailureCallbackUrl": "接受任务失败回调的 URL",
}
```

## 请求参数

- Name

管道名称。为了便于您的管理，我们推荐对不同的管道设置不同的名称，但并不强迫。
管道名称最长40个字符。

- InputBucket

用于存放转码源文件的 Bucket 名称。请确认输入的 Bucket 存在于您的账号中。

- OutputBucket

用于存放转码后的输出文件的 Bucket 名称。请确认输入的 Bucket 存在于您的账号中。

- (可选的) ContentConfig: Permissions

定义了哪些用户或者预定义的用户组可以访问或修改转码后的输入文件。
如果您设置了 Permissions，那么系统将对转码后的文件仅授予您指定的权限，并不会对所有者授予完全控制权限。
如果您忽略了此项，那么系统将对所有者授予完全控制权限。

- (可选的) SuccessCallbackUrl

接受任务成功回调的 URL。仅支持 HTTP 协议的 URL。
转码任务成功后系统会向该 URL 发送一个 POST 请求，请求 JSON 内容如下:

```
{
    "result": "success",
    "input_bucket": "in_bucket_name",
    "input_key": "test.mp4",
    "output_bucket": "out_bucket_name",
    "output_keys": ["test_300K.mp4",
 
    # HLS 转码相关
    "output_playlists": ["test_300K.m3u8"],

    # 转码后输出文件元信息
    "metadata": {
        "test_300K.mp4": {
            'etag': "xxxx",
            'video_streams': [
                {
                    "index": 0,
                    "codec_name": "h264",
                    "width": 560,
                    "height": 320,
                    "duration_ts": 498000,
                    "duration": "5.533333",
                    "bit_rate": "300000",
                    ...
                }, {}, ...
            ],
            'audio_stream': [
                {
                    "index": 1,
                    "codec_name": "aac",
                    "sample_fmt": "fltp",
                    "sample_rate": "48000",
                    "channels": 1,
                    "channel_layout": "mono",
                    "bits_per_sample": 0,
                    "bit_rate": "83050",
                    ...
                }
            ],
            'format': {
                "nb_streams": 2,
                "nb_programs": 0,
                "format_name": "mov,mp4,m4a,3gp,3g2,mj2",
                "format_long_name": "QuickTime / MOV",
                "start_time": "0.000000",
                "duration": "5.568000",
                "size": "383631",
                "bit_rate": "323000",
            }
        },
        "test_300K.m3u8: { ... }
    }
}
```


- (可选的) FailureCallbackUrl

接受任务成功回调的 URL。仅支持 HTTP 协议的 URL。
转码任务失败后系统会向该 URL 发送一个 POST 请求，请求 JSON 内容如下:

```
{
    "result": "failure",
    "input_bucket": "in_bucket_name",
    "input_key": "test.mp4",
    "error_type": "InternalError",
    "error_message": "...",
}
```

## 返回

```
Status: 201 Created
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jun 2017 06:01:47 GMT

{
   "Pipeline":{
       "Id":"123456789012345678",
       "Name":" my_pipeline",
       "InputBucket":"input_bucket",
       "OutputBucket":"output_bucket",
       "ContentConfig":{
          "Permissions":[
             {
                "GranteeType":"Group",
                "Grantee":"AllUsers",
                "Access":["Read"]
             }
          ],
       },
       "SuccessCallbackUrl": "http://mydomain.com/cb",
       "FailureCallbackUrl": "http://mydomain.com/cb",
       "Status": "Active|Paused",
    }
}
```
