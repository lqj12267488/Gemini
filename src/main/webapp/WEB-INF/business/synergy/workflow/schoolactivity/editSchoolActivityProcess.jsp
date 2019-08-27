<%--协同办公-校外人员进校参加活动管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/11
  Time: 11:05
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
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        活动名称
    </div>
    <div class="col-md-10">
        <input id="activityName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        活动内容
    </div>
    <div class="col-md-10">
        <input id="activityContent" type="text"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="165" placeholder="最多输入165个字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityContent}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        活动地点
    </div>
    <div class="col-md-10">
        <input id="activityPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityPlace}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        开始时间
    </div>
    <div class="col-md-4">
        <input id="startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.startTime}"/>
    </div>
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        结束时间
    </div>
    <div class="col-md-4">
        <input id="endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.endTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        进校人数
    </div>
    <div class="col-md-4">
        <input id="peopleNumber" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.peopleNumber}"/>
    </div>
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        车辆数量
    </div>
    <div class="col-md-4">
        <input id="carNumber" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.carNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        组织部门
    </div>
    <div class="col-md-10">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        负责人
    </div>
    <div class="col-md-10">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-10">
        <input id="requestTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requestTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        <span class="iconBtx">*</span>
        联系电话
    </div>
    <div class="col-md-10">
        <input id="contactPhone" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.contactPhone}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        安全措施
    </div>
    <div class="col-md-10">
                        <textarea id="safetyStep" style="height: 100px" maxlength="165" placeholder="最多输入165个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolActivity.safetyStep}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        备注
    </div>
    <div class="col-md-10">
                        <textarea id="remark" maxlength="165" placeholder="最多输入165个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolActivity.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${schoolActivity.id}"/>
<input id="workflowCode" hidden value="T_BG_NOWORKDAYPLACE_WF01">
<script>
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save() {
        var requestTime = $("#requestTime").val();
        requestTime = requestTime.replace('T', '');
        if ($("#activityName").val() == "" || $("#activityName").val() == undefined) {
            swal({
                title: "请填写活动名称！",
                type: "info"
            });
            return;
        }
        if ($("#activityContent").val() == "" || $("#activityContent").val() == undefined) {
            swal({
                title: "请填写活动内容！",
                type: "info"
            });
            return;
        }
        if ($("#activityPlace").val() == "" || $("#activityPlace").val() == undefined) {
            swal({
                title: "请填写活动地点！",
                type: "info"
            });
            return;
        }
        if ($("#startTime").val() == "" || $("#startTime").val() == undefined) {
            swal({
                title: "请填写精确的开始时间！",
                type: "info"
            });
            return;
        }
        if ($("#endTime").val() == "" || $("#endTime").val() == undefined) {
            swal({
                title: "请填写精确的结束时间！",
                type: "info"
            });
            return;
        }
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        if (startTime > endTime) {
            swal({
                title: "开始时间必须早于结束时间！",
                type: "info"
            });
            return;
        }
        startTime = startTime.replace('T', '');
        endTime = endTime.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        if ($("#peopleNumber").val() == "" || $("#peopleNumber").val() == undefined) {
            swal({
                title: "请填写进校人数！",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#peopleNumber").val())) {
            swal({
                title: "进校人数请填写整数！",
                type: "info"
            });
            return;
        }
        if ($("#carNumber").val() == "" || $("#carNumber").val() == undefined) {
            swal({
                title: "请填写车辆数量！",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#carNumber").val())) {
            swal({
                title: "车辆数量请填写整数！",
                type: "info"
            });
            return;
        }
        if ($("#contactPhone").val() == "" || $("#contactPhone").val() == undefined) {
            swal({
                title: "请填写联系电话！",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#contactPhone").val())) {
            swal({
                title: "联系电话请填写整数！",
                type: "info"
            });
            return;
        }
        startTime = startTime.replace('T', '');
        endTime = endTime.replace('T', '');
        $.post("<%=request.getContextPath()%>/schoolActivity/saveSchoolActivity", {
            id: $("#id").val(),
            activityName: $("#activityName").val(),
            activityContent: $("#activityContent").val(),
            activityPlace: $("#activityPlace").val(),
            startTime: startTime,
            endTime: endTime,
            peopleNumber: $("#peopleNumber").val(),
            carNumber: $("#carNumber").val(),
            requestTime: requestTime,
            contactPhone: $("#contactPhone").val(),
            safetyStep: $("#safetyStep").val(),
            remark: $("#remark").val()
        }, function (msg) {
//          保存后刷新页面数据表
            if (msg.status == 1) {
                /*swal({title: msg.msg, type: "success"});*/
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>