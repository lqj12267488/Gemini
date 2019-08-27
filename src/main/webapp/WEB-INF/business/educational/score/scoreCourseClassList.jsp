<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block block-drop-shadow">
                <div class="content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title"> ${className} > ${scoreExamName} > ${courseShow} > 学生成绩报告表</h5>
                        </header>
                    </div>
                    <div>
                        <button type="button" class="btn btn-default btn-clean" id="back"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="impTable()">导出
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreGrid" style="border-color:#000;"  width="100%" cellpadding="0" cellspacing="0"  border="1">
                            <tr >
                                <th colspan="18" style="text-align: center;font-size:40px;font-family:SimSun  ;border: 0;" >学生成绩报告表</th>
                            </tr>
                            <tr >
                                <td  style="border: 0;">&nbsp;</td>
                                <td colspan="8" style="border: 0;text-align: left;" >
                                    <span >班级: &nbsp; ${className}</span>
                                </td>
                                <td colspan="8" style="border: 0;text-align: right;" >
                                    <span style="">考核类型: &nbsp;</span>
                                    <span style="text-decoration: underline;">${courseFlag}</span>
                                </td>
                                <td  style="border: 0;">&nbsp;</td>
                            </tr>
                            <tr >
                                <td  style="border: 0;">&nbsp;</td>
                                <td colspan="8" style="border: 0;text-align: left;" >
                                    <span >课程: &nbsp; ${courseShow}</span>
                                </td>
                                <td colspan="8" style="border: 0;text-align: right;" >
                                    <span style="">学期:&nbsp;</span>
                                    <span style="text-decoration: underline;">${termId}</span>
                                </td>
                                <td style="border: 0;">&nbsp;</td>
                            </tr>
                            <tr style="text-align: center">
                                <td>序 号</td>
                                <td>姓  名</td>
                                <td>A<br/>[10]</td>
                                <td>B<br/>[10]</td>
                                <td>C<br/>[10]</td>
                                <td>D<br/>[10]</td>
                                <td>平时<br/>合计</td>
                                <td>期末<br/>60</td>
                                <td>总   评</td>
                                <td>序 号</td>
                                <td>姓  名</td>
                                <td>A<br/>[10]</td>
                                <td>B<br/>[10]</td>
                                <td>C<br/>[10]</td>
                                <td>D<br/>[10]</td>
                                <td>平时<br/>合计</td>
                                <td>期末<br/>60</td>
                                <td>总   评</td>
                            </tr>
                            <c:forEach items="${row}" var="rowObj">
                                <tr id="rowNum_${rowObj}"></tr>
                            </c:forEach>
                            <tr>
                                <td colspan="18">说明：A栏填学生到课情况满分10；B栏填学生作业情况满分10；C栏填学生测验情况满分10；D栏填学生课
                                    上提问情况满分10。
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" style="border: 0;">任课教师: ${personId}
                                </td>
                                <td colspan="9" style="border: 0;">&nbsp;&nbsp;&nbsp;年 &nbsp; 月 &nbsp; 日 &nbsp;&nbsp;第 &nbsp; 页
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="scoreExamName" value="${scoreExamName}" hidden>
<input id="examId" value="${examId}" hidden>
<input id="classId" value="${classId}" hidden>
<input id="className" value="${className}" hidden>
<script>
    var courseGrid ;
    $(document).ready(function () {
        var courseClassScoreList = ${courseClassScoreList};
        var size = courseClassScoreList.length;
        var htm ="";
        if(size <= 30){
            $.each(courseClassScoreList, function (index, content) {
                htm =getHtml(content) +
                    "<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>";
                $("#rowNum_"+index).append(htm);
            })
            for(var i = size ; i < 30;i++){
                $("#rowNum_"+i).append("<td>&nbsp;&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>"+
                    "<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>");
            }
        }else if( size <=60 && size > 30 ){
            for(var i =0 ;i< 30;i++){
                if( i+1 <= size-30 ){
                    htm = getHtml(courseClassScoreList[i]) +  getHtml(courseClassScoreList[30+i]);
                }else{
                    htm = getHtml(courseClassScoreList[i]) +
                        "<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>";
                }
                $("#rowNum_"+i).append(htm);

            }
        }else{
            var L = parseInt(size/2) +2 ;
            for(var i =0 ;i< L ;i++){
                if( i+1 <= size- L ){
                    htm = getHtml(courseClassScoreList[i]) +  getHtml(courseClassScoreList[ L +i]);
                }else{
                    htm = getHtml(courseClassScoreList[i]) +
                        "<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>";
                }
                $("#rowNum_"+i).append(htm);
            }
        }
    })

    function getHtml(content) {
        var abcd = parseInt(content.peacetimeScoreA) + parseInt(content.peacetimeScoreB) +
            parseInt(content.peacetimeScoreC) + parseInt(content.peacetimeScoreD) ;
        var zf ="";
        var score = content.score ;
        if(score == null || score =="null")
            score ="";
        if(content.examinationStatus=="01"){
            zf = abcd + parseInt(score)*0.6 ;
        }else {
            zf = score;
            score ="";
        }
        if (isNaN(abcd + score + zf))
        {
            abcd="";
        }
        if(content.courseFlag=="01"){
            return htm ="<td>"+content.studentId+"</td>" +
                "<td>"+content.studentName+"</td>" +
                "<td>"+content.peacetimeScoreA+"</td>" +
                "<td>"+content.peacetimeScoreB+"</td>" +
                "<td>"+content.peacetimeScoreC+"</td>" +
                "<td>"+content.peacetimeScoreD+"</td>" +
                "<td>"+abcd+"</td><td>"+score+"</td><td>"+zf+"</td>";
        }else{
            return htm ="<td>"+content.studentId+"</td>" +
                "<td>"+content.studentName+"</td>" +
                "<td></td><td></td><td></td><td></td>" +
                "<td></td><td></td><td>"+zf+"</td>";
        }
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreClass/courseGrid?examId=${examId}"
            + "&classId=${classId}&scoreExamName=${scoreExamName}&className=${className}" );
    }


    //导出

    function impTable() {
        method1('scoreGrid');
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
                var fname = oXL.Application.GetSaveAsFilename("${className} ${courseShow} 学生成绩报告表.xls", "Excel Spreadsheets (*.xls), *.xls");
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
                table = document.getElementById("scoreGrid");
            var ctx = {worksheet: '${className} ${courseShow} 学生成绩报告表' || 'Worksheet', table: table.innerHTML}
            window.location.href = uri + base64(format(template, ctx))
        }
    })();


</script>