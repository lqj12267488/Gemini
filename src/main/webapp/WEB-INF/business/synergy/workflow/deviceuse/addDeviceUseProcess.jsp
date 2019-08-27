<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/15
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-3 tar">
        设备名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="deviceUseNameShow" type="text" value="${deviceUse.deviceUseNameShow}" readonly="readonly"/>
        </div>
        <div id="menuContent" class="menuContent" style="display: none">
            <ul id="deviceNameTree" class="ztree"></ul>
        </div>
        <input id="deviceName" type="hidden" value="${deviceUse.deviceName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
        <textarea id="reason"  class="validate[required,maxSize[100]] form-control" readonly="readonly"
                  value="${deviceUse.reason}">${deviceUse.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${deviceUse.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="manager" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${deviceUse.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local" class="validate[required,maxSize[20]] form-control" readonly="readonly"
               value="${deviceUse.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>

    <div class="col-md-9">
        <textarea id="remark" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${stamp.remark}">${deviceUse.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/deviceUse/printDeviceUse?id=${deviceUse.id}">

<script>

    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=ITSB", function (data) {
                var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
            });
        })
    })

</script>

