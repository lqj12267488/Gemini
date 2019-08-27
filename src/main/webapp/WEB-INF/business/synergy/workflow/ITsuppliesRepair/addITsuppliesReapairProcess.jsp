<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <div class="col-md-3 tar">
        设备名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="deviceNameShow" type="text" onclick="showMenu()"  value="${ITSuppliesRepair.deviceNameShow}" readonly/>
        </div>
        <div id="menuContent" class="menuContent" style="display: none">
            <ul id="deviceNameTree" class="ztree"></ul>
        </div>
        <input id="deviceName" type="hidden" value="${ITSuppliesRepair.deviceName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${ITSuppliesRepair.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${ITSuppliesRepair.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${ITSuppliesRepair.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
                        <textarea id="f_reason" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${ITSuppliesRepair.reason}">${ITSuppliesRepair.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="f_remark" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${ITSuppliesRepair.remark}">${ITSuppliesRepair.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/ITSuppliesRepair/printITSuppliesRepair?id=${ITSuppliesRepair.id}">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=YZCHC", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
        });
    })
</script>