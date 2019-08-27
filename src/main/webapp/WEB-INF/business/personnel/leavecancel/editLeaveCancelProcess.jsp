<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/21
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="leaveCancelid" value="${leaveCancel.id}">

<div class="form-row">
    <div class="col-md-3 tar">
        申请销假部门
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leaveCancel.cancelRequestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假人
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leaveCancel.cancelRequester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假日期
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDate" value="${leaveCancel.cancelRequestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假开始时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelStartTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leaveCancel.cancelStartTime}" onclick="chaa()"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假结束时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelEndTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leaveCancel.cancelEndTime}" onclick="chaa()" onblur="shijian()"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        实际请假天数
    </div>
    <div class="col-md-9">
        <input id="x_realDays" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${leaveCancel.realDays}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假原因
    </div>
    <div class="col-md-9">
                            <textarea id="x_cancelReason" class="validate[required,maxSize[100]] form-control"
                                      value="${leaveCancel.cancelReason}">${leaveCancel.cancelReason}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_RS_LEAVE_CANCEL_WF01">
<input id="printFunds" hidden
       value="<%=request.getContextPath()%>/leaveCancel/printLeaveCancels?id=${leaveCancel.leaveId}">
<script>
    function shijian() {
        if ($("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()) {
            swal({
                title: "请选择销假开始时间需要在销假结束时间之前",
                type: "info"
            });
            //alert("请选择销假开始时间需要在销假结束时间之前！");
            return;
        }
    }

    function chaa() {
        var start = new Date(document.getElementById("x_cancelStartTime").value.substring(0, 10)).getTime();
        var end = new Date(document.getElementById("x_cancelEndTime").value.substring(0, 10)).getTime();
        var cha = (end - start) / 60 / 60 / 24 / 1000;
        var yuan = document.getElementById("f_requestDays").value;
        document.getElementById("x_realDays").value = yuan - cha;
    }

    function save() {
        var date = $("#x_cancelRequestDate").val();
        date = date.replace('T', '');
        var startTime = $("#x_cancelStartTime").val();
        startTime = startTime.replace('T', '');
        var endTime = $("#x_cancelEndTime").val();
        endTime = endTime.replace('T', '');
        if ($("#x_cancelRequestDate").val() == "" || $("#x_cancelRequestDate").val() == "0") {
            swal({
                title: "请填写销假申请时间",
                type: "info"
            });
            //alert("请填写销假申请时间");
            return;
        }
        if ($("#x_cancelStartTime").val() == "" || $("#x_cancelStartTime").val() == "0") {
            swal({
                title: "请填写销假开始时间",
                type: "info"
            });
            //alert("请填写销假开始时间");
            return;
        }
        if ($("#x_cancelEndTime").val() == "" || $("#x_cancelEndTime").val() == "0") {
            swal({
                title: "请填写销假结束时间",
                type: "info"
            });
            //alert("请填写销假结束时间");
            return;
        }
        if ($("#f_requestDate").val() > $("#x_cancelRequestDate").val()) {
            swal({
                title: "请选择请假时间要在销假时间之前",
                type: "info"
            });
            //alert("请选择请假时间要在销假时间之前");
            return;
        }
        if ($("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()) {
            swal({
                title: "请选择销假开始时间需要在销假结束时间之前",
                type: "info"
            });
            //alert("请选择销假开始时间需要在销假结束时间之前！");
            return;
        }
        if ($("#x_cancelEndTime").val() > $("#f_endTime").val()) {
            swal({
                title: "请选择销假结束时间需要在请假结束时间之前",
                type: "info"
            });
            //alert("请选择销假结束时间需要在请假结束时间之前！");
            return;
        }
        if ($("#x_cancelReason").val() == "" || $("#x_cancelReason").val() == "0" || $("#x_cancelReason").val() == undefined) {
            swal({
                title: "请填写请假原因",
                type: "info"
            });
            //alert("请填写请假原因");
            return;
        }

        $.post("<%=request.getContextPath()%>/leaveCancel/saveLeaveCancel", {
            id: $("#leaveCancelid").val(),
            leaveId: $("#eId").val(),
            cancelRequestDate: date,
            cancelStartTime: startTime,
            cancelEndTime: endTime,
            cancelRequestDays: $("#x_cancelRequestDays").val(),
            realDays: $("#x_realDays").val(),
            cancelReason: $("#x_cancelReason").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#leaveCancelGrid').DataTable().ajax.reload();
            }
        })
    }

</script>




