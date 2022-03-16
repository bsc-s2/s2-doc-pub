## Overview
-------------------

We provide a set of RESTful APIs compatible with AmazonS3, which can give you more freedom to develop flexible features.

BaishanCloud Storage Service provides the following three main types of APIs.

* Service operations
* Bucket operations
* Object operation

At the same time, to improve the security of user usage, White Mountain Cloud Storage Service also verifies the identity of the requestor by using signatures.

For more information about the signature algorithm, please refer to [Signature Algorithm](signature/signature.md).

Note: The examples used in the following interfaces are in the context of requiring the use of signatures; if the associated access resource has been set to be accessible anonymously (to all users), it may not carry a signature.
