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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeArchives()">
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
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeArchives()">完成
            </button>
        </div>
    </div>
    <input id="archivesId" type="text" value="${archivesId}" hidden/>
    <%--后缀--%>
    <input id="fileType" type="text" value="${fileType}" hidden/>
    <input id="flag" type="text" value="${flag}" hidden/>
    <input id="arname" type="text" value="${archivesName}" hidden>
    <input id="filesName" type="text"  hidden >

</div>
<script>
    var archivesName = encodeURI(encodeURI('${archivesName}'));
    var fileSuffix;
    var filesTable;
    var filesName =",";
    $(document).ready(function () {
        filesTable = $("#filesTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/archives/getFilesByArchivesId2?archivesId=' + $("#archivesId").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "fileName", "visible": false},
                {
                    "title": "文件名称",
                    "render": function (data, type, row) {
                        filesName = filesName +  row.fileName +",";
                        $("#filesName").val(filesName);
                        return '<a href="<%=request.getContextPath()%>/archives/downloadArchivesFile?archivesId=' + $("#archivesId").val() + '&fileId=' + row.fileId + '">' + row.fileName + '</a>';
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

        if ($("#fileType").val() == '1') {
            fileSuffix = ['mp3', 'wma','wav'];
        } else if ($("#fileType").val() == '2') {
            fileSuffix = ['mp4', 'flv','avi','wmv','mov','vob','mkv'];
        } else if ($("#fileType").val() =='3' ) {
            fileSuffix = ['jpg', 'png', 'jpeg','gif','bmp'];
        } else if ($("#fileType").val() == '4') {
            fileSuffix = ['txt', 'doc', 'docx', 'xlsx', 'ppt', 'pdf', 'xls', 'xlsx', 'rar', 'zip', 'pptx','jpg', 'png', 'jpeg','gif','bmp'];
        }
        $('#ssi-upload').ssi_uploader({
            url: '<%=request.getContextPath()%>/archives/insertArchivesFiles?archivesId=${archivesId}&archivesName=' +
            archivesName + '&archivesCode=${archivesCode}&flag=${flag}&role=${role}',
            maxFileSize: 10240,
            // beforeUpload: checkFileName ,
            allowed: fileSuffix,
            onUpload: function () {
                $("#filesTable").DataTable().ajax.reload();
            }
        });
    });

    function checkFileName() {
        alert(85);
        return "error";
        /*
                        return;
                        $("#filesTable").Rows.Count;
                        fileDate = $("#filesTable").rows[i]["fieldname"].tostring() ;
        */

    }

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

    function closeArchives() {
        $("#dialog").modal("hide");
        if ('${role}' == 'teacher') {
            listTable.ajax.url("<%=request.getContextPath()%>/archives/getTeacherArchivesList").load();
        } else if('${role}' == 'leader'){
            listTable.ajax.url("<%=request.getContextPath()%>/archives/getSchLeaderArchivesList").load();
        } else {
            listTable.ajax.url("<%=request.getContextPath()%>/archives/getDirectorArchivesList").load();
        }
    }
</script>
