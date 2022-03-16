### POST Object

- Description: upload a file by post (based on browser form).

- Request：

```http
POST / HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
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

- Form elements:

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
            	It is the AccessKey, which can be obtained from the console
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>key</td>
            <td>
            	The key (path) after object upload, such as: angel / ${filename}, variable ${filename} will be automatically replaced with the file name of the uploaded file; of course, you can also directly specify the file name of the uploaded file stored in the storage, such as: angel / path / to / myfile.txt,Variable names can be: filename, SHA1, MD5, size
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>acl</td>
            <td>
            	ACL of file: set an ACL when creating a file. Please refer to 《ACL》
            </a></td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>success_action_status</td>
            <td>
            	The response code after successful upload can be set to 200, 201, or 204 (default). If it is set to 200 or 204, the returned body is empty and the status is 200 or 204. If it is set to 201, the returned body in XML format and the status is 201. If it is set to an illegal value, the value is ignored and the default value 204 is used
              Note: if success is set\_ action\_ Redirect or redirect, this setting is ignored
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>success_action_redirect, redirect</td>
            <td>
            	The URL redirected by the client after successful upload. The actual returned location will add bucket, key and Etag querystring to the original URL
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Policy</td>
            <td>
            	File strategy, JSON format string, and encoded with Base64. It will be described in detail later
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>Signature</td>
            <td>
            	The string signed with the secret key. It will be described in detail later
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>file</td>
            <td>
            	Input form with type = file
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	User defined metadeta. The header starts with x-amz-meta -, and all meta are stored in the form of key: value. The maximum limit is 64KB. It is returned as it is when HEAD or GET
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Cache-Control, Content-
Type, Content-Disposition,
Content-Encoding,
Expires</td>
            <td>
            	like put\_file, refer to put\_file interface
            </td>
            <td>No</td>
          </tr>
                    
        </tbody>
</table>

#### Construction of policy：
The policy is a JSON document encoded with UTF-8 and Base64, which specifies the conditions that the request must meet and is used to authenticate the content. Depending on how you design policy documents, you can use them for each upload, each user, all uploads, or other designs that meet your needs.

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

- Description of the above example:
  
  - Upload must be before "2014-04-10t08:55:34.000z".
  - Upload the file to the bucket named "my bucket name".
  - starts-with：$key must start with "my_ Prefix" / '(the "$key" in the policy must be preceded by "$"). If the $key value is empty, there is no prefix before the file name.
  - content-length-range：The file size must be within the specified range.
  - Finally, Base64 encode the policy and set it to the value of the form policy.expiration:

##### Expiration

Expiration is used to specify the expiration time of the policy. The expiration date of the policy is specified in ISO 8601 UTC date format. For example, "2007-12-01t12:00:00.000z" specifies that expiration is required in the policy.

##### Condition:
 Condition is used to verify the content of the uploaded object and the fields filled in by the form

###### Condition type
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Condition</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td width="185px">Precise Matching</td>
            <td>
            	1. Precise matching will verify that the field matches a specific value. This example instructs that the ACL must be set to public-read: {"acl": "public-read" } <br/>
              2.ACL must be set to public-read alternative: [ "eq", "$acl", "public-read" ]
            </td>
          </tr>    
            
          <tr>
            <td>Starts With</td>
            <td>
            If the value must start with a specific value, use starts-with. this example instructs that the key must start with user/betty
starts with:["starts-with", "$key", "user/betty/"]
            	
            </td>
          </tr>  
          <tr>
            <td>Specify the range</td>
            <td>
            For fields that accept a range, use a comma to separate the upper and lower limit values. This example allows 1 to 10 MB of
file sizes:["content-length-range", 1048579, 10485760], byte
            	
            </td>
          </tr>                        
        </tbody>
</table>

###### Conditions field

The conditions in the policy document verify the content of the uploaded object. Each form field you specify in the form（AWSAccessKeyId、Signature、 file、Policy except）Can be used as a condition

#### Signature Construction:
- Encoding policy with UTF-8
- Encode the policy in UTF-8 form with Base64
- Use HMAC SHA-1 and your secret key to convert your policy. Finally, Base64 coding is performed. For example, when using PHP，base64\_encode( hash\_hmac( "sha1", $policy, $SECRETKEY, true ) );
- Set the final value to the value of the form signature.

Finally generated HTML form:

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

- matters needing attention：
  - The URI after the  POST  request can only be “/”
  - success_action_redirect：Specify the URL to be redirected by the client after successful upload.
  - key：The variable ${filename} will be automatically replaced with the file name of the uploaded file
