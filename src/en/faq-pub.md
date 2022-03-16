[TOC]

## Basic knowledge popularization 

### The concept of Bucket and Object 

- Bucket， we store many files in one bucket. 
- Object, we consider each file as an object.
- Users can create buckets, delete buckets, query objects inside buckets, set bucket properties, etc.
- The user can create objects (object is the file uploaded by the user), delete objects, download objects, set the access rights of the objects, etc. 
- One example:
```` 
1. Create a bucket, bucket name: baishan_yun, request url: PUT /baishan_yun. 
2. Upload a file to the bucket of baishan_yun, object name: hello_world, each file is uniquely identified by bucket name and object name, requested url: PUT /baishan_yun/hello_world. 
3. To download this file, request the url: GET /baishan_yun/hello_world. 
4. To delete this file, the requested url: DELETE /baishan_yun/hello_world 
5. To delete the bucket, the requested url: DELETE /baishan_yun 
```` 



## Programming interface and user’s guide related

### What are the technical advantages of BaishanCloud Storage? 



- BaishanCloud Storage is a product that closely combines CDN and cloud storage. BaishanCloud Storage accelerates uploads via CDN edge nodes and downloads via whole CDN networks. Users can also use the cloud storage service separately. 

- BaishanCloud Storage is a multi-copy, multi-IDC, distributed architecture that ensures high reliability and availability. 

- BaishanCloud Storage provides rich and convenient image processing features that help customers also avoid the cost of duplicate uploads/downloads. 

- BaishanCloud Storage is a completely self-developed system, supporting storage needs in various scenarios, and providing higher performance and rich features. 

- BaishanCloud Storage adheres to the user-oriented principle and can be customized according to user needs, helping users to use the storage more conveniently and providing 24\*7 technical staff online service to help users solve problems quickly. 

- BaishanCloud Storage provides a variety of user data import mechanisms to facilitate the migration of data to the storage. 

- BaishanCloud Storage follows and is compatible with the Amazon S3 interface; it supports the official Amazon S3 SDK, and users can also use various open-source tools. 

- BaishanCloud follows the Amazon S3 REST API interface and strictly adheres to the HTTP protocol to avoid various problems caused by inconsistent interfaces and standards, and the Amazon S3 REST API interface, as the industry standard, has not been modified for more than 10 years and is very stable. 

- BaishanCloud supports Amazon S3 ACL access control, which can manage the access permissions of buckets and objects. Each bucket and object have an additional ACL sub-resource, which defines which users or groups will be granted access. 


### List of languages and SDKs supported by BaishanCloud Storage

- BaishanCloud Storage is compatible with the Amazon S3 interface. It includes all major development languages, such as Python, Php, Browser, Node.js, etc. 

- In the document baishancloud\_storage\_api, there are detailed example descriptions of SDKs for Python, Php, Browser, Node.js and other languages, which can help developers get started quickly. For the rest of the rules, you can refer to the Amazon S3 API documentation. 

- Android  Documentation:[AWS Mobile SDK for Android Documentation][AWS Mobile SDK for Android Documentation]    SDK Download:[aws-android-sdk][aws-android-sdk]

- Browser  Documentation: [Getting Started with the SDK in the Browser][Getting Started with the SDK in the Browser]    SDK Download: [Bower][Bower]

- ISO      Documentation: [AWS Mobile SDK iOS Developer Guid][AWS Mobile SDK iOS Developer Guid]    SDK Download: [aws-ios-sdk][aws-ios-sdk]

- Java     Documentation: [AWS SDK for Java Developer Guide][AWS SDK for Java Developer Guide] SDK Download: [aws-java-sdk][aws-java-sdk]

- .NET     Documentation: [AWS SDK for .NET Documentation][AWS SDK for .NET Documentation]    SDK Download: [AWSToolsAndSDKForNet.msi][AWSToolsAndSDKForNet.msi]

- Node.js  Documentation: [AWS SDK for JavaScript Documentation][AWS SDK for JavaScript Documentation]    SDK Download: [Getting Started with the SDK in Node.js]

- PHP      Documentation: [AWS SDK for PHP Documentation][AWS SDK for PHP Documentation]    SDK Download: [Installing via Composer][Installing via Composer]

- Python   Documentation: [Boto 3 Documentation][Boto 3 Documentation]    SDK Download&Description: [Boto 3 - The AWS SDK for Python][Boto 3 - The AWS SDK for Python]

- Ruby     Documentation: [AWS SDK for Ruby][AWS SDK for Ruby]    SDK Download:[AWS SDK for Ruby Developer Guide v2.16.8][AWS SDK for Ruby Developer Guide v2.16.8]

- Go       Documentation: [AWS SDK for Go][AWS SDK for Go]    SDK Download:[aws-sdk-go][aws-sdk-go]

- C++      Documentation: [AWS SDK for C++ Documentation][AWS SDK for C++ Documentation]    SDK Download:[aws-sdk-cpp][aws-sdk-cpp]

### Is the Cloud Storage Object stored in a directory structure? 

A BaishanCloud Storage Object is not a file in the traditional sense, and the storage method is not the same as saving in a file system.

Each Object appears to be a file in a directory, but for cloud storage it is just a directory-like string.

However, this does not affect the way users want to list files from the specified directory:<br/> 

When sending a request to list files, set the prefix parameter to the name of the directory prefix, you can only list the files in this directory, for example: 
- bucket/1.mp4
- bucket/cc/2.mp4
- bucket/cc/3 .mp4
- bucket/dd/ee/ff/3.mp4 

When the requested `prefix` is specified as `cc`, it will list:
- 2.mp4
- 3.mp4


This process is as same as listing files from a directory. In addition to simulating directory listing files, 
it also provides functions such as specifying the maximum number of files to list, 
specifying to list files after a certain file name (sorted in alphabetical order), and merging files according to common prefixes.
For details, please refer to the API documentation. 

Things to pay attention to when using:
 
- Object name should not start with '/'.
  
  For example: You need to upload a file called file.txt, bucket is `sandbox`.
    
    - Object is set to `file.txt`, when accessing it should be `http://ss. bscstorage.com/sandbox/file.txt` (recommended)
    - If object is set to `/file.txt`, it should be `http://ss.bscstorage.com/sandbox//file.txt` when accessing (strongly not recommended)

- It is best not to have two consecutive '/' in the object name. For example: You need to upload a file called file.txt in the folder directory, and the bucket is `sandbox`,
 
    - Object is set to `folder/file.txt`, when accessing it should be `http://ss.bscstorage.com/sandbox/folder/file.txt` (recommended method)
 
    - If object is set to `folder//file.txt`, it should be `http://ss.bscstorage.com/sandbox/folder//file.txt` when accessing (strongly not recommended)
 
    - Why does BaishanCloud Storage not recommend two '//' in the URL: some CDN cache servers may combine two consecutive '//' in the URL into one '/' round-trip source, in this case, the Authentication failed or 404
    
### How to delete a directory? 

BaishanCloud Storage does not support deleting a directory directly, 

Because the Amazon S3 API does not have the concept of directories in the strict sense (there is no directory hierarchy, but it is customary to separate objects by "/" as directories), there is no guarantee for multiple file operations in this case, so it is done by scripts. 

This can be done in the following way:

- List all the files in the directory via the List Objects interface. 

- Deleting them one by one through the Delete Object interface. 

- Deleting a directory.

Please note:

- The list of files returned by the List Objects interface is not all the files in that directory (the list is sorted by filename characters). It may contain the next directory or several directories; so you need to adjust the value of the max-keys parameter, and filter each file to make sure it is a file in that directory. 
If you set the `prefix` parameter, you can strictly list all files under that `prefix`. 



- Deleting all files at once (listing all files and deleting them one by one) does not guarantee that all files in the directory will be cleaned up. 
`(There may be new uploads during the deletion process.)



### Is it possible to use BaishanCloud Storage for whole site backup?

BaishanCloud CDN provides a whole-site backup service, but it is not yet integrated with cloud storage.


### How do users import data

BaishanCloud Storage provides multiple ways for users to import data.

- End users use the SDK interface to upload files to the storage. 

- End users use the SDK to generate offline download tasks, and the storage's offline download subsystem is responsible for downloading data from the origin and synchronizing it to the storage.

- End users configure the rules for 404 back to the origin, and when end user accesses the bucket, it will automatically go to the origin site to grab the data and synchronize it to the storage.

- End users provide the download list of files, and BaishanCloud Storage will download and synchronize the data to the storage through the file list.

- End users can mail the hard disk.


### If the file does not exist in the storage, can I automatically have the storage go to a specific place to pull it? 

If the file does not exist in BaishanCloud Storage, you can configure it to go to a specific domain to pull the file. <br/> 

The file pulling is asynchronous, and the pulling completion time is related to the size of the file being pulled. <br/> 

The request also returns a 302, and the value of the location response header is the address where the file was pulled. <br/>
To use the pull function, you need to provide: 

- The origin domain name.

- The mapping rule from request uri to the uri where the file is pulled.

- The validation method for the origin request (optional).

- Whether to enable the HEAD request to the origin.

### How to use offline download to synchronize data? 

The offline download service supports HTTP protocol, BitTorrent protocol, Magnet URI scheme, etc. <br/> 

By submitting an offline download task, the offline download service will download the file from the address provided in the task and synchronize it to the storage. Once the synchronization is complete, the result of the operation will be sent to the user. <br/>

It supports download task status inquiry, task cancellation, download data corruption check, message transmission, etc. High performance with more than 2000 rps/s.<br/> 

How to use:

- Use SDK, send request to offline.bscstorage.com, request url: http://offline\_domain/<bucket>, bucket name is the bucket to store the file.

- Send the request for the offline task, e.g.

```
{   "Url":"http://www.abc.com/download/movie.mp4",
    "Key":"movies/2016/movie.mp4",
    "SHA1":"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde",
    "MD5":"abcdabcdabcdabcdabcdabcdabcdabcd",
    "CRC32":"abcdef",
    "SuccessCallbackUrl":"http://website/succ/",
    "FailureCallbackUrl":"http://website/fail/",
    }
```

- The user needs to start a service for receiving offline download results.

### Does it support multi-file uploads?

Multiple file submissions in a single request are not supported. <br/> 

If the user wants to submit multiple files in one request for efficiency reasons, it is recommended that the user uses TCP long connections to send multiple requests for uploading files,<br/>.

This avoids establishing multiple connections and is about as efficient as submitting multiple files in a single request.


### How to upload large files and what are the limitations? 


- There is no limit to the total data capacity or the number of data objects on BaishanCloud Storage. The size of each data object can range from 1 byte to 1 TB. 

- The maximum data objects that can be uploaded in a single PUT request is 1TB. 

- For large files it is recommended to use the Slice Upload interface for uploading large files in slices, the limits for slice uploads are 

  - Maximum 512MB per slice. 

  - The maximum number of slices is 2000. 

  - The maximum upload file size is 1TB. 


- Large file uploads are divided into 3 steps:

  - First initializate interface for slice uploads, the request returns an uploadId, the subsequent 2 steps need this uploadId to identify each slice to upload. 

  - The large file is divided into several pieces to be uploaded, and the order of the pieces is identified in the request by the partNmuber parameter.

  - When the upload is complete, the slice completion interface is called to notify storage that the file slice upload is complete. 



### What are the access control permissions? 

- The authorized person can be a user, a group or all users 

- For Bucket control permissions:

  - Read only: allows the authorized person to list all objects in the bucket.
      
  - Write: allows the authorized person to create, overwrite and delete objects in the bucket. 

  - Read ACL(Access Control List): Allows the authorized person to read the ACL of the bucket. 
      
  - Write ACL: Allows the authorized person to modify the ACL of the bucket. 

  - All permissions: Allows the authorized person to read, write, read ACL, and write ACL of the storage bucket.
    
- For Object control permissions:
  
    - Read: Allows the authorized person to read the data and meta information of the object. 

    - Read ACL(Access Control List): allows the authorized person to read the ACL of the object. 

    - Write ACL: allows the authorized person to modify the ACL of the object. 

    - All permissions: allow the authorized person to read, read ACL, write ACL on the object.



### Is it possible to modify bucket and object without signature (anonymous access)? 


Normal operations require a signature to verify user permissions, but it is possible to set a common attribute that allows users to operate without a signature. 

- By setting the bucket permissions to public-read, any user can list the files under the bucket and request them without a signature. 

- After setting the bucket permission to public-read-write, any user can list the files under this bucket and upload files to this bucket, and the request does not require a signature. 

- When uploading a file, after specifying object permissions as public-read, any user can download the file without a signature, which is called anonymous download. 

- When a user accesses the storage through a CDN request, the request does not require a signature to access the files on the storage because the CDN nodes are configured with full permissions.

### Does storage support decompression of user's file packages? 

- It is not supported for now, however, it can be developed if required.

### Does it support restore downloads? 


- Support, use HTTP1.1 protocol (RFC2616) Range and Content-Range header field to restore download, specific header field settings refer to [rfc2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35)

---

## Video processing 

### Is there a requirement for origin file format for transcoding? 

There are no requirements, basically all formats are supported. 

### Does the transcoding template describe the input file or the output file?

The transcoding template is to configure the format and other information of the output file, there is no need to configure anything for the input file.

### What does transcoding templates include?

- Encapsulation formats, flv, mp4, ts, etc. 

- Video encoding format, h265, h264, mpeg2, etc. 

- Video bitrate 

- Video resolution 

- Video keyframe interval 

- Video frame rate

- Audio encoding format, aac, mp2, mp3, etc. 

- Audio bitrate 

- Number of audio channels

### What output formats are supported:

- flv

- fmp4

- mp4

- ts

- mp3

- wma

- wmv

- mp2

- aac

- gif

### Does it support video slicing?

Yes, you can create a transcoding task and specify the duration of the slice segment, provided that the package format ts of the template configuration is used.







### Does it support video watermark?



Yes, the watermark location information is configured in the transcoding template, and you can create a transcoding task and add a watermark image.







### Are video clips supported?



Yes, you can create a transcoding task and specify the start time and duration.







### Does hls slice support AES128 encryption?



Support, create transcoding and provide encrypted key, decrypted url, and encrypted iv vector (optional).







### Does it support 4K transcoding?



Support, you can configure 4k resolution in the template



automatic transcoding



Automatic transcoding means that a transcoding task is automatically created for this file system while uploading a file.



The path where the output file is stored, for example, the source file is a/b/xx.mp4



If the configuration is consistent with the source file path, the file suffix is configured as foo.ts, and the key in the storage is a/b/xxfoo.ts



If there is no configuration and the source file path is consistent, the file suffix is configured as foo.ts, and the key in the storage is xxfoo.ts

### How long does it take to transcode a 1h video?



Transcoding takes about 45 – 60 minutes. If the video encoding and audio encoding remain unchanged (Also known as transcoding, which only the suffix name has changed), it will take 3 - 5 minutes. This is only the estimated time, high resolution and special format time will take longer.

### Can the m3u8 file generated by video slicing be played directly through cloud storage?



Normally it cannot be played. The m3u8 file stores a list of a bunch of small ts files. When playing, the player needs to download the small ts files from the storage, but the download needs to be signed.



Set all small ts files to be anonymous and accessible, and they can be played.



Through CDN, when cloud storage is set as the origin, the file can be played.

### Manually created a transcoding task, but can't find the target file after completion?



It is possible that the output file prefix is not specified, and the target file is placed in the bucket root directory

## Image processing



### Does BaishanCloud Storage support real-time image conversion, rotation, scaling, cutting, and watermarking?





- Yes, we support those functions, please see imgx\_manual documentation for details.



- The processed image is generated and cached, and the next request will not be repeated, and the default cache period is 7 days.



- If a CDN acceleration is configured, the processed images will be automatically pushed to the CDN node.



- If the original image is modified, you can use the v command to regenerate the image and link.







### Is it possible to let the storage automatically determine that the user-agent triggers a specific image cropping output?







Not supported currently, please contact your account team to submit development request if needed.

### Is there a video transcoding function?







- Support conversion between flv, mp4, mov and other formats



- Support for reducing bit rate, resolution, modifying gop (key frame interval) and other functions



- Support video screenshots.







This feature is currently under development and will be provided in the future. Please contact the support team for more details.



---


## User management storage resource related, management console







### What information can storage users view through the background?







The information that can be viewed in the background includes:







- User space information, including usage, number of files used.



- You can view the user's bandwidth, traffic, number of requests, etc.



- You can view file size distribution, file type distribution, etc.



- Provide billing information, including billing details for used traffic, space, and number of requests.



- Provide documents such as image processing to help users use.



- Provides key management.







### Whether the storage console has the function of searching for files. For example, the full path of a file in a bucket is abc/def/123.png. Can you use the file name 123.png to search for the file without knowing the full path? ?



Currently, there is no search function developed in the console. You can use the head command to find files under each bucket.







### Can I count the number of files under a bucket?







The number of files can be viewed from the number of files in the bucket in the database.







### Does Baishan Cloud Storage provide log download?







It is currently not supported from the console, please contact the support team for assistance.


---

## Performance, Reliability, Availability







### Does Baishan Cloud Storage do upload acceleration?







Yes, Baishan cloud storage uses its robust  network with the edge nodes of CDN to improve the upload speed. <br/>



When the user requests accelerated upload of the domain name, the DNS server intelligently returns the IP of the CDN edge node closest to the user to the user. <br/>



The user uploads the file to the nearest edge node, and the edge node transmits the data to the storage center through the optimal path. <br/>







Compared with the accelerated upload by the edge node and the direct upload to the storage center, the average speed is more than doubled, which greatly improves the upload experience. <br/>



Using upload acceleration is very simple, you only need to use acceleration to upload the domain name.







### Does Baishan Cloud Storage integrate CDN support?







Baishan cloud storage and Baishan CDN are perfectly integrated, application for storage and CDN can be carried out at the same time, and there is a complete configuration process







- CDN upload acceleration



- CDN supports virtual domain name back-to-origin



- CDN supports signature back-to-source to protect user data security



- At the same time, Baishan Cloud Storage also supports third-party CDN back-to-origin



- How to configure CDN and cloud storage:

````



If you want to test the download acceleration through CDN, you need to change the CNAME of the domain name from your DNS provider to start,<br/>



For example, www.qq.com.i.qingcdn.com, the CDN returns to ss.bscstorage.com.





Suggestions for creating buckets:



1. Create a bucket with the same name as the user domain name.



For example, if the user website domain name is www.qq.com, then create a bucket such as www.qq.com. Then when the CDN is configured to accelerate, there is no need to modify the host.



2. User-defined bucket name:



For example, if the user website domain name is www.qq.com, and the user wants to create a qq bucket, when the CDN is configured for acceleration, the user accesses www.qq.com.ss.bscstorage.com, and when returning to the origin, the host needs to be changed to qq. ss.bscstorage.com



````

### Is HTTPS supported? How to use?

- Support HTTPS method.

- If it is a user domain name, first, the user domain name needs to have ICP license, and the user needs to apply for an SSL certificate for the domain name, and then upload the certificate to BaishanCloud console, please contact support team if you need any assistance with aquiring SSL certificate.

- If you use the domain name provided by Baishan Cloud Storage, for example: https://ss.bscstorage.com, Note: The bucket must be placed in the url request, not the domain name.

### Is encrypted storage supported?

Not currently supported

### How reliable is it?


- Baishan Cloud Storage ensures reliability up to 99.999% through mechanisms such as multiple data center, multiple cached files, and fast failover.

---

## Pre-sales support, POC testing, etc.

### Is there an environment for quick POC testing? What is the application process?

Currently it is manually reviewed and opened. Please provide the following information when applying:

- The full company name of the applicant client.

- The user is required to provide an email address (login email).

- The initial password for the user to log in to the storage console.



- In order to better cooperate with the test, the user is also required to provide the following information:

   - Upload file type, image video text.

   - Average file size range.

   - Approximate storage space requirements.

   - Whether you need to use CDN.

   - Whether upload acceleration is required.


- BaishanCloud support team will create a user, generate the accseskey and secretkey corresponding to the user, and create a bucket corresponding to the user.



- Users can use accseskey and secretkey, and encode according to the demo given in the SDK.


### How to apply for upload acceleration?







Use the upload acceleration domain name and call the SDK for uploading files.







### How to apply for storage and CDN service at the same time?







- CDN user application address: http://www.qingcdn.com/account/index/login



- Cloud storage users, manual application.







### How does the origin set the cache time?







BaishanCloud Storage can set the settings of HTTP request headers such as Cache-Control of stored files and send the cache settings together with HTTP access requests. <br/>



BaishanCloud CDN can execute the cache policy according to the Cache-Control setting in the HTTP request header returned by the origin site.







---







## Related to third-party service integration







### Is there an integrated text editor for uploading images?







Some customers have proposed the whole page upload function, but this function is not supported currently.







---







## Daily use related







### Does BaishanCloud Storage provide a web management interface for users to manage their own files?







Provide, management interface login address: https://cwn-ss.portal.baishancloud.com


### How to upload files? Is it possible to upload via FTP or rsync? Is there a client can be used?

BaishanCloud Storage follows and is compatible with Amazon S3 REST API. <br/>



There are many mature and reliable SDKs and command-line tools in the community, which are compatible with Amazon S3 REST API, so they can be used directly, which can completely save the development work of the interface layer.



For example the popular:

-   [s3cmd][s3cmd]

-   [boto][boto]

Baishan cloud storage does not support FTP or rsync protocol. Because amazon s3 has more fine-grained control over file permissions.



Graphical FTP alternatives can use cyberduck and crossftp for Mac or s3browser and crossftp for Windows.



Alternatives to command line ftp or rsync can use [s3cmd][s3cmd]



or [aws cli](https://aws.amazon.com/cn/cli/)







To support mounting a bucket on a Linux host, so that files in the bucket can be accessed like local files, the following third-party tools can be used

- s3fs

- riofs

- googys

---

[s3cmd]:        http://s3tools.org/s3cmd

[boto]:         http://boto.cloudhackers.com/en/latest/

[cyberduck]:    https://cyberduck.io/

[s3browser]:    http://s3browser.com

[AWS SDK for Java Developer Guide]:http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/aws-sdk-java-dg.pdf

[aws-java-sdk]:https://sdk-for-java.amazonwebservices.com/latest/aws-java-sdk.zip

[Boto 3 - The AWS SDK for Python]:https://github.com/boto/boto3#quick-start

[Boto 3 Documentation]:http://boto3.readthedocs.io/en/latest/index.html

[Getting Started with the SDK in the Browser]:http://docs.aws.amazon.com/AWSJavaScriptSDK/guide/browser-intro.html

[Bower]:https://bower.io/

[AWS Mobile SDK iOS Developer Guid]:http://docs.aws.amazon.com/mobile/sdkforios/developerguide/aws-ios-dg.pdf

[aws-ios-sdk]:https://sdk-for-ios.amazonwebservices.com/latest/aws-ios-sdk.zip

[AWS Mobile SDK for Android Documentation]:https://aws.amazon.com/cn/documentation/sdk-for-android/

[aws-android-sdk]:https://sdk-for-android.amazonwebservices.com/latest/aws-android-sdk.zip

[AWSToolsAndSDKForNet.msi]:https://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi

[AWS SDK for .NET Documentation]:https://aws.amazon.com/cn/documentation/sdk-for-net/

[AWS SDK for JavaScript Documentation]:https://aws.amazon.com/cn/documentation/sdk-for-javascript/

[Getting Started with the SDK in Node.js]:http://docs.aws.amazon.com/AWSJavaScriptSDK/guide/node-intro.html

[AWS SDK for PHP Documentation]:https://aws.amazon.com/cn/documentation/sdk-for-php/

[Installing via Composer]:http://docs.aws.amazon.com/aws-sdk-php/v3/guide/getting-started/installation.html

[AWS SDK for Ruby]:https://aws.amazon.com/cn/documentation/sdk-for-ruby/

[AWS SDK for Ruby Developer Guide v2.16.8]:http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/

[AWS SDK for Go]:http://docs.aws.amazon.com/sdk-for-go/api/

[aws-sdk-go]:https://github.com/aws/aws-sdk-go/wiki

[AWS SDK for C++ Documentation]:https://aws.amazon.com/cn/documentation/sdk-for-cpp/

[aws-sdk-cpp]:https://github.com/aws/aws-sdk-cpp

## SDK Related

### Error when uploading file using java SDK ：Unable to verify integrity of data upload.  Client calculated content hash (contentMD5: E+6KS0B2pNPJ272XbG92fw== in base 64) didn't match hash (etag: 359740e5918c395b6e35a2c612582e42 in hex) calculated by Amazon S3

When uploading files, the Java SDK uses the "ChunkedEncoding" method by default. We do not support this method at the moment. You can disable this upload method through parameter settings. Please refer to the following example.

```java
BasicAWSCredentials awsCreds = new BasicAWSCredentials(
		accessKey, secretKey);
AmazonS3 s3 = new AmazonS3Client(awsCreds);

s3.setS3ClientOptions(S3ClientOptions.builder().disableChunkedEncoding().build());
```

### Error when uploading file using android SDK ：Unable to verify integrity of data upload. Client calculated content hash didn't match hash calculated by Amazon S3. You may need to delete the data stored in Amazon S3

When uploading files, the android SDK uses the "ChunkedEncoding" method by default. We do not support this method for the time being. Although the android SDK provides an interface to disable this method, it still cannot take effect after setting it to disable, so it needs to be signed by using v2. to circumvent this problem. "ChunkedEncoding" is only used for v4 signatures.

To set the method to use v2 signature, please refer to the following code.

```java
AWSCredentials credentials = new BasicAWSCredentials(
		accessKey, secretKey);

ClientConfiguration configuration = new ClientConfiguration();
configuration.setSignerOverride("S3SignerType");

AmazonS3 s3 = new AmazonS3Client(credentials, configuration);
```

### When uploading and downloading files using the ios SDK, an error occurs: Code: 403; Error Code: SignatureDoesNotMatch; Request ID: 23e338d9-1706-1410-3759-a0369fd80cca

The iOS SDK will determine the service type according to the domain name specified by the endpoint. For example, if the domain name starts with 's3' (s3.amazonaws.com), it means that the request is for s3 service, and the corresponding signature method is used. Therefore, when specifying a non-AWS standard When the domain name is used, it will result in the use of an incorrect signature method. In addition, there are few configurable parameters in the ios SDK, and the behavior of the SDK can only be changed by modifying the source code. Source code github address: 'https://github.com/aws/aws-sdk-ios.git'. A new line needs to be inserted at line 319 of the file AWSCore/Authentication/AWSSignature.m: '[request setValue:contentSha256 forHTTPHeaderField:@"x-amz-content-sha256"];'. Then execute the following command in the source code root directory to compile the source code:

```shell
chmod +x Scripts/SdkPackage.sh
sh Scripts/Package.sh
```

Since you only need to recompile AWSCore, you can edit the Scripts/Package.sh file and delete the code for compiling other modules. After deletion, the end of the file is as follows:

```shell
if [ -x "Scripts/SdkPackage.sh" ]; then
    Scripts/SdkPackage.sh AWSCore
fi
```

The compiled framework is located in the builtFramework/framework directory. Use the newly compiled AWSCore.framework to replace the original one in the project.

### Downloading AWS SDK from Maven Repository is too slow and easily lead to disconnection. You can add the following configuration to pom.xml to replace the mirror.

```java
<repositories>
    <repository>
        <id>my-repo1</id>
        <name>your custom repo</name>
        <url>http://mirrors.redv.com/maven2</url>
    </repository>
</repositories>
```

### How to set up signature version for SDK

#### java SDK

java SDK default using signature version 4, to use signature version 2, please add the following script:

```java
import com.amazonaws.ClientConfiguration;

ClientConfiguration clientconfiguration = new ClientConfiguration();
clientconfiguration.setSignerOverride("S3SignerType");
AmazonS3 client = new AmazonS3Client(awsCreds, clientconfiguration);
```

#### python SDK

python SDK(boto3) default using signature version 2, to use signature version 4, please add the following script:

``` python
from botocore.client import Config

config = Config(signature_version='s3v4')
client = boto3.client(
	's3',
	aws_access_key_id = access_key,
	aws_secret_access_key = secret_key,
	config = config,
	region_name = 'us-east-1',
	endpoint_url = 'http://bscstorage.com',
)
```

#### php SDK

php SDK only support signature version 4, signature version 2 not supported. 

#### go SDK

go SDK only support signature version 4, signature version 2 not supported.


#### JavaScript SDK

JavaScript SDK default using signature version 2, to use signature version 4, please add the following script:

```javasrcript
AWS.config.signatureVersion = 'v4';
```
