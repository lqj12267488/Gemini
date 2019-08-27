<%--非工作日学校场所使用管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/19
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/noWorkDayPlace/printNoWorkDayPlace?id=${noWorkDayPlace.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="n_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="n_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="n_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        开始时间
    </div>
    <div class="col-md-9">
        <input id="n_startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.startTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        结束时间
    </div>
    <div class="col-md-9">
        <input id="n_endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.endTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        活动内容
    </div>
    <div class="col-md-9">
                        <textarea id="n_content"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${noWorkDayPlace.content}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        人数
    </div>
    <div class="col-md-9">
        <input id="n_peopleNumber" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${noWorkDayPlace.peopleNumber}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用场所
    </div>
    <div class="col-md-9">
        <input id="n_usePlace" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.usePlace}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用性质
    </div>
    <div class="col-md-9">
        <input id="n_useProperty" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.useProperty}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="n_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${noWorkDayPlace.remark}</textarea>
    </div>
</div>
<input id="n_id" hidden value="${noWorkDayPlace.id}">