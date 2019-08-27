<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/3
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <input id="ssi-upload" type="file" multiple/>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var ids = $("#cache").val().split(",");
        $('#ssi-upload').ssi_uploader({
            url: "<%=request.getContextPath()%>/resourcePublic/batchUpdate?resourceSubjectId=" + ids[0] +
            "&resourceMajorId=" + ids[1] + "&resourceCourseId=" + ids[2],
            maxFileSize: 2048,
            allowed: ['jpg', 'gif', 'txt', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'rar', 'zip', 'ppt', 'pptx',
                'avi', 'wmv', 'mpeg', 'mp4', 'mov', 'mkv', 'flv', 'f4v', 'm4v', 'rmvb', 'rm', '3gp', 'dat', 'ts', 'mts', 'vob'],
            onUpload: function () {
                $("#dialog").modal("hide")
                swal({
                    title: "上传成功！",
                    type: "success"
                }, function () {
                    searchResource()
                });
            }
        });
    });
</script>