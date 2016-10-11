### DELETE Bucket

 - 描述：删除指定Bucket。

 - 注意：不能删除非空Bucket。

 - 请求格式：

```http
DELETE /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
DELETE /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应（无HTTP Body）：

```http
HTTP/1.1 204 No Content
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

 - 请求示例：

```
curl -v -X DELETE -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?formatter=json"
```

或者

```
curl -v -X DELETE "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v -X DELETE "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```
