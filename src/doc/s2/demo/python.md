## Python Demo

### 安装AWS Python 客户端boto3

```
pip install boto3
```

### 初始化，设置帐号信息和域名

```python

import boto3
from boto3.s3.transfer import TransferConfig

cli = boto3.client(
    's3',
    aws_access_key_id='ziw5dp1alvty9n47qksu', #请替换为您自己的access_key
    aws_secret_access_key='V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV', #请替换为您自己的secret_key
    endpoint_url='http://ss.bscstorage.com'
)

```


### 文件操作接口

#### 上传文件

##### 使用put_object接口上传

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'

```python
resp = cli.put_object(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx',
    ContentType='image/jpeg', # 请替换为合适的文件类型
    Body='the content of the file as a string'
)
```

##### 使用upload_file接口上传（适合大文件上传，支持自动分块，多块并行上传）

```python
config = TransferConfig(
    multipart_threshold=30 * 1024 * 1024,
    multipart_chunksize=8 * 1024 * 1024,
    max_concurrency=10
)
resp = cli.upload_file(
    '/root/test.mp4',
    'test-bucket-xxx',
    'test-key-xxx',
    ExtraArgs={
        'ContentType': 'image/jpeg', # 请替换为合适的文件类型
        'ACL': 'private',
    },
    Config=config
)
```

#### copy文件

copy源bucket中所有以`aa`前缀的文件到目标bucket中

```python
marker = ''

while True:
    resp = s3.list_objects(
        Bucket='src-bucket',
        Prefix='aa',
        Marker=marker,
    )

    if 'Contents' not in resp:
        break

    for content in resp['Contents']:
        s3.copy_object(Bucket='dst-bucket', Key=content['key'], CopySource='/%s/%s' % ('src-bucket', content['key']))

    marker = resp['Contents'][-1]['Key']
```

#### 下载文件

```python
resp = cli.get_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 获取文件的URL

获取已签名的URL用来下载文件，可通过参数ExpiresIn设置签名过期时间。

```python
url = cli.generate_presigned_url(
    'get_object',
    Params={
        'Bucket': 'test-bucket-xxx',
        'Key': 'test-key-xxx'
    },
    ExpiresIn=60
)
print url
```

#### 删除文件

```python
resp = cli.delete_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 获取文件的ACL

```python
resp = cli.get_object_acl(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 设置文件的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```python
resp = cli.put_object_acl(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```python
resp = cli.put_object_acl(
    AccessControlPolicy={
        'Grants': [
            {
                'Grantee': {
                    'ID': 'user_foo', # 请替换为真实存在的用户
                    'Type': 'CanonicalUser',
                },
                'Permission': 'WRITE',
            },
            {
                'Grantee': {
                    'ID': 'your-user-name',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'FULL_CONTROL',
            },
        ],
        'Owner': {
            'ID': 'your-user-name',
        },
    },
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```


### 桶操作接口

#### 创建桶

ACL可设置为：'private' 或 'public-read' 或 'public-read-write' 或 'authenticated-read'

```python
resp = cli.create_bucket(
    ACL='public-read',
    Bucket='test-bucket-xxx'
)
```

#### 列出桶中所包含的文件, 每次最多可以返回1000个文件

```python
resp = cli.list_objects(
    Bucket='test-bucket-xxx',
    Prefix='',
    Marker='',
)
```

#### 列出桶中所包含的所有文件

```python
marker = ''

while True:
    resp = s3.list_objects(
        Bucket='test-bucket-xxx',
        Marker=marker,
    )

    if 'Contents' not in resp:
        break

    for content in resp['Contents']:
        print 'key: %s, size: %d' % (content['Key'], content['Size'])

    marker = resp['Contents'][-1]['Key']
```

#### 删除桶

```python
resp = cli.delete_bucket(
    Bucket='test-bucket-xxx'
)
```

#### 获取桶的ACL

```python
resp = cli.get_bucket_acl(
    Bucket='test-bucket-xxx'
)
```

#### 设置桶的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```python
resp = cli.put_bucket_acl(
    ACL='public-read',
    Bucket='test-bucket-xxx',
)
```

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```python
resp = cli.put_bucket_acl(
    AccessControlPolicy={
        'Grants': [
            {
                'Grantee': {
                    'ID': 'user_foo', # 请替换为真实存在的用户
                    'Type': 'CanonicalUser',
                },
                'Permission': 'WRITE',
            },
            {
                'Grantee': {
                    'ID': 'your-user-name',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'FULL_CONTROL',
            },
        ],
        'Owner': {
            'ID': 'your-user-name',
        },
    },
    Bucket='test-bucket-xxx'
)
```


### 服务操作接口

#### 列出所有的桶

```python
resp = cli.list_buckets()
```

AWS 官方 SDK [aws-sdk-python](https://aws.amazon.com/sdk-for-python/)
接口详细文档 [api-reference](https://boto3.readthedocs.io/en/latest/reference/services/s3.html)
