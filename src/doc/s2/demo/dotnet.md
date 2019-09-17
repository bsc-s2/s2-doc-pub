## Dotnet Demo

### 安装AWS Dotnet SDK

```
dotnet add package AWSSDK.S3
```

### 初始化，设置帐号信息和域名

```csharp
using System;
using System.IO;
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using System.Threading.Tasks;

namespace dnet
{
    class Program
    {
        private static IAmazonS3 client;

        public static void Main()
        {
            # 请替换为您自己的access key
            string accessKey = "accessKey";

            # 请替换为您自己的secret key
            string secretKey = "secretKey";

            AmazonS3Config config = new AmazonS3Config();
            config.ServiceURL = "http://ss.bscstorage.com";
            client = new AmazonS3Client(accessKey, secretKey, config);
        }
    }
}
```


### 文件操作接口

#### 上传文件

```csharp
static async Task WritingAnObjectAsync()
{
    try
    {
        // 1. Put object-specify only key name for the new object.
        var putRequest1 = new PutObjectRequest
        {
            BucketName = "test-bucket-xxx",
            Key = "test-key-xxx",
            ContentBody = "sample text"
        };

        PutObjectResponse response1 = await client.PutObjectAsync(putRequest1);

        // 2. Put the object-set ContentType and add metadata.
        var putRequest2 = new PutObjectRequest
        {
            BucketName = "test-bucket-xxx",
            Key = "test-key-xxx",
            FilePath = "/root/test.txt",
            ContentType = "text/plain"
        };
        putRequest2.Metadata.Add("x-amz-meta-title", "someTitle");
        PutObjectResponse response2 = await client.PutObjectAsync(putRequest2);
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine(
                "Error encountered ***. Message:'{0}' when writing an object"
                , e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine(
            "Unknown encountered on server. Message:'{0}' when writing an object"
            , e.Message);
    }
}
```

#### 下载文件

```csharp
static async Task ReadObjectDataAsync()
{
    string responseBody = "";
    try
    {
        GetObjectRequest request = new GetObjectRequest
        {
            BucketName = bucketName,
            Key = keyName
        };
        using (GetObjectResponse response = await client.GetObjectAsync(request))
        using (Stream responseStream = response.ResponseStream)
        using (StreamReader reader = new StreamReader(responseStream))
        {
            string title = response.Metadata["x-amz-meta-title"]; // Assume you have "title" as medata added to the object.
            string contentType = response.Headers["Content-Type"];
            Console.WriteLine("Object metadata, Title: {0}", title);
            Console.WriteLine("Content type: {0}", contentType);

            responseBody = reader.ReadToEnd(); // Now you process the response body.
        }
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered ***. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 删除文件

```csharp
private static async Task DeleteObjectAsync()
{
    try
    {
        // Delete the object
        DeleteObjectRequest request = new DeleteObjectRequest
        {
            BucketName = bucketName,
            Key = keyName,
        };
        Console.WriteLine("Deleting an object");
        await client.DeleteObjectAsync(request);
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 文件的ACL

```csharp
private static async Task TestObjectACLAsync()
{
    try
    {
        // Retrieve the ACL for the object.
        GetACLResponse aclResponse = await client.GetACLAsync(new GetACLRequest
        {
            BucketName = bucketName,
            Key = keyName
        });

        S3AccessControlList acl = aclResponse.AccessControlList;

        // Retrieve the owner (we use this to re-add permissions after we clear the ACL).
        Owner owner = acl.Owner;

        // Clear existing grants.
        acl.Grants.Clear();

        // Add a grant to reset the owner's full permission (the previous clear statement removed all permissions).
        S3Grant fullControlGrant = new S3Grant
        {
            Grantee = new S3Grantee { CanonicalUser = owner.Id },
            Permission = S3Permission.FULL_CONTROL
        };

        // Describe the grant for the permission using an email address.
        S3Grant grantUsingEmail = new S3Grant
        {
            Grantee = new S3Grantee { EmailAddress = emailAddress },
            Permission = S3Permission.WRITE_ACP
        };
        acl.Grants.AddRange(new List<S3Grant> { fullControlGrant, grantUsingEmail });

        // Set a new ACL.
        PutACLResponse response = await client.PutACLAsync(new PutACLRequest
        {
            BucketName = bucketName,
            Key = keyName,
            AccessControlList = acl
        });
    }
    catch (AmazonS3Exception amazonS3Exception)
    {
        Console.WriteLine("An AmazonS3Exception was thrown. Exception: " + amazonS3Exception.ToString());
    }
    catch (Exception e)
    {
        Console.WriteLine("Exception: " + e.ToString());
    }
}
```

### 桶操作接口

#### 创建桶

```csharp
static async Task CreateBucketAsync()
{
    try
    {
        PutBucketResponse response = await client.PutBucketAsync("test-bucket-xxx");
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 列出桶中所包含的文件

```csharp
static async Task ListObjectsAsync()
{
    try
    {
        // List all objects
        ListObjectsRequest listRequest = new ListObjectsRequest
        {
            BucketName = "test-bucket-xxx",
            MaxKeys = 10,
        };

        ListObjectsResponse listResponse;
        do
        {
            // Get a list of objects
            listResponse = client.ListObjectsAsync(listRequest).Result;
            foreach (S3Object obj in listResponse.S3Objects)
            {
                Console.WriteLine("key = {0} size = {1}", obj.Key, obj.Size);
            }

            // Set the marker property
            listRequest.Marker = listResponse.NextMarker;
        } while (listResponse.IsTruncated);
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 删除桶

```csharp
static async Task DeleteBucketAsync()
{
    try
    {
        var response = await client.DeleteBucketAsync("test-bucket-xxx");
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 获取桶的ACL

```csharp
static async Task GetBucketACLAsync(string bucketName)
{
    try
    {
        GetACLResponse response = await client.GetACLAsync(new GetACLRequest
        {
            BucketName = "test-bucket-xxx"
        });
        S3AccessControlList accessControlList = response.AccessControlList;
        Console.WriteLine("ID: {0}", accessControlList.Owner.Id);
        foreach(var g in accessControlList.Grants)
        {
            Console.WriteLine("Permission: {0}, {1}", g.Permission.HeaderName, g.Permission.Value);
            Console.WriteLine("Grantee: {0}", g.Grantee.CanonicalUser);
        }
    }
    catch (AmazonS3Exception e)
    {
        Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
    }
    catch (Exception e)
    {
        Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
    }
}
```

#### 设置桶的ACL

```csharp
// Set Canned ACL (PublicRead)
client.PutACL(new PutACLRequest
{
    BucketName = "SampleBucket",
    CannedACL = S3CannedACL.PublicRead
});
 
// Set Canned ACL (PublicRead)
client.PutACL(new PutACLRequest
{
    BucketName = "SampleBucket",
    CannedACL = S3CannedACL.Private
});
```

#### 列出所有的桶

```csharp
static async Task ListBucketsAsync(string bucketName)
{
    var response = client.ListBucketsAsync().Result;
    foreach (var bucket in response.Buckets)
    {
        Console.WriteLine(bucket.BucketName);
    }
}
```

AWS 官方 SDK [aws-sdk-dotnet](https://aws.amazon.com/cn/sdk-for-net/)
接口详细文档 [api-reference](https://docs.aws.amazon.com/sdkfornet/v3/apidocs/Index.html)
