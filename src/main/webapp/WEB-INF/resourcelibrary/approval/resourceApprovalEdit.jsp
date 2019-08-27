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
            <input id="approvalId" hidden value="${data.approvalId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="resourceId" value="${data.resourceId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" value="${data.resourceName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requestDept" value="${data.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requester" value="${data.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" value="${data.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requestReason" value="${data.requestReason}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requestType" value="${data.requestType}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="requestFlag" value="${data.requestFlag}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="approvalDept" value="${data.approvalDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="approver" value="${data.approver}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="approvalTime" value="${data.approvalTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="approvalFlag" value="${data.approvalFlag}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="approvalOpinion" value="${data.approvalOpinion}"/>
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
        var approvalId = $("#approvalId").val();
        var resourceId = $("#resourceId").val();
        var resourceName = $("#resourceName").val();
        var requestDept = $("#requestDept").val();
        var requester = $("#requester").val();
        var requestDate = $("#requestDate").val();
        var requestReason = $("#requestReason").val();
        var requestType = $("#requestType").val();
        var requestFlag = $("#requestFlag").val();
        var approvalDept = $("#approvalDept").val();
        var approver = $("#approver").val();
        var approvalTime = $("#approvalTime").val();
        var approvalFlag = $("#approvalFlag").val();
        var approvalOpinion = $("#approvalOpinion").val();
        if (approvalId == "" || approvalId == undefined || approvalId == null) {
            alert("请填写！");
            return;
        }
        if (resourceId == "" || resourceId == undefined || resourceId == null) {
            alert("请填写！");
            return;
        }
        if (resourceName == "" || resourceName == undefined || resourceName == null) {
            alert("请填写！");
            return;
        }
        if (requestDept == "" || requestDept == undefined || requestDept == null) {
            alert("请填写！");
            return;
        }
        if (requester == "" || requester == undefined || requester == null) {
            alert("请填写！");
            return;
        }
        if (requestDate == "" || requestDate == undefined || requestDate == null) {
            alert("请填写！");
            return;
        }
        if (requestReason == "" || requestReason == undefined || requestReason == null) {
            alert("请填写！");
            return;
        }
        if (requestType == "" || requestType == undefined || requestType == null) {
            alert("请填写！");
            return;
        }
        if (requestFlag == "" || requestFlag == undefined || requestFlag == null) {
            alert("请填写！");
            return;
        }
        if (approvalDept == "" || approvalDept == undefined || approvalDept == null) {
            alert("请填写！");
            return;
        }
        if (approver == "" || approver == undefined || approver == null) {
            alert("请填写！");
            return;
        }
        if (approvalTime == "" || approvalTime == undefined || approvalTime == null) {
            alert("请填写！");
            return;
        }
        if (approvalFlag == "" || approvalFlag == undefined || approvalFlag == null) {
            alert("请填写！");
            return;
        }
        if (approvalOpinion == "" || approvalOpinion == undefined || approvalOpinion == null) {
            alert("请填写！");
            return;
        }

        $.post("<%=request.getContextPath()%>/resourceLibrary/approval/saveResourceApproval", {
            approvalId:approvalId,
            resourceId:resourceId,
            resourceName:resourceName,
            requestDept:requestDept,
            requester:requester,
            requestDate:requestDate,
            requestReason:requestReason,
            requestType:requestType,
            requestFlag:requestFlag,
            approvalDept:approvalDept,
            approver:approver,
            approvalTime:approvalTime,
            approvalFlag:approvalFlag,
            approvalOpinion:approvalOpinion,
        }, function (msg) {
            swal({title: msg.msg, type: msg.result});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



