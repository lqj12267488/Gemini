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
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教师姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherName"/>
                            </div>
                            <div class="col-md-1 tar">
                                级别：
                            </div>
                            <div class="col-md-2">
                                <select id="teachingLevel"/>
                            </div>
                            <div class="col-md-1 tar">
                                学科：
                            </div>
                            <div class="col-md-2">
                                <select id="subject"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;
    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLJB", function (data) {
                addOption(data, 'teachingLevel');
            });
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " COURSE_ID",
                    text: " COURSE_NAME ",
                    tableName: "T_JW_COURSE"
                },
                function (data) {
                    addOption(data, "subject",'${examTeacherCourse.courseId}');
                });
        })
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch', '${course.departmentsId}');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")

        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacher/doubleDivisionList',
            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {"data": "personId", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "data": "teacherName",
                    "title": "教师姓名",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.teacherName+'</span>';
                    }
                },
                {"data":"departmentIdShow","title":"所属系部"},
                {"data": "teachingLevelShow", "title": "级别"},
                {"data": "subjectShow", "title": "学科"},
                {"data": "issuingTime", "title": "发证时间"},
                {"data": "validityTerm", "title": "有效期"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.teacherId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.teacherId  + '")/>';
                    }
                }
            ],
            'order' : [5,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/course/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSearch');
        });
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddDoubleDivision")
        $("#dialog").modal("show")
    }

    function edit(teacherId) {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddDoubleDivision?teacherId=" + teacherId)
        $("#dialog").modal("show")
    }

    function del(teacherId) {
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
            $.post("<%=request.getContextPath()%>/teacher/delDoubleDivision", {
                teacherId: teacherId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();

            });

        });
        /* if (confirm("确定要删除这条记录？")) {
             $.get("/course/del?id=" + id, function (data) {
                 alert(data.msg);
                 $('#table').DataTable().ajax.reload();
             })
         }*/
    }

    function search() {
        var teacherName = $("#teacherName").val();
        var teachingLevel = $("#teachingLevel").val();
        var subject = $("#subject").val();
        var url = "<%=request.getContextPath()%>/teacher/doubleDivisionList?teacherName=" + teacherName + "&teachingLevel=" + teachingLevel +
            "&subject=" + subject;
        $("#table").DataTable().ajax.url(url).load();
    }

    function searchclear() {
        $("#teacherName").val("");
        $("#teachingLevel").val("");
        $("#subject").val("");
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/teacher/doubleDivisionList").load();
    }

    /**
     * 弹出教师自然状态页面
     */
    function toShowTeacherCondition(id) {
        $("#dialog").load("${pageContext.request.contextPath}/teacher/showTeacherCondition?teacherId="+id);
        $("#dialog").show();
    }

</script>