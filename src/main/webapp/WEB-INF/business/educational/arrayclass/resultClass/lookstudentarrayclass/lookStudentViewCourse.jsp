<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/29
  Time: 18:47
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
                    <h5 class="mui-title">${arrayClassName} > ${studentName} > 学生课表查看</h5>
                    <input id="arrayclassId" value="${arrayclassId}" hidden>
                    <input id="studentId" value="${studentId}" hidden>
                    <input id="arrayClassName" value="$arrayClassName}" hidden>
                </header>
            </div>
        </div>
        <div class="block block-drop-shadow content">
            <div class="form-row">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="back()">返回
                </button>
            </div>
            <div class="form-row">
                <table width="100%" border="1" cellspacing="0">
                    <tr  style="height: 50px;width:100% " >
                        <td width="10%"></td>
                        <c:forEach items="${weekShow}" var="weekObj">
                            <td width="12%"><div>${weekObj.text}</div></td>
                        </c:forEach>
                    </tr>
                    <c:forEach items="${arrayClassTimeList}" var="arrayClassTime">
                        <tr style="height: 50px">
                            <td>${arrayClassTime.hoursName }</td>
                            <c:forEach items="${weekShow}" var="weekObj">
                                <td>
                                    <div class="container" id="arrayClass_${arrayClassTime.hoursCode}_${weekObj.id}"></div>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        //本班级已排课
        var arrayclassResultClassList = ${arrayclassResultClassList};
        $.each(arrayclassResultClassList, function (index, content) {
            var arrayClassName = "arrayClass_"+ content.hoursCode+ "_"+ content.week ;
            //单双周
            var weekshow = "";
            /*
             if(content.weekType != '1'  && content.weekType != 1 ){
             weekshow = '('+content.weekTypeShow+')';
             }
             */
            var htm ='<div width="100%">'+content.courseIdShow+'<br>' +
                content.teacherPersonIdShow+'<br>' +
                content.roomIdShow+'<br>' +
                '第'+content.startWeek+'周到第'+content.endWeek+'周'+weekshow+'<br>' +
                '</div>';
            $("#"+arrayClassName).html(htm);
        })

    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/toSelectStudentList?arrayClassId=${arrayclassId}&arrayClassName=${arrayClassName}");
    }


</script>
<style>
    td{
        text-align: center;
    }
    .div{
        text-align: center;
    }

</style>