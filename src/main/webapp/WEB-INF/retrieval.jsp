<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/5/15
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="icon" type="libs/image/ico" href="favicon.ico"/>
        <link href="../libs/css/stylesheets.css" rel="stylesheet" type="text/css"/>
        <script type='text/javascript' src='../libs/js/plugins/jquery/jquery.min.js'></script>
        <script type='text/javascript' src='../libs/js/plugins/jquery/jquery-ui.min.js'></script>
        <script type='text/javascript' src='../libs/js/plugins/jquery/jquery-migrate.min.js'></script>
        <script type='text/javascript' src='../libs/js/plugins/jquery/globalize.js'></script>
        <script type='text/javascript' src='../libs/js/plugins/bootstrap/bootstrap.min.js'></script>
        <script type='text/javascript' src='../libs/js/plugins/uniform/jquery.uniform.min.js'></script>
        <script type='text/javascript' src='../libs/js/plugins.js'></script>
        <script type='text/javascript' src='../libs/js/actions.js'></script>
        <script type='text/javascript' src='../libs/js/settings.js'></script>
    </head>
    <title></title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <div class="modal-header" style="text-align:center">
                <span id="appIndex" class="close" data-dismiss="modal" aria-hidden="true" onclick="backMain()" style="color:#fff;">&times;</span>
                <h1>密码找回</h1>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <input type="hidden" id="userAccount"/>
        <div class="col-md-12">
            <div class="form-row" >
                <div class="col-md-3" ></div>
                <div class="col-md-2" >1.确认帐号</div>
                <div class="col-md-2" >2.安全验证</div>
                <div class="col-md-2" >3.重置密码</div>
                <div class="col-md-3" ></div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="controls" id="view">
            </div>
        </div>

    </div>
</div>
<%-- <div class="form-row">
     <div class="col-md-3 tar" id="viewque">
         请回答账号保护问题
     </div>
     <div class="col-md-5">
         <input id="question" type="text" value="${loguser.question}"/>
     </div>
     <div  class="col-md-4" id="questionCheck"></div>
 </div>

 <div class="form-row">
     <div class="col-md-3 tar" id="viewans">
         请填写答案
     </div>
     <div class="col-md-5">
         <input id="answer" type="text" />
     </div>
     <div  class="col-md-4" id="answerCheck" >
     </div>
 </div>--%>
</body>
</html>
<script>
    $(document).ready(function () {
        $("#view").html(
            '<div class="form-row">'+
                '<div class="col-md-3 "></div>'+
                '<div class="col-md-5">请填写您需要找回的帐号</div>'+
            '</div>'+
            '<div class="form-row">'+
                '<div class="col-md-3 "></div>'+
                '<div class="col-md-5">'+
                    '<input id="username" type="text" />'+
                '</div>'+
                '<div  class="col-md-4"  id="usernameCheck"></div>'+
            '</div>'+
            '<div class="modal-footer"  style="text-align:center">'+
                '<button type="button" class="btn btn-success btn-clean" onclick="GetQuestion()">下一步</button>'+
            '</div>');
    });

    function GetQuestion(){
        if($("#username").val()==""){
            $("#usernameCheck").html('<a class="styleRed">请填写您需要找回的帐号</a>');
        }else{
            $.ajax({
                url: "/resetPwdGetQuestion",
                data: {
                    userAccount: $("#username").val(),
                },
                type:"get",
                success: function (data) {
                    $("#userAccount").val($("#username").val());
                    if(null == data || "" == data || data.size == 0){
                        $("#usernameCheck").html('<a class="styleRed">您填写的帐号不存在</a>');
                    }else{
                        var question=data.question;
                        if( null == question ||question == "" ){
                            $("#usernameCheck").html('<a class="styleRed">您的账号没有添加密码问题，请与管理员联系</a>');
                        }else {
                            $("#view").html(
                                '<div class="form-row">'+
                                    '<div class="col-md-3 "></div>'+
                                    '<div class="col-md-5">请填写密码问题答案</div>'+
                                '</div>'+
                                '<div class="form-row">'+
                                    '<div class="col-md-3 tar">密码问题</div>'+
                                    '<div class="col-md-5">'+question+'</div>'+
                                    '<div  class="col-md-4"  id="questionCheck"></div>'+
                                '</div>'+
                                '<div class="form-row">'+
                                    '<div class="col-md-3 tar">答案</div>'+
                                    '<div class="col-md-5">'+
                                        '<input id="answer" type="text" />'+
                                    '</div>'+
                                    '<div  class="col-md-4"  id="answerCheck"></div>'+
                                '</div>'+
                                '<div class="modal-footer"  style="text-align:center">'+
                                    '<button type="button" class="btn btn-success btn-clean" onclick="PwdCheckQue()">下一步</button>'+
                                '</div>');
                        }
                    }
                }
            })
        }
    }

    function PwdCheckQue(){
        if($("#answer").val()=="") {
            $("#answerCheck").html('<a class="styleRed">请填写密码问题答案</a>');
        }else{
            $.ajax({
                url: "/resetPwdCheckQue",
                data: {
                    userAccount: $("#userAccount").val(),
                    answer: $("#answer").val()
                },
                type:"post",
                success: function (msg) {
                    if(msg.status == 0){
                        $("#answerCheck").html('<a class="styleRed">您填写的答案有误</a>');
                    }else{
                        $("#view").html(
                            '<div class="form-row">'+
                                '<div class="col-md-3 "></div>'+
                                '<div class="col-md-5">请输入新密码</div>'+
                            '</div>'+
                            '<div class="form-row">'+
                                '<div class="col-md-3 tar">请输入新密码</div>'+
                                '<div class="col-md-5"><input id="newPwd" type="password"/></div>'+
                                '<div  class="col-md-4" id="newPwdCheck"></div>'+
                            '</div>'+
                            '<div class="form-row">'+
                                '<div class="col-md-3 tar">密码确认</div>'+
                                '<div class="col-md-5"><input id="newpwdAgain" type="password"/></div>'+
                                '<div  class="col-md-4" id="newpwdAgainCheck"></div>'+
                            '</div>'+
                            '<div class="modal-footer"  style="text-align:center">'+
                                '<button type="button" class="btn btn-success btn-clean" onclick="PwdDoChange()">保存</button>'+
                            '</div>');
                    }
                }
            })
        }
    }

    function PwdDoChange(){
        checkNewPwd();
        checkPwdAgain();
        if($("a").hasClass("styleRed")){
            return;
        }
        $.ajax({
            url: "/resetPwdDoChange",
            data: {
                userAccount: $("#userAccount").val(),
                password: $("#newPwd").val(),
            },
            success: function (msg) {
                if (msg.status == 1) {
                    alert("保存成功！");
                    window.location.href = "/logout";
                }
            }
        })

    }

    /*$("#newPwd").blur();*/
    function checkNewPwd(){
        if($("#newPwd").val()!=""){
            if($("#newPwd").val().length<6)
                $("#newPwdCheck").html('<a class="styleRed">您输入的新密码小于六位</a>');
            else{
                if($("#newpwdAgain").val()!=$("#newPwd").val()){
                    $("#newPwdCheck").html('');
                    $("#newpwdAgainCheck").html('<a class="styleRed">两次密码不一致</a>');
                }else {
                    $("#newPwdCheck").html('');
                    $("#newpwdAgainCheck").html('');
                }
            }
        }else if($("#newPwd").val()=="" && $("#newpwdAgain").val()==""){
            $("#newpwdAgainCheck").html('');
            $("#newPwdCheck").html('');
        }
    }

    /*$("#newpwdAgain").blur();*/
    function checkPwdAgain(){
        if($("#newPwd").val()!="") {
            if ($("#newpwdAgain").val() != $("#newPwd").val())
                $("#newpwdAgainCheck").html('<a class="styleRed">两次密码不一致</a>');
            else if ($("#newpwdAgain").val() == $("#newPwd").val())
                $("#newpwdAgainCheck").html('<a>验证通过<a>');
            else
                $("#newpwdAgainCheck").html('<a class="styleRed">请再次输入</a>');
        }else if($("#newPwd").val()=="" && $("#newpwdAgain").val()==""){
            $("#newpwdAgainCheck").html('');
            $("#newPwdCheck").html('');
        }
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
<style>
    .styleRed{
        color:red!important;
    }
</style>