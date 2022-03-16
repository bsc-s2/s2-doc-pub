# Get pipe

## Description
Send GET request to `/2012-09-25/pipelines/` to get the pipeline belonging to your account.


## request
```
GET /2012-09-25/pipelines/pipelineId HTTP/1.1
Content-Type: charset=UTF-8
Accept: */*
Host: transcoder-ss.bscstorage.com
x-amz-date: 20170726T174952Z
Authorization: AWS4-HMAC-SHA256
               Credential=AccessKeyID/request-date/Transcoder endpoint/elastictranscoder/aws4_request,
               SignedHeaders=host;x-amz-date;x-amz-target,
               Signature=calculated-signature
```

## return

```
Status: 200 OK
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
