# Transcoder 请求签名方式

Transcoder API 中的所有请求均需要签名验证。
Transcoder 服务目前支持 AWS V4 签名方式。包括下列四个步骤：
1. 创建 Canonical Request
2. 创建 String to Sign （请注意使用 `elastictranscoder` 服务名）
3. 使用 HMAC 方法生成签名。

具体 V4 签名步骤请参考：[签名算法](.doc/s2/signature/signature.html#添加version-4-签名：)
