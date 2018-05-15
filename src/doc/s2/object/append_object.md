### Append Object
---
- Append Object以追加写的方式上传文件，被追加的文件可以是bucket中任意方式上传的文件(除开分片上传的分片文件)， 如: put Object，copy Object，分片上传且已经合并的文件。

  Append上传和put Object接口一致，除开以下两点：
    - x-amz-meta-s2-append-position请求头，必选， 用于标识append上传和上传文件追加在当前文件的位置
        - position的值为0时，如果当前追加的文件不存在或者文件的size等于0，则将数据追加到文件尾部后返回成功，否则返回409错误；
        - position的值大于0时，如果和当前文件的size相等，将数据追加到size开始的位置后返回成功，且修改文件的修改时间为当前时间；否则，返回409错误，且在response的x-amz-meta-append-position header中设置当前文件的size。
    - x-amz-meta-s2-directive请求头，取值：COPY, REPLACE, 可选(则为COPY)，用于标识append文件是是否覆盖文件的file meta信息

    注意：
    - 同一个position只能有一个请求能追加成功，且由于并发，设置正确的position也可能会返回失败，
    - 同一文件最多只能追加2000次请求
    - 单次请求最大文件大小为20G
    - 追加文件的总大小最大1T

- 请求格式：

```
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Length: <object data length>
Content-Type: <mime-type>
x-amz-meta-s2-append-position: <position>
Authorization: <authorization string> #请参照《签名算法》

[object data]
```

- 响应：
```
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-s2-append-position: <position>
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
            <td>x-amz-meta-append-position</td>
            <td>
            	用于标识append上传和上传文件追加在当前文件的位置
            </td>
            <td>Yes</td>
          </tr>    
          <tr>
            <td>x-amz-meta-s2-directive</td>
            <td>
            	指定是否使用被append文件的file meta，取值：COPY,REPALCE，默认为:COPY, 如果设置为COPY，则使用append文件的file meta，如果设置为REPLACE, 则使用当前append请求中携带的file meta
            </td>
            <td>No</td>
          </tr>    
          
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
