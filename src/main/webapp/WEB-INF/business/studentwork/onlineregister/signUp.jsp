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
        .uploadKj {
            background-color: transparent;
            border: none;
            border-bottom: 1px solid #9e9e9e;
            border-radius: 0;
            outline: none;
            height: 3rem;
            width: 100%;
            font-size: 1rem;
            margin: 0 0 20px 0;
            padding: 0;
            box-shadow: none;
            box-sizing: content-box;
            transition: all 0.3s;
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
            <form class="col s12" id="signUp">
                <input type="hidden" name="registerType" value="${type}">
                <input type="file" name="file_img" style="display: none" id="imgFile" onchange="fileChange(this)">
                <table>
                    <tr>
                        <td>
                            <div class="input-field col s12">
                                <input id="s_name" name="name" type="text" class="validate"/>
                                <label for="s_name"><span style="color: red">*</span>姓名</label>
                            </div>
                        </td>
                        <td rowspan="2"><img onclick="showInputFile()" src="<%=request.getContextPath()%>/libs/img/upload.png" height="150" width="110" alt="" id="userImg"></td>
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
                    <select name="nation" id="s_nation">
                        <option value="" disabled selected><span style="color: red">*</span>民族</option>
                        <option value="01">汉族</option>
                        <option value="02">蒙古族</option>
                        <option value="03">回族</option>
                        <option value="04">藏族</option>
                        <option value="05">维吾尔族</option>
                        <option value="06">苗族</option>
                        <option value="07">彝族</option>
                        <option value="08">壮族</option>
                        <option value="09">布依族</option>
                        <option value="10">朝鲜族</option>
                        <option value="11">满族</option>
                        <option value="12">侗族</option>
                        <option value="13">瑶族</option>
                        <option value="14">白族</option>
                        <option value="15">土家族</option>
                        <option value="16">哈尼族</option>
                        <option value="17">哈萨克族</option>
                        <option value="18">傣族</option>
                        <option value="19">黎族</option>
                        <option value="20">僳僳族</option>
                        <option value="21">佤族</option>
                        <option value="22">畲族</option>
                        <option value="23">高山族</option>
                        <option value="24">拉祜族</option>
                        <option value="25">水族</option>
                        <option value="26">东乡族</option>
                        <option value="27">纳西族</option>
                        <option value="28">景颇族</option>
                        <option value="29">柯尔克孜族</option>
                        <option value="30">土族</option>
                        <option value="31">达斡尔族</option>
                        <option value="32">仫佬族</option>
                        <option value="33">羌族</option>
                        <option value="34">布朗族</option>
                        <option value="35">撒拉族</option>
                        <option value="36">毛南族</option>
                        <option value="37">仡佬族</option>
                        <option value="38">锡伯族</option>
                        <option value="39">阿昌族</option>
                        <option value="40">普米族</option>
                        <option value="41">塔吉克族</option>
                        <option value="42">怒族</option>
                        <option value="43">乌孜别克族</option>
                        <option value="44">俄罗斯族</option>
                        <option value="45">鄂温克族</option>
                        <option value="46">崩龙族</option>
                        <option value="47">保安族</option>
                        <option value="48">裕固族</option>
                        <option value="49">京族</option>
                        <option value="50">塔塔尔族</option>
                        <option value="51">独龙族</option>
                        <option value="52">鄂伦春族</option>
                        <option value="53">赫哲族</option>
                        <option value="54">门巴族</option>
                        <option value="55">珞巴族</option>
                        <option value="56">基诺族</option>
                        <option value="57">其他</option>
                        <option value="58">外国血统</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select name="sex" id="s_sex">
                        <option value="" disabled selected><span style="color: red">*</span>性别</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <input name="birthday" id="s_birthday" type="date" class="datepicker">
                    <label for="s_birthday"><span style="color: red">*</span>出生日期</label>
                </div>
                <div class="input-field col s6">
                    <select name="language" id="s_language">
                        <option value="" disabled selected><span style="color: red">*</span>语言</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="fatherTel" type="text" id="s_fatherTel" class="validate"/>
                    <label for="s_fatherTel"><span style="color: red">*</span>父亲电话</label>
                </div>
                <div class="input-field col s6">
                    <input name="motherTel" type="text" id="s_motherTel" class="validate"/>
                    <label for="s_motherTel"><span style="color: red">*</span>母亲电话</label>
                </div>

                <div class="input-field col s6">
                    <select id="s_examType" name="examType">
                        <option value="" disabled selected><span style="color: red">*</span>考生类别</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select id="s_province" name="province">
                        <option value="" disabled selected><span style="color: red">*</span>省</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <select id="s_city" name="city">
                        <option value="" disabled selected><span style="color: red">*</span>市</option>
                    </select>
                </div>
                <div class="input-field col s6">
                    <select id="s_county" name="county">
                        <option value="" disabled selected><span style="color: red">*</span>县</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="graduatedSchool" type="text" id="s_graduatedSchool" class="validate"/>
                    <label for="s_graduatedSchool"><span style="color: red">*</span>毕业学校</label>
                </div>
                <div class="input-field col s6">
                    <input name="graduationDate" id="s_graduationDate" type="date" class="datepicker"/>
                    <label for="s_graduationDate"><span style="color: red">*</span>毕业时间</label>
                </div>

                <div class="input-field col s6">
                    <input name="examinationCardNumber" type="text" id="s_examinationCardNumber" class="validate"/>
                    <label for="s_examinationCardNumber"><span style="color: red">*</span>准考证号</label>
                </div>
                <div class="input-field col s6">
                    <select name="registerOrigin" id="s_registerOrigin">
                        <option value="" disabled selected><span style="color: red">*</span>报名起点</option>
                    </select>
                </div>

                <div class="input-field col s6">
                    <input name="examScore" type="text" id="s_examScore" class="validate"/>
                    <label for="s_examScore"><span style="color: red">*</span>考试成绩</label>
                </div>
                <div class="input-field col s6">
                    <input name="remark" type="text" id="s_remark" class="validate"/>
                    <label for="s_remark">备注</label>
                </div>
                <div class="file-field input-field col s12">
                    <div class="btn">
                        <span>身份证附件</span>
                        <input type="file" name="file_idcardImg" id="s_idcardImg"/>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"/>
                    </div>
                </div>
                <div class="file-field input-field col s12">
                    <div class="btn">
                        <span>准考证附件</span>
                        <input type="file" name="file_examinationImg" id="s_examinationImg"/>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"/>
                    </div>
                </div>
                <div class="file-field input-field col s12">
                    <div class="btn">
                        <span>成绩单附件</span>
                        <input type="file" name="file_scoreImg" id="s_scoreImg"/>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"/>
                    </div>
                </div>
                <div class="file-field input-field col s12">
                    <div class="btn">
                        <span>户口本附件</span>
                        <input type="file" name="file_hukouImg" id="s_hukouImg" multiple/>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"/>
                    </div>
                </div>
                <div class="file-field input-field col s12">
                    <div class="btn">
                        <span>毕业证附件</span>
                        <input type="file" name="file_graduatedImg" id="s_graduatedImg" multiple/>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"/>
                    </div>
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
<%--<span style="font-size: 10px">注：1.考生本人对填写内容的真实性负责，凡弄虚作假者一票否决。<br>注：2比赛级别指市级及以上，同等类型只需填写最高奖项。</span>--%>
</body>
<script>
    var baseUrl = "<%=request.getContextPath()%>";
    $("#layout").load(baseUrl + "/common/commonSaveLoading");
    $(document).ready(function () {


        var show_num = [];
        draw(show_num);

        $("#canvas").on('click', function () {
            draw(show_num);
        })


        $.get(baseUrl + "/common/getSysDict?name=XB", function (data) {
            $.each(data, function (index, content) {
                $("#s_sex").append("<option value='" + content.id + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        $.get(baseUrl + "/common/getSysDict?name=YY", function (data) {
            $.each(data, function (index, content) {
                $("#s_language").append("<option value='" + content.id + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        /*$.get(baseUrl + "/common/getSysDict?name=MZ", function (data) {
            $.each(data, function (index, content) {
                $("#s_nation").append("<option value='" + content.id + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });*/
        $.get(baseUrl + "/common/getSysDict?name=XSLB", function (data) {
            $.each(data, function (index, content) {
                $("#s_examType").append("<option value='" + content.id + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        //省
        getAdministrativeDivisions("s_province", $("#s_province").val(), " and type = '1' ", baseUrl);
        $("#s_province").change(function () {
            $("#s_county").empty();
            $("#s_county").append("<option value='' disabled selected><span style='color: red'>*</span>县</option>");
            if ($(this).val() != "") {
                $("#s_city").empty();
                $("#s_city").append("<option value='' disabled selected><span style='color: red'>*</span>市</option>");
                getAdministrativeDivisions("s_city", "", " and type = '2' and parent_id ='" + $(this).val() + "'", baseUrl);
            }else {
                $("#s_city").empty();
                $("#s_city").append("<option value='' disabled selected><span style='color: red'>*</span>市</option>");
            }
        });
        $("#s_city").change(function () {
            if ($(this).val() != "") {
                $("#s_county").empty();
                $("#s_county").append("<option value='' disabled selected><span style='color: red'>*</span>县</option>");
                getAdministrativeDivisions("s_county", "", " and type = '3' and parent_id ='" + $(this).val() + "'", baseUrl);
            }else {
                $("#s_county").empty();
                $("#s_county").append("<option value='' disabled selected><span style='color: red'>*</span>县</option>");
            }
        });
        //报名起点
        $.get(baseUrl + "/common/getSysDict?name=BMQD", function (data) {
            $.each(data, function (index, content) {
                $("#s_registerOrigin").append("<option value='" + content.id + "'>" + content.text + "</option>");
            });
            $('select').material_select();
        });
        //materialize 下拉选组件初始化
        $('select').material_select();
        //materialize 时间选择组件初始化
        $('.datepicker').pickadate({
            selectMonths: true, // 是否允许选择月份
            selectYears: 99, // 选择的年份范围
            format: 'yyyy-mm-dd'
        });
    });

    function saveArchives() {
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
        }else {
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            if (reg.test($("#s_idcard").val()) === false) {
                alert("身份证输入不合法");
                $("#s_idcard").val("");
                return;
            }else {
                $.post("<%=request.getContextPath()%>/onlineregister/getRegisterByIDCard", {
                    idcard: $("#s_idcard").val(),
                }, function (msg) {
                    if (msg !== 'notfound'){
                        alert("此身份证已报名！");
                        return;
                    }else {
                        if ($("#s_nation").val() == "" || $("#s_nation").val() == undefined) {
                            alert("请填写民族！");
                            return;
                        }
                        if ($("#s_sex").val() == "" || $("#s_sex").val() == undefined) {
                            alert("请填写性别！");
                            return;
                        }
                        if ($("#s_birthday").val() == "" || $("#s_birthday").val() == undefined) {
                            alert("请填写出生日期！");
                            return;
                        }
                        if ($("#s_language").val() == "" || $("#s_language").val() == undefined) {
                            alert("请填写语言！");
                            return;
                        }
                        if ($("#s_fatherTel").val() == "" || $("#s_fatherTel").val() == undefined) {
                            alert("请填写父亲电话！");
                            return;
                        }
                        if ($("#s_motherTel").val() == "" || $("#s_motherTel").val() == undefined) {
                            alert("请填写母亲电话！");
                            return;
                        }

                        if ($("#s_examType").val() == "" || $("#s_examType").val() == undefined) {
                            alert("请填写考生类别！");
                            return;
                        }
                        if ($("#s_province").val() == "" || $("#s_province").val() == undefined) {
                            alert("请填写省！");
                            return;
                        }
                        if ($("#s_city").val() == "" || $("#s_city").val() == undefined) {
                            alert("请填写市！");
                            return;
                        }
                        if ($("#s_county").val() == "" || $("#s_county").val() == undefined) {
                            alert("请填写县！");
                            return;
                        }
                        if ($("#s_graduatedSchool").val() == "" || $("#s_graduatedSchool").val() == undefined) {
                            alert("请填写毕业学校！");
                            return;
                        }
                        if ($("#s_graduationDate").val() == "" || $("#s_graduationDate").val() == undefined) {
                            alert("请填写毕业时间！");
                            return;
                        }
                        if ($("#s_examinationCardNumber").val() == "" || $("#s_examinationCardNumber").val() == undefined) {
                            alert("请填写准考证号！");
                            return;
                        }
                        if ($("#s_registerOrigin").val() == "" || $("#s_registerOrigin").val() == undefined) {
                            alert("请填写报名起点！");
                            return;
                        }
                        if ($("#s_examScore").val() == "" || $("#s_examScore").val() == undefined) {
                            alert("请填写考试成绩！");
                            return;
                        }
                        if ($("#s_idcardImg").val() == "" || $("#s_idcardImg").val() == undefined) {
                            alert("请上传身份证附件！");
                            return;
                        }
                        if ($("#s_examinationImg").val() == "" || $("#s_examinationImg").val() == undefined) {
                            alert("请上传准考证附件！");
                            return;
                        }
                        if ($("#s_scoreImg").val() == "" || $("#s_scoreImg").val() == undefined) {
                            alert("请上传成绩单附件！");
                            return;
                        }
                        if ($("#s_hukouImg").val() == "" || $("#s_hukouImg").val() == undefined) {
                            alert("请上传户口本附件！");
                            return;
                        }if ($("#s_graduatedImg").val() == "" || $("#s_graduatedImg").val() == undefined) {
                            alert("请上传毕业证附件！");
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

                        var formData = new FormData(document.getElementById("signUp"));
                        $("#progress").removeAttr("style");
                        $("#btnDiv").html("<a class=\"waves-effect waves-light btn disabled\" onclick=\"saveArchives()\"\n" +
                            "       style=\"width: 200px\">正在提交</a>");
                        $.ajax({
                            url: "<%=request.getContextPath()%>/onlineregister/saveOnlineRegister",
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
                });
            }
        }
    }

    function getAdministrativeDivisions(id, value, where, path) {
        $.get(path + "/common/getTableDict", {
                id: " id",
                text: " name ",
                tableName: " t_sys_administrative_divisions ",
                where: " WHERE valid_flag = '1' " + where,
                orderBy: " order by show_order ",
            },
            function (data) {
                $.each(data, function (index, content) {
                    $("#" + id).append("<option value='" + content.id + "'>" + content.text + "</option>");
                });
                $('select').material_select();
            }
        );
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