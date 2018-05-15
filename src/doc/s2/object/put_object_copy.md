### PUT Object - Copy

 - 描述：通过拷贝方式创建Object（不上传具体的文件内容。而是通过COPY方式对系统内另一文件进行复制）。

 - 请求格式：

```http
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
x-amz-copy-source: </source-bucket/source-object>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
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
            <td>x-amz-copy-source</td>
            <td>
            	被copy的文件地址。格式：/source-bucket/source-object，需要整体进行urlencode编码.
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Cache-Control</td>
            <td>
            	文件Cache，标准HTTP协议，更多内容参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Expires</td>
            <td>
            	文件在客户端或浏览器的缓存过期时间，允许客户端在这个时间之前不去服务端检查，读取时原值返回。格式为：Sun, 29 Jul 2018 20:36:14 UTC
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
            	必须是0
            </td>
            <td>=0</td>
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
          
          <tr>
            <td>x-amz-copy-source-if-match</td>
            <td>
            	如果指定的ETag与源文件的ETag匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-nonematch</td>
            <td>
            	如果指定的ETag与源文件的ETag不匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-unmodified-since</td>
            <td>
            	如果指定的时间开始源文件没有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-modified-since</td>
            <td>
            	如果指定的时间开始源文件有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>

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
            <td>CopyObjectResult</td>
            <td>
            	包含ETag和LastModified元素
            </td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	文件的ETag
            </td>
          </tr>
        
          <tr>
            <td>CopyObjectResult</td>
            <td>
            	文件的最后修改时间
            </td>
          </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X PUT -H "x-amz-copy-source: /bucket-123/path/to/file123.txt" -H "Date:
Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/myfile.txt"
```
