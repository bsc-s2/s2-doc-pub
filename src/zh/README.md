## 概述
-------------------

我们提供了一套兼容AmazonS3的RESTful API，可以使您更加自由地开发出灵活的功能。

白山云存储服务主要提供以下三类API：

* Service操作
* Bucket操作
* Object操作

与此同时，为提高用户使用的安全性，白山云存储服务还通过使用签名来验证请求者的身份。

如需了解签名算法的详细信息，请参考[《签名算法》](signature/signature.md)。

注意：以下接口中所使用的示例都是在需要使用签名情况下；如果相关访问资源已设置为可匿名（所有用户）访问，则可不带签名。