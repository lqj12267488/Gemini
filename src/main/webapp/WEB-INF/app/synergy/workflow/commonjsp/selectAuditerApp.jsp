<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/app.css">
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <a id="back" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
    <h1 id="title" class="mui-title">选择办理人</h1>
</header>
</body>
<div class="mui-content">
    <div id="select" class="mui-input-group">
    </div>
    <div align="center">
        <button type="button" class="mui-btn mui-btn-primary"
                onclick="audit()">保存
        </button>
        <button type="button" class="btn btn-default btn-clean"
                onclick="mui.back()">关闭
        </button>
    </div>
</div>
<%--<script type="text/javascript" src="../../../libs/js/app/mui.js"></script>--%>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
<script>
    var doc = '';
    var term = $("#term").val()
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: '${tableName}',
            workflowCode: $("#workflowCode").val(),
            businessId: '${businessId}',
            term: '${term}'
        }, function (data) {
            if (data.nodeType == 0) {
                $("#select").append("<select id='personId' class='mui-btn mui-btn-block'></select>");
                $("#personId").append("<option value=''>请选择</option>");
                $.each(data.emps, function (index, content) {
                    $("#personId").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            }else{
                $.each(data.emps, function (key, map) {
                    if (data.emps.nodeType == 0) {
                        $("#select").append("<select id='personId'></select>");
                        $("#personId").append("<option value=''>请选择</option>");
                        $.each(data.emps, function (index, content) {
                            $("#personId").append("<option value='" + content.id + "'>" + content.name + "</option>");
                        })
                    } else {
                        var doc = '';
                        if(map.id !='9999')
                            doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                                ' <label>' + map.name + '</label>' +
                                '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                                '<input hidden value="' + map.name + '" class="cbs"/>' +
                                '</div>';
                        $("#select").append(doc);
                    }
                })
            }
        })
    })
    var checkVal = new Array();
    var checkText = new Array();

    function getCheckBoxRes(className){
        var rdsObj   = document.getElementsByClassName(className);
        var k        = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                k++;
            }
        }
        return checkVal;
    }
    function getCheckBoxText(className){
        var rdsObj   = document.getElementsByClassName('rds');
        var rdsObjs   = document.getElementsByClassName(className);
        var k        = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkText[k] = rdsObjs[i].value;
                k++;
            }
        }
        return checkText;
    }
    function audit() {
        var resVal = getCheckBoxRes('rds').toString();
        var resText = getCheckBoxText('cbs').toString();
        var value = '';
        var text = '';
        var selectVal = $("#personId option:selected").val();
        if(resVal.length < 1 && selectVal == ''){
            mui.toast('请选择');
            return;
        }else{
            if (resVal < 1){
                value = $("#personId option:selected").val();
                text = $("#personId option:selected").text();
            }else{
                value = resVal;
                text = resText;
            }
        }
        var term = '${term}';
        var msg = "确认移交到" + text + "？";
        if (term == '-1') {
            msg = "确认办结？";
        }
        if (confirm(msg)) {
            $.post("<%=request.getContextPath()%>/audit", {
                term: term,
                handleUser: value,
                handleName: text,
                remark: '${remark}',
                businessId: '${businessId}',
                tableName: '${tableName}'
            }, function (data) {
                if (data.status = 1) {
                    alert(data.msg)
                    window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0"
                }
            })
        }else{
            window.location.reload();
        }
    }

    mui.init({
        swipeBack: true, //启用右滑关闭功能
    });

</script>
