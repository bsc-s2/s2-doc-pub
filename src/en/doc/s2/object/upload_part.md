### Upload Part

- Description: upload slice interface
  
- Request format:

```http
PUT /<ObjectName>?partNumber=<PartNumber>&uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Content-Length: <Content-Length>
Content-MD5: <Content-MD5>
Authorization: <authorization string> #Please refer to signature algorithm

...
file_content
...

```

- Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
Etag: <Etag>
```

- Request Parameters：

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
            <td>The serial number of the document slice, starting from 1</td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>uploadId</td>
            <td>Uploadid value obtained through Initiate Multipart Upload (large file fragment upload initialization interface)</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
    </table>

- Request Heades：

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
            <td>File size, original value returned when reading</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Content-MD5</td>
            <td>Base64 encoded file MD5 (fail when inconsistent with the transmitted content). Note: the string format is the value encoded by Base64 in RFC standard</td>
            <td>No</td>
          </tr>
        </tbody>
    </table>

- Attention：
  - The number of slices cannot exceed 2000.
