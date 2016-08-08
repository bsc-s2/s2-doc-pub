### GET Object ACL

 - 描述：获得指定Object的ACL信息。更多信息请参照：[《ACL》][2]

 - 请求格式：

```http
GET /<ObjectName>?acl HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 123
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

Json format:
Note: You can specify the XML with formatter request parameter
{
    "Owner": "Baishan0000000000000001",
    
    "ACL": {
    
        "GRPS000000ANONYMOUSE": [
        
        	"read"
        ],
    
        "Baishan0000001001NHT3M7": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "Baishan0000000000000001": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "Baishan0000001001HBK3UT": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "GRPS0000000CANONICAL": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
        
        ...
    }
}
```

 - 响应格式说明请参照：[《ACL》][2]

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt?acl"
```
