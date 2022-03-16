# 列管道

## 描述
发送 GET 请求到 `/2012-09-25/pipelines/` 以获取属于您账号的管道。

## 请求
```
GET /2012-09-25/pipelines?PageToken=value HTTP/1.1
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

当 Transcoder 接口返回超过一页的结果时（ 返回中出现 `NextPageToken`），请使用 `PageToken` 来获取下一页的结果。

## 返回
```
Status: 200 OK
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jun 2017 06:01:47 GMT

{
   "Pipelines": [
       {
           "Id":"123456789012345678"
           "Name":" my_pipeline",
           "InputBucket":"input_bucket",
           "OutputBucket":"output_bucket",
           "SuccessCallbackUrl": "http://mydomain.com/cb",
           "FailureCallbackUrl": "http://mydomain.com/cb",
           "ContentConfig": {...},
           "Status": "Active|Paused",
        },
        { ... }
    ],
    "NextPageToken": "123456789012345679"
}
```
