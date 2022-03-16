## Node.js Demo

### Install the AWS SDK for JavaScript in Node.js

```
npm install aws-sdk
```

### Initialization & Set the account information and the domain name

```javascript

var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.accessKeyId = 'ziw5dp1alvty9n47qksu'; // Please change the example value to your access_key
AWS.config.secretAccessKey = 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'; // Please change the example value to your secret_key
AWS.config.region = 'us-west-1';
AWS.config.endpoint = 'http://ss.bscstorage.com';
AWS.config.s3ForcePathStyle = true

var s3 = new AWS.S3();

```


### File Operation API

#### File Upload

##### Using ‘putObject’ API to upload the File

The permitted values of ACL are private, public-read, public-read-write, and authenticated-read. 

```javascript
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
```

##### Using the 'upload' interface (It suits to upload the large File, it supports dividing the File into different blocks automatically and uploading those blocks simultaneously.)

```javascript
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
```

#### File Download

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    Key: 'test-key-xxx'
};
s3.getObject(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Get File URL

Get the pre-signed URL to download the File, and the developer could set an expired time.

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    Key: 'test-key-xxx',
    Expires: 60
};
var url = s3.getSignedUrl('getObject', params);
console.log('The URL is', url);
```

#### File Delete

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    Key: 'test-key-xxx'
};
s3.deleteObject(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Get File ACL

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    Key: 'test-key-xxx'
};
s3.getObjectAcl(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Set File ACL

#####  Using pre-defined ACL

The permitted values of ACL are private, public-read, public-read-write, and authentication-read

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    Key: 'test-key-xxx',
    ACL: 'public-read'
};
s3.putObjectAcl(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

##### Using custom ACL

The permitted values of Permission are FULL_CONTROL, WRITE, WRITE_ACP, READ, and READ_ACP

```javascript
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
```


### Bucket Operation API

#### Bucket Create

The permitted values of ACL are private, public-read, public-read-write, and authentication-read

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    ACL: 'public-read'
};
s3.createBucket(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### List all the files contained on the bucket.

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
};
s3.listObjects(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Bucket Delete

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
};
s3.deleteBucket(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Get Bucket ACL

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
};
s3.getBucketAcl(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

#### Set Bucket ACL

#####  Using pre-defined ACL

The permitted values of ACL are private, public-read, public-read-write, and authentication-read.

```javascript
var params = {
    Bucket: 'test-bucket-xxx',
    ACL: 'public-read'
};
s3.putBucketAcl(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

##### Using custom ACL

The permitted values of Permission are FULL\_CONTROL, WRITE, WRITE\_ACP, READ, and READ\_ACP

```javascript
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
```


### Service Operation API

#### Buckets List (List all the Buckets of your service)


```javascript
s3.listBuckets(function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
});
```

The link of the official AWS SDK for Node.js: [aws-sdk-node.js](https://aws.amazon.com/sdk-for-node-js/)

The link of API documentation: [api-reference](http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html)
