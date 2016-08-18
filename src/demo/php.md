## PHP Demo
```php

目录：

初始化，设置帐号信息和域名

一，文件操作接口：
    1，上传文件：
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

require 'aws.phar';
$cli = new Aws\S3\S3Client([
    'version' => 'latest',
    'region' => 'us-east-1',
    'credentials' => [
        'key' => 'z2qutjf718d0i9gw6skc',
        'secret' => 'SEQgcc1ppH7uXPG4ZPIcrCv2cWz8grcReMfFABCn',
    ],
    'endpoint' => 'http://s2.i.qingcdn.com',
]);


一，文件操作接口：

    1，上传文件：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        $resp = $cli->putObject([
            'ACL' => 'public-read',
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
            'Body' => 'file content as a string'
        ]);

    2，下载文件：

        $resp = $cli->getObject([
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
        ]);

    3，获取文件的URL：
        获取已签名的URL用来下载文件，可设置签名过期时间。

        $cmd = $cli->getCommand('GetObject', [
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
        ]);
        $req = $s3->createPresignedRequest($cmd, '+10 seconds');
        $url = (string) $req->getUri();

    4，删除文件：

        $resp = $cli->deleteObject([
            'Bucket' => 'test-bucket-xxx',
            'key' => 'test-key-xxx',
        ]);

    5，获取文件的ACL：

        $resp = $cli->getObjectAcl([
            'Bucket' => 'test-bucket-xxx',
            'key' => 'test-key-xxx',
        ]);

    6，设置文件的ACL：

        6.1， 使用预定义的ACL：
            支持的预定义ACL有：'private', 'public-read', 'public-read-write'

            $resp = $cli->putObjectAcl([
                'ACL' => 'public-read-write',
                'Bucket' => 'test-bucket-xxx',
                'Key' => 'test-key-xxx',
            ]);

        6.2， 使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            $resp = $cli->putObjectAcl([
                'AccessControlPolicy' => [
                    'Grants' => [
                        [
                            'Grantee' => [
                                'ID' => 'user_foo',
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


二，桶操作接口：

    1，创建桶：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        $resp = $cli->createBucket([
            'Bucket' => 'test-bucket-xxx',
            'ACL' => 'public-read',
        ]);

    2，列出桶中所包含的文件：

        $resp = $cli->listObjects([
            'Bucket' => 'test-bucket-xxx',
        ]);

    3，删除桶：

        $resp = $cli->deleteBucket([
            'Bucket' => 'test-bucket-xxx',
        ]);

    4，获取桶的ACL：

        $resp = $cli->getBucketAcl([
            'Bucket' => 'test-bucket-xxx',
        ]);

    5，设置桶的ACL：
        5.1，使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            $resp = $cli->putBucketAcl([
                'AccessControlPolicy' => [
                    'Grants' => [
                        [
                            'Grantee' => [
                                'ID' => 'user_foo',
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


三，服务操作接口：

    1，列出所有的桶：

        $resp = $cli->listBuckets([
        ]);
```
