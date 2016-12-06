

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