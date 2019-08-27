<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
             <%--   <div class="block block-drop-shadow content block-fill-white">

                </div>--%>
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${arrayClassName}>${className} > 设置教学计划</span>
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
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayclassplan/getArrayclassArrayList?arrayclassId=${id}&classId=${classId}',
            },
            "destroy": true,
            "columns": [
                {"data": "departmentsId", "title": "系部"},
                {"data": "majorCode", "title": "专业"},
                {"data": "classId", "title": "班级"},
                {"data": "courseType", "title": "课程类型"},
                {"data": "courseId", "title": "课程"},
                {"data": "roomId", "title": "教室"},
                {"data": "teacherPersonId", "title": "授课教师"},
                {"data": "weekType", "title": "学周类型"},
                {"data": "startWeek", "title": "开始学周"},
                {"data": "endWeek", "title": "结束学周"},
                {"data": "weekHours", "title": "每周学时"},
                {"data": "connectHours", "title": "连课学时"},
                {"data": "mergeFlag", "title": "合班"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.arrayId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.arrayId + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayclassplan/toArrayclassArrayAdd?arrayclassClassId=${arrayclassClassId}")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayclassplan/toArrayclassArrayEdit?id=" + id)
        $("#dialog").modal("show")
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
            $.post("<%=request.getContextPath()%>/arrayclassplan/delArrayclassArray", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type:"success"
                });
                $('#table').DataTable().ajax.reload();
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toArrayClassClassList?id=${id}&className=${className}&arrayClassName=${arrayClassName}")
    }
</script>