### PUT Bucket

 - 描述：创建一个Bucket。

 - 请求格式：

```http
PUT /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
x-amz-acl: <Canned-ACL> #请参照《ACL》
```

或者

```http
PUT /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
x-amz-acl: <Canned-ACL> #请参照《ACL》
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
            <td>创建Bucket的同时，设置一个ACL。请参照：<a href="http://open.baishanstorage.com/?c=doc&a=guide&section=acl">《ACL》</a></td>
            <td>No</td>
          </tr>
                    
        </tbody>
    </table>

 - 响应（无HTTP Body）：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

 - 请求示例：

```
curl -v -X PUT -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?formatter=json"
```

或者

```
curl -v -X PUT "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v -X PUT "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
