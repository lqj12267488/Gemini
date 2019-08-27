<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }

        .iconBtx{
            color: #E9003A;
            font-size: 16px;
        }

    </style>
</head>
<div class="modal-dialog">
    <div class="tanchu-content">
        <div class="tanchu-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="resourceId" hidden value="${resourceId}"/>
            <input id="resourceName" hidden value="${resourceName}"/>
            <input id="requestType" hidden value="${requestType}"/>
        </div>
        <div class="tanchu">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="tc_list" style="vertical-align:bottom">
                <div class="tc_l_l" style="vertical-align:top;">
                    资源名称
                </div>
                <div class="tc_l_r">
                    ${resourceName}
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>申请理由
                </div>
                <div class="tc_l_r">
                            <textarea id="reason" style="height: 100px"
                                      class="validate[required,maxSize[20]] form-control"></textarea>
                </div>
            </div>
        </div>
        <div class="tc_an">
            <button type="button" id="saveBtn" class="tc_btn1" onclick="save()">申请
            </button>
            <button type="button" class="tc_btn2"  onclick="closeDialog()">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {

    });
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        var resourceId = $("#resourceId").val();
        var reason = $("#reason").val();
        var edit_remark = $("#edit_remark").val();
        if (reason == "" || reason == undefined || reason == null) {
            swal({title: "请填写申请理由！",type: "info"});
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/resourcePrivate/toUpResourcePrivateAdd", {
            resourceId:resourceId,
            reason:reason,
            requestType: $("#requestType").val()
        }, function (msg) {
            hideSaveLoading();

            swal({title: msg.msg,type: msg.result});
            $('#tablePrivate').DataTable().ajax.reload();
            closeDialog();
        })
    }


</script>
<style>
    .modal-dialog {
        width: 400px;
        height: 400px;
    }
</style>