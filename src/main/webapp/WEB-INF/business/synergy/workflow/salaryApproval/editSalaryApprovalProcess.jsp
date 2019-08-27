<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/18
  Time: 17:46
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
<input type="hidden" id="salaryApprovalid" value="${salaryApproval.id}">

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${salaryApproval.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${salaryApproval.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${salaryApproval.requestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        年份
    </div>
    <div class="col-md-9">
        <input id="f_year" type="number" placeholder="请输入标准年份"
               class="validate[required,maxSize[100]] form-control" value="${salaryApproval.year}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        月份
    </div>
    <div class="col-md-9">
        <input id="f_month" type="number" placeholder="请输入标准月份"
               class="validate[required,maxSize[100]] form-control" value="${salaryApproval.month}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        工资单名称
    </div>
    <div class="col-md-9">
        <textarea id="f_fileName" maxlength="12" placeholder="最多输入12个字"
                  class="validate[required,maxSize[100]] form-control">${salaryApproval.fileName}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control">${salaryApproval.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_SALARYAPPROVAL_WF01">

<script>
    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        var fyear = $("#f_year").val();
        var fmonth= $("#f_month").val();
        if(null !=fyear && fyear !="" && fyear.length!=4){
            swal({
                title: "请输入正确的年份！",
                type: "info"
            });
            $("#f_year").val("");
            return;
        }
        if( null !=fmonth && fmonth!="" && (parseInt(fmonth)>12 || parseInt(fmonth)<1)){
            swal({
                title: "请输入正确的月份！",
                type: "info"
            });
            $("#f_month").val("");
            return;
        }
        if($("#f_fileName").val() =="" ||  $("#f_fileName").val() =="0" || $("#f_fileName").val() == undefined){
            swal({
                title: "工资单名称！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/salaryApproval/saveSalaryApproval", {
            id: $("#salaryApprovalid").val(),
            requestDept: $("#f_requestDept").val(),
            requestDate: date,
            requester: $("#f_requester").val(),
            year: $("#f_year").val(),
            month: $("#f_month").val(),
            fileName: $("#f_fileName").val(),
            remark: $("#f_remark").val(),
        }, function (msg) {
            if (msg.status == 1) {
                $('#salaryApprovalGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>

