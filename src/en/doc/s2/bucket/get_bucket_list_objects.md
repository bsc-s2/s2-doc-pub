
### GET Bucket (List Objects)

- Description: get all objects under the bucket.
  
- Request Syntax:

```http
GET /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

or

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Request parameters:

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Parameter</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>delimiter</td>
            <td>Folded display characters. Usually use：‘/’</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>marker</td>
            <td>The initial position of the Key, the system will list the value larger than the Key, usually used as a 'paging' scenario</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>max-keys</td>
            <td>The default maximum number of Key value is 400</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>prefix</td>
            <td>List the Keys that start with the specified character</td>
            <td>No</td>
          </tr>
          
       
        </tbody>
    </table>

Example of response format（HTTP Body）：

```json
{

    Delimiter: "/",
    
    Prefix: "html/",
    
    CommonPrefixes: [
    
        {
            Prefix: "html/assets/"
        },
    
        {
            Prefix: "html/attributions/"
        },
    
        {
            Prefix: "html/documentation/"
        },
    
        ...
    ],
    
    Marker: null,
    
    ContentsQuantity: 5,
    
    CommonPrefixesQuantity: 3,
    
    NextMarker: null,
    
    IsTruncated: false,
    
    Contents: [
    
        {
            SHA1: "9fc710aa89efbe42020b0310d16a07449bf06131",
            Name: "html/coming-soon.html",
            Expiration-Time: null,
            Last-Modified: "Fri, 21 Mar 2014 01:50:46 UTC",
            Owner: "Baishan0000000000000001",
            MD5: "934d922cac80449ee361cefeb3276b3e",
            Content-Type: "text/html",
            Size: 8781
        },
    
        {
            SHA1: "a9625a128263f05e331f6d78add9bd15911c3565",
            Name: "html/ebook.html",
            Expiration-Time: null,
            Last-Modified: "Fri, 21 Mar 2014 01:50:47 UTC",
            Owner: "Baishan0000000000000001",
            MD5: "cb7ed943ead4aeb513aa8c0b76865a8b",
            Content-Type: "text/html",
            Size: 18734
        },
        
        ...
    ]
}
```

- Return value Description:

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Contents</td>
            <td>Metadata array of object</td>
          </tr>
          
          <tr>
            <td>CommonPrefixes</td>
            <td>After folding the prefix, the next level is the prefix array</td>
          </tr>
          
          <tr>
            <td>Delimiter</td>
            <td>Currently used collapse character</td>
          </tr>
          
          <tr>
            <td>Prefix</td>
            <td>Currently used prefix</td>
          </tr>
          
          <tr>
            <td>Marker</td>
            <td>Currently used marker</td>
          </tr>
          
          <tr>
            <td>ContentsQuantity</td>
            <td>Number of elements in contents</td>
          </tr>
          
          <tr>
            <td>CommonPrefixesQuantity</td>
            <td>Number of elements in Common Prefixes</td>
          </tr>
          
          <tr>
            <td>NextMarker</td>
            <td>Marker on next page</td>
          </tr>
          
          <tr>
            <td>IsTruncated</td>
            <td>Is there another page</td>
          </tr>
          
          <tr>
            <td>SHA1</td>
            <td>SHA1 value of file content</td>
          </tr>
          
          <tr>
            <td>Name</td>
            <td>Key (file name) of object</td>
          </tr>
                    
          <tr>
            <td>Last-Modified</td>
            <td>Last modification time of object</td>
          </tr>
          
          <tr>
            <td>Owner</td>
            <td>Owner of the object</td>
          </tr>
          
          <tr>
            <td>MD5</td>
            <td>MD5 value of file content</td>
          </tr>
          
          <tr>
            <td>Content-Type</td>
            <td>MIME-type of the file</td>
          </tr>
          
          <tr>
            <td>Size</td>
            <td>File size (bytes)</td>
          </tr>
          
        </tbody>
    </table>

- Example: 
  
If there are some files as follows under a bucket (for convenience, they are not displayed in the JSON format, only show some useful information, the same below):

```
join/mailaddresss.txt
join/mycodelist.txt
join/personalfiles/connects.docx
join/personalfiles/myphoto.jpg
join/readme.txt
join/userlist.txt
join/zero.txt
mary/personalfiles/mary.jpg
mary/readme.txt
sai/readme.txt
```

Use prefix to specify files starting with join /

```http
GET /?prefix=join/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

return:

```
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/personalfiles/connects.docx
    join/personalfiles/myphoto.jpg
    join/readme.txt
    join/userlist.txt
    join/zero.txt
```

Use the delimiter to specify that the collapse method is '/'：

```http
GET /?delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

return：

```
Contents:

CommonPrefix:
    join
    mary
    sai
```

Use prefix to specify the file starting with join /, and use delimiter to specify the folding method as '/'：

```http
GET /?prefix=join/&delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

return：

```
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/readme.txt
    join/userlist.txt
    join/zero.txt
CommonPrefix:
    join/personalfiles/
```

Use max-keys to limit the maximum list length:

```http
GET /?prefix=join/&delimiter=/&max-keys=4&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

return：

```
IsTruncated : true
Next-Marker : join/userlist.txt
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/readme.txt
CommonPrefix:
    join/personalfiles/
```

Use marker to continue to get the subsequent results of the previous column operations：

```http
GET /?prefix=join/&delimiter=/&max-keys=4&marker=join/userlist.txt&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

return：

```
IsTruncated : false
Contents:
    join/userlist.txt
    join/zero.txt
```
