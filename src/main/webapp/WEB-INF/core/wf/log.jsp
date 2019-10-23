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
    <h2 style="margin-left: 25%;">
        <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
    </h2>
</div>
<div class="container">
    <div class="content">
        <button onclick="back()" class="btn btn-default btn-clean">返回</button>
        <c:if test="${2== states}">
            <button onclick="doPrint()" class="btn btn-default btn-clean" id="dayin">打印</button>
        </c:if>
        <div id="business"></div>
        <div id="file" class="form-row">
            <div class="col-md-3 tar">
                附件
            </div>
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
            <div id="logPrint" class="form-row">
                <div id="log" style="text-align: center">
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
</div>
<input id="tableName" hidden value="${tableName}">
<script>
    $(document).ready(function () {
        if ("T_XG_GRANT_MANAGEMENT_WF" == '${tableName}' || "T_DT_REPORT_MANAGEMENT" == '${tableName}') {
            $("#dayin").hide();
        }
        $("#div1").hide();
        $("#business").load('${url}')
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${businessId}'
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

    function doPrint() {

        /*  var bdhtml = window.document.body.innerHTML;
          $("#logPrint div").attr("style", "text-align:center; padding-left: 20%;padding-top:8%;");
          $.get($("#printFunds").val(), function (html) {
              window.document.body.innerHTML = html;
              window.print();
              window.document.body.innerHTML = bdhtml;
          })*/
        var iframe = document.getElementById("print-iframe");
        if (!iframe) {
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
