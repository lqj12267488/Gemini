<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/23
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <header class="mui-bar mui-bar-nav">
                        <h5 class="mui-title">${arrayClassName} > ${teacherPersonName} > 设置任课课程</h5>
                    </header>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            课程名称：
                        </div>
                        <div class="col-md-2">
                            <input id="courseId" type="text" />
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
                        <table id="teacherCourseGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="teacherPersonId" value="${teacherPersonId}" hidden>
    <input id="arrayclassId" value="${arrayclassId}" hidden>
    <input id="arrayClassName" value="${arrayClassName}" hidden>
    <input id="arrayclassTeacherId1" value="${arrayclassTeacherId1}" hidden>
</div>
<script>
    var teacherCourseTable;
    $(document).ready(function () {
        search();
        teacherCourseTable.on('click', 'tr a', function () {
            var data = teacherCourseTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editTeacherCourse") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/editTeacherCourse?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delTeacherCourse") {
                swal({
                    title: "您确定要删除本条信息?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClass/teacher/deleteTeacherCourseById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        teacherCourseTable.ajax.reload();
                    });
                })
            }
        });
    })

    function add() {
        var teacherPersonId=$("#teacherPersonId").val();
        var arrayclassId=$("#arrayclassId").val();
        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/editTeacherCourse?teacherPersonId=${teacherPersonId}"+"&arrayclassId="+arrayclassId+"&arrayclassTeacherId=${arrayclassTeacherId1}");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#courseId").val("");
        search();
    }
    function search(){
        var arrayclassId=$("#arrayclassId").val();
        var teacherPersonId=$("#teacherPersonId").val();
        var courseId=$("#courseId").val();
        courseId='%'+courseId+'%';
        teacherCourseTable = $("#teacherCourseGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/teacher/getTeacherCourseList',
                "data": {
                    courseId:courseId,
                    teacherPersonId:teacherPersonId,
                    arrayclassId:arrayclassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "18%", "data": "courseId", "title": "课程名称"},
                {"width": "18%", "data": "courseType", "title": "课程类型"},
                {"width": "18%", "data": "departmentsId", "title": "系部"},
                {"width": "18%", "data": "majorCode", "title": "专业"},
                {"width": "18%", "data": "trainingLevel", "title": "培养层次"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return "<a id='editTeacherCourse' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delTeacherCourse' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function back() {
        var arrayclassId=$("#arrayclassId").val();
        var arrayClassName=$("#arrayClassName").val();
        $("#right").load("<%=request.getContextPath()%>/arrayClass/teacher/teacherList?arrayclassId="+arrayclassId+"&arrayClassName="+arrayClassName);
    }
</script>