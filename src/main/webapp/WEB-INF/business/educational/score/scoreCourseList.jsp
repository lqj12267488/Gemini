<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 15:19
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
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreExamName} > 考试课程设置</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width:100px">
                                课程名称：
                            </div>
                            <div class="col-md-2">
                                <input id="selCourse" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                课程类型：
                            </div>
                            <div class="col-md-2">
                                <select id="selType" class="js-example-basic-single"></select>
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="planImport()">教学计划导入
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" value="${scoreExamId}" hidden/>
</div>
<script>
    var scoreExamId=$("#scoreExamId").val();
    var listTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'selType');
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var subjectId = data.subjectId;
            var courseShow = data.courseShow;
            var scoreExamId=data.scoreExamId;
            var planId=data.planId;
            var courseType=data.courseType;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreCourse/editScoreCourse?subjectId=" + subjectId);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要删除本条课程?",
                    text: "课程名称："+courseShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/scoreCourse/deleteScoreCourseById", {
                        subjectId: subjectId
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        listTable.ajax.reload();
                    });
                })
            }
            if (this.id == "editClass") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreCourse/scoreClassTree",{
                    subjectId: subjectId,
                    scoreExamId:scoreExamId,
                    planId:planId,
                    courseType:courseType
                });
                $("#dialog").modal("show");
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreCourse/editScoreCourse?scoreExamId="+scoreExamId);
        $("#dialog").modal("show");
    }
    function planImport() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreCourse/planImport?scoreExamId="+scoreExamId);
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#selCourse").val("");
        $("#selType").val("");
        search();
    }
    function search() {
        var scoreExamId = $("#scoreExamId").val();
        var courseId = $("#selCourse").val();
        courseId="%"+courseId+"%";
        var courseType = $("#selType").val();
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/scoreCourse/getScoreCourseList',
                "data":{
                    scoreExamId:scoreExamId,
                    courseType: courseType,
                    courseId: courseId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "subjectId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "courseType", "title": "课程类型"},
                {"width":"12%","data": "courseShow", "title": "课程"},
                {"width":"8%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"12%","data": "trainingLevel", "title": "培养层次"},
                {"width":"8%","data": "planId", "title": "教学计划"},
                {"width":"8%","data": "courseFlag", "title": "考试类型"},
                {"width":"12%","data": "totalScore", "title": "总分"},
                {"width":"8%","data": "passScore", "title": "及格分"},
                {"width":"8%","title": "操作","render": function () {return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='editClass' class='icon-wrench' title='考试班级设置'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreExam/list");
    }
</script>


