<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.goisan.system.bean.CommonBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html class="ui-page-login">

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title></title>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.min.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/style.css" rel="stylesheet"/>
    <style>

        .area {
            margin: 20px auto 0px auto;
        }

        .mui-input-group {
            margin-top: 10px;
        }

        .mui-input-group:first-child {
            margin-top: 20px;
        }

        .mui-input-group label {
            width: 22%;
        }

        .mui-input-row label ~ input,
        .mui-input-row label ~ select,
        .mui-input-row label ~ textarea {
            width: 78%;
        }

        .mui-checkbox input[type=checkbox],
        .mui-radio input[type=radio] {
            top: 6px;
        }

        .mui-content-padded {
            margin-top: 25px;
        }

        .mui-btn {
            padding: 10px;
        }

        .link-area {
            display: block;
            margin-top: 25px;
            text-align: center;
        }

        .spliter {
            color: #bbb;
            padding: 0px 8px;
        }

        .oauth-area {
            position: absolute;
            bottom: 20px;
            left: 0px;
            text-align: center;
            width: 100%;
            padding: 0px;
            margin: 0px;
        }

        .oauth-area .oauth-btn {
            display: inline-block;
            width: 50px;
            height: 50px;
            background-size: 30px 30px;
            background-position: center center;
            background-repeat: no-repeat;
            margin: 0px 20px;
            /*-webkit-filter: grayscale(100%); */
            border: solid 1px #ddd;
            border-radius: 25px;
        }

        .oauth-area .oauth-btn:active {
            border: solid 1px #aaa;
        }

        .oauth-area .oauth-btn.disabled {
            background-color: #ddd;
        }
    </style>

</head>

<body>
<header class="mui-bar mui-bar-nav">
    <h2 class="mui-title" style="font-size: 15px!important;">欢迎访问 <%=CommonBean.getParamValue("SZXXMC")%></h2>
</header>
<div>
    <img style="width:100%;margin-top:30px;" src="<%=request.getContextPath()%>/libs/img/app/bg.jpg"></img>
</div>
<div>
    <form id='login-form' class="mui-input-group">
        <div class="mui-input-row">
            <label>账号</label>
            <input id='username' type="text" class="mui-input-clear mui-input" placeholder="请输入账号,身份证号中字母请大写">
        </div>
        <div class="mui-input-row">
            <label>密码</label>
            <input id='password' type="password" class="mui-input-clear mui-input" placeholder="请输入密码">
        </div>
        <div class="mui-toast-container">
            <div class="mui-toast-message" id="msg">

            </div>
        </div>
    </form>
    <!-- 			<form class="mui-input-group"> -->
    <!-- 				<ul class="mui-table-view mui-table-view-chevron"> -->
    <!-- 					<li class="mui-table-view-cell"> -->
    <!-- 						自动登录 -->
    <!-- 						<div id="autoLogin" class="mui-switch"> -->
    <!-- 							<div class="mui-switch-handle"></div> -->
    <!-- 						</div> -->
    <!-- 					</li> -->
    <!-- 				</ul> -->
    <!-- 			</form> -->
    <div>
        <div class="col-md-12">
            <span>&nbsp;&nbsp;</span><span id="msgalert" style="color: red;font-size: 18px" hidden></span>
        </div>
    </div>
    <div class="mui-content-padded">
        <button id='login' class="mui-btn mui-btn-block mui-btn-primary" onclick="login()"
                style="background-color: #0062cc !important;">登录
        </button>
        <!-- 				<div class="link-area"><a id='reg'>注册账号</a> <span class="spliter">|</span> <a id='forgetPassword'>忘记密码</a> -->
        <!-- 				</div> -->
    </div>
    <div class="mui-content-padded oauth-area">

    </div>
</div>

<script src="<%=request.getContextPath()%>/libs/js/app/mui.enterfocus.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/app.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/base64.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.indexedlist.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
<link href="<%=request.getContextPath()%>/libs/css/app/mui.indexedlist.css" rel="stylesheet" />
<script>
    (function ($, doc) {
        $.init({
            statusBarBackground: '#f7f7f7'
        });
        $.plusReady(function () {
            plus.screen.lockOrientation("portrait-primary");
            var settings = app.getSettings();
            var state = app.getState();
            var mainPage = $.preload({
                "id": 'main',
                "url": '<%=request.getContextPath()%>'+'main.html'
            });
            var toMain = function () {
                //使用定时器的原因：
                //可能执行太快，main页面loaded事件尚未触发就执行自定义事件，此时必然会失败
                var id = setInterval(function () {
                    if (main_loaded_flag) {
                        clearInterval(id);
                        $.fire(mainPage, 'show', null);
                        mainPage.show("pop-in");
                    }
                }, 20);
            };
            //检查 "登录状态/锁屏状态" 开始
            if (settings.autoLogin && state.token && settings.gestures) {
                $.openWindow({
                    url: '<%=request.getContextPath()%>'+'unlock.html',
                    id: 'unlock',
                    show: {
                        aniShow: 'pop-in'
                    },
                    waiting: {
                        autoShow: false
                    }
                });
            } else if (settings.autoLogin && state.token) {
                toMain();
            } else {
                app.setState(null);
                //第三方登录
                var authBtns = ['qihoo', 'weixin', 'sinaweibo', 'qq']; //配置业务支持的第三方登录
                var auths = {};
                var oauthArea = doc.querySelector('.oauth-area');
                plus.oauth.getServices(function (services) {
                    for (var i in services) {
                        var service = services[i];
                        auths[service.id] = service;
                        if (~authBtns.indexOf(service.id)) {
                            var isInstalled = app.isInstalled(service.id);
                            var btn = document.createElement('div');
                            //如果微信未安装，则为不启用状态
                            btn.setAttribute('class', 'oauth-btn' + (!isInstalled && service.id === 'weixin' ? (' disabled') : ''));
                            btn.authId = service.id;
                            btn.style.backgroundImage = 'url("<%=request.getContextPath()%>images/' + service.id + '.png")'
                            oauthArea.appendChild(btn);
                        }
                    }
                    $(oauthArea).on('tap', '.oauth-btn', function () {
                        if (this.classList.contains('disabled')) {
                            plus.nativeUI.toast('您尚未安装微信客户端');
                            return;
                        }
                        var auth = auths[this.authId];
                        var waiting = plus.nativeUI.showWaiting();
                        auth.login(function () {
                            waiting.close();
                            plus.nativeUI.toast("登录认证成功");
                            auth.getUserInfo(function () {
                                plus.nativeUI.toast("获取用户信息成功");
                                var name = auth.userInfo.nickname || auth.userInfo.name;
                                app.createState(name, function () {
                                    toMain();
                                });
                            }, function (e) {
                                plus.nativeUI.toast("获取用户信息失败：" + e.message);
                            });
                        }, function (e) {
                            waiting.close();
                            plus.nativeUI.toast("登录认证失败：" + e.message);
                        });
                    });
                }, function (e) {
                    oauthArea.style.display = 'none';
                    plus.nativeUI.toast("获取登录认证失败：" + e.message);
                });
            }
            // close splash
            setTimeout(function () {
                //关闭 splash
                plus.navigator.closeSplashscreen();
            }, 600);
            //检查 "登录状态/锁屏状态" 结束
            var loginButton = doc.getElementById('login');
            var accountBox = doc.getElementById('account');
            var passwordBox = doc.getElementById('password');
            var autoLoginButton = doc.getElementById("autoLogin");
            var regButton = doc.getElementById('reg');
            var forgetButton = doc.getElementById('forgetPassword');
            loginButton.addEventListener('tap', function (event) {
                var loginInfo = {
                    account: accountBox.value,
                    password: passwordBox.value
                };
                app.login(loginInfo, function (err) {
                    if (err) {
                        plus.nativeUI.toast(err);
                        return;
                    }
                    toMain();
                });
            });
            $.enterfocus('#login-form input', function () {
                $.trigger(loginButton, 'tap');
            });
            autoLoginButton.classList[settings.autoLogin ? 'add' : 'remove']('mui-active')
            autoLoginButton.addEventListener('toggle', function (event) {
                setTimeout(function () {
                    var isActive = event.detail.isActive;
                    settings.autoLogin = isActive;
                    app.setSettings(settings);
                }, 50);
            }, false);
            regButton.addEventListener('tap', function (event) {
                $.openWindow({
                    url: '<%=request.getContextPath()%>'+'reg.html',
                    id: 'reg',
                    preload: true,
                    show: {
                        aniShow: 'pop-in'
                    },
                    styles: {
                        popGesture: 'hide'
                    },
                    waiting: {
                        autoShow: false
                    }
                });
            }, false);
            forgetButton.addEventListener('tap', function (event) {
                $.openWindow({
                    url: '<%=request.getContextPath()%>'+'forget_password.html',
                    id: 'forget_password',
                    preload: true,
                    show: {
                        aniShow: 'pop-in'
                    },
                    styles: {
                        popGesture: 'hide'
                    },
                    waiting: {
                        autoShow: false
                    }
                });
            }, false);
            //
            window.addEventListener('resize', function () {
                oauthArea.style.display = document.body.clientHeight > 400 ? 'block' : 'none';
            }, false);
            //
            var backButtonPress = 0;
            $.back = function (event) {
                backButtonPress++;
                if (backButtonPress > 1) {
                    plus.runtime.quit();
                } else {
                    plus.nativeUI.toast('再按一次退出应用');
                }
                setTimeout(function () {
                    backButtonPress = 0;
                }, 1000);
                return false;
            };
        });
    }(mui, document));

    //自动关闭提示框
    function Alert(str) {
        var msgw,msgh,bordercolor;
        msgw=350;//提示窗口的宽度
        msgh=80;//提示窗口的高度
        titleheight=25 //提示窗口标题高度
        bordercolor="#336699";//提示窗口的边框颜色
        titlecolor="#99CCFF";//提示窗口的标题颜色
        var sWidth,sHeight;
        //获取当前窗口尺寸
        sWidth = document.body.offsetWidth;
        sHeight = document.body.offsetHeight;
//    //背景div
        var bgObj=document.createElement("div");
        bgObj.setAttribute('id','alertbgDiv');
        bgObj.style.position="absolute";
        bgObj.style.top="0";
        bgObj.style.background="#E8E8E8";
        bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
        bgObj.style.opacity="0.6";
        bgObj.style.left="0";
        bgObj.style.width = sWidth + "px";
        bgObj.style.height = sHeight + "px";
        bgObj.style.zIndex = "10000";
        document.body.appendChild(bgObj);
        //创建提示窗口的div
        var msgObj = document.createElement("div")
        msgObj.setAttribute("id","alertmsgDiv");
        msgObj.setAttribute("align","center");
        msgObj.style.background="white";
        msgObj.style.border="1px solid " + bordercolor;
        msgObj.style.position = "absolute";
        msgObj.style.left = "50%";
        msgObj.style.font="12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
        //窗口距离左侧和顶端的距离
        msgObj.style.marginLeft = "-225px";
        //窗口被卷去的高+（屏幕可用工作区高/2）-150
        msgObj.style.top = document.body.scrollTop+(window.screen.availHeight/2)-150 +"px";
        msgObj.style.width = msgw + "px";
        msgObj.style.height = msgh + "px";
        msgObj.style.textAlign = "center";
        msgObj.style.lineHeight ="25px";
        msgObj.style.zIndex = "10001";
        document.body.appendChild(msgObj);
        //提示信息标题
        var title=document.createElement("h4");
        title.setAttribute("id","alertmsgTitle");
        title.setAttribute("align","left");
        title.style.margin="0";
        title.style.padding="3px";
        title.style.background = bordercolor;
        title.style.filter="progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
        title.style.opacity="0.75";
        title.style.border="1px solid " + bordercolor;
        title.style.height="18px";
        title.style.font="12px Verdana, Geneva, Arial, Helvetica, sans-serif";
        title.style.color="white";
        title.innerHTML="提示信息";
        document.getElementById("alertmsgDiv").appendChild(title);
        //提示信息
        var txt = document.createElement("p");
        txt.setAttribute("id","msgTxt");
        txt.style.margin="16px 0";
        txt.innerHTML = str;
        document.getElementById("alertmsgDiv").appendChild(txt);
        //设置关闭时间
        window.setTimeout("closewin()",3000);
    }
    function closewin() {
        document.body.removeChild(document.getElementById("alertbgDiv"));
        document.getElementById("alertmsgDiv").removeChild(document.getElementById("alertmsgTitle"));
        document.body.removeChild(document.getElementById("alertmsgDiv"));
    }

    //登录

    function login() {
        var errorMsg = "";
        var loginName = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        if (loginName == "" || loginName == null || loginName == "null") {
            errorMsg += "用户名不能为空!";
        }
        if (password == "" || password == null || password == "null") {
            errorMsg += "密码不能为空!";
        }
        if (errorMsg != "") {
/*
            alert(errorMsg);
*/
            $("#msgalert").text("   "+errorMsg).show();
            return;
        }
        else {
            $("#msgalert").text("   "+"正在登录中，请稍后...").show();

//					var encodepassword=(base64encode(base64encode(password)));
            $.post("<%=request.getContextPath()%>/loginApp/login",
                {"loginId": loginName, "password": password},
                function (result) {
                    if (result.status == 1) {
                        $("#msgalert").text("   "+"账号或密码输入有误，请重新输入").show();
//                        mui.alert();

                        return false;
                    }
                    if (result.status == 0) {
                        //mui.toast(result.message);
                        window.location = "<%=request.getContextPath()%>/loginApp/index";  // "/index";
                    } else {
                        mui.toast(result.message);
                    }
                }, "json");
        }
    }
</script>
</body>

</html>