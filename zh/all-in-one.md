<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Content**

  - [概述](#%E6%A6%82%E8%BF%B0)
  - [编程接口相关, 用户使用相关](#%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3%E7%9B%B8%E5%85%B3-%E7%94%A8%E6%88%B7%E4%BD%BF%E7%94%A8%E7%9B%B8%E5%85%B3)
    - [白山云存储和七牛比的优势在哪里? 为什么七牛的API 不如 aws-s3的 API 灵活?  任稚](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E5%92%8C%E4%B8%83%E7%89%9B%E6%AF%94%E7%9A%84%E4%BC%98%E5%8A%BF%E5%9C%A8%E5%93%AA%E9%87%8C-%E4%B8%BA%E4%BB%80%E4%B9%88%E4%B8%83%E7%89%9B%E7%9A%84api-%E4%B8%8D%E5%A6%82-aws-s3%E7%9A%84-api-%E7%81%B5%E6%B4%BB--%E4%BB%BB%E7%A8%9A)
    - [白山云存储提供哪些语言的 SDK 客户端? 哪里可以找到快速上手的例子? 任稚](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E6%8F%90%E4%BE%9B%E5%93%AA%E4%BA%9B%E8%AF%AD%E8%A8%80%E7%9A%84-sdk-%E5%AE%A2%E6%88%B7%E7%AB%AF-%E5%93%AA%E9%87%8C%E5%8F%AF%E4%BB%A5%E6%89%BE%E5%88%B0%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E7%9A%84%E4%BE%8B%E5%AD%90-%E4%BB%BB%E7%A8%9A)
    - [如何删除一个目录? 沈杰](#%E5%A6%82%E4%BD%95%E5%88%A0%E9%99%A4%E4%B8%80%E4%B8%AA%E7%9B%AE%E5%BD%95-%E6%B2%88%E6%9D%B0)
    - [是否可以使用白山云存储做整站的备份? xp](#%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E4%BD%BF%E7%94%A8%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E5%81%9A%E6%95%B4%E7%AB%99%E7%9A%84%E5%A4%87%E4%BB%BD-xp)
    - [404回源, 如果存储上文件不存在, 是否可以自动让存储去特定的地方拉取? 书文](#404%E5%9B%9E%E6%BA%90-%E5%A6%82%E6%9E%9C%E5%AD%98%E5%82%A8%E4%B8%8A%E6%96%87%E4%BB%B6%E4%B8%8D%E5%AD%98%E5%9C%A8-%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E8%87%AA%E5%8A%A8%E8%AE%A9%E5%AD%98%E5%82%A8%E5%8E%BB%E7%89%B9%E5%AE%9A%E7%9A%84%E5%9C%B0%E6%96%B9%E6%8B%89%E5%8F%96-%E4%B9%A6%E6%96%87)
    - [数据同步, 导入: 如何使用离线下载同步数据，效率，速度如何? 闯](#%E6%95%B0%E6%8D%AE%E5%90%8C%E6%AD%A5-%E5%AF%BC%E5%85%A5-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8%E7%A6%BB%E7%BA%BF%E4%B8%8B%E8%BD%BD%E5%90%8C%E6%AD%A5%E6%95%B0%E6%8D%AE%EF%BC%8C%E6%95%88%E7%8E%87%EF%BC%8C%E9%80%9F%E5%BA%A6%E5%A6%82%E4%BD%95-%E9%97%AF)
    - [多文件上传是否支持? xp](#%E5%A4%9A%E6%96%87%E4%BB%B6%E4%B8%8A%E4%BC%A0%E6%98%AF%E5%90%A6%E6%94%AF%E6%8C%81-xp)
    - [超大文件上传是如何实现的, 有什么限制? 书文](#%E8%B6%85%E5%A4%A7%E6%96%87%E4%BB%B6%E4%B8%8A%E4%BC%A0%E6%98%AF%E5%A6%82%E4%BD%95%E5%AE%9E%E7%8E%B0%E7%9A%84-%E6%9C%89%E4%BB%80%E4%B9%88%E9%99%90%E5%88%B6-%E4%B9%A6%E6%96%87)
    - [是否可以让文件允许任何用户下载(匿名下载)?，是否可以对每一个文件授权只让特定的用户下载? 沈杰](#%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E8%AE%A9%E6%96%87%E4%BB%B6%E5%85%81%E8%AE%B8%E4%BB%BB%E4%BD%95%E7%94%A8%E6%88%B7%E4%B8%8B%E8%BD%BD%E5%8C%BF%E5%90%8D%E4%B8%8B%E8%BD%BD%EF%BC%8C%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E5%AF%B9%E6%AF%8F%E4%B8%80%E4%B8%AA%E6%96%87%E4%BB%B6%E6%8E%88%E6%9D%83%E5%8F%AA%E8%AE%A9%E7%89%B9%E5%AE%9A%E7%9A%84%E7%94%A8%E6%88%B7%E4%B8%8B%E8%BD%BD-%E6%B2%88%E6%9D%B0)
  - [周边服务, 图片, 视频处理等](#%E5%91%A8%E8%BE%B9%E6%9C%8D%E5%8A%A1-%E5%9B%BE%E7%89%87-%E8%A7%86%E9%A2%91%E5%A4%84%E7%90%86%E7%AD%89)
    - [白山存储支持实时图片转换,旋转,缩放,剪切,打水印吗? xp](#%E7%99%BD%E5%B1%B1%E5%AD%98%E5%82%A8%E6%94%AF%E6%8C%81%E5%AE%9E%E6%97%B6%E5%9B%BE%E7%89%87%E8%BD%AC%E6%8D%A2%E6%97%8B%E8%BD%AC%E7%BC%A9%E6%94%BE%E5%89%AA%E5%88%87%E6%89%93%E6%B0%B4%E5%8D%B0%E5%90%97-xp)
    - [是否可以让存储自动判断user-agent触发特定的图片剪裁输出? 闯](#%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E8%AE%A9%E5%AD%98%E5%82%A8%E8%87%AA%E5%8A%A8%E5%88%A4%E6%96%ADuser-agent%E8%A7%A6%E5%8F%91%E7%89%B9%E5%AE%9A%E7%9A%84%E5%9B%BE%E7%89%87%E5%89%AA%E8%A3%81%E8%BE%93%E5%87%BA-%E9%97%AF)
    - [视频转码可以做吗? 沈杰](#%E8%A7%86%E9%A2%91%E8%BD%AC%E7%A0%81%E5%8F%AF%E4%BB%A5%E5%81%9A%E5%90%97-%E6%B2%88%E6%9D%B0)
  - [用户管理存储资源相关, 管理控制台](#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86%E5%AD%98%E5%82%A8%E8%B5%84%E6%BA%90%E7%9B%B8%E5%85%B3-%E7%AE%A1%E7%90%86%E6%8E%A7%E5%88%B6%E5%8F%B0)
    - [存储用户可以有后台可以看到存储服务的使用量吗? 林飞](#%E5%AD%98%E5%82%A8%E7%94%A8%E6%88%B7%E5%8F%AF%E4%BB%A5%E6%9C%89%E5%90%8E%E5%8F%B0%E5%8F%AF%E4%BB%A5%E7%9C%8B%E5%88%B0%E5%AD%98%E5%82%A8%E6%9C%8D%E5%8A%A1%E7%9A%84%E4%BD%BF%E7%94%A8%E9%87%8F%E5%90%97-%E6%9E%97%E9%A3%9E)
    - [白山云存储是否提供日志下载? 林飞](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E6%98%AF%E5%90%A6%E6%8F%90%E4%BE%9B%E6%97%A5%E5%BF%97%E4%B8%8B%E8%BD%BD-%E6%9E%97%E9%A3%9E)
  - [性能, 可靠性, 可用性相关](#%E6%80%A7%E8%83%BD-%E5%8F%AF%E9%9D%A0%E6%80%A7-%E5%8F%AF%E7%94%A8%E6%80%A7%E7%9B%B8%E5%85%B3)
    - [白山云存储是否做了上传(cdn)加速,来提升访问质量?  闯](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E6%98%AF%E5%90%A6%E5%81%9A%E4%BA%86%E4%B8%8A%E4%BC%A0cdn%E5%8A%A0%E9%80%9F%E6%9D%A5%E6%8F%90%E5%8D%87%E8%AE%BF%E9%97%AE%E8%B4%A8%E9%87%8F--%E9%97%AF)
    - [白山云存储是否整合了cdn支持? 沈杰](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E6%98%AF%E5%90%A6%E6%95%B4%E5%90%88%E4%BA%86cdn%E6%94%AF%E6%8C%81-%E6%B2%88%E6%9D%B0)
    - [https是否支持? 如何使用? 林飞](#https%E6%98%AF%E5%90%A6%E6%94%AF%E6%8C%81-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8-%E6%9E%97%E9%A3%9E)
    - [加密存储是否支持? 书文](#%E5%8A%A0%E5%AF%86%E5%AD%98%E5%82%A8%E6%98%AF%E5%90%A6%E6%94%AF%E6%8C%81-%E4%B9%A6%E6%96%87)
    - [文件可靠性多少，会不会丢文件?服务可用性是多少? xp](#%E6%96%87%E4%BB%B6%E5%8F%AF%E9%9D%A0%E6%80%A7%E5%A4%9A%E5%B0%91%EF%BC%8C%E4%BC%9A%E4%B8%8D%E4%BC%9A%E4%B8%A2%E6%96%87%E4%BB%B6%E6%9C%8D%E5%8A%A1%E5%8F%AF%E7%94%A8%E6%80%A7%E6%98%AF%E5%A4%9A%E5%B0%91-xp)
    - [上传文件后多久可以下载到这个文件? xp](#%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6%E5%90%8E%E5%A4%9A%E4%B9%85%E5%8F%AF%E4%BB%A5%E4%B8%8B%E8%BD%BD%E5%88%B0%E8%BF%99%E4%B8%AA%E6%96%87%E4%BB%B6-xp)
  - [售前支持, 测试等](#%E5%94%AE%E5%89%8D%E6%94%AF%E6%8C%81-%E6%B5%8B%E8%AF%95%E7%AD%89)
    - [快速测试的环境？申请流程是什么? 林飞](#%E5%BF%AB%E9%80%9F%E6%B5%8B%E8%AF%95%E7%9A%84%E7%8E%AF%E5%A2%83%EF%BC%9F%E7%94%B3%E8%AF%B7%E6%B5%81%E7%A8%8B%E6%98%AF%E4%BB%80%E4%B9%88-%E6%9E%97%E9%A3%9E)
    - [如何申请使用上传加速? 闯](#%E5%A6%82%E4%BD%95%E7%94%B3%E8%AF%B7%E4%BD%BF%E7%94%A8%E4%B8%8A%E4%BC%A0%E5%8A%A0%E9%80%9F-%E9%97%AF)
    - [如何同时申请存储和 cdn 服务? 沈杰](#%E5%A6%82%E4%BD%95%E5%90%8C%E6%97%B6%E7%94%B3%E8%AF%B7%E5%AD%98%E5%82%A8%E5%92%8C-cdn-%E6%9C%8D%E5%8A%A1-%E6%B2%88%E6%9D%B0)
    - [使用白山云存储如何配置和控制 CDN 的缓存时间等策略? 任稚](#%E4%BD%BF%E7%94%A8%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E5%A6%82%E4%BD%95%E9%85%8D%E7%BD%AE%E5%92%8C%E6%8E%A7%E5%88%B6-cdn-%E7%9A%84%E7%BC%93%E5%AD%98%E6%97%B6%E9%97%B4%E7%AD%89%E7%AD%96%E7%95%A5-%E4%BB%BB%E7%A8%9A)
  - [与第三方服务整合相关](#%E4%B8%8E%E7%AC%AC%E4%B8%89%E6%96%B9%E6%9C%8D%E5%8A%A1%E6%95%B4%E5%90%88%E7%9B%B8%E5%85%B3)
    - [整合文本编辑器的上传图片 闯](#%E6%95%B4%E5%90%88%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8%E7%9A%84%E4%B8%8A%E4%BC%A0%E5%9B%BE%E7%89%87-%E9%97%AF)
  - [日常使用相关](#%E6%97%A5%E5%B8%B8%E4%BD%BF%E7%94%A8%E7%9B%B8%E5%85%B3)
    - [白山云存储是否提供图形界面gui,或web管理界面让用户管理自己的文件? xp](#%E7%99%BD%E5%B1%B1%E4%BA%91%E5%AD%98%E5%82%A8%E6%98%AF%E5%90%A6%E6%8F%90%E4%BE%9B%E5%9B%BE%E5%BD%A2%E7%95%8C%E9%9D%A2gui%E6%88%96web%E7%AE%A1%E7%90%86%E7%95%8C%E9%9D%A2%E8%AE%A9%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86%E8%87%AA%E5%B7%B1%E7%9A%84%E6%96%87%E4%BB%B6-xp)
    - [如何上传文件? 是否可以通过 ftp 或 rsync 的方式上传? 是否有客户端?](#%E5%A6%82%E4%BD%95%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6-%E6%98%AF%E5%90%A6%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87-ftp-%E6%88%96-rsync-%E7%9A%84%E6%96%B9%E5%BC%8F%E4%B8%8A%E4%BC%A0-%E6%98%AF%E5%90%A6%E6%9C%89%E5%AE%A2%E6%88%B7%E7%AB%AF)
  - [实例（兼容Amazon SDK）](#%E5%AE%9E%E4%BE%8B%EF%BC%88%E5%85%BC%E5%AE%B9amazon-sdk%EF%BC%89)
  - [Python Demo](#python-demo)
    - [安装AWS Python 客户端boto3](#%E5%AE%89%E8%A3%85aws-python-%E5%AE%A2%E6%88%B7%E7%AB%AFboto3)
    - [初始化，设置帐号信息和域名](#%E5%88%9D%E5%A7%8B%E5%8C%96%EF%BC%8C%E8%AE%BE%E7%BD%AE%E5%B8%90%E5%8F%B7%E4%BF%A1%E6%81%AF%E5%92%8C%E5%9F%9F%E5%90%8D)
    - [文件操作接口](#%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E6%8E%A5%E5%8F%A3)
      - [上传文件](#%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6)
        - [使用put_object接口上传](#%E4%BD%BF%E7%94%A8put_object%E6%8E%A5%E5%8F%A3%E4%B8%8A%E4%BC%A0)
        - [使用upload_file接口上传（适合大文件上传，支持自动分块，多块并行上传）](#%E4%BD%BF%E7%94%A8upload_file%E6%8E%A5%E5%8F%A3%E4%B8%8A%E4%BC%A0%EF%BC%88%E9%80%82%E5%90%88%E5%A4%A7%E6%96%87%E4%BB%B6%E4%B8%8A%E4%BC%A0%EF%BC%8C%E6%94%AF%E6%8C%81%E8%87%AA%E5%8A%A8%E5%88%86%E5%9D%97%EF%BC%8C%E5%A4%9A%E5%9D%97%E5%B9%B6%E8%A1%8C%E4%B8%8A%E4%BC%A0%EF%BC%89)
      - [下载文件](#%E4%B8%8B%E8%BD%BD%E6%96%87%E4%BB%B6)
      - [获取文件的URL](#%E8%8E%B7%E5%8F%96%E6%96%87%E4%BB%B6%E7%9A%84url)
      - [删除文件](#%E5%88%A0%E9%99%A4%E6%96%87%E4%BB%B6)
      - [获取文件的ACL](#%E8%8E%B7%E5%8F%96%E6%96%87%E4%BB%B6%E7%9A%84acl)
      - [设置文件的ACL](#%E8%AE%BE%E7%BD%AE%E6%96%87%E4%BB%B6%E7%9A%84acl)
        - [使用预定义的ACL](#%E4%BD%BF%E7%94%A8%E9%A2%84%E5%AE%9A%E4%B9%89%E7%9A%84acl)
        - [使用自定义的ACL](#%E4%BD%BF%E7%94%A8%E8%87%AA%E5%AE%9A%E4%B9%89%E7%9A%84acl)
    - [桶操作接口](#%E6%A1%B6%E6%93%8D%E4%BD%9C%E6%8E%A5%E5%8F%A3)
      - [创建桶](#%E5%88%9B%E5%BB%BA%E6%A1%B6)
      - [列出桶中所包含的文件](#%E5%88%97%E5%87%BA%E6%A1%B6%E4%B8%AD%E6%89%80%E5%8C%85%E5%90%AB%E7%9A%84%E6%96%87%E4%BB%B6)
      - [删除桶](#%E5%88%A0%E9%99%A4%E6%A1%B6)
      - [获取桶的ACL](#%E8%8E%B7%E5%8F%96%E6%A1%B6%E7%9A%84acl)
      - [设置桶的ACL](#%E8%AE%BE%E7%BD%AE%E6%A1%B6%E7%9A%84acl)
        - [使用自定义的ACL](#%E4%BD%BF%E7%94%A8%E8%87%AA%E5%AE%9A%E4%B9%89%E7%9A%84acl-1)
    - [服务操作接口](#%E6%9C%8D%E5%8A%A1%E6%93%8D%E4%BD%9C%E6%8E%A5%E5%8F%A3)
      - [列出所有的桶](#%E5%88%97%E5%87%BA%E6%89%80%E6%9C%89%E7%9A%84%E6%A1%B6)
  - [PHP Demo](#php-demo)
  - [JavaScript  Demo](#javascript--demo)
  - [Node.js Demo](#nodejs-demo)
  - [API](#api)
  - [Bucket操作](#bucket%E6%93%8D%E4%BD%9C)
  - [Service操作](#service%E6%93%8D%E4%BD%9C)
    - [GET Service (List Buckets)](#get-service-list-buckets)
    - [GET Bucket (List Objects)](#get-bucket-list-objects)
    - [PUT Bucket](#put-bucket)
    - [DELETE Bucket](#delete-bucket)
    - [PUT Bucket ACL](#put-bucket-acl)
    - [GET Bucket ACL](#get-bucket-acl)
  - [Object操作](#object%E6%93%8D%E4%BD%9C)
    - [HEAD Object](#head-object)
    - [GET Object](#get-object)
    - [PUT Object](#put-object)
    - [POST Object](#post-object)
      - [Policy的构建：](#policy%E7%9A%84%E6%9E%84%E5%BB%BA%EF%BC%9A)
        - [expiration:](#expiration)
        - [Condition:](#condition)
          - [Condition 类型](#condition-%E7%B1%BB%E5%9E%8B)
          - [Conditions 字段](#conditions-%E5%AD%97%E6%AE%B5)
      - [Signature的构建：](#signature%E7%9A%84%E6%9E%84%E5%BB%BA%EF%BC%9A)
    - [PUT Object - Copy](#put-object---copy)
    - [DELETE Object](#delete-object)
    - [GET Object ACL](#get-object-acl)
    - [PUT Object ACL](#put-object-acl)
    - [Initiate Multipart Upload](#initiate-multipart-upload)
    - [Upload Part](#upload-part)
    - [Upload Part - Copy](#upload-part---copy)
    - [Complete Multipart Upload](#complete-multipart-upload)
    - [List Parts](#list-parts)
  - [签名算法](#%E7%AD%BE%E5%90%8D%E7%AE%97%E6%B3%95)
  - [添加签名](#%E6%B7%BB%E5%8A%A0%E7%AD%BE%E5%90%8D)
    - [添加version 2 签名](#%E6%B7%BB%E5%8A%A0version-2-%E7%AD%BE%E5%90%8D)
      - [身份信息与签名的携带方式：](#%E8%BA%AB%E4%BB%BD%E4%BF%A1%E6%81%AF%E4%B8%8E%E7%AD%BE%E5%90%8D%E7%9A%84%E6%90%BA%E5%B8%A6%E6%96%B9%E5%BC%8F%EF%BC%9A)
        - [通过Authorization请求头：](#%E9%80%9A%E8%BF%87authorization%E8%AF%B7%E6%B1%82%E5%A4%B4%EF%BC%9A)
        - [通过请求参数：](#%E9%80%9A%E8%BF%87%E8%AF%B7%E6%B1%82%E5%8F%82%E6%95%B0%EF%BC%9A)
      - [签名的计算方法：](#%E7%AD%BE%E5%90%8D%E7%9A%84%E8%AE%A1%E7%AE%97%E6%96%B9%E6%B3%95%EF%BC%9A)
    - [添加version 4 签名：](#%E6%B7%BB%E5%8A%A0version-4-%E7%AD%BE%E5%90%8D%EF%BC%9A)
      - [身份信息与签名的携带方式：](#%E8%BA%AB%E4%BB%BD%E4%BF%A1%E6%81%AF%E4%B8%8E%E7%AD%BE%E5%90%8D%E7%9A%84%E6%90%BA%E5%B8%A6%E6%96%B9%E5%BC%8F%EF%BC%9A-1)
        - [通过Authorization头：](#%E9%80%9A%E8%BF%87authorization%E5%A4%B4%EF%BC%9A)
        - [通过请求参数：](#%E9%80%9A%E8%BF%87%E8%AF%B7%E6%B1%82%E5%8F%82%E6%95%B0%EF%BC%9A-1)
      - [签名的计算方法：](#%E7%AD%BE%E5%90%8D%E7%9A%84%E8%AE%A1%E7%AE%97%E6%96%B9%E6%B3%95%EF%BC%9A-1)
    - [ACL(Access Control List)](#aclaccess-control-list)
      - [被授权者(Grantee)](#%E8%A2%AB%E6%8E%88%E6%9D%83%E8%80%85grantee)
      - [S2预定义的组(Group)](#s2%E9%A2%84%E5%AE%9A%E4%B9%89%E7%9A%84%E7%BB%84group)
      - [可以指定被授权者的权限(Permissions)](#%E5%8F%AF%E4%BB%A5%E6%8C%87%E5%AE%9A%E8%A2%AB%E6%8E%88%E6%9D%83%E8%80%85%E7%9A%84%E6%9D%83%E9%99%90permissions)
      - [Canned ACL](#canned-acl)
      - [如何指定ACL](#%E5%A6%82%E4%BD%95%E6%8C%87%E5%AE%9Aacl)
        - [x-amz-grant-*请求头类型](#x-amz-grant-%E8%AF%B7%E6%B1%82%E5%A4%B4%E7%B1%BB%E5%9E%8B)
  - [约束与限制](#%E7%BA%A6%E6%9D%9F%E4%B8%8E%E9%99%90%E5%88%B6)
- [Imgx(图片处理服务)使用说明](#imgx%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86%E6%9C%8D%E5%8A%A1%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)
  - [URL格式](#url%E6%A0%BC%E5%BC%8F)
  - [举例](#%E4%B8%BE%E4%BE%8B)
  - [指令格式](#%E6%8C%87%E4%BB%A4%E6%A0%BC%E5%BC%8F)
  - [签名](#%E7%AD%BE%E5%90%8D)
  - [缓存 & CDN](#%E7%BC%93%E5%AD%98-&-cdn)
  - [图片处理指令](#%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86%E6%8C%87%E4%BB%A4)
  - [水印功能详细介绍](#%E6%B0%B4%E5%8D%B0%E5%8A%9F%E8%83%BD%E8%AF%A6%E7%BB%86%E4%BB%8B%E7%BB%8D)
    - [图片水印](#%E5%9B%BE%E7%89%87%E6%B0%B4%E5%8D%B0)
    - [文字水印](#%E6%96%87%E5%AD%97%E6%B0%B4%E5%8D%B0)
  - [使用“指令集”](#%E4%BD%BF%E7%94%A8%E2%80%9C%E6%8C%87%E4%BB%A4%E9%9B%86%E2%80%9D)
  - [字体 (font_family)](#%E5%AD%97%E4%BD%93-font_family)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 概述
-------------------

> 我们提供了一套兼容AmazonS3的RESTful API，可以使您更加自由地开发出灵活的功能。
>
> 白山云存储服务主要提供以下三类API：
>
> * Service操作
> * Bucket操作
> * Object操作
>
> 与此同时，为提高用户使用的安全性，白山云存储服务还通过使用签名来验证请求者的身份。
>
> 如需了解签名算法的详细信息，请参考[《签名算法》](signature/signature.md)。
>
> 注意：以下接口中所使用的示例都是在需要使用签名情况下；如果相关访问资源已设置为可匿名（所有用户）访问，则可不带签名。

[TOC]

##  编程接口相关, 用户使用相关

### 白山云存储和七牛比的优势在哪里? 为什么七牛的API 不如 aws-s3的 API 灵活?  任稚
### 白山云存储提供哪些语言的 SDK 客户端? 哪里可以找到快速上手的例子? 任稚
### 如何删除一个目录? 沈杰
### 是否可以使用白山云存储做整站的备份? xp
### 404回源, 如果存储上文件不存在, 是否可以自动让存储去特定的地方拉取? 书文
### 数据同步, 导入: 如何使用离线下载同步数据，效率，速度如何? 闯
### 多文件上传是否支持? xp
### 超大文件上传是如何实现的, 有什么限制? 书文
### 是否可以让文件允许任何用户下载(匿名下载)?，是否可以对每一个文件授权只让特定的用户下载? 沈杰

---

##  周边服务, 图片, 视频处理等

### 白山存储支持实时图片转换,旋转,缩放,剪切,打水印吗? xp
### 是否可以让存储自动判断user-agent触发特定的图片剪裁输出? 闯
### 视频转码可以做吗? 沈杰

---

##  用户管理存储资源相关, 管理控制台

### 存储用户可以有后台可以看到存储服务的使用量吗? 林飞
### 白山云存储是否提供日志下载? 林飞

---

##  性能, 可靠性, 可用性相关

### 白山云存储是否做了上传(cdn)加速,来提升访问质量?  闯
### 白山云存储是否整合了cdn支持? 沈杰
### https是否支持? 如何使用? 林飞
### 加密存储是否支持? 书文
### 文件可靠性多少，会不会丢文件?服务可用性是多少? xp
### 上传文件后多久可以下载到这个文件? xp

---

##  售前支持, 测试等

### 快速测试的环境？申请流程是什么? 林飞
### 如何申请使用上传加速? 闯
### 如何同时申请存储和 cdn 服务? 沈杰
### 使用白山云存储如何配置和控制 CDN 的缓存时间等策略? 任稚

---

##  与第三方服务整合相关

### 整合文本编辑器的上传图片 闯

---

##  日常使用相关

### 白山云存储是否提供图形界面gui,或web管理界面让用户管理自己的文件? xp

### 如何上传文件? 是否可以通过 ftp 或 rsync 的方式上传? 是否有客户端?

白山云存储遵循业界通用 amazon-s3 API, 是1套 restful 的 API.
社区中有不少成熟的 SDK 和 命令行工具可以直接使用, 接口层完全可以省去开发工作了.
例如流行的:

-   [s3cmd][s3cmd]
-   [boto][boto]

白山云存储不支持 ftp 或 rsync 协议. 因为 amazon s3 对文件权限的控制粒度上更精细.

-   对图形界面的 ftp 替代品可以使用 Mac 下的 [cyberduck][cyberduck]
    或 Windows 下的[s3browser][s3browser].
-   对命令行方式的 ftp 或 rsync 的替代品可以使用 [s3cmd][s3cmd]

---

[s3cmd]:        http://s3tools.org/s3cmd
[boto]:         http://boto.cloudhackers.com/en/latest/
[cyberduck]:    https://cyberduck.io/
[s3browser]:    http://s3browser.com

## 实例（兼容Amazon SDK）
-------------------

## Python Demo

### 安装AWS Python 客户端boto3

```
pip install boto3
```

### 初始化，设置帐号信息和域名

```python

import boto3
from boto3.s3.transfer import TransferConfig

cli = boto3.client(
    's3',
    aws_access_key_id='ziw5dp1alvty9n47qksu', #请替换为您自己的access_key
    aws_secret_access_key='V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV', #请替换为您自己的secret_key
    endpoint_url='http://s2.i.qingcdn.com'
)

```


### 文件操作接口

#### 上传文件

##### 使用put_object接口上传

ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

```python
resp = cli.put_object(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx',
    Body='the content of the file as a string'
)
```

##### 使用upload_file接口上传（适合大文件上传，支持自动分块，多块并行上传）

```python
config = TransferConfig(
    multipart_threshold=30 * 1024 * 1024,
    multipart_chunksize=8 * 1024 * 1024,
    max_concurrency=10
)
resp = cli.upload_file(
    '/root/test.mp4',
    'test-bucket-xxx',
    'test-key-xxx',
    Config=config
)
```

#### 下载文件

```python
resp = cli.get_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 获取文件的URL

获取已签名的URL用来下载文件，可通过参数ExpiresIn设置签名过期时间。

```python
url = cli.generate_presigned_url(
    'get_object',
    Params={
        'Bucket': 'test-bucket-xxx',
        'Key': 'test-key-xxx'
    },
    ExpiresIn=60
)
print url
```

#### 删除文件

```python
resp = cli.delete_object(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 获取文件的ACL

```python
resp = cli.get_object_acl(
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

#### 设置文件的ACL

##### 使用预定义的ACL

支持的预定义ACL有：'private', 'public-read', 'public-read-write'

```python
resp = cli.put_object_acl(
    ACL='public-read',
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```python
resp = cli.put_object_acl(
    AccessControlPolicy={
        'Grants': [
            {
                'Grantee': {
                    'ID': 'user_foo',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'WRITE',
            },
            {
                'Grantee': {
                    'ID': 'your-user-name',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'FULL_CONTROL',
            },
        ],
        'Owner': {
            'ID': 'your-user-name',
        },
    },
    Bucket='test-bucket-xxx',
    Key='test-key-xxx'
)
```


### 桶操作接口

#### 创建桶

ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

```python
resp = cli.create_bucket(
    ACL='public-read',
    Bucket='test-bucket-xxx'
)
```

#### 列出桶中所包含的文件

```python
resp = cli.list_objects(
    Bucket='test-bucket-xxx'
)
```

#### 删除桶

```python
resp = cli.delete_bucket(
    Bucket='test-bucket-xxx'
)
```

#### 获取桶的ACL

```python
resp = cli.get_bucket_acl(
    Bucket='test-bucket-xxx'
)
```

#### 设置桶的ACL

##### 使用自定义的ACL

可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

```python
resp = cli.put_bucket_acl(
    AccessControlPolicy={
        'Grants': [
            {
                'Grantee': {
                    'ID': 'user_foo',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'WRITE',
            },
            {
                'Grantee': {
                    'ID': 'your-user-name',
                    'Type': 'CanonicalUser',
                },
                'Permission': 'FULL_CONTROL',
            },
        ],
        'Owner': {
            'ID': 'your-user-name',
        },
    },
    Bucket='test-bucket-xxx'
)
```


### 服务操作接口

#### 列出所有的桶

```python
resp = cli.list_buckets()
```

AWS 官方 SDK [aws-sdk-python](https://github.com/boto/boto3)

## PHP Demo
```php

目录：

初始化，设置帐号信息和域名

一，文件操作接口：
    1，上传文件：
    2，下载文件：
    3，获取文件的URL：
    4，删除文件：
    5，获取文件的ACL：
    6，设置文件的ACL：
        6.1， 使用预定义的ACL：
        6.2， 使用自定义的ACL：

二，桶操作接口：
    1，创建桶：
    2，列出桶中所包含的文件：
    3，删除桶：
    4，获取桶的ACL：
    5，设置桶的ACL：
        5.1，使用自定义的ACL：

三，服务操作接口：
    1，列出所有的桶：



初始化，设置帐号信息和域名

require 'aws.phar';
$cli = new Aws\S3\S3Client([
    'version' => 'latest',
    'region' => 'us-east-1',
    'credentials' => [
        'key' => 'z2qutjf718d0i9gw6skc',  //请替换为您自己的access_key
        'secret' => 'SEQgcc1ppH7uXPG4ZPIcrCv2cWz8grcReMfFABCn', //请替换为您自己的secret_key
    ],
    'endpoint' => 'http://s2.i.qingcdn.com',
]);


一，文件操作接口：

    1，上传文件：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        $resp = $cli->putObject([
            'ACL' => 'public-read',
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
            'Body' => 'file content as a string'
        ]);

    2，下载文件：

        $resp = $cli->getObject([
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
        ]);

    3，获取文件的URL：
        获取已签名的URL用来下载文件，可设置签名过期时间。

        $cmd = $cli->getCommand('GetObject', [
            'Bucket' => 'test-bucket-xxx',
            'Key' => 'test-key-xxx',
        ]);
        $req = $s3->createPresignedRequest($cmd, '+10 seconds');
        $url = (string) $req->getUri();

    4，删除文件：

        $resp = $cli->deleteObject([
            'Bucket' => 'test-bucket-xxx',
            'key' => 'test-key-xxx',
        ]);

    5，获取文件的ACL：

        $resp = $cli->getObjectAcl([
            'Bucket' => 'test-bucket-xxx',
            'key' => 'test-key-xxx',
        ]);

    6，设置文件的ACL：

        6.1， 使用预定义的ACL：
            支持的预定义ACL有：'private', 'public-read', 'public-read-write'

            $resp = $cli->putObjectAcl([
                'ACL' => 'public-read-write',
                'Bucket' => 'test-bucket-xxx',
                'Key' => 'test-key-xxx',
            ]);

        6.2， 使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            $resp = $cli->putObjectAcl([
                'AccessControlPolicy' => [
                    'Grants' => [
                        [
                            'Grantee' => [
                                'ID' => 'user_foo',
                                'Type' => 'CanonicalUser',
                            ],
                            'Permission' => 'WRITE',
                        ],
                        [
                            'Grantee' => [
                                'ID' => 'your-user-name',
                                'Type' => 'CanonicalUser',
                            ],
                            'Permission' => 'FULL_CONTROL',
                        ],

                    ],
                    'Owner' => [
                        'ID' => 'your-user-name',
                    ],
                ],
                'Bucket' => 'test-bucket-xxx',
                'Key' => 'test-key-xxx',
            ]);


二，桶操作接口：

    1，创建桶：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        $resp = $cli->createBucket([
            'Bucket' => 'test-bucket-xxx',
            'ACL' => 'public-read',
        ]);

    2，列出桶中所包含的文件：

        $resp = $cli->listObjects([
            'Bucket' => 'test-bucket-xxx',
        ]);

    3，删除桶：

        $resp = $cli->deleteBucket([
            'Bucket' => 'test-bucket-xxx',
        ]);

    4，获取桶的ACL：

        $resp = $cli->getBucketAcl([
            'Bucket' => 'test-bucket-xxx',
        ]);

    5，设置桶的ACL：
        5.1，使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            $resp = $cli->putBucketAcl([
                'AccessControlPolicy' => [
                    'Grants' => [
                        [
                            'Grantee' => [
                                'ID' => 'user_foo',
                                'Type' => 'CanonicalUser',
                            ],
                            'Permission' => 'WRITE',
                        ],
                        [
                            'Grantee' => [
                                'ID' => 'your-user-name',
                                'Type' => 'CanonicalUser',
                            ],
                            'Permission' => 'FULL_CONTROL',
                        ],

                    ],
                    'Owner' => [
                        'ID' => 'your-user-name',
                    ],
                ],
                'Bucket' => 'test-bucket-xxx',
            ]);


三，服务操作接口：

    1，列出所有的桶：

        $resp = $cli->listBuckets([
        ]);
```

## JavaScript  Demo
```html

<html>
<!--将输入文本框中的数据作为文件上传，列出已经上传的文件，下载文件的示例-->
<!--不建议将帐号信息放到浏览器端代码中-->
<textarea id="data"></textarea>
<button id="upload-button">Upload to S3</button>
<div id="results"></div>
<script src='https://sdk.amazonaws.com/js/aws-sdk-2.5.0.min.js'></script>
<script type="text/javascript">
    AWS.config.update({
        accessKeyId: 'ziw5dp1alvty9n47qksu',
        secretAccessKey: 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'
    });
    AWS.config.region = 'us-west-1';
    AWS.config.endpoint = 'http://101.200.190.134';
    AWS.config.s3ForcePathStyle = true

    var s3 = new AWS.S3({
        params: {
            Bucket: 'test-bucket'
        }
    });

    var textarea = document.getElementById('data');
    var button = document.getElementById('upload-button');
    var results = document.getElementById('results');

    button.addEventListener('click', function() {
        results.innerHTML = '';

        var params = {
            Key: 'data.txt',
            Body: textarea.value
        };
        s3.upload(params, function(err, data) {
            results.innerHTML = err ? 'ERROR!' : 'SAVED.';

            s3.listObjects({
                Bucket: 'test-bucket'
            }, function(err, data) {
                if (err) {
                    console.log(err);
                } else {
                    console.log(data);
                }

            });
            s3.getObject({
                Bucket: 'test-bucket',
                Key: 'data.txt'
            }, function(err, data) {
                if (err) {
                    console.log(err);
                } else {
                    console.log(data);
                }
            });

        });

    }, false);
</script>
</html>



<html>
<!--上传用户本地文件，并生成文件的URL的示例-->
<!--不建议将帐号信息放到浏览器端代码中-->
<input type="file" id="file-chooser" />
<button id="upload-button">Upload to S3</button>
<div id="results"></div>
<div id="signed_url"></div>

<script src='https://sdk.amazonaws.com/js/aws-sdk-2.5.0.min.js'></script>
<script type="text/javascript">

  AWS.config.update({accessKeyId: 'ziw5dp1alvty9n47qksu', secretAccessKey: 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'});
  AWS.config.region = 'us-west-1';
  AWS.config.endpoint = 'http://101.200.190.134';
  AWS.config.s3ForcePathStyle = true

  var s3 = new AWS.S3({params: {Bucket: 'test-bucket'}});

  var fileChooser = document.getElementById('file-chooser');
  var button = document.getElementById('upload-button');
  var results = document.getElementById('results');
  var signed_url = document.getElementById('signed_url')

  button.addEventListener('click', function() {
    var file = fileChooser.files[0];
    if (file) {
      results.innerHTML = '';
      signed_url.innerHTML = '';

      var params = {Key: file.name, ContentType: file.type, Body: file};
      s3.upload(params, function (err, data) {
        var params_get = { Bucket: 'test-bucket', Key: file.name, Expires: 60 };
        var url = s3.getSignedUrl('getObject', params_get, function(err, url) {
            signed_url.innerHTML = err ? 'ERROR!' : 'retrive the file use this signed url: ' + url;
            });
        results.innerHTML = err ? 'ERROR!' : 'UPLOADED.';
      });
    } else {
      results.innerHTML = 'Nothing to upload.';
    }
  }, false);
</script>
</html>
```

## Node.js Demo
```Node.js

目录：

初始化，设置帐号信息和域名

一，文件操作接口：
    1，上传文件：
        1.1，使用putObject接口上传：
        1.2，使用upload接口上传（适合大文件上传，支持自动分块，多块并行上传）：
    2，下载文件：
    3，获取文件的URL：
    4，删除文件：
    5，获取文件的ACL：
    6，设置文件的ACL：
        6.1， 使用预定义的ACL：
        6.2， 使用自定义的ACL：

二，桶操作接口：
    1，创建桶：
    2，列出桶中所包含的文件：
    3，删除桶：
    4，获取桶的ACL：
    5，设置桶的ACL：
        5.1，使用自定义的ACL：

三，服务操作接口：
    1，列出所有的桶：



初始化，设置帐号信息和域名

var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.accessKeyId = 'ziw5dp1alvty9n47qksu'; //请替换为您自己的access_key
AWS.config.secretAccessKey = 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'; //请替换为您自己的secret_key
AWS.config.region = 'us-west-1';
AWS.config.endpoint = 'http://s2.i.qingcdn.com';
AWS.config.s3ForcePathStyle = true

var s3 = new AWS.S3();


一，文件操作接口：

    1，上传文件：

        1.1，使用putObject接口上传：
            ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                ACL: 'public-read',
                Body: new Buffer('blablabla')
            };
            s3.putObject(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

        1.2，使用upload接口上传（适合大文件上传，支持自动分块，多块并行上传）：

            var file_stream = fs.createReadStream('/root/test.mp4')
            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                Body: file_stream,
                ACL: 'public-read'
            }
            var options = {partSize: 10 * 1024 * 1024, queueSize: 10}
            s3.upload(params, options, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

    2，下载文件：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.getObject(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    3，获取文件的URL：
        获取已签名的URL用来下载文件，可通过参数Expires设置签名过期时间。

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx',
            Expires: 60
        };
        var url = s3.getSignedUrl('getObject', params);
        console.log('The URL is', url);

    4，删除文件：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.deleteObject(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    5，获取文件的ACL：

        var params = {
            Bucket: 'test-bucket-xxx',
            Key: 'test-key-xxx'
        };
        s3.getObjectAcl(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    6，设置文件的ACL：

        6.1， 使用预定义的ACL：
            支持的预定义ACL有：'private', 'public-read', 'public-read-write'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                ACL: 'public-read'
            };
            s3.putObjectAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });

        6.2， 使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            var params = {
                Bucket: 'test-bucket-xxx',
                Key: 'test-key-xxx',
                AccessControlPolicy: {
                    Grants: [
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'user-foo'
                            },
                            Permission: 'WRITE'
                        },
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'your-user-name'
                            },
                            Permission: 'FULL_CONTROL'
                        },
                    ],
                    Owner: {
                        ID: 'your-user-name'
                    }
                }
            };
            s3.putObjectAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });


二，桶操作接口：

    1，创建桶：
        ACL可设置为：'private' 或 'public-read' 或 'public-read-write'

        var params = {
            Bucket: 'test-bucket-xxx',
            ACL: 'public-read'
        };
        s3.createBucket(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    2，列出桶中所包含的文件：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.listObjects(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    3，删除桶：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.deleteBucket(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    4，获取桶的ACL：

        var params = {
            Bucket: 'test-bucket-xxx',
        };
        s3.getBucketAcl(params, function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });

    5，设置桶的ACL：
        5.1，使用自定义的ACL：
            可指定的Permission包括：'FULL_CONTROL', 'WRITE', 'WRITE_ACP', 'READ', 'READ_ACP'

            var params = {
                Bucket: 'test-bucket-xxx',
                AccessControlPolicy: {
                    Grants: [
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'user-foo'
                            },
                            Permission: 'WRITE'
                        },
                        {
                            Grantee: {
                                Type: 'CanonicalUser',
                                ID: 'your-user-name'
                            },
                            Permission: 'FULL_CONTROL'
                        },
                    ],
                    Owner: {
                        ID: 'your-user-name'
                    }
                }
            };
            s3.putBucketAcl(params, function(err, data) {
                if (err) console.log(err, err.stack);
                else console.log(data);
            });


三，服务操作接口：

    1，列出所有的桶：

        s3.listBuckets(function(err, data) {
            if (err) console.log(err, err.stack);
            else console.log(data);
        });
```

## API
-------------------

## Bucket操作
-------------------


## Service操作

### GET Service (List Buckets)

 - 描述：获得当前Owner下所有Bucket的列表。

 - 请求格式：

```http
GET /?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应格式（HTTP Body）：

```json
{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000001234567890"
    },

    "Buckets": {
        "Bucket": [
            {
                "CreationDate": "Fri, 21 Mar 2014 01:13:42 UTC",
                "Name": "bucket_name_0"
            },
            {
                "CreationDate": "Fri, 12 Mar 2013 02:25:22 UTC",
                "Name": "bucket_name_1"
            },

            ...
        ]
    }
}
```

 - 返回值说明：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>Owner</td>
            <td>所有者</td>
          </tr>

          <tr>
            <td>DisplayName</td>
            <td>所有者的显示名字</td>
          </tr>

          <tr>
            <td>ID</td>
            <td>所有者的UserId</td>
          </tr>

          <tr>
            <td>Buckets</td>
            <td>多个Buckets的容器</td>
          </tr>

          <tr>
            <td>Bucket</td>
            <td>Bucket信息的容器</td>
          </tr>

          <tr>
            <td>CreationDate</td>
            <td>当前Bucket创建时间</td>
          </tr>

          <tr>
            <td>Name</td>
            <td>Bucket名称</td>
          </tr>

        </tbody>
</table>

 - 请求示例：

``` 
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://s2.i.qingcdn.com/?formatter=json"
```

或者

```    
curl -v "http://s2.i.qingcdn.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

 - 响应示例：

```http
HTTP/1.1 200 OK
Server: openresty/1.9.7.4
Date: Mon, 08 Aug 2016 04:04:52 GMT
Content-Type: application/json
Connection: keep-alive
Content-Length: 155
x-amz-s2-requester: your user id
x-amz-request-id: 000011e5-1608-0812-0452-00163e0069ec

{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000001234567890"
    },
    "Buckets": {
        "Bucket": [
            {
                "CreationDate": "Mon, 08 Aug 2016 03:15:40 UTC",
                "Name": "bucket_name_0"
            },
            {
                "CreationDate": "Mon, 08 Aug 2016 03:15:40 UTC",
                "Name": "bucket_name_1"
            },

         ...
        ]
    }
}
```


### GET Bucket (List Objects)

 - 描述：获取bucket下所有object。

 - 请求格式：

```http
GET /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 请求参数：

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
            <td>delimiter</td>
            <td>折叠显示字符。通常使用：‘/’</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>marker</td>
            <td>Key的初始位置，系统将列出比Key大的值，通常用作‘分页’的场景</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>max-keys</td>
            <td>返回值的最大Key的数量。默认为400</td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>prefix</td>
            <td>列出以指定字符为开头的Key</td>
            <td>No</td>
          </tr>
          
       
        </tbody>
    </table>

响应格式举例（HTTP Body）：

```json
{

    Delimiter: "/",
    
    Prefix: "html/",
    
    CommonPrefixes: [
    
        {
            Prefix: "html/assets/"
        },
    
        {
            Prefix: "html/attributions/"
        },
    
        {
            Prefix: "html/documentation/"
        },
    
        ...
    ],
    
    Marker: null,
    
    ContentsQuantity: 5,
    
    CommonPrefixesQuantity: 3,
    
    NextMarker: null,
    
    IsTruncated: false,
    
    Contents: [
    
        {
            SHA1: "9fc710aa89efbe42020b0310d16a07449bf06131",
            Name: "html/coming-soon.html",
            Expiration-Time: null,
            Last-Modified: "Fri, 21 Mar 2014 01:50:46 UTC",
            Owner: "Baishan0000000000000001",
            MD5: "934d922cac80449ee361cefeb3276b3e",
            Content-Type: "text/html",
            Size: 8781
        },
    
        {
            SHA1: "a9625a128263f05e331f6d78add9bd15911c3565",
            Name: "html/ebook.html",
            Expiration-Time: null,
            Last-Modified: "Fri, 21 Mar 2014 01:50:47 UTC",
            Owner: "Baishan0000000000000001",
            MD5: "cb7ed943ead4aeb513aa8c0b76865a8b",
            Content-Type: "text/html",
            Size: 18734
        },
        
        ...
    ]
}
```

 - 返回值说明：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Contents</td>
            <td>Object的Metadata数组</td>
          </tr>
          
          <tr>
            <td>CommonPrefixes</td>
            <td>折叠以后的Prefix，下一级是Prefix数组</td>
          </tr>
          
          <tr>
            <td>Delimiter</td>
            <td>当前使用的折叠字符</td>
          </tr>
          
          <tr>
            <td>Prefix</td>
            <td>当前使用的前缀</td>
          </tr>
          
          <tr>
            <td>Marker</td>
            <td>当前使用的Marker</td>
          </tr>
          
          <tr>
            <td>ContentsQuantity</td>
            <td>Contents中元素个数</td>
          </tr>
          
          <tr>
            <td>CommonPrefixesQuantity</td>
            <td>CommonPrefixes中元素个数</td>
          </tr>
          
          <tr>
            <td>NextMarker</td>
            <td>下一页的Marker</td>
          </tr>
          
          <tr>
            <td>IsTruncated</td>
            <td>是否还有下一页</td>
          </tr>
          
          <tr>
            <td>SHA1</td>
            <td>文件内容的sha1值</td>
          </tr>
          
          <tr>
            <td>Name</td>
            <td>Object的Key(文件名)</td>
          </tr>
                    
          <tr>
            <td>Last-Modified</td>
            <td>Object的最后修改时间</td>
          </tr>
          
          <tr>
            <td>Owner</td>
            <td>Object的拥有者</td>
          </tr>
          
          <tr>
            <td>MD5</td>
            <td>文件内容的md5值</td>
          </tr>
          
          <tr>
            <td>Content-Type</td>
            <td>文件的mime type</td>
          </tr>
          
          <tr>
            <td>Size</td>
            <td>文件的大小(字节)</td>
          </tr>
          
        </tbody>
    </table>

 - 应用举例：
假设某Bucket下有如下文件(为方便说明，没有显示为json格式，仅表现其中的一些有用信息，以下同)：

```
join/mailaddresss.txt
join/mycodelist.txt
join/personalfiles/connects.docx
join/personalfiles/myphoto.jpg
join/readme.txt
join/userlist.txt
join/zero.txt
mary/personalfiles/mary.jpg
mary/readme.txt
sai/readme.txt
```

使用prefix指定以join/为开头的文件：

```http
GET /?prefix=join/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/personalfiles/connects.docx
    join/personalfiles/myphoto.jpg
    join/readme.txt
    join/userlist.txt
    join/zero.txt
```

使用delimiter指定折叠方式为‘/’：

```http
GET /?delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
Contents:

CommonPrefix:
    join
    mary
    sai
```

使用prefix指定以join/为开头的文件，同时使用delimiter指定折叠方式为‘/’：

```http
GET /?prefix=join/&delimiter=/&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/readme.txt
    join/userlist.txt
    join/zero.txt
CommonPrefix:
    join/personalfiles/
```

使用max-keys做最大值列表长度限制：

```http
GET /?prefix=join/&delimiter=/&max-keys=4&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
IsTruncated : true
Next-Marker : join/userlist.txt
Contents:
    join/mailaddresss.txt
    join/mycodelist.txt
    join/readme.txt
CommonPrefix:
    join/personalfiles/
```

使用marker继续获得之前的列操作的后续结果：

```http
GET /?prefix=join/&delimiter=/&max-keys=4&marker=join/userlist.txt&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

返回：

```
IsTruncated : false
Contents:
    join/userlist.txt
    join/zero.txt
```

### PUT Bucket

 - 描述：创建一个Bucket。

 - 请求格式：

```http
PUT /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
x-amz-acl: <Canned-ACL> #请参照[《ACL》](../acl/acl.md)
```

或者

```http
PUT /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
x-amz-acl: <Canned-ACL> #请参照[《ACL》](../acl/acl.md)
```

 - Request Header（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>x-amz-acl</td>
            <td>创建Bucket的同时，设置一个ACL。请参照《ACL》
            <td>No</td>
          </tr>
                    
        </tbody>
    </table>

 - 响应（无HTTP Body）：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

 - 请求示例：

```
curl -v -X PUT -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?formatter=json"
```

或者

```
curl -v -X PUT "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v -X PUT "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

### DELETE Bucket

 - 描述：删除指定Bucket。

 - 注意：不能删除非空Bucket。

 - 请求格式：

```http
DELETE /?formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
DELETE /<Your-Bucket-Name>/?formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应（无HTTP Body）：

```http
HTTP/1.1 204 No Content
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
```

 - 请求示例：

```
curl -v -X DELETE -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?formatter=json"
```

或者

```
curl -v -X DELETE "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v -X DELETE "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

### PUT Bucket ACL

 - 描述：给指定Bucket设置ACL规则。更多信息请参照：[《ACL》](../acl/acl.md)

 - 请求格式：

```http
PUT /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》

#ACL规则
{
	'Baishan0000000000000001' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS000000ANONYMOUSE' :  [ "read", "read_acp" , "write", "write_acp" ],
	'GRPS0000000CANONICAL' :  [ "read", "read_acp" , "write", "write_acp" ],
}

```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId
{
    "Owner": {
        "DisplayName": "",
        "ID": "user_authed"
    },
    "AccessControlList": {
        "Grant": [
            {
                "Grantee": {
                    "DisplayName": "",
                     "ID": "Baishan0000000000000001"
                },
                "Permission": "READ,READ_ACP,WRITE,WRITE_ACP"
            },

            ...
        ]
    }
}
```

 - 请求格式说明请参照：[《ACL》](../acl/acl.md)
 - 请求示例：

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&formatter=json"
```

### GET Bucket ACL

 - 描述：获得指定Bucket的ACL信息。更多信息请参照：[《ACL》]((../acl/acl.md))

 - 请求格式：

```http
GET /?acl&formatter=json HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

或者

```http
GET /<Your-Bucket-Name>/?acl&formatter=json HTTP/1.1
Host: s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 123
Connection: keep-alive
X-RequestId: 00078d50-1404-0810-5947-782bcb10b128
X-Requester: Your UserId

{
    "Owner": {
        "DisplayName": "",
        "ID": "Baishan0000000000000001"
    },

    "AccessControlList": {
        "Grant": [
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "GRPS000000ANONYMOUSE"
                },
                "Permission": "READ"
            },
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "Baishan0000001001NHT3M7"
                },
                "Permission": "READ, READ_ACP, WRITE, WRITE_ACP"
            },
            {
                "Grantee": {
                    "DisplayName": "",
                    "ID": "Baishan0000000000000001"
                },
                "Permission": "READ, WRITE"
            },

            ...
        ]
    }
}

```

 - 响应格式说明请参照：[《ACL》]((../acl/acl.md))

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: Baishan <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&formatter=json"
```

或者

```
curl -v "http://<Your-Bucket-Name>.s2.i.qingcdn.com/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

或者

```
curl -v "http://s2.i.qingcdn.com/<Your-Bucket-Name>/?acl&KID=baishan,<access_key>&Expires=1398873316&ssig=<ssig>&formatter=json"
```

## Object操作
-------------------



### HEAD Object

 - 描述：使用HEAD请求方式获取Object的Metadata。

 - 请求格式：

```http
HEAD /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```
 - 响应（无HTTP Body）：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
Content-Type: <object-mime-type>
Content-Length: <object-file-bytes>
ETag: "<文件的MD5值>"
Last-Modified: <最后修改时间>
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-foo1: <value1> #自定义meta：foo1
x-amz-meta-foo2: <value2> #自定义meta：foo2
```

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Range</td>
            <td>
            	Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Modified-Since</td>
            <td>
            	Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Unmodified-Since</td>
            <td>
            	Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is the same as the one specified; otherwise, return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>If-None-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is different from the one specified; otherwise, return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr> 
                    
        </tbody>
    </table>

 - Response Headers（响应头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Content-Type</td>
            <td>Object的mime-type</td>
		  </tr>
		  <tr>
            <td>Content-Length</td>
            <td>Object的Size(bytes)</td>
		  </tr>
		  <tr>
            <td>ETag</td>
            <td>Object的hash值，一般是md5值</td>
		  </tr>
		  <tr>
            <td>Last-Modified</td>
            <td>Object的最后修改时间</td>
		  </tr>
		  <tr>
            <td>x-amz-meta-*</td>
            <td>用户可自定义文件属性信息，读取时原值返回。<br>
            例如：<br>
            x-amz-meta-UploadLocation: My Home<br>
            X-amz-meta-ReviewedBy: test@test.net<br>
            X-amz-meta-FileChecksum: 0x02661779<br>
            X-amz-meta-CheckSumAlgorithm: crc32<br>
            </td>
		  </tr>
		  <tr>
            <td>x-amz-meta-crc32</td>
            <td>Object的CRC32值</td>
		  </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X HEAD -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/<Object-Name>"
```

### GET Object

 - 描述：获取一个Object（下载）。
 
 - 请求格式：
 
```http
GET /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
Range: bytes=<byte_range> #支持断点下载
```

 - 响应：
 
```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
Content-Type: <object-mime-type>
Content-Length: <object-file-bytes>
ETag: "<文件的MD5值>"
Last-Modified: <最后修改时间>
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
x-amz-meta-foo1: <value1> #自定义meta：foo1
x-amz-meta-foo2: <value2> #自定义meta：foo2

#文件内容
<BODY>
```

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Range</td>
            <td>
            	Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Modified-Since</td>
            <td>
            	Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Unmodified-Since</td>
            <td>
            	Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>If-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is the same as the one specified; otherwise, return a 412 (precondition failed).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>If-None-Match</td>
            <td>
            	Return the object only if its entity tag (ETag) is different from the one specified; otherwise, return a 304 (not modified).<br>
            	• Type: String<br>
				• Default: None<br>
				• Constraints: None
            </td>
            <td>No</td>
          </tr> 
                    
        </tbody>
</table>

 - Response Headers（响应头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Content-Type</td>
            <td>Object的mime-type</td>
		  </tr>
		  <tr>
            <td>Content-Length</td>
            <td>Object的Size(bytes)</td>
		  </tr>
		  <tr>
            <td>ETag</td>
            <td>Object的hash值，一般是md5值</td>
		  </tr>
		  <tr>
            <td>Last-Modified</td>
            <td>Object的最后修改时间</td>
		  </tr>
		  <tr>
            <td>x-amz-meta-*</td>
            <td>用户可自定义文件属性信息，读取时原值返回。<br>
            例如：<br>
            x-amz-meta-UploadLocation: My Home<br>
            X-amz-meta-ReviewedBy: test@test.net<br>
            X-amz-meta-FileChecksum: 0x02661779<br>
            X-amz-meta-CheckSumAlgorithm: crc32<br>
            </td>
		  </tr>
		  <tr>
            <td>x-amz-meta-crc32</td>
            <td>Object的CRC32值</td>
		  </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -H "Range: bytes=0-1024" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/<Object-Name>"
```

 - 应用举例：
 
	- 标准示例：
  
```http
GET /my_bucket/path/to/my/file.txt HTTP/1.1
Host: s2.i.qingcdn.com
Date: Sun, 1 Jan 2006 12:00:00 GMT
Authorization: AWS AccessKey:ssig
Range: bytes=100-2048
```

	-	响应：
  
```http
HTTP/1.1 206 Partial Content
Server: openresty/1.9.7.4
Content-Type: application/xml
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: GRPS000000ANONYMOUSE
Date: Mon, 08 Aug 2016 02:46:21 GMT
Last-Modified: Mon, 08 Aug 2016 02:45:55 GMT
ETag: "21b1a992d1cbf49729fc4461e55dd94f"
x-amz-meta-s2-size: 109051904
x-amz-meta-s2-crc32: 9422bc32
Cache-Control: max-age=31536000
Content-Length: 109051904

...
file_content
...

```

* 使用各种验证措施的下载方式：

```http
GET /path/to/my/file.txt?AWSAccessKeyId=<AccessKey>&Expires=<1175139620>&Signature=<your_sign> HTTP/1.1
Host: my_bucket.s2.i.qingcdn.com
Date: date
Range: bytes=byte_range
```

  * 响应：

```http
HTTP/1.1 206 Partial Content
Server: openresty/1.9.7.4
Content-Type: application/xml
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: GRPS000000ANONYMOUSE
Date: Mon, 08 Aug 2016 02:46:21 GMT
Last-Modified: Mon, 08 Aug 2016 02:45:55 GMT
ETag: "21b1a992d1cbf49729fc4461e55dd94f"
x-amz-meta-s2-size: 109051904
x-amz-meta-s2-crc32: 9422bc32
Cache-Control: max-age=31536000
Content-Length: 109051904

...
file_content
...

```

***以上示例中QueryString的含义请参照[《签名算法》][1]中的关于 认证方式 的说明。***

### PUT Object

 - 描述：PUT方式上传一个文件（同时可以设置meta和acl）。

 - 请求格式： 

```http
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Content-Length: <object data length>
Content-Type: <mime-type>
Authorization: <authorization string> #请参照《签名算法》

[object data]
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
```

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Expires</td>
            <td>
            	文件过期时间，到期系统将自动清除文件（非即时，清除时间不定期），格式参考：http://www.w3.org/Protocols/rfc2616/
                rfc2616-sec14.html#sec14.21.
            </td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>Cache-Control</td>
            <td>
            	文件Cache，标准HTTP协议，更多内容参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>
            
          <tr>
            <td>Content-Type</td>
            <td>
            	文件mime type，读取时原值返回
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Length</td>
            <td>
            	文件大小，读取时原值返回
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>Content-MD5</td>
            <td>
            	base64编码的文件MD5（与传送内容不符时失败），注意：字符串格式为rfc标准使用base64编码的值
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Disposition</td>
            <td>
            	HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Encoding</td>
            <td>
            	文件编码，HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>x-amz-acl</td>
            <td>
            	文件ACL：创建文件的同时，设置一个ACL。请参照《ACL》
            </td>
            <td>No</td>
          </tr>
            
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	用户自定义MetaDeta, header以x-amz-meta-开头, 所有meta以key:value的形式存储,最大限制64KB,
                HEAD或者GET时原样返回
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>

 - 请求示例：

```
curl -v -T "myfile.txt" -H "x-amz-meta-UploadLocation: My Home" -H "Date: Sat,20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/myfile.txt"
```

### POST Object

 - 描述：POST方式上传一个文件（基于浏览器表单的上传方式）。

 - 请求格式：

```http
POST / HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Content-Length: <length>

Content-Type:multipart/form-data; boundary=----WebKitFormBoundary1dIjDASRYXQm6DNA

------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="key"

destinationProject/${filename}
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="success_action_redirect"

http://123.abc.com/1.php?f=1111.txt
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="AWSAccessKeyId"

100M414ZO0X30
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="Policy"

eyJleHBpcmF0aW9uIjoiMjAxMi0wNi0wNlQwNjozOTo0MS4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoiczN4cC5zM3dhdGNoIn0sWyJzdGFydHMtd2l0aCIsIiRrZXkiLCJhbmdlbFwvIl1dfQ==
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="Signature"

VK6Kw4kRqW2e84ZIX2cV2QqHo58=
------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="file"; filename="112233.txt"
Content-Type: text/plain

------WebKitFormBoundary1dIjDASRYXQm6DNA
Content-Disposition: form-data; name="submit"

上传
------WebKitFormBoundary1dIjDASRYXQm6DNA-
```

 - 表单元素：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td width="185px">AWSAccessKeyId</td>
            <td>
            	就是AccessKey，可以到控制台获取
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>key</td>
            <td>
            	object上传后的key（路径），例如：angel/${filename}，变量
                ${filename}将被自动替换成被上传文件的文件名；当然也可以直接指定被上传文件存储在存储中的文件名。如：angel/path/to/myfile.txt, <br/>变量名可以为: filename, sha1, md5, size
            </td>
            <td>Yes</td>
          </tr>    
            
          <tr>
            <td>acl</td>
            <td>
            	文件的ACL：创建文件的同时，设置一个ACL。请参照《ACL》
            </a></td>
            <td>No</td>
          </tr>    
            
          <tr>
            <td>success_action_status</td>
            <td>
            	上传成功后的响应码，可以设置的值为:200, 201, or 204(defalut),
                若设置为200或者204, 则返回body为空, status为200或者204,
                若设置为201, 则返回xml格式的body, stats为201, 如果设置为非法的值, 则忽略该值,使用默认值204<br/>
                 <b>注</b>: 如果设置success_action_redirect或者redirect, 则忽略该设置
            </td>
            <td>No</td>
          </tr>  
            
          <tr>
            <td>success_action_redirect, redirect</td>
            <td>
            	上传成功后客户端重定向的URL,实际返回的location会在原来的URL加上bucket, key和etag querystring
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Policy</td>
            <td>
            	文件的策略，json格式字符串，并使用base64进行编码。后面详细介绍
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>Signature</td>
            <td>
            	使用SecretKey签名后的字符串。后面详细介绍
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>file</td>
            <td>
            	type=file的input表单
            </td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	用户自定义MetaDeta, header以x-amz-meta-开头, 所有meta以key:value的形式存储,最大限制64KB,
                HEAD或者GET时原样返回
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Cache-Control, Content-Type, Content-Disposition,Content-Encoding,Expires</td>
            <td>
            	和put_file一样, 参考put_file接口
            </td>
            <td>No</td>
          </tr>
                    
        </tbody>
</table>

#### Policy的构建：
 策略是使用 UTF-8 和 Base64 编码的 JSON
 文档，它指定了请求必须满足的条件并且用于对内容进行身份验证。根据您设计策略文档的方式，您可以对每次上传、每个用户、所有上传或根据其他能够满足您需要的设计来使用它们。

```json
{
    "expiration": "2014-04-10T08:55:34.000Z",

    "conditions": [

        {
            "bucket": "my-bucket-name"
        },

        {
            "acl": "private"
        },

        [
            "starts-with", "$key", "my_prefix/"
        ],

        [
            "content-length-range", 0, 52428800
        ]
    ]
}
```

 - 以上示例的说明：

  - 上传必须在”2014-04-10T08:55:34.000Z”之前。
  - 文件上传到名为”my-bucket-name”的bucket。
  - starts-with：$key必须以”my_prefix/”开始 (Policy中”$key”前必须带”$”)。若$key值为空，文件名前无前缀。
  - content-length-range：文件大小必须在指定范围内。
  - 最终将policy进行base64编码设置到表单Policy的value中。

  
##### expiration:
  expiration用于指定policy的过期时间, 采用ISO 8601 UTC日期格式来指定策略的过期日期。例如，“2007-12-01T12:00:00.000Z”指定, 在策略中过期是必需的。
 
##### Condition:
Condition用于验证上传的对象的内容与表单冲填写的域
###### Condition 类型
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Condition</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td width="185px">精确匹配</td>
            <td>
            	1. 精确匹配将验证字段是否匹配特定的值。此示例指示ACL 必须设置为公共读取：{"acl": "public-read" } <br/>
            	2.ACL 必须设置为公共读取的替代方法: [ "eq", "$acl", "public-read" ]
            </td>
          </tr>    
            
          <tr>
            <td>Starts With</td>
            <td>
            如果值必须从某个特定的值开始，请使用starts-with。本示例指示密钥必须从user/betty开始：["starts-with", "$key", "user/betty/"]
            	
            </td>
          </tr>  
          <tr>
            <td>指定范围</td>
            <td>
            对于接受范围的字段，请使用逗号来分隔上限和下限值。本示例允许1 到10 MB 的文件大小：["content-length-range", 1048579, 10485760], 单位字节
            	
            </td>
          </tr>                        
        </tbody>
</table>

###### Conditions 字段
策略文档中的条件验证上传的对象的内容。您在表单中指定的每个表单字段（AWSAccessKeyId、Signature、file、Policy除外）都可以作为条件

#### Signature的构建：
  - 用UTF-8对policy进行编码
  - 用Base64对UTF-8形式的policy进行编码
  - 用HMAC SHA-1和你的Secret Key将你的policy进行转换。最后进行base64编码。如：使用php时，base64_encode( hash_hmac( "sha1", $policy, $SECRETKEY, true ) );
  - 将最终的值设置到表单Signature的value中。
 - 最终生成的html表单：

```html
<form method="post" action="http://my-bucket.<?=c('api_host');?>/" enctype="multipart/form-data">
    <input type="hidden" name="AWSAccessKeyId" value="您的accesskey" />
    <input type="hidden" name="key" value="my_prefix/${filename}" />
    <input type="hidden" name="acl" value="private" />
    <input type="hidden" name="success_action_status" value="201" />
    <input type="hidden" name="Policy" value="eyJleHBpcmF0aW9uIjoiMjAxNC0wNC0xMFQwOToxNzozMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoiY2xvdWQxMjMqwqwsdifsdGFydHMtd2l0aCIsIiRrZXkiLCJteWZpbGVzLyJdLFsic3RhcnRzLXdpdGgiLCIkQ29udGVudC1UeXBlIiwiIl0sWyJzdGFydHMtd2l0aCIsIiRDb250ZW50LURpc3Bvc2l0aW9uIiwiIl0seyJ1aWQiOiIxMjMifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwwLDUyNDI4ODAwXV19" />
    <input type="hidden" name="Signature" value="HnOSk3kfx5LFtn4CIiFcSglQUXc=" />
    <input type="file" name="file" />
    <input type="submit" value="上传" />
</form>
```

 - 注意事项：
  - POST请求后的uri只能是“/”
  - success_action_redirect：指定上传成功后客户端重定向的URL。
  - key：变量${filename}将被自动替换成被上传文件的文件名；


### PUT Object - Copy

 - 描述：通过拷贝方式创建Object（不上传具体的文件内容。而是通过COPY方式对系统内另一文件进行复制）。

 - 请求格式：

```http
PUT /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
x-amz-copy-source: </source-bucket/source-object>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CopyObjectResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <LastModified>Mon, 08 Aug 2016 05:04:10 GMT</LastModified>
    <ETag>870c06c00566c4fb1861bb10f34d1904</ETag>
</CopyObjectResult>
```

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>x-amz-copy-source</td>
            <td>
            	被copy的文件地址。格式：/source-bucket/source-object，需要整体进行urlencode编码.
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Cache-Control</td>
            <td>
            	文件Cache，标准HTTP协议，更多内容参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Expires</td>
            <td>
            	文件在客户端或浏览器的缓存过期时间，允许客户端在这个时间之前不去服务端检查，读取时原值返回。格式为：Sun, 29 Jul 2018 20:36:14 UTC
            </td>
            <td>No</td>
          </tr>
            
          <tr>
            <td>Content-Type</td>
            <td>
            	文件mime type，读取时原值返回
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Length</td>
            <td>
            	必须是0
            </td>
            <td>=0</td>
          </tr>
                             
          <tr>
            <td>Content-Disposition</td>
            <td>
            	HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>Content-Encoding</td>
            <td>
            	文件编码，HTTP标准文件属性信息，读取时原值返回。参见：http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>x-amz-acl</td>
            <td>
            	文件ACL：创建文件的同时，设置一个ACL。请参照《ACL》
            </td>
            <td>No</td>
          </tr>
          
          <tr>
            <td>x-amz-meta-*</td>
            <td>
            	用户自定义MetaDeta, header以x-amz-meta-开头, 所有meta以key:value的形式存储,最大限制64KB,
                HEAD或者GET时原样返回
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-match</td>
            <td>
            	如果指定的ETag与源文件的ETag匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-nonematch</td>
            <td>
            	如果指定的ETag与源文件的ETag不匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-unmodified-since</td>
            <td>
            	如果指定的时间开始源文件没有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
          
          <tr>
            <td>x-amz-copy-source-if-modified-since</td>
            <td>
            	如果指定的时间开始源文件有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>    
        </tbody>
</table>

 - Response Body（响应XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>CopyObjectResult</td>
            <td>
            	包含ETag和LastModified元素
            </td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	文件的ETag
            </td>
          </tr>
        
          <tr>
            <td>CopyObjectResult</td>
            <td>
            	文件的最后修改时间
            </td>
          </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X PUT -H "x-amz-copy-source: /bucket-123/path/to/file123.txt" -H "Date:
Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/myfile.txt"
```

### DELETE Object

 - 描述：删除指定Object。

 - 请求格式：

```http
DELETE /<ObjectName> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应（无HTTP Body）：

```http
HTTP/1.1 204 No Content
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 0
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
```

 - 请求示例：

```
curl -v -X DELETE -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt"
```


### GET Object ACL

 - 描述：获得指定Object的ACL信息。更多信息请参照：[《ACL》](../acl/acl.md)

 - 请求格式：

```http
GET /<ObjectName>?acl HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Content-Length: 123
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

Json format:
Note: You can specify the XML with formatter request parameter
{
    "Owner": "Baishan0000000000000001",
    
    "ACL": {
    
        "GRPS000000ANONYMOUSE": [
        
        	"read"
        ],
    
        "Baishan0000001001NHT3M7": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "Baishan0000000000000001": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "Baishan0000001001HBK3UT": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
    
        "GRPS0000000CANONICAL": [
            "read",
            "write",
            "read_acp",
            "write_acp"
        ],
        
        ...
    }
}
```

 - 响应格式说明请参照：[《ACL》](../acl/acl.md)

 - 请求示例：

```
curl -v -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt?acl"
```

### PUT Object ACL

 - 描述：给指定Object设置ACL规则。更多信息请参照：[《ACL》](../acl/acl.md)

 - 请求格式：

```http
PUT /<ObjectName>?acl HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》

#ACL规则: XML or Json
{
    "Baishan0000000000000001" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS000000ANONYMOUSE" :  [ "read", "read_acp" , "write", "write_acp" ],
    "GRPS0000000CANONICAL" :  [ "read", "read_acp" , "write", "write_acp" ]
}
```

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>x-amz-acl</td>
            <td>
            	文件ACL：请参照《ACL》
            </td>
            <td>No</td>
          </tr>
        </tbody>
</table>

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
```

 - Request Body（请求Body）：
XML or JSon format acl body

Note: 假如指定了x-amz-acl header将忽略body中acl, body中的xml格式由请求参数formatter参数决定, 默认为XML

 - Response（无HTTP Body）：

 - 请求格式说明请参照：[《ACL》](../acl/acl.md)

 - 请求示例：

```
curl -v -T "acl.txt" -H "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization:
AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt"
```

### Initiate Multipart Upload

 - 描述：大文件分片上传初始化接口
 - 注意：在初始化上传接口中要求必须进行用户认证，匿名用户无法使用该接口。在初始化上传时可以给定文件上传所需要的meta绑定信息，在后续的上传中该信息将被保留，并在最终完成时写入云存储系统。

 - 请求格式：

```http
POST /<ObjectName>?uploads HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Content-Type: <mime-type>
x-amz-meta-foo1: <value1> #自定义meta：foo1
x-amz-meta-foo2: <value2> #自定义meta：foo2
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<InitiateMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Bucket>your-bucket</Bucket>
    <Key>objectName</Key>
    <UploadId>VXBsb2FkIElEIGZvciA2aWWpbmcncyBteS1tb3ZpZS5tMnRzIHVwbG9hZA</UploadId>
</InitiateMultipartUploadResult>
```

 - Request Headers（请求头）：
 参考put_object

 - Response Body（响应XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>InitiateMultipartUploadResult</td>
            <td>
            	包含Bucket, Key和UploadId元素
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
            	标识该分块上传的ID, 之后上传分片时需要携带该参数
            </td>
          </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X POST "Date: Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/my/file.txt?uploads"
```

### Upload Part
 - 描述：上传分片接口

 - 请求格式：

```http
PUT /<ObjectName>?partNumber=<PartNumber>&uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Content-Length: <Content-Length>
Content-MD5: <Content-MD5>
Authorization: <authorization string> #请参照《签名算法》

...
file_content
...

```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>
Etag: <Etag>
```

- Request Parameters(请求参数)：

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
            <td>partNumber</td>
            <td>文件分片的序号，从1开始</td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>uploadId</td>
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
    </table>

- Request Heades(请求头)：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>Content-Length</td>
            <td>
            	文件大小，读取时原值返回
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Content-MD5</td>
            <td>
            	base64编码的文件MD5（与传送内容不符时失败），注意：字符串格式为rfc标准使用base64编码的值
            </td>
            <td>No</td>
          </tr>
        </tbody>
</table>
  - 注意：分片数不能超过2048。

### Upload Part - Copy

 - 描述：通过拷贝方式创建上传一个分片（不上传具体的文件内容。而是通过COPY方式对系统内另一文件进行复制）。

 - 请求格式：

```
PUT /<ObjectName>?partNumber=PartNumber&uploadId=UploadId HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
x-amz-copy-source: </source-bucket/source-object>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

```
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
ETag: "<文件的MD5值>"
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CopyObjectResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <LastModified>Mon, 08 Aug 2016 05:04:10 GMT</LastModified>
    <ETag>870c06c00566c4fb1861bb10f34d1904</ETag>
</CopyObjectResult>
```
 - Request Parameters(请求参数)：

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
        <td>partNumber</td>
        <td>文件分片的序号，从1开始</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>uploadId</td>
        <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
        <td>Yes</td>
      </tr>
    </tbody>
</table>

 - Request Headers（请求头）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>x-amz-copy-source</td>
            <td>
                被copy的文件地址。格式：/source-bucket/source-object，需要整体进行urlencode编码.
            </td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>Content-Length</td>
            <td>
                必须是0
            </td>
            <td>=0</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-match</td>
            <td>
                如果指定的ETag与源文件的ETag匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-nonematch</td>
            <td>
                如果指定的ETag与源文件的ETag不匹配, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-unmodified-since</td>
            <td>
                如果指定的时间开始源文件没有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
          <tr>
            <td>x-amz-copy-source-if-modified-since</td>
            <td>
                如果指定的时间开始源文件有修改, 则可copy源文件, 否则返回412(PreconditionFailed)
            </td>
            <td>No</td>
          </tr>
        </tbody>
</table>

 - Response Body（响应XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>CopyObjectResult</td>
            <td>
                包含ETag和LastModified元素
            </td>
          </tr>
          <tr>
            <td>ETag</td>
            <td>
                文件的ETag
            </td>
          </tr>
          <tr>
            <td>CopyObjectResult</td>
            <td>
                文件的最后修改时间
            </td>
          </tr>
        </tbody>
</table>

 - 请求示例：

```
curl -v -X PUT -H "x-amz-copy-source: /bucket-123/path/to/file123.txt" -H "Date:
Sat, 20 Nov 2286 17:46:39 GMT" -H "Authorization: AWS <access_key>:<ssig>" "http://<Your-Bucket-Name>.s2.i.qingcdn.com/path/to/myfile.txt?partNumber=<PartNumber>&uploadId=<UploadId>"
```

### Complete Multipart Upload

 - 描述：大文件分片上传拼接完成接口（合并接口）

 - 请求格式：

```http
POST /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Content-Type: text/json
Authorization: <authorization string> #请参照《签名算法》

<CompleteMultipartUpload>
    <Part>
        <PartNumber>1</PartNumber>
        <ETag>"a54357aff0632cce46d942af68356b38"</ETag>
    </Part>
    <Part>
        <PartNumber>2</PartNumber>
        <ETag>"0c78aef83f66abc1fa1e8477f296d394"</ETag>
    </Part>
    <Part>
        <PartNumber>3</PartNumber>
        <ETag>"acbd18db4cc2f85cedef654fccc4a4d8"</ETag>
    </Part>
</CompleteMultipartUpload>
```

 - 响应：

```http
HTTP/1.1 200 OK
Date: Tue, 08 Apr 2014 02:59:47 GMT
Connection: keep-alive
x-amz-request-id: 0000106c-1608-0810-4621-00163e000064
x-amz-s2-requester: <Your UserName>

<?xml version="1.0" encoding="UTF-8"?>
<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Location>http://Example-Bucket.s2.i.qingcdn.com/Example-Object</Location>
    <Bucket>Example-Bucket</Bucket>
    <Key>Example-Object</Key>
    <ETag>"3858f62230ac3c915f300c664312c11f-9"</ETag>
</CompleteMultipartUploadResult>
```

- Request Parameters(请求参数)：

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
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
 </table>

 - Request Body（请求Body）：

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>PartNumber</td>
            <td>文件分片的序号</td>
            <td>Yes</td>
          </tr>
          
          <tr>
            <td>ETag</td>
            <td>通过Upload Part（上传分片接口）上传成功后返回的响应头中的Etag值</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
</table>

 - Response Body（响应XML Body）：
<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Required</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>CompleteMultipartUploadResult</td>
            <td>
            	包含Location, Bucket, Key和ETag元素
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Location</td>
            <td>
            	URI标识新上传的文件
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Bucket</td>
            <td>
            	bucket name
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>Key</td>
            <td>
            	objectName
            </td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	文件的ETag, 该ETag和put_object的ETag不同, 并不是文件的md5值
            </td>
            <td>Yes</td>
          </tr>
        </tbody>
</table>

### List Parts

 - 描述：列出已经上传的所有分块

 - 请求格式：

```http
GET /<ObjectName>?uploadId=<UploadId> HTTP/1.1
Host: <Your-Bucket-Name>.s2.i.qingcdn.com
Date: <date>
Authorization: <authorization string> #请参照《签名算法》
```

 - 响应：

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

- Request Parameters（请求参数）：

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
            <td>通过Initiate Multipart Upload（大文件分片上传初始化接口）获得的uploadId值</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>max-parts</td>
            <td>返回最大的part数量, 默认返回2048个</td>
            <td>Yes</td>
          </tr>
        
          <tr>
            <td>part-number-marker</td>
            <td>列出该partNumber之后的parts, 不包括该partNUmber指定的part, partNUmber从1开始</td>
            <td>Yes</td>
          </tr>
       
        </tbody>
</table>

- Request Headers（请求头）：

- Response Body（响应XML Body）：
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
            	包含Bucket, Key, UploadId, Initiator, Owner, StorageClass, PartNumberMarker, NextPartNumberMarker, MaxParts, IsTruncated, Part元素
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
            	标识该分块上传的ID, 之后上传分片时需要携带该参数
            </td>
          </tr>
        
          <tr>
            <td>Initiator</td>
            <td>
            	包含ID, DisplayName元素
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
            	包含ID, DisplayName元素, 指定文件的owner
            </td>
          </tr>
        
          <tr>
            <td>StorageClass</td>
            <td>
            	存储类别
            </td>
          </tr>
        
          <tr>
            <td>PartNumberMarker</td>
            <td>
            	 list开始的partNumber, 不包含该partNumber
            </td>
          </tr>
        
          <tr>
            <td>NextPartNumberMarker</td>
            <td>
            	下次开始list的partNumber
            </td>
          </tr>
        
          <tr>
            <td>MaxParts</td>
            <td>
            	最大part数量
            </td>
          </tr>
        
          <tr>
            <td>IsTruncated</td>
            <td>
            	是否被truncated
            </td>
          </tr>
        
          <tr>
            <td>Part</td>
            <td>
            	包含PartNumber, LastModified, ETag, Size元素, 表示一个part的信息
            </td>
          </tr>
        
          <tr>
            <td>PartNumber</td>
            <td>
            	part的number
            </td>
          </tr>
        
          <tr>
            <td>LastModified</td>
            <td>
            	part的最后修改时间
            </td>
          </tr>
        
          <tr>
            <td>ETag</td>
            <td>
            	part的md5
            </td>
          </tr>
        
          <tr>
            <td>Size</td>
            <td>
            	part的size
            </td>
          </tr>
        </tbody>
</table>


## 签名算法

- 如果http请求中没有携带身份信息（AccessKey），则改该请求为匿名请求，会被认为是来自匿名用户的访问。

- 如果http请求中携带了身份信息（AccessKey），则认为访问来自该AccessKey所对应的用户。由于AccessKey是可以被他人获取到的，
为了防止其他人冒用您的AccessKey来访问服务，请求中还必须携带您的签名。在申请帐号以后，您将得到AccessKey和SecretKey，
SecretKey是需要保密的。签名是由此次http请求的相关信息和您的SecretKey计算得到的，其他人因为不知道您的SecretKey，将不能
计算出正确的签名。

- 身份信息与签名可以放到请求头（Authorization）中，也可以放到请求参数中。

- 签名的方式与Amazon S3的签名方式兼容，支持signature version 2 和 signature version 4。

## 添加签名

> 由于计算签名的过程比较繁琐且容易出错，不建议自己计算签名，推荐使用[SDKs]('https://aws.amazon.com/tools/')，SDK可以自动为请求计算签名。

### 添加version 2 签名

#### 身份信息与签名的携带方式：

##### 通过Authorization请求头：

请求头格式：

```
Authorization: AWS AWSAccessKeyId:Signature
```

- AWSAccessKeyId: 您的AccessKey

- Signature: 计算得到的签名

例子：

```
Authorization: AWS ziw5dp1alvty9n47qksu:frJIUN8DYpKDtOLCwo//yllqDzg=
```

##### 通过请求参数：

需要在请求中包含以下三个参数：

- AWSAccessKeyId：指定您的AccessKey

- Signature：计算得到的签名

- Expires：指定签名的过期时间

例子：

```
GET /yourbucket/yourkey?AWSAccessKeyId=ziw5dp1alvty9n47qksu&Expires=1141889120&Signature=vjbyPxybdZaNmGa%2ByT272YEAiv4%3D
```

#### 签名的计算方法：

```
Signature = Base64( HMAC-SHA1( YourSecretKey, UTF-8-Encoding-Of( StringToSign ) ) )

StringToSign = HTTP-Verb + "\n" +
	Content-MD5 + "\n" +
	Content-Type + "\n" +
	Date|Expires + "\n" +
	CanonicalizedAmzHeaders +
	CanonicalizedResource
```

- YourSecretKey: 您的SecretKey

- HTTP-Verb: 请求的方法，如：`PUT`，`GET`，`DELETE`，`POST`

- Content-MD5: 请求头Content-MD5的内容，如果没有这个头，由空字符串代替

- Content-Type: 请求头Content-Type的内容，如果没有这个头，由空字符串代替

- Date|Expires: 如果使用Authorization头携带签名信息，为Date头的内容，如果没有Date头，由空字符串代替；如果使用请求参数携带签名信息，为参数Expires的内容

- CanonicalizedAmzHeaders: 请求中所有以x-amz-开始的头所组成的字符串,如果没有这样的头，由空字符串代替

- CanonicalizedResource: 请求所对应的资源

计算CanonicalizedAmzHeaders的例子：

```
原始请求头：
Date: Tue, 27 Mar 2007 19:36:42 +0000
X-Amz-b:   Bar
x-amz-a: foob
x-Amz-a:   fooa
Host: johnsmith.s3.amazonaws.com

对应的CanonicalizedAmzHeaders为：
x-amz-a:fooa,foob
x-amz-b:Bar
```

> 注意：
> 1.请求头的名字全部转换为小写，按转换后的头名字排序。2，如果出现重复的头，需要合并，各个值之间用逗号分隔，并排序。3，去掉值前后的空格。

计算CanonicalizedResource的例子：

```
GET /?foo=bar
GET /yourbucket/yourkey?foo=bar
GET /yourbucket/yourkey?acl&foo=bar

对应的nicalizedResource分别为：

／
/yourbucket/yourkey
/yourbucket/yourkey?acl
```

如果您需要了解完整和详细的签名计算过程，请参考以下连接：

- [http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html](http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html)
- [http://docs.aws.amazon.com/general/latest/gr/signature-version-2.html](http://docs.aws.amazon.com/general/latest/gr/signature-version-2.html)

###  添加version 4 签名：

#### 身份信息与签名的携带方式：

##### 通过Authorization头：

例子：

```
Authorization: AWS4-HMAC-SHA256 Credential=ziw5dp1alvty9n47qksu/20160830/us-east-1/s3/aws4_request, SignedHeaders=content-type;host;x-amz-date, Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7
```

- Credential由AccessKey，请求的日期，region，服务名，`aws4_request`五部分组成，各部分之间用斜线分隔

- SignedHeaders: 表示那些头参与了签名的计算，未包含在这里的头不会影响到签名的生成

- Signature: 计算得到的签名

##### 通过请求参数：

需要在请求中加入以下参数：

- X-Amz-Algorithm: 计算签名时使用的Hash算法，指定为`AWS4-HMAC-SHA256`

- X-Amz-Credential: 包含了AccessKey，日期，region，服务名的信息

- X-Amz-Date: 请求的时间

- X-Amz-Expires: 指定签名在多长时间内有效

- X-Amz-SignedHeaders: 计算签名时用到的头

- X-Amz-Signature: 计算得的到签名

例子：

```
GET /yourbucket/test.mp4??X-Amz-Algorithm=AWS4-HMAC-SHA256&&X-Amz-Credential=ziw5dp1alvty9n47qksu/20160830/us-east-1/s3/aws4_request&X-Amz-Date=20160830T201207Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7
```

#### 签名的计算方法：

计算CanonicalRequest

```
CanonicalRequest =
    HTTPRequestMethod + '\n' +
    CanonicalURI + '\n' +
    CanonicalQueryString + '\n' +
    CanonicalHeaders + '\n' +
    SignedHeaders + '\n' +
    HexEncode(Hash(RequestPayload))
```

- HTTPRequestMethod: 如`PUT`, `GET`, `DELETE`, `POST`

- CanonicalURI: 请求的uri

- CanonicalQueryString: 请求参数排序后组成的字符串

- CanonicalHeaders: 需要加入签名计算的头排序后组成的字符串

- SignedHeaders：加入到签名计算的头的名字的列表，各个名字之间用逗号分隔

- HexEncode(Hash(RequestPayload))：请求body的hash的16进制编码,如果通过请求参数携带签名，此处应由字符串`UNSIGNED-PAYLOAD`代替

计算StringToSign

```
StringToSign  =
    Algorithm + '\n' +
    RequestDate + '\n' +
    CredentialScope + '\n' +
    HashedCanonicalRequest
```

- Algorithm: 指定为`AWS4-HMAC-SHA256`

- RequestDate: ISO8601 basic 格式的请求时间，如：20160830T123600Z

- CredentialScope: 日期，region，服务名等组成的字符串， 如：20160830/us-east-1/s3/aws4_request

- HashedCanonicalRequest: Hex(SHA256Hash(CanonicalRequest)),即CanonicalRequest的hash的16进制编码

计算signing key

```
kSecret = YourSecretKey
kDate = HMAC("AWS4" + kSecret, Date)
kRegion = HMAC(kDate, Region)
kService = HMAC(kRegion, Service)
kSigning = HMAC(kService, "aws4_request")
```

- YourSecretKey: 您的SecretKey

- Date：8位数的日期，应与Credentail中的Date部分一样

- Region： 应与Credential中的region部分一样

- Service: 应与Credential中的服务名部分一样

- kSigning即为用于计算签名的signing key

计算签名

```
signature = HexEncode(HMAC-SHA256(kSigning, StringToSign))
```

如果您需要了解完整和详细的签名计算过程，请参考以下连接

- [http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html](http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html)
- [http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html)

### ACL(Access Control List)
-------------------

访问控制列表(ACL)使您可以管理存储桶(bucket)和对象(object)的访问权限。每个存储桶和对象都都有一个附加的ACL子资源。它定义了哪些用户或则组将被授予访问权限, 收到某个资源(存储桶或或者对象)的请求后，S2将检查相应的ACL以验证请求者是否拥有所需的访问权限。

创建存储桶或对象时，S2将创建一个默认ACL，以授予资源拥有者对资源的完全控制权限，如下面的示例存储桶ACL中所示。

```
<?xml version="1.0" encoding="UTF-8"?><AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/">    <Owner>        <ID>*** Owner-Canonical-User-ID ***</ID>        <DisplayName>owner-display-name</DisplayName>    </Owner>    <AccessControlList>        <Grant>            <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Canonical User">                <ID>*** Owner-Canonical-User-ID ***</ID>                <DisplayName>display-name</DisplayName>            </Grantee>            <Permission>FULL_CONTROL</Permission>        </Grant>    </AccessControlList></AccessControlPolicy>

```

示例ACL包含一个Owner元素表示资源拥有者的用户名。Grant元素表示被授权者（用户或预定义的组）和所授予的权限。您可以通过添加Grant元素授予权限。

#### 被授权者(Grantee)

被授权者可以是s2用户或某个预定义的S2组。您可以通过email地址或用户名将权限授予某个用户。但是，如果您在授权请求设置的是email地址，S2将查找该email对应的用户名并将它添加到ACL。生成的ACL将始终包含的是s2用户的用户名，而不是用户的email地址。

#### S2预定义的组(Group)

S2拥有一系列预定义的组。将用户访问权限授予某个组时，您可以指定一个URI，而不是用户名。我们提供以下预定义的组：

- 经身份验证的用户组(Authenticated Users group), 由http://acs.amazonaws.com/groups/global/AuthenticatedUsers标识, 该组代表了所有的s2用户。该组的访问权限允许任何s2用户访问资源, 但是，所有的请求必须是已签名的（经身份验证)。
- 所有的用户组(All Users group), 由http://acs.amazonaws.com/groups/global/AllUsers标识。该组的访问权限允许任何人访问资源。请求可以是已签名的（经身份验证），也可以是未签名的（匿名）。- 日志传输组(Log Delivery group), 由http://acs.amazonaws.com/groups/s3/LogDelivery标识, 存储桶上的WRITE 许可使该组可以将服务器访问日志写入存储桶。

#### 可以指定被授权者的权限(Permissions)

下表列出了S2在ACL中支持的权限集及在操作资源语境中的含义。

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Permission</th>
            <th>当在存储桶上授权</th>
            <th>当在对象上授权</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>READ</td>
            <td>允许授权者列出bucket中所有的对象</td>
            <td>允许被授权者读取对象的数据和meta信息</td>
          </tr>
          <tr>
            <td>WRITE</td>
            <td>允许被授权者创建、覆盖和删除存储桶中的对象</td>
            <td>不可用</td>
          </tr>

          <tr>
            <td>READ_ACP</td>
            <td>允许被授权者读取存储桶ACL</td>
            <td>允许被授权者读取对象的ACL</td>
          </tr>
          <tr>
            <td>WRITE_ACP</td>
            <td>允许被授权者修改存储桶的ACL</td>
            <td>允许被授权者修改对象的ACL</td>
          </tr>
          <tr>
            <td>FULL_CONTROL</td>
            <td>允许被授权者在存储桶上的READ、WRITE、READ_ACP 和WRITE_ACP权限</td>
            <td>允许被授权者在对象上的READ、READ_ACP 和WRITE_ACP权限</td>
          </tr>
        </tbody>
</table>

#### Canned ACL

S2支持一系列预定义的授权，称为标准ACL。每个标准ACL都有一组预定义的被授权者和权限。下表列出了一系列标准ACL和相关联的预定义授权。

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Canned ACL</th>
            <th>适用于</th>
            <th>对应的ACL权限</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>private</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。其他人没有访问权限（默认）。</td>
          </tr>
          <tr>
            <td>public-read</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。匿名用户有READ的权限</td>
          </tr>
          <tr>
            <td>public-read-write</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。AllUsers组用户有READ, WRITE的权限,对象没有WRITE权限</td>
          </tr>
          <tr>
            <td>authenticated-read</td>
            <td>存储桶和对象</td>
            <td>拥有者将获得FULL_CONTROL。AuthenticatedUsers组用户有READ</td>
          </tr>
       </tbody>
</table>

#### 如何指定ACL

S2 API使您可以在创建存储桶或对象时设置ACL。S2还提供API在现有存储桶或对象上设置ACL。这些API向您提供了以下方法来设置ACL：

- 使用请求header设置ACL – 发送创建资源（存储桶或对象）的请求时，您可以使用x-amz-acl头设置Canned acl, 或者使用x-amz-grant-*头设置某个用户或者则组具有的权限。

- 使用ACL API设置ACL – 当您发送在现有资源上设置ACL的请求时，您可以在请求标头或body中设置ACL, 如put_object_acl API

<b>注意</b>:

- x-amz-acl和x-amz-grant-\*不能同时指定, 同时指定是返回400错误
- 在put_object_acl API中如果, 指定 x-amz-acl或者x-amz-grant-*请求头, 则忽略body中的ACL

##### x-amz-grant-*请求头类型

x-amz-grant-\*请求头的值为type=value对的形式, 每个tpye=value以逗号隔开, 同一请求中可以指定多个x-amz-grant-\*请求头, 允许的type为:
- emailAddress, 用户的email地址
- id, 用户名
- uri, 预定义用户组的uri

<table class="table table-condensed">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>x-amz-grant-read</td>
            <td>允许授权者READ的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-write</td>
            <td>允许授权者WRITE的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-read-acp</td>
            <td>允许授权者READ_ACP的权限</td>
          </tr>
          <tr>
            <td>x-amz-grant-write-acp</td>
            <td>允许授权者WRITE_ACP的权限</td>
          </tr>
          </tr>
          <tr>
            <td>x-amz-grant-full-control</td>
            <td>允许授权者READ, WRITE, READ_ACP, WRITE_ACP的权限</td>
            </tr>
       </tbody>
</table>

例子:
```
   x-amz-grant-read: emailAddress="xyz@amazon.com", emailAddress="abc@amazon.com"
```

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

﻿

![](http://imgx-test.heheapp.com/w_300/bsc_logo.jpg)

# Imgx(图片处理服务)使用说明

标签： 图片处理 imgx 白山云 存储服务

---

## URL格式
```
http://imgx.i.qingcdn.com/<bucket>/<处理指令>/<文件路径>?<签名保护>
```
或者
```
http://<bucket>.imgx.i.qingcdn.com/<处理指令>/<文件路径>?<签名保护>
```

- `bucket` : 您在云存储服务中的bucket名称；
- `处理指令` : 对原始图片的处理指令，下面有详细介绍；
- `文件路径` : 原始图片文件在云存储服务中的存储路径；
- `签名保护` : 主要是签名相关的参数；



## 举例
例如：原始图片在云存储中的url为：http://s2.i.qingcdn.com/imgx-test/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464773061&Signature=jFVHRSrOLeg5e3nIR00UE2vik0A%3D
可以看出：

 - bucket为：imgx-test
 - 在bucket中的路径为：demo/1.jpg

下面我们进行下列操作：

 - 裁剪人脸区域, 并将图片缩略：400x400：`c_thumb,g_face,w_400,h_400`
 - 将图片变成圆角，半径为最大(正圆)：`r_max`
 - 将图片亮度增加8%：`e_brightness:8`
 - 将图片格式转换为png格式：`f_png`

处理指令为：`c_thumb,g_face,w_400,h_400,r_max,e_brightness:8,f_png`
我们可以通过URL直接进行访问：
```
http://imgx.i.qingcdn.com/imgx-test/c_thumb,g_face,w_400,h_400,r_max,e_brightness%3A8,f_png/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464773122&Signature=4cwxt1e%2Fg2NL1OfsldaVsa8SD9s%3D
```
或者
```
http://imgx-test.imgx.i.qingcdn.com/c_thumb,g_face,w_400,h_400,r_max,e_brightness%3A8,f_png/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464773122&Signature=4cwxt1e%2Fg2NL1OfsldaVsa8SD9s%3D
```
或者创建一个json文件(如果您不想将处理指令暴露在URL中)，内容为：
```json
[
    {  
        "crop" : "thumb",
        "gravity" : "face",
        "width" : 400,
        "height" : 400,
        "radius" : "max",
        "effect" : "brightness:8",
        "format" : "png"
    }
]
```
将文件保存到您对应的bucket下的路径：
```
imgx/t/my_thumb.json    #其中文件名(my_thumb)是您自定义的“指令集名称”，类似css中的class
```
然后就可以通过下面的URL进行访问（也就是说，处理指令也可以不用放在URL中，直接隐藏到您自定义的json文件中）：
```
http://imgx.i.qingcdn.com/imgx-test/t_my_thumb/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464773563&Signature=WIMaNLacGaPRAlA6fl%2BGAsStfoQ%3D
```




## 指令格式

- 指令名和指令值之间用“_”连接，如：`c_fit`
- 相关指令使用逗号隔开“,” 如： `c_fit,w_100,h_100,g_face`
- 多组指令之间用“--”隔开，如： `c_fit,w_100,h_100,g_face,r_max--l_text:my_font:hello+word,w_100,h_40`



## 签名

为了保护您的原图不被盗取以及处理指令不被恶意滥用，所以这里必须使用签名保护，签名形式完全兼容AWS-V2认证，以下提供一个生成代签名URL的php函数：

```php
/**
* Get a query string authenticated URL
*
* @param string $accessKey AccessKey
* @param string $secretKey SecretKey
* @param string $bucket Bucket name
* @param string $uri Object URI
* @param integer $lifetime Lifetime in seconds
* @param boolean $hostBucket Use the bucket name as the hostname
* @param boolean $https Use HTTPS ($hostBucket should be false for SSL verification)
* @return string
*/
function getAuthenticatedURL($accessKey, $secretKey, $bucket, $uri, $lifetime, $hostBucket = false, $https = false, $endpoint = 'imgx.i.qingcdn.com') {
	
	$expires = time() + $lifetime;
	$uri = str_replace(array('%2F', '%2B', '%2C', '%3A', '%20'), array('/', '+', ',', ':', '+'), rawurlencode($uri));
	return sprintf(($https ? 'https' : 'http').'://%s/%s?AWSAccessKeyId=%s&Expires=%u&Signature=%s',
	$hostBucket ? $bucket : $endpoint.'/'.$bucket, $uri, $accessKey, $expires,
	urlencode(base64_encode(hash_hmac('sha1', "GET\n\n\n{$expires}\n/{$bucket}/{$uri}", $secretKey, true))));
}
//用法很简单
echo getAuthenticatedURL('您的accessKey', '您的secretKey', '您的bucket', '指令/文件路径', '多久以后过期(秒)');
# 建议$lifetime设置比较长，例如：1000000000
```

## 缓存 & CDN

 - 处理后的图片生成缓存，下次请求不在重复生成，默认缓存7天
 - 如果配置了CDN，处理后的图片会自动推送到CDN节点
 - 如果您的原图修改了，可以使用`v`指令重新生成图片和链接，后面详细介绍



## 图片处理指令

> 以下介绍具体处理指令，用下列几张原图为例，方便您对照：
1. [demo/charles.png][1]
2. [demo/1.jpg][2]
3. [demo/3.png][3]
4. [demo/4.png][4]
5. [demo/sheep.png][5]
6. [demo/horses.png][6]
7. [avatar.png][7]

<table>
    <thead>
        <tr>
            <th width="57px"><i>指令名</i></th>
            <th width="46px"><i>指令</i></th>
		    <th width="130px"><i>Value</i></th>
		    <th width="386px"><i>示例</i></th>
		    <th width="186px"><i>描述</i></th>
        </tr>
        <tr>
            <th>crop</th>
            <th><b>c</b></th>
            <th><i>mode</i></th>
            <th></th>
            <th>裁剪方式，指定图像裁剪或放缩的方式。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>scale</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_scale,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775245&Signature=U8cS78xlQH0EZArL2WJMZx9mHNY%3D" /></td>
            <td>改变图像的大小，以匹配给定的宽度和高度。所有原始图像的部分将是可见的，但可能会被拉伸而变形。
                <br /><br /><code>c_scale,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>fill</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775280&Signature=3%2ByB4vbW4XesbrNCssGY7LexDhU%3D" /></td>
            <td>裁剪图像，同时保留原有比例。
                <br /><br /><code>c_fill,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>lfill</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_lfill,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775301&Signature=cFPJah0EXgrFkV%2F%2B1KjE5vedmHo%3D" /></td>
            <td>同 <i>fill</i> 模式，不同的是限制图片尺寸不大于原图
                <br /><br /><code>c_lfill,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>fit</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775325&Signature=dzwxaEl%2FTA2qsDSGfcv%2FG5Gs9%2F8%3D" /></td>
            <td>改变图像的大小，以匹配给定的宽度和高度，同时保留原有比例，所有原始图像的部分将是可见的。等比放缩，不会因为拉伸而变形。
                <br /><br /><code>c_fit,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>mfit</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_mfit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775342&Signature=yEhC4KixIMt4RrtnKMpN%2F9jp4CM%3D" /></td>
            <td>同 <i>fit</i> 模式，不同的是限制图片尺寸不小于原图
                <br /><br /><code>c_mfit,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>limit</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_limit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775503&Signature=ne3LQQQl92ExCHy3LAUM3m9jMo4%3D" /></td>
            <td>同 <i>fit</i>，不同的是限制图片尺，处理后的图片尺寸不会超过原图。
                <br /><br /><code>c_limit,h_80,w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>pad</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_pad,h_80,w_80,g_center,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775599&Signature=pEv4icz3BrvbkjvTQHAOXce3Tvo%3D" /></td>
            <td>指定图像的尺寸，同时保留原有比例。如果原图比例不满足指定的尺寸，将被填充为背景颜色。
                <br /><br /><code>c_pad,h_80,w_80,g_center,b_dddddd</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>lpad</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_lpad,h_640,w_640,g_center,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775619&Signature=ZY8kJ8xsAo4lTbcyY8unWndaKEI%3D" /></td>
            <td>同 <i>pad</i> 模式，不同的是，如果指定的尺寸大于原图，将不扩大原图
                <br /><br /><code>c_lpad,h_640,w_640,g_center,b_dddddd</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>mpad</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_mpad,h_80,w_80,g_center,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775641&Signature=e5eohM2MOtqMsXCUKOmRop2iQIE%3D" /></td>
            <td>同 <i>pad</i> 模式，不同的是限制图片尺寸不小于原图
                <br /><br /><code>c_mpad,h_80,w_80,g_center,b_dddddd</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>crop</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,h_210,w_210,g_face/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775755&Signature=QkEGM0VA2nhfOQ3JlvWCAfsGiFw%3D" /></td>
            <td>指定尺寸和位置，用于从原始图片的基础上裁剪出一部分。
                <br /><br /><code>c_crop,h_210,w_210,g_face</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>thumb</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,h_250,w_250,g_face/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775849&Signature=%2FVEIEuisY%2FNYzT52s2P%2BnIwe8Mk%3D" /></td>
            <td>定位人脸（结合'face'或'faces'重力参数）并生成缩略图，常用于生成头像。
                <br /><br /><code>c_thumb,h_250,w_250,g_face</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>width</th>
            <th><b>w</b></th>
            <th><i>像素或者百分比</i></th>
            <th></th>
            <th>宽度参数，结合 <i>裁剪方式(crop)</i> 或者 <i>水印(overlay)</i> 使用 </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>80</i></td>
            <td><img src="http://imgx-test.heheapp.com/w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775890&Signature=3O7sB36S5fxARIRIXma0EDwrUM0%3D" /></td>
            <td>调整宽度为80像素
                <br /><br /><code>w_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>0.1</i></td>
            <td><img src="http://imgx-test.heheapp.com/w_0.1/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775909&Signature=UGZpnvF3kXfVN9JlYsKq4J1DMcc%3D" /></td>
            <td>调整图像到其原始尺寸的10％。
                <br /><br /><code>w_0.1</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>height</th>
            <th><b>h</b></th>
            <th><i>像素或者百分比</i></th>
            <th></th>
            <th>高度参数，结合 <i>裁剪方式(crop)</i> 或者 <i>水印(overlay)</i> 使用 </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>80</i></td>
            <td><img src="http://imgx-test.heheapp.com/h_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775931&Signature=iZkes%2BXqVFnIUa3AR5vIRugTcy8%3D" /></td>
            <td>调整高度为80像素
                <br /><br /><code>h_80</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>0.1</i></td>
            <td><img src="http://imgx-test.heheapp.com/h_0.1/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775993&Signature=kppwJvaUOgNOacxgOX7pZCMwDDs%3D" /></td>
            <td>调整图像到其原始尺寸的10％。
                <br /><br /><code>h_0.1</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>gravity</th>
            <th><b>g</b></th>
            <th><i>用于指定位置或者方向</i></th>
            <th></th>
            <th>1. 用于 <i>'crop', 'pad', 'fill'</i> 的裁剪方式； <br>2. 用于指定 <i>水印(overlay)</i> 的位置</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>north_west</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_north_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778155&Signature=UExeDYZxS7Wf2J1nMK4KTwtPIyU%3D" /></td>
            <td>左上位置
                <br /><br /><code>c_crop,g_north_west,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>north</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_north,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778249&Signature=plyAm8ZvqawOF3ohDLxCLsmpUQc%3D" /></td>
            <td>正上位置，水平方向居中
                <br /><br /><code>c_crop,g_north,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>north_east</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_north_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778268&Signature=O%2FtX9DTxsjLpF7Q3cJagA8o3l9Y%3D" /></td>
            <td>右上位置
                <br /><br /><code>c_crop,g_north_east,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>west</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778292&Signature=eFTNVmXxhn9hScGUWcpmwnx%2Fkio%3D" /></td>
            <td>左边，垂直方向居中
                <br /><br /><code>c_crop,g_west,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>center</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_center,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778308&Signature=M%2FTeVwmYdINeqp4%2BxxAYMe452g0%3D" /></td>
            <td>正中
                <br /><br /><code>c_crop,g_center,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>east</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778324&Signature=Qb1%2BDyldQ%2FOxx7JJmdQz%2Bglrark%3D" /></td>
            <td>右边，垂直方向居中
                <br /><br /><code>c_crop,g_east,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>south_west</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_south_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778343&Signature=AsJdVwQgL7obQ3lGfKF0RDOHrmM%3D" /></td>
            <td>左下位置
                <br /><br /><code>c_crop,g_south_west,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>south</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_south,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778363&Signature=ImwO39IKfypIoAB442JWj9ogq%2Fg%3D" /></td>
            <td>正下位置，水平方向居中
                <br /><br /><code>c_crop,g_south,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>south_east</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_south_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778397&Signature=sKbISWjFnnsu5B6UrnrmNTEe%2FZo%3D" /></td>
            <td>右下位置
                <br /><br /><code>c_crop,g_south_east,h_200,w_200</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>xy_center</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_xy_center,h_400,w_400,x_245,y_240/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778421&Signature=iWwhFozXKF5m8CO5qhpYT6bcJP8%3D" /></td>
            <td>指定的x,y坐标，并作为中心点
                <br /><br /><code>c_crop,g_xy_center,<br>
                h_400,w_400,x_245,y_240</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>face</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,g_face,h_140,w_140/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778446&Signature=AwK%2BJlJi%2FWMa5m8TDQiqn3z97As%3D" /></td>
            <td>自动定位人脸的位置，如果有多张脸，选择最容易识别的一个
                <br /><br /><code>c_crop,g_face,h_140,w_140</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td>face (thumb)</td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,h_130,w_140,f_png/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464778466&Signature=qSOky2UqHn3tgrQU2bE0BZEjrM8%3D" /></td>
            <td>自动定位人脸的位置，并且根据指定的尺寸生成缩略图。如果有多张脸，选择最容易识别的一个
                <br /><br /><code>c_thumb,g_face,h_130,w_140,f_png</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>faces</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_faces,h_220,w_600,e_brightness%3A18/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779681&Signature=WjBH1Jz2AhdWlQno%2BieOONMHjfk%3D" /></td>
            <td>自动定位多张人脸的位置
                <br /><br /><code>c_thumb,g_faces,h_220,w_600,<br>
                e_brightness:18</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>face:center</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face%3Acenter,h_140,w_140/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779711&Signature=IpqPP16HCxCoPEZRTb%2BPAwh9bfw%3D" /></td>
            <td>自动定位人脸的位置，如果找不到人脸则自动定位到原图的中心
                <br /><br /><code>c_thumb,g_face:center,h_140,w_140</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>faces:center</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_faces%3Acenter,h_120,w_330,e_brightness%3A18/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779729&Signature=MpE5J2LsxhCu1K5%2FB2h9i%2F8VZXA%3D" /></td>
            <td>自动定位多张人脸的位置，如果找不到人脸则自动定位到原图的中心
                <br /><br /><code>c_thumb,g_faces:center,<br>
                h_120,w_330,e_brightness:18</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>x</th>
            <th><b>x</b></th>
            <th><i>像素</i></th>
            <th></th>
            <th>用于指定图片裁剪或者水印的横向坐标。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>110</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,h_180,w_180,x_110/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851108&Signature=qkUt0EBiRH1hL%2FdTSbS%2BvbdS060%3D" /></td>
            <td>裁剪图像180x180像素，从左边110像素开始
                <br /><br /><code>c_crop,h_180,w_180,x_110</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>y</th>
            <th><b>y</b></th>
            <th><i>像素</i></th>
            <th></th>
            <th>用于指定图片裁剪或者水印的纵向坐标。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>230</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_crop,h_180,w_180,x_180,y_230/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851257&Signature=KbWMmZBansdeH7ELNlGu0yIqbXo%3D" /></td>
            <td>裁剪图像180x180像素，从顶部230像素开始。
                <br /><br /><code>c_crop,h_180,w_180,x_180,y_230</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>quality</th>
            <th><b>q</b></th>
            <th><i>百分比</i></th>
            <th></th>
            <th>控制JPG或者WEBP格式图片的压缩质量。最小值为1，最大值为100。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>100</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,h_130,w_140,q_100/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779812&Signature=AgnTF%2BLL6kJCwfQsqxvZrRmaXzk%3D" /></td>
            <td>图片质量为100%，文件大小为14.3KB。
                <br /><br /><code>c_thumb,g_face,h_130,w_140,q_100</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>10</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,h_130,w_140,q_10/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779833&Signature=ngDnb0IJts9p8tlLPAmkI9uK9zk%3D" /></td>
            <td>图片质量为10%，文件大小降低到1.5KB。
                <br /><br /><code>c_thumb,g_face,h_130,w_140,q_10</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>radius</th>
            <th><b>r</b></th>
            <th><i>像素值或者'max'</i></th>
            <th></th>
            <th>指定半径，生成圆角或完全变成圆形（椭圆）。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>30</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,h_140,w_140,f_png,r_30/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779854&Signature=3gVOrVBxma72lG0RRCd%2BrbVzbVY%3D" /></td>
            <td>生成30像素半径的圆角
                <br /><br /><code>c_thumb,g_face,h_140,w_140,f_png,r_30</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>max</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,h_140,w_140,f_png,r_max/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779872&Signature=bLoCnVoXjhycDcmBssoC185tyLY%3D" /></td>
            <td>使用最大半径生成圆角
                <br /><br /><code>c_thumb,g_face,h_140,w_140,f_png,r_max</code></td>
        </tr>
    </tbody>
    <thead>
        <tr>
            <th>angle</th>
            <th><b>a</b></th>
            <th><i>角度或者翻转模式</i></th>
            <th></th>
            <th>翻转或者旋转图像</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>90</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80,a_90/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779895&Signature=9tqwZW7SthjhR2dm950jAn9ZjDI%3D" /></td>
            <td>顺时针旋转90度
                <br /><br /><code>c_fill,h_80,w_80,a_90</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>10</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80,a_10/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779911&Signature=zwPmqKWWUZj9D4gPqnWfWscy8F8%3D" /></td>
            <td>顺时针旋转10度
                <br /><br /><code>c_fill,h_80,w_80,a_10</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>-20</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80,a_-20/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779926&Signature=eE1xWIAlkx4XZAnQ2ww6P8bAVPM%3D" /></td>
            <td>逆时针旋转20度
                <br /><br /><code>c_fill,h_80,w_80,a_-20</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>vflip</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80,a_vflip/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779944&Signature=%2Bca1r1SJSn%2Bs9ocufpuBDty1LeA%3D" /></td>
            <td>垂直翻转
                <br /><br /><code>c_fill,h_80,w_80,a_vflip</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>hflip</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_80,w_80,a_hflip/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779960&Signature=2hSuIkpVhahTCyV53W27sxFXu3E%3D" /></td>
            <td>水平翻转
                <br /><br /><code>c_fill,h_80,w_80,a_hflip</code></td>
        </tr>
    </tbody>

    <thead>
        <tr>
            <th>effect</th>
            <th><b>e</b></th>
            <th><i>name and value</i></th>
            <th></th>
            <th>使用滤镜或者特效</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>grayscale</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_grayscale/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779995&Signature=szrfdWnBYaDbF9mDpEYYQSmHjvc%3D" /></td>
            <td>灰度
                <br /><br /><code>c_fill,h_380,w_380,e_grayscale</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>oil_paint</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_oil_paint/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780024&Signature=Qq%2Fn2GdugVX2E91mKFi2OBl%2FQzA%3D" /></td>
            <td>油画效果
                <br /><br /><code>c_fill,h_380,w_380,e_oil_paint</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>oil_paint:2</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_oil_paint%3A2/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780041&Signature=8cfjtMELUFb0ABNn55M2Zdj%2FEj4%3D" /></td>
            <td>
                使用油画效果，并指定一个level值为2，取值范围1到8，默认值为4
                <br /><br /><code>c_fill,h_380,w_380,e_oil_paint:2</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>negate</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_negate%3A2/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780058&Signature=3qG45TiVOSNwQom%2FpCRANKTFQbY%3D" /></td>
            <td>
                反色
                <br /><br /><code>c_fill,h_380,w_380,e_negate:2</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>brightness:28</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_brightness%3A28/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780075&Signature=PjBqfmVBGLYq5K65Rj95MYLjomg%3D" /></td>
            <td>
                调整图片的亮度，并指定一个百分比值为28，取值范围-100到100，默认值为30
                <br /><br /><code>c_fill,h_380,w_380,e_brightness:28</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>brightness:-28</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_brightness%3A-20/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780093&Signature=MDGQX78ccpE0nYpSt3s0YFSftqE%3D" /></td>
            <td>
                调整图片的亮度，并指定一个百分比值为-20，取值范围-100到100，默认值为30
                <br /><br /><code>c_fill,h_380,w_380,e_brightness:-20</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>blur</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_blur/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780111&Signature=kZHLSOF2dZDUr%2B6%2F5I7qVYg2qbc%3D" /></td>
            <td>
                模糊效果
                <br /><br /><code>c_fill,h_380,w_380,e_blur</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>blur:300</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_blur%3A300/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780133&Signature=1TqlkiM8qhIIGUCCbIihSJtoTDA%3D" /></td>
            <td>
                使用模糊效果，并指定一个level值为300，取值范围1到2000，默认值为100
                <br /><br /><code>c_fill,h_380,w_380,e_blur:300</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>pixelate</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_pixelate%3A20/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780147&Signature=CiVrSg5tbpF0S3kWamgfbvKkPsQ%3D" /></td>
            <td>
                像素化
                <br /><br /><code>c_fill,h_380,w_380,e_pixelate:20</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>pixelate:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_pixelate%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780426&Signature=hjoTMD2jgmLPydz5NF5NnaNlauw%3D" /></td>
            <td>
                使用像素化效果，并指定一个level值为40，默认值为5
                <br /><br /><code>c_fill,h_380,w_380,e_pixelate:40</code>    
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>sharpen</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_sharpen/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780445&Signature=hPVzAXcdvlZX3LqDk%2Bw8bYOV%2BwE%3D" /></td>
            <td>
                锐化
                <br /><br /><code>c_fill,h_380,w_380,e_sharpen</code>    
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>sharpen:400</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_sharpen%3A400/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780462&Signature=bfGlfc%2Fbm6bfdO7lWcRgj6L8Xyw%3D" /></td>
            <td>
                使用锐化效果，并指定一个level值为400，取值范围1到2000，默认值为100
                <br /><br /><code>c_fill,h_380,w_380,e_sharpen:400</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>auto_contrast</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_auto_contrast/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780485&Signature=85x57KcbBgtTMLvSqag4y4yElKY%3D" /></td>
            <td>
                自动对比度
                <br /><br /><code>c_fill,h_380,w_380,e_auto_contrast</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>improve</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_improve/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780504&Signature=NYmzvR%2BtSDeNbfpe%2FWDa92AjHtA%3D" /></td>
            <td>
                自动调整图像色彩，对比度和亮度。
                <br /><br /><code>c_fill,h_380,w_380,e_improve</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><b>sepia</b></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_sepia/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780521&Signature=eHWgaDcKYk7VfNkAjg1rxsrRLQc%3D" /></td>
            <td>
                增加褐色，实现老照片效果
                <br /><br /><code>c_fill,h_380,w_380,e_sepia</code>     
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>sepia:60</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_sepia%3A60/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780543&Signature=Hv9AAamVUxQwOuhKTT0pR5k8ITs%3D" /></td>
            <td>
                增加褐色，实现老照片效果，并指定一个level值为60。取值范围1到100，默认值为80。
                <br /><br /><code>c_fill,h_380,w_380,e_sepia:60</code>    
            </td>

        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>red:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_red%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780562&Signature=wH%2FQSVXJ3WA6hYEhMcS34mAJzx8%3D" /></td>
            <td>
                增加红色
                <br /><br /><code>c_fill,h_380,w_380,e_red:40</code>     
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>green:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_green%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780575&Signature=dvXP0ufzgn2lLrMGcrCpV7cRqjM%3D" /></td>
            <td>
                增加绿色
                <br /><br /><code>c_fill,h_380,w_380,e_green:40</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>blue:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_blue%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780588&Signature=W0qO6qxutxohHyAkAOXXjSbEsn0%3D" /></td>
            <td>
                增加蓝色
                <br /><br /><code>c_fill,h_380,w_380,e_blue:40</code>    
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>yellow:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_yellow%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780602&Signature=BS29Zm2sH3VXT4N8l3bHZIT8xuA%3D" /></td>
            <td>
                增加黄色
                <br /><br /><code>c_fill,h_380,w_380,e_yellow:40</code>     
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>cyan:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_cyan%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780616&Signature=pXDGPEPPl6xQvxIdcYcPQUToZJI%3D" /></td>
            <td>
                增加青色
                <br /><br /><code>c_fill,h_380,w_380,e_cyan:40</code>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>magenta:40</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_380,w_380,e_magenta%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780628&Signature=tHkwP66w96NAZh1FBpwC9fj3cmc%3D" /></td>
            <td>
                增加粉色
                <br /><br /><code>c_fill,h_380,w_380,e_magenta:40</code>    
            </td>
        </tr>
    </tbody>

    <thead>
        <tr>
            <th>opacity</th>
            <th><b>o</b></th>
            <th><i>百分比</i></th>
            <th></th>
            <th>控制PNG或者WEBP格式图片不透明度。最小值为1，最大值为100。</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>25</i></td>
            <td><img src="http://imgx-test.heheapp.com/h_330,w_330,o_25/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780646&Signature=PLo6%2BUYr%2FQ9tP6ksUXUnXS8CESU%3D" /></td>
            <td>
                不透明度为25%
                <br /><br /><code>h_330,w_330,o_25</code>      
            </td>
        </tr>
    </tbody>

    <thead>
        <tr>
            <th>border</th>
            <th><b>bo</b></th>
            <th><i>style</i></th>
            <th></th>
            <th>设置边框</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>10_0000004a</i></td>
            <td><img src="http://imgx-test.heheapp.com/h_330,w_330,bo_10_0000004a/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780667&Signature=21asF6rN41wa8ezER4xY5G1TVDw%3D" /></td>
            <td>
                设置一个边框宽度为10px，颜色值为黑色，透明度为4a（16进制）
                <br /><br /><code>h_330,w_330,bo_10_0000004a</code>     
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>8_bbbbbb</i></td>
            <td><img src="http://imgx-test.heheapp.com/h_330,w_330,bo_8_bbbbbb,r_100/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780686&Signature=tFi1iqhNnyIuuT4jnTYodEn%2FtQw%3D" /></td>
            <td>
                对圆角图像设置一个边框宽度为8px，颜色值为bbbbbb
                <br /><br /><code>h_330,w_330,bo_8_bbbbbb,r_100</code>      
            </td>
        </tr>
    </tbody>

    <thead>
        <tr>
            <th>background</th>
            <th><b>b</b></th>
            <th><i>color</i></th>
            <th></th>
            <th>设置背景颜色，配合其他指令</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>dddddd</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_pad,w_380,h_180,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780701&Signature=o6fomfZsrB%2B1GhgR%2BlXPDFxDocs%3D" /></td>
            <td>
                设置背景颜色为dddddd
                <br /><br /><code>c_pad,w_380,h_180,b_dddddd</code>      
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>fff6def0</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_110,w_110,a_30,b_fff6def0/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780715&Signature=MysQeT9UxGIMAMXMqW7hlzXwF0k%3D" /></td>
            <td>
                设置背景颜色为fff6de，透明度为f0 (16进制)
                <br /><br /><code>c_fill,h_110,w_110,a_30,b_fff6def0</code>    
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>dbeced</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,h_140,w_140,r_max,b_dbeced--c_lpad,g_center,w_152,h_152,b_dbeced/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780729&Signature=%2BhTugtDL8OCzDgyR95YJ3R9DniI%3D" /></td>
            <td>
                设置背景颜色为dddddd
                <br /><br /><code>c_fill,h_140,w_140,r_max,<br>b_dbeced--c_lpad,g_center,<br>w_152,h_152,b_dbeced</code>    
            </td>
        </tr>
    </tbody>


    <thead>
        <tr>
            <th>overlay</th>
            <th><b>l</b></th>
            <th><i>水印图片名，或者字体描述文件名称等</i></th>
            <th></th>
            <th>在原图上增加水印。您可以配合w，h，x，y和重力参数控制水印的尺寸和位置，还可以使用o参数控制水印的透明度</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>superman</i></td>
            <td><img src="http://imgx-test.heheapp.com/c_fill,w_500,h_500,g_face,f_png--l_superman,g_south_east,w_250,x_-120,y_-60--l_bs_logo,x_20,y_20/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464835936&Signature=VntmQ1EndLDbBb4wiG3ofN7TdcI%3D" /></td>
            <td>
                在图片的右下角加一个方脸超人的水印（支持外部区域）；首先需要将水印贴图（必须是png格式）保存到您的对应bucket下，路径规则为：imgx/l/my_name.png，然后您可以使用l_my_name指令进行水印操作了
                <br /><br /><code>c_fill,w_500,h_500,g_face,<br>
                f_png--l_superman,g_south_east,<br>
                w_250,x_-120,y_-60--l_scs_logo,x_20,y_20</code>    
            </td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>text:font_me:你好，白山云</i></td>
            <td><img src="http://imgx-test.heheapp.com/l_text:font_me:%E4%BD%A0%E5%A5%BD%EF%BC%8C%E7%99%BD%E5%B1%B1%E4%BA%91,g_north_east,x_14,y_14--w_400/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464846517&Signature=8wPZnmR4kfFStvjXBGBQ%2B21j03M%3D" /></td>
            <td>
                文字水印。关于字体样式的设置后面会详细介绍。
                <br /><br /><code>l_text:font_me:你好，白山云,<br>
                g_north_east,x_14,y_14--w_400</code>
            </td>
        </tr>
    </tbody>


    <thead>
        <tr>
            <th>format</th>
            <th><b>f</b></th>
            <th><i>图片格式</i></th>
            <th></th>
            <th>图片格式转</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>png</i></td>
            <td></td>
            <td><code>f_png</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>webp</i></td>
            <td></td>
            <td><code>f_webp</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>jpeg</i></td>
            <td></td>
            <td><code>f_jpeg</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>jpg</i></td>
            <td></td>
            <td><code>f_jpg</code></td>
        </tr>
    </tbody>


    <thead>
        <tr>
            <th>version</th>
            <th><b>v</b></th>
            <th><i>版本</i></th>
            <th></th>
            <th>缓存未过期的情况下指定版本重新生成图像</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>1.21</i></td>
            <td></td>
            <td>小数 <code>v_1.21</code></td>
        </tr>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>13</i></td>
            <td></td>
            <td>整数 <code>v_13</code></td>
        </tr>
    </tbody>

    <thead>
        <tr>
            <th>transformation</th>
            <th><b>t</b></th>
            <th><i>名称</i></th>
            <th></th>
            <th>"指令集"，指令可以不放到URL中，使用json格式的文件，保存到指定的路径下</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td><b></b></td>
            <td><i>my_thumbs</i></td>
            <td></td>
            <td>
                自定义名称，在对应的bucket下，创建文件：<i>imgx/t/my_thumbs.json</i>
                <br /><br /><code>t_my_thumbs</code>    
            </td>
        </tr>
    </tbody>

</table>


## 水印功能详细介绍

1. 水印分为：`图片水印` 和 `文字水印`；
2. 如果您使用了水印 `l` 指令，则和 `l` 一组的其他指令将针对 `水印图片或者文字` 进行处理（如：`w`、`h`、`g`、`x`、`y`、`o`、`bo`、`e`、`a`、`r`等），后面举例介绍。

### 图片水印

您需要预先将水印贴图保存到对应的bucket下 `imgx/l/<filename>.png`，图片必须是png格式，下面两张图为例：


<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr>
		    <th><i>水印贴图</i></th>
		    <th><i>对应路径</i></th>
		    <th><i>对应指令</i></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><img src="http://s2.i.qingcdn.com/imgx-test/imgx/l/icon_v.png?AWSAccessKeyId=acc_drdrxp&Expires=2464848305&Signature=xlPiRJyVFwdViWHgbsj5yiTYl%2Bk%3D" /></td>
            <td><i>imgx/l/icon_v.png</i></td>
            <td><code>l_icon_v</code></td>
        </tr>
        <tr>
            <td><img src="http://s2.i.qingcdn.com/imgx-test/imgx/l/bs_logo.png?AWSAccessKeyId=acc_drdrxp&Expires=2464848350&Signature=H37eufIimTWyx240GDCspIUzAQM%3D" /></td>
            <td><i>imgx/l/bs_logo.png</i></td>
            <td><code>l_bs_logo</code></td>
        </tr>
    </tbody>
</table>


下面举例介绍具体功能

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr>
		    <th width="300px"><i>示例</i></th>
		    <th><i>描述</i></th>
		    <th><i>指令</i></th>
        </tr>
    </thead>
    <tbody>
        <tr>
		    <td><img src="http://imgx-test.heheapp.com/c_fit,w_300,f_png--l_bs_logo,g_north_west,w_120,o_35,x_43,y_20,a_-10/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464848736&Signature=qgX3TgPxRhsDC55OYz0w2DKMLJ0%3D" /></td>
		    <td>
		        1. 将原图等比放缩；<br>
		        2. 添加一个图片水印到原图的左上角，并且微调坐标(x_43,y_20)，设置水印的宽度为120px，不透明度为35%，逆时针旋转水印10度
		    </td>
		    <td>
		        <code>c_fit,w_300,f_png--<br>
		        l_bs_logo,g_north_west,<br>
		        w_120,o_35,x_43,y_20,a_-10</code>
		    </td>
        </tr>
        <tr>
		    <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_icon_v,g_south_east,w_60,x_-1,y_-5/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464848557&Signature=ExulrCr%2BFC%2B%2BTeuHgpah7M%2FwzO0%3D" /></td>
		    <td>
		        1. 将原图处理成一个圆角头像；<br>
		        2. 在右下角添加一个水印图片，并且向外微调水印坐标(x_-1,y_-5)，设置水印图片的宽度为60px
		    </td>
		    <td>
		        <code>c_thumb,g_face,w_200,h_200,<br>
		        r_max,bo_6_ffffff80,f_png--l_icon_v,<br>
		        g_south_east,w_60,x_-1,y_-5</code>
		    </td>
        </tr>
        <tr>
		    <td><img src="http://imgx-test.heheapp.com/c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_icon_v,g_south_east,w_60,x_-1,y_-5,e_negate/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464848604&Signature=LyDMfwGhTgjUzfkoo6GGCRU3%2B1E%3D" /></td>
		    <td>
		        1. 同上<br>
		        2. 将水印图片反色
		    </td>
		    <td>
		        <code>c_thumb,g_face,w_200,h_200,<br>
		        r_max,bo_6_ffffff80,f_png--l_icon_v,<br>
		        g_south_east,w_60,x_-1,y_-5,e_negate</code>
		    </td>
        </tr>
    </tbody>
</table>


<br />

### 文字水印

您需要预先将文字水印的字体配置(json格式的文件)保存到对应的bucket下 `imgx/l/<file>.json`，例如：
```json
{
    "font_family" : "Xingkai SC",
    "font_style" : "bold",
    "font_size" : 30,
    "font_color" : "000000",
    "background" : "ff0000cc",
    "padding" : 10,
    "word_spacing" : 1,
    "kerning" : 1,
    "line_spacing" : 2,
    "pierced" : false,
    "tile" : false,
    "text" : "默认值",
}
```
对应路径：`imgx/l/my_font.json`

字体参数介绍

*所有参数非必填项*


<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr>
		    <th><i>参数名</i></th>
		    <th><i>介绍</i></th>
		    <th><i>默认值</i></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><b>font_family</b></td>
            <td>字体家族，我们支持的所有 <a href="#H2-字体 (font_family)">字体</a></td>
            <td>Songti SC</td>
        </tr>
        <tr>
            <td><b>font_style</b></td>
            <td>
                字体样式（如果字体本身支持以下样式才有效果，否则默认使用normal）：
                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;normal（常规）
                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>italic</i>（斜体）
                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>bold</b>（粗体）
                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;light（细体）
            </td>
            <td>normal</td>
        </tr>
        <tr>
            <td><b>font_size</b></td>
            <td>字号（单位：px）</td>
            <td>14</td>
        </tr>
        <tr>
            <td><b>font_color</b></td>
            <td>16进制rgba（前6为rgb，最后2位alpha，都是0到f），省略最后两位则认为不透明</td>
            <td>黑色(000000)</td>
        </tr>
        <tr>
            <td><b>background</b></td>
            <td>16进制rgba（前6为rgb，最后2位alpha，都是0到f），省略最后两位则认为不透明</td>
            <td>透明(ffffff00)</td>
        </tr>
        <tr>
            <td><b>padding</b></td>
            <td>文字周围填充的宽度（单位：px）</td>
            <td>6</td>
        </tr>
        <tr>
            <td><b>word_spacing</b></td>
            <td>词间距（单位：px）</td>
            <td>0</td>
        </tr>
        <tr>
            <td><b>kerning</b></td>
            <td>字间距（单位：px）</td>
            <td>0</td>
        </tr>
        <tr>
            <td><b>line_spacing</b></td>
            <td>行间距（单位：px）</td>
            <td>0</td>
        </tr>
        <tr>
            <td><b>pierced</b></td>
            <td>镂空字效果（bool值）</td>
            <td>false</td>
        </tr>
        <tr>
            <td><b>tile</b></td>
            <td>是否平铺（bool值）</td>
            <td>false</td>
        </tr>
        <tr>
            <td><b>text</b></td>
            <td>默认字符串</td>
            <td>空字符串</td>
        </tr>
    </tbody>
</table>


####示例1：
`imgx/l/simple_font.json` :
```json
{
    "font_family" : "Microsoft YaHei",
    "font_size" : 40,
    "font_color" : "ffffff"
}
```
一个最简单的文字水印
<img src="http://imgx-test.heheapp.com/w_800,f_png--l_text:simple_font:Hello+Bai+Shan%21%21,x_20,y_20,a_-25/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849050&Signature=dOMoCFXBKPQxLjJ0lunNxsoXT%2BA%3D">

指令：
```
w_800,f_png--l_text:simple_font:Hello+Bai+Shan!!,x_20,y_20,a_-25
```



####示例2：

`imgx/l/subtitles.json` :
```json
{
    "font_size" : 22,
    "font_color" : "ffffff"
}
```

`imgx/l/subtitles_s.json` :

```json
{
    "font_size" : 16,
    "font_color" : "ffffff"
}
```
咱们也搞一个大片效果, 应用到两张图上：
<img src="http://imgx-test.heheapp.com/f_png,c_fill,w_800,h_400,e_brightness:-8--c_pad,w_800,h_550,g_center,b_000000ff,e_yellow:30--l_text:subtitles:%E4%B8%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%8F%90%E4%BE%9B%E4%B8%80%E5%A5%97%E4%BA%91%E7%AB%AF%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86%E6%9C%8D%E5%8A%A1,g_south,y_100--l_text:subtitles_s:Imgx+is+the+image+back-end+for+web+and+mobile+developers,g_south,y_80/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849662&Signature=7Mw8D66XZsoYNWc7hzMmvQH9Wpg%3D">


指令：
```
f_png,c_fill,w_800,h_400,e_brightness:-8--c_pad,w_800,h_550,g_center,b_000000ff,e_yellow:30--l_text:subtitles:为开发者提供一套云端图片处理服务,g_south,y_100--l_text:subtitles_s:Imgx is the image back-end for web and mobile developers,g_south,y_80
```



####示例3：
`imgx/l/my_font.json` :
```json
{
    "font_family" : "Xingkai SC",
    "font_style" : "bold",
    "font_size" : 40,
    "font_color" : "000000",
    "background" : "ff0000cc",
    "padding" : 18
}
```
咱们做一个对联：
<img src="http://imgx-test.heheapp.com/w_800,f_png--l_text:my_font:%E9%A9%AC%E9%A9%B0%E5%A4%A7%E9%81%93%E5%BE%81%E9%80%94%E8%BF%9C,g_south_west,w_40,x_20,y_100--l_text:my_font:%E7%BE%8A%E4%B8%8A%E5%A5%87%E5%B3%B0%E6%99%AF%E8%89%B2%E5%A8%87,g_south_east,w_40,x_20,y_100--l_text:my_font:%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86,g_north,y_20/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849847&Signature=6clVRP9Jdg1szWrW7nI2jPjEI44%3D">

指令：
```
w_800,f_png--l_text:my_font:马驰大道征途远,g_south_west,w_40,x_20,y_100--l_text:my_font:羊上奇峰景色娇,g_south_east,w_40,x_20,y_100--l_text:my_font:图片处理,g_north,y_20
```


####示例4：
`imgx/l/font_me.json` :
```json
{
    "font_family": "Microsoft YaHei",
    "font_size": 30,
    "font_color": "ffffff",
    "font_style": "bold",
    "background": "0000008f",
    "pierced": true,
    "tile": false,
    "padding": 12,
    "word_spacing": 2.2,
    "line_spacing": 1.2,
    "kerning": 1.5
}
```
镂空字效果
<img src="http://imgx-test.heheapp.com/l_text:font_me:%E4%BD%A0%E5%A5%BD%EF%BC%8C%E7%99%BD%E5%B1%B1%E4%BA%91,g_north_west,x_20,y_20--w_800/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850225&Signature=Ogu7V1xUjeTvPA6Ml4%2B64kB02mM%3D">

指令：
```
l_text:font_me:你好，白山云,g_north_west,x_20,y_20--w_800
```


####示例5：
`imgx/l/tile.json` :
```json
{
    "font_family" : "Microsoft YaHei",
    "font_style" : "bold",
    "font_size" : 40,
    "font_color" : "000000",
    "background" : "ff000066",
    "padding" : 18,
    "tile": true
}
```
平铺效果
<img src="http://imgx-test.heheapp.com/w_800,f_png--l_text:tile:Hello+BaiShan%21%21,g_south/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850272&Signature=ZFRF%2F0HOsfQcdb3Y3N5%2FFxhE5jE%3D">

指令：
```
w_800,f_png--l_text:tile:Hello BaiShan!!,g_south
```


####示例6：
`imgx/l/badge.json` :
```json
{
	"font_style" : "bold",
	"font_size" : 30,
	"font_color" : "ffffff",
	"background" : "ff0000cc",
	"padding" : 15
}
```
增加一个badge(数字徽章)
<img src="http://imgx-test.heheapp.com/c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_text:badge:69,r_max,g_south_east,w_34,h_34,x_-1,y_-5/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850332&Signature=rREFYd6SQEtPdSu5JGFqGjRYxBQ%3D">

指令：
```
c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_text:badge:69,r_max,g_south_east,w_34,h_34,x_-1,y_-5
```





## 使用“指令集”

如果您不希望把指令暴露在URL中，很简单：

下面举例说明，自动识别照片上的人脸位置并做一张带有边框的圆形缩略图：

- 先创建一个json文件，保存到对应的bucket中：
路径： `imgx/t/avatar.json` ：
```json
[
    {
        "crop" : "thumb",
        "gravity" : "face:center",
        "width" : 200,
        "height" : 200,
        "radius" : "max",
        "border" : "6_ffffff80",
        "format" : "png"
    },
    {
        "overlay" : "icon_v",
        "gravity" : "south_east",
        "width" : 60,
        "x" : -1,
        "y" : -5
    }
]
```

- 通过下面的方式访问：

```
http://imgx.i.qingcdn.com/imgx-test/t_avatar/demo/1.jpg?<签名>
http://imgx.i.qingcdn.com/imgx-test/t_avatar/demo/3.jpg?<签名>
```

- 效果：
<img src="http://imgx-test.heheapp.com/t_avatar/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850497&Signature=iRB5cnXfQp5m9sVBSUSsZtL235s%3D">
<img src="http://imgx-test.heheapp.com/t_avatar/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850600&Signature=ZnUlYNjjaYmo9RCKJ5i2QG913G4%3D">
<img src="http://imgx-test.heheapp.com/t_avatar/avatar.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850684&Signature=8EmYZxvTsg5hMkiPBhA7Px37fyE%3D">
<img src="http://imgx-test.heheapp.com/t_avatar/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850768&Signature=Ms%2BM6jzw3KzUB2CjSZ3R8iH6ECY%3D">




## 字体 (font_family)

> 查询字体的API：http://imgx.i.qingcdn.com/fonts


  [1]: http://s2.i.qingcdn.com/imgx-test/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851871&Signature=9Nb4uSsCdGbdhYdL05QNJMBOUDI%3D
  [2]: http://s2.i.qingcdn.com/imgx-test/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464852096&Signature=krRDPWUXPGYWKaQ0FcrHOLh9w20=
  [3]: http://s2.i.qingcdn.com/imgx-test/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852128&Signature=UitAP/HXvS2T6Y9AAs7TGPJGwzU=
  [4]: http://s2.i.qingcdn.com/imgx-test/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852159&Signature=yvaPahyPoYUpLYaEE9br44JNAuw=
  [5]: http://s2.i.qingcdn.com/imgx-test/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852222&Signature=6TpoUspMxFaB5rnKT4VzhiaWcLg%3D
  [6]: http://s2.i.qingcdn.com/imgx-test/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852280&Signature=jxH/VEABVAiIEc3ZE7GYSrj6LAw=
  [7]: http://s2.i.qingcdn.com/imgx-test/avatar.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852327&Signature=47wCMMxlDj8lP4JMaZ99NXl50%2bE=
  [8]: http://s2.i.qingcdn.com/imgx-test/bsc_logo.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2470638306&Signature=M4FHkWtF%2FEz%2FDlu5ru5DOahuRtQ%3D
