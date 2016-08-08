## Python Demo

安装AWS Python 客户端boto3

```
pip install boto3
```

使用实例

```python
import boto3
# first get a client
# change aws_access_key_id and aws_secret_access_key to your own
cli = boto3.client(
    's3',
    aws_access_key_id='ziw5dp1alvty9n47qksu',
    aws_secret_access_key='V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV',
    endpoint_url='http://s2.i.qingcdn.com'
)
############################ Service APIs ###################
# list all your buckets
resp = cli.list_buckets()
############################ Bucket APIs ####################
# create a bucket
resp = cli.create_bucket(
    ACL='public-read',   #omit this line to use default ACL
                         #the default is 'private'
    Bucket='a-valid-bucket-name' #you specify a name
)
# list objects in a bucket
resp = cli.list_objects(
    Bucket='bucket-name-xxx'
)
# delete a bucket
resp = cli.delete_bucket(
    Bucket='bucket-name-xxx'
)
# operate bucket ACL
## get bucket ACL
resp = cli.get_bucket_acl(
    Bucket='bucket-name-xxx'
)
## put bucket ACL
### use predefied ACL
### three options: 'private', 'public-read', 'public-read-write'
### in the following example we use 'public-read'
resp = cli.put_bucket_acl(
    ACL='public-read',
    Bucket='you-bucket-name-xxx'
)
### use AccessControlPolicy
### assume you want to give one of the following permissions to user 'user_foo'
### 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'
### take 'WRITE' for example
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
                    'ID': 'you-user-name',  #the owner of the bucket
                    'Type': 'CanonicalUser',
                },
            },
        ],
        'Owner': {
            'ID': 'you-user-name',  #the owner of the bucket
        },
    },
    Bucket='you-bucket-name-xxx'
)
############################ Object APIs ####################
# put object
resp = cli.put_object(
    ACL='public-read',  #omit this line to use the default
    Bucket='bucket-name-xxx', #an exist bucket
    Key='object-name-xxx',  #you specify a name for this object
    Body='the content of the file as a string'
)
# get an object
resp = cli.get_object(
    Bucket='bucket-name-xxx',
    Key='object-name-xxx'
)
# delete an object
resp = cli.delete_object(
    Bucket='bucket-name-xxx',
    Key='object-name-xxx'
)
# operate object ACL
## get object ACL
resp = cli.get_object_acl(
    Bucket='bucket-name-xxx',
    Key='object-name-xxx'
)
## put object ACL
### use predefied ACL
### three options: 'private', 'public-read', 'public-read-write'
### in the following example we use 'public-read'
resp = cli.put_object_acl(
    ACL='public-read',
    Bucket='bucket-name-xxx',
    Key='object-name-xxx'
)
### use AccessControlPolicy
### assume you want to give one of the following permissions to user 'user_foo'
### 'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'
### take 'WRITE' for example
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
                    'ID': 'you-user-name',  # the owner of the bucket
                    'Type': 'CanonicalUser',
                },
            },
        ],
        'Owner': {
            'ID': 'you-user-name',  # the owner of the bucket
        },
    },
    Bucket='bucket-name-xxx',
    Key='object-name-xxx'
)
# upload file
resp = cli.upload_file(
    '/root/test.mp4',  #change this to the name of an exsit file
    'bucket-name-xxx',  #an exist bucket
    'object-name-xxx'  #you specify a name
)
```

AWS 官方 SDK <a href="https://github.com/boto/boto3">aws-sdk-python</a>

