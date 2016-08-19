## Node.js Demo
```Node.js

目录：

初始化，设置帐号信息和域名

一，文件操作接口：
    1，上传文件：
        1.1，使用putObject接口上传：
        1.2，使用upload接口上传（适合大文件上传，支持自动分块，多块并行上传）：
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

var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.accessKeyId = 'ziw5dp1alvty9n47qksu'; //请替换为您自己的access_key
AWS.config.secretAccessKey = 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'; //请替换为您自己的secret_key
AWS.config.region = 'us-west-1';
AWS.config.endpoint = 'http://s2.i.qingcdn.com';
AWS.config.s3ForcePathStyle = true

var s3 = new AWS.S3();


一，文件操作接口：

    1，上传文件：

        1.1，使用putObject接口上传：
            ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                ACL: 'public-read',
                Body: new Buffer('blablabla')
            };
            s3.putObject(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

        1.2，使用upload接口上传（适合大文件上传，支持自动分块，多块并行上传）：

            var file_stream = fs.createReadStream('/root/test.mp4')
            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                Body: file_stream,
                ACL: 'public-read'
            }
            var options = {partSize: 10 * 1024 * 1024, queueSize: 10}
            s3.upload(params, options, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

    2，下载文件：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.getObject(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    3，获取文件的URL：
        获取已签名的URL用来下载文件，可通过参数Expires设置签名过期时间。

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx',
            Expires: 60
        };
        var url = s3.getSignedUrl('getObject', params);
        console.log('The URL is', url);

    4，删除文件：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.deleteObject(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    5，获取文件的ACL：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.getObjectAcl(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    6，设置文件的ACL：

        6.1， 使用预定义的ACL：
            支持的预定义ACL有：'private', 'public-read', 'public-read-write'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                ACL: 'public-read'
            };
            s3.putObjectAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

        6.2， 使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                AccessControlPolicy: {
                    Grants: [
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'user-foo'
                            },
                            Permission: 'WRITE'
                        },
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'your-user-name'
                            },
                            Permission: 'FULL_CONTROL'
                        },
                    ],
                    Owner: {
                        ID: 'your-user-name'
                    }
                }
            };
            s3.putObjectAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });


二，桶操作接口：

    1，创建桶：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        var params = {
            Bucket: 'test-bucket-xxx',
            ACL: 'public-read'
        };
        s3.createBucket(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    2，列出桶中所包含的文件：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.listObjects(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    3，删除桶：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.deleteBucket(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    4，获取桶的ACL：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.getBucketAcl(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    5，设置桶的ACL：
        5.1，使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            var params = {
                Bucket: 'test-bucket-xxx',
                AccessControlPolicy: {
                    Grants: [
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'user-foo'
                            },
                            Permission: 'WRITE'
                        },
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'your-user-name'
                            },
                            Permission: 'FULL_CONTROL'
                        },
                    ],
                    Owner: {
                        ID: 'your-user-name'
                    }
                }
            };
            s3.putBucketAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });


三，服务操作接口：

    1，列出所有的桶：

        s3.listBuckets(function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });
```
