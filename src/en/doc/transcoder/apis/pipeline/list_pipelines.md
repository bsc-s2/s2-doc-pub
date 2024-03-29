# View pipe

## Description
Send GET request to `/2012-09-25/pipelines/pipelineId` to get the specified pipe.

## request
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

- PageToken

When the transcoder interface returns more than one page of results (`NextPageToken`appears in the return)
Please use `PageToken` to get the results on the next page.

## return
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
