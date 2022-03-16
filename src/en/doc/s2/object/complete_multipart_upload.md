## Complete Multipart Upload

- Description: large file fragment upload and splicing completion interface (merging interface)

- Request format:

```http
POST /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Type: text/json
Authorization: <authorization string> #Please refer to signature algorithm

<CompleteMultipartUpload>
    <Part>
        <PartNumber>1</PartNumber>
        <ETag>"a54357aff0632cce46d942af68356b38"</ETag>
    </Part>
    <Part>
        <PartNumber>2</PartNumber>
        <ETag>"0c78aef83f66abc1fa1e8477f296d394"</ETag>
    </Part>
    <Part>
        <PartNumber>3</PartNumber>
        <ETag>"acbd18db4cc2f85cedef654fccc4a4d8"</ETag>
    </Part>
</CompleteMultipartUpload>
```

- Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Location>http://Example-Bucket.ss.bscstorage.com/Example-Object</Location>
    <Bucket>Example-Bucket</Bucket>
    <Key>Example-Object</Key>
    <ETag>"3858f62230ac3c915f300c664312c11f-9"</ETag>
</CompleteMultipartUploadResult>
```

- Request Parameters：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>       
          <tr>
            <td>PartNumber</td>
            <td>Uploadid value obtained through Initiate Multipart Upload (large file fragment upload initialization interface)</td>
            <td>Yes</td>
          </tr>      
          <tr>
            <td>ETag</td>
            <td>The Etag value in the response header returned after successful upload through the Upload Part</td>
            <td>Yes</td>
          </tr>     
        </tbody>
</table>

 - Response Body（ Response XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>      
          <tr>
            <td>CompleteMultipartUploadResult</td>
            <td>
            	Contain Location, Bucket, Key and ETag element
            </td>
            <td>Yes</td>
          </tr>     
          <tr>
            <td>Location</td>
            <td>
            	URI Identifies the newly uploaded file
            </td>
            <td>Yes</td>
          </tr>    
          <tr>
            <td>Bucket</td>
            <td>
            	bucket name
            </td>
            <td>Yes</td>
          </tr>  
          <tr>
            <td>Key</td>
            <td>
            	objectName
            </td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>ETag</td>
            <td>
            	Etag of the file, the Etag and put\_ Unlike the Etag of object, it is not the MD5 value of the file
            </td>
            <td>Yes</td>
          </tr>
        </tbody>
</table>

