# 创建任务

## 描述

发送 POST 请求到 `/2012-09-25/jobs` 以创建任务。

## 请求

```
POST /2012-09-25/jobs HTTP/1.1
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
   "PipelineId":"本转码任务使用的管道 ID"
}
```


## 请求参数

- Inputs

转码源文件的信息。接受类型：数组。
注意目前只支持单一 input。如：
```
"Inputs": [{
    "Key": "path/to/orginal.mp4"
}]
```

- Inputs: Key

转码原文件名。

- OutputKeyPrefix

转码后输出文件名前缀。通常用于将转码输出存入单独目录中。比如设置 OutputKeyPrefix 为 `transcode_output/` ，从而将转码后的文件统一存放在 `transcode_ouput` 目录下。如不需要设置前缀，则使用空字符串。

- (可选) Outputs

转码输出文件信息。Outputs 和 Snapshots 必须至少存在一个。

- Outputs: Key

转码输出文件名。输出的文件将会保存在管道中设置的 OutputBucket 中。
注意：
- 如果输出文件名已经存在于存储中，原文件将被本次转码输出文件覆盖。
- 如果模板中的  Container 是 `ts`，且 SegmentDuration 不为空，则最终输出文件名会在所提供的输出文件名的基础上增加 `00000.ts`和 `.m3u8` 。所以如果所提供的输出文件名已经包含后缀 `.ts`，则最终的结果会是 `OutputKeyPrefixKey.ts00000.ts`。

- Outputs: PresetId

本输出应用的转码模板 ID。

- (可选、TS 输出 Only) Outputs: SegmentDuration

HLS 切片时长。可选值：1 - 60。单位为秒。
注意 SegmentDuration 仅对 Container 为 `ts` 有效。对于其他 Container， 则自动忽略此项。

- （可选）Snapshots

截图输出信息。Outputs 和 Snapshots 必须至少存在一个。

- Snapshots: Format

截图文件格式。
可选值：png, jpg

- Snapshots: Key

输出截图文件名。
注意扩展名会自动根据 Format 添加。

- Snapshots: Time

截图开始时间。格式为 s.S（s 为秒，S 为浮点型毫秒）。

- （可选）Snapshots: Interval

截图间隔。格式为 s.S（s 为秒，S 为浮点型毫秒）。只有当 Number > 1 时才会起作用。
如果设置截图间隔，则会在输出文件名中自动添加 图片索引，比如 `snapshot0000.png - snapshop0010.png`。

- （可选）Snapshots: Number

截图最大数量。默认为1。

- （可选）Snapshots: Resolution

截图分辨率。格式为 [width]x[height]。 比如: 1920x1080。
默认为原视频分辨率。

- （可选）Snapshots: AspectRatio

截图宽高比。可选值为 ["1:1", "4:3", "3:2", "16:9"]。
默认为原视频宽高比。

- （可选）Playlists

自适应 HLS 转码输出信息。

- Playlists: Format

自适应转码的格式。可选值：HLSv3、HLSv4。
对于自适应HLS播放列表中的每一个子HLS转码
- HLSv3转码会生成ts切片文件（video00000.ts, video00001.ts, ...），以及一个m3u8播放列表。
- HLSv4转码会生成一个ts文件和一个m3u8播放列表。

- Playlists: Name

自适应HLS播放列表的文件名。注意系统会自动添加 `.m3u8` 扩展名。

- Playlists: OutputKeys

包含在自适应 HLS 播放列表中的输出文件名。每个被包含的输出必须是 HLS 输出（Container 为 `ts`，且提供 SegmentDuration），而且 SegmentDuration 必须相同。

- PipelineId

本转码任务使用的管道 ID


## 返回

```
Status: 201 Created
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jan 2013 06:01:47 GMT

{
   "Job":{
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
   }
}
```

## 例子
```
{
   "Inputs":[{
      "Key":"input/test.ts"
   }],
   "OutputKeyPrefix":"",
   "Outputs":[{
      "Key":"test.mp4",
      "PresetId":"123",
   }],
   "PipelineId":"1000000000000000001"
}
```
