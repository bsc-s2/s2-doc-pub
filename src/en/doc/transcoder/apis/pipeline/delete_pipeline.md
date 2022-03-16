# Delete pipe

## Description
Send DELETE request to `/2012-09-25/pipelines/pipelineId` to get the specified pipe.


## Request
```
DELETE /2012-09-25/pipelines/pipelineId HTTP/1.1
Content-Type: charset=UTF-8
Accept: */*
Host: transcoder-ss.bscstorage.com
x-amz-date: 20170726T174952Z
Authorization: AWS4-HMAC-SHA256
               Credential=AccessKeyID/request-date/Transcoder endpoint/elastictranscoder/aws4_request,
               SignedHeaders=host;x-amz-date;x-amz-target,
               Signature=calculated-signature
```

## Return

```
Status: 202 Accepted
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jun 2017 06:01:47 GMT

{
   "Success":"true"
}
```
