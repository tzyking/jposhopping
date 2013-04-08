<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Fine Uploader - jQuery Wrapper Minimal Demo</title>
    <link href="fineuploader-{VERSION}.css" rel="stylesheet">
  </head>
  <body>
    <div id="jquery-wrapped-fine-uploader"></div>
 
    <script src="../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js"></script>
    <script src="jquery.fineuploader-{VERSION}.js"></script>
    <script>
      $(document).ready(function () {
        $('#jquery-wrapped-fine-uploader').fineUploader({
          request: {
            endpoint: 'server/handleUploads'
          }
        });
      });
    </script>
  </body>
</html>