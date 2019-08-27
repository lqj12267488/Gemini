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
        <c:if test="${backUrl}!=0">
            <button onclick="back()" class="btn btn-default btn-clean">返回</button>
        </c:if>
        <div id="business"></div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar">
                附件
            </div>
        </div>
        <div style="text-align: center">
            <br/>
            <button class="btn btn-default btn-clean" onclick="addFiles()">上传附件</button>
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
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">
<input id="url" hidden value="${url}">
<input id="backUrl" hidden value="${backUrl}">
<input id="termWorkflow" hidden>

<script>
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
                        '<a href="' +'<%=request.getContextPath()%>'+ val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
    })

    function addFiles() {
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId=${businessId}&businessType=&tableName=${tableName}");
        $("#dialogFile").modal("show");
    }

    function getAuditer(term) {
        $("#termWorkflow").val(term)
        if (term == '-1') {
            audit()
        } else {
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
                        if (data.emps.length == 1) {
                            handleName = data.emps[0].text;
                            personId = data.emps[0].id;
                            audit()
                        } else {
                            $("#dialogMoreAudit").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
                            $("#dialogFile").modal("hide")
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
                        confirmButtonText: "删除",
                        closeOnConfirm: false
                    }, function () {
                        var remark = $("#workflowRemark").val();
                        $.post("<%=request.getContextPath()%>/audit", {
                            term: term,
                            remark: remark,
                            businessId: '${businessId}',
                            tableName: '${tableName}'
                        }, function (data) {
                            if (data.status = 1) {
                                swal({
                                    title: data.msg,
                                    type: "success"
                                });
                                //alert(data.msg)
                                back()
                                $("#dialogFile").modal("hide")
                                $("#dialogMoreAudit").modal("hide")
                                $("#dialog").load("<%=request.getContextPath()%>/loadMoreAudit");
                                $("#dialog").modal("show");
                            }
                        })
                    })
                }
            })
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
        if (confirm("确认提交给" + handleName + "？")) {
            var remark = "驳回后重新申请";
            var term = $("#termWorkflow").val();
            $.post("<%=request.getContextPath()%>/audit", {
                term: term,
                handleUser: personId,
                handleName: handleName,
                remark: remark,
                businessId: '${businessId}',
                tableName: '${tableName}'
            }, function (data) {
                if (data.status = 1) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    //alert(data.msg)
                    $("#dialogFile").modal("hide")
                    $("#dialogMoreAudit").modal("hide")
                    $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");
                    $("#dialog").load("<%=request.getContextPath()%>/loadMoreAudit");
                    $("#dialog").modal("show");
                    back()
                }
            })
        }
    }

    function back() {
        $("#right").load('${backUrl}');
    }
</script>