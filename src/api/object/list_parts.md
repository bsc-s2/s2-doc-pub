### List Parts

 - 描述：列出已经上传的所有分块

 - 请求格式：

```http
GET /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<Bucket>example-bucket</Bucket>
<Key>example-object</Key>
<UploadId>XXBsb2FkIElEIGZvciBlbHZpbmcncyVcdS1tb3ZpZS5tMnRzEEEwbG9hZA</UploadId>
<Initiator>
    <ID>initiator</ID>
    <DisplayName></DisplayName>
</Initiator>
<Owner>
    <ID>owner</ID>
    <DisplayName></DisplayName>
</Owner>
<StorageClass>STANDARD</StorageClass>
<PartNumberMarker>1</PartNumberMarker>
<NextPartNumberMarker>3</NextPartNumberMarker>
<MaxParts>2</MaxParts>
<IsTruncated>true</IsTruncated>
<Part>
    <PartNumber>2</PartNumber>
    <LastModified>2010-11-10T20:48:34.000Z</LastModified>
    <ETag>"7778aef83f66abc1fa1e8477f296d394"</ETag>
    <Size>10485760</Size>
</Part>
<Part>
    <PartNumber>3</PartNumber>
    <LastModified>2010-11-10T20:48:33.000Z</LastModified>
    <ETag>"aaaa18db4cc2f85cedef654fccc4a4x8"</ETag>
    <Size>10485760</Size>
</Part>
</ListPartsResult>
```

- Request Parameters（请求参数）：

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
            <td>uploadId</td>
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>max-parts</td>
            <td>返回最大的part数量, 默认返回2048个</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>part-number-marker</td>
            <td>列出该partNumber之后的parts, 不包括该partNUmber指定的part, partNUmber从1开始</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
</table>

- Request Headers（请求头）：

- Response Body（响应XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>ListPartsResult</td>
            <td>
            	包含Bucket, Key, UploadId, Initiator, Owner, StorageClass, PartNumberMarker, NextPartNumberMarker, MaxParts, IsTruncated, Part元素
            </td>
          </tr>
        
          <tr>
            <td>Bucket</td>
            <td>
            	bucket name
            </td>
          </tr>
        
          <tr>
            <td>Key</td>
            <td>
            	objectName
            </td>
          </tr>
        
          <tr>
            <td>UploadId</td>
            <td>
            	标识该分块上传的ID, 之后上传分片时需要携带该参数
            </td>
          </tr>
        
          <tr>
            <td>Initiator</td>
            <td>
            	包含ID, DisplayName元素
            </td>
          </tr>
        
          <tr>
            <td>ID</td>
            <td>
            	init UserName
            </td>
          </tr>
        
          <tr>
            <td>DisplayName</td>
            <td>
            </td>
          </tr>
        
          <tr>
            <td>Owner</td>
            <td>
            	包含ID, DisplayName元素, 指定文件的owner
            </td>
          </tr>
        
          <tr>
            <td>StorageClass</td>
            <td>
            	存储类别
            </td>
          </tr>
        
          <tr>
            <td>PartNumberMarker</td>
            <td>
            	 list开始的partNumber, 不包含该partNumber
            </td>
          </tr>
        
          <tr>
            <td>NextPartNumberMarker</td>
            <td>
            	下次开始list的partNumber
            </td>
          </tr>
        
          <tr>
            <td>MaxParts</td>
            <td>
            	最大part数量
            </td>
          </tr>
        
          <tr>
            <td>IsTruncated</td>
            <td>
            	是否被truncated
            </td>
          </tr>
        
          <tr>
            <td>Part</td>
            <td>
            	包含PartNumber, LastModified, ETag, Size元素, 表示一个part的信息
            </td>
          </tr>
        
          <tr>
            <td>PartNumber</td>
            <td>
            	part的number
            </td>
          </tr>
        
          <tr>
            <td>LastModified</td>
            <td>
            	part的最后修改时间
            </td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	part的md5
            </td>
          </tr>
        
          <tr>
            <td>Size</td>
            <td>
            	part的size
            </td>
          </tr>
        </tbody>
</table>
