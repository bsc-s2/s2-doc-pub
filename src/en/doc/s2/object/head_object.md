
### HEAD Object

- Description: use the HEAD request method to obtain the Metadata of the Object.
  
- Request format:

```http
HEAD /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Response（No HTTP body）：

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
x-amz-meta-foo1: <value1> #custom meta：foo1
x-amz-meta-foo2: <value2> #custom meta：foo2
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
            <td>Object's Size(bytes)</td>
		  </tr>
		  <tr>
            <td>ETag</td>
            <td>Object's hash value，normally is md5 value</td>
		  </tr>
		  <tr>
            <td>Last-Modified</td>
            <td>Object last modified time</td>
		  </tr>
		  <tr>
            <td>x-amz-meta-*</td>
            <td>User can customize file property information, return value when read<br>
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
curl -v -X HEAD -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/<Object-Name>"
```
