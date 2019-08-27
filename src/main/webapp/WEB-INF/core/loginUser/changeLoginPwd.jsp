<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/5/4
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">账号密码修改</span>
            <input id="personId" hidden value="${loguser.personId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请输入原密码
                    </div>
                    <div class="col-md-5">
                        <input id="oldPwd" type="password"/>
                    </div>
                    <div class="col-md-4" id="oldPwdCheck"></div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        登录账户修改
                    </div>
                    <div class="col-md-5">
                        <input id="username" type="text"/>
                    </div>
                    <div class="col-md-4" id="usernameCheck"></div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请输入新密码
                    </div>
                    <div class="col-md-5">
                        <input id="newPwd" type="password"/>
                    </div>
                    <div class="col-md-4" id="newPwdCheck"></div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        密码确认
                    </div>
                    <div class="col-md-5">
                        <input id="newpwdAgain" type="password"/>
                    </div>
                    <div class="col-md-4" id="newpwdAgainCheck"></div>
                </div>
            </div>
        </div>
        <div class="modal-body clearfix" id="que_ans" style="display: none">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar" id="viewque">
                        请填写账号保护问题
                    </div>
                    <div class="col-md-5">
                        <input id="question" type="text" value="${loguser.question}"/>
                    </div>
                    <div class="col-md-4" id="questionCheck"></div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar" id="viewans">
                        请填写答案
                    </div>
                    <div class="col-md-5">
                        <input id="answer" type="text" value="${answer}"/>
                    </div>
                    <div class="col-md-4" id="answerCheck" style="display: none">
                        <button type="button" class="btn btn-success btn-clean" onclick="saveQueAns()">保存密码问题</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="viewQueAns()">设置密码问题</button>
            <button type="button" class="btn btn-success btn-clean" onclick="saveLoginPwd()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        $("#oldPwd").val("");
        $("#username").val("");
        $("#newPwd").val("");
        $("#newpwdAgain").val("");
        $("#usernameCheck").html('<a >如不修改可以不填</a>');

        if (null != $("#answer").val() && $("#answer").val() != "") {//answer
            $("#answer").attr("readonly", "readonly");
            $("#question").attr("readonly", "readonly");
            $("#viewque").html("账号保护问题");
            $("#viewans").html("账号保护答案");
        } else {
            $("#answerCheck").css('display', 'block');
            $("#answer").blur(function () {
                if ($("#answer").val().length < 6)
                    $("#questionCheck").html('<a class="styleRed">您输入的答案不得小于六个字</a>');
                else
                    $("#questionCheck").html('');
            });
            $("#question").blur(function () {
                if ($("#question").val().length < 6)
                    $("#questionCheck").html('<a class="styleRed">您输入的问题不得小于六个字</a>');
                else
                    $("#questionCheck").html('');
            });
        }
    });

    $("#username").blur(function () {
        if ($("#username").val() != "") {
            $.post("<%=request.getContextPath()%>/checkUserAccount?useraccount=" + $("#username").val(), function (data) {
                if (data == "false") {
                    $("#usernameCheck").html('<a class="styleRed">您填写的账号已存在</a>');
                } else {
                    $("#usernameCheck").html('<a >您填写的账号可使用</a>');
                }
            });
        } else {
            $("#usernameCheck").html('');
        }
    });

    $("#newPwd").blur(function () {
        var patrn = /^([a-zA-Z0-9]|[._]){5,19}$/;
        if ($("#newPwd").val() != "") {
            if (!patrn.exec($("#newPwd").val())) {
                $("#newPwdCheck").html('<a class="styleRed">密码只允许输入英文字母和数字,长度不小于5个字符</a>');
            } else {
                if ($("#newpwdAgain").val() != $("#newPwd").val()) {
                    $("#newPwdCheck").html('');
                    $("#newpwdAgainCheck").html('<a class="styleRed">两次密码不一致</a>');
                } else {
                    $("#newPwdCheck").html('');
                    $("#newpwdAgainCheck").html('');
                }
            }
        } else if ($("#newPwd").val() == "" && $("#newpwdAgain").val() == "") {
            $("#newpwdAgainCheck").html('');
            $("#newPwdCheck").html('');
        }
    });

    $('#newpwdAgain').on('input propertychange', function () {
        if ($("#newPwd").val() != "") {
            if ($("#newpwdAgain").val() != $("#newPwd").val())
                $("#newpwdAgainCheck").html('<a class="styleRed">两次密码不一致</a>');
            else if ($("#newpwdAgain").val() == $("#newPwd").val())
                $("#newpwdAgainCheck").html('<a>验证通过<a>');
            else
                $("#newpwdAgainCheck").html('<a class="styleRed">请再次输入</a>');
        } else if ($("#newPwd").val() == "" && $("#newpwdAgain").val() == "") {
            $("#newpwdAgainCheck").html('');
            $("#newPwdCheck").html('');
        }
    });


    $("#oldPwd").blur(function () {
        if ($("#oldPwd").val() != "") {
            $.post("<%=request.getContextPath()%>/checkUserPwd?pwd=" + $("#oldPwd").val(), function (data) {
                if (data == "false") {
                    $("#oldPwdCheck").html('<a class="styleRed">密码错误</a>');
                } else {
                    $("#oldPwdCheck").html('<a ></a>');
                }
            });
        }
    });

    function saveLoginPwd() {
        if ($("#newpwdAgain").val() == "" && $("#username").val() == "") {
            swal({
                title: "您没有填写需要修改的信息"
            });
            return;
        }
        if ($("a").hasClass("styleRed")) {
            swal({
                title: "您填写的信息有误"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/saveLoginPwd", {
            personId: $("#personId").val(),
            userAccount: $("#username").val(),
            password: $("#newPwd").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
            }
        })
    }

    /*$("#answer").blur(function(){
        if($("#answer").val()!=""){
            $.post("/checkQAnswer?answer="+$("#answer").val(), function (data) {
                if(data == "false"){
                    $("#answerCheck").html('<a class="styleRed">您填写的答案不正确</a>');
                }else{
                    $("#answerCheck").html('<a>验证通过</a>');
                }
            });
        }
    });*/

    function viewQueAns() {
        $("#que_ans").css('display', 'block');
    }

    function saveQueAns() {
        if ($("#oldPwd").val() == "") {
            swal({
                title: "请您填写原密码"
            });

            return;
        }
        if ($("#oldPwd").hasClass("styleRed")) {
            swal({
                title: "您填写的密码有误"
            });

            return;
        }

        if ($("#answer").val() == "") {
            swal({
                title: "请您填写答案"
            });

            return;
        }
        if ($("#question").val() == "") {
            swal({
                title: "请您填写账号保护问题"
            });

            return;
        }

        if ($("#newpwdAgainCheck").hasClass("styleRed")) {
            swal({
                title: "您填写的密码问题或答案不符合要求"
            });

            return;
        }

        $.post("<%=request.getContextPath()%>/saveQueAns", {
            personId: $("#personId").val(),
            answer: $("#answer").val(),
            question: $("#question").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
            }
        })


    }
</script>
<style>
    .styleRed {
        color: red !important;
    }
</style>