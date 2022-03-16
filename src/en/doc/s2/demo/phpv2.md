## Python Demo

### Install the AWS Python client – boto3

```
pip install boto3
```

### Initialization & account and domain setup

```python

import boto3
from boto3.s3.transfer import TransferConfig

cli = boto3.client(
    's3',
    aws_access_key_id='ziw5dp1alvty9n47qksu', #please replace with your access_key
    aws_secret_access_key='V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV', #please replace with your secret_key
    endpoint_url='http://ss.bscstorage.com'
)

```


###  File operation API

#### File Upload

##### Using the put_object interface

ACL can set as：'private' or 'public-read' or 'public-read-write' or 'authenticated-read'

```python
resp = cli.put_object(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx',
    ContentType='image/jpeg', # please replace with applicable content type
    Body='the content of the file as a string'
)
```

##### Using upload_file interface (It suits to upload the large File, it supports dividing the File into different blocks automatically and uploading those blocks simultaneously.)

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
        'ContentType': 'image/jpeg', # please replace with applicable content type
        'ACL': 'private',
    },
    Config=config
)
```

#### File Copy

Copy all files in the source bucket prefixed with `aa` to the target bucket

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

#### File Download

```python
resp = cli.get_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### Get File URL

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

#### File Delete

```python
resp = cli.delete_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### Get File ACL

```python
resp = cli.get_object_acl(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### Set File ACL

##### Using the pre-defined ACL

Support pre-defined ACL：'private', 'public-read', 'public-read-write' 或 'authenticated-read'

```python
resp = cli.put_object_acl(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

##### Using the custom ACL

Permission includes：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

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


### Bucket operation API

#### Bucket Create

ACL can be set as：'private' or 'public-read' or 'public-read-write' or 'authenticated-read'

```python
resp = cli.create_bucket(
    ACL='public-read',
    Bucket='test-bucket-xxx'
)
```

#### List Bucket File (List all the files contained on the bucket. The max number of returning files each time is 1000)

```python
resp = cli.list_objects(
    Bucket='test-bucket-xxx',
    Prefix='',
    Marker='',
)
```

#### List all the files contained in the bucket

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

####  Bucket Delete

```python
resp = cli.delete_bucket(
    Bucket='test-bucket-xxx'
)
```

#### Get Bucket ACL

```python
resp = cli.get_bucket_acl(
    Bucket='test-bucket-xxx'
)
```

#### Set Bucket ACL

##### Using the pre-defined ACL

Support pre-defined ACL：'private', 'public-read', 'public-read-write' or 'authenticated-read'

```python
resp = cli.put_bucket_acl(
    ACL='public-read',
    Bucket='test-bucket-xxx',
)
```

##### Using the custom ACL

Permission includes：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

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


### Service operation API

#### List all buckets

```python
resp = cli.list_buckets()
```

AWS Official SDK [aws-sdk-python](https://aws.amazon.com/sdk-for-python/)

API doc [api-reference](https://boto3.readthedocs.io/en/latest/reference/services/s3.html)
