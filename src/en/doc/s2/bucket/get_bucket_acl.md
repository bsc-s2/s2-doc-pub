### GET Bucket ACL

- Description: get ACL information of the specified bucket. For more information, please refer to:[《ACL》](https://doc.bscstorage.com/doc/s2/bucket/\(../acl/acl.md))

- Request format:

```http
GET /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

or

```http
GET /<Your-Bucket-Name>/?acl&formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 123
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId

{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000000000000001"
    },

    "AccessControlList": {
        "Grant": [
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "GRPS000000ANONYMOUSE"
                },
                "Permission": "READ"
            },
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "Baishan0000001001NHT3M7"
                },
                "Permission": "READ, READ_ACP, WRITE, WRITE_ACP"
            },
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "Baishan0000000000000001"
                },
                "Permission": "READ, WRITE"
            },

            ...
        ]
    }
}
```

- Please refer to：[《ACL》]((../acl/acl.md))

- Request example：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/?acl&formatter=json"
```

or

```
curl -v "http://<Your-Bucket-Name>.ss.bscstorage.com/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

or

```
curl -v "http://ss.bscstorage.com/<Your-Bucket-Name>/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
