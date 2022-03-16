### PUT Object - Copy

- Description: create an object by copying (copy another file in the system instead of uploading specific file content).
- Request format:：

```http
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
x-amz-copy-source: </source-bucket/source-object>
Authorization: <authorization string> #Please refer to signature algorithm
```

- response：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<MD5 value of file>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CopyObjectResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <LastModified>Mon, 08 Aug 2016 05:04:10 GMT</LastModified>
    <ETag>870c06c00566c4fb1861bb10f34d1904</ETag>
</CopyObjectResult>
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
            <td>x-amz-copy-source</td>
            <td>
            	The address of the file to be copied. Format: / source bucket / source object. urlencode the whole.
            </td>
            <td>Yes</td>
          </tr>     
          <tr>
            <td>Cache-Control</td>
            <td>
            	File cache, standard HTTP protocol. For more information, see:http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>      
          <tr>
            <td>Expires</td>
            <td>
            	The cache expiration time of the file in the client or browser allows the client not to check the server before this time, and the original value is returned when reading. Format is：Sun, 29 Jul 2018 20:36:14 UTC
            </td>
            <td>No</td>
          </tr>          
          <tr>
            <td>Content-Type</td>
            <td>
            	File mime type. The original value is returned when reading
            </td>
            <td>No</td>
          </tr>        
          <tr>
            <td>Content-Length</td>
            <td>
            	must be 0
            </td>
            <td>=0</td>
          </tr>                           
          <tr>
            <td>Content-Disposition</td>
            <td>
            	HTTP standard file attribute information. The original value is returned when reading. See：http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
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
          <tr>
            <td>x-amz-copy-source-if-match</td>
            <td>
            	If the specified Etag matches the Etag of the source file, the source file can be copied, otherwise 412 is returned(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>              
          <tr>
            <td>x-amz-copy-source-if-nonematch</td>
            <td>
            	If the specified Etag does not match the Etag of the source file, the source file can be copied, otherwise 412 is returned(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>           
          <tr>
            <td>x-amz-copy-source-if-unmodified-since</td>
            <td>
            	If the source file has not been modified since the specified time, you can copy the source file; otherwise, return412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>            
          <tr>
            <td>x-amz-copy-source-if-modified-since</td>
            <td>
            	If the source file has been modified since the specified time, you can copy the source file, otherwise return412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>

 - Response Body（Response XML Body）：
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
            	Contains Etag and LastModified elements
            </td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	File's ETag
            </td>
          </tr>
        
          <tr>
            <td>CopyObjectResult</td>
            <td>
            	Last modification time of the file
            </td>
          </tr>
        </tbody>
</table>

- Request example:
```
curl -v -X PUT -H "x-amz-copy-source: /bucket-123/path/to/file123.txt" -H "Date:

Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access\_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/myfile.txt"
```
