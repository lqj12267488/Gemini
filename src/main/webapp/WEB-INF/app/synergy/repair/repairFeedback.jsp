<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2019/10/9
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <span id="back" class=" mui-icon mui-icon-left-nav mui-pull-left" onclick="back()" style="color:#fff;"></span>
    <h1 id="title" class="mui-title">反馈</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

</header>
<div class="modal-body clearfix" style="position: relative; top: 50px;">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="controls" >
        <div class="form-row">
            <div class="col-md-2 tar">
                反馈状态
            </div>
            <div class="col-md-9">
                <select id="feedbackFlag"  class="js-example-basic-single">
                    <option value="1">满意</option>
                    <option value="2">不满意</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-2 tar">
                <span class="iconBtx">*</span>
                反馈意见
            </div>
            <div class="col-md-9">
                <input id="fback" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                       maxlength="30" placeholder="最多输入30个字"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.feedback}"/>
            </div>
        </div>
    </div>
    <div style="text-align: center">
        <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
    </div>
</div>


</body>
<script>
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
    function back() {
        window.location.href = "<%=request.getContextPath()%>/repair/repairApp";
    }
    function save() {
       var feedbackFlag =  $("#feedbackFlag").val();
       var fback = $("#fback").val();
        var id = "${id}";
        console.log(id)
      $.ajax({
          url:"<%=request.getContextPath()%>/repair/saveFeedbackInfo",
          type:"post",
          dataType:"json",
          data:{
              feedbackFlag:feedbackFlag,
              fback:fback,
              id:id
          },
          success:function (msg) {
              alert(msg.msg);
              window.location.href = "<%=request.getContextPath()%>/repair/repairApp";
          }

      })
    }
</script>
</html>
