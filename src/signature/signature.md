
## 签名简介

- 如果http请求中没有携带身份信息（AccessKey），则改该请求为匿名请求，会被认为是来自匿名用户的访问。

- 如果http请求中携带了身份信息（AccessKey），则认为访问来自该AccessKey所对应的用户。由于AccessKey是可以被他人获取到的，
为了防止其他人冒用您的AccessKey来访问服务，请求中还必须携带您的签名。在申请帐号以后，您将得到AccessKey和SecretKey，
SecretKey是需要保密的。签名是由此次http请求的相关信息和您的SecretKey计算得到的，其他人因为不知道您的SecretKey，将不能
计算出正确的签名。

- 身份信息与签名可以放到请求头（Authorization）中，也可以放到请求参数中。

- 签名的方式与Amazon S3的签名方式兼容，支持signature version 2 和 signature version 4。

## 添加签名

> 由于计算签名的过程比较繁琐且容易出错，不建议自己计算签名，推荐使用[SDKs]('https://aws.amazon.com/tools/')，SDK可以自动为请求计算签名。

### 添加version 2 签名

#### 身份信息与签名的携带方式：

##### 通过Authorization请求头：

请求头格式：

```
Authorization: AWS AWSAccessKeyId:Signature
```

- AWSAccessKeyId: 您的AccessKey

- Signature: 计算得到的签名

例子：

```
Authorization: AWS ziw5dp1alvty9n47qksu:frJIUN8DYpKDtOLCwo//yllqDzg=
```

##### 通过请求参数：

需要在请求中包含以下三个参数：

- AWSAccessKeyId：指定您的AccessKey

- Signature：计算得到的签名

- Expires：指定签名的过期时间

例子：

```
GET /yourbucket/yourkey?AWSAccessKeyId=ziw5dp1alvty9n47qksu&Expires=1141889120&Signature=vjbyPxybdZaNmGa%2ByT272YEAiv4%3D
```

#### 签名的计算方法：

```
Signature = Base64( HMAC-SHA1( YourSecretKey, UTF-8-Encoding-Of( StringToSign ) ) )

StringToSign = HTTP-Verb + "\n" +
	Content-MD5 + "\n" +
	Content-Type + "\n" +
	Date|Expires + "\n" +
	CanonicalizedAmzHeaders +
	CanonicalizedResource
```

- YourSecretKey: 您的SecretKey

- HTTP-Verb: 请求的方法，如：`PUT`，`GET`，`DELETE`，`POST`

- Content-MD5: 请求头Content-MD5的内容，如果没有这个头，由空字符串代替

- Content-Type: 请求头Content-Type的内容，如果没有这个头，由空字符串代替

- Date|Expires: 如果使用Authorization头携带签名信息，为Date头的内容，如果没有Date头，由空字符串代替；如果使用请求参数携带签名信息，为参数Expires的内容

- CanonicalizedAmzHeaders: 请求中所有以x-amz-开始的头所组成的字符串,如果没有这样的头，由空字符串代替

- CanonicalizedResource: 请求所对应的资源

计算CanonicalizedAmzHeaders的例子：

```
原始请求头：
Date: Tue, 27 Mar 2007 19:36:42 +0000
X-Amz-b:   Bar
x-amz-a: foob
x-Amz-a:   fooa
Host: johnsmith.s3.amazonaws.com

对应的CanonicalizedAmzHeaders为：
x-amz-a:fooa,foob
x-amz-b:Bar
```

> 注意：
> 1.请求头的名字全部转换为小写，按转换后的头名字排序。2，如果出现重复的头，需要合并，各个值之间用逗号分隔，并排序。3，去掉值前后的空格。

计算CanonicalizedResource的例子：

```
GET /?foo=bar
GET /yourbucket/yourkey?foo=bar
GET /yourbucket/yourkey?acl&foo=bar

对应的nicalizedResource分别为：

／
/yourbucket/yourkey
/yourbucket/yourkey?acl
```

如果您需要了解完整和详细的签名计算过程，请参考以下连接：

- [http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html](http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html)
- [http://docs.aws.amazon.com/general/latest/gr/signature-version-2.html](http://docs.aws.amazon.com/general/latest/gr/signature-version-2.html)

###  添加version 4 签名：

#### 身份信息与签名的携带方式：

##### 通过Authorization头：

例子：

```
Authorization: AWS4-HMAC-SHA256 Credential=ziw5dp1alvty9n47qksu/20160830/us-east-1/s3/aws4_request, SignedHeaders=content-type;host;x-amz-date, Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7
```

- Credential由AccessKey，请求的日期，region，服务名，`aws4_request`五部分组成，各部分之间用斜线分隔

- SignedHeaders: 表示那些头参与了签名的计算，未包含在这里的头不会影响到签名的生成

- Signature: 计算得到的签名

##### 通过请求参数：

需要在请求中加入以下参数：

- X-Amz-Algorithm: 计算签名时使用的Hash算法，指定为`AWS4-HMAC-SHA256`

- X-Amz-Credential: 包含了AccessKey，日期，region，服务名的信息

- X-Amz-Date: 请求的时间

- X-Amz-Expires: 指定签名在多长时间内有效

- X-Amz-SignedHeaders: 计算签名时用到的头

- X-Amz-Signature: 计算得的到签名

例子：

```
GET /yourbucket/test.mp4??X-Amz-Algorithm=AWS4-HMAC-SHA256&&X-Amz-Credential=ziw5dp1alvty9n47qksu/20160830/us-east-1/s3/aws4_request&X-Amz-Date=20160830T201207Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7
```

#### 签名的计算方法：

计算CanonicalRequest

```
CanonicalRequest =
    HTTPRequestMethod + '\n' +
    CanonicalURI + '\n' +
    CanonicalQueryString + '\n' +
    CanonicalHeaders + '\n' +
    SignedHeaders + '\n' +
    HexEncode(Hash(RequestPayload))
```

- HTTPRequestMethod: 如`PUT`, `GET`, `DELETE`, `POST`

- CanonicalURI: 请求的uri

- CanonicalQueryString: 请求参数排序后组成的字符串

- CanonicalHeaders: 需要加入签名计算的头排序后组成的字符串

- SignedHeaders：加入到签名计算的头的名字的列表，各个名字之间用逗号分隔

- HexEncode(Hash(RequestPayload))：请求body的hash的16进制编码,如果通过请求参数携带签名，此处应由字符串`UNSIGNED-PAYLOAD`代替

计算StringToSign

```
StringToSign  =
    Algorithm + '\n' +
    RequestDate + '\n' +
    CredentialScope + '\n' +
    HashedCanonicalRequest
```

- Algorithm: 指定为`AWS4-HMAC-SHA256`

- RequestDate: ISO8601 basic 格式的请求时间，如：20160830T123600Z

- CredentialScope: 日期，region，服务名等组成的字符串， 如：20160830/us-east-1/s3/aws4_request

- HashedCanonicalRequest: Hex(SHA256Hash(CanonicalRequest)),即CanonicalRequest的hash的16进制编码

计算signing key

```
kSecret = YourSecretKey
kDate = HMAC("AWS4" + kSecret, Date)
kRegion = HMAC(kDate, Region)
kService = HMAC(kRegion, Service)
kSigning = HMAC(kService, "aws4_request")
```

- YourSecretKey: 您的SecretKey

- Date：8位数的日期，应与Credentail中的Date部分一样

- Region： 应与Credential中的region部分一样

- Service: 应与Credential中的服务名部分一样

- kSigning即为用于计算签名的signing key

计算签名

```
signature = HexEncode(HMAC-SHA256(kSigning, StringToSign))
```

如果您需要了解完整和详细的签名计算过程，请参考以下连接

- [http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html](http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html)
- [http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html)
