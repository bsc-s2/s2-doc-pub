
## Signature algorithm

- If the HTTP request does not carry the identity information (AccessKey), the request will be changed to an anonymous request, which will be considered by an anonymous user.
- If the identity information is carried in the HTTP request (AccessKey), the request will be considered by the user who is corresponding to the access Key. Since the AccessKey can be obtained by others, in order to prevent others from using your accessKey to access the service, your signature must also be carried in the request. After applying for an account, you will get the AccessKey and Secret key, which need to be kept confidential. The signature will be calculated by the HTTP request Information and your secret key so that others do not know your secret key, they will not be able to calculate the correct signature.
- The identity information and signature can be put in the request header （Authorization）or in the request parameters.
- The signature method is compatible with Amazon S3 and supports signature version 2 and signature version 4.

## Add Signature
> Since the process of calculating the signature is cumbersome and error-prone, it is not recommended to calculate the signature by yourself. It is recommended to use the SDKs. The SDK can automatically calculate the signature.

### Add version 2 Signature

#### Carrying method of identity information and signature:

##### Request header via Authorization:

Request header format:


```
Authorization: AWS AWSAccessKeyId:Signature
```

- AWSAccessKeyId: your AccessKey
- Signature: calculated signature

```
Authorization: AWS ziw5dp1alvty9n47qksu:frJIUN8DYpKDtOLCwo//yllqDzg=
```

##### Request parameters:

You need to include the following three parameters in the request:

- Awsaccesskeyid: To specify your AccessKey
- Signature: calculated signature
- Expires: Specifies the expiration time of the signature

Example:

```
GET /yourbucket/yourkey?AWSAccessKeyId=ziw5dp1alvty9n47qksu&Expires=1141889120&Signature=vjbyPxybdZaNmGa%2ByT272YEAiv4%3D
```

#### Signature calculation method
```
Signature = Base64( HMAC-SHA1( YourSecretKey, UTF-8-Encoding-Of( StringToSign ) ) )

StringToSign = HTTP-Verb + "\n" +

Content-MD5 + "\n" +

Content-Type + "\n" +

Date|Expires + "\n" +

CanonicalizedAmzHeaders +

CanonicalizedResource
```

- Yoursecretkey: To fill in it with your Secretkey
- HTTP-Verb: The request method, such as PUT, GET, DELETE, POST
- Content-MD5: The request header of the content-MD5. If there is no such header, please fill in it with an empty string
- Content-Type: The request header of the content-Type. If there is no such header, please fill in it with an empty string
- Date|Expires: If the Authorization header is used to be as the content of the Date header. please fill in it with an empty string when there is no the Date Header. If the request parameter is used to carry the signature information, it will be the content of the Expires.
- CanonicalizedAmzHeaders: The string composed of all headers starting with x-amz - in the request. If there is no such header, please fill in it with an empty string.
- CanonicalizedResource: The Resource which is corresponding to the request.

Example of calculating the Canonicalizedamzheaders:

Original request header:

```
Date: Tue, 27 Mar 2007 19:36:42 +0000
X-Amz-b:   Bar
x-amz-a: foob
x-Amz-a:   fooa
Host: johnsmith.s3.amazonaws.com

The corresponding CanonicalizedAmzHeaders is：
x-amz-a:fooa,foob
x-amz-b:Bar
```


> Note:
> 1. All the request header names are converted to lowercase and sorted by the converted header name. 2. If the duplicate headers appeared, please merge them, such as separating the value by commas and sorting them. 3. Remove the spaces before and after the value.

Example of calculating Canonicalizedresource:

```
GET /?foo=bar

GET /yourbucket/yourkey?foo=bar

GET /yourbucket/yourkey?acl&foo=bar

The corresponding nicalizedresources are:

／

/yourbucket/yourkey

/yourbucket/yourkey?acl

```

If you want to know the completed signature calculation process, please refer to the following links:

- <http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html>
- <http://docs.aws.amazon.com/general/latest/gr/signature-version-2.html>

### Add version 4 Signature:

#### Carrying method of identity information and signature:

##### Through the Authorization header:

example:


```
Authorization:AWS4HMACSHA256Credential=ziw5dp1alvty9n47qksu/20160830/useast-1/s3/aws4\_request, SignedHeaders=content-type;host;xamzdate,Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7

```

- Credential consists of AccessKey, the requested date, region, service name, and aws4\_ Request, which is separated by slashes
- SignedHeaders: Indicates which header participates in the calculation of the signature. Headers not included here will not affect the generation of the signature
- Signature: Calculated signature

##### Through request parameters:

The following parameters need to be added to the request:

- X-Amz-Algorithm: The hash algorithm used to calculate the signature which is AWS4-HMAC-SHA256
- X-Amz-Credential: It contains the information of AccessKey, date, region, and service name
- X-Amz-Date: Requested time
- X-Amz-Expires: Specify the expired time of the signature
- X-Amz-SignedHeaders: The header which is used to calculate the signature
- X-Amz-Signature: Calculated signature

Example:

```
GET /yourbucket/test.mp4??X-Amz-Algorithm=AWS4-HMAC-SHA256&&X-Amz-Credential=ziw5dp1alvty9n47qksu/20160830/us-east-1/s3/aws4\_request&X-Amz-Date=20160830T201207Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7

```

#### Signature calculation method:

Calculate CanonicalRequest

```
CanonicalRequest =

HTTPRequestMethod + '\n' +

CanonicalURI + '\n' +

CanonicalQueryString + '\n' +

CanonicalHeaders + '\n' +

SignedHeaders + '\n' +

HexEncode(Hash(RequestPayload))
```

- HTTPRequestMethod: PUT, GET, DELETE, POST
- CanonicalURI: Requested URI
- CanonicalQueryString: The string formed after sorting the request parameters
- CanonicalHeaders: The string formed after sorting the header needs to be added to the signature calculation
- SignedHeaders：A list of names added to the header of the signature calculation, separated by commas
- HexEncode(Hash(RequestPayload))： The hexadecimal encoding of the hash of the request body. If the signature is carried through the request parameters, the string unsigned-payload should be used instead

Calculate StringToSign

```
StringToSign  =

Algorithm + '\n' +

RequestDate + '\n' +

CredentialScope + '\n' +

HashedCanonicalRequest
```

- Algorithm: AWS4-HMAC-SHA256
- RequestDate: ISO8601 basic Request time in format, e.g:20160830T123600Z
- CredentialScope: A string consisting of date, region, service name, etc., such as 20160830/us-east-1/s3/aws4\_request
- HashedCanonicalRequest: Hex(SHA256Hash(CanonicalRequest)), That is, the hexadecimal encoding of the hash of canonicalrequest

Calculation signing key

```
kSecret = YourSecretKey
kDate = HMAC("AWS4" + kSecret, Date)
kRegion = HMAC(kDate, Region)
kService = HMAC(kRegion, Service)
kSigning = HMAC(kService, "aws4\_request")
```

- YourSecretKey: your SecretKey
- Date：The 8-digit date should be the same as the date part in credentail
- Region：It should be the same as the region section in credential
- Service: It should be the same as the service name part in credential

Calculate signature
```
signature = HexEncode(HMAC-SHA256(kSigning, StringToSign))
```
If you want to know the complete and detailed signature calculation process, please refer to the following connection:

- <http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html>
- <http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html>





