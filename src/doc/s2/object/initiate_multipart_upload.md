### Initiate Multipart Upload

 - 描述：大文件分片上传初始化接口
 - 注意：在初始化上传接口中要求必须进行用户认证，匿名用户无法使用该接口。在初始化上传时可以给定文件上传所需要的meta绑定信息，在后续的上传中该信息将被保留，并在最终完成时写入云存储系统。

 - 请求格式：

```http
POST /<ObjectName>?uploads HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Type: <mime-type>
x-amz-meta-foo1: <value1> #自定义meta：foo1
x-amz-meta-foo2: <value2> #自定义meta：foo2
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

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

 - Request Headers（请求头）：
 参考put_object

 - Response Body（响应XML Body）：
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
            	包含Bucket, Key和UploadId元素
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
            	标识该分块上传的ID, 之后上传分片时需要携带该参数
            </td>
          </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X POST "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/my/file.txt?uploads"
```
