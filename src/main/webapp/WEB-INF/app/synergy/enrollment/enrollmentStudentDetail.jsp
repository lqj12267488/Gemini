<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/14
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet" />

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">新生登记详情</h1>
    </header>
    <div class="" style="padding-top: 10%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;" >
            &nbsp;&nbsp;&nbsp;&nbsp;学生姓名
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                   value="${enrollmentstudent.name}"    />
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;身份证号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${enrollmentstudent.idcard}"  />
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;手机号码
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${enrollmentstudent.tel}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;系部
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${enrollmentstudent.departmentShow}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;专业
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                    class="validate[required,maxSize[20]] form-control"
                    value="${enrollmentstudent.majorShow}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;性别
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                    class="validate[required,maxSize[20]] form-control"
                    value="${enrollmentstudent.sexShow}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;">
            &nbsp;&nbsp;&nbsp;&nbsp;民族
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                    class="validate[required,maxSize[20]] form-control"
                    value="${enrollmentstudent.nationShow}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;">
            &nbsp;&nbsp;&nbsp;&nbsp;政治面貌
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input  type="text" style="line-height:40px;height:40px;text-align:center;"
                    class="validate[required,maxSize[20]] form-control"
                    value="${enrollmentstudent.politicalStatusShow}"/>
        </div>


    </div>
</div>
<script>




</script>

