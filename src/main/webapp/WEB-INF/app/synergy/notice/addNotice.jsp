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
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap" id="main">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">发通知</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="mui-content" style="padding-top: 0%">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标题
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="f_title" style="text-align:center;" maxlength="30" placeholder="最多输入30个字"
                      class="validate[required,maxSize[100]] form-control"
            ></textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;" ;
                 class="ui-select">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>类型
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <div id="select"></div>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>接收部门
            </div>
            <div class="col-md-9" style="height: 65px;vertical-align:middle;text-align:center;">
            <textarea id="f_dept" style="text-align:center;" placeholder="请点击选择"
                      class="validate[required,maxSize[100]] form-control" readonly onclick="selectDept()"></textarea>
                <input hidden id="r_dept"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>接收人员
            </div>
            <div class="col-md-9" style="height: 65px;vertical-align:middle;text-align:center;">
                    <textarea id="f_people" style="text-align:center;" placeholder="请点击选择"
                              class="validate[required,maxSize[100]] form-control" readonly
                              onclick="selectPeople()"></textarea>
                <input hidden id="r_people"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>内容
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_content" style="text-align:center;" maxlength="665" placeholder="最多输入665个字"
                          class="validate[required,maxSize[100]] form-control"
                ></textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; display: block;"
                 id="bpeople">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>办理人
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
                <div id="people"></div>
            </div>
            <div style="text-align: center">
                <center>
                    <button class="mui-btn mui-btn-primary" id="saveBtn" style="width:80%; display: block; "
                            onclick="save()">提交
                    </button>
                </center>
            </div>
        </div>
    </div>
</div>
<div id="deptTree" style="display:none">
    <header class="mui-bar mui-bar-nav" id="deptTreeheader" style="display:none">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">选择部门</h1>
        <a id='done' class="mui-icon mui-pull-right" onclick="deptCover()"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="mui-content" style="padding-top: 0%">
        <div id='list' class="mui-indexed-list">
            <div class="mui-indexed-list-bar"></div>
            <div class="mui-indexed-list-inner" id="Tree"></div>
        </div>
    </div>
</div>
<div id="empTree" style="display:none">
    <header class="mui-bar mui-bar-nav" id="empTreeheader" style="display:none">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">选择接收人</h1>
        <a id='wellDone' class="mui-icon mui-pull-right" onclick="empCover()"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="mui-content" style="padding-top: 0%">
        <div id='empList' class="mui-indexed-list">
            <div class="mui-indexed-list-bar"></div>
            <div class="mui-indexed-list-inner" id="empInnerTree"></div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_SYS_MESSAGE">
<input id="workflowCode" hidden value="T_SYS_MESSAGE_WF">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var doc = '';
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'TZLX',
        }, function (data) {
            $("#select").append("<select id='f_type' class='mui-btn mui-btn-block' style='padding: 2%'></select>");
            $("#f_type").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#f_type").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: "T_SYS_MESSAGE",
            workflowCode: "T_SYS_MESSAGE_WF",
            businessId: '${id}'
        }, function (data) {
            if (data.emps.length == 0) {
                $("#people").append("<label>当前没有办理人</label>");
                return;
            }
            $("#people").append("<select id='personId' class='mui-btn mui-btn-block'></select>");
            $("#personId").append("<option value=''>请选择</option>");
            $.each(data.emps, function (index, content) {
                $("#personId").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        $("a[id='done']").click(function () {
            document.getElementById("main").style.display = "";
            document.getElementById("deptTree").style.display = "none";
            document.getElementById("deptTreeheader").style.display = "none";
            var Tree = document.getElementById("Tree");
            var ul = document.getElementById("Treeul");
            Tree.removeChild(ul);
        });
        $("a[id='wellDone']").click(function () {
            document.getElementById("main").style.display = "";
            document.getElementById("empTree").style.display = "none";
            document.getElementById("empTreeheader").style.display = "none";
            var empTree = document.getElementById("empInnerTree");
            var empUl = document.getElementById("empTreeul");
            empTree.removeChild(empUl);
        });
    })

    function selectDept() {
        var ul = document.getElementById("done");
        ul.innerHTML = "返回";

        document.getElementById("main").style.display = "none";
        document.getElementById("deptTree").style.display = "";
        document.getElementById("deptTreeheader").style.display = "";
        var line = "";
        $.post("<%=request.getContextPath()%>/notice/addDept", {}, function (data) {
            if (data != '') {
                line = '<div class="mui-input-row mui-checkbox mui-left">'
            }
            $.each(data, function (key, content) {
                    line = line +
                        '<li data-value=' + content.id + ' data-tags=' + content.id
                        + ' class="mui-table-view-cell mui-indexed-list-item mui-radio mui-left"  onclick="checkDeptTree()" >' +
                        '<input type="checkbox" class="rds" name="1"  id="' + content.name + '" onclick="checkDeptTree()" '
                        + 'value="' + content.name + '"/>' + content.name +
                        '<input type="hidden" name="suggest" value="' + content.id + '" class="rd"'
                        + 'id="aa' + content.name + '_2"/>' +
                        '</li>';
                }
            )
            if (line == "")
                line = '<div class="mui-indexed-list-empty-alert">没有数据</div>';
            else
                line = line + '</div>';
            var ul = document.createElement("ul");
            ul.id = "Treeul";
            ul.className = 'mui-table-view';
            ul.innerHTML = line;
            var Tree = document.getElementById("Tree");
            Tree.appendChild(ul);
        })
    }

    function selectPeople() {
        if ($("#f_dept").val() == '') {
            alert("请先选择部门");
            return;
        }
        var ul = document.getElementById("wellDone");
        ul.innerHTML = "返回";

        document.getElementById("main").style.display = "none";
        document.getElementById("empTree").style.display = "";
        document.getElementById("empTreeheader").style.display = "";
        var line = "";
        var a;
        $.post("<%=request.getContextPath()%>/notice/addEmp", {
            id: $("#r_dept").val()
        }, function (data) {
            if (data != '') {
                line = '<div class="mui-input-row mui-checkbox mui-left">'
                a = 0
            }
            $.each(data, function (key, content) {

                    line = line +
                        '<li data-value=' + content.personId + ' data-tags=' + content.personId
                        + ' class="mui-table-view-cell mui-indexed-list-item mui-radio mui-left"  onclick="checkEmpTree()" >' +
                        '<input type="checkbox" class="rds" name="1"  id="' + content.name + '" onclick="checkEmpTree()" '
                        + 'value="' + content.name + '"/>' + content.name +
                        '<input type="hidden" name="suggest" value="' + content.personId + '" class="rd"'
                        + 'id="aa' + content.name + '_2"/>' +
                        '</li>';
                }
            )
            if (line == "")
                line = '<div class="mui-indexed-list-empty-alert">没有数据</div>';
            else
                line = line + '</div>';
            var ul = document.createElement("ul");
            ul.id = "empTreeul";
            ul.className = 'mui-table-view';
            ul.innerHTML = line;
            var Tree = document.getElementById("empInnerTree");
            Tree.appendChild(ul);
        })

    }

    function checkDeptTree() {
        var ul = document.getElementById("done");
        ul.innerHTML = "完成";
    }

    function checkEmpTree() {
        var ul = document.getElementById("wellDone");
        ul.innerHTML = "完成";
    }

    function deptCover() {
        var rdsObj = document.getElementsByClassName('rds');
        var rdObj = document.getElementsByClassName('rd');
        var checkVal = new Array();
        var checkVals = new Array();
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                checkVals[k] = rdObj[i].value;
                k++;
            }
        }
        $("#f_dept").val(checkVal);
        $("#r_dept").val(checkVals);
    }

    function empCover() {
        var rdsObj = document.getElementsByClassName('rds');
        var rdObj = document.getElementsByClassName('rd');
        var checkVal = new Array();
        var checkVals = new Array();
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                checkVals[k] = rdObj[i].value;
                k++;
            }
        }
        $("#f_people").val(checkVal);
        $("#r_people").val(checkVals);
    }


    function save() {
        if ($("#f_title").val() == "" || $("#f_title").val() == null) {
            alert("请填写标题");
            return;
        }
        if ($("#f_title").val().indexOf(" ") != -1 || $("#f_title").val().indexOf("/") != -1 || $("#f_title").val().indexOf("@") != -1) {
            alert("标题中不可包含特殊符号。例如[空格]、[/]、[@]等符号");
            return;
        }
        if ($("#f_type option:selected").val() == "" || $("#f_type option:selected").val() == null) {
            alert("请选择通知类型");
            return;
        }
        if ($("#r_dept").val() == "") {
            alert("请选择部门");
            return;
        }
        /* if ($("#r_people").val() == "") {
             alert("请选择人员");
             return;
         }*/
        if ($("#f_content").val() == "") {
            alert("请填写通知内容");
            return;
        }
        if ($("#personId option:selected").val() == "" || $("#personId option:selected").val() == null) {
            alert("请选择办理人");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/message/saveProcessMessage", {
            id: '${id}',
            title: $("#f_title").val(),
            content: $("#f_content").val(),
            type: $("#f_type option:selected").val(),
            deptId: $("#r_dept").val(),
            empId: $("#r_people").val()
        }, function (msg) {
            if (msg.status == 1) {
                $.post("<%=request.getContextPath()%>/submit", {
                        businessId: '${id}',
                        tableName: "T_SYS_MESSAGE",
                        workflowCode: $("#workflowCode").val(),
                        handleUser: $("#personId option:selected").val(),
                        handleName: $("#personId option:selected").text(),
                    },
                    function (msg) {
                        if (msg.status == 1) {
                            hideSaveLoadingByClass('.saveBtnClass button');
                            alert(msg.msg);
                            window.location.href = "<%=request.getContextPath()%>/loginApp/index"
                        }
                    })
            }
        })
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

</script>
<style>
    .ui-select {
        text-align: center;
    }

    .ui-select select {
        position: absolute;
        left: 0px;
        top: 0px;
        width: 100%;
        height: 3em;
        opacity: 0;
    }
</style>