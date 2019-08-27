<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet"/>

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/jquery.qrcode.min.js"></script>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap" id="main">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">学生考勤</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div id="from" class="mui-content">
        <div style="background:#d0d0d0;height:30px;line-height: 30px">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>课程
        </div>
        <div style="height:41px;">
            <select id="courseId">
                <option value="">请选择</option>
                <c:forEach items="${courses}" var="item">
                    <option value="${item.id}">${item.text}</option>
                </c:forEach>
            </select>
        </div>
        <div style="background:#d0d0d0;height:30px;line-height: 30px">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>班级
        </div>
        <div style="line-height: 41px;background: white;padding-left: 15px">
            <c:forEach items="${classes}" var="item">
                <input type="checkbox" name="classId" value="${item.id}" onchange="changeMagor()">${item.name}
            </c:forEach>
        </div>
        <div style="background:#d0d0d0;height:30px;line-height: 30px">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>课节
        </div>
        <div style="height: 41px;">
            <select id="courseTime">
                <option value="">请选择</option>
                <c:forEach items="${courseTimes}" var="item">
                    <option value="${item.id}">${item.text}</option>
                </c:forEach>
            </select>
        </div>
        <div style="background:#d0d0d0;height:30px;line-height: 30px">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>专业
        </div>
        <div id="major" style="line-height: 41px;background: white;padding-left: 15px">
            请选择班级
        </div>
        <div style="height: 65px;text-align:center;padding-top: 10px">
            <button class="mui-btn mui-btn-primary" style="width: 80%" onclick="make()">提交</button>
        </div>
    </div>
    <div id="codeimg" align="center" style="height: 405px;padding-top:45px;display: none">

    </div>
    <div id="codeBottun" style="height: 65px;text-align:center;padding-top: 10px;display: none">
        <button class="mui-btn mui-btn-primary" style="width: 80%" onclick="closeCode()">关闭</button>
    </div>
</div>
<script>
    function make() {
        var courseId = $("#courseId").val();
        var classIds = '';
        $("input[name='classId']:checked").each(function (index, item) {
            classIds += $(item).val() + ",";
        });
        classIds = classIds.substring(0, classIds.length - 1);
        var major = "";
        $("input[name='major']:checked").each(function (index, item) {
            major += $(item).val() + ",";
        });
        major = major.substring(0, major.length - 1);
        var courseTime = $("#courseTime").val();
        if (courseId == "" || courseId == null || courseId == undefined) {
            alert("请选择课程！");
        }
        if (classIds == "" || classIds == null || classIds == undefined) {
            alert("请选择班级！");
            return;
        }
        if (courseTime == "" || courseTime == null || courseTime == undefined) {
            alert("请选择课节！");
            return;
        }
        var data = {
            courseId: courseId,
            classId: classIds,
            courseTimeId: courseTime,
            major: major
        };
        window.kqData = data;
        $.post("<%=request.getContextPath()%>/teach/saveTask", data, function (res) {
            if (res.status == 2) {
                alert("当前班级正在上课不能重复上课!");
            } else {
                data["id"] = res.msg;
                if (res.status == 0) {
                    alert("当前任务已经存在直接展示二维码!")
                }
                stop();
                qrcode();
                $("#codeimg").css({display: "block"});
                $("#codeBottun").css({display: "block"});
                $("#from").css({display: "none"});
                window.timeoutID = window.setInterval(function () {
                    qrcode()
                }, 5000);
            }
        });
    }

    function changeMagor() {
        var classIds = '';
        $("input[name='classId']:checked").each(function (index, item) {
            classIds += $(item).val() + ",";
        });
        $.post("<%=request.getContextPath()%>/teach/getMajorByClassIs", {
            ids: classIds.substring(0, classIds.length - 1)
        }, function (data) {
            $("#major").html("")
            $.each(data, function (index, item) {
                $("#major").append("<input type=\"checkbox\" name=\"major\" value=\"" + item.id + "\">" + item.name + "</br>")
            })
        });
    }

    function qrcode() {
        window.kqData["now"] = new Date().getTime();
        $("#codeimg").html("");
        $("#codeimg").qrcode({
            type: 'image/jpeg',
            width: 360, //宽度
            height: 360, //高度
            text: JSON.stringify(window.kqData) //任意内容
        });
    }

    function closeCode() {
        stop();
        $("#courseId").val("");
        $("#courseTime").val("");
        $("input[name='classId']:checked").removeAttr("checked");
        $("input[name='major']:checked").removeAttr("checked");
        $("#codeimg").css({display: "none"});
        $("#codeBottun").css({display: "none"});
        $("#from").css({display: "block"});
    }

    function stop() {
        if (window.timeoutID) {
            window.clearInterval(window.timeoutID);
        }
    }

    function backMain() {
        stop();
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
</body>
</html>