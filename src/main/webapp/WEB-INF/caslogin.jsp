﻿﻿<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/11
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script>
    var userAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = userAgent.match(/ipad/i) == "ipad";
    var bIsIphoneOs = userAgent.match(/iphone os/i) == "iphone os";
    var bIsMidp = userAgent.match(/midp/i) == "midp";
    var bIsUc7 = userAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
    var bIsUc = userAgent.match(/ucweb/i) == "ucweb";
    var bIsAndroid = userAgent.match(/android/i) == "android";
    var bIsCE = userAgent.match(/windows ce/i) == "windows ce";
    var bIsWM = userAgent.match(/windows mobile/i) == "windows mobile";
    if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
        window.location.href = "<%=request.getContextPath()%>/loginApp/loginJsp";
    }
</script>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="HTML, CSS, XML"/>
    <meta name="description" content="Free Web tutorials on HTML, CSS, XML"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="applicable-device" content="pc,mobile"/>
    <link rel="icon" type="libs/image/ico" href="favicon.ico"/>
    <link href="<%=request.getContextPath()%>/libs/css/css.css" rel="stylesheet" type="text/css"/>
    <script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
</head>
<body>
<!--新登录页代码-->
<!--新登录页代码结束-->
<script type="text/javascript">

    $(document).ready(function () {
        <%response.sendRedirect("/login");%>
    })

</script>
</body>
</html>
