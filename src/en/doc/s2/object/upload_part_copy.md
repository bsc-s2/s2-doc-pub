### Upload Part - Copy

- Description: create and upload a fragment by copying (do not upload specific file content, but copy another file in the system by COPY).

- Request format:

```
PUT /<ObjectName>?partNumber=PartNumber&uploadId=UploadId HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
x-amz-copy-source: </source-bucket/source-object>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Response:

```
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CopyObjectResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <LastModified>Mon, 08 Aug 2016 05:04:10 GMT</LastModified>
    <ETag>870c06c00566c4fb1861bb10f34d1904</ETag>
</CopyObjectResult>
```

- Request Parameters：

<table class="table table-condensed">
    <thead>
      <tr>
        <th>Parameter</th>
        <th>Description</th>
        <th>Required</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>partNumber</td>
        <td>The serial number of the document slice, starting from 1</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>uploadId</td>
        <td>Uploadid value obtained through Initiate Multipart Upload (large file fragment upload initialization interface)</td>
        <td>Yes</td>
      </tr>
    </tbody>
</table>

- Request Headers：

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
            <td>x-amz-copy-source</td>
            <td>
                The address of the file to be copied. format：/source-bucket/source-object，We need to encode urlencode as a whole
            </td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>Content-Length</td>
            <td>
               Must be 0
            </td>
            <td>=0</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-match</td>
            <td>
                If the specified Etag matches the Etag of the source file, the source file can be copied, otherwise it returns412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-nonematch</td>
            <td>
                If the specified Etag does not match the Etag of the source file, the source file can be copied, otherwise it returns412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-unmodified-since</td>
            <td>
                If the source file has not been modified since the specified time, you can copy the source file; otherwise, return412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-modified-since</td>
            <td>
                If the source file is modified at the specified time, the source file can be copied, otherwise 412 is returned(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
        </tbody>
</table>

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
            <td>CopyObjectResult</td>
            <td>
                contain ETag and LastModified 
            </td>
          </tr>
          <tr>
            <td>ETag</td>
            <td>
                File's ETag
            </td>
          </tr>
          <tr>
            <td>CopyObjectResult</td>
            <td>
                File last modified time
            </td>
          </tr>
        </tbody>
</table>

- Request example:

```
curl -v -X PUT -H "x-amz-copy-source: /bucket-123/path/to/file123.txt" -H "Date:
Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/myfile.txt?partNumber=<PartNumber>&uploadId=<UploadId>"
```
