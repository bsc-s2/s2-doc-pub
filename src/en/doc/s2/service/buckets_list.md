### GET Service (List Buckets)

- Description: get the list of all buckets under the current owner.
  
- Request Syntax

```http
GET /?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> # Please refer to ‘Signature algorithm’
```

or

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Request Syntax（HTTP Body）：

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

- Return value Description:

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
            <td>owner</td>
          </tr>

          <tr>
            <td>DisplayName</td>
            <td>Display name of the owner</td>
          </tr>

          <tr>
            <td>ID</td>
            <td>Owner's UserId</td>
          </tr>

          <tr>
            <td>Buckets</td>
            <td>Containers for multiple buckets</td>
          </tr>

          <tr>
            <td>Bucket</td>
            <td>Bucket container for information</td>
          </tr>

          <tr>
            <td>CreationDate</td>
            <td>Current bucket creation date</td>
          </tr>

          <tr>
            <td>Name</td>
            <td>Bucket name</td>
          </tr>

        </tbody>
</table>

- Request example:

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://ss.bscstorage.com/?formatter=json"
```

or

```
curl -v "http://ss.bscstorage.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

- Request example：

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
