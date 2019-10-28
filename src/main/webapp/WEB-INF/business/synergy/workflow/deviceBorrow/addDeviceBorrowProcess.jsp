<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.requestDate}" ="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        借用时间
    </div>
    <div class="col-md-9">
        <input id="f_borrowTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.borrowTime}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        归还时间
    </div>
    <div class="col-md-9">
        <input id="f_revertTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${deviceBorrow.revertTime}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        设备清单
    </div>
    <div class="col-md-9">
        <textarea id="f_deviceList" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${deviceBorrow.deviceList}">${deviceBorrow.deviceList}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        活动内容
    </div>
    <div class="col-md-9">
        <textarea id="f_activityContent" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${deviceBorrow.activityContent}">${deviceBorrow.activityContent}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/deviceBorrow/printDeviceBorrow?id=${deviceBorrow.id}">
<script>


</script>
