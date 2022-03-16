### Initiate Multipart Upload

- Description: initialization interface for large file fragment upload
- Note: user authentication is required in initializing the upload interface. Anonymous users cannot use this interface. During the initial upload, the meta binding information required for file upload can be given. This information will be retained in subsequent uploads and written to the cloud storage system when the final upload is completed.

- Request format:

```http
POST /<ObjectName>?uploads HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Type: <mime-type>
x-amz-meta-foo1: <value1> #custom meta：foo1
x-amz-meta-foo2: <value2> #custom meta：foo2
Authorization: <authorization string> #Please refer to signature algorithm
```

- Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<InitiateMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Bucket>your-bucket</Bucket>
    <Key>objectName</Key>
    <UploadId>VXBsb2FkIElEIGZvciA2aWWpbmcncyBteS1tb3ZpZS5tMnRzIHVwbG9hZA</UploadId>
</InitiateMultipartUploadResult>
```

 - Request Headers：
reference resources for put_object documentation

- Response Body（Response XML Body）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>InitiateMultipartUploadResult</td>
            <td>
            	Contains Bucket, Key and UploadId elements
            </td>
          </tr>
        
          <tr>
            <td>Bucket</td>
            <td>
            	bucket name
            </td>
          </tr>
        
          <tr>
            <td>Key</td>
            <td>
            	objectName
            </td>
          </tr>
        
          <tr>
            <td>UploadId</td>
            <td>
            	Identify the ID of the block upload. This parameter needs to be carried when uploading the block later
            </td>
          </tr>
        </tbody>
</table>

- Request example:

```
curl -v -X POST "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/my/file.txt?uploads"
```
