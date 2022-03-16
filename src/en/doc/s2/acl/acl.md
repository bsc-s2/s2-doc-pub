### ACL(Access Control List)
-------------------

Access control lists (ACL) enable you to manage access to buckets and objects. Each bucket and object has an additional ACL sub resource. It defines which users or groups will be granted access rights. After receiving a request for a resource (bucket or object), S2 will check the corresponding ACL to verify whether the requester has the required access rights.

When creating a bucket or object, S2 will create a default ACL to grant the resource owner full control over the resource, as shown in the following example bucket ACL.

```
<?xml version="1.0" encoding="UTF-8"?>
<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Owner>
        <ID>*** Owner-Canonical-User-ID ***</ID>
        <DisplayName>owner-display-name</DisplayName>
    </Owner>
    <AccessControlList>
        <Grant>
            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Canonical User">
                <ID>*** Owner-Canonical-User-ID ***</ID>
                <DisplayName>display-name</DisplayName>
            </Grantee>
            <Permission>FULL_CONTROL</Permission>
        </Grant>
    </AccessControlList>

</AccessControlPolicy>

```

The example ACL contains an owner element that represents the user name of the resource owner. The grant element represents the authorized person (user or predefined group) and the permissions granted. You can grant permissions by adding the grant element.

#### Grantee

The authorized person can be an S2 user or a predefined S2 group. You can grant permissions to a user by email address or user name. However, if you set an email address in the authorization request, S2 will find the user name corresponding to the email and add it to the ACL. The generated ACL will always contain the S2 user's user name, not the user's email address.

#### S2 predefined groups


S2 has a series of predefined groups. When granting user access to a group, you can specify a URI instead of a user name. We provide the following predefined groups:

- All Users group, identified by http://acs.amazonaws.com/groups/global/AllUsers. The access rights of this group allow anyone to access the resource. Requests can be signed (authenticated) or unsigned (anonymous).

- Log Delivery group, identified by http://acs.amazonaws.com/groups/s3/LogDelivery, the WRITE permission on the storage bucket allows this group to write server access logs to the storage bucket.

#### Specify the permissions of the authorized person

The following table lists the permission sets supported by S2 in ACL and its meaning in the context of operation resources.

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Permission</th>
            <th>When authorizing on the storage bucket</th>
            <th>When authorizing on an object</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>READ</td>
            <td>The authorizer is allowed to list all objects in the bucket</td>
            <td>Allow the authorized person to read the data and meta information of the object</td>
          </tr>
          <tr>
            <td>WRITE</td>
            <td>Allows authorized persons to create, overwrite, and delete objects in buckets</td>
            <td>Not available</td>
          </tr>

          <tr>
            <td>READ_ACP</td>
            <td>Allow authorized persons to read buckets ACL</td>
            <td>允许被授权者读取对象的ACL</td>
          </tr>
          <tr>
            <td>WRITE_ACP</td>
            <td>Allows the authorized person to modify the ACL of the bucket</td>
            <td>Allows the authorized person to modify the ACL of an object</td>
          </tr>
          <tr>
            <td>FULL_CONTROL</td>
            <td>Allow the authorized person to READ、WRITE、READ_ACP and WRITE_ACPpermissions</td>
            <td>Allow the authorized person on the objectREAD、READ_ACP 和WRITE_ACP permissions</td>
          </tr>
        </tbody>
</table>

#### Canned ACL

S2 supports a series of predefined authorizations, called standard ACLs. each standard ACL has a predefined set of authorized persons and permissions. The following table lists a set of standard ACLs and the associated predefined authorizations.

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Canned ACL</th>
            <th>Applicable for</th>
            <th>Corresponding ACL permissions</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>private</td>
            <td>Buckets and objects</td>
            <td>The owner will get  FULL_CONTROL。Others do not have access (default).</td>
          </tr>
          <tr>
            <td>public-read</td>
            <td>Buckets and objects</td>
            <td>The owner will get FULL_CONTROL。Anonymous users have READpermissions</td>
          </tr>
          <tr>
            <td>public-read-write</td>
            <td>Buckets and objects</td>
            <td>The owner will get FULL_CONTROL。AllUsers have READ, WRITEpermissions,Object no WRITE permissions</td>
          </tr>
          <tr>
            <td>authenticated-read</td>
            <td>Buckets and objects</td>
            <td>The owner will get FULL_CONTROL。AuthenticatedUsers have READ</td>
          </tr>
       </tbody>
</table>

#### How to specify ACL

The S2 API allows you to set ACL when creating buckets or objects. S2 also provides an API to set ACL on existing buckets or objects. These APIs provide you with the following methods to set ACL:

- Set ACL with request header - When sending a request to create a resource (bucket or object), you can use the x-amz-acl header to set the Canned acl, or the x-amz-grant-* header to set the permissions for a user or group.

- Set ACL using ACL API - When you send a request to set an ACL on an existing resource, you can set the ACL in the request header or body, such as the put_object_acl API

<b>Attention</b>:

- x-amz-acl and x-amz-grant-* cannot be specified at the same time, both of them return 400 errors
- If x-amz-acl or x-amz-grant-* request header is specified in the put_object_acl API, the ACL in the body is ignored.


#### x-amz-grant-* request header type

x-amz-grant-* the value of the request header is in the form of a type = value , each tpye = value is separated by commas. Multiple x-amz-grant-* request headers can be specified in the same request. The allowed types are:
- emailAddress, User's email address
- id, user name
- uri, Uri for predefined user groups

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>x-amz-grant-read</td>
            <td>Permission to allow the authorizer to READ</td>
          </tr>
          <tr>
            <td>x-amz-grant-write</td>
            <td>Permission to allow the authorizer to WRITE</td>
          </tr>
          <tr>
            <td>x-amz-grant-read-acp</td>
            <td>Permission to allow the authorizer to READ_ACP</td>
          </tr>
          <tr>
            <td>x-amz-grant-write-acp</td>
            <td>Permission to allow the authorizer to WRITE_ACP</td>
          </tr>
          </tr>
          <tr>
            <td>x-amz-grant-full-control</td>
            <td>Permission to allow the authorizer to READ, WRITE, READ_ACP, WRITE_ACP</td>
            </tr>
       </tbody>
</table>

Example:

```
x-amz-grant-read: emailAddress="xyz@amazon.com", emailAddress="abc@amazon.com"
```
