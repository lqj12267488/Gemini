<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/29
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-3 tar">
        申请内容
    </div>
    <div class="col-md-9">
        <textarea id="content"  class="validate[required,maxSize[100]] form-control" readonly="readonly"
                  value="${screenUse.content}">${screenUse.content}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        大屏幕
    </div>
    <div class="col-md-9">
        <div>
            <input id="screenShow" type="text" value="${screenUse.screenShow}" readonly="readonly"/>
        </div>
        <div id="menuContent" class="menuContent" style="display: none">
            <ul id="screenUseTree" class="ztree"></ul>
        </div>
        <input id="screen" type="hidden" value="${screenUse.screen}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local" class="validate[required,maxSize[20]] form-control" readonly="readonly"
               value="${screenUse.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        使用日期
    </div>
    <div class="col-md-9">
        <input id="usingTime" type="datetime-local" class="validate[required,maxSize[20]] form-control" readonly="readonly"
               value="${screenUse.usingTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${screenUse.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${screenUse.requester}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>

    <div class="col-md-9">
        <textarea id="remark" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${screenUse.remark}">${screenUse.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/screenUse/printScreenUse?id=${screenUse.id}">
<script>
    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=DPM", function (data) {
                var screenUseTree = $.fn.zTree.init($("#screenUseTree"), setting, data);
            });
        })
    })
</script>