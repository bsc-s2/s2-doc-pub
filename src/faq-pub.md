[TOC]

## 基础知识普及

### Bucket和Object的概念

- Bucket是桶的意思，这个桶里面就可以存放很多文件。
- Object是对象的意思，我们可以把每个文件都作为一个对象。
- 用户可以创建桶、删除桶、查询桶里面的对象、可以设置桶的属性等。
- 用户可以创建一个对象（这个对象就是用户上传的文件）、删除对象、下载对象、设置对象的访问权限等。
- 小栗子：

```
1.创建一个桶,桶名叫: baishan_yun，请求的url：PUT /baishan_yun。
2.上传文件到baishan_yun的桶里，对象名叫: hello_world，每个文件通过桶名和对象名来唯一标识，请求的url：PUT /baishan_yun/hello_world。
3.要下载这个文件，请求的url：GET /baishan_yun/hello_world。
4.删除这个文件，请求的url：DELETE /baishan_yun/hello_world
5.删除桶，请求的url：DELETE /baishan_yun
```

---

##  编程接口相关, 用户使用相关

### 白山云存储有哪些技术优势？

- 白山云存储是CDN与云存储紧密结合的产品，白山云存储通过CDN边缘节点进行加速上传、通过全网CDN进行加速下载。但白山不强制将两者绑定，用户也可以单独使用云存储服务。
- 白山云存储是多副本、多IDC、分布式架构，保证高可靠性和可用性。
- 白山云存储提供丰富和便捷的图片处理功能，用户可以高效使用，且帮助客户避免重复上传/下载带来的费用。
- 白山云存储是完全自研开发的系统，老版本系统经历了长达7年的稳定运行，支持各种场景的存储需求，新版本更是提供了更高的性能，更丰富的功能。
- 白山云存储坚持以用户为主的原则，可以根据用户的需求进行定制开发, 帮助用户更方便的使用存储，并且提供7*24小时的技术人员在线服务，帮助用户迅速解决问题。
- 白山云存储提供多种用户数据导入机制，方便用户将数据迁移到存储上。
- 白山云存储遵循和兼容Amazon S3的接口；可以随意使用Amazon S3的官方SDK，功能强大、性能高, 并且用户也可以使用各种开源客户端、工具等。
- 白山云遵守Amazon S3 REST API接口，并严格遵守HTTP协议，避免接口不一致、标准不一致带来的各种问题, Amazon S3 REST API接口作为行业标准，已经有10多年没有修改了，非常稳定。
- 白山云支持Amazon S3的ACL访问控制，可以管理bucke和object的访问权限。每个bucke和object都有一个附加的ACL子资源。它定义了哪些用户或则组将被授予访问权限。

### 白山云存储支持的语言和SDK列表?

- 白山云存储兼容Amazon S3的接口。包括所有主流开发语言，例如：Python、Php、Browser、Node.js等。
- 在文档baishancloud_storage_api，有详细的对Python、Php、Browser、Node.js等语言的SDK的实例说明，能帮助开发人员快速入手。其余规则，可参考Amazon S3的API文档。

- Android  文档：[AWS Mobile SDK for Android Documentation][AWS Mobile SDK for Android Documentation]    SDK下载:[aws-android-sdk][aws-android-sdk]
- Browser  文档：[Getting Started with the SDK in the Browser][Getting Started with the SDK in the Browser]    SDK下载：[Bower][Bower]
- ISO      文档：[AWS Mobile SDK iOS Developer Guid][AWS Mobile SDK iOS Developer Guid]    SDK下载:[aws-ios-sdk][aws-ios-sdk]
- Java     文档：[AWS SDK for Java Developer Guide][AWS SDK for Java Developer Guide]SDK下载：[aws-java-sdk][aws-java-sdk]
- .NET     文档：[AWS SDK for .NET Documentation][AWS SDK for .NET Documentation]    SDK下载:[AWSToolsAndSDKForNet.msi][AWSToolsAndSDKForNet.msi]
- Node.js  文档：[AWS SDK for JavaScript Documentation][AWS SDK for JavaScript Documentation]    SDK下载:[Getting Started with the SDK in Node.js]
- PHP      文档：[AWS SDK for PHP Documentation][AWS SDK for PHP Documentation]    SDK下载:[Installing via Composer][Installing via Composer]
- Python   文档：[Boto 3 Documentation][Boto 3 Documentation]    SDK下载地址及说明：[Boto 3 - The AWS SDK for Python][Boto 3 - The AWS SDK for Python]
- Ruby     文档：[AWS SDK for Ruby][AWS SDK for Ruby]    SDK下载地址：[AWS SDK for Ruby Developer Guide v2.16.8][AWS SDK for Ruby Developer Guide v2.16.8]
- Go       文档：[AWS SDK for Go][AWS SDK for Go]    SDK下载地址：[aws-sdk-go][aws-sdk-go]
- C++      文档：[AWS SDK for C++ Documentation][AWS SDK for C++ Documentation]    SDK下载地址：[aws-sdk-cpp][aws-sdk-cpp]

### 云存储的Object是以目录结构存储的吗?

白山云存储的Object不是传统意义上的一个文件，存储方式也不是以文件系统保存的。
每个Object看上去是一个目录下的文件，但对于云存储只是一个类似目录的字符串。
但是这并不影响用户想从指定目录列文件的方式：<br/>
当发送列文件的请求时，设置prefix参数为目录前缀的名字，则可以只列出这个目录下的文件，比如：

- bucket/1.mp4
- bucket/cc/2.mp4
- bucket/cc/3.mp4
- bucket/dd/ee/ff/3.mp4

当请求的`prefix`指定为`cc`时，将会列出：

- 2.mp4
- 3.mp4

跟从目录列文件的体验是一样的。
除了模拟目录列文件，还提供指定列出最大的文件数目、指定从某个文件名之后列出文件(按照字母顺序进行排序)、将文件按公共前缀进行合并等功能，详细可参照API文档。

使用的时候需要注意的问题：

- Object 名字最好不要用 '/' 开头
  比如： 需要上传一个叫file.txt文件，bucket 是 `sandbox`,

  - object 设置为 `file.txt`, 访问的时候应该是 `http://s2.i.qingcdn.com/sandbox/file.txt` （推荐方式）
  - object 如果设置为 `/file.txt`, 访问的时候应该是 `http://s2.i.qingcdn.com/sandbox//file.txt` （强烈不推荐）

- Object 名字中最好不要有两个连续的 '/'
  比如： 需要在folder目录下上传一个叫file.txt文件，bucket 是 `sandbox`,

  - object 设置为 `folder/file.txt`, 访问的时候应该是 `http://s2.i.qingcdn.com/sandbox/folder/file.txt` （推荐方式）
  - object 如果设置为 `folder//file.txt`, 访问的时候应该是 `http://s2.i.qingcdn.com/sandbox/folder//file.txt` （强烈不推荐）
  - 为什么白山云存储不建议在URL中带有2个'//'：某些CDN的cache server可能会把URL中两个连续的'//'合并为一个'/'来回源，这个时候就会出现验证失败或者404

### 如何删除一个目录?

白山云存储删除目录的方法为：
白山云存储不支持直接删除一个目录,
因为 Amazon S3 API 没有严格意义上的目录的概念(没有目录层级的结构,但习惯上把 Object 按照"/"分隔当做目录来使用),这种情况下,对多个文件操作的原子性方面没法保证,
所以这方面都是写脚本做的.

可以通过以下方式完成该操作：

- 通过List Objects接口列出该目录的所有文件。
- 通过Delete Object接口逐一进行删除。
- 删除目录。

请注意：

- List Objects接口返回的文件列表不全部是该目录下的文件（列表是根据文件名字符排序的），
  可能包含下一个或几个目录；所以需要根据实际情况调整max-keys参数的值，
  并且需要对每一个文件进行筛选，确认是该目录的文件;
  如果设置 `prefix` 参数的话，就可以严格的列出以该 `prefix` 下所有文件.

- 一次删除（列出所有文件，逐一删除）不能保障该目录的文件都被清理完成
  在删除的过程中可能会有新上传，所以整个过程不能保持原子性。

### 是否可以使用白山云存储做整站的备份?

白山云CDN提供整站备份服务，但目前尚未与云存储整合。

### 用户如何导入数据？

白山云存储提供多种方式，方便用户导入数据。

- 用户使用SDK上传文件接口，将文件上传到存储上。
- 用户使用SDK生成离线下载任务，由存储的离线下载子系统负责将数据从源站进行下载，同步到存储上。
- 用户配置404回源的规则，当用户访问该用户的bucket，会自动去源站将数据抓取下来，同步到存储上。
- 用户提供文件的下载列表，白山云存储通过文件列表，将数据下载并同步到存储上。
- 用户邮寄硬盘的方式。

### 404回源, 如果存储上文件不存在, 是否可以自动让存储去特定的地方拉取?

如果白山云存储上不存在该文件，可以配置指定去某个域名拉取文件。<br/>
文件的拉取是异步的，拉取完成时间和拉取的文件大小相关。<br/>
同时该请求会返回302,location 响应头的值是文件拉取的地址。<br/>
使用拉取功能时，需要提供：

- 回源的域名domain。
- 请求uri到回源拉取文件uri的映射规则。
- 回源请求的校验方式（可选）。
- 是否启用HEAD请求回源拉取文件。

### 如何使用离线下载同步数据?

离线下载服务支持HTTP协议、BT协议、磁力链接等。<br/>
通过提交离线下载任务，离线下载服务会根据任务中提供的文件地址，从网站下载文件，并同步到存储上。同步完成后，给用户发送操作结果。<br/>
支持下载任务的状态查询、任务取消、下载数据损坏检查，消息秒传等功能高性能，性能达到2000多rps/s。<br/>
如何使用：

- 使用SDK，向offline.bscstorage.com发送请求，请求的url：http://offline_domain/<bucket>，bucket是要存放文件的桶。
- 发送请求的body体为离线的任务，比如：

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

- 用户需要起一个服务用于接收离线下载服务发送的离线下载结果。


### 多文件上传是否支持?

不支持一次请求提交多个文件。<br/>
如果用户是为了效率考虑，想一个请求提交多个文件，建议客户使用TCP的长连接，多次发送上传文件的请求，<br/>
这样避免建立多次连接，效率和一次请求提交多个文件差不多。

### 大文件如何上传, 有什么限制?

- 白山云存储的总数据容量和数据对象数量不受限制。各个数据对象的大小可在 1 字节至 1 TB 之间。
- 可在单个PUT中上传的最大数据对象为20GB。
- 对于大文件建议使用分片上传接口对大文件分片上传，分片上传的限制是：

  - 每个分片最大20GB。
  - 最多分片数是4096。
  - 最大上传文件大小是1TB。

- 大文件上传主要分为3步：

  - 首先调用分片上传初始化接口，请求返回一个uploadId, 后续2步需要这个uploadId标识每个分片上传。
  - 将大文件分成若干片，调用分片上传接口，上传每个分片, 请求中通过partNmuber参数标识这个块的顺序。
  - 上传完成后，调用分片完成接口，通知存储，文件分片上传完成。

### 访问控制权限有哪些？

- 被授权者可以是某个用户、某个组、所有用户
- 对于Bucket的控制权限：

  - 可读：允许被授权者列出bucket中所有的对象。
  - 可写：允许被授权者创建、覆盖和删除存储桶中的对象。
  - 可读ACL：允许被授权者读取存储桶的ACL。
  - 可写ACL：允许被授权者修改存储桶的ACL。
  - 全部权限：允许被授权者对存储桶的可读、可写、可读ACL、可写ACL。

- 对于Object的控制权限：

  - 可读：允许被授权者读取对象的数据和meta信息。
  - 可读ACL：允许被授权者读取对象的ACL。
  - 可写ACL：允许被授权者修改对象的ACL。
  - 全部权限：允许被授权者在对象上的可读、可读ACL、可写ACL。

### 是否可以不用签名操作操作bucket和object(匿名访问)?

正常的操作都需要签名进行用户权限的验证，但是也允许设置共有属性，让用户不用签名来操作。

- 将bucket权限设置成public-read之后，任何用户都可以列出这个bucket下的文件，请求不需要签名。
- 将bucket权限设置成public-read-write之后，任何用户都可以列出这个bucket下的文件，并且可以上传文件到该bucket下，请求不需要签名。
- 当上传文件时，指定Object的权限是public-read之后，任何用户都可以下载该文件，不需要签名，即所谓的匿名下载。
- 当用户通过CDN回源来访问存储时，因为给CDN配置了超级权限，所以请求不需要签名也可以访问存储上的文件。

### 存储支持解压客户的文件包吗？
- 现在不支持，如果项目规模足够大，可以定制开发。

---

##  周边服务, 图片, 视频处理等

### 白山存储支持实时图片转换,旋转,缩放,剪切,打水印吗?

- 支持，详见imgx_manual文档。
- 处理后的图片生成缓存，下次请求不在重复生成，默认缓存7天。
- 如果配置了CDN，处理后的图片会自动推送到CDN节点。
- 如果修改了原图，可以使用v指令重新生成图片和链接。

### 是否可以让存储自动判断user-agent触发特定的图片剪裁输出?

暂不支持，如有需求可以开发

### 是否有视频转码功能?

- 支持flv、mp4、mov等格式之间的转换
- 支持降低码率、分辨率、修改gop(关键帧间隔)等功能
- 支持视频截图。

该服务需要和厦门同事配合，目前正在开发中，后续会提供服务。

---

##  用户管理存储资源相关, 管理控制台

### 存储用户可以通过后台查看到哪些信息?

后台可以查看到的信息包括：

- 用户空间的信息，包括使用量、使用文件数。
- 可以查看用户的带宽、流量、请求次数等。
- 可以查看文件大小分布、文件类型分布等。
- 提供账单信息，包括使用的流量、空间、请求数的计费详情。
- 提供图片处理等文档，帮助用户使用。
- 提供秘钥管理。

### 存储控制台有没有搜索文件功能，如某个bucket下文件全路径是abc/def/123.png，在不知道此全路径的情况下，能否使用文件名              123.png搜索该文件？
目前在控制台暂时没有开发搜索功能，可以在每个bucket下面使用head命令查找文件。

### 能否统计某bucket下面的文件数量？

文件数量可以从查看数据库中的bucket的文件数，但是有误差。

### 白山云存储是否提供日志下载?

暂不支持，如有需求，后续可开发。


---

##  性能, 可靠性, 可用性相关

### 白山云存储是否做了上传加速?

白山云存储通过和CDN的边缘节点配合使用，提升上传的速度。<br/>
用户请求加速上传域名，由DNS服务器智能将距离用户最近的CDN边缘节点的ip返给用户。<br/>
用户将文件上传到最近的边缘节点，边缘节点通过最优路径，将数据传输到存储中心。<br/>

通过边缘节点加速上传和直接上传到存储中心的对比，平均速度提升一倍多，极大地改善了上传的体验。<br/>
使用上传加速很简单，只需要使用加速上传域名即可。

### 白山云存储是否整合了cdn支持?

白山云存储和白山CDN是完美整合,申请存储和CDN可以同时进行，有完善的配置流程

- CDN上传加速
- CDN支持虚拟域名回源
- CDN支持签名回源，保护用户的数据安全
- 同时白山云存储还支持第三方CDN回源
- CDN和云存储的配置方法：

```
如果要测试通过CDN进行下载加速的情况，需要将用户要访问的已备案的域名CNAME到CDN给出的域名，<br/>
例如www.qq.com.i.qingcdn.com，CDN回源至s2.i.qingcdn.com。

创建bucket的建议：
1、以用户域名创建同名的bucket。
例如用户网站域名www.qq.com，那么创建www.qq.com这样一个bucket，这时CDN配置加速时，无需修改host
2、用户自定义bucket的名字：
例如用户网站域名www.qq.com，用户要创建一个qq的bucket，那么CDN在配置加速时，用户访问www.qq.com.s2.i.qingcdn.com，回源时，需要将host修改成qq.s2.i.qingcdn.com
```

### https是否支持? 如何使用?

- 支持https方式。
- 如果是用户域名，首先用户域名需要备案，其次用户需要申请域名的SSL证书，然后将证书发给白山云，白山云配置完成后即可使用。
- 如果是使用白山云存储提供的域名，例如： https://ss.bscstorage.com， 注：必须将bucket放在url请求中，不要放在域名中。

### 加密存储是否支持?

暂不支持

### 可靠性是多少?

- 白山云存储通过多机房、多副本、快速的故障恢复等机制，保证可靠性达到13个9。

---

##  售前支持, 测试等

### 快速测试的环境？申请流程是什么?

目前为人工审核及开通。

- 申请客户的公司全称。
- 需要用户提供邮箱（登陆邮箱）。
- 用户登录存储控制台的初始密码。

- 为更好的配合测试，需要用户提供如下信息：

  - 上传文件类型，图片 视频 文本。
  - 平均文件的大小范围。
  - 大概存储空间需求。
  - 是否需要用CDN。
  - 是否需要上传加速。
 
- 研发同事创建user，生成user对应的accseskey和secretkey，创建user对应的bucket即可。
- 用户使用accseskey、secretkey，根据SDK中给出的demo进行编码，即可使用。

### 如何申请使用上传加速?

使用上传加速域名、调用上传文件的SDK即可。

### 如何同时申请存储和 cdn 服务?

- CDN用户申请地址：http://www.qingcdn.com/account/index/login
- 云存储用户，人工申请。

### 源存储如何设置缓存时间？

白山云存储可以设置所存储文件的Cache-Control等HTTP请求头的设置，并将缓存设置与HTTP访问请求一起下发。<br/>
白山云CDN可以按源站返回HTTP请求头里的Cache-Control设置执行缓存策略。

---

##  与第三方服务整合相关

### 是否有整合文本编辑器的上传图片？

有客户提出整网页上传功能，暂不支持此功能。

---

##  日常使用相关

### 白山云存储是否提供web管理界面让用户管理自己的文件?

提供，管理界面登陆地址：http://console.bscstorage.com


### 如何上传文件? 是否可以通过 ftp 或 rsync 的方式上传? 是否有客户端?

白山云存储遵循和兼容Amazon S3 REST API。<br/>
社区中有非常多成熟可靠的SDK和命令行工具，兼容Amazon S3 REST API，所以可以直接使用, 可完全省去接口层的开发工作。
例如流行的:

-   [s3cmd][s3cmd]
-   [boto][boto]

 白山云存储不支持 ftp 或 rsync 协议. 因为 amazon s3 对文件权限的控制粒度上更精细.

-   对图形界面的 ftp 替代品可以使用 Mac 下的 [cyberduck][cyberduck]
    或 Windows 下的[s3browser][s3browser].
-   对命令行方式的 ftp 或 rsync 的替代品可以使用 [s3cmd][s3cmd]
或[aws cli](https://aws.amazon.com/cn/cli/)
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

##  SDK 相关

### 在使用java SDK上传文件时报错：Unable to verify integrity of data upload.  Client calculated content hash (contentMD5: E+6KS0B2pNPJ272XbG92fw== in base 64) didn't match hash (etag: 359740e5918c395b6e35a2c612582e42 in hex) calculated by Amazon S3

Java SDK 在上传文件时，默认使用“ChunkedEncoding”的方式，我们暂不支持这种方式，您可以通过参数设置来禁用这种上传方式，可参考下面的例子。

```java
BasicAWSCredentials awsCreds = new BasicAWSCredentials(
		accessKey, secretKey);
AmazonS3 s3 = new AmazonS3Client(awsCreds);

s3.setS3ClientOptions(S3ClientOptions.builder().disableChunkedEncoding().build());
```

### 在使用android SDK上传文件时报错：Unable to verify integrity of data upload. Client calculated content hash didn't match hash calculated by Amazon S3. You may need to delete the data stored in Amazon S3

android SDK 在上传文件时，默认使用“ChunkedEncoding”的方式，我们暂不支持这种方式，虽然android SDK提供了接口禁用这种方式，
但是设置为禁用后，仍然不能生效，因此需要通过使用v2签名来绕开这个问题。“ChunkedEncoding”是只有v4签名的时候才会使用的。
设置使用v2签名的方法可以参考以下代码。

```java
AWSCredentials credentials = new BasicAWSCredentials(
		accessKey, secretKey);

ClientConfiguration configuration = new ClientConfiguration();
configuration.setSignerOverride("S3SignerType");

AmazonS3 s3 = new AmazonS3Client(credentials, configuration);
```

### 在使用ios SDK上传,下载文件时报错：Code: 403; Error Code: SignatureDoesNotMatch; Request ID: 23e338d9-1706-1410-3759-a0369fd80cca

ios SDK 会根据endpoint指定的域名来判断服务类型，如如果域名以‘s3’开头（s3.amazonaws.com)表示请求的是s3服务，则
使用对应的签名方式，因此，当指定非AWS的标准域名时，会导致使用不正确签名方式。另外ios SDK可配置参数较少，只能
通过修改源代码改变SDK行为。源代码github地址：‘https://github.com/aws/aws-sdk-ios.git‘。需在文件AWSCore/Authentication/AWSSignature.m第319行处插入新的一行：‘[request setValue:contentSha256 forHTTPHeaderField:@"x-amz-content-sha256"];‘。然后在源代码根目录执行以下命令编译源代码：

```shell
chmod +x Scripts/SdkPackage.sh
sh Scripts/Package.sh
```

由于只需要重新编译AWSCore，您可以编辑Scripts/Package.sh文件，删掉编译其他模块的代码，删掉后文件末尾如下：

```shell
if [ -x "Scripts/SdkPackage.sh" ]; then
    Scripts/SdkPackage.sh AWSCore
fi
```

编译好的framework位于builtFramework/framework目录，使用新编译得到的AWSCore.framework替换项目中原来的即可。

### 从Maven Repository下载AWS SDK时速度太慢，且容易断线。可以在pom.xml中加入以下配置，更换镜像。

```java
<repositories>
    <repository>
        <id>my-repo1</id>
        <name>your custom repo</name>
        <url>http://mirrors.redv.com/maven2</url>
    </repository>
</repositories>
```

### 如何让SDK使用指定版本的签名（V2签名或V4签名）。

#### java SDK

java SDK 默认使用V4签名，如果要使用V2签名，可参考下面的代码进行设置

```java
import com.amazonaws.ClientConfiguration;

ClientConfiguration clientconfiguration = new ClientConfiguration();
clientconfiguration.setSignerOverride("S3SignerType");
AmazonS3 client = new AmazonS3Client(awsCreds, clientconfiguration);
```

#### python SDK

python SDK(boto3) 默认使用V2签名，如果要使用V4签名，可参考下面的代码进行设置

```python
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

php SDK 只支持V4签名，不能使用V2签名

#### go SDK

go SDK 只支持V4签名，不能使用V2签名

#### JavaScript SDK

JavaScript SDK 默认使用V2签名，如果要使用V4签名，可添加下面的代码

```javasrcript
AWS.config.signatureVersion = 'v4';
```
