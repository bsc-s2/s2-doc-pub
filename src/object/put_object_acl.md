### PUT Object ACL

 - 描述：给指定Object设置ACL规则。更多信息请参照：[《ACL》](../acl/acl.md)

 - 请求格式：

```http
PUT /<ObjectName>?acl HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》

#ACL规则: XML or Json
{
    "Baishan0000000000000001" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS000000ANONYMOUSE" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS0000000CANONICAL" :  [ "read", "read_acp" , "write", "write_acp" ]
}
```

 - Request Headers（请求头）：

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
            <td>
            	文件ACL：请参照《ACL》
            </td>
            <td>No</td>
          </tr>
        </tbody>
</table>

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
```

 - Request Body（请求Body）：
XML or JSon format acl body

Note: 假如指定了x-amz-acl header将忽略body中acl, body中的xml格式由请求参数formatter参数决定, 默认为XML

 - Response（无HTTP Body）：

 - 请求格式说明请参照：[《ACL》](../acl/acl.md)

 - 请求示例：

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization:
AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt"
```
