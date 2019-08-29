<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>新疆现代职业技术学院</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-3.3.1.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/materialize/css/materialize.min.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/materialize/js/materialize.js"></script>
    <style type="text/css">
        #canvas {
            float: right;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->

<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <h1 class="mui-title">新疆现代职业技术学院护理专业报名</h1>
        <span id="appIndex" class="mui-icon mui-icon-search mui-pull-right" onclick="searchResult()" style="color:#fff;"></span>
    </header>
    <input type="hidden" id="idCardisHave">
    <div class="mui-content">
        <div class="row">
            <form class="col s12" id="summerCamp">
                <input type="file" name="file" style="display: none" id="imgFile" onchange="fileChange(this)">
                <table>
                    <tr>
                        <td>
                            <div class="input-field col s12">
                                <input id="s_name" name="name" type="text" class="validate" value="${summerCamp.name}"/>
                                <label for="s_name"><span style="color: red">*</span>姓名</label>
                            </div>
                        </td>
                        <td rowspan="2"><img onclick="showInputFile()"
                                             src="<%=request.getContextPath()%>/libs/img/upload.png" height="150"
                                             width="110" alt="" id="userImg"></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input-field col s12">
                                <input name="idcard" id="s_idcard" type="text" class="validate"/>
                                <label for="s_idcard"><span style="color: red">*</span>身份证号</label>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="input-field col s6">
                    <select name="mz" id="s_mz">
                        <option value="" disabled selected><span style="color: red">*</span>民族</option>
                        <option value="汉族">汉族</option>
                        <option value="壮族">壮族</option>
                        <option value="满族">满族</option>
                        <option value="回族">回族</option>
                        <option value="苗族">苗族</option>
                        <option value="维吾尔族">维吾尔族</option>
                        <option value="土家族">土家族</option>
                        <option value="彝族">彝族</option>
                        <option value="土族">土族</option>
                        <option value="朝鲜族">朝鲜族</option>
                        <option value="蒙古族">蒙古族</option>
                        <option value="阿昌族">阿昌族</option>
                        <option value="鄂温克族">鄂温克族</option>
                        <option value="傈僳族">傈僳族</option>
                        <option value="水族">水族</option>
                        <option value="白族">白族</option>
                        <option value="高山族">高山族</option>
                        <option value="珞巴族">珞巴族</option>
                        <option value="塔吉克族">塔吉克族</option>
                        <option value="保安族">保安族</option>
                        <option value="仡佬族">仡佬族</option>
                        <option value="布朗族">布朗族</option>
                        <option value="塔塔尔族">塔塔尔族</option>
                        <option value="哈尼族">哈尼族</option>
                        <option value="毛南族">毛南族</option>
                        <option value="布依族">布依族</option>
                        <option value="哈萨克族">哈萨克族</option>
                        <option value="门巴族">门巴族</option>
                        <option value="佤族">佤族</option>
                        <option value="达斡尔族">达斡尔族</option>
                        <option value="赫哲族">赫哲族</option>
                        <option value="傣族">傣族</option>
                        <option value="仫佬族">仫佬族</option>
                        <option value="乌孜别克族">乌孜别克族</option>
                        <option value="德昂族">德昂族</option>
                        <option value="基诺族">基诺族</option>
                        <option value="纳西族">纳西族</option>
                        <option value="锡伯族">锡伯族</option>
                        <option value="东乡族">东乡族</option>
                        <option value="京族">京族</option>
                        <option value="怒族">怒族</option>
                        <option value="瑶族">瑶族</option>
                        <option value="侗族">侗族</option>
                        <option value="景颇族">景颇族</option>
                        <option value="普米族">普米族</option>
                        <option value="独龙族">独龙族</option>
                        <option value="柯尔克孜族">柯尔克孜族</option>
                        <option value="羌族">羌族</option>
                        <option value="裕固族">裕固族</option>
                        <option value="俄罗斯族">俄罗斯族</option>
                        <option value="拉祜族">拉祜族</option>
                        <option value="撒拉族">撒拉族</option>
                        <option value="藏族">藏族</option>
                        <option value="鄂伦春族">鄂伦春族</option>
                        <option value="黎族">黎族</option>
                        <option value="畲族">畲族</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select name="sex" id="s_sex">
                        <option value="" disabled selected><span style="color: red">*</span>性别</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <input name="birdate" id="s_birdate" type="date" class="datepicker">
                    <label for="s_birdate"><span style="color: red">*</span>出生日期</label>
                </div>
                <div class="input-field col s6">
                    <select name="sex" id="language">
                        <option value="" disabled selected><span style="color: red">*</span>语言</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="stuno" type="text" id="s_stuno" class="validate"/>
                    <label for="s_stuno">父亲电话</label>
                </div>
                <div class="input-field col s6">
                    <input name="health" type="text" id="s_health" class="validate"/>
                    <label for="s_health">母亲电话</label>
                </div>

                <div class="input-field col s6">
                    <input name="endschool" type="text" id="s_endschool" class="validate"/>
                    <label for="s_endschool"><span style="color: red">*</span>考生类别</label>
                </div>
                <div class="input-field col s6">
                    <select id="s_bmtype" name="bmtype">
                        <option value="" disabled selected><span style="color: red">*</span>省</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="endschool" type="text" id="s_endschool" class="validate"/>
                    <label for="s_endschool"><span style="color: red">*</span>市</label>
                </div>
                <div class="input-field col s6">
                    <input name="endschool" type="text" id="s_endschool" class="validate"/>
                    <label for="s_endschool"><span style="color: red">*</span>县</label>
                </div>

                <div class="input-field col s6">
                    <input name="health" type="text" id="s_health" class="validate"/>
                    <label for="s_health">毕业学校</label>
                </div>
                <div class="input-field col s6">
                    <input name="health" type="text" id="s_health" class="validate"/>
                    <label for="s_health">毕业时间</label>
                </div>

                <div class="input-field col s6">
                    <input name="stuno" type="text" id="s_stuno" class="validate"/>
                    <label for="s_stuno">准考证号</label>
                </div>
                <div class="input-field col s6">
                    <select name="sex" id="language">
                        <option value="" disabled selected><span style="color: red">*</span>报名起点</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="stuno" type="text" id="s_stuno" class="validate"/>
                    <label for="s_stuno">考试成绩</label>
                </div>
                <div class="input-field col s6">
                    <select id="s_isrelieve" name="isrelieve">
                        <option value="" disabled selected><span style="color: red">*</span>是否服从调剂</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select id="s_isstay" name="isstay">
                        <option value="" disabled selected><span style="color: red">*</span>是否住宿</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select id="s_ismeal" name="ismeal">
                        <option value="" disabled selected><span style="color: red">*</span>是否就餐</option>
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </div>
                <div class="input-field col s12">
                    <span style="font-size: 16px;font-weight: bold">家庭信息 - 父亲</span>
                    <br>
                </div>
                <div class="input-field col s6">
                    <input name="faname" id="s_faname" type="text" class="validate"/>
                    <label for="s_faname"><span style="color: red">*</span>姓名</label>
                </div>
                <div class="input-field col s6">
                    <input name="faworkunit" id="s_faworkunit" type="text" class="validate"/>
                    <label for="s_faworkunit">工作单位</label>
                </div>
                <div class="input-field col s6">
                    <input name="fapost" id="s_fapost" type="text" class="validate"/>
                    <label for="s_fapost">职务</label>
                </div>
                <div class="input-field col s6">
                    <input name="fatel" id="s_fatel" type="text" maxlength="11" class="validate"/>
                    <label for="s_fatel"><span style="color: red">*</span>联系电话</label>
                </div>

                <div class="input-field col s12">
                    <span style="font-size: 16px;font-weight: bold">家庭信息 - 母亲</span>
                    <br>
                </div>
                <div class="input-field col s6">
                    <input name="moname" id="s_moname" type="text" class="validate"/>
                    <label for="s_moname"><span style="color: red">*</span>姓名</label>
                </div>
                <div class="input-field col s6">
                    <input name="moworkunit" id="s_moworkunit" type="text" class="validate"/>
                    <label for="s_moworkunit">工作单位</label>
                </div>
                <div class="input-field col s6">
                    <input name="mopost" id="s_mopost" type="text" class="validate"/>
                    <label for="s_mopost">职务</label>
                </div>
                <div class="input-field col s6">
                    <input name="motel" id="s_motel" type="text" maxlength="11" class="validate"/>
                    <label for="s_motel"><span style="color: red">*</span>联系电话</label>
                </div>
                <div class="input-field col s12">
                    <span style="font-size: 16px;font-weight: bold">比赛情况</span>
                    <a style="float: right;margin:0 30px 0 0 " class="btn-floating" onclick="addMatch()"><i
                            class="material-icons">add</i></a>
                    <br>
                </div>
                <div id="s_match">
                    <div class="input-field col s6">
                        <input id="s_matchtime" type="date" class="datepicker s_matchtime">
                        <label for="s_matchtime">时间</label>
                    </div>
                    <div class="input-field col s6">
                        <input id="s_matchname"   maxlength="256" type="text" class="validate s_matchname"/>
                        <label for="s_matchname">小学参加的重要比赛名称</label>
                    </div>
                    <div class="input-field col s6">
                        <select id="s_matchlevel" >
                            <option value="" disabled selected>比赛级别</option>
                            <option value="省">省</option>
                            <option value="市">市</option>
                            <option value="县">县</option>
                            <option value="局">局</option>
                            <option value="校">校</option>
                            <option value="其他">其他</option>
                        </select>
                    </div>
                    <div class="input-field col s6">
                        <input id="s_matchrank" type="text" class="validate s_matchrank"/>
                        <label for="s_matchrank">取得名次</label>
                    </div>
                </div>
                <div class="input-field col s12">
                    <span style="font-size: 16px;font-weight: bold">小学市级以上获奖和个人特长</span>
                    <a style="float: right;margin:0 30px 0 0 " class="btn-floating " onclick="addAward()"><i
                            class="material-icons">add</i></a>
                    <br>
                </div>
                <div id="s_award">
                    <div class="input-field col s6">
                        <input id="s_awardtime" type="date" class="datepicker s_awardtime">
                        <label for="s_awardtime">时间</label>
                    </div>
                    <div class="input-field col s6">
                        <input id="s_awardname" maxlength="256" type="text" class="validate s_awardname"/>
                        <label for="s_awardname">受过何种奖励</label>
                    </div>
                    <div class="input-field col s12">
                        <input id="s_awardpost"  maxlength="256" type="text" class="validate s_awardpost"/>
                        <label for="s_awardpost">本人在活动中的职务/职责</label>
                    </div>
                    <%--<div class="input-field col s12">
                        <textarea name="hobby" maxlength="256" id="s_hobby" class="materialize-textarea s_hobby"></textarea>
                        <label for="s_hobby">爱好和特长，取得成绩</label>
                    </div>--%>
                </div>
                <div class="input-field col s6">
                    <input id="w_v" type="text"/>
                    <label for="w_v"><span style="color: red">*</span>验证码</label>
                </div>
                <div class="input-field col s6">
                    <canvas id="canvas" width="100" height="44"></canvas>
                </div>
                <input type="hidden" id="myhidden">
            </form>
        </div>
    </div>
</div>
</div>
<div class="progress" id="progress" style="display: none">
    <div class="indeterminate"></div>
</div>
<div class="center-align" id="btnDiv">
    <a class="waves-effect waves-light btn" onclick="saveArchives()"
       style="width: 200px">报名</a>
</div>
<br/>
<span style="font-size: 10px">注：1.考生本人对填写内容的真实性负责，凡弄虚作假者一票否决。<br>注：2比赛级别指市级及以上，同等类型只需填写最高奖项。</span>
</body>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {


        var show_num = [];
        draw(show_num);

        $("#canvas").on('click', function () {
            draw(show_num);
        })


        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JKZK", function (data) {
            $.each(data, function (index, content) {
                $("#s_health").append("<option value='" + content.text + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XLYBTYPE", function (data) {
            $.each(data, function (index, content) {
                $("#s_bmtype").append("<option value='" + content.text + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XLYBYXX", function (data) {
            $.each(data, function (index, content) {
                $("#s_endschool").append("<option value='" + content.text + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });

        //materialize 下拉选组件初始化
        $('select').material_select();
        //materialize 时间选择组件初始化
        $('.datepicker').pickadate({
            selectMonths: true, // 是否允许选择月份
            selectYears: 99 // 选择的年份范围
        });
    });

    function saveArchives() {

        console.log(matchtime);
        if ($("#s_name").val() == "" || $("#s_name").val() == "0" || $("#s_name").val() == undefined) {
            alert("请填写姓名");
            return;
        }
        if ($("#imgFile").val() == "" || $("#imgFile").val() == "0" || $("#imgFile").val() == undefined) {
            alert("请上传头像");
            return;
        }

        if ($("#s_idcard").val() == "" || $("#s_idcard").val() == undefined) {
            alert("请填写身份证号！");
            return;
        }

        if ($("#s_mz").val() == "" || $("#s_mz").val() == undefined) {
            alert("请填写民族！");
            return;
        }
        if ($("#s_sex").val() == "" || $("#s_sex").val() == undefined) {
            alert("请填写性别！");
            return;
        }
        if ($("#s_birdate").val() == "" || $("#s_birdate").val() == undefined) {
            alert("请填写出生日期！");
            return;
        }

        if ($("#s_bmtype").val() == "" || $("#s_bmtype").val() == undefined) {
            alert("请填写报名营类型！");
            return;
        }
        if ($("#s_endschool").val() == "" || $("#s_endschool").val() == undefined) {
            alert("请填写毕业学校！");
            return;
        }
        if ($("#s_isrelieve").val() == "" || $("#s_isrelieve").val() == undefined) {
            alert("请填写是否服从调剂！");
            return;
        }
        if ($("#s_isstay").val() == "" || $("#s_isstay").val() == undefined) {
            alert("请填写是否住宿！");
            return;
        }
        if ($("#s_ismeal").val() == "" || $("#s_ismeal").val() == undefined) {
            alert("请填写是否就餐！");
            return;
        }
        if ($("#s_faname").val() == "" || $("#s_faname").val() == undefined) {
            alert("请填写父亲姓名！");
            return;
        }
        if ($("#s_fatel").val() == "" || $("#s_fatel").val() == undefined) {
            alert("请填写父亲联系电话！");
            return;
        }
        if ($("#s_moname").val() == "" || $("#s_moname").val() == undefined) {
            alert("请填写母亲姓名！");
            return;
        }
        if ($("#s_motel").val() == "" || $("#s_motel").val() == undefined) {
            alert("请填写母亲联系电话！");
            return;
        }
        $.ajaxSettings.async = false;
        $.post("<%=request.getContextPath()%>/summerCamp/getSummerCampsByIDCard", {
            idcard: $("#s_idcard").val(),
        }, function (msg) {
            if (msg !== 'notfound')
            {
                $("#idCardisHave").val(12);
            }
        });
        $.ajaxSettings.async = true;
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (reg.test($("#s_idcard").val()) === false) {
            alert("身份证输入不合法");
            $("#s_idcard").val("");
            return;
        }

        if ($("#idCardisHave").val() === "12" ) {
            alert("此身份证已报名！");
            $("#idCardisHave").val(11);
            return;
        }



        if ($("#w_v").val() == "" || $("#w_v").val() == "0" || $("#w_v").val() == undefined) {
            alert("请填写验证码！");
            return;
        }

        if ($("#myhidden").val().toLowerCase() != $("#w_v").val().toLowerCase()) {
            alert("验证码错误！");
            var show_num = [];
            $("#w_v").val('');
            draw(show_num);
            return;
        }



        var matchname = "";
        var matchlevel = "";
        var matchrank = "";
        var matchtime = "";

        $(".s_matchtime").each(function (index, item) {
            matchtime += $(item).val().replace(/(^\s*)|(\s*$)/g, "") + ",";
        });

        matchtime = matchtime.substring(0, matchtime.length - 1);
        $(".s_matchname").each(function (index, item) {
            matchname += $(item).val() + ",";
        });
        matchname = matchname.substring(0, matchname.length - 1);
        $(".s_matchlevel").each(function (index, item) {
            matchlevel += $(item).val() + ",";
        });
        matchlevel = matchlevel.substring(0, matchlevel.length - 1);
        $(".s_matchrank").each(function (index, item) {
            matchrank += $(item).val() + ",";
        });
        matchrank = matchrank.substring(0, matchrank.length - 1);
        var awardtime = "";
        var awardname = "";
        var awardpost = "";

        $(".s_awardtime").each(function (index, item) {
            awardtime += $(item).val().replace(/(^\s*)|(\s*$)/g, "") + ",";
        });
        awardtime = awardtime.substring(0, awardtime.length - 1);
        $(".s_awardname").each(function (index, item) {
            awardname += $(item).val() + ",";
        });
        awardname = awardname.substring(0, awardname.length - 1);
        $(".s_awardpost").each(function (index, item) {
            awardpost += $(item).val() + ",";
        });

        awardpost = awardpost.substring(0, awardpost.length - 1);
        var formData = new FormData(document.getElementById("summerCamp"));
        formData.append("matchtime", matchtime);
        formData.append("matchname", matchname);
        formData.append("matchlevel", matchlevel);
        formData.append("matchrank", matchrank);
        formData.append("awardtime", awardtime);
        formData.append("awardname", awardname);
        formData.append("awardpost", awardpost);
        $("#progress").removeAttr("style");
        $("#btnDiv").html("<a class=\"waves-effect waves-light btn disabled\" onclick=\"saveArchives()\"\n" +
            "       style=\"width: 200px\">正在提交</a>");
        $.ajax({
            url: "<%=request.getContextPath()%>/summerCamp/saveSummerCamp",
            type: 'POST',
            cache: false,
            data: formData,
            async: true,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (msg) {
                alert(msg.msg);
                searchResult();
            }
        });
    }


    function draw(show_num) {
        var canvas_width = $('#canvas').width();
        var canvas_height = $('#canvas').height();
        var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
        var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
        canvas.width = canvas_width;
        canvas.height = canvas_height;
        var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
        var aCode = sCode.split(",");
        var aLength = aCode.length;//获取到数组的长度

        for (var i = 0; i <= 3; i++) {
            var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
            var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
            var txt = aCode[j];//得到随机的一个内容
            show_num[i] = txt.toLowerCase();

            var x = 10 + i * 20;//文字在canvas上的x坐标
            var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
            context.font = "bold 23px 微软雅黑";

            context.translate(x, y);
            context.rotate(deg);

            context.fillStyle = randomColor();
            context.fillText(txt, 0, 0);

            context.rotate(-deg);
            context.translate(-x, -y);
        }
        var shownum = show_num + "";
        shownum = shownum.replace(/,/g, "")
        $("#myhidden").val(shownum);
        for (var i = 0; i <= 5; i++) { //验证码上显示线条
            context.strokeStyle = randomColor();
            context.beginPath();
            context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.stroke();
        }
        for (var i = 0; i <= 30; i++) { //验证码上显示小点
            context.strokeStyle = randomColor();
            context.beginPath();
            var x = Math.random() * canvas_width;
            var y = Math.random() * canvas_height;
            context.moveTo(x, y);
            context.lineTo(x + 1, y + 1);
            context.stroke();
        }
    }

    function randomColor() {//得到随机的颜色值
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    }

    function showInputFile() {
        $("#imgFile").click();
    }

    //查询方法
    function searchResult() {
        window.location.href = "/summerCamp/signUpResult";
    }

    //新增比赛情况方法
    function addMatch() {
        $('#s_match').append("<div class=\"input-field col s6\">\n" +
            "                        <input id=\"s_matchtime\"  type=\"date\" class=\"datepicker s_matchtime\">\n" +
            "                        <label for=\"s_matchtime\">时间</label>\n" +
            "                    </div>\n" +
            "                    <div class=\"input-field col s6\">\n" +
            "                        <input id=\"s_matchname\"  type=\"text\" class=\"validate s_matchname\"/>\n" +
            "                        <label for=\"s_matchname\">小学参加的重要比赛名称</label>\n" +
            "                    </div>\n" +
            "                    <div class=\"input-field col s6\">\n" +
            "                        <select id=\"s_matchlevel\" >\n" +
            "                            <option value=\"\"  disabled selected>比赛级别</option>\n" +
            "                            <option value=\"省\">省</option>\n" +
            "                            <option value=\"市\">市</option>\n" +
            "                            <option value=\"县\">县</option>\n" +
            "                            <option value=\"局\">局</option>\n" +
            "                            <option value=\"校\">校</option>\n" +
            "                            <option value=\"其他\">其他</option>\n" +
            "                        </select>\n" +
            "                    </div>\n" +
            "                    <div class=\"input-field col s6\">\n" +
            "                        <input id=\"s_matchrank\"   type=\"text\" class=\"validate s_matchrank\"/>\n" +
            "                        <label for=\"s_matchrank\">取得名次</label>\n" +
            "                    </div>");
        $('.datepicker').pickadate({
            selectMonths: true,
            selectYears: 99
        });
        $('select').material_select();

    }

    //新增小学阶段市级及以上获奖情况和个人特长情况方法
    function addAward() {
        $('#s_award').append("   <div class=\"input-field col s6\">\n" +
            "                        <input id=\"s_awardtime\"  type=\"date\" class=\"datepicker s_awardtime\">\n" +
            "                        <label for=\"s_awardtime\">时间</label>\n" +
            "                    </div>\n" +
            "                    <div class=\"input-field col s6\">\n" +
            "                        <input id=\"s_awardname\"  type=\"text\" class=\"validate s_awardname\"/>\n" +
            "                        <label for=\"s_awardname\">受过何种奖励</label>\n" +
            "                    </div>\n" +
            "                    <div class=\"input-field col s12\">\n" +
            "                        <input id=\"s_awardpost\" type=\"text\" class=\"validate s_awardpost\"/>\n" +
            "                        <label for=\"s_awardpost\">本人在活动中的职务/职责</label>\n" +
            "                    </div>");
            // "                    </div>\n" +
            // "                    <div class=\"input-field col s12\">\n" +
            // "                        <textarea name=\"hobby\" id=\"s_hobby\" class=\"materialize-textarea s_hobby\"></textarea>\n" +
            // "                        <label for=\"s_hobby\">爱好和特长，取得成绩</label>\n" +
            // "                    </div>");
        $('.datepicker').pickadate({
            selectMonths: true,
            selectYears: 99
        });
    }

    function fileChange(target) {
        var file = target;
        if (file.files[0].size >= 512000) {
            alert("请上传小于500K的文件");
            return;
        }
        var img = document.getElementById("userImg");
        var reader = new FileReader();
        reader.onload = function (evt) {
            img.src = evt.target.result;
        };
        reader.readAsDataURL(file.files[0]);
    }
</script>
