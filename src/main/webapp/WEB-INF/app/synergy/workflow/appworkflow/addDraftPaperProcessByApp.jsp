<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:08
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
        <h1 class="mui-title">拟文稿纸申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="" style="padding-top: 0%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="title" readonly="readonly" style="line-height:40px;height:40px;text-align:center;" type="text" value="${draftPaper.title}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;文号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="paperNumber" readonly="readonly" style="line-height:40px;height:40px;text-align:center;" type="text" value="${draftPaper.paperNumber}" />
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;拟稿人部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="draftDept" readonly="readonly" style="line-height:40px;height:40px;text-align:center;" value="${draftPaper.draftDept}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;拟稿人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="drafter"  readonly="readonly" style="line-height:40px;height:40px;text-align:center;" value="${draftPaper.drafter}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;拟稿日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="draftDate" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.draftDate}" type="text" class="validate[required,maxSize[100]] form-control"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;内容
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="content" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control" value="${draftPaper.secretLevel}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;机密等级
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="secretLevel" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.secretLevel}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;份数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="copies"  readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.copies}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;主送部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <div style="white-space:nowrap;">
                <input id="sendDeptIdSel" style="line-height:40px;height:40px;text-align:center;"
                       disabled="disabled" type="text" onclick="showMenu1()"  value="${draftPaper.sendDeptIdShow}" readonly/>
            </div>
            <div id="menuContent1" class="menuContent1">
                <ul id="treeDemo1" class="ztree"></ul>
            </div>
            <input id="sendDeptId" type="hidden" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.sendDeptId}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;抄送部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <div style="white-space:nowrap;">
                <input id="copyDeptIdSel" style="line-height:40px;height:40px;text-align:center;"
                       disabled="disabled" type="text" onclick="showMenu2()"  value="${draftPaper.copyDeptIdShow}" readonly/>
            </div>
            <div id="menuContent2" class="menuContent2">
                <ul id="treeDemo2" class="ztree"></ul>
            </div>
            <input id="copyDeptId" type="hidden" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.copyDeptId}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;报送部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <div style="white-space:nowrap;">
                <input id="submitDeptIdSel" style="line-height:40px;height:40px;text-align:center;"
                       disabled="disabled" type="text" onclick="showMenu3()"  value="${draftPaper.submitDeptIdShow}" readonly/>
            </div>
            <div id="menuContent3" class="menuContent3">
                <ul id="treeDemo3" class="ztree"></ul>
            </div>
            <input id="submitDeptId" style="line-height:40px;height:40px;text-align:center;"
                   type="hidden" value="${draftPaper.submitDeptId}"/>
        </div>
    </div>
 </div>
<script>
    $(document).ready(function () {
        //主送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo1"), setting, data);
            var node;
            var lis = $("#sendDeptId").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });
        //抄送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree2 = $.fn.zTree.init($("#treeDemo2"), setting, data);
            var node;
            var lis = $("#copyDeptId").val().split(",");
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree2.getNodeByParam("id", lis[i], null);
                var callbackFlag2 = $("#"+lis[i]).attr("checked");
                editRangezTree2.checkNode(node, true, false, callbackFlag2);
            }
        });
        //报送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree3 = $.fn.zTree.init($("#treeDemo3"), setting, data);
            var node;
            var lis = $("#submitDeptId").val().split(",");
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree3.getNodeByParam("id", lis[i], null);
                var callbackFlag3 = $("#"+lis[i]).attr("checked");
                editRangezTree3.checkNode(node, true, false, callbackFlag3);
            }
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#drafterId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#drafterId").val(ui.item.label);
                    $("#drafterId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

        })
    })




</script>
<!--主送部门-->
<script type="text/javascript">
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y":"", "N":""}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck
        }
    };
    function showMenu1() {
        var sendDeptIdObj = $("#sendDeptId");
        var sendDeptIdOffset = $("#sendDeptId").offset();
        $("#menuContent1").css({left:sendDeptIdOffset.left + "px", top:sendDeptIdOffset.top + sendDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }
    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "sendDeptIdSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length>0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
                nodes = zTree.getCheckedNodes(true);
            $("#sendDeptId").val(getChildNodes(nodes));//获取子节点
            $("#sendDeptIdSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }
    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var sendDeptId = $("#sendDeptId");
        sendDeptId.attr("value", v);
    }
    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
</script>
<!--抄送部门-->
<script type="text/javascript">
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y":"", "N":""}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick2,
            onCheck: onCheck2
        }
    };
    function showMenu2() {
        var copyDeptIdObj = $("#copyDeptId");
        var copyDeptIdOffset = $("#copyDeptId").offset();
        $("#menuContent2").css({left:copyDeptIdOffset.left + "px", top:copyDeptIdOffset.top + copyDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown2);
    }
    function hideMenu2() {
        $("#menuContent2").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown2);
    }
    function onBodyDown2(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "copyDeptIdObj" || event.target.id == "menuContent2" || $(event.target).parents("#menuContent2").length>0)) {
            hideMenu2();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
                nodes = zTree.getCheckedNodes(true);
            $("#copyDeptId").val(getChildNodes2(nodes));//获取子节点
            $("#copyDeptIdSel").val(getChildNodesSel2(nodes));//获取子节点
        }
    }
    function onCheck2(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var copyDeptId = $("#copyDeptId");
        copyDeptId.attr("value", v);
    }
    function beforeClick2(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodesSel2(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes2(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
</script>
<!--报送部门-->
<script type="text/javascript">
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y":"", "N":""}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick3,
            onCheck: onCheck3
        }
    };
    function showMenu3() {
        var submitDeptIdObj = $("#submitDeptId");
        var submitDeptIdOffset = $("#submitDeptId").offset();
        $("#menuContent3").css({left:submitDeptIdOffset.left + "px", top:submitDeptIdOffset.top + submitDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown3);
    }
    function hideMenu3() {
        $("#menuContent3").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown3);
    }
    function onBodyDown3(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "submitDeptIdObj" || event.target.id == "menuContent3" || $(event.target).parents("#menuContent3").length>0)) {
            hideMenu3();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo3"),
                nodes = zTree.getCheckedNodes(true);
            $("#submitDeptId").val(getChildNodes3(nodes));//获取子节点
            $("#submitDeptIdSel").val(getChildNodesSel3(nodes));//获取子节点
        }
    }
    function onCheck3(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo3"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var submitDeptId = $("#submitDeptId");
        submitDeptId.attr("value", v);
    }
    function beforeClick3(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodesSel3(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes3(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
<style>
    #menuContent1{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent2{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent3{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
