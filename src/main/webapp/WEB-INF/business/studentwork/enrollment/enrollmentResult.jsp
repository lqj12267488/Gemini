<%@ page import="com.goisan.system.bean.CommonBean" %><%--
  Created by IntelliJ IDEA.
  User: NeilVan
  Date: 2018/5/5
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title></title>
    <link href="<%=request.getContextPath()%>/libs/css/cxstyle.css" rel="stylesheet" type="text/css">

</head>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
<body>
<div class="header_logo">
    <div class="header_logo_con">
        <h1 class="h1_logo"><%=CommonBean.getParamValue("SZXXMC")%>考生录取查询</h1>
    </div>
</div>


<div class="main">
    <div class="mainCon">
        <div class="leftLoginIntro">
            <h2>系统使用说明</h2>
            <table width="360" class="login_intro_table">
                <tr>
                    <td align="left" valign="top" class="text12"><span class="style1">1、</span></td>
                    <td align="left" valign="top" class="text12">系统查询结果禁止使用于其他任何目的。造成不良后果的，将依法追究责任。</td>
                </tr>
                <tr>
                    <td align="left" valign="top" class="text12"><span class="style1">2、</span></td>
                    <td align="left" valign="top" class="text12">请输入完整准确的身份证号。<br>
                </tr>
            </table>

        </div>
        <div class="rightLoginContent">

            <div class="loginBox">
                <h2>录取查询</h2>
                <input type="hidden" name="doLogin" value="true">
                <div>
                  <span class="sf">身份证号：</span><input type="text" id="ZJH" name="ZJH" class="inputBox" title="请输入身份证号码" />
                </div>

                <div>
                   <span class="sf">考生姓名：</span><input type="text" id="XM" name="XM" class="inputBox" title="请输入中文姓名" />
                </div>
                <div>
                    <button class="login_button" onclick="searchStu()">查 询</button>
                </div>
            </div>

        </div>
        <div class="clear"></div>
    </div>
</div>



<div class="foot">
    <div class="footer">
        <div class="copyright">
            <%=CommonBean.getParamValue("SZXXMC")%>招生办公室&nbsp;&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;&copy;&nbsp;2017<br>
        </div>
    </div>
</div>
</body>

<script language="JavaScript">
    function refresh_image()
    {
        document.getElementById("captcha_image").src ='captcha.php';
    }

    function trim(text)
    {
        return text.replace(/^\s+/,"").replace(/\s+$/,"");
    }

    function searchStu(){
        if ($("#ZJH").val()==""||$("#ZJH").val()==null){
                alert("请输入身份证号！")
                return false;
            }
        $.ajax({
            "type":"get",
            "jsonp":"callback",
            "url": '<%=request.getContextPath()%>/enrollment/result',
            "data":{
                idcard:document.getElementById('ZJH').value,
                name:document.getElementById('XM').value
            },
            "success":function(data){
                if(data.status==0 ){
                    alert(data.msg);
                }else{
                    alert(data.msg);
                }}
        })

    }

</script>


</html>

