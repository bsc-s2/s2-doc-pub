## 约束与限制
-------------------

- 编码限制

    -   bucket名称、object key、meta、ACL内容等只支持UTF-8编码=
    
    -   访问资源的url要进行rawurlencode编码
    
    -   object key除了“/”以外需要进行rawurlencode编码
    
- 命名规则

    API中的bucket和object的命名需符合以下规则：

    bucket命名:

    -   云存储内全局唯一；

    -   由小写字母、数字及“-”组成，长度为6~63位;

    -   不能以数字、‘-’开头;

    -   不能以‘-’开头或结尾;

    -   或者使用域名的名命名规则，例如：xxx.foo.com.cn，方便绑定您的域名

    object命名:

    -   key长度不超过512个字节；

    -   key除了“/”以外需要进行rawurlencode编码
