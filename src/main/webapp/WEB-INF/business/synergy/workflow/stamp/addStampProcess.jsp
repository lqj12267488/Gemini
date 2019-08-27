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
        合同类型
    </div>
    <div class="col-md-9">
        <select  id="stampFlag" disabled="disabled" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        合同内容
    </div>
    <div class="col-md-9">
        <textarea id="contractDetails"  class="validate[required,maxSize[20]] form-control" readonly="readonly"
                  value="${stamp.contractDetails}">${stamp.contractDetails}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${stamp.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${stamp.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${stamp.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${stamp.remark}">${stamp.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/stamp/printStamp?id=${stamp.id}">

<script>

    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YZLX", function (data) {
                addOption(data, 'stampFlag','${stamp.stampFlag}');
            });
        })


    })

</script>
