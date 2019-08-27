<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/20
  Time: 8:42
  To change this template use File | Settings | File Templates.
--%>
<%-- 已办 查看流程页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/shopItemsReceive/printShopItemsReceive?id=${shopItemsReceive.id}">
    <div class="form-row">
        <div class="col-md-3 tar">
            申请部门
        </div>
        <div class="col-md-9">
            <input id="f_requestDept" type="text"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requestDept}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            申请人
        </div>
        <div class="col-md-9">
            <input id="f_requester" type="text"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requester}" readonly="readonly"/>
        </div>
    </div>

    <div class="form-row">
        <div class="col-md-3 tar">
            申请日期
        </div>
        <div class="col-md-9">
            <input id="f_requestDate" type="datetime-local"  readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requestDate}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            标准(元/人)
        </div>
        <div class="col-md-9">
            <input id="standard" type="text"  readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.standard}"/>
        </div>
    </div>
<div class="form-row">
    <div class="col-md-3 tar">
        人数
    </div>
    <div class="col-md-9">
        <input id="peopleNumber"  type="text" readonly="readonly"
                  class="validate[required,maxSize[20]] form-control"
                  value="${shopItemsReceive.peopleNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        总金额
    </div>
    <div class="col-md-9">
        <input id="totalAmount"   type="text" readonly="readonly"
                  class="validate[required,maxSize[20]] form-control"
                  value="${shopItemsReceive.totalAmount}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        用途
    </div>
    <div class="col-md-9">
        <input id="use" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${shopItemsReceive.use}" readonly="readonly"/>
    </div>
</div>
    <div class="form-row">
        <div class="col-md-3 tar">
            备注
        </div>
        <div class="col-md-9">
            <input id="remark" type="text"
                   class="validate[required,maxSize[100]] form-control"
                   value="${shopItemsReceive.remark}" readonly="readonly"/>
        </div>
    </div>
<script>


</script>
