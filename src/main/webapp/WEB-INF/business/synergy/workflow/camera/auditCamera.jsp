<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%--待办里的办理页面--%>

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
               value="${camera.requestDept}"/>
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
               value="${camera.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.requestDate}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        拍摄时间
    </div>
    <div class="col-md-9">
        <input id="shootDate" type="datetime-local"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        拍摄地点
    </div>
    <div class="col-md-9">
        <input id="shootingLocation" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootingLocation}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        拍摄方法
    </div>
    <div class="col-md-9">
        <input id="shootingMethod"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootingMethod}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        摄影机机位数
    </div>
    <div class="col-md-9">
        <input id="machineNumber"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${camera.machineNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        活动内容
    </div>
    <div class="col-md-9">
        <input id="content"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${camera.content}"/>
    </div>
</div>
<input id="id" hidden value="${camera.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/camera/printCamera?id=${camera.id}">
