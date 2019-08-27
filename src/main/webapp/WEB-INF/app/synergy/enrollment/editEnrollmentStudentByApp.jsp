<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/14
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet" />

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">新生登记</h1>
    </header>
    <div class="" style="padding-top: 10%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;" >
            &nbsp;&nbsp;&nbsp;&nbsp;学生姓名
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="name" type="text" style="line-height:40px;height:40px;text-align:center;"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;身份证号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="idcard" onblur="checkEnrollmentIdCard()"  type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;手机号码
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="tel" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   />
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;系部
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
            <div id="deptSel"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;专业
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
            <div id="majorSel"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;性别
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
            <div id="sexSel"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;">
            &nbsp;&nbsp;&nbsp;&nbsp;民族
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
            <div id="nationSel"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;">
            &nbsp;&nbsp;&nbsp;&nbsp;政治面貌
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
            <div id="politicalStatusSel"></div>
        </div>
        <div style="text-align: center">
            <center>
                <button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                        onclick="save()">保存</button>
            </center>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        //系部初始化
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                $("#deptSel").append("<select id='deptSelName' class='mui-btn mui-btn-block'></select>");
                $("#deptSelName").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
                $.each(data, function (index, content) {
                    $("#deptSelName").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            })
        //系部联动专业
        $("#deptSel").change(function(){
            $('#majorSel').html("");
            var deptSelName= $("#deptSelName").val();
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(deptSelName!="") {
                major_sql+= " and departments_id ='"+deptSelName+"' ";
            }
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " order by departments_id,major_code desc,trainingLevel desc,major_direction desc "

                },
                function (data) {
                    $("#majorSel").append("<select id='majorSelName' class='mui-btn mui-btn-block'></select>");
                    $("#majorSelName").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
                    $.each(data, function (index, content) {
                        $("#majorSelName").append("<option value='" + content.id + "'>" + content.text + "</option>");
                    })

                })

        });

        //性别
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            $("#sexSel").append("<select id='sexSelName' class='mui-btn mui-btn-block'></select>");
            $("#sexSelName").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#sexSelName").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        });
        //民族
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            $("#nationSel").append("<select id='nationSelName' class='mui-btn mui-btn-block'></select>");
            $("#nationSelName").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#nationSelName").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        });

        //政治面貌
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            $("#politicalStatusSel").append("<select id='politicalStatusSelName' class='mui-btn mui-btn-block'></select>");
            $("#politicalStatusSelName").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#politicalStatusSelName").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        });

        })


    function checkEnrollmentIdCard(){
        var idcard= $("#idcard").val();
            $.post("<%=request.getContextPath()%>/enrollment/checkEnrollmentIdCard?idcard="+idcard, function (data) {
                if(data.status ==1){
                    alert("身份证号已存在!")
                }
            });


    }


    function save(){
        var name = $("#name").val();
        var idcard = $("#idcard").val();
        var tel = $("#tel").val();
        var deptSelName = $("#deptSelName").val();
        var majorSelName = $("#majorSelName").val();
        var sexSelName = $("#sexSelName").val();
        var nationSelName = $("#nationSelName").val();
        var politicalStatusSelName = $("#politicalStatusSelName").val();
        if(name =="" || name == null){
            alert("请填写学生姓名");
            return;
        }

        if(idcard =="" || idcard == null){
            alert("请填写身份证号");
            return;
        }

        if(tel =="" || tel == null){
            alert("请填写手机号码");
            return;
        } else{
            var phoneNum = /^1\d{10}$/;
            if (phoneNum.test(tel) === false ) {
                alert("手机号码格式不正确!");
                return;
            }
        }

        if(deptSelName =="" || deptSelName == null){
            alert("请选择系部");
            return;
        }

        if(majorSelName =="" || majorSelName == null){
            alert("请选择专业");
            return;
        }

        if(sexSelName =="" || sexSelName == null){
            alert("请选择性别");
            return;
        }

        if(nationSelName =="" || nationSelName == null){
            alert("请选择民族");
            return;
        }

        if(politicalStatusSelName =="" || politicalStatusSelName == null){
            alert("请选择政治面貌");
            return;
        }
        var majorCode=majorSelName.split(",")[0];
        var majorDirection=majorSelName.split(",")[1];
        var trainingLevel=majorSelName.split(",")[2];
        $.post("<%=request.getContextPath()%>/enrollment/savaEnrollmentStudent",  {
            name: name,
            sex: sexSelName,
            idcard: idcard,
            nation: nationSelName,
            departmentsId: deptSelName,
            majorCode: majorCode,
            majorDirection: majorDirection,
            trainingLevel: trainingLevel,
            politicalStatus: politicalStatusSelName,
            tel: tel
        }, function (msg) {
            if (msg.status == 1) {
                alert(msg.msg);
                window.location.href = "<%=request.getContextPath()%>/enrollmentApp/index"
            }
        })
    }
</script>

