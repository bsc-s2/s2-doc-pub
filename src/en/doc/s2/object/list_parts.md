### List Parts

- Description: lists all blocks that have been uploaded
  
- Request format:

```http
GET /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.ss.bscstorage.com
Date: <date>
Authorization: <authorization string> #Please refer to signature algorithm
```

- Response:

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

- Request Parameters：

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
            <td>Uploadid value obtained through Initiate Multipart Upload (large file fragment upload initialization interface)</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>max-parts</td>
            <td>Returns the maximum number of parts, 2048 by default</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>part-number-marker</td>
            <td>List the parts after the partnumber, excluding the part specified by the partnumber, which starts from 1</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
</table>


- Request Headers：

- Response Body（Response XML Body）：

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
            	Contain Bucket, Key, UploadId, Initiator, Owner, StorageClass, PartNumberMarker, NextPartNumberMarker, MaxParts, IsTruncated, Part element
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
            	Identify the ID of the block upload. This parameter needs to be carried when uploading the block later
            </td>
          </tr>     
          <tr>
            <td>Initiator</td>
            <td>
            	Include ID, DisplayName element
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
            	Include ID, DisplayName element, specific file's owner
            </td>
          </tr>    
          <tr>
            <td>StorageClass</td>
            <td>
            	storage class
            </td>
          </tr>  
          <tr>
            <td>PartNumberMarker</td>
            <td>
            	 list initial partNumber, does not include this partNumber
            </td>
          </tr>   
          <tr>
            <td>NextPartNumberMarker</td>
            <td>
            	Start the partNumber of the list next time
            </td>
          </tr>    
          <tr>
            <td>MaxParts</td>
            <td>
            	Maximum part numbers
            </td>
          </tr>   
          <tr>
            <td>IsTruncated</td>
            <td>
            	Is it truncated
            </td>
          </tr>   
          <tr>
            <td>Part</td>
            <td>
            	It contains partnumber, LastModified, Etag and size elements to represent the information of a part
            </td>
          </tr>  
          <tr>
            <td>PartNumber</td>
            <td>
            	Number of part
            </td>
          </tr>  
          <tr>
            <td>LastModified</td>
            <td>
            	Last modification time of part
            </td>
          </tr>
          <tr>
            <td>ETag</td>
            <td>
            	part's md5
            </td>
          </tr>
          <tr>
            <td>Size</td>
            <td>
            	part's size
            </td>
          </tr>
        </tbody>
</table>
