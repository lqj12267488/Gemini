<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/3
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>
<div class="modal-dialog">
    <input id="tableName" hidden value="${tableName}">
    <input id="businessId" hidden value="${businessId}">
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
            <input id="ssi-upload" type="file" multiple/>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#filesTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/files/getFilesByBusinessId?businessId=${businessId}',
            },
            "destroy": true,
            "columns": [
                {
                    "title": "文件名称",
                    "render": function (data, type, row) {
                        return '<a href="<%=request.getContextPath()%>/files/downloadFiles?id=' + row.fileId + '">' + row.fileName + '</a>';
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
            "dom": 'rt',
            language: language
        });

        $('#ssi-upload').ssi_uploader({
            url: '<%=request.getContextPath()%>/files/insertFiles?businessType=${businessType}&businessId=${businessId}&tableName=${tableName}',
            maxFileSize: 10,
            allowed: ['jpg', 'gif', 'txt', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'rar', 'zip', 'ppt', 'pptx'],
            onUpload: function () {
                if ($("#url").html() != undefined) {
                    $("#right").load("<%=request.getContextPath()%>/toEditBusiness?businessId=" + $("#businessId").val() + "&url=" + $("#url").val()
                        + "&tableName=" + $("#tableName").val() + "&backUrl=" + $("#backUrl").val());
                }
                $("#filesTable").DataTable().ajax.reload();
                reloadFileNumber();
            }
        });
    });

    function del(id) {
        var tableName = $("#tableName").val();
        var businessId = $("#businessId").val();
        swal({
            title: "请确认是否要删除该附件?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            if (tableName == "T_ZW_REPAIR") {
                $.post("<%=request.getContextPath()%>", {
                    repairID: businessId
                }, function (msg) {
                    if (msg.status == 1) {
                        $.post("<%=request.getContextPath()%>/files/delFile", {
                            id: id,
                        }, function (msg) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            if ($("#url").html() != undefined) {
                                $("#right").load("<%=request.getContextPath()%>/toEditBusiness?businessId=" + $("#businessId").val() + "&url=" + $("#url").val()
                                    + "&tableName=" + $("#tableName").val() + "&backUrl=" + $("#backUrl").val());
                            }
                            $("#filesTable").DataTable().ajax.reload();
                            reloadFileNumber();
                        })
                    } else {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    }
                })
            }
            else {
                $.post("<%=request.getContextPath()%>/files/delFile", {
                    id: id,
                }, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    if ($("#url").html() != undefined) {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness?businessId=" + $("#businessId").val() + "&url=" + $("#url").val()
                            + "&tableName=" + $("#tableName").val() + "&backUrl=" + $("#backUrl").val());
                    }
                    $("#filesTable").DataTable().ajax.reload();
                    reloadFileNumber();
                })
            }
        })

    }

    function download(id) {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/files/downloadFiles",
            data: {
                id: id,
            },
            error: function (request) {
                swal({title: "下载失败！", type: "error"});
                //alert("下载失败！");
            },
            success: function (data) {
                return data;
            }
        });
    }
</script>