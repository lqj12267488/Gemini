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
        <input id="m_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${message.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="m_requester"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${message.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="m_publicTime" type="text"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${message.publicTime}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <input id="m_title" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${message.title}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        类型
    </div>
    <div class="col-md-9">
        <input id="f_typeShow"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${message.typeShow}"/>
    </div>
</div>
<div class="form-row">
<div class="col-md-3 tar">
    发送人员
</div>
<div class="col-md-9">
    <input id="m_empShow"
           readonly=“readonly”
           class="validate[required,maxSize[100]] form-control"
           value="${message.empIdShow}"/>
</div>
</div>
<div class="form-row">
<div class="col-md-3 tar">
    发送部门
</div>
<div class="col-md-9">
    <input id="m_deptShow"
           readonly=“readonly”
           class="validate[required,maxSize[100]] form-control"
           value="${message.deptIdShow}"/>
</div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        内容
    </div>
    <div class="col-md-9">
        <input id="m_content"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${message.content}"/>
    </div>
</div>
<input id="id" hidden value="${message.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/message/printMessage?id=${message.id}">



