<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2019/10/9
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet"/>

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.previewimage.js"></script>
    <style>
        .col-md-9 {
            line-height: 40px;
            height: 40px;
            text-align: center;
            width: 100%;
        }

        input {
            line-height: 40px;
            height: 40px;
            text-align: center;
            width: 100%;
        }

        .col-md-3 {
            background: #d0d0d0;
            height: 25px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <span id="back" class=" mui-icon mui-icon-left-nav mui-pull-left" onclick="back()" style="color:#fff;"></span>
    <h1 id="title" class="mui-title">反馈</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

</header>
<div class="modal-body clearfix" style="position: relative; top: 50px;">
    <div id="layout"
         style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>

    <div class="mainBodyClass">
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            ${repair.name}
        </div>
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修类型
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            ${repair.repairTypeShow}
        </div>
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修物品名称
        </div>
        <div class="col-md-9">
            ${repair.itemNameShow}
        </div>
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>联系人电话
        </div>
        <div class="col-md-9">
            ${repair.contactNumber}
        </div>
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>故障描述
        </div>
        <div class="col-md-9">
            ${repair.faultDescription}
        </div>
        <div class="col-md-3 tar">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>维修地址
        </div>
        <div class="col-md-9">
            ${repair.repairAddress}
        </div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar"style="background:#d0d0d0;height:25px;vertical-align:middle;">
                附件
            </div>
        </div>

        <c:if test="${flag==1}">
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>反馈状态
            </div>
            <c:if test="${repair.feedbackFlag==1}">
                <div class="col-md-9">
                        满意
                </div>
            </c:if>
            <c:if test="${repair.feedbackFlag==2}">
                <div class="col-md-9">
                    不满意
                </div>
            </c:if>

            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>反馈意见
            </div>
            <div class="col-md-9">
                    ${repair.feedback}
            </div>
        </c:if>

        <c:if test="${flag==0}">
        <div class="form-row">
            <div class="col-md-3 tar">
                反馈状态
            </div>
            <div class="col-md-9">
                <select id="feedbackFlag" class="js-example-basic-single">
                    <option value="1">满意</option>
                    <option value="2">不满意</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar">
                <span class="iconBtx">*</span>
                反馈意见
            </div>
            <div class="col-md-9">
                <input id="fback" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                       maxlength="30" placeholder="最多输入30个字"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.feedback}"/>
            </div>
        </div>
    </div>
    <div style="text-align: center">
        <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
    </div>
        </c:if>


</div>

</body>
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${repair.repairID}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="col-md-9" style="vertical-align:middle; height: auto; margin-bottom: 10px">' +
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
                    $("#file").append('<div class="col-md-9" style="vertical-align:middle; height: auto; margin-bottom: 10px">' +
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
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function back() {
        window.location.href = "<%=request.getContextPath()%>/repair/repairApp";
    }

    function save() {
        var feedbackFlag = $("#feedbackFlag").val();
        var fback = $("#fback").val();
        var id = "${id}";
        console.log(id)
        $.ajax({
            url: "<%=request.getContextPath()%>/repair/saveFeedbackInfo",
            type: "post",
            dataType: "json",
            data: {
                feedbackFlag: feedbackFlag,
                fback: fback,
                id: id
            },
            success: function (msg) {
                alert(msg.msg);
                window.location.href = "<%=request.getContextPath()%>/repair/repairApp";
            }

        })
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
</html>
