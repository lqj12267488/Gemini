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
    <link rel="stylesheet" type="text/css" href="../../../libs/css/app/app.css" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet" />

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">评教评分</h1>
    </header>
    <div class="mui-content">
        <div  id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <!-- 主界面具体展示内容 -->
        <div class="mui-content-padded mainBodyClass">
            <h3 class="mui-ellipsis">
                <div id="headerShow"></div>
            </h3>
            <form id="formID" class="mui-input-group" >
                <c:forEach items="${iList}" var="iListFri"><!-- 循环第一层-->
                <c:choose>
                    <c:when test="${iListFri.leafFlag == 0 }">
                        <div class="mui-input-row" style="background:#048ADB;height:60px;vertical-align:middle;">
                            <div class="headerdiv">${iListFri.indexName}</div>
                        </div>
                        <c:forEach items="${iListFri.indexList}" var="indexListSe">
                            <c:choose>
                                <c:when test="${indexListSe.leafFlag == 0 }">
                                    <div  class="mui-input-row" style="background:#13A4FB;height:60px;vertical-align:middle;" >
                                            <div class="headerdiv">&nbsp;&nbsp;&nbsp;&nbsp;${indexListSe.indexName}</div>
                                    </div>
                                    <c:forEach items="${indexListSe.indexList}" var="indexListTre">
                                            <div class="mui-input-row"  style="background:#69C5FC;height:60px;vertical-align:middle;">
                                                <div  class="headerdiv">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${indexListTre.indexName}(满分${indexListTre.score})</div>
                                            </div>
                                        <div class="mui-input-row">
                                            <input type="hidden" name="indexName" value="${indexListTre.indexName}"/>
                                            <input type="hidden" name="macScore" value="${indexListTre.score}"/>
                                            <input type="hidden" name="indexId" value="${indexListTre.indexId}"/>
                                            <label style="text-align:right">
                                                <span class="iconBtx">*</span>评分:
                                            </label>
                                            <input type="number" name="score" />
                                        </div>
                                        <div class="mui-input-row">
                                            <label style="text-align:right">
                                                评语:
                                            </label>
                                            <input type="text" name="remark"/>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${indexListSe.leafFlag == 1 }">
                                    <div class="mui-input-row" style="background:#13A4FB;height:60px;vertical-align:middle;">
                                        <div  class="headerdiv">&nbsp;&nbsp;&nbsp;&nbsp;${indexListSe.indexName}(满分${indexListSe.score})</div>
                                    </div>
                                    <div class="mui-input-row">
                                        <input type="hidden" name="indexName" value="${indexListSe.indexName}"/>
                                        <input type="hidden" name="macScore" value="${indexListSe.score}"/>
                                        <input type="hidden" name="indexId" value="${indexListSe.indexId}"/>
                                        <label style="text-align:right">
                                            <span class="iconBtx">*</span>评分:
                                        </label>
                                        <input type="number" name="score" />
                                    </div>
                                    <div class="mui-input-row">
                                        <label style="text-align:right" >
                                            评语:
                                        </label>
                                        <input type="text" name="remark"/>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:when test="${iListFri.leafFlag == 1 }">
                        <div  class="mui-input-group"  style="background: #048ADB;height:60px;vertical-align:middle;">
                            <div class="headerdiv">${iListFri.indexName}(满分${iListFri.score})</div>
                        </div>
                        <div class="mui-input-row">
                            <input type="hidden" name="indexName" value="${iListFri.indexName}"/>
                            <input type="hidden" name="macScore" value="${iListFri.score}"/>
                            <input type="hidden" name="indexId" value="${iListFri.indexId}"/>
                            <label style="text-align:right">
                                <span class="iconBtx">*</span>评分:
                            </label>
                            <input type="number" name="score" />
                        </div>
                        <div class="mui-input-row">
                            <label style="text-align:right" >
                                评语:
                            </label>
                            <input type="text" name="remark" />
                        </div>
                    </c:when>
                </c:choose>
                </c:forEach>
            </form>
            <button id="saveBtn" class="mui-btn mui-btn-block mui-btn-primary btn-register" onclick="save();">
                提交
            </button>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");

    var strJson = '${strJson}';

    var empPersonId= "";
    var empDeptId= "";
    var empName= "";
    var taskName= "";
    var taskId= "";
    var eType =  "";

    window.onscroll=function(){
        var box= document.getElementById("layout");
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        box.style.top=80+ t+"px";
    }

    $(document).ready(function (){
        var sJson =  eval('(' + strJson + ')') ;
        empPersonId= sJson.empPersonId;
        empDeptId= sJson.empDeptId;
        empName= sJson.empName;
        taskName= sJson.taskName;
        taskId= sJson.taskId;
        eType =sJson.evaluationType ;

        taskName = decodeURI(decodeURI(taskName));
        empName = decodeURI(decodeURI(empName));

        $("#headerShow").html("<tr><td width='50%'>评教任务：&nbsp;&nbsp;&nbsp;&nbsp;"+taskName+"</td></tr>" +
                                "<tr><td width='50%'>被评教人：&nbsp;&nbsp;&nbsp;&nbsp;"+empName+"</td></tr>");
    })

    function save() {
        var scoreVale=new Array();
        var indexIdVale=new Array();
        var remarkVale=new Array();
        var macScoreVale=new Array();
        var indexNameVale=new Array();

        var Scorecheck = false;

        var al="";var bl="";
        $("[name=indexId]").each(function () {
            indexIdVale.push(this.value);
        });
        $("[name=score]").each(function () {
            if(null ==this.value ||this.value ==""){
                al ="请填写评分，评分不能为空！";
                return;
            }
            scoreVale.push(this.value);
        });
        $("[name=remark]").each(function () {
/*
            if(null == this.value || this.value ==""){
                bl ="请填写评语，评语不能为空！" ;
                return;
            }
*/
            remarkVale.push(this.value);
        });
        $("[name=macScore]").each(function () {
            macScoreVale.push(this.value);
        });
        $("[name=indexName]").each(function () {
            indexNameVale.push(this.value);
        });
        if(!(al+bl)==""){
            alert(al+bl);
            return;
        }
        for(var i=0;i<scoreVale.length;i++){
            if(parseInt(scoreVale[i])>parseInt(macScoreVale[i]) ){
                alert(indexNameVale[i]+"的评分已超过最大值！");
                return;
            }
            if(parseInt(scoreVale[i]) < parseInt(macScoreVale[i]) ){
                Scorecheck = true;
            }
            if(parseInt(scoreVale[i])< 0 ){
                alert("评分不能为负数！");
                return;
            }
        }

        if( ! Scorecheck ){
            alert("不可以将所有评分项均设置为满分，请进行调整！");
            return;
        }

        var returnValue ="";
        for(var i=0;i<scoreVale.length;i++){
            if(returnValue==""){
                returnValue = indexIdVale[i]+"##"+scoreVale[i]+"##"+remarkVale[i];
            }else{
                returnValue = returnValue+"@@@@"+indexIdVale[i]+"##"+scoreVale[i]+"##"+remarkVale[i];
            }
        }

        if((al+bl)==""){
            insert(returnValue);
        }else{
            return;
        }

        scoreVale=new Array();
        indexIdVale=new Array();
        remarkVale=new Array();
        macScoreVale=new Array();
        indexNameVale=new Array();
    }

    function insert(returnValue) {
/*
        $('.mui-content-padded').css('opacity','0.2');
        $("#layout").css('display','block');
        $('#saveBtn').css('display','none');
*/

        showSaveLoading('#saveBtn');
        $.post("<%=request.getContextPath()%>/evaluation/result/insertResult",
            {
                taskId:taskId,
                empPersonId:empPersonId,
                empDeptId:empDeptId,
                empName:empName,
                returnValue:returnValue,
            },
            function (msg) {
                hideSaveLoading('#saveBtn');
                alert(msg.msg);
                window.location="<%=request.getContextPath()%>/evaluationApp/result/listEmpsMenmbers?taskId="+taskId+"&evaluationType="+eType;
            })
    }

</script>

</html>
<style>
    .headerdiv{
        font-family: 'Microsoft YaHei', 'Helvetica Neue', Helvetica, sans-serif;
        line-height: 1.1;
        float: left;
        width: 100%;
        height: 60px;
        padding: 11px 15px;
        vertical-align: middle;
        /*display:table;*/
       /* line-height: 100px;*/
    }
</style>