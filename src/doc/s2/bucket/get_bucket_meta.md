### GET Bucket - Meta

 - 描述：获取一个Bucket的meta信息。

 - 请求格式：

```http
GET /?meta&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
Content-Length: 1234
Content-Type: application/json
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId

{
	DeleteQuantity: 71,
	
	Capacity: 2843723,
	
	ACL: {
	
		GRPS000000ANONYMOUSE: ["read"],
		
		GRPS0000000CANONICAL: [ ],
		
		Baishan0000001001HBK3UT: ["read", "write", "read_acp", "write_acp"]
	},
		
	ProjectID: 4241,
	
	DownloadQuantity: 93,
	
	DownloadCapacity: 27365564,
		
	CapacityC: 0,
	
	QuantityC: 0,
	
	Project: "Your-Bucket-Name",
	
	UploadCapacity: 9112891,
	
	UploadQuantity: 80,
	
	Last-Modified: "Wed, 16 Apr 2014 13:49:38 UTC",
	
	SizeC: 0,
	
	Owner: "Baishan0000001001HBK3UT",
	
	DeleteCapacity: 6269168,
	
	Quantity: 9
}
```

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.ss.bscstorage.com/?meta&formatter=json"
```
