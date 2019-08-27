<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-3 tar">
        采购物品
    </div>
    <div class="col-md-9">
        <input id="goodsBigName" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.goodsBigName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        采购数量
    </div>
    <div class="col-md-9">
        <input id="goodsBigNum" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.goodsBigNum}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        物品单位
    </div>
    <div class="col-md-9">
        <input id="unit" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.unit}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
        <textarea id="reason"  class="validate[required,maxSize[100]] form-control" readonly="readonly"
                  value="${goodsPurchasingBig.reason}">${goodsPurchasingBig.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        预算(万元)
    </div>
    <div class="col-md-9">
        <input id="budget" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.budget}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local" class="validate[required,maxSize[20]] form-control" readonly="readonly"
               value="${goodsPurchasingBig.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.requester}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${goodsPurchasingBig.remark}">${goodsPurchasingBig.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/goodsPurchasingBig/printGoodsPurchasingBig?id=${goodsPurchasingBig.id}">
<script>


</script>