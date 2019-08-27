<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/26
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${notice.createDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${notice.creator}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="publicTime" type="text"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${notice.publicTime}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <input id="ntitle" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${notice.title}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        类型
    </div>
    <div class="col-md-9">
        <input id="typeShow"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${notice.typeShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        内容
    </div>
    <div class="col-md-9">
        <div class="validate[required,maxSize[100]] form-control" style="height: auto">
            ${notice.content}
        </div>
    </div>
</div>
<input id="id" hidden value="${notice.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/notice/printNotice?id=${notice.id}">


