# Create pipe

## Description
Send post request to `/2012-09-25/pipelines/` to create a pipe.

## request
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

## Request parameters

- Name

Pipe name. In order to facilitate your management, we recommend setting different names for different pipes, but it is not forced. 
The maximum length of the pipe name is 40 characters.

- InputBucket

The name of the bucket used to store the transcoding source file. Please confirm that the entered bucket exists in your account.

- OutputBucket

The bucket name used to store the transcoded output file. Please confirm that the entered bucket exists in your account.

- (Optional) ContentConfig: Permissions

Defines which users or predefined user groups can access or modify the transcoded input file. If you set permissions, the system will only grant you the specified permissions to the transcoded files, and will not grant full control permissions to the owner. If you ignore this item, the system grants full control to the owner.

- (Optional) SuccessCallbackUrl


Accept the URL of the successful callback of the task. Only HTTP protocol URLs are supported. After the transcoding task is successful, the system will send a post request to the URL. The request JSON content is as follows:

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


- (optional) FailureCallbackUrl

Accept the URL of the successful callback of the task. Only HTTP protocol URLs are supported. After the transcoding task fails, the system will send a post request to the URL. The request JSON content is as follows:

```
{
    "result": "failure",
    "input_bucket": "in_bucket_name",
    "input_key": "test.mp4",
    "error_type": "InternalError",
    "error_message": "...",
}
```

## Return

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
