<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/9
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%
    String path = request.getContextPath();
%>
<script>
    //utf-8转unicode
    function Utf8ToUnicode(strUtf8) {
        var i, j;
        var uCode;
        var temp = new Array();

        for (i = 0, j = 0; i < strUtf8.length; i++) {
            uCode = strUtf8.charCodeAt(i);
            if (uCode < 0x100) {					//ASCII字符
                temp[j++] = 0x00;
                temp[j++] = uCode;
            } else if (uCode < 0x10000) {
                temp[j++] = (uCode >> 8) & 0xff;
                temp[j++] = uCode & 0xff;
            } else if (uCode < 0x1000000) {
                temp[j++] = (uCode >> 16) & 0xff;
                temp[j++] = (uCode >> 8) & 0xff;
                temp[j++] = uCode & 0xff;
            } else if (uCode < 0x100000000) {
                temp[j++] = (uCode >> 24) & 0xff;
                temp[j++] = (uCode >> 16) & 0xff;
                temp[j++] = (uCode >> 8) & 0xff;
                temp[j++] = uCode & 0xff;
            } else {
                break;
            }
        }
        temp.length = j;
        return temp;
    }

    var x = Utf8ToUnicode(menuCharsName);
    if (x == '83,79,84,12,82,158,81,108')
        srcxtbg.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/xtbgEcharts.js';
    else if (x == '101,89,82,161,123,161,116,6')
        srcjwgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/jwglEcharts.js';
    else if (x == '78,186,78,139,123,161,116,6')
        srcrsgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/rsglEcharts.js';
    else if (x == '91,102,117,31,93,229,79,92')
        srcxsgz.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/xsgzEcharts.js';
    else if (x == '128,3,104,56,139,196,101,89')
        srckhgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/khglEcharts.js';
    else if (x == '96,59,82,161,123,161,116,6')
        srczwgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/zwglEcharts.js';
    else if (x == '91,102,117,31,78,42,78,186,122,122,149,244')
        srcxsgrkj.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/xsgrkjEcharts.js';
    else if (x == '81,90,86,226,123,161,116,6')
        srcdtgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/dtglEcharts.js';
    else if (x == '130,6,96,197,123,161,116,6')
        srcyqgl.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/yqglEcharts.js';
    else if (x == '101,89,94,8,78,42,78,186,122,122,149,244')
        srcjsgrkj.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/jsgrkjEcharts.js';
    else if (x == '91,182,149,127,78,42,78,186,122,122,149,244')
        srcjzgrkj.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/jzgrkjEcharts.js';
    else if (x == '141,68,110,144,94,147')
        srczyk.src = '<%=request.getContextPath()%>/libs/js/plugins/echarts/zykEcharts.js';
</script>

<script type='text/javascript' id='srcxtbg'></script>
<script type='text/javascript' id='srcjwgl'></script>
<script type='text/javascript' id='srcrsgl'></script>
<script type='text/javascript' id='srcxsgz'></script>
<script type='text/javascript' id='srckhgl'></script>
<script type='text/javascript' id='srczwgl'></script>
<script type='text/javascript' id='srcxsgrkj'></script>
<script type='text/javascript' id='srcdtgl'></script>
<script type='text/javascript' id='srcyqgl'></script>
<script type='text/javascript' id='srcjsgrkj'></script>
<script type='text/javascript' id='srcjzgrkj'></script>
<script type='text/javascript' id='srczyk'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/echarts/my_echarts.js'></script>

