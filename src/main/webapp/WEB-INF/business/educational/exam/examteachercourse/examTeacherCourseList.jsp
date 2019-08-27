<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教师名称：
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="personSelect"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addExamTeacherCourse()">新增
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="examTeacherCourseGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var examTeacherCourseTable;
    $(document).ready(function () {
        examTeacherCourseTable = $("#examTeacherCourseGrid").DataTable({
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "15%", "data": "majorCodeShow", "title": "专业"},
                {"width": "15%", "data": "courseId", "title": "课程"},
                {"width": "15%", "data": "teacherPersonIdShow", "title": "教师名称"},
                {"width": "15%", "data": "teacherDeptIdShow", "title": "部门"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateExamTeacherCourse' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteExamTeacherCourse' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc']],
            "dom": 'rtlip',
            language: language
        });

        search();
        examTeacherCourseTable.on('click', 'tr a', function () {
            var data = examTeacherCourseTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "updateExamTeacherCourse") {
                $("#dialog").load("<%=request.getContextPath()%>/examTeacherCourse/getUpdateExamTeacherCourse?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteExamTeacherCourse") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "教师名称：" + data.teacherPersonIdShow + "----"+data.teacherDeptIdShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/examTeacherCourse/deleteExamTeacherCourse?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        search();
                    })
                })
            }
        });
    })

    function addExamTeacherCourse() {
        $("#dialog").load("<%=request.getContextPath()%>/examTeacherCourse/getAddExamTeacherCourse");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#personSelect").val("");
        search();
    }

    function search() {
        var personId = $("#personSelect").val();
        examTeacherCourseTable.ajax.url("<%=request.getContextPath()%>/examTeacherCourse/getExamTeacherCourseList?teacherPersonId=" + personId).load();

    }
</script>
