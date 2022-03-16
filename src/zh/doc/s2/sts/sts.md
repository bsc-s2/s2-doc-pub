## 临时凭证使用流程

当在白山云存储开通存储账号以后可以得到访问存储服务需要的access key和secret
key，这是永久访问凭证，而且具有任何操作权限，因此为了防止泄露该永久凭证，
不适合将其存放在移动客户端等不安全的地方。当需要从移动客户端访问存储服务时，
就可以使用临时凭证，此时，永久凭证存放在客户服务器上，
客户服务器使用永久凭证向白山云存储节点索取临时凭证，然后将得到的临时凭证发送给移动客户端，移动客户端再使用临时凭证访问存储服务。

临时凭证包括三部分：临时`access_key`， 临时`secret_key`，
token。使用临时凭证和使用永久凭证的方法类似，只是需要多加一个token，如果使用SDK，这个token可以通过参数传入。

临时凭证是有有效期的，可以在获取临时凭证时设置有效期的长短，可以设置为15分钟到60分钟。

临时凭证的权限也可以在获取的时候设置，如可以设置为只能上传，或只能下载，或只能上传到指定目录等。


## STS使用流程

```
             3            +------------+
  +-------------------->  | 移动客户端 |
  |                       +------------+
  |                             |
  |                             | 4
  |                             |
  |                 1           v
+------------+ ---------> +--------------------+
| 客户服务器 |            | 白山云存储endpoint |
+------------+ <--------- +--------------------+
                   2
```

1. 客户服务器访问白山云存储节点提供的STS服务获取临时凭证。

2. 云存储STS服务返回临时凭证。

3. 客户服务器将临时凭证发送给移动客户端。

4. 移动客户端使用临时凭证访问云存储服务。

### 示例

使用STS服务的SDK访问白山云存储STS服务，endpoint为 `http://sts.ss.bscstorage.com`。

申请临时凭证常用到下面三个参数：

-   Policy: 用来描述分配的权限, 它是一个json字符串，只需要填充里面的`Statement`字段。

    -   `Effect`: `Allow`表示允许，`Deny`表示拒绝。

    -   `Resource`: 用来描述哪些资源会被分配权限, `*`代表所有。

    -   `Action`: 表示被拒绝或者允许的动作，`*`代表所有。

        -   `s3:GetObject`
        -   `s3:GetObjectAcl`
        -   `s3:PutObject`
        -   `s3:DeleteObject`
        -   `s3:PutObjectAcl`
        -   `s3:ListMultipartUploadParts`
        -   `s3:AbortMultipartUpload`
        -   `s3:ListAllMyBuckets`
        -   `s3:CreateBucket`
        -   `s3:DeleteBucket`
        -   `s3:GetBucketVersioning`
        -   `s3:GetBucketCORS`
        -   `s3:PutBucketAcl`
        -   `s3:PutBucketVersioning`
        -   `s3:PutBucketCORS`
        -   `s3:ListBucket`
        -   `s3:ListBucketMultipartUploads`
        -   `s3:GetBucketPolicy`
        -   `s3:PutBucketPolicy`
        -   `s3:DeleteBucketPolicy`
        -   `s3:GetBucketAcl`

    Eg: "{\"Statement\":[{\"Resource\":\"*\",\"Action\":[\"s3:*\"],\"Effect\":\"Allow\"}]}"表示允许所有方法访问所有资源。

-   RoleArn: 资源名称，字符串类型，用户自定义，长度必须大于20。

-   RoleSessionName: session名称，字符串类型，用户自定义。

使用Java SDK的示例如下：

```java
// 通过永久凭证生成临时凭证
String stsEndPoint = "http://sts.ss.bscstorage.com";
String accessKey = "ziwxxxxxxxxxxxxxxxxx";
String secretKey = "V+ZTZ5xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
BasicAWSCredentials awsCreds = new BasicAWSCredentials(
                accessKey, secretKey);

AWSSecurityTokenService sts = AWSSecurityTokenServiceClientBuilder.standard().withCredentials(
                new AWSStaticCredentialsProvider(awsCreds)).withEndpointConfiguration(
                        new EndpointConfiguration(stsEndPoint, "us-east-1")).build();

String policy = "{\"Statement\":[{\"Resource\":\"*\",\"Action\":[\"s3:PutObject\"],\"Effect\":\"Allow\"}]}"

AssumeRoleRequest assumeRoleRequest = new AssumeRoleRequest();
assumeRoleRequest.setPolicy(policy_str);
assumeRoleRequest.setRoleArn("arn:aws:iam::123456789:role/test_role");
assumeRoleRequest.setRoleSessionName("test-session");

AssumeRoleResult assumeRoleResult = sts.assumeRole(assumeRoleRequest);

String tmp_access_key = assumeRoleResult.getCredentials().getAccessKeyId();
String tmp_secret_key = assumeRoleResult.getCredentials().getSecretAccessKey();
String token = assumeRoleResult.getCredentials().getSessionToken();

// 使用服务器返回的临时凭证
String s3EndPoint = "http://ss.bscstorage.com";

BasicSessionCredentials sessionCredentials = new BasicSessionCredentials(
                tmp_access_key, tmp_secret_key, token);

AmazonS3 s3 = AmazonS3ClientBuilder.standard().withCredentials(
            new AWSStaticCredentialsProvider(sessionCredentials)).withEndpointConfiguration(
                    new EndpointConfiguration(s3EndPoint, "us-east-1")).build();

S3Object obj = s3.getObject("bucket", "key");
```

使用Python SDK示例如下：

```python
import boto3

cli = boto3.client(
    'sts',
    region_name="bj",
    aws_access_key_id="accesskey",
    aws_secret_access_key="secretkey",
    endpoint_url='http://sts.ss.bscstorage.com'
)

policy = "{\"Statement\":[{\"Resource\":\"*\",\"Action\":[\"s3:*\"],\"Effect\":\"Allow\"}]}"
# 使用永久凭证生成临时凭证
resp = cli.assume_role(
    DurationSeconds=3600,
    RoleArn='arn:aws:iam::123456789012:role/demo',
    RoleSessionName="test",
    Policy=policy,
)

print("tmp accesskey: %s" % resp['Credentials']['AccessKeyId'])
print("tmp secretkey: %s" % resp['Credentials']['SecretAccessKey'])
print("expired time : %s" % resp['Credentials']['Expiration'])
print("session token: %s" % resp['Credentials']['SessionToken'])

# 使用临时凭证创建client
tmpcli = boto3.client(
    "s3",
    region_name="bj",
    aws_access_key_id=resp['Credentials']['AccessKeyId'],
    aws_secret_access_key=resp['Credentials']['SecretAccessKey'],
    aws_session_token=resp['Credentials']['SessionToken'],
    endpoint_url='http://ss.bscstorage.com',
)

print tmpcli.head_object(Bucket='bucket', Key='key')
```

使用PHP SDK示例如下：

```php
<?php

require 'aws.phar';

try {
    $cli = new Aws\Sts\StsClient([
        'version' => 'latest',
        'region' => 'us-east-1',
        'credentials' => [
            'key' => 'accesskey',
            'secret' => 'secretkey',
        ],
        'endpoint' => 'http://sts.ss.bscstorage.com',
    ]);
    $result = $cli->assumeRole([
        'DurationSeconds' => 3600,
        'Policy' => "{\"Statement\":[{\"Resource\":\"*\",\"Action\":[\"s3:*\"],\"Effect\":\"Allow\"}]}",
        'RoleArn' => 'arn:aws:iam::123456789012:role/demo', // REQUIRED
        'RoleSessionName' => 'test', // REQUIRED
    ]);

    $tmp_accesskey = $result['Credentials']['AccessKeyId'];
    $tmp_secretkey = $result['Credentials']['SecretAccessKey'];
    $tmp_sesstoken = $result['Credentials']['SessionToken'];

    echo "tmp accesskey:", $tmp_accesskey, "\n";
    echo "tmp secretkey:", $tmp_secretkey, "\n";
    echo "session token:", $tmp_sesstoken, "\n";

    $s3 = new Aws\S3\S3Client([
        'version' => 'latest',
        'region' => 'us-east-1',
        'credentials' => [
            'key' => $tmp_accesskey,
            'secret' => $tmp_secretkey,
            'token' => $tmp_sesstoken,
        ],
        'endpoint' => 'http://ss.bscstorage.com',
    ]);

    $resp = $s3->getObject([
        'Bucket' => 'bucket',
        'Key' => 'key',
    ]);

    echo $resp;
} catch (\Exception $e) {
    echo "Exception: " . $e->getMessage() . "\n";
}
```

使用dotnet SDK示例如下：

```csharp
static async Task StsDemo()
{
    AmazonSecurityTokenServiceConfig config = new AmazonSecurityTokenServiceConfig();
    config.ServiceURL = "http://sts.ss.bscstorage.com";
    config.SignatureVersion = "4";
    AmazonSecurityTokenServiceClient sts = new AmazonSecurityTokenServiceClient("accesskey", "secretkey", config);
    var response = await sts.AssumeRoleAsync(new AssumeRoleRequest
    {
        Policy = "{\"Statement\":[{\"Resource\":\"*\",\"Action\":[\"s3:*\"],\"Effect\":\"Allow\"}]}",
        RoleArn = "arn:aws:iam::123456789012:role/demo",
        RoleSessionName = "testAssumeRoleSession",
    });
 
    Credentials credentials = response.Credentials;
    Console.WriteLine("tmp accesskey:" + credentials.AccessKeyId);
    Console.WriteLine("tmp secretkey:" + credentials.SecretAccessKey);
    Console.WriteLine("tmp sesstoken:" + credentials.SessionToken);

    AmazonS3Config s3config = new AmazonS3Config();
    s3config.ServiceURL = "http://ss.bscstorage.com";
    s3config.SignatureVersion = "4";
    AmazonS3Client s3 = new AmazonS3Client(credentials.AccessKeyId, credentials.SecretAccessKey, credentials.SessionToken, s3config);
    var resp = await s3.GetObjectMetadataAsync("bucket", "key");
    Console.WriteLine(resp.HttpStatusCode);
}
```
