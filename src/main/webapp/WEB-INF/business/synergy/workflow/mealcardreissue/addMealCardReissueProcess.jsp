<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/11
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/mealCardReissue/printMealCardReissue?id=${mealCardReissue.id}">

<div class="form-row">
    <div class="col-md-3 tar">
        申请教师部门
    </div>
    <div class="col-md-9">
        <input id="deptId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardReissue.deptId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请补卡教师
    </div>
    <div class="col-md-9">
        <input id="teacherId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardReissue.teacherId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        补卡原因
    </div>
    <div class="col-md-9">
        <input id="reissueReason" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardReissue.reissueReasonShow}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        补卡待遇
    </div>
    <div class="col-md-9">
        <input id="treatment" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardReissue.treatment}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        补卡时间
    </div>
    <div class="col-md-9">
        <input id="mealCardTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${mealCardReissue.reissueTime}" readonly="readonly"/>
    </div>

</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${mealCardReissue.remark}">${mealCardReissue.remark}</textarea>
    </div>
</div>
<script>


</script>
