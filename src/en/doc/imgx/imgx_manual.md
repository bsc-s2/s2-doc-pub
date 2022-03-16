![](http://imgx-ss.bscstorage.com/imgx-test/w_300/bsc_logo.jpg?AWSAccessKeyId=acc_drdrxp&Expires=1504489369&Signature=hzOLDt69E94WpxQP69FEsvWJWbU%3D%)

# The Description of Imgx

# Tag： Image process Imgx BaishanCloud Cloud Storage
---
## URL Format
```
[http://imgx-ss.bscstorage.com/<bucket>/ <processing](http://imgx-ss.bscstorage.com/%3cbucket%3e/%20%3cprocessing) instruction>/<the File path>?<Signature>
```
OR
```
[http://<bucket>.imgx-ss.bscstorage.com/<processing]() instruction>/<The File path>?<Signature>
```

- `bucket`: Your bucket name in Baishan Cloud storage. 
- `Processing Instruction`: The processing instruction for the original image. There are some detailed instructions below.
- `文件路径`: The storage path of the original image.
- `Signature`: The main parameters of the Signature.



## Example
Example: The URL of the original image is http://ss.bscstorage.com/imgx-test/demo/1.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=2464773061&Signature=jFVHRSrOLeg5e3nIR00UE2vik0A%3D
It shows

` `- The bucket name is imgx-test
` `- The storage path of the bucket is demo/1.jpg

Operations:

` `- Crop the face area and shorten the image to 400x400 - `c_
thumb,g_
face,w_
400,h_
400`
` `- Turn the image into a rounded corner with the maximum radius (perfect circle) - `r_
max`
` `- Increase the brightness of the image by 8%`e_
brightness - 8`
` `- Convert the image format to PNG - `f_
png`

The Processing Instruction: `c_
thumb,g_
face,w_
400,h_
400,r_
max,e_
brightness:8,f_
png`
We can access it directly through the URL as below
```
http://imgx-ss.bscstorage.com/imgx-test/c_
thumb,g_
face,w_
400,h_
400,r_
max,e_
brightness%3A8,f_
png/demo/1.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=2464773122&Signature=4cwxt1e%2Fg2NL1OfsldaVsa8SD9s%3D
```
OR
```
http://imgx-test.imgx-ss.bscstorage.com/c_
thumb,g_
face,w_
400,h_
400,r_
max,e_
brightness%3A8,f_
png/demo/1.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=2464773122&Signature=4cwxt1e%2Fg2NL1OfsldaVsa8SD9s%3D
```
Or you could create a Jason file if you do not want to expose the processing instruction in the URL. 
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
Save the File to the path which belongs to your bucket. 
```
<p>imgx/cmd_
template/my_
thumb.json    </p><p>#The ‘my_
thumb’ is a custom name by yourself.</p>
```
Then the user could access it through the below URL which means the processing instruction can be hidden to the Jason File. 
```
http://imgx-ss.bscstorage.com/imgx-test/t_
my_
thumb/demo/1.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=2464773563&Signature=WIMaNLacGaPRAlA6fl%2BGAsStfoQ%3D
```




## Processing Format

- The connection between the Processing name and the Processing value is ‘_’ such as `c_fit`.
- Related instructions are separated by commas such as `c_
fit,w_100,h_100,g_face`.
- Different instructions are separated by ‘--’, such as `c_
fit,w_100,h_100,g_face,r_max--l_text:my_font:hello+word,w_100,h_40`



## Signature

To protect your original image from theft and processing instructions from malicious abuse, signature protection must be used here. The signature form is fully compatible with AWS V2 authentication. The following provides a PHP function to generate the URL of the generation signature:  

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
function getAuthenticatedURL($accessKey, $secretKey, $bucket, $uri, $lifetime, $hostBucket = false, $https = false, $endpoint = 'imgx-ss.bscstorage.com') {

$expires = time() + $lifetime;
$uri = str_
replace(array('%2F', '%2B', '%2C', '%3A', '%20'), array('/', '+', ',', ':', '+'), rawurlencode($uri));
return sprintf(($https ? 'https' : 'http').'://%s/%s?AWSAccessKeyId=%s&Expires=%u&Signature=%s',
$hostBucket ? $bucket : $endpoint.'/'.$bucket, $uri, $accessKey, $expires,
urlencode(base64_
encode(hash_
hmac('sha1', "GET\n\n\n{$expires}\n/{$bucket}/{$uri}", $secretKey, true))));
}
//The usage method
echo getAuthenticatedURL('your accessKey', 'your secretKey', 'your bucket', 'the processing instruction/the File path', 'the Expired time (s)');
# We recommend to set the value of $lifetime more longer, such as 1000000000.
```

## Cache & CDN

- The cached will be generated automatically after processing the image and the same request will not be generated. The default expired time is 2 days.
- If the user configures the CDN address, the processed image will be automatically sent to the distributed nodes.


## The Processing Instructions

> The processing instructions are introduced below, and the following original pictures are used as examples for your comparison.
>1. [demo/charles.png][1]
>2. [demo/1.jpg][2]
>3. [demo/3.png][3]
>4. [demo/4.png][4]
>5. [demo/sheep.png][5]
>6. [demo/horses.png][6]
>7. [avatar.png][7]


<table>
<thead>
<tr>
<th width="57px"><i>Processing instruction name</i></th>
<th width="46px"><i>processing instruction</i></th>
<th width="130px"><i>Value</i></th>
<th width="386px"><i>example</i></th>
<th width="186px"><i>Description</i></th>
</tr>
<tr>
<th>crop</th>
<th><b>c</b></th>
<th><i>mode</i></th>
<th></th>
            <th> Clipping mode, which specifies how the image is clipped or scaled</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><b>scale</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_
scale,h_
80,w_
80/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775245&Signature=U8cS78xlQH0EZArL2WJMZx9mHNY%3D" /></td>
<td>Changes the size of the image to match the expected width and height. All parts of the original image will be visible but maybe stretched out of shape.  
<br /><br /><code>c_scale,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>fill</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_
fill,h_
80,w_
80/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775280&Signature=3%2ByB4vbW4XesbrNCssGY7LexDhU%3D" /></td>
<td>Crop the image while retaining its original proportions
<br /><br /><code>c_fill,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>lfill</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_lfill,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775301&Signature=cFPJah0EXgrFkV%2F%2B1KjE5vedmHo%3D" /></td>
<td>The mode is the same as <i>fill</i>, but the difference is to limit the size of the image to no larger than the original.
<br /><br /><code>c_lfill,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>fit</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775325&Signature=dzwxaEl%2FTA2qsDSGfcv%2FG5Gs9%2F8%3D" /></td>
<td>Change the size of the image to match the expected width and height, while retaining the original proportions, and all parts of the original image will be visible.  Equal scale shrinkage, no deformation due to stretching. 
<br /><br /><code>c_fit,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>mfit</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_mfit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775342&Signature=yEhC4KixIMt4RrtnKMpN%2F9jp4CM%3D" /></td>
<td>The mode is the same as <i>fit</i>, but the difference is to limit the size of the image to no less than the original.
<br /><br /><code>c_mfit,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>limit</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_limit,h_80,w_80/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775503&Signature=ne3LQQQl92ExCHy3LAUM3m9jMo4%3D" /></td>
<td>The mode is the same as <i>fit</i>, but the difference is that the image size after processing will not exceed the original image. 
<br /><br /><code>c_limit,h_80,w_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>pad</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_pad,h_80,w_80,g_center,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775599&Signature=pEv4icz3BrvbkjvTQHAOXce3Tvo%3D" /></td>
<td>Specifies the size of the image while retaining the original scale.  If the original scale does not meet the specified size, it will be filled with a background color. 
<br /><br /><code>c_pad,h_80,w_80,g_center,b_dddddd</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>lpad</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_
lpad,h_
640,w_
640,g_
center,b_
dddddd/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775619&Signature=ZY8kJ8xsAo4lTbcyY8unWndaKEI%3D" /></td>
<td>The mode is the same as <i>pad</i>, but the difference is that if the size specified is larger than the original, the original will not be enlarged.
<br /><br /><code>c_lpad,h_640,w_640,g_center,b_dddddd</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>mpad</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_mpad,h_80,w_80,g_center,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775641&Signature=e5eohM2MOtqMsXCUKOmRop2iQIE%3D" /></td>
<td>The mode is the same as <i>pad</i> , but the difference is to limit the size of the image to no less than the original. 
<br /><br /><code>c_mpad,h_,w_80,g_center,b_
dddddd</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>crop</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,h_210,w_210,g_face/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775755&Signature=QkEGM0VA2nhfOQ3JlvWCAfsGiFw%3D" /></td>
<td>Specifies the size and position used to crop out a portion from the original image.
<br /><br /><code>c_crop,h_210,w_210,g_face</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>thumb</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,h_250,w_250,g_face/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464775849&Signature=%2FVEIEuisY%2FNYzT52s2P%2BnIwe8Mk%3D" /></td>
<td>To locate the face (combined with the 'face' or 'faces' gravity parameters) and generate a thumbnail image, often used to generate an avatar.
<br /><br /><code>c_thumb,h_250,w_250,g_face</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>width</th>
<th><b>w</b></th>
<th><i> Pixels or percentages </i></th>
<th></th>
<th> width parameter, use with <i>crop</i> or <i>overlay</i> </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>80</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/w_
80/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775890&Signature=3O7sB36S5fxARIRIXma0EDwrUM0%3D" /></td>
<td> Adjust the width to 80 pixels
<br /><br /><code>w_
80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>0.1</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/w_
0.1/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775909&Signature=UGZpnvF3kXfVN9JlYsKq4J1DMcc%3D" /></td>
<td>Adjust the image to 10% of its original size.
<br /><br /><code>w_0.1</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>height</th>
<th><b>h</b></th>
<th><i> Pixels or percentages </i></th>
<th></th>
<th> Height parameter, Use with <i>crop</i> or <i>overlay</i></th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>80</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/h_
80/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775931&Signature=iZkes%2BXqVFnIUa3AR5vIRugTcy8%3D" /></td>
<td>Adjust the height to 80 pixels
<br /><br /><code>h_80</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>0.1</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/h_
0.1/demo/charles.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464775993&Signature=kppwJvaUOgNOacxgOX7pZCMwDDs%3D" /></td>
<td>Adjust the image to 10% of its original size
<br /><br /><code>h_0.1</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>gravity</th>
<th><b>g</b></th>
<th><i>To specify a position or direction</i></th>
<th></th>
<th>1. Use <i>'crop', 'pad', 'fill'</i> to specify clipping mode； <br>2. Use to specify the <i>overlay</i> position</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><b>north_west</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_north_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778155&Signature=UExeDYZxS7Wf2J1nMK4KTwtPIyU%3D" /></td>
<td>Upper left position
<br /><br /><code>c_crop,g_north_west,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>north</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_north,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778249&Signature=plyAm8ZvqawOF3ohDLxCLsmpUQc%3D" /></td>
<td>Straight up, horizontally centered
<br /><br /><code>c_crop,g_north,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>north_east</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_north_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778268&Signature=O%2FtX9DTxsjLpF7Q3cJagA8o3l9Y%3D" /></td>
<td>Upper Right position
<br /><br /><code>c_crop,g_north_east,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>west</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778292&Signature=eFTNVmXxhn9hScGUWcpmwnx%2Fkio%3D" /></td>
<td>On the left, vertically centered
<br /><br /><code>c_crop,g_west,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>center</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_center,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778308&Signature=M%2FTeVwmYdINeqp4%2BxxAYMe452g0%3D" /></td>
<td>The middle
<br /><br /><code>c_crop,g_center,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>east</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778324&Signature=Qb1%2BDyldQ%2FOxx7JJmdQz%2Bglrark%3D" /></td>
<td>On the right, vertically centered
<br /><br /><code>c_crop,g_east,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>south_west</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_south_west,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778343&Signature=AsJdVwQgL7obQ3lGfKF0RDOHrmM%3D" /></td>
<td>Lower left position
<br /><br /><code>c_crop,g_south_west,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>south</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_south,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778363&Signature=ImwO39IKfypIoAB442JWj9ogq%2Fg%3D" /></td>
<td>Straight down, horizontally centered
<br /><br /><code>c_crop,g_south,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>south_east</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_south_east,h_200,w_200/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778397&Signature=sKbISWjFnnsu5B6UrnrmNTEe%2FZo%3D" /></td>
<td>Lower right position
<br /><br /><code>c_crop,g_south_east,h_200,w_200</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>xy_center</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_xy_center,h_400,w_400,x_245,y_240/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778421&Signature=iWwhFozXKF5m8CO5qhpYT6bcJP8%3D" /></td>
<td>The Specified x,y coordinates, and as the center point
<br /><br /><code>c_crop,g_xy_center,<br>
h_400,w_400,x_245,y_240</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>face</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,g_face,h_140,w_140/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464778446&Signature=AwK%2BJlJi%2FWMa5m8TDQiqn3z97As%3D" /></td>
<td>Automatically locate the face if there are multiple faces, choose the one that is easiest to recognize.
<br /><br /><code>c_crop,g_face,h_140,w_140</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td>face (thumb)</td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,h_130,w_140,f_png/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464778466&Signature=qSOky2UqHn3tgrQU2bE0BZEjrM8%3D" /></td>
<td>Automatically locate the position of the face and generate thumbnails according to the specified size. If there are multiple faces, choose the one that is easiest to recognize.
<br /><br /><code>c_thumb,g_face,h_130,w_140,f_png</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>faces</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_faces,h_220,w_600,e_brightness%3A18/demo/3.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464779681&Signature=WjBH1Jz2AhdWlQno%2BieOONMHjfk%3D" /></td>
<td>Automatically located the position of the multiple faces
<br /><br /><code>c_thumb,g_faces,h_220,w_600,<br>
e_brightness:18</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>face:center</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face%3Acenter,h_140,w_140/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779711&Signature=IpqPP16HCxCoPEZRTb%2BPAwh9bfw%3D" /></td>
<td>Automatic to locate the location of the face, if you cannot find the face is automatically positioned to the center of the original picture.
<br /><br /><code>c_thumb,g_face:center,h_140,w_140</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>faces:center</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_faces%3Acenter,h_120,w_330,e_brightness%3A18/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779729&Signature=MpE5J2LsxhCu1K5%2FB2h9i%2F8VZXA%3D" /></td>
<td>Automatic positioning to the location of multiple faces, if the face cannot be found automatically positioning to the center of the original picture.
<br /><br /><code>c_thumb,g_faces:center,<br>
h_120,w_330,e_brightness:18</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>x</th>
<th><b>x</b></th>
<th><i>Pixels</i></th>
<th></th>
<th>Use to specify the horizontal coordinates of a cropping or watermark image </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>110</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,h_180,w_180,x_110/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851108&Signature=qkUt0EBiRH1hL%2FdTSbS%2BvbdS060%3D" /></td>
<td>Crop the image at 180x180 pixels, starting at 110 pixels on the left
<br /><br /><code>c_crop,h_180,w_180,x_110</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>y</th>
<th><b>y</b></th>
<th><i>Pixels</i></th>
<th></th>
<th>To Specify the vertical coordinates of a cropping or watermark image</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>230</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_crop,h_180,w_180,x_180,y_230/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851257&Signature=KbWMmZBansdeH7ELNlGu0yIqbXo%3D" /></td>
<td>Crop the image at 180x180 pixels, starting at 230 pixels at the top
<br /><br /><code>c_crop,h_180,w_180,x_180,y_230</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>quality</th>
<th><b>q</b></th>
<th><i> percentage</i></th>
<th></th>
<th> Controls the compression quality of JPG or WEBP images.  The minimum value is 1 and the maximum value is 100</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>100</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,h_130,w_140,q_100/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779812&Signature=AgnTF%2BLL6kJCwfQsqxvZrRmaXzk%3D" /></td>
<td> Image quality is 100% and file size is 14.3KB
<br /><br /><code>c_thumb,g_face,h_130,w_140,q_100</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>10</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,h_130,w_140,q_10/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779833&Signature=ngDnb0IJts9p8tlLPAmkI9uK9zk%3D" /></td>
<td>Image quality is 10% and file size is reduced to 1.5KB
<br /><br /><code>c_thumb,g_face,h_130,w_140,q_10</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>radius</th>
<th><b>r</b></th>
<th><i> Pixel or 'Max'</i></th>
<th></th>
<th>## Specifies radius, generates rounded corners or becomes completely round (oval)</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>30</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,h_140,w_140,f_png,r_30/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779854&Signature=3gVOrVBxma72lG0RRCd%2BrbVzbVY%3D" /></td>
<td>Generates rounded corners with a radius of 30 pixels
<br /><br /><code>c_thumb,g_face,h_140,w_140,f_png,r_30</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>max</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,h_140,w_140,f_png,r_max/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464779872&Signature=bLoCnVoXjhycDcmBssoC185tyLY%3D" /></td>
<td>Use the maximum radius to generate rounded corners
<br /><br /><code>c_thumb,g_face,h_140,w_140,f_png,r_max</code></td>
</tr>
</tbody>
<thead>
<tr>
<th>angle</th>
<th><b>a</b></th>
<th><i> Angle or flip mode</i></th>
<th></th>
<th> Flip or rotate the image </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>90</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_80,w_80,a_90/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779895&Signature=9tqwZW7SthjhR2dm950jAn9ZjDI%3D" /></td>
<td> Rotate 90 degrees clockwise
<br /><br /><code>c_fill,h_80,w_80,a_90</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>10</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_80,w_80,a_10/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779911&Signature=zwPmqKWWUZj9D4gPqnWfWscy8F8%3D" /></td>
<td> Rotate 10 degrees clockwise
<br /><br /><code>c_fill,h_80,w_80,a_10</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>-20</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_80,w_80,a_-20/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779926&Signature=eE1xWIAlkx4XZAnQ2ww6P8bAVPM%3D" /></td>
<td> Rotate 20 degrees counterclockwise
<br /><br /><code>c_fill,h_80,w_80,a_-20</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>vflip</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_80,w_80,a_vflip/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779944&Signature=%2Bca1r1SJSn%2Bs9ocufpuBDty1LeA%3D" /></td>
<td> flip vertical
<br /><br /><code>c_fill,h_80,w_80,a_vflip</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>hflip</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_80,w_80,a_hflip/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779960&Signature=2hSuIkpVhahTCyV53W27sxFXu3E%3D" /></td>
<td> flip horizontal
<br /><br /><code>c_fill,h_80,w_80,a_hflip</code></td>
</tr>
</tbody>

<thead>
<tr>
<th>effect</th>
<th><b>e</b></th>
<th><i>name and value</i></th>
<th></th>
<th> Use filters or special effects </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><b>grayscale</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_grayscale/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464779995&Signature=szrfdWnBYaDbF9mDpEYYQSmHjvc%3D" /></td>
<td> gray level
<br /><br /><code>c_fill,h_380,w_380,e_grayscale</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>oil_
paint</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_oil_paint/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780024&Signature=Qq%2Fn2GdugVX2E91mKFi2OBl%2FQzA%3D" /></td>
<td> Canvas effect
<br /><br /><code>c_fill,h_380,w_380,e_oil_paint</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>oil_paint:2</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_oil_paint%3A2/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780041&Signature=8cfjtMELUFb0ABNn55M2Zdj%2FEj4%3D" /></td>
<td>
Use the oil painting effect and specify a level value of 2. The value ranges from 1 to 8. The default value is 4  
<br /><br /><code>c_fill,h_380,w_380,e_oil_paint:2</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>negate</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_negate%3A2/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780058&Signature=3qG45TiVOSNwQom%2FpCRANKTFQbY%3D" /></td>
<td>
reverse color
<br /><br /><code>c_fill,h_380,w_380,e_negate:2</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>brightness:28</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_brightness%3A28/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780075&Signature=PjBqfmVBGLYq5K65Rj95MYLjomg%3D" /></td>
<td>
Adjust the brightness of the image and specify a percentage value of 28. The value ranges from -100 to 100. The default value is 30.
<br /><br /><code>c_fill,h_380,w_380,e_brightness:28</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>brightness:-28</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_brightness%3A-20/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780093&Signature=MDGQX78ccpE0nYpSt3s0YFSftqE%3D" /></td>
<td>
Adjust the brightness of the image and specify a percentage value of -20. The value ranges from -100 to 100. The default value is 30.
<br /><br /><code>c_fill,h_380,w_380,e_brightness:-20</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>blur</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_blur/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780111&Signature=kZHLSOF2dZDUr%2B6%2F5I7qVYg2qbc%3D" /></td>
<td>
blur effect
<br /><br /><code>c_fill,h_380,w_380,e_blur</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>blur:300</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_blur%3A300/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780133&Signature=1TqlkiM8qhIIGUCCbIihSJtoTDA%3D" /></td>
<td>
Use the blur effect and specify a level value of 300. The value ranges from 1 to 2000. The default value is 100.
<br /><br /><code>c_fill,h_380,w_380,e_blur:300</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>pixelate</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_pixelate%3A20/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780147&Signature=CiVrSg5tbpF0S3kWamgfbvKkPsQ%3D" /></td>
<td>
pixelate
<br /><br /><code>c_fill,h_380,w_380,e_pixelate:20</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>pixelate:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_pixelate%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780426&Signature=hjoTMD2jgmLPydz5NF5NnaNlauw%3D" /></td>
<td>
Use the pixelated effect and specify a level value of 40. The default value is 5.
<br /><br /><code>c_fill,h_380,w_380,e_pixelate:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>sharpen</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_sharpen/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780445&Signature=hPVzAXcdvlZX3LqDk%2Bw8bYOV%2BwE%3D" /></td>
<td>
Sharpen
<br /><br /><code>c_fill,h_380,w_380,e_sharpen</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>sharpen:400</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_sharpen%3A400/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780462&Signature=bfGlfc%2Fbm6bfdO7lWcRgj6L8Xyw%3D" /></td>
<td>
Use sharpening and specify a level value of 400. The value ranges from 1 to 2000. The default value is 100.
<br /><br /><code>c_fill,h_380,w_380,e_sharpen:400</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>auto_
contrast</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_auto_contrast/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780485&Signature=85x57KcbBgtTMLvSqag4y4yElKY%3D" /></td>
<td>
Auto Contrast
<br /><br /><code>c_fill,h_380,w_380,e_auto_contrast</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>improve</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_improve/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780504&Signature=NYmzvR%2BtSDeNbfpe%2FWDa92AjHtA%3D" /></td>
<td>
Automatically adjust the image color, contrast, and brightness
<br /><br /><code>c_fill,h_380,w_380,e_improve</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><b>sepia</b></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_sepia/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780521&Signature=eHWgaDcKYk7VfNkAjg1rxsrRLQc%3D" /></td>
<td>
Add brown to achieve the old photo effect
<br /><br /><code>c_fill,h_380,w_380,e_sepia</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>sepia:60</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_sepia%3A60/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780543&Signature=Hv9AAamVUxQwOuhKTT0pR5k8ITs%3D" /></td>
<td>
Add brown to achieve the old photo effect and specify a level value of 60. The value ranges from 1 to 100. The default value is 80.
<br /><br /><code>c_fill,h_380,w_380,e_sepia:60</code>
</td>

<tr>
<td></td>
<td><b></b></td>
<td><i>red:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_red%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780562&Signature=wH%2FQSVXJ3WA6hYEhMcS34mAJzx8%3D" /></td>
<td>
Add Red
<br /><br /><code>c_fill,h_380,w_380,e_red:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>green:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_green%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780575&Signature=dvXP0ufzgn2lLrMGcrCpV7cRqjM%3D" /></td>
<td>
Add Green
<br /><br /><code>c_fill,h_380,w_380,e_green:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>blue:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_blue%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780588&Signature=W0qO6qxutxohHyAkAOXXjSbEsn0%3D" /></td>
<td>
Add Blue
<br /><br /><code>c_fill,h_380,w_380,e_blue:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>yellow:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_yellow%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780602&Signature=BS29Zm2sH3VXT4N8l3bHZIT8xuA%3D" /></td>
<td>
Add Yellow
<br /><br /><code>c_fill,h_380,w_380,e_yellow:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>cyan:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_cyan%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780616&Signature=pXDGPEPPl6xQvxIdcYcPQUToZJI%3D" /></td>
<td>
Add Brown
<br /><br /><code>c_fill,h_380,w_380,e_cyan:40</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>magenta:40</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_380,w_380,e_magenta%3A40/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780628&Signature=tHkwP66w96NAZh1FBpwC9fj3cmc%3D" /></td>
<td>
Add Pink
<br /><br /><code>c_fill,h_380,w_380,e_magenta:40</code>
</td>
</tr>
</tbody>

<thead>
<tr>
<th>opacity</th>
<th><b>o</b></th>
<th><i>Percentage</i></th>
<th></th>
<th> Controls the opacity of PNG or WEBP images. The minimum value is 1 and the maximum value is 100 </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>25</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/h_330,w_330,o_25/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780646&Signature=PLo6%2BUYr%2FQ9tP6ksUXUnXS8CESU%3D" /></td>
<td>
The Opacity is 25%
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
<th> set Border</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>10_
0000004a</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/h_330,w_330,bo_10_0000004a/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780667&Signature=21asF6rN41wa8ezER4xY5G1TVDw%3D" /></td>
<td>
Set a border width to 10px, color to black, and opacity to 4A (hexadecimal).  
<br /><br /><code>h_330,w_330,bo_10_0000004a</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>8_bbbbbb</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/h_330,w_330,bo_8_bbbbbb,r_100/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780686&Signature=tFi1iqhNnyIuuT4jnTYodEn%2FtQw%3D" /></td>
<td>
Set a border width of 8px and a color value of bbbbbb for the rounded image  
<br /><br /><code>h_330,w_330,bo_8_bbbbbb,r_
100</code>
</td>
</tr>
</tbody>

<thead>
<tr>
<th>background</th>
<th><b>b</b></th>
<th><i>color</i></th>
<th></th>
<th> Set the background color with other commands</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>dddddd</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_pad,w_380,h_180,b_dddddd/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780701&Signature=o6fomfZsrB%2B1GhgR%2BlXPDFxDocs%3D" /></td>
<td>
Set the background color to the color value dddddd
<br /><br /><code>c_pad,w_380,h_180,b_dddddd</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>fff6def0</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_110,w_110,a_30,b_fff6def0/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780715&Signature=MysQeT9UxGIMAMXMqW7hlzXwF0k%3D" /></td>
<td>
Set the background color to fff6de and opacity to f0 (hexadecimal)
<br /><br /><code>c_fill,h_110,w_110,a_30,b_fff6def0</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>dbeced</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,h_140,w_140,r_max,b_dbeced--c_lpad,g_center,w_152,h_152,b_dbeced/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464780729&Signature=%2BhTugtDL8OCzDgyR95YJ3R9DniI%3D" /></td>
<td>
Set the background color to the color value dddddd
<br /><br /><code>c_fill,h_140,w_140,r_max,<br>b_dbeced--c_lpad,g_center,<br>w_152,h_152,b_dbeced</code>
</td>
</tr>
</tbody>


<thead>
<tr>
<th>overlay</th>
<th><b>l</b></th>
<th><i> Use watermark picture name, or use font to describe the file name, etc </i></th>
<th></th>
<th> Add a watermark to the original image. And you can use the W, H, X, Y ,and gravity parameters to control the size and position of the watermark, and the O parameter to control the transparency of the watermark.  </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>superman</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fill,w_500,h_500,g_face,f_png--l_superman,g_south_east,w_250,x_-120,y_-60--l_bs_logo,x_20,y_20/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464835936&Signature=VntmQ1EndLDbBb4wiG3ofN7TdcI%3D" /></td>
<td>
Add a watermark of square face superman in the bottom right corner of the image (support external area). Firstly, you need to save the watermark map (must be in PNG format) to your corresponding bucket, the File path is imgx/overlay/ myname.png, and then you can use the l_my_name command to do the watermark operation.
<br /><br /><code>c_fill,w_500,h_500,g_face,<br>
f_png--l_superman,g_south_east,<br>
w_250,x_-120,y_-60--l_scs_logo,x_20,y_20</code>
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>text:font_me:Hello, BaishanCloud</i></td>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/l_text:font_me:%E4%BD%A0%E5%A5%BD%EF%BC%8C%E7%99%BD%E5%B1%B1%E4%BA%91,g_north_east,x_
14,y_14--w_400/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464846517&Signature=8wPZnmR4kfFStvjXBGBQ%2B21j03M%3D" /></td>
<td>
Text watermark. More on font style Settings later
<br /><br /><code>l_text:font_me:Hello, BaishanCloud<br>
g_north_east,x_14,y_14--w_400</code>
</td>
</tr>
</tbody>


<thead>
<tr>
<th>format</th>
<th><b>f</b></th>
<th><i>Image Format</i></th>
<th></th>
<th> Image format transfer</th>
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
<th><i>Version</i></th>
<th></th>
<th> Specifies the version to regenerate the image if the cache has not expired</th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>1.21</i></td>
<td></td>
<td> decimal<code>v_1.21</code></td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>13</i></td>
<td></td>
<td> integer<code>v_
13</code></td>
</tr>
</tbody>

<thead>
<tr>
<th>transformation</th>
<th><b>t</b></th>
<th><i>Name</i></th>
<th></th>
<th>"Instruction set", the instructions can be saved to the specified path using jSON-formatted files instead of urls  </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>my_thumbs</i></td>
<td></td>
<td>
Custom Name. Under the corresponding bucket, create the file:<i>imgx/cmd_template/my_thumbs.json</i>
<br /><br /><code>t_my_thumbs</code>
</td>
</tr>
</tbody>
<thead>
<tr>
<th>information</th>
<th><b>i</b></th>
<th><i>information type</i></th>
<th></th>
<th> Retrieves picture information for the specified type </th>
</tr>
</thead>
<tbody>
<tr>
<td></td>
<td><b></b></td>
<td><i>exif</i></td>
<td>
<a href="http://imgx-ss.bscstorage.com/imgx-test/i_exif/info.jpg?AWSAccessKeyId=acc_drdrxp&Expires=1532134163&Signature=3wHpLeDk%2FZxTLodjQxiT5Lksc6w%3D">exif</a>
</td>
<td>
i_exif, Returns information about the image exif in JSON format
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>iptc</i></td>
<td>
<a href="http://imgx-ss.bscstorage.com/imgx-test/i_iptc/info.jpg?AWSAccessKeyId=acc_drdrxp&Expires=1532134979&Signature=pOoJof%2Fzjahvk5JrK7c9z2oMOq4%3D">iptc</a>
</td>
<td>
i_iptc, Returns the IPTC information of the image in JSON format
</td>
</tr>
<tr>
<td></td>
<td><b></b></td>
<td><i>all</i></td>
<td>
<a href="http://imgx-ss.bscstorage.com/imgx-test/i_all/info.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=1532135055&Signature=vsuwXraMZP7KmBql%2Bn1Y3G%2FpwVs%3D">all</a>
</td>
<td>
i_all, Returns all information about the image in JSON format
</td>
</tr>
</tbody>

</table>

## Access the image processing service by using AWS-SDK
<p>You can access the image processing service directly using the standard AWS-SDK.</p><p>Note: The IMGx service only accepts the standard 'get_
object' operation. All other operations are illegal.</p>

The following example code uses python boto3 sdk：

```
import boto3

s2_imgx_domain_name = 'http://imgx-ss.bscstorage.com'   # This example uses the three-copy cluster configuration, which needs to be adjusted based on different clusters.
s2_imgx_access_key = 'xxxxxx'                           # User own access key
s2_imgx_secret_key = 'xxxxxx'                           # User own secret key

imgx_cmd = 'c_scale,w_100,h_100' # Picture processing commands, refer to the picture processing instructions section.
imgx_bucket = 'my_imgx_bucket'   # The name of the user's bucket on the storage
imgx_key = 'my_img.jpg'          # The key name of the image that the user wants to manipulate.


# Create s2 client
imgx_cli = boto3.client('s3',
endpoint_url=s2_imgx_domain_name,
aws_access_key_id=s2_imgx_access_key,
aws_secret_access_key=s2_imgx_secret_key)

imgx_cmd_key = u'{cmd}/{key}'.format(cmd=imgx_cmd, key=imgx_
key) # As the Key on final access
resp = imgx_cli.get_object(Bucket=imgx_bucket, Key=imgx_
cmd_key)

print resp
```


## Instruction about the watermark function

1. WaterMark type: `picture watermarking` and `text watermarking`.
2. If you use the watermark `l` command, other instructions will be combined with `l` to process the `watermark image or text`（e.g. `w`、`h`、`g`、`x`、`y`、`o`、`bo`、`e`、`a`、`r`, etc.）

### Picture Watermark

You need to save the watermark texture to the corresponding bucket `imgx/overlay/<filename>.png` in advance. The image must be in png format. The following two images are examples.

<table class="table table-striped table-bordered table-condensed">
<thead>
<tr>
<th><i> watermark texture</i></th>
<th><i> corresponding path</i></th>
<th><i> corresponding command</i></th>
</tr>
</thead>
<tbody>
<tr>
<td><img src="http://ss.bscstorage.com/imgx-test/imgx/l/icon_
v.png?AWSAccessKeyId=acc_drdrxp&Expires=2464848305&Signature=xlPiRJyVFwdViWHgbsj5yiTYl%2Bk%3D" /></td>
<td><i>imgx/overlay/icon_v.png</i></td>
<td><code>l_icon_v</code></td>
</tr>
<tr>
<td><img src="http://ss.bscstorage.com/imgx-test/imgx/l/bs_
logo.png?AWSAccessKeyId=acc_
drdrxp&Expires=2464848350&Signature=H37eufIimTWyx240GDCspIUzAQM%3D" /></td>
<td><i>imgx/overlay/bs_logo.png</i></td>
<td><code>l_bs_logo</code></td>
</tr>
</tbody>
</table>


The following are examples of specific functions

<table class="table table-striped table-bordered table-condensed">
<thead>
<tr>
<th width="300px"><i>example</i></th>
<th><i>description</i></th>
<th><i>processing instruction</i></th>
</tr>
</thead>
<tbody>
<tr>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_fit,w_300,f_png--l_bs_logo,g_north_west,w_120,o_35,x_43,y_20,a_-10/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464848736&Signature=qgX3TgPxRhsDC55OYz0w2DKMLJ0%3D" /></td>
<td>
1. Scale the original image proportionally;<br>
2. Add an image watermark to the upper left corner of the original image, fine-tune the coordinates (x_43, y_20), set the width of the watermark to 120px, the opacity to 35%, and rotate the watermark 10 degrees counterclockwise.
</td>
<td>
<code>c_fit,w_300,f_png--<br>
l_bs_logo,g_north_west,<br>
w_120,o_35,x_43,y_20,a_-10</code>
</td>
</tr>
<tr>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_icon_v,g_south_east,w_60,x_
-1,y_-5/demo/1.jpg?AWSAccessKeyId=acc_
drdrxp&Expires=2464848557&Signature=ExulrCr%2BFC%2B%2BTeuHgpah7M%2FwzO0%3D" /></td>
<td>
1. Process the original image into a rounded avatar <br>
2. Add a watermark image in the lower right corner, fine-tune the watermark coordinates (x_-1, y_-5) outward, and set the width of the watermark image to 60px.
</td>
<td>
<code>c_thumb,g_face,w_200,h_200,<br>
r_max,bo_6_ffffff80,f_png--l_icon_v,<br>
g_south_east,w_60,x_-1,y_-5</code>
</td>
</tr>
<tr>
<td><img src="http://imgx-ss.bscstorage.com/imgx-test/c_
thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_icon_v,g_south_east,w_60,x_-1,y_-5,e_negate/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464848604&Signature=LyDMfwGhTgjUzfkoo6GGCRU3%2B1E%3D" /></td>
<td>
1. As above<br>
2. Invert the watermarked image
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

### Text Watermark

Please save the font configuration of the text watermark (json formatted file) to the corresponding bucket `imgx/overlay/<file>.json` in advance, for example,
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
"text" : "Default Value",
}
```
Corresponding path: `imgx/overlay/my_font.json`

Introduction of font parameters

*All parameters are not required*


<table class="table table-striped table-bordered table-condensed">
<thead>
<tr>
<th><i>parameter name</i></th>
<th><i>description</i></th>
<th><i>default value</i></th>
</tr>
</thead>
<tbody>
<tr>
<td><b>font_family</b></td>
<td> All <a href="#H2-font (font_
family)"> fonts we support</a></td>
<td>Songti SC</td>
</tr>
<tr>
<td><b>font_style</b></td>
<td>
Font style (only effective if the font itself supports the following styles, otherwise normal is used by default):
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;normal（normal）
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>italic</i>（italic face）
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>bold</b>（bold face）
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;light（light face type）
</td>
<td>normal</td>
</tr>
<tr>
<td><b>font_size</b></td>
<td> font size（px）</td>
<td>14</td>
</tr>
<tr>
<td><b>font_color</b></td>
<td>Hexadecimal rgba (the first 6 are rgb, the last 2 bits of alpha are 0 to f), if the last two digits are omitted, it is considered opaque </td>
<td>Black(000000)</td>
</tr>
<tr>
<td><b>background</b></td>
<td>16Hexadecimal rgba (the first 6 are rgb, the last 2 bits of alpha are 0 to f), if the last two digits are omitted, it is considered opaque </td>
<td>transparent(ffffff00)</td>
</tr>
<tr>
<td><b>padding</b></td>
<td> The width of the padding around the text（px）</td>
<td>6</td>
</tr>
<tr>
<td><b>word_spacing</b></td>
<td> character spacing（px）</td>
<td>0</td>
</tr>
<tr>
<td><b>kerning</b></td>
<td> word spacing（px）</td>
<td>0</td>
</tr>
<tr>
<td><b>line_spacing</b></td>
<td> Line spacing（px）</td>
<td>0</td>
</tr>
<tr>
<td><b>pierced</b></td>
<td> cutout effect（bool value）</td>
<td>false</td>
</tr>
<tr>
<td><b>tile</b></td>
<td> Whether to tile（bool value）</td>
<td>false</td>
</tr>
<tr>
<td><b>text</b></td>
<td>default string</td>
<td>empty string</td>
</tr>
</tbody>
</table>


#### Example 1
`imgx/overlay/simple_font.json` :
```json
{
"font_family" : "Microsoft YaHei",
"font_size" : 40,
"font_color" : "ffffff"
}
```
The simplest text watermarks
<img src="http://imgx-ss.bscstorage.com/imgx-test/w_800,f_png--l_text:simple_font:Hello+Bai+Shan%21%21,x_20,y_20,a_-25/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849050&Signature=dOMoCFXBKPQxLjJ0lunNxsoXT%2BA%3D">

Processing Instruction:
```
w_800,f_png--l_text:simple_font:Hello+Bai+Shan!!,x_20,y_20,a_-25
```



#### Example 2 

`imgx/overlay/subtitles.json` :
```json
{
"font_size" : 22,
"font_color" : "ffffff"
}
```

`imgx/overlay/subtitles_s.json` :

```json
{
"font_size" : 16,
"font_color" : "ffffff"
}
```
Let's create a blockbuster effect and apply it to two images:
<img src="http://imgx-ss.bscstorage.com/imgx-test/f_png,c_fill,w_800,h_400,e_brightness:-8--c_pad,w_800,h_550,g_center,b_000000ff,e_yellow:30--l_text:subtitles:%E4%B8%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%8F%90%E4%BE%9B%E4%B8%80%E5%A5%97%E4%BA%91%E7%AB%AF%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86%E6%9C%8D%E5%8A%A1,g_south,y_100--l_text:subtitles_s:Imgx+is+the+image+back-end+for+web+and+mobile+developers,g_south,y_80/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849662&Signature=7Mw8D66XZsoYNWc7hzMmvQH9Wpg%3D">


Processing Instruction:
```
f_png,c_fill,w_800,h_400,e_brightness:-8--c_pad,w_800,h_550,g_center,b_000000ff,e_yellow:30--l_text:subtitles: There is a set of cloud image processing services,g_south,y_
100--l_text:subtitles_s:Imgx is the image back-end for web and mobile developers,g_south,y_80
```



#### Example 3 
`imgx/overlay/my_font.json` :
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
Let's make a couplet:
<img src="http://imgx-ss.bscstorage.com/imgx-test/w_800,f_png--l_text:my_font:%E9%A9%AC%E9%A9%B0%E5%A4%A7%E9%81%93%E5%BE%81%E9%80%94%E8%BF%9C,g_south_west,w_40,x_20,y_100--l_text:my_font:%E7%BE%8A%E4%B8%8A%E5%A5%87%E5%B3%B0%E6%99%AF%E8%89%B2%E5%A8%87,g_south_east,w_40,x_20,y_100--l_text:my_
font:%E5%9B%BE%E7%89%87%E5%A4%84%E7%90%86,g_
north,y_20/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464849847&Signature=6clVRP9Jdg1szWrW7nI2jPjEI44%3D">

Processing Instruction:
```
w_800,f_png--l_text:my_font,g_south_west,w_40,x_20,y_100--l_text:my_font,g_south_east,w_40,x_20,y_100--l_text:my_font,g_north,y_20
```


#### Example 4
`imgx/overlay/font_me.json` :
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
Cutout Effect
<img src="http://imgx-ss.bscstorage.com/imgx-test/l_text:font_me:%E4%BD%A0%E5%A5%BD%EF%BC%8C%E7%99%BD%E5%B1%B1%E4%BA%91,g_north_west,x_20,y_20--w_800/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850225&Signature=Ogu7V1xUjeTvPA6Ml4%2B64kB02mM%3D">

指令：
```
l_text:font_me: Hello,BaishanCloud,g_north_west,x_20,y_20--w_800
```


#### Example 5
`imgx/overlay/tile.json` :
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
tiling effect
<img src="http://imgx-ss.bscstorage.com/imgx-test/w_800,f_png--l_text:tile:Hello+BaiShan%21%21,g_south/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850272&Signature=ZFRF%2F0HOsfQcdb3Y3N5%2FFxhE5jE%3D">

Processing Instruction:
```
w_800,f_png--l_text:tile:Hello BaiShan!!,g_south
```


#### Example 6
`imgx/overlay/badge.json` :
```json
{
"font_style" : "bold",
"font_size" : 30,
"font_color" : "ffffff",
"background" : "ff0000cc",
"padding" : 15
}
```
Add a badge
<img src="http://imgx-ss.bscstorage.com/imgx-test/c_thumb,g_face,w_200,h_200,r_max,bo_
6_ffffff80,f_png--l_text:badge:69,r_max,g_south_east,w_34,h_34,x_-1,y_-5/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850332&Signature=rREFYd6SQEtPdSu5JGFqGjRYxBQ%3D">

Processing Instruction:
```
c_thumb,g_face,w_200,h_200,r_max,bo_6_ffffff80,f_png--l_text:badge:69,r_max,g_south_east,w_34,h_34,x_-1,y_-5
```





## Use the "instruction set"

If you don't want to expose the directive in the URL, this is an example to automatically recognize the face position on a photo and make a circular thumbnail with a border:

- Firstly, create a json file and save it to the corresponding bucket:
Path: `imgx/cmd_template/avatar.json` :
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

- Access via the below way.

```
http://imgx-ss.bscstorage.com/imgx-test/t_avatar/demo/1.jpg?<signature>
http://imgx-ss.bscstorage.com/imgx-test/t_avatar/demo/3.jpg?<signature>
```

- Effect：
<img src="http://imgx-ss.bscstorage.com/imgx-test/t_avatar/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464850497&Signature=iRB5cnXfQp5m9sVBSUSsZtL235s%3D">
<img src="http://imgx-ss.bscstorage.com/imgx-test/t_avatar/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850600&Signature=ZnUlYNjjaYmo9RCKJ5i2QG913G4%3D">
<img src="http://imgx-ss.bscstorage.com/imgx-test/t_avatar/avatar.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850684&Signature=8EmYZxvTsg5hMkiPBhA7Px37fyE%3D">
<img src="http://imgx-ss.bscstorage.com/imgx-test/t_avatar/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464850768&Signature=Ms%2BM6jzw3KzUB2CjSZ3R8iH6ECY%3D">




## Font (font_family)

> The API to query fonts: http://imgx-ss.bscstorage.com/fonts


[1]: http://ss.bscstorage.com/imgx-test/demo/charles.png?AWSAccessKeyId=acc_drdrxp&Expires=2464851871&Signature=9Nb4uSsCdGbdhYdL05QNJMBOUDI%3D
[2]: http://ss.bscstorage.com/imgx-test/demo/1.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2464852096&Signature=krRDPWUXPGYWKaQ0FcrHOLh9w20=
[3]: http://ss.bscstorage.com/imgx-test/demo/3.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852128&Signature=UitAP/HXvS2T6Y9AAs7TGPJGwzU=
[4]: http://ss.bscstorage.com/imgx-test/demo/4.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852159&Signature=yvaPahyPoYUpLYaEE9br44JNAuw=
[5]: http://ss.bscstorage.com/imgx-test/demo/sheep.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852222&Signature=6TpoUspMxFaB5rnKT4VzhiaWcLg%3D
[6]: http://ss.bscstorage.com/imgx-test/demo/horses.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852280&Signature=jxH/VEABVAiIEc3ZE7GYSrj6LAw=
[7]: http://ss.bscstorage.com/imgx-test/avatar.png?AWSAccessKeyId=acc_drdrxp&Expires=2464852327&Signature=47wCMMxlDj8lP4JMaZ99NXl50%2bE=
[8]: http://ss.bscstorage.com/imgx-test/bsc_logo.jpg?AWSAccessKeyId=acc_drdrxp&Expires=2470638306&Signature=M4FHkWtF%2FEz%2FDlu5ru5DOahuRtQ%3D

