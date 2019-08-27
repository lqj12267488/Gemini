<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<input id="printFunds" hidden value="<%=request.getContextPath()%>/mealCardHandle/printMealCardHandle?id=${mealCardHandle.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请教师部门
    </div>
    <div class="col-md-9">
        <input id="deptId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.deptId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请办卡教师
    </div>
    <div class="col-md-9">
        <input id="teacherId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.teacherId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        饭卡类型
    </div>
    <div class="col-md-9">
        <input id="mealCardType" type="text" class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.mealCardTypeShow}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请办卡时间
    </div>
    <div class="col-md-9">
        <input id="mealCardTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${mealCardHandle.mealCardTime}" readonly="readonly"/>
    </div>

</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${mealCardHandle.remark}">${mealCardHandle.remark}</textarea>
    </div>
</div>
<script>


</script>
