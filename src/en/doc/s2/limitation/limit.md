## Constraint and limitation

- Coding restriction

- Bucket name, object key, meta, ACL, etc. only supports UTF-8 encoding

- The URL to access the resource should be encoded by rawurlencode

- Object key needs to be encoded by rawurlencode except "/"

- Naming rule

The name of bucket and object in API shall comply with the following rules:

Bucket name:

- It is unique in cloud storage

- It is composed of the lowercase letter, the number and the character "-" and the length should be from 6 to 63 digits;

- Cannot start with the number and the character '-'；

- Cannot start or end with '-'；

- Or use the domain name, such as xxx.foo.com.cn, which is convenient for binding your domain name

Object name:

- The length of the key cannot exceed 512 bytes；

- The key excepts "/" should be encoded by rawurlencode
