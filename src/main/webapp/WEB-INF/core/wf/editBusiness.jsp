<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="container">
    <div class="content">
        <c:if test="${backUrl!='0'}">
            <button onclick="back()" class="btn btn-default btn-clean">返回</button>
        </c:if>
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div id="business"></div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar">
                附件
            </div>
        </div>
        <div style="text-align: center" class="saveBtnClass">
            <br/>
            <button class="btn btn-default btn-clean" onclick="addFiles()">上传附件</button>
            <button class="btn btn-default btn-clean" onclick="shutDown()">流程关闭</button>
            <c:forEach items="${definitions}" var="definition">
                <button class="btn btn-default btn-clean"
                        onclick="getAuditer('${definition.term}')">${definition.operationName}</button>
            </c:forEach>
        </div>
        <div class="form-row">
            <div class="col-md-12" style="text-align: center">
                <br>
                流程轨迹：
                <c:forEach items="${nodes}" var="node">
                    <c:choose>
                        <c:when test="${node.nodeId == '-1'}">
                            <c:if test="${node.nodeId == cuurentNodeId}">
                                <span style="font-size: 14px">办结</span>
                            </c:if>
                            <c:if test="${node.nodeId != cuurentNodeId}">
                                办结
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${node.nodeId == cuurentNodeId}">
                                <span style="font-size: 16px">${node.nodeName}</span>
                            </c:if>
                            <c:if test="${node.nodeId != cuurentNodeId}">
                                ${node.nodeName}
                            </c:if>
                            <c:if test="${!s.last}">
                                <span class=" icon-arrow-right"></span>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
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
            </c:forEach>
        </div>
    </div>
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">
<input id="url" hidden value="${url}">
<input id="backUrl" hidden value="${backUrl}">
<input id="termWorkflow" hidden>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    var handleName = "";
    var personId = "";
    $(document).ready(function () {
        $("#business").load('${url}')
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
    })

    function addFiles() {
        if ('${tableName}' == "T_JW_SLOW_EXAMINATION") {
            $("#dialog").load("<%=request.getContextPath()%>/files/filesUpload?businessId=${businessId}&businessType=&tableName=${tableName}");
            $("#dialog").modal("show");
        } else {
            $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId=${businessId}&businessType=&tableName=${tableName}");
            $("#dialogFile").modal("show");
        }
    }

    function shutDown() {
        showSaveLoading(".saveBtnClass button");
        $.post("<%=request.getContextPath()%>/stop", {
            startId: '${startId}',
            handleId: '${handleId}',
            remark: "申请人流程关闭",
            businessId: '${businessId}',
            tableName: '${tableName}'
        }, function (data) {
            hideSaveLoadingByClass(".saveBtnClass button");
            swal({
                title: "流程已关闭！",
                type: "info"
            });
            $("#dialog").modal("hide")
            $("#audit").modal("hide")
            $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
            back()
        })
    }

    function getAuditer(term) {
        $("#termWorkflow").val(term)
        if (term == '-1') {
            audit()
        } else {
            if (save()) {
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
                        hideSaveLoadingByClass(".saveBtnClass button");
                        //if (confirm("确认移交申请？")) {
                        swal({
                            title: "确认移交申请?",
                            //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "green",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            showSaveLoading(".saveBtnClass button");
                            var remark = $("#workflowRemark").val();
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
                        })
                    }
                })
            }
        }

    }

    function audit() {
        save()
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
        if (personId == '') {
            swal({
                title: '请选择人员！',
                type: "warning"
            });
            return;
        }
        if (confirm("修改保存成功，是否确认提交给" + handleName + "？")) {
            var remark = "驳回后重新申请";
            var term = $("#termWorkflow").val();
            showSaveLoading(".saveBtnClass button");
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
                    //alert(data.msg)
                    $("#dialog").modal("hide")
                    $("#audit").modal("hide")
                    $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit")
                    back()
                }
            })
        }
    }

    function back() {
        $("#right").load('${backUrl}');
    }
</script>