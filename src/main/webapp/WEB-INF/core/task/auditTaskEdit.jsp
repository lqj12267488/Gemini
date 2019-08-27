<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<input id="taskId" name="taskId"  hidden value="${sysTask.taskId}">
<input id="fundId" name="fundId"  hidden value="${sysTask.id}">
<input id="tableName" hidden value="T_BG_FUNDS_WF">
<input id="workflowCode" hidden value="T_BG_FUNDS_WF01">
<input id="businessId" hidden>
<input id="workflowId" hidden>
<div class="form-row">
    <div class="col-md-3 tar">
        经办部门
    </div>
    <div class="col-md-9">
        <input id="deptShow" value="${sysTask.deptShow}" readonly  class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="personShow" value="${sysTask.personShow}" readonly  class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="taskTime" type="text" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${sysTask.taskTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请款原因
    </div>
    <div class="col-md-9">
        <textarea id="taskTitle"
                  class="validate[required,maxSize[2000]] form-control">${sysTask.taskTitle}</textarea>
    </div>

</div>

<div class="form-row" style="text-align: center">
    <button type="button" class="btn btn-default btn-clean"
            onclick="submitRequest()">提交申请
    </button>

</div>

<script>
    function submitRequest() {
        var taskTitle=$("#taskTitle").val();
        var taskId=$("#taskId").val();
        var fundId=$("#fundId").val();
        if(taskTitle.length==0){
            alert("请填写请款原因");
        }else if(taskTitle.length==2000){
            alert("请款原因长度过长");
        }else{
            $("#businessId").val(fundId);
            $("#workflowId").val(taskId);
            getAuditer();

        }

    }
    function getAuditer() {
        $("#dialog").modal().load("/toSelectAuditer");
    }

    function audit() {

        var personId = $("#personId option:selected").val();
        var handleName = $("#personId option:selected").text();
        $.post("/submitTask", {
                businessId: $("#businessId").val(),
                workflowId: $("#workflowId").val(),
                tableName: "T_BG_FUNDS_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName

            },
            function (msg) {
                if (msg.status == 1) {
                    alert(msg.msg);
                    $("#dialog").modal("hide");
                    $("#audit").modal("hide");
                    $("#unAudit").load("/loadIndexUnAudit")
                }
            })
    }

</script>

