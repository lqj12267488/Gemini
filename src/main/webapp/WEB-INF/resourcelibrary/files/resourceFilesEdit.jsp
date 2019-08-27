<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="fileId" hidden value="${data.fileId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
            <div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="fileName" value="${data.fileName}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="fileUrl" value="${data.fileUrl}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="fileType" value="${data.fileType}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="fileSize" value="${data.fileSize}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="coverUrl" value="${data.coverUrl}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="coverType" value="${data.coverType}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="tablename" value="${data.tablename}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="businessId" value="${data.businessId}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="businessType" value="${data.businessType}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="sourceSystem" value="${data.sourceSystem}"/>
</div>
</div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });


    function save() {
    var fileId = $("#fileId").val();
var fileName = $("#fileName").val();
var fileUrl = $("#fileUrl").val();
var fileType = $("#fileType").val();
var fileSize = $("#fileSize").val();
var coverUrl = $("#coverUrl").val();
var coverType = $("#coverType").val();
var tablename = $("#tablename").val();
var businessId = $("#businessId").val();
var businessType = $("#businessType").val();
var sourceSystem = $("#sourceSystem").val();
if (fileId == "" || fileId == undefined || fileId == null) {
	alert("请填写！");
	return;
}
if (fileName == "" || fileName == undefined || fileName == null) {
	alert("请填写！");
	return;
}
if (fileUrl == "" || fileUrl == undefined || fileUrl == null) {
	alert("请填写！");
	return;
}
if (fileType == "" || fileType == undefined || fileType == null) {
	alert("请填写！");
	return;
}
if (fileSize == "" || fileSize == undefined || fileSize == null) {
	alert("请填写！");
	return;
}
if (coverUrl == "" || coverUrl == undefined || coverUrl == null) {
	alert("请填写！");
	return;
}
if (coverType == "" || coverType == undefined || coverType == null) {
	alert("请填写！");
	return;
}
if (tablename == "" || tablename == undefined || tablename == null) {
	alert("请填写！");
	return;
}
if (businessId == "" || businessId == undefined || businessId == null) {
	alert("请填写！");
	return;
}
if (businessType == "" || businessType == undefined || businessType == null) {
	alert("请填写！");
	return;
}
if (sourceSystem == "" || sourceSystem == undefined || sourceSystem == null) {
	alert("请填写！");
	return;
}

        $.post("<%=request.getContextPath()%>/resourceLibrary/files/saveResourceFiles", {
        fileId:fileId,
fileName:fileName,
fileUrl:fileUrl,
fileType:fileType,
fileSize:fileSize,
coverUrl:coverUrl,
coverType:coverType,
tablename:tablename,
businessId:businessId,
businessType:businessType,
sourceSystem:sourceSystem,
}, function (msg) {
            alert(msg.msg);
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



