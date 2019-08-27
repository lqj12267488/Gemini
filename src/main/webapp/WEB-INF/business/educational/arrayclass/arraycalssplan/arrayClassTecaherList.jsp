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
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${arrayClassName} > 维护教师授课计划</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教师：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <select id="courseIdSel"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchGrid()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclearGrid()">清空
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
    <input id="arrayclass" hidden value="${arrayclassId}">
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherId").val(ui.item.label);
                    $("#teacherId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: " T_JW_COURSE ",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseIdSel");
            })

        $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/teacher/getTeacherList?arrayclassId=${arrayclassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayclassTeacherId", "visible": false},
                {"data": "teacherPersonShow", "title": "授课教师"},
                {"data": "teacherDeptId", "title": "所在部门"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="维护教师授课计划" onclick=toArrayclassArrayTeacherList("' + row.arrayclassTeacherId + '","'+row.teacherPersonShow+'")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function searchclearGrid() {
        $("#courseIdSel option:selected").val("");
        $("#courseIdSel").val("");
        $("#teacherId").val("");
        $("#teacherId").attr("keycode", "");
        searchGrid();
    }

    function searchGrid() {
        var courseId = $("#courseIdSel option:selected").val();
        if (courseId == undefined || courseId == null) {
            courseId = "";
        }
        var teacherId = $("#teacherId").attr("keycode");
        var teacherPersonId = "";
        var teacherDeptId = "";
        if (teacherId != null && teacherId != "") {
            teacherPersonId = teacherId.split(",")[1];
            teacherDeptId = teacherId.split(",")[0];
        }
        var arrayclassId = $("#arrayclass").val();
        $("#table").DataTable().ajax.url(
            "<%=request.getContextPath()%>/arrayClass/teacher/getTeacherList?" +
            "arrayclassId=" + arrayclassId + "&courseId=" + courseId +
            "&teacherPersonId=" + teacherPersonId + "&teacherDeptId=" + teacherDeptId
        ).load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toTeacherList");
    }

    function toArrayclassArrayTeacherList(id,teacherPersonShow) {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toArrayclassArrayTeacherList?id=" + id +"&teacherPersonShow="+teacherPersonShow+"&arrayClassName=${arrayClassName}");
    }

</script>