<%--校内车辆管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/10
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/schoolVehicle/printSchoolVehicle?id=${schoolVehicle.id}">
<div class="form-row">
    <div class="col-md-3 tar">
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
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolVehicle.requestTime}" readonly/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        车辆品牌及型号
    </div>
    <div class="col-md-9">
        <input id="vehicleModel" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolVehicle.vehicleModel}" readonly/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        车牌号码
    </div>
    <div class="col-md-9">
        <input id="vehicleNum" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolVehicle.vehicleNum}" readonly/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        是否为本人车辆
    </div>
    <div class="col-md-9">
        <select  id="vehicleIf" disabled/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="remark"
                                  class="validate[required,maxSize[100]] form-control"
                        readonly>${schoolVehicle.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${schoolVehicle.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'vehicleIf','${schoolVehicle.vehicleIf}');
        });
    })
</script>