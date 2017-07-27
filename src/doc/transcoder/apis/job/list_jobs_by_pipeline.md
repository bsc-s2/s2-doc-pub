# 列出管道中的任务

## 描述
发送 GET 请求到 `/2012-09-25/jobsByPipeline/pipelineId` 以列出分配在指定管道中的任务。

## 请求
```
GET /2012-09-25/jobsByPipeline/pipelineId?PageToken=12345678 HTTP/1.1
Content-Type: charset=UTF-8
Accept: */*
Host: transcoder-ss.bscstorage.com
x-amz-date: 20170726T174952Z
Authorization: AWS4-HMAC-SHA256
               Credential=AccessKeyID/request-date/Transcoder endpoint/elastictranscoder/aws4_request,
               SignedHeaders=host;x-amz-date;x-amz-target,
               Signature=calculated-signature
```

## 请求参数

- PageToken

如果结果中出现 NextPageToken,  则说明结果没有列完全。需要在下一次请求中使用上一次结果中的 NextPageToken 做为PageToken，来继续请求结果。

## 返回
```
Status: 200 OK
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jan 2013 06:01:47 GMT

{
   "Jobs":[{
      "Id":"任务 ID",
      "Inputs":[{
          "Key":"转码源文件名"
      }],
      "OutputKeyPrefix":"转码后的输出文件名前缀",
      "Outputs":[{
         "Key":"转码后的输出文件名",
         "PresetId":"转码模板 ID",
         "SegmentDuration":"[1,60]",
      },
      {...}],
      "Snapshots":[{
         "Key":"转码后的输出文件名"，
         "Format":"jpg|png",
         "Time":"截图开始时间点",
         "Interval":"截图间隔时间",
         "Number":"截图数量"，
      },
      {...}]
      "Playlists":[{
         "Format":"HLSv3|HLSv4",
         "Name":"播放列表文件名",
         "OutputKeys":[
            "包含在输出文件列表中的输出文件名",
            ...
         ],
      },
      {...}],
      "PipelineId":"本转码任务使用的管道 ID",
      "Status":"Submitted|Progressing|Complete|Canceled|Error",
      "Timing":{
         "SubmitTimeMillis":"任务创建的时间。单位：epoch milliseconds",
         "FinishTimeMillis":"任务完成的时间。单位：epoch milliseconds"
      }
   },
   {...}],
  "NextPageToken": "1234567890"
}
```
