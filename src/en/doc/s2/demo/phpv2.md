## PHP Demo (V2)

 System Requirement: 
 - PHP version>=5.3.3 and compiled with the cURL, JSON, and XML extensions. 
 - A recent version of cURL 7.16.2+ compiled with OpenSSL and Zlib

### Install the AWS SDK for PHP
 
```
curl -O https://docs.aws.amazon.com/aws-sdk-php/v2/download/aws.phar
```

 Initialization & Set the account information and the domain name

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

### File Operation API 

#### File Upload

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authenticated-read'. And the developer needs to fill in the Body line with the File's content.

```php
$resp = $cli->putObject(array(
	'ACL' => 'public-read',
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
	'ContentType' => 'image/jpeg',
	'Body' => 'file content as a string'
));
```

#### Using the 'upload' interface (It suits to upload the large File, it supports dividing the File into different blocks automatically and uploading those blocks simultaneously.)

```
$resp = $cli->upload('test-bucket-xxx',
	'test-key-xxx', fopen('path/to/my/file/test.txt', 'r'));
```

#### Upload the entire directory. (The necessary parameters are the local directory to be uploaded, the name of the bucket, and the prefix needed )

```
$resp = $cli->uploadDirectory('/root/mydata\_dir',
	'test-bucket-xxx',
	''
);
```
#### File Download

```php
$resp = $cli->getObject(array(
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));
```

#### Download the File to the local directory. The necessary parameters are the file storage directory, the name of the bucket, and the prefix of the File to be downloaded

```
$resp = $cli->downloadBucket('/root/download\_dir',
	'test-bucket-xxx',
	''
);
```

#### Get File URL

Get the pre-signed URL to download the File, and the developer could set an expired time.

```php
$cmd = $cli->getCommand('GetObject', array(
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));

$url = $cmd->createPresignedUrl('+100 seconds');
```

#### File Delete

```php
$resp = $cli->deleteObject(array(
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));
```

#### Get File ACL

```php
$resp = $cli->getObjectAcl(array(
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));
```

#### Set File ACL

##### Using the pre-defined ACL

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authentication-read'

```php
$resp = $cli->putObjectAcl(array(
	'ACL' => 'public-read-write',
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));
```

##### Using the custom ACL

The permitted values of Permission are 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', and 'READ_ACP'

```php
$resp = $cli->putObjectAcl(array(
	'Grants' => array(
		array(
			'Grantee' => array(
				'ID' => 'user\_foo', //请替换为真实存在的用户
				'Type' => 'CanonicalUser',
			),
			'Permission' => 'FULL\_CONTROL',
		),
	),
	'Owner' => array(
		'ID' => 'your-user-name',
	),
	'Bucket' => 'test-bucket-xxx',
	'Key' => 'test-key-xxx',
));
```


### Bucket operation API

#### Bucket Create

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authentication-read'

```php
$resp = $cli->createBucket(array(
	'Bucket' => 'test-bucket-xxx',
	'ACL' => 'public-read',
));
```

#### List all the files contained on the bucket. The max number of returning files at the same time is 1000

```php
$resp = $cli->listObjects(array(
	'Bucket' => 'test-bucket-xxx',
	'Prefix' => '',
	'Marker' => '',
));
```

#### List all the files contained on the bucket.

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

#### Bucket Delete

```php
$resp = $cli->deleteBucket(array(
	'Bucket' => 'test-bucket-xxx',
));
```

#### Get Bucket ACL

```php
$resp = $cli->getBucketAcl(array(
	'Bucket' => 'test-bucket-xxx',
));
```
#### Set Bucket ACL

##### Using the pre-defined ACL

The permitted values of ACL are 'private', 'public-read', 'public-read-write', and 'authentication-read'.

```php
$resp = $cli->putBucketAcl(array(
	'ACL' => 'public-read-write',
	'Bucket' => 'test-bucket-xxx',
));
```

##### Using the custom ACL

The permitted values of Permission are 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', and 'READ_ACP'
 
```php
$resp = $cli->putBucketAcl(array(
	'Grants' => array(
		array(
			'Grantee' => array(
				'ID' => 'user\_foo', //请替换为真实存在的用户
				'Type' => 'CanonicalUser',
			),
			'Permission' => 'FULL\_CONTROL',
		),
	),
	'Owner' => array(
		'ID' => 'your-user-name',
	),
	'Bucket' => 'test-bucket-xxx',
));
```


### Service Operation API

#### Buckets List (List all the Buckets of your service)

```php
$resp = $cli->listBuckets();
```

Official AWS SDK for PHP: [aws-sdk-php](https://aws.amazon.com/sdk-for-php/)
API documentation: [api-reference](http://docs.aws.amazon.com/aws-sdk-php/v2/api/class-Aws.S3.S3Client.html)
