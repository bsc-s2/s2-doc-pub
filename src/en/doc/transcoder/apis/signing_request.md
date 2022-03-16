# Transcoder Request signature method

All  requests in the transcoder API require signature verification.Transcoder service currently supports AWS V4 signature. It includes the following four steps:

1.establish Canonical Request

2.establish String to Sign （Please pay attention to the use elastictranscoder service name ）

3.Generate a signature using the HMAC method.

For specific V4 signature steps, please refer to: [signature algorithm](https://doc.bscstorage.com/doc/s2/signature/signature.html#%E6%B7%BB%E5%8A%A0version-4-%E7%AD%BE%E5%90%8D%EF%BC%9A)

