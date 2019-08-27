<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/3/14
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/echarts/xsgzEcharts.js'></script>
</head>
<body>
<div style="height: 100%">
    <div class="row">
        <div class="col-md-12">
            <div id="right" class="col-md-10">
                <ul id="eCharts_ul" style="list-style: none;"></ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var liListFlag = false;
    var liList = new Array(5);//生成<li>
    var liListAll = '';
    var myCharts = new Array(5);//图表个数
    var myChartFlag = new Array(5);
    var options = new Array(5);//图表数组
    var dataArray=null;
    $(document).ready(function () {
        $.post(getPath() + '/echartsMenu/getCountDeptMajorEcharts', {},
            function (msg) {
                dataArray = msg;
                countDeptMajorEcharts(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray);
            }
        );
    })
</script>
