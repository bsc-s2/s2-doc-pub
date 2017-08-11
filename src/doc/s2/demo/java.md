## Java Demo

### 安装AWS Java SDK

使用maven，在pom.xml中加入如下内容

```
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-bom</artifactId>
            <version>1.11.77</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
        <groupId>com.amazonaws</groupId>
        <artifactId>aws-java-sdk-s3</artifactId>
    </dependency>
</dependencies>
```

### 初始化，设置帐号信息和域名

```java
package com.baishancloud.sdk_test;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.*;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.S3ClientOptions;
import com.amazonaws.services.s3.model.*;

public class App
{
    private static String endPoint = "http://bscstorage.com";
    private static String accessKey = "ziw5dp1alvty9n47qksu"; //请替换为您自己的access key
    private static String secretKey = "V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV"; //请替换为您自己的secret key

    public static void main( String[] args )
    {
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(
                accessKey, secretKey);

        AmazonS3 s3 = new AmazonS3Client(awsCreds);

        s3.setRegion(Region.getRegion(Regions.US_EAST_1));
        s3.setEndpoint(endPoint);
        s3.setS3ClientOptions(S3ClientOptions.builder().setPathStyleAccess(true)
                .disableChunkedEncoding().build()); //暂不支持ChunkedEncoding
    }
}
```


### 文件操作接口

#### 上传文件

```java
String file_content = "bla bla";
InputStream inputStream = new ByteArrayInputStream(file_content.getBytes());

ObjectMetadata objectMetadata = new ObjectMetadata();
objectMetadata.setContentType("image/jpeg"); //请替换为合适的文件类型
objectMetadata.addUserMetadata("key-foo", "value_bar");

PutObjectRequest putObjectrequest = new PutObjectRequest(
		"test-bucket", "test-key", inputStream, objectMetadata);

//您可以使用下面两种方式为上传的文件指定ACL，后一种已被注释
putObjectrequest.setCannedAcl(CannedAccessControlList.PublicReadWrite);

//AccessControlList accessControlList = new AccessControlList();
//accessControlList.setOwner(new Owner("your_user_id", ""));
//accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.Read);
//accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.ReadAcp);
//accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
//putObjectrequest.setAccessControlList(accessControlList);

PutObjectResult putObjectResult = s3.putObject(putObjectrequest);
```

#### 下载文件

```java
GetObjectRequest getObjectRequest = new GetObjectRequest("test-bucket", "test-key");
S3Object s3Object = s3.getObject(getObjectRequest);

System.out.println(s3Object.getObjectMetadata().getUserMetadata().get("key-foo"));
byte[] buf = new byte[1024];
try {
	int n = s3Object.getObjectContent().read(buf, 0, 1024);
	System.out.println(new String(buf, "UTF-8"));
} catch (IOException e) {
	System.out.println("errr");
}
```

#### 下载到本地文件

```java
GetObjectRequest getObjectRequest = new GetObjectRequest("test-bucket", "test-key");
ObjectMetadata meta = s3.getObject(getObjectRequest, new File("/root/test.down"));
```

#### 获取文件的URL

获取已签名的URL用来下载文件，可通过参数设置签名过期时间。

```java
URL url = s3.generatePresignedUrl("test-bucket", "test-key",
                                  new Date(116, 11, 17)); //2016年12月17日过期
System.out.println(url.toString());
```

#### 删除文件

```java
s3.deleteObject("test-bucket", "test_key");
```

#### 获取文件的ACL

```java
AccessControlList accessControlList = s3.getObjectAcl("test-bucket", "test-key");
```

#### 设置文件的ACL

##### 使用预定义的ACL

```java
s3.setObjectAcl(bucketName, "test-key", CannedAccessControlList.AuthenticatedRead);
```

##### 使用自定义的ACL

```java
AccessControlList accessControlList = new AccessControlList();
accessControlList.setOwner(new Owner("your_user_id", ""));

accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
accessControlList.grantPermission(GroupGrantee.LogDelivery, Permission.FullControl);
accessControlList.grantPermission(new CanonicalGrantee("some_user_id"), Permission.Read);
accessControlList.grantPermission(new EmailAddressGrantee("some_email@some.com"), Permission.WriteAcp);

s3.setObjectAcl("test-bucket", "test-key", accessControlList);
```


### 桶操作接口

#### 创建桶

```java
CreateBucketRequest createBucketRequest = new CreateBucketRequest("test-bucket");
createBucketRequest.withCannedAcl(CannedAccessControlList.PublicRead);

Bucket bucket = s3.createBucket(createBucketRequest);
```

#### 列出桶中所包含的文件, 每次最多返回1000个文件

```java
ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
listObjectsRequest.setBucketName("test-bucket");
listObjectsRequest.setMarker("foo"); //设置从哪个key开始列
listObjectsRequest.setPrefix("foo"); //只返回以“foo“为前缀的key
listObjectsRequest.setDelimiter("/"); //对有公共部分的keys进行合并
listObjectsRequest.setMaxKeys(200); //最多返回200个

ObjectListing objectListing = s3.listObjects(listObjectsRequest);
```

#### 列出桶中所包含的所有文件

```java
String marker = "";

ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
listObjectsRequest.setBucketName("test-bucket");
listObjectsRequest.setMarker(marker);

while (true)
{
    ObjectListing objectListing = s3.listObjects(listObjectsRequest);

    List<S3ObjectSummary> contents = new ArrayList<S3ObjectSummary>();
    contents = objectListing.getObjectSummaries();

    if (contents.size() == 0)
    {
        break;
    }

    for (S3ObjectSummary content: contents)
    {
        String key = content.getKey();
        long size = content.getSize();
        System.out.format("key: %s, size: %d\n", key, size);
        listObjectsRequest.setMarker(key);
    }
}
```

#### 删除桶

```java
s3.deleteBucket("test-bucket");
```

#### 获取桶的ACL

```java
AccessControlList accessControlList = s3.getBucketAcl("test-bucket");
```

#### 设置桶的ACL

##### 使用预定义的ACL

```java
s3.setBucketAcl("test-bucket", CannedAccessControlList.AuthenticatedRead);
```

##### 使用自定义的ACL

```java
AccessControlList accessControlList = new AccessControlList();
accessControlList.setOwner(new Owner("your_user_id", ""));

accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
accessControlList.grantPermission(GroupGrantee.LogDelivery, Permission.FullControl);
accessControlList.grantPermission(new CanonicalGrantee("some_user_id"), Permission.Read);
accessControlList.grantPermission(new EmailAddressGrantee("some_email@some.com"), Permission.WriteAcp);

s3.setBucketAcl("test-bucket", accessControlList);
```


### 服务操作接口

#### 列出所有的桶

```java
List<Bucket> allBuckets = new ArrayList<Bucket>();
allBuckets = s3.listBuckets();
```

AWS 官方 SDK [aws-sdk-java](https://aws.amazon.com/sdk-for-java/)
接口详细文档 [api-reference](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html)
