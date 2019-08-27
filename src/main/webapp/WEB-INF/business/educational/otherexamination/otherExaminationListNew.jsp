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
                                <select id="deptName" class="js-example-basic-single"></select>
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
    var dataS;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'deptName');
        });
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var otherAchievementsId = data.id;
            var semesterId = data.semesterId;
            var curriculum = data.curriculum;
            var classId = data.classId;
            var majorShow = data.majorShow;
            var departmentid = data.departmentId;
            var semester = data.semester;
            var trainingLevel = data.trainingLevel;
            var majorDirection = data.majorDirection;
            if (this.id == "updateList") {
                $.get("<%=request.getContextPath()%>/otherExamination/getScoreExamListByOtherExam?termId=" + semesterId + "&course=" + curriculum + "&classId=" + classId + "&scoreExamId=" + otherAchievementsId, function (msg) {
                    if (msg.status == 2) {
                        swal({
                            title: "成绩已提交，不可修改！",
                            type: "error"
                        });
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/updateOtherAchievementsNew?id=" + otherAchievementsId);
                        $("#dialog").modal("show");
                    }
                })
            }
            if (this.id == "deleteList") {
                $.get("<%=request.getContextPath()%>/otherExamination/getScoreExamListByOtherExam?termId=" + semesterId + "&course=" + curriculum + "&classId=" + classId + "&scoreExamId=" + otherAchievementsId, function (msg) {
                    if (msg.status == 2) {
                        swal({
                            title: "成绩已提交，不可删除！",
                            type: "error"
                        });
                    } else {
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/otherExamination/deleteOtherAchievementsNew?id=" + otherAchievementsId, function (msg) {
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                $('#scoreExamGrid').DataTable().ajax.reload();
                            })
                        });
                    }
                })
            }
            if (this.id == "list") {
                $("#right").load("<%=request.getContextPath()%>/otherExamination/importOtherExam?id=" + otherAchievementsId + "&trainingLevel=" + trainingLevel +
                    "&majorDirection=" + majorDirection + "&term=" + semesterId + "&curriculum=" + curriculum +
                    "&classId=" + classId + "&departmentId=" + departmentid + "&majorCode=" + majorShow + "&semester=" + semester);
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
        if ("" == scoreExamName || null == scoreExamName) {
            scoreExamName = "";
        } else {
            scoreExamName = "%" + scoreExamName + "%";
        }
        var term = $("#selTerm").val();
        var deptName = $("#deptName").val();

        var className = $("#className").val();
        if ("" == className || null == className) {
            className = "";
        } else {
            className = "%" + className + "%";
        }
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
                {"width": "8%", "data": "majorCode", "title": "专业"},
                {"width": "8%", "data": "className", "title": "班级"},
                {"width": "12%", "data": "curriculum", "title": "课程"},
                {"width": "12%", "data": "assessmentType", "title": "考核类型"},
                {
                    "width": "8%", "title": "操作",
                    "render": function () {
                        return "<a id='updateList' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteList' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='list' class='icon-align-justify' title='录入成绩'></a>";
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
        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/addOtherAchievementsNew");
        $("#dialog").modal("show");
    }

</script>

