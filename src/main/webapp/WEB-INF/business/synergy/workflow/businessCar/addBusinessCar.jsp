<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%-- 已办 查看流程页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/businessCar/printBusinessCar?id=${businessCar.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"  readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        起始时间
    </div>
    <div class="col-md-9">
        <input id="f_startTime" type="datetime-local"  readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.startTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        结束时间
    </div>
    <div class="col-md-9">
        <input id="f_endTime" type="datetime-local"  readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.endTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        始发地
    </div>
    <div class="col-md-9">
        <input id="f_startPlace" type="text"  readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.startPlace}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
       目的地
    </div>
    <div class="col-md-9">
        <input id="f_endPlace" type="text"  readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.endPlace}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        用车类型
    </div>
    <div class="col-md-9">
        <div>
            <input id="cartypeShow" type="text"  value="${businessCar.carTypeShow}" readonly="readonly" />
        </div>
        <div id="menuContent" class="menuContent">

        </div>
        <input id="cartype" type="hidden" value="${businessCar.carType}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
        <input id="f_reason" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.reason}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        人数
    </div>
    <div class="col-md-9">
        <input id="f_peopleNum"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${businessCar.peopleNum}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <input id="f_remark" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${businessCar.remark}" readonly="readonly"/>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=GWYCGL", function (data) {
            var cartypeTree = $.fn.zTree.init($("#cartypeTree"), setting, data);
        });
    })
</script>
