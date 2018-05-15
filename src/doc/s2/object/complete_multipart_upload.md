### Complete Multipart Upload

 - 描述：大文件分片上传拼接完成接口（合并接口）

 - 请求格式：

```http
POST /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Type: text/json
Authorization: <authorization string> #请参照《签名算法》

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

 - 响应：

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

- Request Parameters(请求参数)：

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
            <td>uploadId</td>
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
 </table>

 - Request Body（请求Body）：

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
            <td>文件分片的序号</td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>ETag</td>
            <td>通过Upload Part（上传分片接口）上传成功后返回的响应头中的Etag值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
</table>

 - Response Body（响应XML Body）：
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
            	包含Location, Bucket, Key和ETag元素
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Location</td>
            <td>
            	URI标识新上传的文件
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
            	文件的ETag, 该ETag和put_object的ETag不同, 并不是文件的md5值
            </td>
            <td>Yes</td>
          </tr>
        </tbody>
</table>
