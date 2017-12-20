## PHP Demo

系统需求：

  - PHP >= 5.5.0

### 安装AWS SDK for PHP

```
curl -O http://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.phar
```

初始化，设置帐号信息和域名

```php

require 'aws.phar';
$cli = new Aws\S3\S3Client([
    'version' => 'latest',
    'region' => 'us-east-1',
    'credentials' => [
        'key' => 'z2qutjf718d0i9gw6skc',  //请替换为您自己的access_key
        'secret' => 'SEQgcc1ppH7uXPG4ZPIcrCv2cWz8grcReMfFABCn', //请替换为您自己的secret_key
    ],
    'endpoint' => 'http://ss.bscstorage.com',
]);

```


### 文件操作接口

#### 上传文件

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'
如果需要上传的文件内容已经在内存中,可以直接使用'Body'指定。
如果文件在磁盘上，可以通过'SourceFile'指定文件名，’Body‘和'SourceFile'不能同时使用。


```php
$resp = $cli->putObject([
    'ACL' => 'public-read',
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
    'ContentType' => 'image/jpeg',  //请替换为合适的文件类型
    'Body' => 'file content as a string',
    //'SourceFile' => '/root/test.jpg',
]);
```

#### 下载文件

```php
$resp = $cli->getObject([
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
```

#### 获取文件的URL

获取已签名的URL用来下载文件，可设置签名过期时间。

```php
$cmd = $cli->getCommand('GetObject', [
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
$req = $s3->createPresignedRequest($cmd, '+10 seconds');
$url = (string) $req->getUri();
```

#### 删除文件

```php
$resp = $cli->deleteObject([
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
```

#### 获取文件的ACL

```php
$resp = $cli->getObjectAcl([
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
```

#### 设置文件的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->putObjectAcl([
    'ACL' => 'public-read-write',
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
```

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```php
$resp = $cli->putObjectAcl([
    'AccessControlPolicy' => [
        'Grants' => [
            [
                'Grantee' => [
                    'ID' => 'user_foo', //请替换为真实存在的用户
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'WRITE',
            ],
            [
                'Grantee' => [
                    'ID' => 'your-user-name',
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'FULL_CONTROL',
            ],

        ],
        'Owner' => [
            'ID' => 'your-user-name',
        ],
    ],
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
]);
```


### 桶操作接口

#### 创建桶

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->createBucket([
    'Bucket' => 'test-bucket-xxx',
    'ACL' => 'public-read',
]);
```

#### 列出桶中所包含的文件, 每次最多返回1000个文件

```php
$resp = $cli->listObjects([
    'Bucket' => 'test-bucket-xxx',
    'Prefix' => '',
    'Marker' => '',
]);
```

#### 列出桶中所包含的所有文件

```php
$marker = '';
while (true):
    $resp = $cli->listObjects([
        'Bucket' => 'test-bucket-xxx',
        'Marker' => $marker,
    ]);

    if($resp['Contents'] == NULL)
    {
        break;
    }

    foreach($resp['Contents'] as $content)
    {
        var_dump($content['Key']);
        $marker = $content['Key'];
    }
endwhile;
```

#### 删除桶

```php
$resp = $cli->deleteBucket([
    'Bucket' => 'test-bucket-xxx',
]);
```

#### 获取桶的ACL

```php
$resp = $cli->getBucketAcl([
    'Bucket' => 'test-bucket-xxx',
]);
```

#### 设置桶的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->putBucketAcl([
    'ACL' => 'public-read-write',
    'Bucket' => 'test-bucket-xxx',
]);
```

##### 使用自定义的ACL：

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```php
$resp = $cli->putBucketAcl([
    'AccessControlPolicy' => [
        'Grants' => [
            [
                'Grantee' => [
                    'ID' => 'user_foo', //请替换为真实存在的用户
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'WRITE',
            ],
            [
                'Grantee' => [
                    'ID' => 'your-user-name',
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'FULL_CONTROL',
            ],

        ],
        'Owner' => [
            'ID' => 'your-user-name',
        ],
    ],
    'Bucket' => 'test-bucket-xxx',
]);
```


### 服务操作接口

#### 列出所有的桶

```php
$resp = $cli->listBuckets([
]);
```

AWS 官方 SDK [aws-sdk-php](https://aws.amazon.com/sdk-for-php/)
接口详细文档 [api-reference](http://docs.aws.amazon.com/aws-sdk-php/v3/api/class-Aws.S3.S3Client.html)
