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
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body>
    <header class="mui-bar mui-bar-nav">
        <span id="back" class=" mui-icon mui-icon-left-nav mui-pull-left" onclick="mui.back()" style="color:#fff;"></span>
        <h1 id="title" class="mui-title">${archives.archivesName} 电子档案 授权</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="mui-content">
        <div  id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mui-scroll" style="padding-bottom: 40px;">
            <div class="mui-content-padded">
                <h3 class="mui-ellipsis" style=" border:10px;font-size: 40px">
                    <c:forEach items="${empList}" var="empitems">
                        <div style="white-space:nowrap;">&nbsp;&nbsp;&nbsp;&nbsp;<input style="width: 25px;height: 25px;" name="checkEmp" type="checkbox" ${empitems.staffStatusShow} value="${empitems.personId},${empitems.deptId}">${empitems.name}</div>
                    </c:forEach>
                </h3>
            </div>
        </div>
        <div id="addbutton" style="height: 40px; padding-top:1%; position: fixed; bottom: 0; width: 100%; z-index: 3" align="center">
            <button id="add" style="background: #0064a6;color:#ffffff; padding-top:1%; width: 100%" onclick="save()">保存</button>&nbsp;
        </div>
    </div>
    <input hidden id="archivesId" value="${archivesId}">
    <input hidden id="deptId" value="${deptId}">
</body>
</html>
<script>
    $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function save() {
        var deptId = $("#deptId").val();
        var archivesId = $("#archivesId").val();

        var groupCheckbox=$("input[name='checkEmp']");
        var checkList = "";
        for(i=0;i<groupCheckbox.length;i++){
            if(groupCheckbox[i].checked){
                if(checkList =="")
                    checkList =  groupCheckbox[i].value;
                else
                    checkList = checkList +"##"+ groupCheckbox[i].value;
            }
        }
        showSaveLoading('#saveBtn');
        $.post("<%=request.getContextPath()%>/archives/saveArchivesPower",
            {
                deptId:deptId,
                archivesId:archivesId,
                checkList:checkList,
            },
            function (msg) {
                hideSaveLoading('#saveBtn');
                alert("保存成功");
                mui.back();
            })
    }

</script>