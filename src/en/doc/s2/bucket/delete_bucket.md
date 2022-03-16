### DELETE Bucket

- Description: delete the specified Bucket.
  
- Note: Cannot delete the non-empty Bucket.
  
- Request Syntax:

```http
DELETE /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

or

```http
DELETE /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Response (no HTTP body)：

```http
HTTP/1.1 204 No Content
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

- Request example:

```
curl -v -X DELETE -H “Date: Sat, 20 Nov 2286 17:46:39 GMT” -H “Authorization: Baishan <access\_key>:<ssig>” “http://<Your-Bucket-Name>.ss.bscstorage.com/?formatter=json”
```

or

```
curl -v -X DELETE "http://<Your-Bucket-Name>.ss.bscstorage.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

or

```
curl -v -X DELETE "http://ss.bscstorage.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
