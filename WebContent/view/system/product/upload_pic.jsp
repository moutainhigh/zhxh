<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <%-- <script src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script> --%>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script>
    	var result = '${result}';
    	var result_id = '${id}';
    	var result_saveFolder = '${saveFolder}';
    	var result_forObj = '${forObj}';
    	var id="";
    	var saveFolder = "";
    	var forObj = "";
    	
    	$(function(){
    		if (result != "") {
    			alert(result);
    			result = "";
    			$("#id").val(result_id);
    			$("#saveFolder").val(result_saveFolder);
    			$("#forObj").val(result_forObj);
    		}
    	})
    	
    	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			id = data.id;
			saveFolder = data.saveFolder;
			forObj = data.forObj;
			
			$("#id").val(id);
			$("#saveFolder").val(saveFolder);
			$("#forObj").val(forObj);
			
		}
    	
		var loadImageFile = (function() {
			if (window.FileReader) {
				var oPreviewImg = null, oFReader = new window.FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;

				oFReader.onload = function(oFREvent) {
					if (!oPreviewImg) {
						var newPreview = document
								.getElementById("imagePreview");
						oPreviewImg = new Image();
						oPreviewImg.style.width = (newPreview.offsetWidth).toString() + "px";
						//oPreviewImg.style.height = (newPreview.offsetHeight).toString() + "px";
						newPreview.innerHTML = "";
						newPreview.appendChild(oPreviewImg);
					}
					oPreviewImg.src = oFREvent.target.result;
				};

				return function() {
					var aFiles = document.getElementById("imageInput").files;
					if (aFiles.length === 0) {
						return;
					}
					if (!rFilter.test(aFiles[0].type)) {
						alert("您选择的文件并不是图片格式。请重新选择!");
						return;
					}
					oFReader.readAsDataURL(aFiles[0]);
				}
			}
			if (navigator.appName === "Microsoft Internet Explorer") {
				return function() {

					//alert(document.getElementById("imageInput").value);
					var imagePreview = document.getElementById("imagePreview");
					imagePreview.innerHTML = "";
					document.getElementById("imagePreview").filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = document.getElementById("imageInput").value;
				}
			}
		})();
    	
    	
    	function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	    function onRowDblClick(e) {
	        onOk();
	    }
	</script>
	<style type="text/css">
		#imagePreview {
			/* width: 360px; */
			height: 220px;
			filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);
		}
	</style>
</head>
<body>
	<div class="mini-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
          <label id="memo">请选择图片上传</label>
    </div>
	<div style="width:70%;margin-bottom:30px; MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
		<form id="uploadImgForm" method="post" class="form-x"  action="${pageContext.request.contextPath}/common/update_common_file.html" enctype="multipart/form-data" style="margin-top: 30px;">
	         <input type="hidden" id="redirectPath" name="redirectPath" value="/view/system/product/upload_pic" />
	 	     <input type="hidden" id="id" name="id" value="" />
	 	     <input type="hidden" id="saveFolder" name="saveFolder" value="" />
	 	     <input type="hidden" id="forObj" name="forObj" value="" />
	         <div class="form-group">
	             <div class="label"><label for="pic_path">选择图片</label> </div>
	             <div class="field">
	             	<a class="button border-blue button-small input-file" href="javascript:void(0);" style="vertical-align: middle">+ 浏览文件<input size="100" type="file" name="imageInput" id="imageInput"  onchange="loadImageFile()" /></a>
	             	<button class="button border-sub button-small" style="vertical-align: middle" > 上传</button>
	             	<button class="button border-sub button-small" style="vertical-align: middle" onclick="onOk()" type="button"> 关闭</button>
	             </div>
	         </div>
	         <div class="form-group">
	             <div class="label"><label for="logo">预览</label></div>
	             <div class="field">
	             	<div id="imagePreview">
	             		<c:if test="${null != filepath && filepath != '' }">
	             			<img src="${pageContext.request.contextPath}/${filepath }" width="80%" />
	             		</c:if>
	             	</div>
	             </div>
	         </div>
	         <!-- <div class="form-button"><button class="button bg-main" type="submit">提交</button></div> -->
	    </form>
	</div>
</body>
</html>