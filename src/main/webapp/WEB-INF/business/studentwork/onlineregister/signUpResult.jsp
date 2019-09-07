<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>报名结果查询</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/materialize/css/materialize.min.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/materialize/js/materialize.js"></script>
<body>

<div class="mui-inner-wrap">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" onclick="back()" style="color:#fff;"></a>
        <h1 class="mui-title">报名结果查询</h1>
    </header>

    <div class="mui-content">
        <div class="row">
            <form class="col s12">
                <br>
                <div class="input-field col s12">
                    <input id="s_name" type="text" class="validate"/>
                    <label for="s_name">姓名</label>
                </div>
                <div class="input-field col s12">
                    <input id="s_idcard" type="text" class="validate"/>
                    <label for="s_idcard">身份证号</label>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="center-align">
    <a class="waves-effect waves-light btn" onclick="query()" style="width: 200px">查询</a>
</div>
<div id="reSultView">

</div>
</body>
<script>
    function query() {
        if ($("#s_name").val() === "" || $("#s_name").val() === undefined) {
            alert("请填写姓名！");
            return;
        }
        if ($("#s_idcard").val() === "" || $("#s_idcard").val() === undefined) {
            alert("请填写身份证号！");
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (reg.test($("#s_idcard").val()) === false) {
            alert("身份证输入不合法");
            return;
        }
        $.post("<%=request.getContextPath()%>/onlineregister/getRegisterByIDCard", {
            idcard: $("#s_idcard").val(),
            name: $("#s_name").val()
        }, function (msg) {
            var arr  = msg.split("-");
            if ('1' === arr[0]) {
                $("#reSultView").html("<br>\n" +
                    "    <div class=\"center-align\">\n" +
                    "        <i  class=\"material-icons\" style=\"font-size: 130px\">verified_user</i>\n" +
                    "    </div>\n" +
                    "    <div class=\"center-align\" >\n" +
                    "        <span style=\"font-weight: bold;font-size: 20px;color: #26a69a\">恭喜您，报名审核通过</span>\n" +
                    "    </div>\n" +
                    "\n" +
                    "    <div class=\"progress\">\n" +
                    "        <div class=\"determinate\" style=\"width: 100%\">气温</div>\n" +
                    "    </div>");

            } else if ('2' === arr[0]) {
                $("#reSultView").html("<br>\n" +
                    "    <div class=\"center-align\">\n" +
                    "        <i  class=\"material-icons\" style=\"font-size: 130px\">not_interested</i>\n" +
                    "    </div>\n" +
                    "    <div class=\"center-align\" >\n" +
                    "        <span style=\"font-weight: bold;font-size: 20px;color: #ff493f\">很遗憾，您的报名审核未通过</span>\n" +
                    "    </div>\n" +
                    "\n" +
                    "    <div class=\"progress\">\n" +
                    "        <div class=\"determinate\" style=\"width: 100%;background-color:#ff493f\"></div>\n" +
                    "    </div>");
            } else if ('0' === arr[0]) {

                $("#reSultView").html("<br>\n" +
                    "    <div class=\"center-align\">\n" +
                    "        <i  class=\"material-icons\" style=\"font-size: 130px\">info</i>\n" +
                    "    </div>\n" +
                    "    <div class=\"center-align\" >\n" +
                    "        <span style=\"font-weight: bold;font-size: 20px;color: #ffae28\">您的报名申请正在审核中</span>\n" +
                    "    </div>\n" +
                    "\n" +
                    "    <div class=\"progress\">\n" +
                    "        <div class=\"indeterminate\"></div>\n" +
                    "    </div>");
            } else if ('notfound' === arr[0]) {
                $("#reSultView").html("<br>\n" +
                    "    <div class=\"center-align\">\n" +
                    "        <i  class=\"material-icons\" style=\"font-size: 130px\">error_outline</i>\n" +
                    "    </div>\n" +
                    "    <div class=\"center-align\" >\n" +
                    "        <span style=\"font-weight: bold;font-size: 20px;color: #ff493f\">未查到报名信息<br>检查姓名和身份证是否正确</span>\n" +
                    "    </div>\n" +
                    "\n" +
                    "    <div class=\"progress\">\n" +
                    "        <div class=\"determinate\" style=\"width: 100%;background-color:#ff493f\"></div>\n" +
                    "    </div>");
            }
        });
    }

    function back() {
        window.location.href = "/onlineregister/signUp";
    }
</script>
