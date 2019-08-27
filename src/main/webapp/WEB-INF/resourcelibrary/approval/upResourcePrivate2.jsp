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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="resourceId" hidden value="${resourceId}"/>
            <input id="resourceName" hidden value="${resourceName}"/>
            <input id="requestType" hidden value="${requestType}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源名称
                    </div>
                    <div class="col-md-9">
                        ${resourceName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请理由
                    </div>
                    <div class="col-md-9">
                            <textarea id="reason" style="height: 100px"
                                      class="validate[required,maxSize[20]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">申请
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
        <%--<div class="tc_an">--%>
        <%--<button type="button" class="tc_btn1" onclick="save()">申请--%>
        <%--</button>--%>
        <%--<button type="button" class="tc_btn2"  onclick="closeDialog()">关闭--%>
        <%--</button>--%>
        <%--</div>--%>
    </div>
</div>
<script>
    $(document).ready(function () {

    });
    function save() {
        var resourceId = $("#resourceId").val();
        var reason = $("#reason").val();
        var edit_remark = $("#edit_remark").val();
        if (reason == "" || reason == undefined || reason == null) {
            swal({title: "请填写申请理由！",type: "info"});
            return;
        }
        $.post("<%=request.getContextPath()%>/resourcePrivate/toUpResourcePrivateAdd", {
            resourceId:resourceId,
            reason:reason,
            requestType: $("#requestType").val()
        }, function (msg) {
            swal({title: msg.msg,type: msg.result},function () {
                $("#dialog").modal('hide');
//            closeDialog();
                $('#tablePrivate').DataTable().ajax.reload();
            });
        })
    }
</script>
<style>
    .modal-dialog {
        width: 400px;
        height: 400px;
    }
</style>