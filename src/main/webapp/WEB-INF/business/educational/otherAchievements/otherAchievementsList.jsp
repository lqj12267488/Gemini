<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/11/20
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width:100px">
                                学期:
                            </div>
                            <div class="col-md-2">
                                <select id="selTerm" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <input id="deptName" type="text"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width:100px">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="className" type="text"/>
                            </div>


                            <div class="col-md-1 tar" style="width:100px">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="selName" type="text"/>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreExamGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="type" hidden value="${type}">
</div>
<script>
    var scoreExamTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var otherAchievementsId = data.id;
            var semesterId=data.semesterId;
            var courseId=data.courseId;
            var classId=data.classId;
            if (this.id == "list"){

                /*通过 考试id 考场名 学期 获得考场详情信息*/

                $("#right").load("<%=request.getContextPath()%>/otherAchievements/toOtherAchievementsDetails?otherAchievementsId=" + otherAchievementsId+
                    "&semesterId="+semesterId+"&courseId="+courseId+"&classId="+classId);
                $("#right").modal("show");
            }

        });
    })

    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        $("#deptName").val("");
        $("#className").val("");
        search();
    }

    function search() {
        var scoreExamName = $("#selName").val();
        scoreExamName = "%" + scoreExamName + "%";
        var term = $("#selTerm").val();

        var deptName = $("#deptName").val();
        deptName = "%" + deptName + "%";

        var className = $("#className").val();
        className = "%" + className + "%";





        scoreExamTable = $("#scoreExamGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherAchievements/getOtherAchievementsList',
                "data": {
                    semester: term,
                    department: deptName,
                    className: className,
                    curriculum: scoreExamName,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "semesterId", "visible": false},
                {"data": "classId", "visible": false},
                {"width": "12%", "data": "semester", "title": "学期"},
                {"width": "8%", "data": "department", "title": "系部"},
                {"width": "8%", "data": "className", "title": "班级"},
                {"width": "12%", "data": "curriculum", "title": "课程"},
                {"width": "12%", "data": "assessmentType", "title": "考核类型"},
                {
                    "width": "8%", "title": "操作",
                    "render": function () {
                        return "<a id='list' class='icon-align-justify' title='录入成绩'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/otherAchievements/addOtherAchievements");
        $("#dialog").modal("show");
    }

</script>

