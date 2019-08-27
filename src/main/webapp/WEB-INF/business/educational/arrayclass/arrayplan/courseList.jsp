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
        <div class="col-md-12" id="roleList">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="block block-fill-white content">
                            <div class="form-row">
                                <h5>${arrayClassName} > 设置课程信息</h5>
                                <div class="col-md-1 tar">
                                    课程名称：
                                </div>
                                <div class="col-md-2">
                                    <select id="a_courseID1" />
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
                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row">
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="back()">返回
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="add()">新增
                                    </button>
                                    <br>
                                </div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="arrayClassCourseGrid" cellpadding="0" cellspacing="0"
                                           width="100%" style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var arrayClass;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "a_courseID1", '${arrayClassCourse.courseID}');
            });
        arrayClass = $("#arrayClassCourseGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassCourse/getArrayClassCourseList?arrayClassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"data": "arrayClassCourseId", "visible": false},
                {"data": "courseType", "visible": false},
                {"data": "courseID", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"width": "8%", "data": "courseTypeShow", "title": "课程类型"},
                {"width": "8%", "data": "courseShow", "title": "课程名称"},
                {"width": "7%", "data": "departmentShow", "title": "系部"},
                {"width": "7%", "data": "majorShow", "title": "专业"},
                {"width": "8%", "data": "weekShow", "title": "学周类型"},
                {"width": "8%", "data": "startWeek", "title": "开始学周"},
                {"width": "8%", "data": "endWeek", "title": "结束学周"},
                {"width": "8%", "data": "weekNumber", "title": "学周数"},
                {"width": "8%", "data": "weekHours", "title": "每周学时数"},
                {"width": "8%", "data": "totleHours", "title": "总学时数"},
                {"width": "8%", "data": "teachShow", "title": "上课类型"},
                {"width": "7%", "data": "credit", "title": "学分"},
                {
                    "width": "7%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.arrayClassCourseId+'")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.arrayClassCourseId + '")/>&ensp;&ensp;' +
                            '<span class="icon-info-sign" title="设置排课约束条件" onclick=courseWeekManage("' + row.arrayClassCourseId + '")/>';

                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc']],
            "dom": 'rtlip',
            language: language
        });
    })


    function courseWeekManage(arrayClassCourseId) {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCondition/request?arrayClassId=${arrayClassId}&elementsId=" + arrayClassCourseId+"&elementsType="+3+"&arrayClassName=${arrayClassName}");
    }



    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/arrayClassCourse/deleteArrayClassCourseById", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type:"success"
                });
                $('#arrayClassCourseGrid').DataTable().ajax.reload();
            });
        })
    }


    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourse?arrayClassId=${arrayClassId}&term=${term}&id="+id);
        $("#dialog").modal("show")
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCourse");
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourse?arrayClassId=${arrayClassId}&term=${term}");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#a_courseID1").val("");
        $("#a_courseID1 option:selected").val()
        search();
    }
    function search() {
        var courseId = $("#a_courseID1 option:selected").val();
        arrayClass.ajax.url("<%=request.getContextPath()%>/arrayClassCourse/getArrayClassCourseList?arrayClassId=${arrayClassId}"+
            "&courseID="+courseId).load();
    }
</script>