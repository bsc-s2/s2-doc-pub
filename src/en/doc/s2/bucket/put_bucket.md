### PUT Bucket

- Description: create a bucket.
  
- Request Syntax

```http
PUT /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
x-amz-acl: <Canned-ACL> #Please refer to[《ACL》](path: ../acl/acl.md)
```

or

```http
PUT /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
x-amz-acl: <Canned-ACL> #Please refer to[《ACL》](path: ../acl/acl.md)
```

- Request Header（请求头）：

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
            <td>x-amz-acl</td>
            <td>Set an ACL while creating a bucket. Please refer to ACL
            <td>No</td>
          </tr>
                    
        </tbody>
    </table>

- Response (no HTTP body)：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

- Request example:

```
curl -v -X PUT -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/?formatter=json"
```

or

```
curl -v -X PUT "http://<Your-Bucket-Name>.ss.bscstorage.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

or

```
curl -v -X PUT "http://ss.bscstorage.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
