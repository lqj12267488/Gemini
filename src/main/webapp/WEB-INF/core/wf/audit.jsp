<%@ page import="com.goisan.system.bean.CommonBean" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="div1">
    <h2 style="margin-left: 40%;">
        <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
    </h2>
</div>
<div class="container">
    <div class="content">
        <button id="back" onclick="back()" class="btn btn-default btn-clean">返回</button>
        <button onclick="doPrint()" class="btn btn-default btn-clean" id="dayin">打印</button>
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div id="business"></div>
            <div id="file" class="form-row">
                <div class="col-md-3 tar">
                    &nbsp;&nbsp;&nbsp;&nbsp;附件
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    快速意见
                </div>
                <div class="col-md-9">
                    <select id="opinion" onchange="changeOpinion()"></select>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    您的意见
                </div>
                <div class="col-md-9">
                    <textarea id="workflowRemark" maxlength="165" placeholder="最多输入165个字"></textarea>
                </div>
            </div>
            <div class="form-row" id="s_fileUpload" hidden="hidden">
                <div class="col-md-3 tar">
                    文件上传：
                </div>
                <div class="col-md-9">
                    <input id="fileUpload" type="file"/>
                </div>
            </div>
            <div style="text-align: center" class="saveBtnClass">
                <c:forEach items="${definitions}" var="definitions">
                    <button class="btn btn-default btn-clean"
                            onclick="getAuditer('${definitions.term}')">${definitions.operationName}</button>
                </c:forEach>
            </div>
            <div class="form-row">
                <div class="col-md-12" style="text-align: center">
                    <br>
                    流程轨迹：
                    <c:forEach items="${nodes}" var="node" varStatus="s">
                        <c:if test="${node.nodeId == cuurentNodeId}">
                            <span style="font-size: 16px">${node.nodeName}</span>
                        </c:if>
                        <c:if test="${node.nodeId != cuurentNodeId}">
                            ${node.nodeName}
                        </c:if>
                        <c:if test="${!s.last}">
                            <span class=" icon-arrow-right"></span>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div id="logPrint" class="form-row">
                <div style="text-align: center">
                    <br>
                    <h4>流程日志</h4>
                    <c:forEach items="${workflowLog}" var="log">
                <span style="font-size: 18px">${log.cuurentNodeId}：${log.handleName}
                    <c:if test="${empty log.handleTime}">
                        ${log.createTime}
                    </c:if>
                    <c:if test="${not empty log.handleTime}">
                        ${fn:substring(log.handleTime, 0, 19)}
                    </c:if>
                </span><br/>
                        <c:if test="${empty log.remark}">
                            无<br/>
                        </c:if>
                        <c:if test="${not empty log.remark}">
                            ${log.remark}<br/>
                        </c:if>
                        <c:if test="${tableName=='T_BG_DOCUMENT_WF'}">
                            <c:if test="${empty log.fileName}">
                            </c:if>
                            <c:if test="${not empty log.fileName}">
                                <div>
                                    附件：<a href="<%=request.getContextPath()%>/document/downloadDocumentFile?id=${log.id}"
                                          target="_blank">${log.fileName}</a>
                                </div>
                                <br/>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">
<input id="termWorkflow" hidden>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/printTeacherPlan?id=${businessId}">
<input id="flag" hidden value="${flag}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    var handleName = "";
    var personId = "";
    $(document).ready(function () {
        if("T_XG_GRANT_MANAGEMENT_WF" == '${tableName}'){
            $("#dayin").hide();
        }else if ("T_DT_REPORT_MANAGEMENT" == '${tableName}'){
            $("#dayin").hide();
        }
        $("#div1").hide();
        $("#business").load('<%=request.getContextPath()%>' + '${url}');
        if ("T_BG_DOCUMENT_WF" == '${tableName}') {
            $("#s_fileUpload").show();
        }
        if ("T_BG_DOCUMENT_WF" == '${tableName}') {

            $.post("<%=request.getContextPath()%>/document/getFilesByBusinessId", {
                businessId: '${businessId}',
            }, function (data) {
                if (data.data.length == 0) {
                    $("#file").append('<div class="form-row">' +
                        '<div class="col-md-3 tar"></div>' +
                        '<div class="col-md-9">' +
                        '无' +
                        '</div>' +
                        '</div>')
                } else {
                    $.each(data.data, function (i, val) {
                        $("#file").append('<div class="form-row">' +
                            '<div class="col-md-3 tar"></div>' +
                            '<div class="col-md-9">' +
                            '<a href="' + '<%=request.getContextPath()%>/document/downloadDocumentFile?id=' + val.id + '" target="_blank">' + val.fileName + '</a>' +
                            '</div>' +
                            '</div>');
                    })
                }
            })
        } else {
            $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
                businessId: '${businessId}',
            }, function (data) {
                if (data.data.length == 0) {
                    $("#file").append('<div class="form-row">' +
                        '<div class="col-md-3 tar"></div>' +
                        '<div class="col-md-9">' +
                        '无' +
                        '</div>' +
                        '</div>')
                } else {
                    $.each(data.data, function (i, val) {
                        $("#file").append('<div class="form-row">' +
                            '<div class="col-md-3 tar"></div>' +
                            '<div class="col-md-9">' +
                            '<a href="' + '<%=request.getContextPath()%>/files/downloadFiles?id=' + val.fileId + '" target="_blank">' + val.fileName + '</a>' +
                            '</div>' +
                            '</div>');
                    })
                }
            })
        }
        $.get("<%=request.getContextPath()%>/getOpinion", function (data) {
            addOption(data, 'opinion');
        })

    })

    function changeOpinion() {
        var val = $("#opinion option:selected").val();
        if (val != "") {
            $("#workflowRemark").val($("#opinion option:selected").text());
        } else {
            $("#workflowRemark").val("");
        }
    }

    function getAuditer(term) {
        var remark = $("#workflowRemark").val();
        if (remark == '' || remark == undefined || remark == null) {
            swal({
                title: "请填写意见!",
                type: "info"
            });
            //alert("请填写意见！")
            return
        }
        if ("T_BG_DOCUMENT_WF" == '${tableName}') {
            var formData = new FormData();
            var fileUpload = document.getElementById("fileUpload");
            if ( fileUpload.files[0] != undefined){
                formData.append("file", fileUpload.files[0]);
            }
            var fileUpload = $("#fileUpload").val();
            var fileUpload_end = fileUpload.split(".");

            if (fileUpload_end[1] == 'bat' || fileUpload_end[1] == "exe") {
                swal({title: "不可上传可执行文件！", type: "info"});
                return;
            }
        }
        $("#termWorkflow").val(term);
        if (term == '-1') {
            audit()
        } else {
            showSaveLoading(".saveBtnClass button");
            $.post("<%=request.getContextPath()%>/checkUnAudit", {
                tableName: $("#tableName").val(),
                businessId: $("#businessId").val(),
            }, function (msg) {
                if (msg.status == 0) {
                    $.post("<%=request.getContextPath()%>/getAuditer", {
                        tableName: $("#tableName").val(),
                        workflowCode: $("#workflowCode").val(),
                        businessId: $("#businessId").val(),
                        term: term
                    }, function (data) {
                        hideSaveLoadingByClass(".saveBtnClass button");
                        if (data.emps.length == 1) {
                            handleName = data.emps[0].text;
                            personId = data.emps[0].id;
                            audit()
                        } else {
                            $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
                            $("#audit").modal("hide")
                        }
                    })
                } else {
                    //if (confirm("确认移交申请？")) {
                    swal({
                        title: "确认移交申请?",
                        //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "green",
                        confirmButtonText: "确认",
                        closeOnConfirm: false
                    }, function () {
                        var remark = $("#workflowRemark").val();
                        if ("T_BG_DOCUMENT_WF" == '${tableName}') {
                            if("2"==term){
                                formData.append("term", term);
                                formData.append("remark", remark);
                                formData.append("businessId", '${businessId}');
                                formData.append("tableName", '${tableName}');
                                formData.append("handleUser", personId);
                                formData.append("handleName", handleName);
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/document/audit',
                                    type: "post",
                                    processData: false,
                                    contentType: false,
                                    data: formData,
                                    success: function (data) {
                                        hideSaveLoadingByClass(".saveBtnClass button");
                                        if (data.status = 1) {
                                            swal({
                                                title: data.msg,
                                                type: "success"
                                            });
                                            //alert(data.msg)
                                            back()
                                            $("#dialog").modal("hide")
                                            $("#audit").modal("hide")
                                            $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
                                        }
                                    }
                                });
                            }else
                                {
                                formData.append("term", term);
                                formData.append("remark", remark);
                                formData.append("businessId", '${businessId}');
                                formData.append("tableName", '${tableName}');
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/document/audits',
                                    type: "post",
                                    processData: false,
                                    contentType: false,
                                    data: formData,
                                    success: function (data) {
                                        hideSaveLoadingByClass(".saveBtnClass button");
                                        if (data.status = 1) {
                                            swal({
                                                title: data.msg,
                                                type: "success"
                                            });
                                            //alert(data.msg)
                                            back()
                                            $("#dialog").modal("hide")
                                            $("#audit").modal("hide")
                                            $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
                                        }
                                    }
                                });
                            }

                        } else
                            {
                            $.post("<%=request.getContextPath()%>/audit", {
                                term: term,
                                remark: remark,
                                businessId: '${businessId}',
                                tableName: '${tableName}'
                            }, function (data) {
                                hideSaveLoadingByClass(".saveBtnClass button");
                                if (data.status = 1) {
                                    swal({
                                        title: data.msg,
                                        type: "success"
                                    });
                                    //alert(data.msg)
                                    back()
                                    $("#dialog").modal("hide")
                                    $("#audit").modal("hide")
                                    $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
                                }
                            })
                        }
                    })
                }
            })
        }
    }

    function download(id) {
        swal({
            title: 1,
            type: "info"
        });
        //alert(1)
    }

    function audit() {
        if ("T_BG_DOCUMENT_WF" == '${tableName}') {
            var formData = new FormData();
            var fileUpload = document.getElementById("fileUpload");
            if ( fileUpload.files[0] != undefined){
                formData.append("file", fileUpload.files[0]);
            }

            var fileUpload = $("#fileUpload").val();
            var fileUpload_end = fileUpload.split(".");

            if (fileUpload_end[1] == 'bat' || fileUpload_end[1] == "exe") {
                swal({title: "不可上传可执行文件！", type: "info"});
                return;
            }
        }
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == "") {
                handleName = $("#personId option:selected").text();
            }
            if (personId == "") {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == "") {
                handleName = $("#name").val();
            }
            if (personId == "") {
                personId = $("#personIds").val();
            }
        }
       /* if (personId == '') {
            swal({
                title: '请选择人员！',
                type: "warning"
            });
            return;
        }*/
        var term = $("#termWorkflow").val();
        var msg = "确认移交到" + handleName + "？";
        if (term == '-1') {
            msg = "确认办结？";
        }
        //if (confirm(msg)) {
        swal({
            title: "您确定要移交本条信息?",
            text: msg,
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function (isConfirm) {
            if (isConfirm) {
                var remark = $("#workflowRemark").val();
                showSaveLoadingByClass(".saveBtnClass button");
                if ("T_BG_DOCUMENT_WF" == '${tableName}') {
                    formData.append("term", term);
                    formData.append("remark", remark);
                    formData.append("businessId", '${businessId}');
                    formData.append("tableName", '${tableName}');
                    formData.append("handleUser", personId);
                    formData.append("handleName", handleName);
                    $.ajax({
                        url: '<%=request.getContextPath()%>/document/audit',
                        type: "post",
                        processData: false,
                        contentType: false,
                        data: formData,
                        success: function (data) {
                            hideSaveLoadingByClass(".saveBtnClass button");
                            if (data.status = 1) {
                                swal({
                                    title: data.msg,
                                    type: "success"
                                });
                                //alert(data.msg)
                                back()
                                $("#dialog").modal("hide")
                                $("#audit").modal("hide")
                                $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
                            }
                        }
                    });
                } else {
                    $.post("<%=request.getContextPath()%>/audit", {
                        term: term,
                        handleUser: personId,
                        handleName: handleName,
                        remark: remark,
                        businessId: '${businessId}',
                        tableName: '${tableName}'
                    }, function (data) {
                        hideSaveLoadingByClass(".saveBtnClass button");
                        if (data.status = 1) {
                            swal({
                                title: data.msg,
                                type: "success"
                            });
                            back();
                            $("#dialog").modal("hide");
                            $("#audit").modal("hide");
                            $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");
                        }
                    })
                }
            } else {
                handleUser = "";
                handleName = "";
            }

        })
    }

    function doPrint() {
        if($("#flag").val()=="1"){
            $("#audit").modal("hide");
        }
        var iframe=document.getElementById("print-iframe");
        if(!iframe){

            iframe = document.createElement('IFRAME');
            var doc = null;
            iframe.setAttribute("id", "print-iframe");
            iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
            document.body.appendChild(iframe);
        }
        $.get($("#printFunds").val(), function (html) {
            console.log($("#printFunds").val())
            console.log(html);
            doc = iframe.contentWindow.document;
            //这里可以自定义样式
            //doc.write("<LINK rel="stylesheet" type="text/css" href="css/print.css">");
            doc.write('<div>' + html + '</div>');
            doc.close();
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
        })
    }



    function back() {
        $("#right").load('<%=request.getContextPath()%>${backUrl}');
    }
</script>
