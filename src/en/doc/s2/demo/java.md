## Java Demo

### Install AWS Java SDK

Using the maven and add the bellowing to the pom.xml

```
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-bom</artifactId>
            <version>1.12.95</version>
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

### Initialization & Set the account information and the domain name

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
import com.amazonaws.ClientConfiguration;

public class App
{
    private static String endPoint = "http://ss.bscstorage.com";
    private static String accessKey = "ziw5dp1alvty9n47qksu"; // please replace with your access_key
    private static String secretKey = "V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV"; // please replace with your secret_key

    public static void main( String[] args )
    {
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(
                accessKey, secretKey);

        ClientConfiguration clientconfiguration = new ClientConfiguration();
        clientconfiguration.setSocketTimeout(60 * 60 * 1000); // in milliseconds
        clientconfiguration.setConnectionTimeout(60 * 60 * 1000); // in milliseconds

        AmazonS3 s3 = new AmazonS3Client(awsCreds, clientconfiguration);

        s3.setRegion(Region.getRegion(Regions.US_EAST_1));
        s3.setEndpoint(endPoint);
        s3.setS3ClientOptions(S3ClientOptions.builder().setPathStyleAccess(true)
                .disableChunkedEncoding().build());
    }
}
```


### File Operation API

#### File Upload

```java
String file_content = "bla bla";
InputStream inputStream = new ByteArrayInputStream(file_content.getBytes());

ObjectMetadata objectMetadata = new ObjectMetadata();
objectMetadata.setContentType("image/jpeg"); 
objectMetadata.addUserMetadata("key-foo", "value_bar");

PutObjectRequest putObjectrequest = new PutObjectRequest(
		"test-bucket", "test-key", inputStream, objectMetadata);


putObjectrequest.setCannedAcl(CannedAccessControlList.PublicReadWrite);

//AccessControlList accessControlList = new AccessControlList();
//accessControlList.setOwner(new Owner("your_user_id", ""));
//accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.Read);
//accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.ReadAcp);
//accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
//putObjectrequest.setAccessControlList(accessControlList);

PutObjectResult putObjectResult = s3.putObject(putObjectrequest);
```

#### File Copy

```java
CopyObjectResult res = s3.copyObject("srcBucketName", "srcKey", "dstBucketName", "dstKey");
```

#### File Download

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

#### Download to Local File

```java
GetObjectRequest getObjectRequest = new GetObjectRequest("test-bucket", "test-key");
ObjectMetadata meta = s3.getObject(getObjectRequest, new File("/root/test.down"));
```

#### Get File URL

Get the pre-signed URL to download the File, and the developer could set an expired time.

```java
URL url = s3.generatePresignedUrl("test-bucket", "test-key",
                                  new Date(116, 11, 17)); //2016年12月17日过期
System.out.println(url.toString());
```

#### File Delete

```java
s3.deleteObject("test-bucket", "test_key");
```

#### Get File ACL

```java
AccessControlList accessControlList = s3.getObjectAcl("test-bucket", "test-key");
```

#### Set File ACL

##### Using pre-defined ACL

```java
s3.setObjectAcl(bucketName, "test-key", CannedAccessControlList.AuthenticatedRead);
```

##### Using Custom ACL

```java
AccessControlList accessControlList = new AccessControlList();
accessControlList.setOwner(new Owner("your_user_id", ""));

accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
accessControlList.grantPermission(GroupGrantee.LogDelivery, Permission.FullControl);
accessControlList.grantPermission(new CanonicalGrantee("some_user_id"), Permission.Read);
accessControlList.grantPermission(new EmailAddressGrantee("some_email@some.com"), Permission.WriteAcp);

s3.setObjectAcl("test-bucket", "test-key", accessControlList);
```


### Bucket Operation API

#### Bucket Create

```java
CreateBucketRequest createBucketRequest = new CreateBucketRequest("test-bucket");
createBucketRequest.withCannedAcl(CannedAccessControlList.PublicRead);

Bucket bucket = s3.createBucket(createBucketRequest);
```

#### Bucket File List (List all the files contained on the bucket. The max number of returning files at the same time is 1000)

```java
ListObjectsRequest listObjectsRequest = new ListObjectsRequest();
listObjectsRequest.setBucketName("test-bucket");
listObjectsRequest.setMarker("foo"); //设置从哪个key开始列
listObjectsRequest.setPrefix("foo"); //只返回以“foo“为前缀的key
listObjectsRequest.setDelimiter("/"); //对有公共部分的keys进行合并
listObjectsRequest.setMaxKeys(200); //最多返回200个

ObjectListing objectListing = s3.listObjects(listObjectsRequest);
```

#### List all the files contained on the bucket

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

#### Bucket Delete

```java
s3.deleteBucket("test-bucket");
```

#### Get Bucket ACL

```java
AccessControlList accessControlList = s3.getBucketAcl("test-bucket");
```

#### Set Bucket ACL

##### Using the pre-defined ACL

```java
s3.setBucketAcl("test-bucket", CannedAccessControlList.AuthenticatedRead);
```

##### Using the custom ACL

```java
AccessControlList accessControlList = new AccessControlList();
accessControlList.setOwner(new Owner("your_user_id", ""));

accessControlList.grantPermission(GroupGrantee.AuthenticatedUsers, Permission.Write);
accessControlList.grantPermission(GroupGrantee.LogDelivery, Permission.FullControl);
accessControlList.grantPermission(new CanonicalGrantee("some_user_id"), Permission.Read);
accessControlList.grantPermission(new EmailAddressGrantee("some_email@some.com"), Permission.WriteAcp);

s3.setBucketAcl("test-bucket", accessControlList);
```


### Service Operation API

#### Bucket List

```java
List<Bucket> allBuckets = new ArrayList<Bucket>();
allBuckets = s3.listBuckets();
```

The link of the official AWS SDK for Java: [aws-sdk-java](https://aws.amazon.com/sdk-for-java/)

The link of API documentation: [api-reference](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html)
