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
        accessKeyId: 'ziw5dp1alvty9n47qksu',    <!--请替换为您自己的access key-->
        secretAccessKey: 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'    <!--请替换为您自己的secret key-->
    });
    AWS.config.region = 'us-west-1';
    AWS.config.endpoint = 'http://ss.bscstorage.com';
    AWS.config.s3ForcePathStyle = true

    var bucket_name = 'test-bucket'    <!--请替换为您自己的bucket的名字-->

    var s3 = new AWS.S3({
        params: {
            Bucket: bucket_name
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
                Bucket: bucket_name
            }, function(err, data) {
                if (err) {
                    console.log(err);
                } else {
                    console.log(data);
                }

            });
            s3.getObject({
                Bucket: bucket_name,
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

```


```html

<html>
<!--上传用户本地文件，并生成文件的URL的示例-->
<!--不建议将帐号信息放到浏览器端代码中-->
<input type="file" id="file-chooser" />
<button id="upload-button">Upload to S3</button>
<div id="results"></div>
<div id="signed_url"></div>

<script src='https://sdk.amazonaws.com/js/aws-sdk-2.5.0.min.js'></script>
<script type="text/javascript">

  <!--请替换为您自己的access key 和secret key-->
  AWS.config.update({accessKeyId: 'ziw5dp1alvty9n47qksu', secretAccessKey: 'V+ZTZ5u5wNvXb+KP5g0dMNzhMeWe372/yRKx4hZV'});
  AWS.config.region = 'us-west-1';
  AWS.config.endpoint = 'http://ss.bscstorage.com';
  AWS.config.s3ForcePathStyle = true

  var bucket_name = 'test-bucket'    <!--请替换为您自己的bucket的名字-->

  var s3 = new AWS.S3({params: {Bucket: bucket_name}});

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
        var params_get = { Bucket: bucket_name, Key: file.name, Expires: 60 };
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

AWS 官方 SDK [aws-sdk-browser](https://aws.amazon.com/sdk-for-browser/)
