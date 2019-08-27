<%--资产报废管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/AssetsScrap/printAssetsScrap?id=${AssetsScrap.id}">
<%--<div class="form-row">
    <div class="col-md-3 tar">
        资产编号
    </div>
    <div class="col-md-9">
        <input id="f_assetsId" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.assetsId}" readonly="readonly"/>
    </div>
</div>--%>

<div class="form-row">
    <div class="col-md-3 tar">
        资产名称
    </div>
    <div class="col-md-9">
        <input id="f_assetsName" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${AssetsScrap.assetsName}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        报废原因
    </div>
    <div class="col-md-9">
                        <textarea id="f_reason"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${softinstall.reason}" readonly="readonly">${AssetsScrap.reason}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="f_manager" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.manager}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="f_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${AssetsScrap.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${AssetsScrap.id}">