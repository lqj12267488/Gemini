<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:08
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
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">拟文稿纸申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿人部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="draftDept" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.draftDept}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="drafter" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.drafter}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="draftDate" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.draftDate}" type="date" class="validate[required,maxSize[100]] form-control"
                   readonly/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>核稿人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="checker" style="text-align:center;" type="text" onclick="selectPeople()"
                   value="${draftPaper.checkerShow}" readonly/>
            <input id="checkerId" style="text-align:center;" hidden type="text" value="${draftPaper.checker}"/>
            <input id="checkerDeptId" style="text-align:center;" hidden type="text"
                   value="${draftPaper.checkDept}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="t_title" style="line-height:40px;height:40px;text-align:center;" type="text"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="15" placeholder="最多输入15个字" value="${draftPaper.title}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>文号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="paperNumber" style="line-height:40px;height:40px;text-align:center;" type="text"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="15" placeholder="最多输入15个字" value="${draftPaper.paperNumber}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>内容
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="content" style="text-align:center;" maxlength="665" placeholder="最多输入665个字"
                      type="text" class="validate[required,maxSize[100]] form-control"
                      value="${draftPaper.content}">${draftPaper.content}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>机密等级
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="secretLevel" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="15" placeholder="最多输入15个字"
                   value="${draftPaper.secretLevel}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>份数
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="copies" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="15" placeholder="最多输入15个字"
                   value="${draftPaper.copies}" type="text"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>主送部门
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="sendDeptIdSel" style="text-align:center;"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${draftPaper.sendDeptIdShow}" onclick="selectSendDept()"
                          readOnly>${draftPaper.sendDeptIdShow}</textarea>
            <input id="sendDeptId" type="hidden" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.sendDeptId}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>抄送部门
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="copyDeptIdSel" style="text-align:center;"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${draftPaper.copyDeptIdShow}" onclick="selectCopyDept()"
                          readOnly>${draftPaper.copyDeptIdShow}</textarea>
            <input id="copyDeptId" type="hidden" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.copyDeptId}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报送部门
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="submitDeptIdSel" style="text-align:center;"
                      type="text" class="validate[required,maxSize[100]] form-control"
                      value="${draftPaper.submitDeptIdShow}" onclick="selectSubmitDept()"
                      readOnly>${draftPaper.submitDeptIdShow}</textarea>
            <input id="submitDeptId" type="hidden" style="line-height:40px;height:40px;text-align:center;"
                   value="${draftPaper.submitDeptId}"/>
        </div>
    </div>
</div>
<div id="peopleTree" style="display:none" class="mui-content">
    <header class="mui-bar mui-bar-nav" id="peopleTreeheader" style="display:none">
        <%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>--%>
        <h1 class="mui-title">选择核稿人</h1>
        <a id='peopleDone' class="mui-icon mui-pull-right"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="">
        <div id='list' class="mui-indexed-list">
            <div class="mui-indexed-list-search mui-input-row mui-search">
                <input type="search" class="mui-input-clear  mui-indexed-list-search-input" placeholder="搜索姓名"
                       id="search">
            </div>
            <div hidden class="mui-indexed-list-bar">
                <a>A</a>
                <a>B</a>
                <a>C</a>
                <a>D</a>
                <a>E</a>
                <a>F</a>
                <a>G</a>
                <a>H</a>
                <a>I</a>
                <a>J</a>
                <a>K</a>
                <a>L</a>
                <a>M</a>
                <a>N</a>
                <a>O</a>
                <a>P</a>
                <a>Q</a>
                <a>R</a>
                <a>S</a>
                <a>T</a>
                <a>U</a>
                <a>V</a>
                <a>W</a>
                <a>X</a>
                <a>Y</a>
                <a>Z</a>
            </div>
            <div class="mui-indexed-list-alert"></div>
            <div class="mui-indexed-list-inner" id="emptree">
                <ul class="mui-table-view" id="empUl">
                    <c:forEach items="${emps}" var="dep">
                        <li data-value="AKU" class="mui-table-view-cell">
                            <a class="mui-navigate-right"
                               onclick="selectEmps('${dep.id}','${dep.dept}','${dep.name} ---- ${dep.deptName}')">${dep.name}
                                ---- ${dep.deptName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<div id="sendDeptTree" style="display:none" class="mui-content">
    <header class="mui-bar mui-bar-nav" id="sendDeptTreeheader" style="display:none">
        <%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>--%>
        <h1 class="mui-title">选择部门</h1>
        <a id='sendDone' class="mui-icon mui-pull-right" onclick="deptCover('sendDeptTree')"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="" style="padding-top: 0%">
        <div id='sendDeptList' class="mui-indexed-list">
            <div class="mui-indexed-list-bar"></div>
            <div class="mui-indexed-list-inner" id="sendTree"></div>
        </div>
    </div>
</div>
<div id="copyDeptTree" style="display:none" class="mui-content">
    <header class="mui-bar mui-bar-nav" id="copyDeptTreeheader" style="display:none">
        <%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>--%>
        <h1 class="mui-title">选择部门</h1>
        <a id='copyDone' class="mui-icon mui-pull-right" onclick="deptCover('copyDeptTree')"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="" style="padding-top: 0%">
        <div id='copyDeptList' class="mui-indexed-list">
            <div class="mui-indexed-list-bar"></div>
            <div class="mui-indexed-list-inner" id="copyTree"></div>
        </div>
    </div>
</div>
<div id="submitDeptTree" style="display:none" class="mui-content">
    <header class="mui-bar mui-bar-nav" id="submitDeptTreeheader" style="display:none">
        <%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>--%>
        <h1 class="mui-title">选择部门</h1>
        <a id='submitDone' class="mui-icon mui-pull-right" onclick="deptCover('submitDeptTree')"
           style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">返回</a>
    </header>
    <div class="" style="padding-top: 0%">
        <div id='submitDeptList' class="mui-indexed-list">
            <div class="mui-indexed-list-bar"></div>
            <div class="mui-indexed-list-inner" id="submitTree"></div>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/libs/js/app/jquery.js"></script>
<%--<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>--%>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.indexedlist.js"></script>
<script>
    mui.init();
    mui.ready(function () {
        var header = document.querySelector('header.mui-bar');
        var list = document.getElementById('list');
        //calc hieght
        list.style.height = (document.body.offsetHeight - header.offsetHeight) + 'px';
        //create
        window.indexedList = new mui.IndexedList(list);
    });
    $(document).ready(function () {
        $("a[id='sendDone']").click(function () {
            document.getElementById("mainPage").style.display = "";
            document.getElementById("close").style.display = "";
            document.getElementById("sendDeptTree").style.display = "none";
            document.getElementById("sendDeptTreeheader").style.display = "none";
            var sendTree = document.getElementById("sendTree");
            var ul = document.getElementById("sendTreeul");
            sendTree.removeChild(ul);
        });
        $("a[id='copyDone']").click(function () {
            document.getElementById("mainPage").style.display = "";
            document.getElementById("close").style.display = "";
            document.getElementById("copyDeptTree").style.display = "none";
            document.getElementById("copyDeptTreeheader").style.display = "none";
            var copyTree = document.getElementById("copyTree");
            var copyUl = document.getElementById("copyTreeul");
            copyTree.removeChild(copyUl);
        });
        $("a[id='submitDone']").click(function () {
            document.getElementById("mainPage").style.display = "";
            document.getElementById("close").style.display = "";
            document.getElementById("submitDeptTree").style.display = "none";
            document.getElementById("submitDeptTreeheader").style.display = "none";
            var submitTree = document.getElementById("submitTree");
            var submitUl = document.getElementById("submitTreeul");
            submitTree.removeChild(submitUl);
        });
        $("a[id='peopleDone']").click(function () {
            document.getElementById("mainPage").style.display = "";
            document.getElementById("close").style.display = "";
            document.getElementById("peopleTree").style.display = "none";
            document.getElementById("peopleTreeheader").style.display = "none";
            var empTree = document.getElementById("empTree");
            var empUl = document.getElementById("empUl");
            //empTree.removeChild(empUl);
        });
    })

    function selectSendDept() {
        var ul = document.getElementById("sendDone");
        ul.innerHTML = "返回";

        document.getElementById("mainPage").style.display = "none";
        document.getElementById("close").style.display = "none";
        document.getElementById("sendDeptTree").style.display = "";
        document.getElementById("sendDeptTreeheader").style.display = "";
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
            ul.id = "sendTreeul";
            ul.className = 'mui-table-view';
            ul.innerHTML = line;
            var Tree = document.getElementById("sendTree");
            Tree.appendChild(ul);
        })
    }

    function selectCopyDept() {
        var ul = document.getElementById("copyDone");
        ul.innerHTML = "返回";

        document.getElementById("mainPage").style.display = "none";
        document.getElementById("close").style.display = "none";
        document.getElementById("copyDeptTree").style.display = "";
        document.getElementById("copyDeptTreeheader").style.display = "";
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
            ul.id = "copyTreeul";
            ul.className = 'mui-table-view';
            ul.innerHTML = line;
            var Tree = document.getElementById("copyTree");
            Tree.appendChild(ul);
        })
    }

    function selectPeople() {
        var ul = document.getElementById("peopleDone");
        ul.innerHTML = "返回";

        document.getElementById("mainPage").style.display = "none";
        document.getElementById("close").style.display = "none";
        document.getElementById("peopleTree").style.display = "";
        document.getElementById("peopleTreeheader").style.display = "";
    }

    function selectSubmitDept() {
        var ul = document.getElementById("submitDone");
        ul.innerHTML = "返回";

        document.getElementById("mainPage").style.display = "none";
        document.getElementById("close").style.display = "none";
        document.getElementById("submitDeptTree").style.display = "";
        document.getElementById("submitDeptTreeheader").style.display = "";
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
            ul.id = "submitTreeul";
            ul.className = 'mui-table-view';
            ul.innerHTML = line;
            var Tree = document.getElementById("submitTree");
            Tree.appendChild(ul);
        })
    }

    function checkDeptTree() {
        var ul = document.getElementById("sendDone");
        ul.innerHTML = "完成";
        var copyUl = document.getElementById("copyDone");
        copyUl.innerHTML = "完成";
        var submitUl = document.getElementById("submitDone");
        submitUl.innerHTML = "完成";
    }

    function deptCover(deptType) {
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
        if (deptType == 'sendDeptTree') {
            $("#sendDeptIdSel").val(checkVal);
            $("#sendDeptId").val(checkVals);
        }
        if (deptType == 'copyDeptTree') {
            $("#copyDeptIdSel").val(checkVal);
            $("#copyDeptId").val(checkVals);
        }
        if (deptType == 'submitDeptTree') {
            $("#submitDeptIdSel").val(checkVal);
            $("#submitDeptId").val(checkVals);
        }
    }

    function selectEmps(empId, deptId, empName) {
        $("#checker").val(empName);
        $("#checkerId").val(empId);
        $("#checkerDeptId").val(deptId);
        document.getElementById("mainPage").style.display = "";
        document.getElementById("close").style.display = "";
        document.getElementById("peopleTree").style.display = "none";
        document.getElementById("peopleTreeheader").style.display = "none";
        var empTree = document.getElementById("empTree");
        var empUl = document.getElementById("empUl");
    }

    function save() {
        var checkerDept = "";
        var checkerId = "";
        if ($("#t_title").val() == "") {
            alert("请填写标题");
            return;
        }
        if ($("#paperNumber").val() == "" || $("#paperNumber").val() == undefined) {
            alert("请填写文号");
            return;
        }
        if ($("#checker").val() == "" || $("#checker").val() == undefined) {
            alert("请填写核稿人");
            return;
        } else {
            checkerId = $("#checkerId").val();
            checkerDept = $("#checkerDeptId").val();
        }
        if ($("#content").val() == "" || $("#content").val() == undefined) {
            alert("请填写内容");
            return;
        }
        if ($("#sendDeptId").val() == "" || $("#sendDeptId").val() == undefined) {
            alert("请选择主送部门");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/draftPaper/saveDraftPaper", {
                id: '${id}',
                checkDept: checkerDept,
                checker: checkerId,
                draftDate: $("#draftDate").val(),
                paperNumber: $("#paperNumber").val(),
                secretLevel: $("#secretLevel").val(),
                copies: $("#copies").val(),
                title: $("#t_title").val(),
                content: $("#content").val(),
                sendDeptId: $("#sendDeptId").val(),
                copyDeptId: $("#copyDeptId").val(),
                submitDeptId: $("#submitDeptId").val()
            },
            function (msg) {
                hideSaveLoadingByClass('.saveBtnClass button');
                alert("数据修改成功！");
            })
        return true;
    }


</script>
<!--主送部门-->
<script type="text/javascript">
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y": "", "N": ""}
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
        $("#menuContent1").css({
            left: sendDeptIdOffset.left + "px",
            top: sendDeptIdOffset.top + sendDeptIdObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "sendDeptIdSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length > 0)) {
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
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
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
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
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
            chkboxType: {"Y": "", "N": ""}
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
        $("#menuContent2").css({
            left: copyDeptIdOffset.left + "px",
            top: copyDeptIdOffset.top + copyDeptIdObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown2);
    }

    function hideMenu2() {
        $("#menuContent2").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown2);
    }

    function onBodyDown2(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "copyDeptIdObj" || event.target.id == "menuContent2" || $(event.target).parents("#menuContent2").length > 0)) {
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
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
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
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes2(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
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
            chkboxType: {"Y": "", "N": ""}
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
        $("#menuContent3").css({
            left: submitDeptIdOffset.left + "px",
            top: submitDeptIdOffset.top + submitDeptIdObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown3);
    }

    function hideMenu3() {
        $("#menuContent3").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown3);
    }

    function onBodyDown3(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "submitDeptIdObj" || event.target.id == "menuContent3" || $(event.target).parents("#menuContent3").length > 0)) {
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
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
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
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes3(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
<style>
    #menuContent1 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent2 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent3 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
