### GET Service (List Buckets)

 - 描述：获得当前Owner下所有Bucket的列表。

 - 请求格式：

```http
GET /?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应格式（HTTP Body）：

```json
{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000001234567890"
    },

    "Buckets": {
        "Bucket": [
            {
                "CreationDate": "Fri, 21 Mar 2014 01:13:42 UTC",
                "Name": "bucket_name_0"
            },
            {
                "CreationDate": "Fri, 12 Mar 2013 02:25:22 UTC",
                "Name": "bucket_name_1"
            },

            ...
        ]
    }
}
```

 - 返回值说明：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>Owner</td>
            <td>所有者</td>
          </tr>

          <tr>
            <td>DisplayName</td>
            <td>所有者的显示名字</td>
          </tr>

          <tr>
            <td>ID</td>
            <td>所有者的UserId</td>
          </tr>

          <tr>
            <td>Buckets</td>
            <td>多个Buckets的容器</td>
          </tr>

          <tr>
            <td>Bucket</td>
            <td>Bucket信息的容器</td>
          </tr>

          <tr>
            <td>CreationDate</td>
            <td>当前Bucket创建时间</td>
          </tr>

          <tr>
            <td>Name</td>
            <td>Bucket名称</td>
          </tr>

        </tbody>
</table>

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://ss.bscstorage.com/?formatter=json"
```

或者

```
curl -v "http://ss.bscstorage.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

 - 响应示例：

```http
HTTP/1.1 200 OK
Server: openresty/1.9.7.4
Date: Mon, 08 Aug 2016 04:04:52 GMT
Content-Type: application/json
Connection: keep-alive
Content-Length: 155
x-amz-s2-requester: your user id
x-amz-request-id: 000011e5-1608-0812-0452-00163e0069ec

{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000001234567890"
    },
    "Buckets": {
        "Bucket": [
            {
                "CreationDate": "Mon, 08 Aug 2016 03:15:40 UTC",
                "Name": "bucket_name_0"
            },
            {
                "CreationDate": "Mon, 08 Aug 2016 03:15:40 UTC",
                "Name": "bucket_name_1"
            },

         ...
        ]
    }
}
```
