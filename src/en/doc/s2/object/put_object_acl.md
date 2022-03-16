### PUT Object ACL

- Description: sets ACL rules for the specified Object. For more information, please refer to：[《ACL》](../acl/acl.md)

- Request format:


```http
PUT /<ObjectName>?acl HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm

#ACL规则: XML or Json
{
    "Baishan0000000000000001" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS000000ANONYMOUSE" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS0000000CANONICAL" :  [ "read", "read_acp" , "write", "write_acp" ]
}
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
            <td>x-amz-acl</td>
            <td>
            	File ACL: please refer to 《ACL》
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

Note: If x-amz-acl is specified, the header will ignore the ACL in the body. The XML format in the body is determined by the request parameter formatter parameter, and the default is XML

 - Response（no HTTP Body）：

 - Please refer to：[《ACL》](../acl/acl.md)

 - Request example：

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization:
AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/path/to/my/file.txt"
```
