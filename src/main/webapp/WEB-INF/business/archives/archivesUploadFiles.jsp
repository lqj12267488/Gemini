<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/25
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>

<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <table id="filesTable" cellpadding="0" cellspacing="0"
                   width="100%" style="max-height: 50%;min-height: 10%;"
                   class="table table-bordered table-striped sortable_default">
            </table>
            <div id="file">
                <input id="ssi-upload" type="file" multiple/>
            </div>
        </div>
    </div>
    <input id="archivesId" type="text" value="${archivesId}" hidden/>
    <input id="flag" type="text" value="${flag}" hidden/>
    <%--<input id="fileUrl" type="text" value="${files.fileUrl}" hidden/>--%>
    <%--&lt;%&ndash;<input id="fileName" type="text" value="${files.Name}" hidden/>&ndash;%&gt;--%>
</div>
<script>
    $(document).ready(function () {
        $("#filesTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/archives/getFilesByArchivesId?archivesId='+$("#archivesId").val(),
            },
            "destroy": true,
            "columns": [
                {
                    "title": "文件名称",
                    "render": function (data, type, row) {
                        return '<a href="<%=request.getContextPath()%>/archives/downloadArchivesFile?fileId=' + row.fileId + '">' + row.fileName + '</a>';
                    }
                },
                {
                    "title": "操作",
                    "width": "15%",
                    "render": function (data, type, row) {
                        return '<span id="del" class="icon-trash" title="删除" onclick=del("' + row.fileId + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        $('#ssi-upload').ssi_uploader({
            url: '<%=request.getContextPath()%>/archives/insertArchivesFiles?archivesId=${archivesId}&flag=${flag}&role=${role}',
            maxFileSize: 100,
            allowed: ['jpg', 'gif', 'txt', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'rar', 'zip', 'ppt', 'pptx','mp4','mp3'],
            onUpload: function () {
                $("#filesTable").DataTable().ajax.reload();
            }
        });
        if("${role}"=="leader"){
            $("#file").hide();
        }
    });

    function del(fileId) {
        $.post("<%=request.getContextPath()%>/archives/deleteFileByFileId", {
            fileId: fileId
        }, function (msg) {
            alert(msg.msg);
            $("#filesTable").DataTable().ajax.reload();
        })
    }

    function download(fileId) {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/archives/downloadArchivesFile",
            data: {
                fileId: fileId,
            },
            error: function (request) {
                alert("下载失败！");
            },
            success: function (data) {
                return data;
            }
        });
    }
</script>
