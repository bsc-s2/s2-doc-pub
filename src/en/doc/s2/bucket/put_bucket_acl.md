### PUT Bucket ACL

 - Description: sets ACL rules for the specified Bucket. For more information, please refer to：[《ACL》](../acl/acl.md)

- Request Syntax:

```http
PUT /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm

#ACL规则
{
	'Baishan0000000000000001' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS000000ANONYMOUSE' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS0000000CANONICAL' :  [ "read", "read_acp" , "write", "write_acp" ],
}

```

- Response:

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
{
    "Owner": {
        "DisplayName": "",
        "ID": "user_authed"
    },
    "AccessControlList": {
        "Grant": [
            {
                "Grantee": {
                    "DisplayName": "",
                     "ID": "Baishan0000000000000001"
                },
                "Permission": "READ,READ_ACP,WRITE,WRITE_ACP"
            },

            ...
        ]
    }
}
```

 - Please refer to：[《ACL》](../acl/acl.md)
 - Request example:

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/?acl&formatter=json"
```
