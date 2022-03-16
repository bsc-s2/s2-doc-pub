# Offline Download Interface

## Authorization

Use AccessKey and SecretKey.

Please refer to [REST-Authentication](http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html#RESTAuthenticationQueryStringAuth).

## Error Response Status Code and Error

Following is a list of error response definitions, including:

`Status code` `Error code`
and its description.

-   **400**
    `InvalidURI`
    <br>
    Couldn't parse the specified URI.

-   **400**
    `DownloadSourceException`
    <br>
    Download source exception can not download file.

-   **404**
    `NoSuchDownloadSource`
    <br>
    The specified download source does not exist.

-   **500**
    `InternalError`
    <br>
    We encountered an internal error. Please try again.

-   **501**
    `NotImplemented`
    <br>
    Current request not implemented.

**Other status code** is same as Amazon S3. Please refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).

Signature of all requests is same as Amazon S3.

## Commit Offline Download Task

### Request URI

`http://offline_domain/<bucket>`

### Request Method

PUT

### Request Body

Data of JSON format.

Following is a list of request content, including:

**Element Name** `Element Type` and its description.

-   Elements for ALL requests:

    -   **Url**
        `String`
        <br>
        Download resource URL (including BT, Magnet, HTTP).

    -   **SuccessCallbackUrl**
        `String`
        <br>
        URL callback success.

    -   **FailureCallbackUrl**
        `String`
        <br>
        URL callback failure.

    -   **Target**
        `String`
        *optional*
        <br>
        Prefix of **Key** for the file to store.

    -   **ACLs**
        `Dict`
        *optional*
        <br>
        Access control lists. you can see ACL part in s2 doc for detail

        Examples:

        -   Specify the upload file's ACL:

            `task['ACLs'] = {'acl': 'private'}` , `task['ACLs'] = {'acl': 'public-read'}`, `task['ACLs'] = {'acl': 'authenticated-read'}`

        -   Authorize the specified user's access to this file:

            `task['ACLs'] = {'grant-read': 'id=user_name', 'grant-write': 'id=user_name', 'grant-read-acp': 'id=user_name', 'grant-write-acp': 'id=user_name'}`

        -   Authorize the specified multi users' access to this file:

            `task['ACLs'] = {'grant-full-control': 'id=user_name'}`

            `task['ACLs'] = {'grant-read': 'user_name1', 'grant-write': 'user_name2'}`

            `task['ACLs'] = {'grant-read-acp': 'emailAddress=user_email', 'grant-write-acp': 'id=user_email'}`


-   Elements for BT request:

    -   **Files**
        `Array`
        <br>
        Contains files which user wanted.

-   Elements for HTTP request:

    -   **Key**
        `String`
        *optional*
        <br>
        Specify put object url, if this field is set, **Target** field will be ignored.

    -   **SHA1**
        `String`
        *optional*
        <br>
        SHA1 hash of this file. Check the file's accuracy.

    -   **MD5**
        `String`
        *optional*
        <br>
        MD5 hash for this file. Check the file's accuracy.

    -   **CRC32**
        `String`
        *optional*
        <br>
        CRC32 hash of this file. Check the file's accuracy.

    -   **Size**
        `Int`
        *optional*
        <br>
        Size of this file. Check the file's accuracy.

    -   **OnKeyExist**
        `String`
        *optional*
        <br>
        specify this file's ignore rule.

        Ignore rules (If the same `key` file exists):
        -   `ignore` : Always ignore.
        -   `ignore-same-md5` : This key just work with `MD5` key. If this file with the same MD5 value exists, ignore this file.
        -   `ignore-same-sha1` : This key just work with `SHA1` key. If this file with the same SHA1 value exists, ignore this file.
        -   `ignore-same-crc32` : This key just work with `CRC32` key. If this file with the same CRC32 value exists, ignore this file.
        -   `ignore-same-checksum` : This key just work with `MD5` or `SHA1` or `CRC32` key. If this file with the same value of any one of the three exists, ignore this file.
        -   `ignore-same-size` : This just work with `Size` key. If this file with the same size exists, ignore this file.
        -   `override` : Always override.

### Request Example

```
//BT method.
{
    "Files":["movie1.txt","movie2.jpg"],
    "Url":"http://www.abc.com/download/movie.torrent",
    "Target":"movie/2016",
    "SuccessCallbackUrl":"http://website/succ/",
    "FailureCallbackUrl":"http://website/fail/",
}
```
or
```
//HTTP method.
{
    "Url":"http://www.abc.com/download/movie.mp4",
    "Key":"movies/2016/movie.mp4",
    "ACLs": {'acl': 'private'},
    "SHA1":"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde",
    "MD5":"abcdabcdabcdabcdabcdabcdabcdabcd",
    "CRC32":"abcdef",
    "SuccessCallbackUrl":"http://website/succ/",
    "FailureCallbackUrl":"http://website/fail/",
}
```
or
```
//Magnet method.
{
    "Url":"magnet:?xt=urn:btih:88594AAACBDE40EF3E2510C47374EC0AA396C08E&dn=movie.mp4",
    "Target":"movie/2016",
    "SuccessCallbackUrl":"http://website/succ/",
    "FailureCallbackUrl":"http://website/fail/",
}
```

### Request Response

-   **Success**

    Return status code 200.

-   **Failure**

    Same as Amazon, refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).

### Request Response Header

After request handled successful, it generated a `x-amz-s2-offline-task-id` header, contains this offline download task ID. The subsequent query task and cancel task both can be done by looking up this ID.

## Query Status Of Offline Download Task

### Request URI

`http://offline_domain/<bucket>/<taskId>`

### Request Method

GET

### Request Response

-   **Success**

    Return status code 200 and body.

    Body contains **State** and **Percent** (total download progress percent). (Json type)

    Example:

    ```
    {
        "State":"TASK_UNDO",
        "Percent":"0.00"
    }
    ```
    or
    ```
    {
        "State":"TASK_DOING",
        "Percent":"80.00"
    }
    ```

    or
    ```
    {
        "State":"TASK_SUCCESS",
        "Percent":"100.00"
    }
    ```
    or
    ```
    {
        "State":"TASK_FAILED"
    }
    ```
    or
    ```
    {
        "State":"TASK_CANCELLED"
    }
    ```

-   **Failure**

    Same as Amazon, refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).

## Delete Offline Download Task

### Request URI

`http://offline_domain/<bucket>/<taskId>`

### Request Method

DELETE

### Request Response

-   **Success**

    Return status code 204.

-   **Failure**

    Same as Amazon, refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).

**notice**: current delete download task is not open to user，if you want to use this feature contact us.

## Success Callback

### Request URL

Determined by argument of `SuccessCallbackUrl` Request.

### Request Method

POST

### Request Body

Data of JSON format.

Following is a list of request content, including:

**Element Name** `Element Type` and its description.

Not null for ALL of these elements.

-   **ETag**
    `String`
    <br>
    MD5 hash of this file. This md5 value must be enclosed in double quotes.

-   **MD5**
    `String`
    <br>
    MD5 hash of this file.

-   **SHA1**
    `String`
    <br>
    SHA1 hash of this file.

-   **CRC32**
    `String`
    <br>
    CRC32 hash of this file.

-   **Key**
    `String`
    <br>
    Name of this file. (e.g. `<Target>/<File> or <Key>`)

-   **Size**
    `Int`
    <br>
    Size of this file.

-   **Content-Type**
    `String`
    <br>
    MIME type of this file (Converted to lowercase letters)

-   **LastModified**
    `String`
    <br>
    Upload time. (Unit: ms)

-   **Task**
    `String`
    <br>
    Name of this offline download task. (e.g. `<bucket>/<taskId>`)

-   **Concrete-Upload**
    `bool`
    <br>
    Concrete upload file to storage, (offline will ignore upload file if it already existed in storage)

-   **Success-IDC**
    `String`
    <br>
    file has uploaded succeed idc list, use comma to split idcs. if Concrete-Upload value is false, this field is null

-   **Failure-IDC**
    `String`
    <br>
    file has uploaded failed idc list, use comma to split idcs. if Concrete-Upload value is false, this field is null

### Request Example

```
{
    "movie1":{
        "ETag":"\"abcdabcdabcdabcdabcdabcdabcdabcd\"",
        "MD5":"abcdabcdabcdabcdabcdabcdabcdabcd",
        "SHA1":"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde",
        "CRC32":"fasdfasdf",
        "Key":"offline/prefix/movie1",
        "Size":"123456",
        "Content-Type":"video\/mp4",
        "LastModified":"1467355438043.852",
        "Task":"bucket/0000d1f0010000000062",
        "Concrete-Upload": true,
        "Success-IDC": "idc1,idc2",
        "Failure-IDC": ""
    } ,
}

or

{
    "movie1":{
        "ETag":"\"abcdabcdabcdabcdabcdabcdabcdabcd\"",
        "MD5":"abcdabcdabcdabcdabcdabcdabcdabcd",
        "SHA1":"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde",
        "CRC32":"fasdfasdf",
        "Key":"offline/prefix/movie1",
        "Size":"123456",
        "Content-Type":"video\/mp4",
        "LastModified":"1467355438043.852",
        "Task":"bucket/0000d1f0010000000062",
        "Concrete-Upload": false,
        "Success-IDC": null,
        "Failure-IDC": null
    } ,
}
```
### Request Response

-   **Success**

    Return status code 200.

-   **Failure**

    Same as Amazon, refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).

## Failure Callback

### Request URL

Determined by argument of FailureCallbackUrl Response.

### Request Method

POST

### Request Body

Data of JSON format.

Following is a list of request content, including:

**Element Name** `Element Type` and its description.

Not null for ALL of these elements EXCEPT **Files**.

-   **Code**
    `String`
    <br>
    Error code.

-   **Message**
    `String`
    <br>
    Error description information.

-   **Resource**
    `String`
    <br>
    Resource name, contains URL of this offline request task.

-   **RequestId**
    `String`
    <br>
    Request ID.

-   **Task**
    `String`
    <br>
    Name of this offline download task. (e.g. `<bucket>/<taskId>`)

-   **Files**
    `dict`
    *optional*
    <br>
    Contains information of files which has been uploaded. With this element, users can pick up information of files which has been uploaded sucessful.

### Request Example

```
{
    "Code":"NoSuchDownloadSource",
    "Message":"The specified download source does not exist",
    "Resource":"http://www.abc.com/download/movie.torrent",
    "RequestId":"4442587FB7D0A2F9",
    "Task":"bucket/0000d1f0010000000062",
}
```
or
```
{
    "Code":"InternalError",
    "Message":"We encountered an internal error. Please try again.",
    "Resource":"http://www.abc.com/download/movie.torrent",
    "RequestId":"4442587FB7D0A2F9",
    "Task":"bucket/0000d1f0010000000063",
    "Uploaded_Files": {
        "movie1": {
            "ETag":"\"abcdabcdabcdabcdabcdabcdabcdabcd\"",
            "SHA1":"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde",
            "CRC32":"fasdfasdf",
            "Key":"offline/prefix/movie1",
            "Size":"123456",
            "Content-Type":"video\/mp4",
            "LastModified":"1467355438043.852",
        }
    }
}
```

### Request Response

-   **Success**

    Return status code 200.

-   **Failure**

    Same as Amazon, refer to [ErrorResponses](http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html).