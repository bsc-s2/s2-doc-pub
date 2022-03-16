### GET Object

- Description: get an object (download).
  
- Request format:
 
```http
GET /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
Range: bytes=<byte_range> #Support breakpoint Download
```

- Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
Content-Type: <object-mime-type>
Content-Length: <object-file-bytes>
ETag: "<MD5 value of file>"
Last-Modified: <Last modification time>
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-foo1: <value1> #Custom meta: foo1
x-amz-meta-foo2: <value2> #Custom meta: foo2

#File content
<BODY>
```

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

 - Response Headers：

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
            <td>Object's mime-type</td>
		  </tr>
		  <tr>
            <td>Content-Length</td>
            <td>Object's size(bytes)</td>
		  </tr>
		  <tr>
            <td>ETag</td>
            <td>Object's hash value，normally it is md5</td>
		  </tr>
		  <tr>
            <td>Last-Modified</td>
            <td>Object's last modified time</td>
		  </tr>
		  <tr>
            <td>x-amz-meta-*</td>
            <td>You can customize the file attribute information and return the original value when reading.<br>
            For example：<br>
            x-amz-meta-UploadLocation: My Home<br>
            X-amz-meta-ReviewedBy: test@test.net<br>
            X-amz-meta-FileChecksum: 0x02661779<br>
            X-amz-meta-CheckSumAlgorithm: crc32<br>
            </td>
		  </tr>
		  <tr>
            <td>x-amz-meta-crc32</td>
            <td>Object's CRC32 value</td>
		  </tr>
        </tbody>
</table>

- Request example:

```
curl -v -H "Range: bytes=0-1024" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/<Object-Name>"
```

- Application examples:
  
- Standard example:
  
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

- Download methods using various verification measures:

```http
GET /path/to/my/file.txt?AWSAccessKeyId=<AccessKey>&Expires=<1175139620>&Signature=<your_sign> HTTP/1.1
Host: my_bucket.ss.bscstorage.com
Date: date
Range: bytes=byte_range
```

- Response:

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

***For the meaning of QueryString in the above example, please refer to the description of authentication method in [signature algorithm] [1].***
