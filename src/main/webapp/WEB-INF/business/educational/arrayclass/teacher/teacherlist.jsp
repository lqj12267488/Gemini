<%--
  Created by IntelliJ IDEA.
  User: Admin
  modify: wq 2017/08/23
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
                        <header class="mui-bar mui-bar-nav">
                            <h5 id="arrayClassName" class="mui-title" value="${arrayClassName}">${arrayClassName} > 设置教师信息</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                授课教师：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherId" type="text" />
                            </div>
                            <%--<div class="col-md-1 tar">--%>
                            <%--课程：--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                            <%--<select id="courseIdSel" />--%>
                            <%--</div>--%>
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
                                onclick="addTeacher()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayclassTeacherGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="arrayclassId" hidden value="${arrayclassId}">
</div>
<script>
    var arrayclassTeacherTable;
    $(document).ready(function () {
        search();
        arrayclassTeacherTable.on('click', 'tr a', function () {
            var data = arrayclassTeacherTable.row($(this).parent()).data();
            var arrayclassTeacherId = data.arrayclassTeacherId;
            var teacherPersonId = data.teacherPersonId;
            var teacherPersonName = data.teacherPersonShow;
            var arrayclassId = data.arrayclassId;
            if (this.id == "editTeacher") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/editTeacher?arrayclassTeacherId="+arrayclassTeacherId);
                $("#dialog").modal("show");
            }
            if (this.id == "delTeacher") {
                swal({
                    title: "您确定要删除本条信息?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClass/delArrayClassTeacher", {
                        arrayclassTeacherId: arrayclassTeacherId
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        arrayclassTeacherTable.ajax.reload();
                    });
                })

            }
            if (this.id == "setCondition") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassCondition/request?arrayClassId=${arrayclassId}&elementsId=" + arrayclassTeacherId+"&arrayClassName=${arrayClassName}"+"&elementsType="+2);
            }
            if (this.id == "setCourse") {
                $("#right").load("<%=request.getContextPath()%>/arrayClass/teacher/teacherCourseAction?teacherPersonId="+teacherPersonId+"&arrayclassId="+arrayclassId +
                    "&arrayClassName=${arrayClassName}&teacherPersonName="+teacherPersonName+"&arrayclassTeacherId="+arrayclassTeacherId);
            }
        });
    })

    function addTeacher() {
        var arrayclassId = $("#arrayclassId").val();
        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/addTeacher?arrayclassId="+arrayclassId);
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#teacherId").val("");
        search();
    }

    function search() {
        var teacherId=$("#teacherId").val();
        teacherId='%'+teacherId+'%';
        var arrayclassId = $("#arrayclassId").val();
        arrayclassTeacherTable = $("#arrayclassTeacherGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/teacher/getTeacherList',
                "data": {
                    teacherPersonId:teacherId,
                    arrayclassId:arrayclassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "arrayclassTeacherId", "visible": false},
                {"data": "teacherPersonId", "visible": false},
                {"data": "arrayclassId", "visible": false},
                {"width": "40%", "data": "teacherPersonShow", "title": "授课教师"},
                {"width": "40%", "data": "teacherDeptId", "title": "所在部门"},
                {
                    "width": "20%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editTeacher' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delTeacher' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='setCondition' class='icon-info-sign' title='设置排课约束条件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='setCourse' class='icon-wrench' title='设置任课课程'></a>";
                    }
                }
            ],
            'order' : [3,'asc'],
            "dom": 'rtlip',
            language: language
        });
//        arrayclassTeacherList.ajax.url(
//            "/arrayClass/teacher/getTeacherList?arrayclassId="+arrayclassId+
//            "&teacherPersonId="+teacherId
//        ).load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassTeacher/request");
        $("#right").modal("show");
    }
</script>