## Provisional signature：STS

Temporary voucher usage process

After opening the storage account in Baishan cloud storage, you can get the access key and secret key required to access the storage service. This is a permanent access certificate and has any operation permission. Therefore, in order to prevent the disclosure of the permanent certificate, it is not suitable to store it in unsafe places such as mobile clients. When you need to access the storage service from the mobile client, you can use the temporary certificate. At this time, the permanent certificate is stored on the client server. The client server uses the permanent certificate to request the temporary certificate from the Baishan cloud storage node, and then sends the obtained temporary certificate to the mobile client. The mobile client then uses the temporary certificate to access the storage service.

Temporary vouchers include three parts: temporary `access_key`, temporary `secret_key`, token. The method of using temporary credentials is similar to that of using permanent credentials, except that an additional token needs to be added. If SDK is used, this token can be passed in through parameters.

Temporary vouchers have a validity period. You can set the length of the validity period when obtaining temporary vouchers, which can be set to 15 minutes to 60 minutes.

The permissions of temporary vouchers can also be set when obtaining them. For example, they can be set to upload only, download only, or upload only to the specified directory.


## STS使用流程

```
             3            +------------+
  +-------------------->  | Mobile client |
  |                       +------------+
  |                             |
  |                             | 4
  |                             |
  |                 1           v
+------------+ ---------> +--------------------+
| Client server |            | Baishan cloud storage endpoint |
+------------+ <--------- +--------------------+
                   2
```

1. The client server accesses the STS service provided by the Baishan cloud storage node to obtain temporary credentials.

2. The cloud storage STS service returns temporary credentials.

3. The client server sends temporary credentials to the mobile client.

4. Mobile clients use temporary credentials to access cloud storage services.

### Example

http://sts.ss.bscstorage.com

- Use the SDK of STS Service to access Baishan cloud storage STS Service. The endpoint is `http://sts.ss.bscstorage.com`

The following three parameters are commonly used to apply for temporary vouchers:

- `Policy`: used to describe the allocated permissions. It is a JSON string, which only `Statement` needs to be filled in field

    - `Effect`:`Allow` indicates allow permission and `Deny` indicates a refusal.

    - `Resource`: Used to describe which resources will be assigned permissions, `*` means for all.

    - `Action` indicates an action that is rejected or allowed, `*` means for all.

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


- RoleArn: Resource name, string type, user defined, length must be greater than 20.

- RoleSessionName: session name, string type, user defined.

Examples of using the Java SDK are as follows:

```java
// Generate temporary vouchers from permanent vouchers
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

Examples of using Python SDK are as follows:

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

Examples of using PHP SDK are as follows:

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

Examples of using dotnet SDK are as follows:

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
