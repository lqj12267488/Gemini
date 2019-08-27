<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="block">
        <div class="block block-drop-shadow">
            <div class="content block-fill-white">
                <header class="mui-bar mui-bar-nav">
                    <h3 class="mui-title">${arrayClassName} ： ${className}班级手动排课 </h3>
                    <input id="arrayclassId" value="${arrayclassId}" hidden>
                    <input id="classId" value="${classId}" hidden>
                    <input id="arrayClassName" value="${arrayClassName}" hidden>
                </header>
            </div>
        </div>
        <div class="block block-drop-shadow content">
            <div class="form-row">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="back()">返回
                </button>
                <div style="text-align: right">
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="delSchedule()">移除
                    </button>
                    <div>注：请先点击“移除”按钮，再点击需要移除的课程</div>
                </div>
            </div>
            <div class="form-row">
                <table width="100%" border="1" cellspacing="0">
                    <tr style="height: 50px;width:100% " >
                        <td width="4%"></td>
                        <c:forEach items="${weekShow}" var="weekObj">
                            <td width="11%"><div>${weekObj.text}</div></td>
                        </c:forEach>
                        <td width="1%" rowspan="${colspanlength+1}"></td>
                        <td width="18%" ><div>待排课程</div></td>
                    </tr>
                    <% boolean b = true ; %>
                    <c:forEach items="${arrayClassTimeList}" var="arrayClassTime">
                        <tr style="height: 100px">
                            <td>${arrayClassTime.hoursName}</td>
                            <c:forEach items="${weekShow}" var="weekObj">
                                <td class="objbackground" id="td_${arrayClassTime.hoursCode}_${weekObj.id}" onclick="arrayClassWeekHours('${arrayClassTime.hoursCode}','${weekObj.id}')">
                                    <div style="height: 100%;width: 100%" class="container" id="arrayClass_${arrayClassTime.hoursCode}_${weekObj.id}"></div>
                                </td>
                            </c:forEach>
                            <% if(b ){%>
                            <td rowspan="${colspanlength}">
                                <br/>
                                <div class="container" id="daipai"
                                     style="vertical-align:top;height:${colspanlength*100}px;overflow-y:auto;">
                                </div>
                            </td>
                            <% b = false; %>
                            <%}%>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    //排课约束条件表
    var arrayClassConditionList = ${arrayClassConditionList};
/*
    //排课教室关联表
    var arrayClassRoomList = $ {arrayClassRoomList};
*/
    //教师其他班级已排课
    var arrayResultClassOtherClass = ${arrayResultClassOtherClass};

    var actionbefore = "";

    var checkedValue =new Object();

    function delSchedule() {
        actionbefore = "del";
    }
    $(document).ready(function () {
        //排课安排
        var arrayclassArrayList = ${arrayclassArrayList};
        $.each(arrayclassArrayList, function (index, content) {
            var htm ='<div style="float:left;background-color:rgba(0, 0, 0, 0);margin: 5px 3px 5px 2px;"  id="array_'+content.courseId+'_'+content.weekType+'" ' +
                            ' onclick=\"checkCourse(\''+content.courseId+'\',\''+content.courseShow+'\',\''+
                                    content.teacherPersonId+'\',\''+content.teacherPersonName+'\',\''+ content.teacherDeptId+'\',\''+
                                    content.startWeek+'\',\''+ content.endWeek+'\',\''+
                                    content.weekType+'\',\''+ content.roomShow+'\',\''+ content.roomId+'\',\''+ content.courseType+'\')\">' +
                '<table border=\"1\" cellspacing=\"0\" >'+
                    '<tr><td>'+content.courseShow+'('+content.teacherPersonName+')</td></tr>' +
                    '<tr><td>'+ content.roomShow+'</td></tr>' +
                    '<tr><td>课时数:'+ content.weekHours+'学时/周</td></tr>' +
                    '<tr><td>未排课时数:<a id="arrayWeekHours_'+content.courseId+'_'+content.weekType+'" >'+content.weekHours+'</a>学时/周' +
                            '<input id="arrayWeekHours_'+content.courseId+'_'+content.weekType+'_value" value="'+content.weekHours+'" hidden/></td></tr>' +
                    '<tr><td>'+  '第'+content.startWeek+'周到第'+content.endWeek+'周</td></tr>' +
                '</table></div>';
            $("#daipai").append(htm);
        });

        //本班级已排课
        var arrayclassResultClassList = ${arrayclassResultClassList};
        $.each(arrayclassResultClassList, function (index, content) {
            var arrayClassName = "arrayClass_"+ content.hoursCode+ "_"+ content.week ;
            //单双周
            var weekshow = "";
            var htm ='<div width="90%">'+content.courseShow+'<br>' +
                content.teacherPersonName+'<br>' +
                content.roomShow+'<br>' +
                '第'+content.startWeek+'周到第'+content.endWeek+'周'+weekshow+'<br>' +
                '<input hidden id="td_'+content.hoursCode+'_'+content.week+'_id" value="'+content.id+'"/>' +
                '<input hidden id="td_'+content.hoursCode+'_'+content.week+'_courseId" value="'+content.courseId+'"/>' +
                '<input hidden id="td_'+content.hoursCode+'_'+content.week+'_courseShow" value="'+content.courseShow+'"/>' +
                '<input hidden id="td_'+content.hoursCode+'_'+content.week+'_courseType" value="'+content.courseType+'"/>' +
                '<input hidden id="td_'+content.hoursCode+'_'+content.week+'_weekType" value="'+content.weekType+'"/>' +
                '</div>';
            var arrayWeekHours_value =$("#arrayWeekHours_"+content.courseId+"_"+content.weekType+"_value").val();
            var hoursNew = Number(arrayWeekHours_value) - 1 ;
            $("#arrayWeekHours_"+content.courseId+"_"+content.weekType+"_value").val(hoursNew);
            $("#arrayWeekHours_"+content.courseId+"_"+content.weekType).html(hoursNew);
            if(hoursNew == 0 || hoursNew =="0"){
                $("#array_"+content.courseId+"_"+content.weekType).css('display','none');
                actionbefore  = "";
            }
            $("#"+arrayClassName).append(htm);
        });

        $.each(arrayClassConditionList, function (index, arrayClassCondition) {
            if( arrayClassCondition.elementsType == "1" && arrayClassCondition.conditionType == "1" ) {
                $("#td_"+arrayClassCondition.limitHoursCode+"_"+arrayClassCondition.limitWeek).removeAttr('onclick');
                $("#td_"+arrayClassCondition.limitHoursCode+"_"+arrayClassCondition.limitWeek).css("background","#2b4250");
                $("#td_"+arrayClassCondition.limitHoursCode+"_"+arrayClassCondition.limitWeek).html("<h1><span class='icon-ban-circle' style='color: red'/></h1><br><h6>此时间禁止排课</h6>");
            }
        });
    })

    //待选课程选中
    function checkCourse(courseId,courseShow,teacherPersonId,teacherPersonName,teacherDeptId , startWeek, endWeek,weekType ,roomShow,roomId,courseType) {
        $("#array_"+courseId+"_"+weekType).css("background-color","rgba(0, 0, 0, 0.2)");
        var weekHours = $("#arrayWeekHours_"+courseId+"_"+weekType+"_value").val();
        if(weekHours == 0 || weekHours =="0") {
            swal({
                title: courseShow + "课程已排满",
                type: "info"
            });
            $("#array_"+courseId+"_"+weekType).css('display','none');
            $("#array_"+courseId+"_"+courseId).css("background-color","rgba(0, 0, 0, 0)");
            actionbefore  = "";
            return;
        }
        checkedValue =new Object();
        checkedValue.courseId=courseId;
        checkedValue.courseShow=courseShow;
        checkedValue.teacherPersonId =teacherPersonId;
        checkedValue.teacherPersonName =teacherPersonName;
        checkedValue.teacherDeptId =teacherDeptId;
        checkedValue.startWeek =startWeek;
        checkedValue.endWeek =endWeek;
        checkedValue.weekType =weekType;
        checkedValue.roomShow =roomShow;
        checkedValue.roomId =roomId;
        checkedValue.weekHours = weekHours;
        checkedValue.courseType = courseType;
        actionbefore  = "checkClass";
    }

    //根据 星期，节次排课
    function arrayClassWeekHours(hoursCode,weekId) {
        if(actionbefore == ""){
            return;
        }
        if(actionbefore == "del"){
            var tdId = $("#td_"+hoursCode+"_"+weekId+"_id").val();
            if(tdId !="" || true){
/*                if(confirm("请确认移除此课?")){
                    // 获取删除课程 信息
                    var delId = $("#td_"+hoursCode+"_"+weekId+"_id").val();
                    var delcourseId = $("#td_"+hoursCode+"_"+weekId+"_courseId").val();
                    var del_weekType = $("#td_"+hoursCode+"_"+weekId+"_weekType").val();

                    //删除此条排课记录 记录
                     $.get("/arrayClassResultClass/delClassResultByid?id="+delId,function (msg) {
                         var arrayWeekHours_value =$("#arrayWeekHours_"+delcourseId+"_"+del_weekType+"_value").val();
                         var hoursNew = Number(arrayWeekHours_value) + 1 ;
                         $("#arrayWeekHours_"+delcourseId+"_"+del_weekType+"_value").val(hoursNew);
                         $("#arrayWeekHours_"+delcourseId+"_"+del_weekType).html(hoursNew);

                         if(arrayWeekHours_value == 0 || arrayWeekHours_value =="0") {
                             $("#array_" + delcourseId + "_" + del_weekType).css('display', '');
                         }
                         $("#arrayClass_"+hoursCode+"_"+weekId).html("");
                         actionbefore  = "";
                     });
                }*/
                var delId = $("#td_"+hoursCode+"_"+weekId+"_id").val();
                var delcourseId = $("#td_"+hoursCode+"_"+weekId+"_courseId").val();
                var del_weekType = $("#td_"+hoursCode+"_"+weekId+"_weekType").val();
                var planName = $("#td_"+hoursCode+"_"+weekId+"_courseShow").val();
                swal({
                    title: "请确认移除此课?",
                    text: "课程名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClassResultClass/delClassResultByid", {
                        id: delId
                    }, function (msg) {
                        if (msg.status == 1) {
                            var arrayWeekHours_value = $("#arrayWeekHours_" + delcourseId + "_" + del_weekType + "_value").val();
                            var hoursNew = Number(arrayWeekHours_value) + 1;
                            $("#arrayWeekHours_" + delcourseId + "_" + del_weekType + "_value").val(hoursNew);
                            $("#arrayWeekHours_" + delcourseId + "_" + del_weekType).html(hoursNew);

                            if (arrayWeekHours_value == 0 || arrayWeekHours_value == "0") {
                                $("#array_" + delcourseId + "_" + del_weekType).css('display', '');
                            }
                            $("#arrayClass_" + hoursCode + "_" + weekId).html("");
                            actionbefore = "";
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                        }
                    });
                })

            }
            actionbefore == "del";
            return;
        }

        if(checkedValue.weekHours == 0 || checkedValue.weekHours =="0"){
            swal({title: checkedValue.courseShow+"课程已排满",type: "info"});
            $("#array_"+checkedValue.courseId+"_"+checkedValue.weekType).css('display','none');
            $("#array_"+checkedValue.courseId+"_"+checkedValue.weekType).css("background-color","rgba(0, 0, 0, 0)");
            actionbefore  = "";
            return;
        }else if(actionbefore == "checkClass"){
            var b = "";
            //判断 排课约束条件表
            $.each(arrayClassConditionList, function (index, arrayClassCondition) {
                if(arrayClassCondition.conditionType == "1" &&
                    arrayClassCondition.limitWeek== weekId && arrayClassCondition.limitHoursCode== hoursCode){
                    // elementsType = 2  教师 禁排
                    if( arrayClassCondition.elementsId == checkedValue.teacherPersonId && arrayClassCondition.elementsType == "2" ){
                        b =" "+checkedValue.teacherPersonName+" 科目，禁止排此时间";
                        return;
                    }
                    // elementsType = 2  教师 禁排
                    if(  arrayClassCondition.elementsId == checkedValue.courseId && arrayClassCondition.elementsType == "3" ){
                        b =" "+checkedValue.courseShow+" 教师禁止排此时间";
                        return;
                    }
                }
             });

            //教师其他班级已排课
            $.each(arrayResultClassOtherClass, function (index, OtherClass) {
                if(checkedValue.teacherPersonId ==OtherClass.teacherPersonId
                    && OtherClass.hoursCode == hoursCode && OtherClass.week== weekId ){
                    b = "此时间与"+OtherClass.className+"班排课冲突";
                    return;
                }
             });
            if(b!= ""){
                swal({
                    title: b,
                    type: "info"
                });
                return;
            }

            //如果此时间 已有课程
            var delId ="";
            if(document.getElementById("td_"+hoursCode+"_"+weekId+"_id")!=  undefined && $("#td_"+hoursCode+"_"+weekId+"_id").val() != null
                && $("#td_"+hoursCode+"_"+weekId+"_id").val() != "" ){//undefined
                if($("#td_"+hoursCode+"_"+weekId+"_courseId").val() == checkedValue.courseId){
                    return;
                }
                delId = $("#td_"+hoursCode+"_"+weekId+"_id").val();
                var delcourseId = $("#td_"+hoursCode+"_"+weekId+"_courseId").val();
                var del_weekType = $("#td_"+hoursCode+"_"+weekId+"_weekType").val();

                var arrayWeekHours_value =$("#arrayWeekHours_"+delcourseId+"_"+del_weekType+"_value").val();
                var hoursNew = Number(arrayWeekHours_value) + 1 ;
                $("#arrayWeekHours_"+delcourseId+"_"+del_weekType+"_value").val(hoursNew);
                $("#arrayWeekHours_"+delcourseId+"_"+del_weekType).html(hoursNew);

                if(arrayWeekHours_value == 0 || arrayWeekHours_value =="0") {
                    $("#array_" + delcourseId + "_" + del_weekType).css('display', '');
                }
                $("#arrayClass_"+hoursCode+"_"+weekId).html("");
            }

            //  新增课程插入数据库
            $.post("<%=request.getContextPath()%>/arrayClassResultClass/saveClassResult",
                {
                    id : delId,
                    arrayclassId : $("#arrayclassId").val(),
                    classId : $("#classId").val(),
                    courseType : checkedValue.courseType,
                    courseId : checkedValue.courseId,
                    roomId : checkedValue.roomId,
                    teacherPersonId : checkedValue.teacherPersonId,
                    teacherDeptId : checkedValue.teacherDeptId,
                    weekType : checkedValue.weekType,
                    startWeek : checkedValue.startWeek,
                    endWeek : checkedValue.endWeek,
                    hours : checkedValue.hours,
                    week : weekId,
                    hoursCode : hoursCode,
                },
                function (msg) {
                var id = msg.msg;
                $("#arrayClass_"+hoursCode+"_"+weekId).html(
                    '<div width="100%">'+checkedValue.courseShow+'<br>' +
                    checkedValue.teacherPersonName+'<br>' +
                    checkedValue.roomShow+'<br>' +
                    '第'+checkedValue.startWeek+'周到第'+checkedValue.endWeek+'周'+'<br>' +
                    '<input hidden id="td_'+hoursCode+'_'+weekId+'_id" value="'+id+'"/>' +
                    '<input hidden id="td_'+hoursCode+'_'+weekId+'_courseId" value="'+checkedValue.courseId+'"/>' +
                    '<input hidden id="td_'+hoursCode+'_'+weekId+'_courseShow" value="'+checkedValue.courseShow+'"/>' +
                    '<input hidden id="td_'+hoursCode+'_'+weekId+'_courseType" value="'+checkedValue.courseType+'"/>' +
                    '<input hidden id="td_'+hoursCode+'_'+weekId+'_weekType" value="'+checkedValue.weekType+'"/>' +
                    '</div>');
                var weekHours = Number(checkedValue.weekHours) - 1;
                checkedValue.weekHours = weekHours;
                $("#arrayWeekHours_"+checkedValue.courseId+"_"+checkedValue.weekType+"_value").val(weekHours);
                $("#arrayWeekHours_"+checkedValue.courseId+"_"+checkedValue.weekType ).html(weekHours);
                if(weekHours == 0 || weekHours =="0"){
                    $("#array_"+checkedValue.courseId+"_"+checkedValue.weekType).css('display','none');
                    $("#array_"+checkedValue.courseId+"_"+checkedValue.weekType).css("background-color","rgba(0, 0, 0, 0)");
                    actionbefore  = "";
                }
            });
        }
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/classList?arrayClassId=${arrayclassId}&arrayClassName=${arrayClassName}");
    }

</script>
<style>
    td{
        font-size: 10px;
        text-align: center;
    }
    .div{
        text-align: center;
    }
    .objbackground{
        background-color:rgba(0, 0, 0, 0);
    }
    .objbackground:hover{
        background-color: rgba(0, 0, 0, 0.2);
    }
</style>