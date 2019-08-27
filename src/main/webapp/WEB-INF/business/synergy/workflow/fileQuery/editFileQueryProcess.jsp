<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/19
  Time: 19:06
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
<input type="hidden" id="fileQueryid" value="${fileQuery.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${fileQuery.requestDept}"/>
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
               value="${fileQuery.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${fileQuery.requestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        查询内容
    </div>
    <div class="col-md-9">
        <input id="f_queryContent" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="330" placeholder="最多输入330个字"
               class="validate[required,maxSize[20]] form-control"
               value="${fileQuery.queryContent}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control">${fileQuery.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_FILEQUERY_WF01">
<script>
    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#f_queryContent").val() == "" || $("#f_queryContent").val() == "0" || $("#f_queryContent").val() == undefined) {
            swal({
                title: "请填写查询内容",
                type: "info"
            });
            //alert("请填写查询内容");
            return;
        }

        $.post("<%=request.getContextPath()%>/fileQuery/saveFileQuery", {
            id: $("#fileQueryid").val(),
            queryContent: $("#f_queryContent").val(),
            remark: $("#f_remark").val(),
            requestDate: date
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#fileQueryGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>

