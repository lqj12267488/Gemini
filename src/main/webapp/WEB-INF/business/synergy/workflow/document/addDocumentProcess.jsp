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
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" readonly="readonly" value="${document.requestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        拟稿
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        文件标题
    </div>
    <div class="col-md-9">
        <input id="f_fileTitle" type="text" class="validate[required,maxSize[100]] form-control"
               value="${document.fileTitle}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        主送
    </div>
    <div class="col-md-9">
        <input id="f_deliveryEmpIdShow"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.deliveryEmpIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        抄送
    </div>
    <div class="col-md-9">
        <input id="f_makeEmpIdShow"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.makeEmpIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        密级
    </div>
    <div class="col-md-9">
        <select id="f_secretClass" disabled="disabled" class="validate[required,maxSize[100]] form-control"></select>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <input id="f_title" type="text" class="validate[required,maxSize[100]] form-control"
               value="${document.title}" readonly="readonly"/>
    </div>
</div>--%>

<div class="form-row">
    <div class="col-md-3 tar">
        打印份数
    </div>
    <div class="col-md-9">
        <input id="f_printingNumber" type="text" class="validate[required,maxSize[100]] form-control"
               value="${document.printingNumber}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        文号
    </div>
    <div class="col-md-9">
        <input id="f_symbol" type="text" class="validate[required,maxSize[100]] form-control"
               value="${document.symbol}" readonly="readonly"/>
    </div>
</div>

<input id="printFunds" hidden
       value="<%=request.getContextPath()%>/document/printDocument?id=${document.id}">
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MJ", function (data) {
            addOption(data, 'f_secretClass', '${document.secretClass}');
        });
    })
</script>