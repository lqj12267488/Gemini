<%--学校商友酒店住宿管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/21
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/hotelStay/printHotelStay?id=${hotelStay.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="h_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="h_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="h_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        事由
    </div>
    <div class="col-md-9">
                        <textarea id="h_reason"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${hotelStay.reason}" readonly="readonly">${hotelStay.reason}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        住宿人数
    </div>
    <div class="col-md-9">
        <input id="h_peopleNumber" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.peopleNumber}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        入住时间
    </div>
    <div class="col-md-9">
        <input id="h_checkInTime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hotelStay.checkInTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        离店时间
    </div>
    <div class="col-md-9">
        <input id="h_checkOutTime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hotelStay.checkOutTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        住宿标准
    </div>
    <div class="col-md-9">
        <input id="h_price" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.price}" readonly="readonly"
               onmouseout="totalAmount()"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        住宿天数
    </div>
    <div class="col-md-9">
        <input id="h_stayDays" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${hotelStay.stayDays}"  readonly="readonly"
               onclick="computeDays()" onmouseout="totalAmount()"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        合计
    </div>
    <div class="col-md-9">
                        <textarea id="h_totalAmount"
                                  class="validate[required,maxSize[100]] form-control"  readonly="readonly">${hotelStay.totalAmount}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="h_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${hotelStay.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${hotelStay.id}">
