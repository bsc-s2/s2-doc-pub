### APPEND Object
---
- Append Object Files can be uploaded by adding write. The added files can be files uploaded in any way in the bucket (except fragment files uploaded in fragments), such as put object, copy object, and files uploaded in fragments and merged.

    The append upload and put object interfaces are consistent, except for the following two points：
    
    - x-amz-meta-s2-append-position Request header, required, used to identify the location of append upload and upload files appended to the current file
    - When the value of position is 0, if the currently appended file does not exist or the size of the file is equal to 0, the data will be appended to the end of the file and a success will be returned, otherwise a 409 error will be returned;
    - When the value of position is greater than 0, if it is equal to the size of the current file, it returns success after appending the data to the starting position of size, and the modification time of the modified file is the current time; Otherwise, a 409 error is returned, and the size of the current file is set in the x-amz-meta-append-position header of the response.
    - X-amz-meta-s2-directive request header, values: COPY, REPLACE ptional (COPY), used to identify whether the append file is the file meta information of the file to be overwritten
    
    Attention：
    
    - Only one request of the same position can be appended successfully, and due to concurrency, setting the correct position may also return failure
    - A maximum of 2000 requests can be appended to the same file
    - The maximum file size for a single request is 20G
    - The total size of the appended file is 1T at most


- Request format:

```
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Length: <object data length>
Content-Type: <mime-type>
x-amz-meta-s2-append-position: <position>
Authorization: <authorization string> #Please refer to signature algorithm
[object data]
```

Response:
```
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<MD5 value of file>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-s2-append-position: <position>
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
            <td>x-amz-meta-append-position</td>
            <td>
            	It is used to identify the location where append uploads and uploads are appended to the current file
            </td>
            <td>Yes</td>
          </tr>    
          <tr>
            <td>x-amz-meta-s2-directive</td>
            <td>
            	<p>Specifies whether to use the file meta of the attached file. The value is：COPY,REPALCE，The default is:COPY, If set to COPY，The file meta of the append file is used. If it is set to REPLACE, The file meta carried in the current append request is used </p><p></p>
            </td>
            <td>No</td>
          </tr>              
          <tr>
            <td>Expires</td>
            <td>
            	When the file expires, the system will automatically clear the file (not immediately, and the clearing time is irregular). Format reference：http://www.w3.org/Protocols/rfc2616/ rfc2616-sec14.html#sec14.21.
            </td>
            <td>No</td>
          </tr>               
          <tr>
            <td>Cache-Control</td>
            <td>
            	file Cache，Standard HTTP protocol. For more information, see:http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>            
          <tr>
            <td>Content-Type</td>
            <td>
            	File MIME type. The original value is returned when reading
            </td>
            <td>No</td>
          </tr>          
          <tr>
            <td>Content-Length</td>
            <td>
            	File size, original value returned when reading
            </td>
            <td>Yes</td>
          </tr>         
          <tr>
            <td>Content-MD5</td>
            <td>
            	Base64 encoded file MD5 (fail when inconsistent with the transmitted content). Note: the string format is the value encoded by Base64 in RFC standard
            </td>
            <td>No</td>
          </tr>      
          <tr>
            <td>Content-Disposition</td>
            <td>
            	HTTP standard file attribute information. The original value is returned when reading. See:http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
            </td>
            <td>No</td>
          </tr>     
          <tr>
            <td>Content-Encoding</td>
            <td>
            	File code, HTTP standard file attribute information, and the original value is returned when reading. See:http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
            </td>
            <td>No</td>
          </tr>  
          <tr>
            <td>x-amz-acl</td>
            <td>
            	File ACL: set an ACL while creating a file. Please refer to 《ACL》
            </td>
            <td>No</td>
          </tr>  
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	User defined metadeta. The header starts with x-amz-meta -, and all meta are stored in the form of key: value. The maximum limit is 64KB. It is returned as it is when HEAD or GET
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>
