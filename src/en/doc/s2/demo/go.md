## Go Demo

### Install the AWS Go SDK

```
go get -u github.com/aws/aws-sdk-go/...
```

### Initialization & Set the account information and the domain name

```go
package main

import "fmt"
import "time"
import "bytes"
import "os"
import "github.com/aws/aws-sdk-go/aws"
import "github.com/aws/aws-sdk-go/service/s3"
import "github.com/aws/aws-sdk-go/service/s3/s3manager"
import "github.com/aws/aws-sdk-go/aws/session"
import "github.com/aws/aws-sdk-go/aws/credentials"

var access_key = "ziw5dp1alvty9n47qksu" // please replace with your access_key
var secret_key = "V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV" //please replace with your secret_key
var token = ""
var end_point = "http://ss.bscstorage.com"

func main() {
    credential := credentials.NewStaticCredentials(access_key, secret_key, token)

    config := aws.NewConfig().WithRegion("us-east-1").
        WithEndpoint(end_point).
        WithCredentials(credential).WithS3ForcePathStyle(true)

    sess := session.New(config)
    svc := s3.New(sess)
    uploader := s3manager.NewUploader(sess)
    downloader := s3manager.NewDownloader(sess)
}
```


### File Operation API

#### File Upload

The permitted values of ACL are private, public-read, public-read-write, and authenticated-read.

```go
params := &s3.PutObjectInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
    ACL: aws.String("public-read"),
    ContentType: aws.String("image/jpeg"), //请替换为合适的文件类型
    Body: bytes.NewReader([]byte("bla bla")),
    Metadata: map[string]*string{
        "key-foo": aws.String("value-bar"),
    },
}

resp, err := svc.PutObject(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### Using the uploader interface to upload local file 

```go
f, err := os.Open("/root/test.txt")
if err != nil {
    fmt.Println("open file error")
    return
}

params := &s3manager.UploadInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
    Body: f,
}

result, err := uploader.Upload(params)
if err != nil {
    fmt.Println("upload file error")
    return
}
fmt.Printf("file uploaded to: %s\n", result.Location)
```

#### File Download

```go
params := &s3.GetObjectInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
}

resp, err := svc.GetObject(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
buf := new(bytes.Buffer)
buf.ReadFrom(resp.Body)
fmt.Println(buf.String())
```

#### Using the downloader interface to download the file 

```go
f, err := os.Create("/root/test.txt.download")
if err != nil {
    fmt.Println("create file error")
    return
}

params := &s3.GetObjectInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
}

n, err := downloader.Download(f, params)
if err != nil {
    fmt.Println("download file error")
    return
}
fmt.Printf("file download %d bytes\n", n)
```

#### Get File URL

Get the pre-signed URL to download the File, and the developer could set an expired time.

```go
params := &s3.GetObjectInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
}
req, _ := svc.GetObjectRequest(params)
url, _ := req.Presign(300 * time.Second) //300秒后过期
fmt.Println(url)
```

#### File Delete

```go
params := &s3.DeleteObjectInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
}
resp, err := svc.DeleteObject(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### Get File ACL

```go
params := &s3.GetObjectAclInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
}

resp, err := svc.GetObjectAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### Set File ACL

##### Using pre-defined ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 和 'authenticated-read'

```go
params := &s3.PutObjectAclInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),
    ACL: aws.String("private"),
}

resp, err := svc.PutObjectAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

##### Using Grant header to Set ACL

```go
params := &s3.PutObjectAclInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),

    GrantFullControl: aws.String("id=your_user_id"),
    GrantRead: aws.String("uri=\"http://acs.amazonaws.com/groups/global/AllUsers\""),
    GrantReadACP: aws.String("id=some_user_id, id=another_user_id"),
    GrantWrite: aws.String("uri=\"http://acs.amazonaws.com/groups/global/AuthenticatedUsers\""),
    GrantWriteACP: aws.String("emailAddress=\"some_email@some.com\", id=some_user_id"),
}

resp, err := svc.PutObjectAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

##### Using custom ACL

The permitted values of Permission are FULL_CONTROL, WRITE, WRITE_ACP, READ, and READ_ACP

```go
params := &s3.PutObjectAclInput{
    Bucket: aws.String("test-bucket"),
    Key: aws.String("test-key"),

    AccessControlPolicy: &s3.AccessControlPolicy{
        Grants: []*s3.Grant{
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("CanonicalUser"),
                    DisplayName: aws.String(""),
                    ID: aws.String("some_user_id"),
                },
                Permission: aws.String("FULL_CONTROL"),
            },
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("Group"),
                    URI: aws.String("http://acs.amazonaws.com/groups/global/AllUsers"),
                },
                Permission: aws.String("READ"),
            },
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("AmazonCustomerByEmail"),
                    DisplayName: aws.String(""),
                    EmailAddress: aws.String("some_email@some.com"),
                },
                Permission: aws.String("READ"),
            },
        },
        Owner: &s3.Owner{
            DisplayName: aws.String(""),
            ID: aws.String("your_user_id"),
        },
    },
}

resp, err := svc.PutObjectAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```


### Bucket Operation API

#### Bucket Create

The permitted values of ACL are private, public-read, public-read-write, and authentication-read

```go
params := &s3.CreateBucketInput{
    Bucket: aws.String("test-bucket"),
    ACL: aws.String("public-read"),
}

resp, err := svc.CreateBucket(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### List all the files contained on the bucket (every time it can return up to 1000 files)

```go
params := &s3.ListObjectsInput{
    Bucket: aws.String("test-bucket"),
    Marker: aws.String("foo"), //设置从哪个key开始列
    Prefix: aws.String("foo"), //只返回以“foo“为前缀的key
    Delimiter: aws.String("/"), //对含有公共部分的keys进行合并
    MaxKeys: aws.Int64(200), //最多返回200个
}

resp, err := svc.ListObjects(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### List all the files on the bucket

```go
marker := ""

for {
    params := &s3.ListObjectsInput{
        Bucket: aws.String("test-bucket"),
        Marker: aws.String(marker),
    }

    resp, err := svc.ListObjects(params)
    if err != nil {
        fmt.Println(err.Error())
        return
    }

    if len(resp.Contents) == 0 {
        break;
    }

    for _, content := range resp.Contents {
        fmt.Printf("key:%s, size:%d\n", *content.Key, *content.Size)
        marker = *content.Key
    }
}
```

#### Bucket Delete

```go
params := &s3.DeleteBucketInput{
    Bucket: aws.String("test-bucket"),
}
resp, err := svc.DeleteBucket(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### Get Bucket ACL

```go
params := &s3.GetBucketAclInput{
    Bucket: aws.String("test-bucket"),
}
resp, err := svc.GetBucketAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

#### Set Bucket ACL

##### Using the pre-defined ACL

The permitted values of ACL are private, public-read, public-read-write, and authentication-read.

```go
params := &s3.PutBucketAclInput{
    Bucket: aws.String("test-bucket"),
    ACL: aws.String("public-read-write"),
}

resp, err := svc.PutBucketAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

##### Set ACL by using Grant header

```go
params := &s3.PutBucketAclInput{
    Bucket: aws.String("test-bucket"),

    GrantFullControl: aws.String("id=your_user_id"),
    GrantRead: aws.String("uri=\"http://acs.amazonaws.com/groups/global/AllUsers\""),
    GrantReadACP: aws.String("id=some_user_id, id=another_user_id"),
    GrantWrite: aws.String("uri=\"http://acs.amazonaws.com/groups/global/AuthenticatedUsers\""),
    GrantWriteACP: aws.String("emailAddress=\"some_email@some.com\", id=some_user_id"),
}

resp, err := svc.PutBucketAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

##### Using Custom ACL

The permitted values of Permission are FULL_CONTROL, WRITE, WRITE_ACP, READ, and READ_ACP

```go
params := &s3.PutBucketAclInput{
    Bucket: aws.String("test-bucket"),

    AccessControlPolicy: &s3.AccessControlPolicy{
        Grants: []*s3.Grant{
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("CanonicalUser"),
                    DisplayName: aws.String(""),
                    ID: aws.String("some_user_id"),
                },
                Permission: aws.String("FULL_CONTROL"),
            },
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("Group"),
                    URI: aws.String("http://acs.amazonaws.com/groups/global/AllUsers"),
                },
                Permission: aws.String("READ"),
            },
            {
                Grantee: &s3.Grantee{
                    Type: aws.String("AmazonCustomerByEmail"),
                    DisplayName: aws.String(""),
                    EmailAddress: aws.String("some_email@some.com"),
                },
                Permission: aws.String("READ"),
            },
        },
        Owner: &s3.Owner{
            DisplayName: aws.String(""),
            ID: aws.String("your_user_id"),
        },
    },
}

resp, err := svc.PutBucketAcl(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```


### Service Operation API

#### List all the Buckets

```go
var params *s3.ListBucketsInput
resp, err := svc.ListBuckets(params)
if err != nil {
    fmt.Println(err.Error())
    return
}
fmt.Println(resp)
```

The link of the official AWS SDK for Go: [aws-sdk-go](https://aws.amazon.com/sdk-for-go/)

The link of API documentation: [api-reference](http://docs.aws.amazon.com/sdk-for-go/api/service/s3/)
