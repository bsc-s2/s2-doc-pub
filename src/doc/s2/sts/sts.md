## 临时凭证使用流程

当在白山云存储开通存储账号以后可以得到访问存储服务需要的access key和secret
key，这是永久访问凭证，而且具有任何操作权限，因此为了防止泄露该永久凭证，
不适合将其存放在移动客户端等不安全的地方。当需要从移动客户端访问存储服务时，
就可以使用临时凭证，此时，永久凭证存放在客户服务器上，
客户服务器使用永久凭证向白山云存储节点索取零时凭证，然后将得到的临时凭证发送给移动客户端，移动客户端再使用临时凭证访问存储服务。

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

### 获取临时凭证

使用STS服务的SDK访问白山云存储STS服务，endpoint为 `http://sts.ss.bscstorage.com`

这一步需要使用永久凭证。使用Java SDK的示例如下：

```java

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
```


### 使用临时凭证

当移动客户端得到临时凭证后就可以使用临时凭证访问云存储服务，使用Java SDK的示例如下：

```java
String s3EndPoint = "http://s2.i.qingcdn.com";

BasicSessionCredentials sessionCredentials = new BasicSessionCredentials(
                tmp_access_key, tmp_secret_key, token);

AmazonS3 s3 = AmazonS3ClientBuilder.standard().withCredentials(
            new AWSStaticCredentialsProvider(sessionCredentials)).withEndpointConfiguration(
                    new EndpointConfiguration(s3EndPoint, "us-east-1")).build();
```

