<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/19
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<input id="printFunds" hidden value="<%=request.getContextPath()%>/fileQuery/printFileQuery?id=${fileQuery.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${fileQuery.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${fileQuery.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${fileQuery.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        查询内容
    </div>
    <div class="col-md-9">
        <textarea id="queryContent" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${fileQuery.queryContent}">${fileQuery.queryContent}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${fileQuery.remark}">${fileQuery.remark}</textarea>
    </div>
</div>
<script>


</script>
