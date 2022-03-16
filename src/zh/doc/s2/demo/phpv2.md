## PHP Demo (v2)

系统需求：

- PHP 5.3.3+ compiled with the cURL, JSON, and XML extensions
- A recent version of cURL 7.16.2+ compiled with OpenSSL and zlib

### 安装AWS SDK for PHP

```
curl -O http://docs.aws.amazon.com/aws-sdk-php/v2/download/aws.phar
```

初始化，设置帐号信息和域名

```php
require 'aws.phar';

$cli = Aws\S3\S3Client::factory(array(
    'endpoint' => 'http://ss.bscstorage.com',
    'credentials' => array(
        'key' => 'your access key',
        'secret' => 'your secret key',
    ),
    'region' => 'us-east-1',
));
```


### 文件操作接口

#### 上传文件

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'
Body 为文件的内容

```php
$resp = $cli->putObject(array(
    'ACL' => 'public-read',
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
    'ContentType' => 'image/jpeg',
    'Body' => 'file content as a string'
));
```

#### 使用upload接口上传，适合大文件上传，支持自动分片上传

```
$resp = $cli->upload('test-bucket-xxx',
    'test-key-xxx', fopen('path/to/my/file/test.txt', 'r'));
```

#### 上传整个目录, 参数分别为需要上传的本地目录，bucket的名字，添加的前缀

```
$resp = $cli->uploadDirectory('/root/mydata_dir',
    'test-bucket-xxx',
    ''
);
```

#### 下载文件

```php
$resp = $cli->getObject(array(
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));
```

#### 下载文件到本地目录, 参数分别是文件保存目录，bucket的名字，要下载的文件的前缀

```
$resp = $cli->downloadBucket('/root/download_dir',
    'test-bucket-xxx',
    ''
);
```

#### 获取文件的URL

获取已签名的URL用来下载文件，可设置签名过期时间。

```php
$cmd = $cli->getCommand('GetObject', array(
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));

$url = $cmd->createPresignedUrl('+100 seconds');
```

#### 删除文件

```php
$resp = $cli->deleteObject(array(
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));
```

#### 获取文件的ACL

```php
$resp = $cli->getObjectAcl(array(
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));
```

#### 设置文件的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->putObjectAcl(array(
    'ACL' => 'public-read-write',
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));
```

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```php
$resp = $cli->putObjectAcl(array(
    'Grants' => array(
        array(
            'Grantee' => array(
                'ID' => 'user_foo', //请替换为真实存在的用户
                'Type' => 'CanonicalUser',
            ),
            'Permission' => 'FULL_CONTROL',
        ),
    ),
    'Owner' => array(
        'ID' => 'your-user-name',
    ),
    'Bucket' => 'test-bucket-xxx',
    'Key' => 'test-key-xxx',
));
```


### 桶操作接口

#### 创建桶

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->createBucket(array(
    'Bucket' => 'test-bucket-xxx',
    'ACL' => 'public-read',
));
```

#### 列出桶中所包含的文件, 每次最多返回1000个文件

```php
$resp = $cli->listObjects(array(
    'Bucket' => 'test-bucket-xxx',
    'Prefix' => '',
    'Marker' => '',
));
```

#### 列出桶中所包含的所有文件

```php
$marker = '';
while (true):
    $resp = $cli->listObjects(array(
        'Bucket' => 'test-bucket-xxx',
        'Marker' => $marker,
    ));

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
$resp = $cli->deleteBucket(array(
    'Bucket' => 'test-bucket-xxx',
));
```

#### 获取桶的ACL

```php
$resp = $cli->getBucketAcl(array(
    'Bucket' => 'test-bucket-xxx',
));
```

#### 设置桶的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```php
$resp = $cli->putBucketAcl(array(
    'ACL' => 'public-read-write',
    'Bucket' => 'test-bucket-xxx',
));
```

##### 使用自定义的ACL：

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```php
$resp = $cli->putBucketAcl(array(
    'Grants' => array(
        array(
            'Grantee' => array(
                'ID' => 'user_foo', //请替换为真实存在的用户
                'Type' => 'CanonicalUser',
            ),
            'Permission' => 'FULL_CONTROL',
        ),
    ),
    'Owner' => array(
        'ID' => 'your-user-name',
    ),
    'Bucket' => 'test-bucket-xxx',
));
```


### 服务操作接口

#### 列出所有的桶

```php
$resp = $cli->listBuckets();
```

AWS 官方 SDK [aws-sdk-php](https://aws.amazon.com/sdk-for-php/)
接口详细文档 [api-reference](http://docs.aws.amazon.com/aws-sdk-php/v2/api/class-Aws.S3.S3Client.html)
