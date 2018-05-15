### PUT Object

 - 描述：PUT方式上传一个文件（同时可以设置meta和acl）。

 - 请求格式： 

```http
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Length: <object data length>
Content-Type: <mime-type>
Authorization: <authorization string> #请参照《签名算法》

[object data]
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
```

 - Request Headers（请求头）：

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
            <td>Expires</td>
            <td>
            	文件过期时间，到期系统将自动清除文件（非即时，清除时间不定期），格式参考：http://www.w3.org/Protocols/rfc2616/
                rfc2616-sec14.html#sec14.21.
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>Cache-Control</td>
            <td>
            	文件Cache，标准HTTP协议，更多内容参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>
            
          <tr>
            <td>Content-Type</td>
            <td>
            	文件mime type，读取时原值返回
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Length</td>
            <td>
            	文件大小，读取时原值返回
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>Content-MD5</td>
            <td>
            	base64编码的文件MD5（与传送内容不符时失败），注意：字符串格式为rfc标准使用base64编码的值
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Disposition</td>
            <td>
            	HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Encoding</td>
            <td>
            	文件编码，HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>x-amz-acl</td>
            <td>
            	文件ACL：创建文件的同时，设置一个ACL。请参照《ACL》
            </td>
            <td>No</td>
          </tr>
            
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	用户自定义MetaDeta, header以x-amz-meta-开头, 所有meta以key:value的形式存储,最大限制64KB,
                HEAD或者GET时原样返回
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>

 - 请求示例：

```
curl -v -T "myfile.txt" -H "x-amz-meta-UploadLocation: My Home" -H "Date: Sat,20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/myfile.txt"
```
