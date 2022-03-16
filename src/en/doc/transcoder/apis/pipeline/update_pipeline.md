# Update pipeline

## Describe
Send PUT request to `/2012-09-25/pipelines/pipelineId` update the created pipe.

## How to update queue parameters
Please include all updated queue parameters in the requested body (unchanged parameters also need to be included).

## Request
```
PUT /2012-09-25/pipelines/pipelineId HTTP/1.1
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
   "InputBucket":"The Bucket name used to store the transcoding source file",
   "OutputBucket":"The name of the Bucket used to store the output file",
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
   "SuccessCallbackUrl": "Accept successful callback of task URL",
   "FailureCallbackUrl": "Accept callback of task failure URL",
}
```


## Request parameters
- Name

Pipe name. In order to facilitate your management, we recommend setting different names for different pipes, but it is not forced. The maximum length of the pipe name is 40 characters.

- InputBucket

The name of the bucket used to store the transcoding source file. Please confirm that the entered bucket exists in your account.

- OutputBucket

The bucket name used to store the transcoded output file. Please confirm that the entered bucket exists in your account.

- (Optional) ContentConfig: Permissions

Defines which users or predefined user groups can access or modify the transcoded input file. If you set permissions, the system will only grant you the specified permissions to the transcoded files, and will not grant full control permissions to the owner. If you ignore this item, the system grants full control to the owner.

- (Optional) SuccessCallbackUrl

Accept the URL of the successful callback of the task. Only HTTP protocol URLs are supported. After the transcoding task is successful, the system will send a post request to the URL.

- (Optional) FailureCallbackUrl

Accept the URL of the successful callback of the task. Only HTTP protocol URLs are supported. After the transcoding task fails, the system will send a post request to the URL.

## return

```
Status: 202 Accepted
Content-Type: application/json
Content-Length: number of characters in the response
Date: Mon, 14 Jun 2017 06:01:47 GMT

{
   "Pipeline":{
       "Id":"123456789012345678",
       "Name":" my_pipeline",
       "InputBucket":"input_bucket",
       "OutputBucket":"output_bucket",
       "SuccessCallbackUrl": "http://mydomain.com/cb",
       "FailureCallbackUrl": "http://mydomain.com/cb",
       "ContentConfig": {...},
       "Status": "Active|Paused",
    }
}
```
