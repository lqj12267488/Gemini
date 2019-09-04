<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h3 class="mui-title">${data.surveyTitle}
                        </header>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="impResult()">导出
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="print()">打印
                        </button>
                    </div>
                    <div class="form-row" id="syllabus" >
                        <div class="col-md-12">
                            <table width="100%" border="1" cellspacing="0">
                                <tr ><td colspan="${colspan}" style="text-align: center;font-size: 25px">${data.surveyTitle}</td></tr>
                                <tr style="height: 80px">
                                    <td style="text-align: center">投票人</td>
                                    <c:forEach items="${questionList}" var="questionItem">
                                        <td >${questionItem.questionName}</td>
                                    </c:forEach>
                                </tr>
                                <c:forEach items="${personList}" var="personlItem">
                                    <tr>
                                        <td  style="text-align: center" >${personlItem.personType}</td>
                                        <c:forEach items="${questionList}" var="questionItem">
                                            <td id="${personlItem.personId}_${questionItem.questionId}"></td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        var answerList =  eval('${answerList}');
        $.each(answerList, function (key, map) {
            $("#"+map.personId+"_"+map.questionId).html(map.answerResult);
        })


    })

    function print() {
        $('#syllabus td').css('color','black');

        //打开一个新窗口newWindow
        var newWindow=window.open("打印窗口","_blank");
        //要打印的div的内容
        var docStr = document.getElementById('syllabus').innerHTML;
        //打印内容写入newWindow文档
        newWindow.document.write(docStr);
        //关闭文档
        newWindow.document.close();
        //调用打印机
        newWindow.print();
        //关闭newWindow页面
        newWindow.close();
        $('#syllabus td').css('color','#FFF');

    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyList");
    }

    function impResult() {
        $('#syllabus td').css('color','black');

        if (getExplorer() == 'ie') {
            var curTbl = document.getElementById("syllabus");
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
                var fname = oXL.Application.GetSaveAsFilename("投票问卷结果.xls", "Excel Spreadsheets (*.xls), *.xls");
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
        } else {
            tableToExcel('ta');
        }
        $('#syllabus td').css('color','#FFF');

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
                table = document.getElementById("syllabus");
            var ctx = {worksheet: '${data.surveyTitle}' || 'Worksheet', table: table.innerHTML}
            window.location.href = uri + base64(format(template, ctx))
        }
    })();
    function getExplorer() {
        var explorer = window.navigator.userAgent;
        if (explorer.indexOf("MSIE") >= 0) {//ie
            return 'ie';
        }
        else if (explorer.indexOf("Firefox") >= 0) {//firefox
            return 'Firefox';
        }
        else if (explorer.indexOf("Chrome") >= 0) { //Chrome
            return 'Chrome';
        }
        else if (explorer.indexOf("Opera") >= 0) {//Opera
            return 'Opera';
        }
        else if (explorer.indexOf("Safari") >= 0) { //Safari
            return 'Safari';
        }
    }




</script>