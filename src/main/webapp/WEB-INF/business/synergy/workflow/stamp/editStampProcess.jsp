<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
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
<input type="hidden" id="stampid" value="${stamp.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        印章类型
    </div>
    <div class="col-md-9">
        <select id="stampFlag"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        合同内容（用途）
    </div>
    <div class="col-md-9">
        <input id="contractDetails" type="text" maxlength="330" placeholder="最多输入330个字"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[20]] form-control"
               value="${stamp.contractDetails}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${stamp.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        经办人
    </div>
    <div class="col-md-9">
        <input id="manager" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${stamp.manager}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" value="${stamp.requestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control">${stamp.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_STAMP_WF">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/stamp/printStamp?id=${stamp.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YZLX", function (data) {
            addOption(data, 'stampFlag', '${stamp.stampFlag}');
        });
        if($('#stampFlag').val()=='1'){
            $('#workflowCode').val($('#workflowCode').val()+'01');
        }else{
            $('#workflowCode').val($('#workflowCode').val()+'02');
        }
    })


    function save() {
        var date = $("#requestDate").val();
        date = date.replace('T', '');
        if ($("#stampFlag").val() == "" || $("#stampFlag").val() == undefined) {
            swal({
                title: "请选择印章类型!",
                type: "info"
            });
            return;
        }
        if ($("#contractDetails").val() == "" || $("#contractDetails").val() == "0" || $("#contractDetails").val() == undefined) {
            swal({
                title: "请填写合同内容!",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/stamp/saveStamp", {
            id: $("#stampid").val(),
            stampFlag: $("#stampFlag option:selected").val(),
            contractDetails: $("#contractDetails").val(),
            remark: $("#remark").val(),
            requestDate: date
        }, function (msg) {
            if (msg.status == 1) {
                $('#stampGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>

