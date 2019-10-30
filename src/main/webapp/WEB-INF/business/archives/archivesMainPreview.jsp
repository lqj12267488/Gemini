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
<div class="modal-dialog" style="min-width: 1200px;">
    <div class="modal-content block-fill-white" id="leftView">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <table id="filesTables" cellpadding="0" cellspacing="0"
                   width="100%" style=" max-height: 50%;min-height: 10%;"
                   class="table table-bordered table-striped sortable_default">
            </table>
            <div id="file">
                <input id="ssi-uploads" type="file" multiple/>
            </div>
        </div>
    </div>
    <input id="archivesId" type="text" value="${archivesId}" hidden/>
    <input id="flag" type="text" value="${flag}" hidden/>
    <div id="rightView"></div>
</div>
<style>
    #leftView {
        position: relative;
    }

    #leftView, #rightView {
        float: left;
        width: 580px;
    }

    #rightView .modal-dialog {
        padding: 0px;
    }
</style>

<script>
    $(document).ready(function () {
        $("#filesTables").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/archives/getFilesByArchivesId2?archivesId=' + $("#archivesId").val(),
            },
            "destroy": true,
            "columns": [
                {
                    "title": "文件名称",
                    "render": function (data, type, row) {
                        return '<span id="preview" title="点击预览" onclick="preview(\'' + row.fileId + '\')">' + row.fileName + '</span>';
                    }
                },
                {
                    "title": "操作",
                    "width": "15%",
                    "render": function (data, type, row) {
                        return '<a id="upload" href="<%=request.getContextPath()%>/archives/downloadArchivesFile?archivesId='+$("#archivesId").val()+'&fileId=' + row.fileId + '" class="icon-download"title="下载"></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        $('#ssi-uploads').ssi_uploader({
            url: '<%=request.getContextPath()%>/archives/insertArchivesFiles?archivesId=${archivesId}&flag=${flag}&role=${role}',
            maxFileSize: 100,
            allowed: ['jpg', 'gif', 'txt', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'rar', 'zip', 'ppt', 'pptx'],
            onUpload: function () {
                $("#filesTables").DataTable().ajax.reload();
            }
        });
        if ("${role}" == "leader") {
            $("#file").hide();
        }
    });

    function preview(fileId) {
        $("#rightView").load("<%=request.getContextPath()%>/archivesPrivate/getPrivateArchivesView?fileId=" + fileId);
        $("#rightView").modal("show");
    }
</script>
