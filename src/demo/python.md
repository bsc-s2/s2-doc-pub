## Python Demo

安装AWS Python 客户端boto3

```
pip install boto3
```

使用实例

```python

目录：

初始化，设置帐号信息和域名

一，文件操作接口：
    1，上传文件：
        1.1，使用put_object接口上传：
        1.2，使用upload_file接口上传（适合大文件上传，支持自动分块，多块并行上传）：
    2，下载文件：
    3，获取文件的URL：
    4，删除文件：
    5，获取文件的ACL：
    6，设置文件的ACL：
        6.1， 使用预定义的ACL：
        6.2， 使用自定义的ACL：

二，桶操作接口：
    1，创建桶：
    2，列出桶中所包含的文件：
    3，删除桶：
    4，获取桶的ACL：
    5，设置桶的ACL：
        5.1，使用自定义的ACL：

三，服务操作接口：
    1，列出所有的桶：



初始化，设置帐号信息和域名

import boto3
from boto3.s3.transfer import TransferConfig

cli = boto3.client(
    's3',
    aws_access_key_id='ziw5dp1alvty9n47qksu',
    aws_secret_access_key='V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV',
    endpoint_url='http://s2.i.qingcdn.com'
)


一，文件操作接口：

    1，上传文件：

        1.1，使用put_object接口上传：
            ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

            resp = cli.put_object(
                ACL='public-read',
                Bucket='test-bucket-xxx',
                Key='test-key-xxx',
                Body='the content of the file as a string'
            )

        1.2，使用upload_file接口上传（适合大文件上传，支持自动分块，多块并行上传）：

            config = TransferConfig(
                multipart_threshold=30 * 1024 * 1024,
                multipart_chunksize=8 * 1024 * 1024,
                max_concurrency=10
            )
            resp = cli.upload_file(
                '/root/test.mp4',
                'test-bucket-xxx',
                'test-key-xxx',
                Config=config
            )

    2，下载文件：

        resp = cli.get_object(
            Bucket='test-bucket-xxx',
            Key='test-key-xxx'
        )

    3，获取文件的URL：
        获取已签名的URL用来下载文件，可通过参数ExpiresIn设置签名过期时间。

        url = cli.generate_presigned_url(
            'get_object',
            Params={
                'Bucket': 'test-bucket-xxx',
                'Key': 'test-key-xxx'
            },
            ExpiresIn=60
        )
        print url

    4，删除文件：

        resp = cli.delete_object(
            Bucket='test-bucket-xxx',
            Key='test-key-xxx'
        )

    5，获取文件的ACL：

        resp = cli.get_object_acl(
            Bucket='test-bucket-xxx',
            Key='test-key-xxx'
        )

    6，设置文件的ACL：

        6.1， 使用预定义的ACL：
            支持的预定义ACL有：'private', 'public-read', 'public-read-write'

            resp = cli.put_object_acl(
                ACL='public-read',
                Bucket='test-bucket-xxx',
                Key='test-key-xxx'
            )

        6.2， 使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            resp = cli.put_object_acl(
                AccessControlPolicy={
                    'Grants': [
                        {
                            'Grantee': {
                                'ID': 'user_foo',
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


二，桶操作接口：

    1，创建桶：
       ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        resp = cli.create_bucket(
            ACL='public-read',
            Bucket='test-bucket-xxx'
        )

    2，列出桶中所包含的文件：

        resp = cli.list_objects(
            Bucket='test-bucket-xxx'
        )

    3，删除桶：

        resp = cli.delete_bucket(
            Bucket='test-bucket-xxx'
        )

    4，获取桶的ACL：

        resp = cli.get_bucket_acl(
            Bucket='test-bucket-xxx'
        )

    5，设置桶的ACL：
        5.1，使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            resp = cli.put_bucket_acl(
                AccessControlPolicy={
                    'Grants': [
                        {
                            'Grantee': {
                                'ID': 'user_foo',
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


三，服务操作接口：

    1，列出所有的桶：

        resp = cli.list_buckets()

```
AWS 官方 SDK <a href="https://github.com/boto/boto3">aws-sdk-python</a>
