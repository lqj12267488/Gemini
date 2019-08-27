<%--校内车辆管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/10
  Time: 14:19
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
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolVehicle.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolVehicle.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolVehicle.requestTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        车辆品牌及型号
    </div>
    <div class="col-md-9">
        <input id="vehicleModel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="12" placeholder="最多输入12个字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolVehicle.vehicleModel}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        车牌号码
    </div>
    <div class="col-md-9">
        <input id="vehicleNum" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="6" placeholder="最多输入6个汉字"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolVehicle.vehicleNum}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        是否为本人车辆
    </div>
    <div class="col-md-9">
        <select  id="vehicleIf" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="remark" maxlength="65" placeholder="最多输入65个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolVehicle.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${schoolVehicle.id}"/>
<input id="workflowCode" hidden value="T_BG_NOWORKDAYPLACE_WF01">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'vehicleIf','${schoolVehicle.vehicleIf}');
        });
    })
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var requestTime = $("#requestTime").val();
        requestTime = requestTime.replace('T', '');
        if ($("#vehicleModel").val() == "" || $("#vehicleModel").val() == undefined) {
            swal({
                title: "请填写车辆品牌及型号！",
                type: "info"
            });
            return;
        }
        if ($("#vehicleNum").val() == "" || $("#vehicleNum").val() == undefined) {
            swal({
                title: "请填写车牌号码！",
                type: "info"
            });
            return;
        }
        if($("#vehicleIf").val()=="" || $("#vehicleIf").val() == undefined){
            swal({
                title: "请选择是否为本人车辆！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/schoolVehicle/saveSchoolVehicle", {
            id:$("#id").val(),
            vehicleModel: $("#vehicleModel").val(),
            vehicleNum:$("#vehicleNum").val(),
            vehicleIf:$("#vehicleIf").val(),
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestTime:requestTime,
            remark:$("#remark").val()
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