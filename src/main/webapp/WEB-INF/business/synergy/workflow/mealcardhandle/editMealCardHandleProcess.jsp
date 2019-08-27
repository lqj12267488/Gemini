<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 16:09
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
<input type="hidden" id="id" value="${mealCardHandle.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.deptId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.teacherId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${mealCardHandle.mealCardTime}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        饭卡类型
    </div>
    <div class="col-md-9">
        <select id="f_mealCardType" ></select>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请办卡时间
    </div>
    <div class="col-md-9">
        <input id="f_mealCardTime" value="${mealCardHandle.mealCardTime}"
               type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="f_remark" maxlength="165" placeholder="最多输入165个字"
                  class="validate[required,maxSize[100]] form-control">${mealCardHandle.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_MEALCARD_HANDLE_WF01">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=FKLX", function (data) {
            addOption(data, 'f_mealCardType', '${mealCardHandle.mealCardType}');
        });
    })
    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#f_mealCardType").val() == "" || $("#f_mealCardType").val() == "0" || $("#f_mealCardType").val() == undefined) {
            swal({
                title: "请填写饭卡类型！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/mealCardHandle/saveMealCardHandle", {
            id: $("#id").val(),
            mealCardType: $("#f_mealCardType").val(),
            remark: $("#f_remark").val(),
            mealCardTime: date
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({title: msg.msg, type: "success"});*/
                $("#dialog").modal('hide');
                $('#mealCardHandleGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>


