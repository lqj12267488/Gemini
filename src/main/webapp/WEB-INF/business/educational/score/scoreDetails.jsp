<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/11/27
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/17
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${data.scoreExamName}</h5>
                        </header>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <%--<a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>--%>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listTable2" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" hidden value="${data.scoreExamId}">
    <input id="scoreExamName" hidden value="${data.scoreExamName}">
</div>
<script>
    var listTable2;
    $(document).ready(function () {
        search();
    })

    function searchclear() {
        $("#selDept").val("");
        $("#selMajor").val("");
        $("#selCourse").val("");
        search();
    }

    function search() {
        var scoreExamId = $("#scoreExamId").val();
        listTable2 = $("#listTable2").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreExam/getTeaOpenScoreList2',
                "data": {
                    scoreExamId: scoreExamId,
                    classId: '${data.classId}',
                    courseId: '${data.courseId}',
                }
            },
            "destroy": true,
            "columns": [
                {"width": "10%", "data": "studentNum", "title": "学号"},
                {"width": "10%", "data": "studentId", "title": "学生姓名"},
                {"width": "10%", "data": "peacetimeScoreA", "title": "A(10)"},
                {"width": "10%", "data": "peacetimeScoreB", "title": "B(10)"},
                {"width": "10%", "data": "peacetimeScoreC", "title": "C(10)"},
                {"width": "10%", "data": "peacetimeScoreD", "title": "D(10)"},
                {"width": "10%", "data": "scoreSum", "title": "平时合计"},
                {"width": "10%", "data": "score", "title": "成绩"},
                {"width": "10%", "data": "generalComment", "title": "总评"}
            ],
            "dom": 'rtlip',
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreImport/scoreCourseList?scoreExamName=${data.scoreExamName}" +
            "&scoreExamId=${data.scoreExamId}&classId=${data.classId}");
    }
</script>

