<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/9
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%><%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  style="color:#fff;"></a>
        <h1 class="mui-title">电子档案</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <%--<c:if test="${menuType =='11'}">--%>
        <c:if test="${creator ==archives.creator}">
            <div style="height: 30px; padding-top: 14%;" align="center">
                <button style="background: #0064a6;color:#ffffff;" onclick="editAppArchives()">修改</button>&nbsp;
                <button style="background: #0064a6;color:#ffffff;" onclick="delAppArchives()">删除</button>&nbsp;
                <button id="sum" style="background: #0064a6;color:#ffffff;" onclick="submitAppArchives()">提交</button>&nbsp;
                <button id="sqbg" style="background: #0064a6;color:#ffffff;" onclick="changeAppArchives()">变更</button>
            </div>
        </c:if>
    <%--</c:if>--%>
    <c:if test="${menuType =='12'}">
        <div style="height: 30px; padding-top: 14%;" align="center">
            <c:if test="${archives.requestFlag =='1' or archives.requestFlag =='0'}">
                <button id="sqbl" style="background: #0064a6;color:#ffffff;" onclick="auditAppArchives()">审核</button>
            </c:if>
            <c:if test="${archives.requestFlag =='5'}">
                <button id="setPower" style="background: #0064a6;color:#ffffff;" onclick="setPowerArchives()">授权</button>
            </c:if>
        </div>
    </c:if>
    <div class="mui-content" style="padding-top: auto;">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;创建部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify ;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.createDept}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;创建人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.creator}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案编码
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="acode" type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.archivesCode}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;一级类别
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.oneLevel}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;二级类别
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.twoLevel}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案类型
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.fileType}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;学校类别
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                       class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${archives.schoolType}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案名称
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="aname"  type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.archivesName}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案状态
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.requestFlagShow}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;文件形成时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                       class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${archives.formatTime}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                       class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${archives.remark}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div id="archivesFile" class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:50px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;附件
            </div>
        </div>
    </div>

</div>
<input id="appid" hidden value="${archives.archivesId}">
<input id="menuType" hidden value="${menuType}">
<input id="requestFlag" hidden value="${archives.requestFlag}">
<input id="filesFlag" hidden value="${filesFlag}">
<script>
    var requestFlag=$("#requestFlag").val();
    $(document).ready(function () {
        if($("#menuType").val()=="12" || $("#menuType").val()=="13"){
            $("#sqbg").hide();
            $("#sqbl").show();
            $("#sum").show();
        }else if($("#menuType").val()=="13"){
            $("#sum").hide();
            $("#sqbg").hide();
            $("#sqbl").hide();
        } else {
            $("#sqbg").show();
            $("#sqbl").hide();
        }
       $.post("<%=request.getContextPath()%>/archives/getFilesByBusinessId", {
            businessId:  $("#appid").val(),
        }, function (data) {
            if (data.data.length == 0) {
                $("#archivesFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>'+
                    '</div>'+
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    $("#archivesFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        '<a href="<%=request.getContextPath()%>/archives/downloadArchivesFile?archivesId=' + $("#appid").val() + '&fileId=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>' +
                        '</ul>'+
                        '</div>'+
                        '</div>');
                })
            }
        })

        <%--$.get("<%=request.getContextPath()%>/archives/getFilesByBusinessId?businessId=" + $("#appid").val(), function (data) {--%>
            <%--var html = "";--%>
            <%--$.each(data.data, function (index, file) {--%>
                <%--html += "<p style='font-size: 17px'><span style='margin-left: 10px'>" + file.fileName +--%>
                    <%--"</span> </p>";--%>
            <%--})--%>
            <%--$("#fileList").html(html)--%>
        <%--})--%>

    })
    function addAppArchives() {
        window.location.href = "<%=request.getContextPath()%>/archives/appAddArchives?menuType="+$("#menuType").val();
    }
    function editAppArchives() {
        if('${archives.personId}'!='${loginuser}'){
            alert("不可修改他人的档案信息！")
        }else if($("#menuType").val()!="12"){
            if('${archives.requestFlag}' =='' || '${archives.requestFlag}' =='6' || '${archives.requestFlag}' =='7' || '${archives.requestFlag}' =='2'){
                window.location.href = "<%=request.getContextPath()%>/archives/appAddArchives?archivesId="+$("#appid").val()+"&menuType="+$("#menuType").val();
            }else {
                alert("当前档案已提交，不可修改。")
            }
        }else {
            window.location.href = "<%=request.getContextPath()%>/archives/appAddArchives?archivesId="+$("#appid").val()+"&menuType="+$("#menuType").val();
        }
        <%--if(requestFlag !=null && requestFlag !=""){--%>
            <%--alert("该档案已提交。提交后须提变更申请，申请通过方可修改。");--%>
            <%--return;--%>
        <%--}else--%>
            <%--window.location.href = "<%=request.getContextPath()%>/archives/appAddArchives?archivesId="+$("#appid").val()+"&menuType="+$("#menuType").val();--%>
    }
    function delAppArchives() {
        var archivesName=encodeURI(encodeURI($("#aname").val()));
        var archivesCode=$("#acode").val();
        if('${archives.personId}'!='${loginuser}'){
            alert("不可删除他人的档案信息！")
        }else if($("#menuType").val()!="12"){
            if('${archives.requestFlag}' =='6' || '${archives.requestFlag}' =='7' || '${archives.requestFlag}' =='2'){
                if (confirm("是否要删除本条记录?")) {
                    $.get("/archives/updateArchivesDelStateById?archivesId=" + $("#appid").val()+"&delState=1"+
                        "&archivesName="+archivesName+"&archivesCode="+archivesCode, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType="+$("#menuType").val();
                        }
                    })
                }
            }else {
                alert("当前档案已提交，不可删除。")
            }
        }else {
            if (confirm("是否要删除本条记录?")) {
                $.get("/archives/deleteArchivesById?archivesId=" + $("#appid").val()+"&delState=1"+
                    "&archivesName="+archivesName+"&archivesCode="+archivesCode, function (msg) {
                    if (msg.status == 1) {
                        alert("删除成功！");
                        window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType="+$("#menuType").val();
                    }
                })
            }
        }

        <%--if(requestFlag !=null && requestFlag !=""){--%>
            <%--alert("该档案已提交。提交后须提变更申请，申请通过方可删除。");--%>
            <%--return;--%>
        <%--}--%>
        <%--if (confirm("是否要删除本条记录?")) {--%>
                   <%--$.get("/archives/deleteArchivesById?archivesId=" + $("#appid").val(), function (msg) {--%>
                       <%--if (msg.status == 1) {--%>
                           <%--alert("删除成功！");--%>
                           <%--window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType="+$("#menuType").val();--%>
                       <%--}--%>
                   <%--})--%>
               <%--}--%>
    }
    function submitAppArchives() {
        var archivesName=encodeURI(encodeURI($("#aname").val()));
        var archivesCode=$("#acode").val();
        if(requestFlag !=null && requestFlag !="" && requestFlag !="6" && requestFlag !="7"){
            alert("该档案已提交");
            return;
        }else if( $("#filesFlag").val() =='0'){
            alert("必须上传附件后才能提交");
            return;
        }else if(confirm("您确定提交档案?")){
            if($("#menuType").val()=="12" || $("#menuType").val()=="13"){
                $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=5&archivesId=" + $("#appid").val()+
                    "&archivesName="+archivesName+"&archivesCode="+archivesCode, function (msg) {
                    if (msg.status == 1) {
                        alert(msg.msg);
                        window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=" + $("#menuType").val();
                    }
                })
            }else {
                $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=0&archivesId=" + $("#appid").val() +
                    "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                    if (msg.status == 1) {
                        alert("提交成功！");
                        window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=" + $("#menuType").val();
                    }
                })
            }
        }
    }
    function changeAppArchives() {

        if( requestFlag =='' || requestFlag =='0' || requestFlag =='2'  || requestFlag=="4"
            || requestFlag =='6' || requestFlag =='7' ){
            alert("该档案的尚未提交或审核已通过，可直接修改或删除");
            return;
        }else if(requestFlag=="1"){
            alert("该档案的变更申请正在审核中");
            return;
        }else if( requestFlag=="3" || requestFlag=="5" ){
            window.location.href ="<%=request.getContextPath()%>/archives/appArchivesRequest?archivesId=" + $("#appid").val()+"&menuType="+$("#menuType").val()
                +'&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}' ;
        }
    }
    function setPowerArchives() {
        window.location.href ="<%=request.getContextPath()%>/archives/appArchivesPower?archivesId=" +
            $("#appid").val()+"&menuType="+$("#menuType").val();
    }
    function auditAppArchives() {
        if (requestFlag == "1" || requestFlag=="0") {
            window.location.href ="<%=request.getContextPath()%>/archives/appArchivesRequest?archivesId=" +
                $("#appid").val()+"&menuType="+$("#menuType").val();
        } else {
            alert("该档案未提交修改申请");
        }
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
<style>
    .headerdiv{
        font-family: 'Microsoft YaHei', 'Helvetica Neue', Helvetica, sans-serif;
        line-height: 1.1;
        float: left;
        width: 100%;
        height: 60px;
        padding: 11px 15px;
        vertical-align: middle;
        /*display:table;*/
        /* line-height: 100px;*/
    }
</style>

