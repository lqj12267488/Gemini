<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/31
  Time: 9:52
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
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="reject()">驳回</button>
            <button type="button" class="btn btn-default btn-clean" onclick="pass()">通过</button>
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
                {"width": "10%", "data": "fileState", "title": "状态"},
            ],
            "dom": 'rt',
            language: language
        });
    });
    function reject() {
        swal({
            title: "您确定驳回此档案的修改申请?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#red",
            confirmButtonText: "驳回",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/archives/updateRequestReject?archivesId="+$("#archivesId").val()+"&requestType=1", function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"},function () {
                        $("#dialog").modal('hide');
                        $('#listGrid').DataTable().ajax.reload();
                    });
                }
            })
        })
    }
    function pass() {
        $.get("<%=request.getContextPath()%>/archives/RequestPass?archivesId="+$("#archivesId").val()+"&requestType=1", function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
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
