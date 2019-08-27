<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请原因
    </div>
    <div class="col-md-9">
        <textarea id="a_reason"
                  class="validate[required,maxSize[100]] form-control"
                  value="${leagues.reason}">${leagues.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        金额
    </div>
    <div class="col-md-9">
        <input id="a_amount" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leagues.amount}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="a_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${leagues.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="a_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${leagues.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="a_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${leagues.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="a_remark" class="validate[required,maxSize[100]] form-control">${leagues.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${leagues.id}">
<input id="workflowCode" hidden value="T_BG_LEAGUE_WF01">
<script>

    function save() {
        if ($("#a_reason").val() == "" || $("#a_reason").val() == "0" || $("#a_reason").val() == undefined) {
            swal({
                title: "请填写申请原因",
                type: "info"
            });
            //alert("请填写申请原因");
            return;
        }
        if ($("#a_amount").val() == "" ||  $("#a_amount").val() == undefined) {
            swal({
                title: "请填写小写金额",
                type: "info"
            });
            //alert("请填写小写金额");
            return;
        }
        var date = $("#a_requestDate").val().replace("T"," ");
        $.post("<%=request.getContextPath()%>/leagues/saveLeague", {
            id: $("#id").val(),
            amount: $("#a_amount").val(),
            requestDate:date,
            remark: $("#a_remark").val(),
            reason:$("#a_reason").val()
        }, function (msg) {
            if (msg.status == 1) {
                $('#leaguesTable').DataTable().ajax.reload();

            }
        })
        return true;
    }
    function back() {
        $("#right").load('<%=request.getContextPath()%>/leagues/process');
    }
</script>
