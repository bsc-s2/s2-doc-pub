### ACL(Access Control List)


访问控制列表(ACL)使您可以管理存储桶(bucket)和对象(object)的访问权限。每个存储桶和对象都都有一个附加的ACL子资源。它定义了哪些用户或则组将被授予访问权限, 收到某个资源(存储桶或或者对象)的请求后，S2将检查相应的ACL以验证请求者是否拥有所需的访问权限。

创建存储桶或对象时，S2将创建一个默认ACL，以授予资源拥有者对资源的完全控制权限，如下面的示例存储桶ACL中所示。

```
<?xml version="1.0" encoding="UTF-8"?><AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/">    <Owner>        <ID>*** Owner-Canonical-User-ID ***</ID>        <DisplayName>owner-display-name</DisplayName>    </Owner>    <AccessControlList>        <Grant>            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Canonical User">                <ID>*** Owner-Canonical-User-ID ***</ID>                <DisplayName>display-name</DisplayName>            </Grantee>            <Permission>FULL_CONTROL</Permission>        </Grant>    </AccessControlList></AccessControlPolicy>

```

示例ACL包含一个Owner元素表示资源拥有者的用户名。Grant元素表示被授权者（用户或预定义的组）和所授予的权限。您可以通过添加Grant元素授予权限。

#### 被授权者(Grantee)

被授权者可以是s2用户或某个预定义的S2组。您可以通过email地址或用户名将权限授予某个用户。但是，如果您在授权请求设置的是email地址，S2将查找该email对应的用户名并将它添加到ACL。生成的ACL将始终包含的是s2用户的用户名，而不是用户的email地址。

#### S2预定义的组(Group)

S2拥有一系列预定义的组。将用户访问权限授予某个组时，您可以指定一个URI，而不是用户名。我们提供以下预定义的组：

- 经身份验证的用户组(Authenticated Users group), 由http://acs.amazonaws.com/groups/global/AuthenticatedUsers标识, 该组代表了所有的s2用户。该组的访问权限允许任何s2用户访问资源, 但是，所有的请求必须是已签名的（经身份验证)。
- 所有的用户组(All Users group), 由http://acs.amazonaws.com/groups/global/AllUsers标识。该组的访问权限允许任何人访问资源。请求可以是已签名的（经身份验证），也可以是未签名的（匿名）。- 日志传输组(Log Delivery group), 由http://acs.amazonaws.com/groups/s3/LogDelivery标识, 存储桶上的WRITE 许可使该组可以将服务器访问日志写入存储桶。
#### 可以指定被授权者的权限(Permissions)
下表列出了S2在ACL中支持的权限集及在操作资源语境中的含义。
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Permission</th>
            <th>当在存储桶上授权</th>
            <th>当在对象上授权</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>READ</td>
            <td>允许授权者列出bucket中所有的对象</td>
            <td>允许被授权者读取对象的数据和meta信息</td>
          </tr>
          <tr>
            <td>WRITE</td>
            <td>允许被授权者创建、覆盖和删除存储桶中的对象</td>
            <td>不可用</td>
          </tr>

          <tr>
            <td>READ_ACP</td>
            <td>允许被授权者读取存储桶ACL</td>
            <td>允许被授权者读取对象的ACL</td>
          </tr>
          <tr>
            <td>WRITE_ACP</td>
            <td>允许被授权者修改存储桶的ACL</td>
            <td>允许被授权者修改对象的ACL</td>
          </tr>
          <tr>
            <td>FULL_CONTROL</td>
            <td>允许被授权者在存储桶上的READ、WRITE、READ_ACP 和WRITE_ACP权限</td>
            <td>允许被授权者在对象上的READ、READ_ACP 和WRITE_ACP权限</td>
          </tr>
        </tbody>
</table>#### Canned ACL
S2支持一系列预定义的授权，称为标准ACL。每个标准ACL都有一组预定义的被授权者和权限。下表列出了一系列标准ACL和相关联的预定义授权。
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Canned ACL</th>
            <th>适用于</th>
            <th>对应的ACL权限</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>private</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。其他人没有访问权限（默认）。</td>
          </tr>
          <tr>
            <td>public-read</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。匿名用户有READ的权限</td>
          </tr>
          <tr>
            <td>public-read-write</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。AllUsers组用户有READ, WRITE的权限,对象没有WRITE权限</td>
          </tr>
          <tr>
            <td>authenticated-read</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。AuthenticatedUsers组用户有READ</td>
          </tr>
       </tbody>
</table>

#### 如何指定ACL

S2 API使您可以在创建存储桶或对象时设置ACL。S2还提供API在现有存储桶或对象上设置ACL。这些API向您提供了以下方法来设置ACL：
- 使用请求header设置ACL – 发送创建资源（存储桶或对象）的请求时，您可以使用x-amz-acl头设置Canned acl, 或者使用x-amz-grant-*头设置某个用户或者则组具有的权限。- 使用ACL API设置ACL – 当您发送在现有资源上设置ACL的请求时，您可以在请求标头或body中设置ACL, 如put_object_acl API

<b>注意</b>:

- x-amz-acl和x-amz-grant-\*不能同时指定, 同时指定是返回400错误
- 在put_object_acl API中如果, 指定 x-amz-acl或者x-amz-grant-*请求头, 则忽略body中的ACL
    ##### x-amz-grant-*请求头类型
x-amz-grant-\*请求头的值为type=value对的形式, 每个tpye=value以逗号隔开, 同一请求中可以指定多个x-amz-grant-\*请求头, 允许的type为:
- emailAddress, 用户的email地址- id, 用户名- uri, 预定义用户组的uri<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>x-amz-grant-read</td>
            <td>允许授权者READ的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-write</td>
            <td>允许授权者WRITE的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-read-acp</td>
            <td>允许授权者READ_ACP的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-write-acp</td>
            <td>允许授权者WRITE_ACP的权限</td>
          </tr>
          </tr>
          <tr>
            <td>x-amz-grant-full-control</td>
            <td>允许授权者READ, WRITE, READ_ACP, WRITE_ACP的权限</td>
            </tr>
       </tbody>
</table>

例子:
```
   x-amz-grant-read: emailAddress="xyz@amazon.com", emailAddress="abc@amazon.com"
```
