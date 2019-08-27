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
                            <h5 class="mui-title">${scoreExamName}</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width: 70px">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="selDept"></select>
                            </div>
                            <div class="col-md-1 tar" style="width: 70px">
                                科目：
                            </div>
                            <div class="col-md-2">
                                <input id="selCourse" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <%--<a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>--%>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" hidden value="${scoreExamId}">
    <input id="scoreExamName" hidden value="${scoreExamName}">
</div>
<script>
    var listTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'selDept');
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var classId = data.classId;
            var courseId = data.courseId;
            if (this.id == "list") {
                $("#right").load("<%=request.getContextPath()%>/scoreExam/openTeaScoreList2?scoreExamName=${scoreExamName}&"
                    + "scoreExamId=" + $("#scoreExamId").val() + "&courseId=" + courseId + "&classId=" + classId
                );
                $("#right").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selDept").val("");
        $("#selCourse").val("");
        search();
    }

    function search() {
        var scoreExamId = $("#scoreExamId").val();
        var departmentsId = $("#selDept").val();
        var courseId = $("#selCourse").val();
        listTable = $("#listTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreExam/getTeaOpenScoreList',
                "data": {
                    scoreExamId: scoreExamId,
                    departmentsId: departmentsId,
                    courseId: courseId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%", "data": "departmentsId", "title": "系部"},
                {"width": "10%", "data": "className", "title": "班级"},
                {"width": "10%", "data": "courseName", "title": "科目"},
                {"width": "10%", "data": "teachingTeacherId", "title": "授课教师"},
                {"width": "10%", "data": "examMethod", "title": "考试方式"},
                {
                    "width": "15%", "title": "操作",
                    "render": function () {
                        return "<a id='list' class='icon-search' title='查看详情'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreExam/openTeaScoreExamList");
        $("#right").modal("show");
    }

    //导出
    function expdata() {
        var href = "<%=request.getContextPath()%>/scoreExam/exportOpenScore?scoreExamId=${scoreExamId}&scoreExamName=${scoreExamName}" +
            "&deptId=" + $("#selDept").val() + "&courseId=" + $("#selCourse").val();
        $("#expdata").attr("href", href);
    }
</script>

