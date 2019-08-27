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
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="approvalId" hidden value="${data.approvalId}"/>
            <input id="resourceId" hidden value="${data.resourceId}"/>
            <input id="resourceName" hidden value="${data.resourceName}"/>
            <input id="requestType" hidden value="${data.requestType}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md">
                        资源名称
                    </div>
                    <div class="col-md">
                        ${data.resourceName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        申请类型
                    </div>
                    <div class="col-md">
                        ${data.requestTypeShow}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        申请人
                    </div>
                    <div class="col-md">
                        ${data.requesterShow}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        申请时间
                    </div>
                    <div class="col-md">
                        ${data.requestDate}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        申请原因
                    </div>
                    <div class="col-md">
                        ${data.requestReason}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        审核意见
                    </div>
                    <div class="col-md">
                        <textarea name="approvalOpinion" id="approvalOpinion" cols="30" rows="2" >${data.approvalOpinion}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer"  style="text-align: right">
            <button type="button" class="btn btn-success btn-clean" onclick="doApproval(2,1)">通过
            </button>
            <button type="button" class="btn btn-success btn-clean" onclick="doApproval(3,0)">驳回
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeDialog()">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });

    function doApproval(requestFlag,approvalFlag) {
        var approvalOpinion =$("#approvalOpinion").val() ;
        if( approvalOpinion == "" ){
            swal({title: msg.msg, type: "error"});
        }
        var resourceId = $("#resourceId").val();
        var resourceName = $("#resourceName").val();
        var approvalId = $("#approvalId").val();
        var requestType = $("#requestType").val();

        $.post("<%=request.getContextPath()%>/resourceLibrary/approval/setResourceApproval", {
            approvalId:approvalId,
            resourceId:resourceId,
            approvalOpinion:approvalOpinion,
            requestFlag:requestFlag,
            approvalFlag:approvalFlag,
            requestType:requestType,
        }, function (msg) {
            swal({title: msg.msg, type:msg.result});
            if(requestFlag == 2 && approvalFlag == 1){
                $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/setPublicResource" +
                    "?resourceId="+resourceId+
                    "&resourceName="+resourceName+
                    "&approvalId="+approvalId+
                    "&requester=${data.requesterShow}");
            }else{
//                $("#dialog").modal('hide');
                closeDialog();
                $('#tableApproval').DataTable().ajax.reload();
            }
        })

    }

</script>
<style>
    .modal-dialog {
        width:600px;
        height: 350px;
        top: 10%!important;
    }
</style>