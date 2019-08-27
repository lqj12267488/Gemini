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
        <div id="business"></div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;附件
            </div>
        </div>
        <div class="form-row" id="ksyj">
            <div class="col-md-3 tar">
                快速意见
            </div>
            <div class="col-md-9">
                <select id="opinion" onchange="changeOpinion()"></select>
            </div>
        </div>
        <div class="form-row" id="yj">
            <div class="col-md-3 tar">
                您的意见
            </div>
            <div class="col-md-9">
                <textarea id="workflowRemark"></textarea>
            </div>
        </div>
        <div style="text-align: center" id="bt">
            <c:forEach items="${definitions}" var="definitions">
                <button class="btn btn-default btn-clean"
                        onclick="getAuditer('${definitions.term}')">${definitions.operationName}</button>
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
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">
<input id="termWorkflow" hidden>
<script>
    var handleName = "";
    var personId = "";
    $(document).ready(function () {
        $("#div1").hide();
        if ('${definitions}' == '') {
            $("#ksyj").hide();
            $("#yj").hide();
            $("#bt").hide();
        }
        $("#business").load('<%=request.getContextPath()%>' + '${url}');
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
                        '<a href="' + '<%=request.getContextPath()%>' + val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
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
        $("#termWorkflow").val(term);
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
                        confirmButtonText: "确认",
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

    function download(id) {
        swal({
            title: 1,
            type: "info"
        });
        //alert(1)
    }

    function audit() {
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
                        back();
                        $("#dialogFile").modal("hide")
                        $("#dialogMoreAudit").modal("hide")
                        $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");
                        $("#dialog").load("<%=request.getContextPath()%>/loadMoreAudit");
                        $("#dialog").modal("show");
                    }
                })
            } else {
                handleUser = "";
                handleName = "";
            }

        })
    }

    function doPrint() {
        var iframe=document.getElementById("print-iframe");
        if(!iframe){
            //var el = document.getElementById("printcontent");

            iframe = document.createElement('IFRAME');
            var doc = null;
            iframe.setAttribute("id", "print-iframe");
            iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
            document.body.appendChild(iframe);
        }
        $.get($("#printFunds").val(), function (html) {
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