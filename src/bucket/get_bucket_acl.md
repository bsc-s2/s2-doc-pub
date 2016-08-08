### GET Bucket ACL

 - 描述：获得指定Bucket的ACL信息。更多信息请参照：[《ACL》][2]

 - 请求格式：

```http
GET /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?acl&formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

响应：

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

 - 响应格式说明请参照：[《ACL》][2]

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&formatter=json"
```

或者

```
curl -v "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
