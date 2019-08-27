<%--礼堂使用管理办理页面
  Created by IntelliJ IDEA.
  User: qw
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<div class="form-row">
    <div class="col-md-3 tar">
        报修类型
    </div>
    <div class="col-md-9">
        <input id="h_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.repairTypeShow}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        资产编号
    </div>
    <div class="col-md-9">
        <input id="h_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.assetsID}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        所在位置
    </div>
    <div class="col-md-9">
        <input id="h_requestDate" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.position}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        所在部门
    </div>
    <div class="col-md-9">
        <input id="h_leader" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.dept}" readonly="readonly"/>
    </div>
</div>


<div class="form-row">
    <div class="col-md-3 tar">
        报修物品名称
    </div>
    <div class="col-md-9">
        <input id="h_endTime" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.itemName}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        联系人电话
    </div>
    <div class="col-md-9">
        <input id="contactNumber" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.contactNumber}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        故障描述
    </div>
    <div class="col-md-9">
        <input id="faultDescription" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${repair.faultDescription}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        维修地址
    </div>
    <div class="col-md-9">
        <input id="repairAddress" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${repair.repairAddress} " readonly="readonly" />
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/repair/distribution");
    }
</script>