### Upload Part
 - 描述：上传分片接口

 - 请求格式：

```http
PUT /<ObjectName>?partNumber=<PartNumber>&uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Length: <Content-Length>
Content-MD5: <Content-MD5>
Authorization: <authorization string> #请参照《签名算法》

...
file_content
...

```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
Etag: <Etag>
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
            <td>partNumber</td>
            <td>文件分片的序号，从1开始</td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>uploadId</td>
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
    </table>

- Request Heades(请求头)：

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
            <td>Content-Length</td>
            <td>文件大小，读取时原值返回</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Content-MD5</td>
            <td>base64编码的文件MD5（与传送内容不符时失败），注意：字符串格式为rfc标准使用base64编码的值</td>
            <td>No</td>
          </tr>
        </tbody>
    </table>

  - 注意：
    - 分片数不能超过2000。
