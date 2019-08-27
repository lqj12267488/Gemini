<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/21
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假部门
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               readonly="readonly"   value="${leaveCancel.cancelRequestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假人
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               readonly="readonly"   value="${leaveCancel.cancelRequester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假日期
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDate" readonly="readonly"   value="${leaveCancel.cancelRequestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假开始时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelStartTime" type="date" class="validate[required,maxSize[100]] form-control"
               readonly="readonly"   value="${leaveCancel.cancelStartTime}" onblur="chaa()"  />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假结束时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelEndTime" type="date"  class="validate[required,maxSize[100]] form-control"
               readonly="readonly"   value="${leaveCancel.cancelEndTime}" onblur="chaa()"  />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        实际请假天数
    </div>
    <div class="col-md-9">
        <input  id="x_realDays" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                 readonly="readonly"   value="${leaveCancel.realDays}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假原因
    </div>
    <div class="col-md-9">
              <textarea id="x_cancelReason"  class="validate[required,maxSize[100]] form-control"
              readonly="readonly"         value="${leaveCancel.cancelReason}">${leaveCancel.cancelReason}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/leaveCancel/printLeaveCancels?id=${leaveCancel.id}">
<script>
</script>
