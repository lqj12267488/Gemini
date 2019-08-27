<%--学校车辆外出使用管理待办修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/28 0028
  Time: 下午 4:51
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
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="s_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="s_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="s_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requestDate}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        开始时间
    </div>
    <div class="col-md-9">
        <input id="s_startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.startTime}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        结束时间
    </div>
    <div class="col-md-9">
        <input id="s_endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.endTime}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        始发地
    </div>
    <div class="col-md-9">
        <input id="s_startPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.startPlace}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        目的地
    </div>
    <div class="col-md-9">
        <input id="s_endPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.endPlace}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        使用车辆
    </div>
    <div class="col-md-9">
        <select  id="s_carType" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请事由
    </div>
    <div class="col-md-9">
                        <textarea id="s_reason" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolCar.reason}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        人数
    </div>
    <div class="col-md-9">
        <input id="s_peopleNum" type="text" placeholder="请填写数字"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolCar.peopleNum}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="s_remark" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolCar.remark}</textarea>
    </div>
</div>
<input id="s_Id" hidden value="${schoolCar.id}"/>
<input id="workflowCode" hidden value="T_BG_SCHOOLCAR_WF01">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=XXCLLX", function (data) {
            addOption(data, 's_carType','${schoolCar.carType}');
        });
    })
    /**功能：修改的申请信保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var date = $("#s_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        var daysFlag=1;
        if ($("#s_startTime").val() == "" || $("#s_startTime").val() == "0" || $("#s_startTime").val() == undefined) {
            swal({
                title: "请填写精确的开始时间！",
                type: "info"
            });
            daysFlag=0;
            return;
        }
        if ($("#s_endTime").val() == "" || $("#s_endTime").val() == "0" || $("#s_endTime").val() == undefined) {
            swal({
                title: "请填写精确的结束时间！",
                type: "info"
            });
            daysFlag=0;
            return;
        }
        if ($("#s_startPlace").val() == "" || $("#s_startPlace").val() == "0" || $("#s_startPlace").val() == undefined) {
            swal({
                title: "请填写始发地！",
                type: "info"
            });
            return;
        }
        if ($("#s_endPlace").val() == "" || $("#s_endPlace").val() == "0" || $("#s_endPlace").val() == undefined) {
            swal({
                title: "请填写目的地！",
                type: "info"
            });
            return;
        }
        if ($("#s_carType").val() == "" || $("#s_carType").val() == "0" || $("#s_carType").val() == undefined) {
            swal({
                title: "请选择使用车型！",
                type: "info"
            });
            return;
        }
        if ($("#s_reason").val() == "" || $("#s_reason").val() == "0" || $("#s_reason").val() == undefined) {
            swal({
                title: "请填写事由！",
                type: "info"
            });
            return;
        }
        if ($("#s_peopleNum").val() == "" || $("#s_peopleNum").val() == "0" || $("#s_peopleNum").val() == undefined) {
            swal({
                title: "请填写人数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#s_peopleNum").val())){
            swal({
                title: "人数请填写整数！",
                type: "info"
            });
            return;
        }
        var startTime = $("#s_startTime").val();
        var endTime =$("#s_endTime").val();
        if(startTime>endTime){
            swal({
                title: "开始时间必须早于结束时间！",
                type: "info"
            });
            return;
        }
        startTime = startTime.replace('T', '');
        endTime = endTime.replace('T', '');
        $.post("<%=request.getContextPath()%>/schoolCar/saveSchoolCar", {
            id:$("#s_Id").val(),
            requestDept: $("#s_requestDept").val(),
            requester: $("#s_requester").val(),
            requestDate:date,
            startTime:startTime,
            endTime:endTime,
            startPlace: $("#s_startPlace").val(),
            endPlace: $("#s_endPlace").val(),
            carType: $("#s_carType").val(),
            reason: $("#s_reason").val(),
            peopleNum: $("#s_peopleNum").val(),
            remark:$("#s_remark").val(),
            checkFlag:0,
            requesterConfirmFlag:0
        }, function (msg) {
            if (msg.status == 1) {
                // swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#hotelStayGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>

