<%@ page import="com.goisan.system.bean.CommonBean" %><%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/28
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/31
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .FangSong{
        font-size:18.7px;
        font-family:FangSong;
    }
    .FangSong1{
        font-size:16px;
        font-family:FangSong;
    }
    .FangSong2{
        font-size:15px;
        font-family:FangSong;
    }
    .KaiTi{
        font-size:18.7px;
        font-family:KaiTi ;
    }
    .td {
        font-size:16px;
        font-family:KaiTi ;
    }

</style>
<div class="container">
    <div class="block">
        <div class="block block-drop-shadow content">
            <div class="form-row">
                <div class="col-md-12">
                    <c:choose>
                        <c:when test="${returnFlag == 1 }">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                        </c:when>
                    </c:choose>
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="impTable()">导出
                    </button>
                </div>
                <div class="col-md-2">
                    请选择表单标题：
                </div>
                <div class="col-md-2">
                    <select id="change" onchange="changeTitle()">
                        <option value="白城职业技术学院" selected>白城职业技术学院</option>
                        <option value="白城师范学院分院">白城师范学院分院</option>
                    </select>
                </div>
                <br/><br/>
                <table id="scoreGrid" width="100%" cellpadding="0" cellspacing="0"  border="1">
                    <tr >
                        <th colspan="8" style="text-align: center;font-size:26.7px;font-family:STXingkai ;border: 0;" id="titleVal" ><%=CommonBean.getParamValue("SZXXMC")%></th>
                    </tr>
                    <tr  style="height:50px;width: 100%" border="0">
                        <td colspan="8" style="text-align: center;font-size:37.35px;font-family:SimSun ;border: 0;">学  生  成  绩  单</td>
                    </tr>
                    <tr  style="height: 30px;width: 100%" border="0">
                        <td style="border: 0;width: 10.5%">&nbsp;&nbsp;</td>
                        <td style="border: 0;width: 6%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td style="border: 0;width: 16.5%"></td>
                        <td style="border: 0;width: 16.5%"></td>
                        <td style="border: 0;width: 10.5%">&nbsp;&nbsp;</td>
                        <td style="border: 0;width: 6%"></td>
                        <td style="border: 0;width: 16.5%"></td>
                        <td style="border: 0;width: 16.5%"></td>
                    </tr>
                    <tr>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>姓  名</b></td>
                        <td colspan="2" style="font-size:18.7px;font-family:KaiTi">${studentName}</td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>入学时间</b></td>
                        <td colspan="2" style="font-size:18.7px;font-family:KaiTi">${arrayclassResultClass.year}</td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>毕业时间</b></td>
                        <td style="font-size:18.7px;font-family:KaiTi">${arrayclassResultClass.graduationYear}</td>
                    </tr>
                    <tr>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>院系名</b></td>
                        <td colspan="2" style="font-size:18.7px;font-family:KaiTi">${arrayclassResultClass.departmentShow}</td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>专    业</b></td>
                        <td colspan="2" style="font-size:18.7px;font-family:KaiTi">${arrayclassResultClass.majorShow}</td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>班   级</b></td>
                        <td style="font-size:18.7px;font-family:KaiTi">${arrayclassResultClass.classShow}</td>
                    </tr>
                    <tr>
                        <td class="FangSong" colspan="2" style="font-size:18.7px; font-family:FangSong"><b>课程名</b></td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>成 绩</b></td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>考试时间</b></td>
                        <td class="FangSong" colspan="2" style="font-size:18.7px; font-family:FangSong"><b>课程名</b></td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>成 绩</b></td>
                        <td class="FangSong" style="font-size:18.7px; font-family:FangSong"><b>考试时间</b></td>
                    </tr>
                    <c:forEach items="${row}" var="rowObj">
                        <tr id="rowNum_${rowObj}"></tr>
                    </c:forEach>
                    <tr>
                        <td colspan="2" class="td" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" colspan="2" style="font-size:16px;font-family:KaiTi"> </td>
                        <td class="td" style="font-size:16px;font-family:KaiTi"> </td>
                        <td class="td" style="font-size:16px;font-family:KaiTi"> </td>
                    </tr>
                    <tr>
                        <td class="td" colspan="2" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" style="font-size:16px;font-family:KaiTi">&nbsp;&nbsp;</td>
                        <td class="td" colspan="2" style="font-size:16px;font-family:KaiTi"> </td>
                        <td class="td" style="font-size:16px;font-family:KaiTi"> </td>
                        <td class="td" style="font-size:16px;font-family:KaiTi"> </td>
                    </tr>

                    <tr >
                        <th colspan="3" style="font-size:18.7px; font-family:FangSong;border: 0;">制表人：      </th>
                        <th colspan="2" style="font-size:18.7px; font-family:FangSong;border: 0;">教务处（盖章）</th>
                        <th colspan="2" style="font-size:18.7px; font-family:FangSong;border: 0;"  >教务处长：</th>
                        <th colspan="3" style="text-align: right;font-size:18.7px; font-family:FangSong;border: 0;">&nbsp;&nbsp;&nbsp;年&nbsp;月&nbsp;日</th>
                    </tr>
                    <tr >
                        <th colspan="8" style="font-size:14.7px; font-family:FangSong;border: 0;" >注：考查课成绩分为优、良、中、及格、不及格，不及格补考合格后成绩为补及。</th>
                    </tr>
                    <tr >
                        <th colspan="8" style="border: 0;" >&nbsp;</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        var arrayclassResultClassList = ${arrayclassResultClassList};
        var size = arrayclassResultClassList.length;

        var htm ="";
        if(size <= 30){
            $.each(arrayclassResultClassList, function (index, content) {
                htm =getHtml(content) +
                    "<td colspan='2' style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td>";
                $("#rowNum_"+index).append(htm);
            })
            for(var i = size ; i < 30;i++){
                $("#rowNum_"+i).append("<td colspan='2' style='font-size:16px;font-family:KaiTi'>&nbsp;&nbsp;</td><td style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td>"+
                    "<td colspan='2' style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td>");
            }
        }else if( size <=60 && size > 30 ){
            for(var i =0 ;i< 30;i++){
                if( i+1 <= size-30 ){
                    htm = getHtml(arrayclassResultClassList[i]) +  getHtml(arrayclassResultClassList[30+i]);
                }else{
                    htm = getHtml(arrayclassResultClassList[i]) +
                        "<td colspan='2' style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td>";
                }
                $("#rowNum_"+i).append(htm);

            }
        }else{
            var L = parseInt(size/2) +2 ;
            for(var i =0 ;i< L ;i++){
                if( i+1 <= size- L ){
                    htm = getHtml(arrayclassResultClassList[i]) +  getHtml(arrayclassResultClassList[ L +i]);
                }else{
                    htm = getHtml(arrayclassResultClassList[i]) +
                        "<td colspan='2' style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td><td style='font-size:16px;font-family:KaiTi'></td>";
                }
                $("#rowNum_"+i).append(htm);
            }
        }
    })

    function getHtml(content) {
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if(!reg1.test(content.score)){
            if(null == (content.score)){
                content.score = "";
            }
        }else{
            content.studentSource;
        }
        return htm ="<td  colspan='2' style='font-size:16px;font-family:KaiTi'>"+content.courseName+"</td>" +
            "<td style='font-size:16px;font-family:KaiTi'>"+content.studentSource+"</td>" + "<td style='font-size:16px;font-family:KaiTi'>"+content.testTime+"&nbsp;&nbsp;&nbsp;</td>" ;
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreExam/getStudentList");
    }

    function changeTitle() {
        $("#titleVal").html($("#change").val());
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
                var fname = oXL.Application.GetSaveAsFilename("${studentName} 学生成绩报告表.xls", "Excel Spreadsheets (*.xls), *.xls");
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
        return function(table, name)   {
            if (!table.nodeType)
                table = document.getElementById("scoreGrid");
            var ctx = {worksheet: '${studentName} 学生成绩报告表' || 'Worksheet', table: table.innerHTML}
            window.location.href = uri + base64(format(template, ctx))
        }
    })();
</script>
<style>
    td{
        text-align: center;
    }
    .div{
        text-align: center;
    }

</style>
