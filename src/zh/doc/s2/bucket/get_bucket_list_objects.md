
### GET Bucket (List Objects)

 - 描述：获取bucket下所有object。

 - 请求格式：

```http
GET /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 请求参数：

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
            <td>折叠显示字符。通常使用：‘/’</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>marker</td>
            <td>Key的初始位置，系统将列出比Key大的值，通常用作‘分页’的场景</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>max-keys</td>
            <td>返回值的最大Key的数量。默认为400</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>prefix</td>
            <td>列出以指定字符为开头的Key</td>
            <td>No</td>
          </tr>
          
       
        </tbody>
    </table>

响应格式举例（HTTP Body）：

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

 - 返回值说明：

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
            <td>Object的Metadata数组</td>
          </tr>
          
          <tr>
            <td>CommonPrefixes</td>
            <td>折叠以后的Prefix，下一级是Prefix数组</td>
          </tr>
          
          <tr>
            <td>Delimiter</td>
            <td>当前使用的折叠字符</td>
          </tr>
          
          <tr>
            <td>Prefix</td>
            <td>当前使用的前缀</td>
          </tr>
          
          <tr>
            <td>Marker</td>
            <td>当前使用的Marker</td>
          </tr>
          
          <tr>
            <td>ContentsQuantity</td>
            <td>Contents中元素个数</td>
          </tr>
          
          <tr>
            <td>CommonPrefixesQuantity</td>
            <td>CommonPrefixes中元素个数</td>
          </tr>
          
          <tr>
            <td>NextMarker</td>
            <td>下一页的Marker</td>
          </tr>
          
          <tr>
            <td>IsTruncated</td>
            <td>是否还有下一页</td>
          </tr>
          
          <tr>
            <td>SHA1</td>
            <td>文件内容的sha1值</td>
          </tr>
          
          <tr>
            <td>Name</td>
            <td>Object的Key(文件名)</td>
          </tr>
                    
          <tr>
            <td>Last-Modified</td>
            <td>Object的最后修改时间</td>
          </tr>
          
          <tr>
            <td>Owner</td>
            <td>Object的拥有者</td>
          </tr>
          
          <tr>
            <td>MD5</td>
            <td>文件内容的md5值</td>
          </tr>
          
          <tr>
            <td>Content-Type</td>
            <td>文件的mime type</td>
          </tr>
          
          <tr>
            <td>Size</td>
            <td>文件的大小(字节)</td>
          </tr>
          
        </tbody>
    </table>

 - 应用举例：
假设某Bucket下有如下文件(为方便说明，没有显示为json格式，仅表现其中的一些有用信息，以下同)：

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

使用prefix指定以join/为开头的文件：

```http
GET /?prefix=join/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

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

使用delimiter指定折叠方式为‘/’：

```http
GET /?delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
Contents:

CommonPrefix:
    join
    mary
    sai
```

使用prefix指定以join/为开头的文件，同时使用delimiter指定折叠方式为‘/’：

```http
GET /?prefix=join/&delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

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

使用max-keys做最大值列表长度限制：

```http
GET /?prefix=join/&delimiter=/&max-keys=4&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

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

使用marker继续获得之前的列操作的后续结果：

```http
GET /?prefix=join/&delimiter=/&max-keys=4&marker=join/userlist.txt&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
IsTruncated : false
Contents:
    join/userlist.txt
    join/zero.txt
```
