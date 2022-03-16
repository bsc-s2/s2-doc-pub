### GET Object

 - 描述：获取一个Object（下载）。
 
 - 请求格式：
 
```http
GET /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
Range: bytes=<byte_range> #支持断点下载
```

 - 响应：
 
```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
Content-Type: <object-mime-type>
Content-Length: <object-file-bytes>
ETag: "<文件的MD5值>"
Last-Modified: <最后修改时间>
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-foo1: <value1> #自定义meta：foo1
x-amz-meta-foo2: <value2> #自定义meta：foo2

#文件内容
<BODY>
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
            <td>Range</td>
            <td>
            	Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Modified-Since</td>
            <td>
            	Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Unmodified-Since</td>
            <td>
            	Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is the same as the one specified; otherwise, return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>If-None-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is different from the one specified; otherwise, return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr> 
                    
        </tbody>
</table>

 - Response Headers（响应头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Content-Type</td>
            <td>Object的mime-type</td>
		  </tr>
		  <tr>
            <td>Content-Length</td>
            <td>Object的Size(bytes)</td>
		  </tr>
		  <tr>
            <td>ETag</td>
            <td>Object的hash值，一般是md5值</td>
		  </tr>
		  <tr>
            <td>Last-Modified</td>
            <td>Object的最后修改时间</td>
		  </tr>
		  <tr>
            <td>x-amz-meta-*</td>
            <td>用户可自定义文件属性信息，读取时原值返回。<br>
            例如：<br>
            x-amz-meta-UploadLocation: My Home<br>
            X-amz-meta-ReviewedBy: test@test.net<br>
            X-amz-meta-FileChecksum: 0x02661779<br>
            X-amz-meta-CheckSumAlgorithm: crc32<br>
            </td>
		  </tr>
		  <tr>
            <td>x-amz-meta-crc32</td>
            <td>Object的CRC32值</td>
		  </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -H "Range: bytes=0-1024" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/<Object-Name>"
```

 - 应用举例：
 
	- 标准示例：
  
```http
GET /my_bucket/path/to/my/file.txt HTTP/1.1
Host: ss.bscstorage.com
Date: Sun, 1 Jan 2006 12:00:00 GMT
Authorization: AWS AccessKey:ssig
Range: bytes=100-2048
```

	-	响应：
  
```http
HTTP/1.1 206 Partial Content
Server: openresty/1.9.7.4
Content-Type: application/xml
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: GRPS000000ANONYMOUSE
Date: Mon, 08 Aug 2016 02:46:21 GMT
Last-Modified: Mon, 08 Aug 2016 02:45:55 GMT
ETag: "21b1a992d1cbf49729fc4461e55dd94f"
x-amz-meta-s2-size: 109051904
x-amz-meta-s2-crc32: 9422bc32
Cache-Control: max-age=31536000
Content-Length: 109051904

...
file_content
...

```

* 使用各种验证措施的下载方式：

```http
GET /path/to/my/file.txt?AWSAccessKeyId=<AccessKey>&Expires=<1175139620>&Signature=<your_sign> HTTP/1.1
Host: my_bucket.ss.bscstorage.com
Date: date
Range: bytes=byte_range
```

  * 响应：

```http
HTTP/1.1 206 Partial Content
Server: openresty/1.9.7.4
Content-Type: application/xml
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: GRPS000000ANONYMOUSE
Date: Mon, 08 Aug 2016 02:46:21 GMT
Last-Modified: Mon, 08 Aug 2016 02:45:55 GMT
ETag: "21b1a992d1cbf49729fc4461e55dd94f"
x-amz-meta-s2-size: 109051904
x-amz-meta-s2-crc32: 9422bc32
Cache-Control: max-age=31536000
Content-Length: 109051904

...
file_content
...

```

***以上示例中QueryString的含义请参照[《签名算法》][1]中的关于 认证方式 的说明。***
