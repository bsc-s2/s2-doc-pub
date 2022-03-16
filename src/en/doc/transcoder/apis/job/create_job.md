# Create task

## Description

Send POST request to `/2012-09-25/jobs` to create a task.

## Request

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
      "Watermarks": [{
        "InputKey": "string",
      }],
      "Encryption": {
        "Mode": "string",
        "Key": "string",
        "KeyMd5": "string",
        "InitializationVector": "string"
      },
      "Composition": [{
        "TimeSpan": {
          "StartTime": "string",
          "Duration": "string"
        }
      }],
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


## Request parameters
- Inputs

Transcoding source file information. Accept type: array. Note that currently only a single input is supported. For example:
```
"Inputs": [{
    "Key": "path/to/orginal.mp4"
}]
```

- Inputs: Key

Transcoding the original file name.

- OutputKeyPrefix

Output file name prefix after transcoding. It is usually used to store transcoded output in a separate directory. Such as setting
OutputKeyPrefix is transcode_output/，So that the transcoded documents can be stored in a unified manner transcode_ouput Directory. If you do not need to set a prefix, use an empty string.

- (Optional) Outputs

Transcoding output file information. At least one of outputs and snapshots must exist.

- Outputs: Key

Transcoding output file name. The output file will be saved in the outputbucket set in the pipeline. be careful:
if the output file name already exists in the storage, the original file will be overwritten by the transcoding output file.
If the container in the template is ts ，If the segmentduration is not empty, the final output file name will be increased based on the provided output file name
uuid00000.ts and `.m3u8`. So if the supplied output file name already contains a suffix `.ts`，the end result will be `OutputKeyPrefixKey.tsuuid00000.ts`，
`uuid` represents the unique identifier of this transcoding, and all `ts` files will be carried, similar to `471c1c6e620c45debe9e3b3388749017`

- Outputs: PresetId

The transcoding template ID of this output application.

- (Optional, TS output only) Outputs: SegmentDuration

HLS slice duration. Optional values: 1 - 60. The unit is seconds. Note that segmentduration is only valid for containers `ts` effective. For other containers, this item is automatically ignored.

- (Optional) Outputs: Watermarks

Video watermarking. If this option is configured, the video coding method in the transcoding template cannot be "unchanged", otherwise the task cannot be created. Currently, only a single watermark is supported, for example:

```
"Watermarks": [{
    "InputKey": "abc.png",
}]
```

The watermark location information is configured in the transcoding template. The default is the upper right corner. The picture format only supports JPG and PNG. "Inputkey" refers to the image file key under the input bucket (configured in the pipeline), which must exist.

- (Optional, HLS encryption) Outputs: Encryption

HLS slice AES-128 encrypted information. This option only works when HLS slices.

```
"Encryption": {
    "Mode": "AES128",
    "Key": "string",
    "KeyMd5": "string",
    "InitializationVector": "string"
}
```
"Mode" option: currently only "aes128" is supported. "Key" option: a string in JSON format, including the secret key of aes128 encrypted video (must be 16 bytes) and the access URL of the key. It must be Base64 encoded. For example: '{"URL":“ http://ss.bscstorage.com/file.key "," key ":" 1111111122222222222 "} ', Base64 encoding is followed by:' eyjvcmwioiiaiahr0cdovl3nzlmjzy3n0b3jhz2uuy29tl2zpbgua2v5iiwgiktlesi6icixmtexmtexmtexmtiymjiymjiyiin0 = '" keymd5 "option: MD5 value of key not Base64 encoded, which must be Base64 encoded." Initializationvector "option: optional configuration. The initialization vector is 16 bytes long and must be Base64 encoded.

- (Optional, video clipping) Outputs: Composition

Video clipping configuration, currently only supports single clipping.

```
"Composition": [{
  "TimeSpan": {
    "StartTime": "string",
    "Duration": "string"
  }
}]
```
"Starttime" option: the start time of clipping, in milliseconds. "Duration" option: the duration of clipping, in milliseconds.

- （Optional）Snapshots

Screenshot output information. At least one of Outputs and Snapshots must exist

- Snapshots: Format

Screenshot file format. Optional value：png, jpg

- Snapshots: Key

Output screenshot file name. Note that the extension is automatically added according to the format.

- Snapshots: Time

Screenshot start time. The format is s.S (s is seconds, s is floating-point milliseconds).

- （Optional）Snapshots: Interval

Screenshot interval. The format is s.S (s is seconds, s is floating-point milliseconds). It works only when number > 1. If the screenshot interval is set, the picture index will be automatically added to the output file name, such as

snapshot0000.png - snapshop0010.png

。

- （Optional）Snapshots: Number

Maximum number of screenshots. The default is 1.

- （Optional）Snapshots: Resolution

Screenshot resolution. The format is [width] x [height]. For example: 1920x1080. The default is the original video resolution.

- （Optional）Snapshots: AspectRatio

Screenshot aspect ratio. The optional values are ["1:1", "4:3", "3:2", "16:9"]. The default is the original video aspect ratio.

- （Optional）Playlists

Adaptive HLS transcoding output information.

- Playlists: Format

Adaptive transcoding format. Optional values: hlsv3, hlsv4. For each sub HLS transcoding in the adaptive HLS playlist

- HLSv3 Transcoding generates TS slice files (video00000.ts, video00001. Ts,...) and a m3u8 playlist.
- HLSv4 Transcoding generates a TS file and a m3u8 playlist.
- Playlists: Name

The file name of the adaptive HLS playlist. Note that the system will automatically add `.m3u8` Extension.

Playlists: OutputKeys

The output file name included in the adaptive HLS playlist. Each contained output must be HLS output (Container is `ts`，and SegmendDration is provided），And the SegmentDuration must be the same.

- PipelineId

Pipeline ID used by this transcoding task


## Return

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

## example

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

## Create tasks through SDK

python

```python
import boto3
from botocore.client import Config


config = Config(signature_version='s3v4')
cli = boto3.client('elastictranscoder',
                   config=config,
                   region_name='us-west-2',
                   endpoint_url='http://transcoder-ss.bscstorage.com',
                   aws_access_key_id="accesskey",
                   aws_secret_access_key="secretkey")

inputs = [{
   'Key': "sample.mp4",
}]

outputs = [{
   'Key': "sample.m3u8",
   # 转码模板id，需要预先配置
   'PresetId': "1000",
   'SegmentDuration': "10",
}]

print cli.create_job(
   # 管道id，请预先创建
   PipelineId='pipelineid',
   Inputs=inputs,
   Outputs=outputs,
)
```

java

```java
public static void create_job() {
   BasicAWSCredentials awsCreds = new BasicAWSCredentials("accessKey", "secretKey");

   ClientConfiguration clientconfiguration = new ClientConfiguration();
   clientconfiguration.setSocketTimeout(60 * 60 * 1000); // in milliseconds
   clientconfiguration.setConnectionTimeout(60 * 60 * 1000); // in milliseconds

   AmazonElasticTranscoder client = new AmazonElasticTranscoderClient(awsCreds, clientconfiguration);
   client.setEndpoint("http://transcoder-ss.bscstorage.com");

   JobInput input = new JobInput().withKey("sample.mp4");

   List<JobInput> inputs = Arrays.asList(input);

   CreateJobOutput out1 = new CreateJobOutput().withKey("output.mp4").withPresetId("1000");

   List<CreateJobOutput> outputs = Arrays.asList(out1);

   CreateJobRequest createJobRequest = new CreateJobRequest().withPipelineId("pipelineid")
            .withInputs(inputs).withOutputs(outputs);

   Job j = client.createJob(createJobRequest).getJob();
   System.out.printf("task id: %s\n", j.getId());
}
```
