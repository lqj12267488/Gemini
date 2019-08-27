<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="content">
                    <div class="header">
                        <span style="font-size: 15px;margin-left: 20px"> ${complexTaskName} > 查看考评结果</span>
                    </div>
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="impTable()">导出
                        </button>
                        <%--<a class="btn btn-default btn-clean"
                           href="/evaluation/complex/exportComplexResult?complexTaskId=${complexTaskId}&complexTaskName=${complexTaskName}">导出
                        </a>
                        <br>--%>
                    </div>
                    <table id="taskDetailTable"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                            <tr id="tr1">
                            </tr>
                            <tr>
                                <c:forEach items="${details}" var="index">
                                    <th>
                                        评分
                                    </th>
                                    <th>
                                        满分
                                    </th>
                                </c:forEach>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <input value="${complexTaskId}" id="complexTaskId" type="hidden"/>
    <input value="${complexTaskName}" id="complexTaskName" type="hidden"/>
    <input value="${evaluationType}" id="eType" type="hidden"/>
</div>
<script>
    var eType = $("#eType").val();
    var taskDetailTable;
    $(document).ready(function () {
        var th1 = '<th rowspan="2">被评人</th><th rowspan="2">被评人班级</th>' +
            '<th rowspan="2">得分</th>';
        var th4 ='';// '<th rowspan="$ {maxLevel + 1}">操作</th>';
        <c:forEach items="${details}" var="index">
            th1 += '<th rowspan="1" colspan="2">' + '<a title="原考评名称：${index.taskName}">${index.taskShowName}</a>'+ '</th>';
        </c:forEach>
        $("#tr1").html(th1);
        /*"url": '/evaluation/getDetails?id=' + '$ {id}' + '&taskId=' + '$ {taskId}',*/
        taskDetailTable = $("#taskDetailTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/xgEvaluation/complex/getComplexResultList?' +
                            'complexTaskId='+$("#complexTaskId").val()+'&evaluationType='+eType,
            },
            "destroy": true,
            "columns": [
                {"data": "empName"},
                {"data": "deptShow"},
                {"data": "score"},
                <c:forEach items="${details}" var="index">
                    {"data": "${index.id}-score"},
                    {"data": "${index.id}-remark"},
                </c:forEach>
            ],
            "order" : [[2,'desc'],[0,'asc']],
            "dom": 'rtlip',
            "language": language
        })
    })

    function back() {
        $("#right").load( "<%=request.getContextPath()%>/xgEvaluation/complex/getComplexResult");
    }

    function impTable() {
        method1('taskDetailTable');
    }

    var idTmr;
    function  getExplorer() {
        var explorer = window.navigator.userAgent ;
        if (explorer.indexOf("MSIE") >= 0) {//ie
            return 'ie';
        }
        else if (explorer.indexOf("Firefox") >= 0) {//firefox
            return 'Firefox';
        }
        else if(explorer.indexOf("Chrome") >= 0){ //Chrome
            return 'Chrome';
        }
        else if(explorer.indexOf("Opera") >= 0){//Opera
            return 'Opera';
        }
        else if(explorer.indexOf("Safari") >= 0){ //Safari
            return 'Safari';
        }
    }
    function method1(tableid) {//整个表格拷贝到EXCEL中
        if(getExplorer()=='ie'){
            var curTbl = document.getElementById(tableid);
            var oXL = new ActiveXObject("Excel.Application");

            //创建AX对象excel
            var oWB = oXL.Workbooks.Add();
            //获取workbook对象
            var xlsheet = oWB.Worksheets(1);
            //激活当前sheet
            var sel = document.body.createTextRange();
            sel.moveToElementText(curTbl);
            //把表格中的内容移到TextRange中
            sel.select();
            //全选TextRange中内容
            sel.execCommand("Copy");
            //复制TextRange中内容
            xlsheet.Paste();
            //粘贴到活动的EXCEL中
            oXL.Visible = true;
            //设置excel可见属性

            try {
                var fname = oXL.Application.GetSaveAsFilename("考评结果.xls", "Excel Spreadsheets (*.xls), *.xls");
            } catch (e) {
                print("Nested catch caught " + e);
            } finally {
                oWB.SaveAs(fname);

                oWB.Close(savechanges = false);
                //xls.visible = false;
                oXL.Quit();
                oXL = null;
                //结束excel进程，退出完成
                //window.setInterval("Cleanup();",1);
                idTmr = window.setInterval("Cleanup();", 1);
            }
        }else{
            tableToExcel('ta');
        }
    }
    function Cleanup() {
        window.clearInterval(idTmr);
        CollectGarbage();
    }
    var tableToExcel = (function() {
        var uri = 'data:application/vnd.ms-excel;base64,',
            template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><meta charset="utf-8"><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
            base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
            format = function(s, c) {
                return s.replace(/{(\w+)}/g,
                    function(m, p) { return c[p]; }) }
        return function(table, name) {
            if (!table.nodeType)
                table = document.getElementById("taskDetailTable");
            var ctx = {worksheet: '${complexTaskName}考评结果' || 'Worksheet', table: table.innerHTML}
            window.location.href = uri + base64(format(template, ctx))
        }
    })();
</script>
<style>
    table tr th {
        text-align: center;
    }
    table tr td {
        text-align: center;
    }
    th, td {
        white-space: nowrap;
    }
</style>
