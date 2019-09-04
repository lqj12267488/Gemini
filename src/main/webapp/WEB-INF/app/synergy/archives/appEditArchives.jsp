<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:49
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
</head>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">电子档案编辑</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="mui-content">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>创建部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${archives.createDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>创建人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${archives.creator}" readonly="readonly"/>
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
                <input type="date" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${archives.requestDate}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>学校类别
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <select id="schooltype" style="font-size: 18px;"></select>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>一级类别
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <select id="f_noticeTypeId" style="font-size: 18px;"></select>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>二级类别
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center; ">
                <select id="tt" style="font-size: 18px;"></select>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>档案类型
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center; " readonly>
                <select id="ttt" style="font-size: 18px;"></select>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx"></span>档案名称
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_name" style="text-align:center;"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${archives.archivesName}">${archives.archivesName}</textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>文件形成时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
                <input type="date" id="formatTime" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${archives.formatTime}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx"></span>备注
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_content" style="text-align:center;" maxlength="665" placeholder="最多输入665个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${archives.remark}">${archives.remark}</textarea>
            </div>
            <div class="mui-content">
                <div style="display: inline">
                    <input type="file" name="file" id="appFile" width="90%">
                    <button class="mui-btn mui-btn-primary" onclick="update()">上传</button>
                </div>
            </div>

            <div class="mui-content">
                <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                    &nbsp;&nbsp;&nbsp;&nbsp;附件
                </div>
                <div id="fileList" class="col-md-9" style="vertical-align:middle;height: 100px">
                </div>
            </div>

            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
            <div style="text-align: center;margin-left: 15%;" class="saveBtnClass">
                <button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                        onclick="saveArchives()">保存
                </button>
            </div>
            <div class="col-md-9" style="vertical-align:middle;height: 100px">
            </div>
        </div>
    </div>
</div>
<input id="archivesId" type="hidden" value="${archives.archivesId}">
<input id="menuType" type="hidden" value="${menuType}">
<input id="archivesCode" hidden value="${archives.archivesCode}">
<input id="editedId" hidden value="${archives.editedId}">
<input id="role" hidden value="${role}">
</body>
<script>
    var rflag;
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    var fileDate;
    $(document).ready(function () {
        var oneLevelVal = "";
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: "TYPE_ID",
            text: "TYPE_NAME",
            tableName: "DZDA_TYPE",
            where: "WHERE PARENT_TYPE_ID='0'",
            orderby: "ORDER BY TYPE_ID"
        }, function (data) {
            $("#f_noticeTypeId").append("<option value=''>请选择</option>");
            $.each(data, function (index, content) {
                if ('${archives.oneLevel}' === content.text) {
                    oneLevelVal = content.id;
                    $("#f_noticeTypeId").append("<option value='" + content.id + "' selected='selected'>" + content.text + "</option>");
                } else {
                    $("#f_noticeTypeId").append("<option value='" + content.id + "'>" + content.text + "</option>");
                }
            })
            $("#f_noticeTypeId").click();

            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID ='" + oneLevelVal + "'",
                orderby: "ORDER BY TYPE_ID"
            }, function (data) {
                $("#tt").append("<option value=''>请选择</option>");
                $.each(data, function (index, content) {
                    if ('${archives.twoLevel}' === content.text)
                        $("#tt").append("<option value='" + content.id + "' selected='selected'>" + content.text + "</option>");
                    else
                        $("#tt").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            });
            $("#tt").click();
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DALX", function (data) {
            $.each(data, function (index, content) {
                if ('${archives.fileType}' == content.text)
                    $("#ttt").append("<option value='" + content.id + "' selected='selected'>" + content.text + "</option>");
                else
                    $("#ttt").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
            $("#ttt").click();
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXLB", function (data) {
            $.each(data, function (index, content) {
                if ('${archives.schoolType}' == content.text)
                    $("#schooltype").append("<option value='" + content.id + "' selected='selected'>" + content.text + "</option>");
                else
                    $("#schooltype").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
            $("#schoolType").click();
        });

        reloadFileList();
    })

    $("#f_noticeTypeId").change(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID ='" + $("#f_noticeTypeId option:selected").val() + "'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                $("#tt").html("");
                $.each(data, function (index, content) {
                    $("#tt").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            });
    })

    function update() {
        var file = document.getElementById("appFile").files[0];
        if (file == "" || file == undefined || file == null) {
            alert("请选择文件！")
            return
        }
        var tableName = "DZDA_MESSAGE";
        var id = $("#archivesId").val()
        var form = new FormData();
        form.append("file", file);
        form.append("businessId", id);
        form.append("tableName", tableName);
        form.append("archivesId", id);
        form.append("archivesName", $("#f_name").val());

        var fName = $("#appFile").val();

        if ($("#ttt").val() == "") {
            alert("请选择档案类型");
            return;
        }

        var name = fName.slice(fName.length - 4, fName.length);
        if ($("#ttt").val() == '1') {
            if (name != '.mp3' && name != '.wma' && name != '.wav') {
                alert("附件类型不符，不能上传" + name + "文件");
                return;
            }
        } else if ($("#ttt").val() == '2') {
            if (name != '.mp4' && name != '.flv' && name != '.avi'
                && name != '.wmv' && name != '.mov' && name != '.vob' && name != '.mkv') {
                alert("附件类型不符，不能上传" + name + "文件");
                return;
            }
        } else if ($("#ttt").val() == '3') {
            if (name != '.jpg' && name != '.png' && name != 'jpeg'
                && name != '.gif' && name != '.bmp') {
                alert("附件类型不符，不能上传" + name + "文件");
                return;
            }
        } else if ($("#ttt").val() == '4') {
            if (name != '.txt' && name != '.doc' && name != 'docx' && name != 'xlsx'
                && name != '.ppt' && name != '.pdf' && name != '.xls' && name != 'xlsx' && name != '.rar'
                && name != '.zip' && name != 'pptx' && name != '.jpg' && name != '.png' && name != 'jpeg'
                && name != '.gif' && name != '.bmp') {
                alert("附件类型不符，不能上传" + name + "文件");
                return;
            }
        }

        var check = "";
        if (fileDate != null)
            for (var i = 0; i < fileDate.length; i++) {
                var file = fileDate[i];
                if (fName.length > file.fileName.length) {
                    var name = fName.slice(fName.length - file.fileName.length, fName.length);
                    if (file.fileName == name) {
                        check = "文件名重复，无法上传";
                        i = fileDate.length + 1;
                    }
                }
            }
        if (check != "") {
            alert(check);
            return;
        }

        $.ajax({
            url: '<%=request.getContextPath()%>/archives/appFiles',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {
                alert("上传成功！");
                $("#appFile").val("");
                reloadFileList();
            }
        });
    }

    function del(fileId) {
        $.post("<%=request.getContextPath()%>/archives/deleteFileByFileId", {
            fileId: fileId
        }, function (msg) {
            alert(msg.msg);
            reloadFileList();
        })
    }

    function reloadFileList() {
        $.get("<%=request.getContextPath()%>/archives/getFilesByBusinessId?businessId=" + $("#archivesId").val(), function (data) {
            var html = "";
            $.each(data.data, function (index, file) {
                html += "<p style='font-size: 17px'><span style='margin-left: 10px'>" + file.fileName +
                    "</span>&nbsp;&nbsp;&nbsp;" +
                    "<span style='margin-left: 30px' fileId='" + file.fileId + "'  onclick='del(\"" + file.fileId + "\")'>删除</span> </p>";
            })
            fileDate = data.data;
            $("#fileList").html(html)
        })
    }


    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function saveArchives() {
        if ($("#menuType").val() == "13") {
            rflag = '7';
        } else {
            rflag = '6';
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            alert("请填写申请日期");
            return;
        }
        if ($("#f_noticeTypeId option:selected").val() == "" ||
            $("#f_noticeTypeId option:selected").val() == "0" ||
            $("#f_noticeTypeId option:selected").val() == undefined) {
            alert("请选择一级类别");
            return;
        }
        if ($("#tt").val() == "" || $("#tt").val() == "0" || $("#tt").val() == undefined) {
            alert("请选择二级类别");
            return;
        }
        if ($("#ttt").val() == "" || $("#ttt").val() == "0" || $("#ttt").val() == undefined) {
            alert("请选择档案类型");
            return;
        }
        if ($("#formatTime").val() == "" || $("#formatTime").val() == "0" || $("#formatTime").val() == undefined) {
            alert("请选择档案形成时间");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/archives/saveArchives", {
            archivesId: $("#archivesId").val(),
            archivesCode: $("#archivesCode").val(),
            requestDate: $("#f_requestDate").val(),
            oneLevel: $("#f_noticeTypeId option:selected").val(),
            twoLevel: $("#tt").val(),
            fileType: $("#ttt").val(),
            remark: $("#f_content").val(),
            archivesName: $("#f_name").val(),
            role: $("#role").val(),
            editedId: $("#editedId").val(),
            schoolType: $("#schooltype").val(),
            formatTime: $("#formatTime").val(),
            requestFlag: rflag
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1) {
                alert(msg.msg);
                window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=" + $("#menuType").val();
            }
        })
    }
</script>
</html>
