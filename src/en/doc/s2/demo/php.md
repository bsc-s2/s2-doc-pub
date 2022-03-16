## PHP Demo

System Requirement: 
- PHP>=5.5.0

### Install the AWS SDK for PHP

```
curl -O http://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.phar
```
Initialization & Set the account information and the domain name

## Request Syntax
```php
 require 'aws.phar';
 $cli = new Aws\S3\S3Client([
 	'version' => 'latest',
	'region' => 'us-east-1',
 	'credentials' => [
 		'key' => 'z2qutjf718d0i9gw6skc',  //Please fill in it with your own access\_key
		'secret' => 'SEQgcc1ppH7uXPG4ZPIcrCv2cWz8grcReMfFABCn', // Please fill in it with your own secret\_key
	],
	'endpoint' => 'http://ss.bscstorage.com',
]);

```

### File Operation API 

#### File Upload

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authenticated-read'. 
If the file already exists in the storage, the developer could use 'Body' to call it. 
If the file is on disk, the developer could use 'SourceFile' to name the file. 
'Body' and 'SourceFile' cannot be used simultaneously.


```php
$resp = $cli->putObject([
	'ACL' => 'public-read',
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
	'ContentType' => 'image/jpeg',  //Please fill in it with the proper file type
	'Body' => 'file content as a string',
	//'SourceFile' => '/root/test.jpg',
]);
```

#### File Download

```php
$resp = $cli->getObject([
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
]);
```

#### Get File URL

Get the pre-signed URL to download the File, and the developer could set an expired time.

```php

$cmd = $cli->getCommand('GetObject', [
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
]);
$req = $cli->createPresignedRequest($cmd, '+10 seconds');
$url = (string) $req->getUri();
```

#### File Delete

```php
$resp = $cli->deleteObject([
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
]);
```

#### Get File ACL

```php
$resp = $cli->getObjectAcl([
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
]);
```

#### Set File ACL

##### Using the pre-defined ACL

The permitted values of ACL are private, public-read, public-read-write, and authentication-read.

```php
$resp = $cli->putObjectAcl([
	'ACL' => 'public-read-write',
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
]);
```

##### Using the custom ACL

The permitted values of Permission are 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', and 'READ_ACP'

```php
$resp = $cli->putObjectAcl([
	'AccessControlPolicy' => [
		'Grants' => [
			[
				'Grantee' => [
					'ID' => 'user_foo', //Please fill it with the existing user information.
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


### Bucket operation API

#### Bucket Create

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authentication-read'.

```php
$resp = $cli->createBucket([
	'Bucket' => 'test-bucket-xxx',
	'ACL' => 'public-read',
]);
```

#### List all the files contained on the bucket. The max number of returning files at the same time is 1000

```php
$resp = $cli->listObjects([
	'Bucket' => 'test-bucket-xxx',
	'Prefix' => '',
	'Marker' => '',
]);
```

#### List all the files contained on the bucket.


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

#### Bucket Delete

```php
$resp = $cli->deleteBucket([
	'Bucket' => 'test-bucket-xxx',
]);
```
#### Get Bucket ACL

```php
$resp = $cli->getBucketAcl([
	'Bucket' => 'test-bucket-xxx',
]);
```

#### Set Bucket ACL

##### Using the pre-defined ACL

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authentication-read'.

```php
$resp = $cli->putBucketAcl([
	'ACL' => 'public-read-write',
	'Bucket' => 'test-bucket-xxx',
]);
```
##### Using the custom ACL

The permitted values of Permission are 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', and 'READ_ACP'

```php
$resp = $cli->putBucketAcl([
	'AccessControlPolicy' => [
	'Grants' => [
			[
				'Grantee' => [
					'ID' => 'user\_foo', // Please fill it with the existing user information.
					'Type' => 'CanonicalUser',
				],
				'Permission' => 'WRITE',
			],
			[
				'Grantee' => [
					'ID' => 'your-user-name',
					'Type' => 'CanonicalUser',
				],
				'Permission' => 'FULL\_CONTROL',
			],

		],
		'Owner' => [
			'ID' => 'your-user-name',
		],
	],
	'Bucket' => 'test-bucket-xxx',
]);
```


### Service Operation API

#### Buckets List (List all the Buckets of your service)

```php
$resp = $cli->listBuckets([
]);
```
Note:
1.Official AWS SDK for PHP: [aws-sdk-php](https://aws.amazon.com/sdk-for-php/) 
1.API documentation: [api-reference](http://docs.aws.amazon.com/aws-sdk-php/v3/api/class-Aws.S3.S3Client.html)

