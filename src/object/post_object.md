### POST Object

 - 描述：POST方式上传一个文件（基于浏览器表单的上传方式）。

 - 请求格式：

```http
POST / HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Content-Length: <length>

Content-Type:multipart/form-data; boundary=----WebKitFormBoundary1dIjDASRYXQm6DNA

------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="key"

destinationProject/${filename}
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="success_action_redirect"

http://123.abc.com/1.php?f=1111.txt
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="AWSAccessKeyId"

100M414ZO0X30
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="Policy"

eyJleHBpcmF0aW9uIjoiMjAxMi0wNi0wNlQwNjozOTo0MS4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoiczN4cC5zM3dhdGNoIn0sWyJzdGFydHMtd2l0aCIsIiRrZXkiLCJhbmdlbFwvIl1dfQ==
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="Signature"

VK6Kw4kRqW2e84ZIX2cV2QqHo58=
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="file"; filename="112233.txt"
Content-Type: text/plain

------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="submit"

上传
------WebKitFormBoundary1dIjDASRYXQm6DNA-
```

 - 表单元素：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td width="185px">AWSAccessKeyId</td>
            <td>
            	就是AccessKey，可以到控制台获取
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>key</td>
            <td>
            	object上传后的key（路径），例如：angel/${filename}，变量${filename}将被自动替换成被上传文件的文件名；当然也可以直接指定被上传文件存储在Sinastorage的文件名。如：angel/path/to/myfile.txt
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>acl</td>
            <td>
            	文件的ACL：创建文件的同时，设置一个ACL。请参照：<a href="http://open.baishanstorage.com/?c=doc&a=guide&section=acl">《ACL》
            </a></td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>success_action_status</td>
            <td>
            	上传成功后的响应码，可以设置的值为:200, 201, or 204(defalut),
                若设置为200或者204, 则返回body为空, status为200或者204,
                若设置为201, 则返回xml格式的body, stats为201
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>success_action_redirect, redirect</td>
            <td>
            	上传成功后客户端重定向的URL。
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Policy</td>
            <td>
            	文件的策略，json格式字符串，并使用base64进行编码。后面详细介绍
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>Signature</td>
            <td>
            	使用SecretKey签名后的字符串。后面详细介绍
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>file</td>
            <td>
            	type=file的input表单
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	用户自定义MetaDeta, header以x-amz-meta-开头, 所有meta以key:value的形式存储,最大限制64KB,
                HEAD或者GET时原样返回
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Cache-Control</td>
            <td>
            	文件Cache，标准HTTP协议，更多内容参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Expires</td>
            <td>
            	文件过期时间，到期系统将自动清除文件（非即时，清除时间不定期），格式参考：http://www.w3.org/Protocols/rfc2616/
                rfc2616-sec14.html#sec14.21.
            </td>
            <td>No</td>
          </tr>
                    
        </tbody>
</table>

 - Policy的构建：
 策略是使用 UTF-8 和 Base64 编码的 JSON
 文档，它指定了请求必须满足的条件并且用于对内容进行身份验证。根据您设计策略文档的方式，您可以对每次上传、每个用户、所有上传或根据其他能够满足您需要的设计来使用它们。

```json
{
    "expiration": "2014-04-10T08:55:34.000Z",

    "conditions": [

        {
            "bucket": "my-bucket-name"
        },

        {
            "acl": "private"
        },

        [
            "starts-with", "$key", "my_prefix/"
        ],

        [
            "content-length-range", 0, 52428800
        ]
    ]
}
```

 - 以上示例的说明：

  - 上传必须在”2014-04-10T08:55:34.000Z”之前。
  - 文件上传到名为”my-bucket-name”的bucket。
  - starts-with：$key必须以”my_prefix/”开始 (Policy中”$key”前必须带”$”)。若$key值为空，文件名前无前缀。
  - content-length-range：文件大小必须在指定范围内。
  - 最终将policy进行base64编码设置到表单Policy的value中。
  
 - Signature的构建：
  - 用UTF-8对policy进行编码
  - 用Base64对UTF-8形式的policy进行编码
  - 用HMAC SHA-1和你的Secret Key将你的policy进行转换。最后进行base64编码。如：使用php时，base64_encode( hash_hmac( "sha1", $policy, $SECRETKEY, true ) );
  - 将最终的值设置到表单Signature的value中。
 - 最终生成的html表单：

```html
<form method="post" action="http://my-bucket.<?=c('api_host');?>/" enctype="multipart/form-data">
    <input type="hidden" name="AWSAccessKeyId" value="您的accesskey" />
    <input type="hidden" name="key" value="my_prefix/${filename}" />
    <input type="hidden" name="acl" value="private" />
    <input type="hidden" name="success_action_status" value="201" />
    <input type="hidden" name="Policy" value="eyJleHBpcmF0aW9uIjoiMjAxNC0wNC0xMFQwOToxNzozMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoiY2xvdWQxMjMqwqwsdifsdGFydHMtd2l0aCIsIiRrZXkiLCJteWZpbGVzLyJdLFsic3RhcnRzLXdpdGgiLCIkQ29udGVudC1UeXBlIiwiIl0sWyJzdGFydHMtd2l0aCIsIiRDb250ZW50LURpc3Bvc2l0aW9uIiwiIl0seyJ1aWQiOiIxMjMifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwwLDUyNDI4ODAwXV19" />
    <input type="hidden" name="Signature" value="HnOSk3kfx5LFtn4CIiFcSglQUXc=" />
    <input type="file" name="file" />
    <input type="submit" value="上传" />
</form>
```

 - 注意事项：
  - POST请求后的uri只能是“/”
  - success_action_redirect：指定上传成功后客户端重定向的URL。
  - key：变量${filename}将被自动替换成被上传文件的文件名；当然也可以直接指定被上传文件存储在Sinastorage的文件名。

