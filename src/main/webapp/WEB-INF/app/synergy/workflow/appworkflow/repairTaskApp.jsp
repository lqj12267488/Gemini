<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/15
  Time: 9:15
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
    <link href="<%=request.getContextPath()%>/libs/css/app/my.previewimage.css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.previewimage.js"></script>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">维修信息详情</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="" style="padding-top: 12%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            维修人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.personName}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            报修种类
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.repairTypeShow}
        </div>
        <%--         <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                    资产编号
                </div>
                <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.assetsID}
                </div>
               <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                    所在位置
                </div>
                <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.position}
                </div>--%>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            所在部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.dept}
        </div>
<%--        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            流水号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.numeration}
        </div>--%>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            报修物品名称
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.itemNameShow}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            维修地址
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.repairAddress}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            故障描述
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.faultDescription}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            联系人电话
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.contactNumber}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.creator}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            请求状态
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.requestFlag}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            反馈意见
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.feedback}
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            反馈状态
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.feedbackFlag}
        </div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar"style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;">
                附件
            </div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            <span class="iconBtx">*</span>维修员分配
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="select"></div>
        </div>
        <div style="text-align: center" >
            <center>
                <button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                        onclick="save()">分配
                </button>
            </center>
        </div>
    </div>
</div>
<script>
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getRepairPersonTree", {}, function (data) {
            $.each(data, function (key, map) {
                if (data.length == 0) {
                    $("#select").append("' <label>' + map.name + '</label>'");
                } else {
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                        '</div>';
                    $("#select").append(doc);
                }
            })
        });

        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${salary.repairID}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="col-md-9" style="vertical-align:middle;">' +
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>' +
                    '</div>' +
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    var str = "";
                    if(".bmp、.jpg、.jpeg、.png、.gif".indexOf(getFileExtendingName(data.fileName)) == -1){
                        str = '<a href="/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>';
                    }else{
                        str = '<img src="<%=request.getContextPath()%>'+val.fileUrl+'"style="width:320px;height:320px;"  data-preview-src="" data-preview-group="1" />';
                    }
                    $("#file").append('<div class="col-md-9" style="vertical-align:middle;">' +
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        str +
                        '</li>' +
                        '</ul>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        mui.previewImage();
    })
    var checkVal = new Array();
    function getCheckBoxRes(className) {
        var rdsObj = document.getElementsByClassName(className);
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                k++;
            }
        }
        return checkVal;
    }
    function save() {
        var resVal = getCheckBoxRes('rds').toString();

        if (resVal.length < 1) {
            alert('请选择要分配的维修员');
            return;
        }else{
            $.post("<%=request.getContextPath()%>/repair/FenPeiRepairPerson?ids="+resVal+"&repairID=${salary.repairID}", {
                },
                function (msg) {
                    if (msg.status == 1) {
                        alert(msg.msg);
                        window.location.href = "<%=request.getContextPath()%>/repairTaskApp/result"
                    }
                })
        }

    }

    function getFileExtendingName (filename) {
        // 文件扩展名匹配正则
        var reg = /\.[^\.]+$/;
        var matches = reg.exec(filename);
        if (matches) {
            return matches[0];
        }
        return '';
    }
</script>
