### PUT Bucket ACL

 - 描述：给指定Bucket设置ACL规则。更多信息请参照：[《ACL》][2]

 - 请求格式：

```http
PUT /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》

#ACL规则
{
	'Baishan0000000000000001' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS000000ANONYMOUSE' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS0000000CANONICAL' :  [ "read", "read_acp" , "write", "write_acp" ],
}

```

 - 响应：

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

 - 请求格式说明请参照：[《ACL》][2]
 - 请求示例：

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&formatter=json"
```
