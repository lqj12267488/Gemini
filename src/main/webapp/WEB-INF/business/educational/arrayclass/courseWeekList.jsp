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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <h5>${arrayClassName} > ${courseShow} > 学时维护</h5>
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
                            <table id="arrayClassCourseWeekGrid" cellpadding="0" cellspacing="0"
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
<script>
    var arrayClass;
    $(document).ready(function () {
        arrayClass = $("#arrayClassCourseWeekGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassCourse/getArrayClassCourseWeekList?arrayClassCourseId=${arrayClassCourseId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "arrayClassId", "visible": false},
                {"data": "arrayClassCourseId", "visible": false},
                {"width": "13%", "data": "weekTypeShow", "title": "学周类型"},
                {"width": "13%", "data": "startWeek", "title": "开始学周"},
                {"width": "13%", "data": "endWeek", "title": "结束学周"},
                {"width": "13%", "data": "weekNumber", "title": "学周数"},
                {"width": "13%", "data": "weekHours", "title": "每周学时数"},
                {"width": "13%", "data": "totleHours", "title": "总学时数"},
                {"width": "13%", "data": "teachTypeShow", "title": "上课类型"},
                {
                    "width": "9%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                        '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';
                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc']],
            "dom": 'rtlip',
            language: language
        });
    })

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
            $.post("<%=request.getContextPath()%>/arrayClassCourse/deleteArrayClassCourseWeekById", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#arrayClassCourseWeekGrid').DataTable().ajax.reload();
            });
        })
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourseWeek?id=" + id);
        $("#dialog").modal("show")
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCourse/request?arrayClassId=${arrayClassId}&arrayClassName=${arrayClassName}");
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourseWeek?arrayClassId=${arrayClassId}&arrayClassCourseId=${arrayClassCourseId}&term=${term}&courseType=${courseType}&courseID=${courseID}&departmentsId=${departmentsId}&majorCode=${majorCode}&credit=${credit}");
        $("#dialog").modal("show");
    }

</script>