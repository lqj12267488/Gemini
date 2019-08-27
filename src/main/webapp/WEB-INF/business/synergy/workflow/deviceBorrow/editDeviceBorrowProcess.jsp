<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="deviceBorrowid" value="${deviceBorrow.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${deviceBorrow.requestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        借用时间
    </div>
    <div class="col-md-9">
        <input id="f_borrowTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.borrowTime}" />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        归还时间
    </div>
    <div class="col-md-9">
        <input id="f_revertTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.revertTime}" />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        设备清单
    </div>
    <div class="col-md-9">
                        <textarea id="f_deviceList"  class="validate[required,maxSize[100]] form-control"
                                  maxlength="330" placeholder="最多输入330个字"
                                  value="${deviceBorrow.deviceList}">${deviceBorrow.deviceList}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        活动内容
    </div>
    <div class="col-md-9">
                        <textarea id="f_activityContent"  class="validate[required,maxSize[100]] form-control"
                                  maxlength="330" placeholder="最多输入330个字"
                                  value="${deviceBorrow.activityContent}">${deviceBorrow.activityContent}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_DEVICEBORROW_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/deviceBorrow/printDeviceBorrow?id=${deviceBorrow.id}">
<script>



    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T','');
        var borrowTime = $("#f_borrowTime").val();
        borrowTime = borrowTime.replace('T','');
        var revertTime = $("#f_revertTime").val();
        revertTime = revertTime.replace('T','');
        if ($("#f_borrowTime").val() == "" || $("#f_borrowTime").val() == "0") {
            swal({
                title: "请填写设备清单!",
                type: "info"
            });
            return;
        }
        if ($("#f_revertTime").val() == "" || $("#f_revertTime").val() == "0") {
           swal({
                title: "请填写结束日期!",
                type: "info"
            });
            return;
        }
        if( $("#f_borrowTime").val() > $("#f_revertTime").val()){
            swal({
                title: "请选择开始时间需要在结束时间之前!",
                type: "info"
            });
            return;
        }
        if ($("#f_deviceList").val() == "" || $("#f_deviceList").val() == "0" || $("#f_deviceList").val() == undefined) {
           swal({
                title: "请填写设备清单!",
                type: "info"
            });
            return;
        }
        if($("#f_activityContent").val() =="" ||  $("#f_activityContent").val() =="0" || $("#f_activityContent").val() == undefined){
           swal({
                title: "请填写活动内容!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/deviceBorrow/saveDeviceBorrow", {
            id: $("#deviceBorrowid").val(),
            requestDate: date,
            revertTime:revertTime,
            borrowTime:borrowTime,
            deviceList: $("#f_deviceList").val(),
            activityContent: $("#f_activityContent").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#deviceBorrowGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>

