## PHP Demo
```php
<?php
require 'aws.phar';
//first get a client
$cli = new Aws\S3\S3Client([
    'version' => 'latest',
    'region' => 'us-east-1',
    'endpoint' => 'http://s2.i.qingcdn.com',
    'credentials' => [
        'key' => 'z2qutjf718d0i9gw6skc', //change to your access key
        'secret' => 'SEQgcc1ppH7uXPG4ZPIcrCv2cWz8grcReMfFABCn', //change to your secret key
    ],
]);
///////////////////////////// Service APIs ////////////////////////////////////
//list all you buckets
$resp = $cli->listBuckets([
]);
///////////////////////////// Bucket APIs ////////////////////////////////////
//create a bucket
$resp = $cli->createBucket([
    'Bucket' => 'a-valid-bucket-name', //you specify a bucket name
    'ACL' => 'public-read', //you can omit this line to use the default ACL,
                            //the default is 'private'
                            //also can be set to 'public-read-write'
]);
//list objects in a bucket
$resp = $cli->listObjects([
    'Bucket' => 'bucket-name-xxx',
]);
//delete a bucket
$resp = $cli->deleteBucket([
    'Bucket' => 'bucket-name-xxx',
]);
//get bucket ACL
$resp = $cli->getBucketAcl([
    'Bucket' => 'bucket-name-xxx',
]);
//put bucket ACL
//use predefined ACL: 'private' or 'public-read' or 'public-read-write'
$resp = $cli->putBucketAcl([
    'ACL' => 'public-read-write',
    'Bucket' => 'bucket-name-xxx',
]);
//put bucket ACL
//use AccessControlPolicy
//this example grant permission 'WRITE' to user 'user_foo'
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
                    'ID' => 'bob', //the owner of the bucket
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'FULL_CONTROL',
            ],
        ],
        'Owner' => [
            'ID' => 'bob',
        ],
    ],
    'Bucket' => 'bucket-name-xxx',
]);
///////////////////////////// Bucket APIs ////////////////////////////////////
//put object
$resp = $cli->putObject([
    'ACL' => 'public-read', //omit this line to use the default ACL
    'Bucket' => 'bucket-name-xxx', //an exist bucket
    'Key' => 'object-name-xxx', //you specify a name for the object
    'Body' => 'file content as a string'
]);
//get object
$resp = $cli->getObject([
    'Bucket' => 'bucket-name-xxx',
    'Key' => 'object-name-xxx',
]);
//delete object
$resp = $cli->deleteObject([
    'Bucket' => 'bucket-name-xxx',
    'key' => 'object-name-xxx',
]);
//get object ACL
$resp = $cli->getObjectAcl([
    'Bucket' => 'bucket-name-xxx',
    'key' => 'object-name-xxx',
]);
//put object ACL
//use predefined ACL: 'private' or 'public-read' or 'public-read-write'
$resp = $cli->putObjectAcl([
    'ACL' => 'public-read-write',
    'Bucket' => 'bucket-name-xxx',
    'Key' => 'object-name-xxx',
]);
//put object ACL
//use AccessControlPolicy
//this example grant permission 'WRITE' to user 'user_foo'
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
                    'ID' => 'bob', //the owner of the bucket
                    'Type' => 'CanonicalUser',
                ],
                'Permission' => 'FULL_CONTROL',
            ],
        ],
        'Owner' => [
            'ID' => 'bob',
        ],
    ],
    'Bucket' => 'bucket-name-xxx',
    'Key' => 'object-name-xxx',
]);
```
