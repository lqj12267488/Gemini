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
        <div class="col-md-12" >
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教师：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherId" type="text" />
                            </div>
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <select id="courseIdSel" />
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayclassList" cellpadding="0" cellspacing="0"
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
    var arrayclassList;
    var arrayclassId = $("#arrayclass").val();
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

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: " T_JW_COURSE ",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseIdSel");
            })

        arrayclassList = $("#arrayclassList").DataTable({
            "destroy": true,
            "columns": [
                {"data": "arrayclassId", "visible": false},
                {"width": "30", "data": "teacherPersonShow", "title": "教师"},
                /*{"width": "10%", "data": "teacherDeptShow", "title": "部门"},*/
                {"width": "10%", "data": "courseIdShow", "title": "课程"},
                {"width": "10%", "data": "courseTypeShow", "title": "课程类型"},
                {"width": "20%", "data": "majorCodeShow", "title": "专业"},
                /*{"width": "15%", "data": "trainingLevelShow", "title": "培养层次"},*/
                {"width": "15%", "data": "totleHours", "title": "总学时数"},
                /*{"width": "20%", "data": "planIdShow", "title": "开课计划"},*/
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='addArrayClassTeacher' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delArrayClassTeacher' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        arrayclassList.on('click', 'tr a', function () {
            var data = arrayclassList.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "addArrayClassTeacher") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/editTeacher?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delArrayClassTeacher") {
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
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type:"success"
                        });
                        arrayclassList.ajax.reload();
                    });
                })
            }
        });
        searchGrid();
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/teacher/addTeacher?arrayclassId="+arrayclassId);
        $("#dialog").modal("show");
    }

    function searchclearGrid() {
        $("#courseIdSel option:selected").val("");
        $("#courseIdSel").val("");
        $("#teacherId").val("");
        $("#teacherId").attr("keycode","");
        searchGrid();
    }

    function searchGrid() {
        var courseId = $("#courseIdSel option:selected").val();
        if (courseId == undefined ||courseId == null ) {
            courseId = "";
        }
        var teacherId = $("#teacherId").attr("keycode");
        var teacherPersonId ="";
        var teacherDeptId ="";
        if( teacherId!=null && teacherId!=""){
            teacherPersonId = teacherId.split(",")[1];
            teacherDeptId = teacherId.split(",")[0];
        }
        arrayclassList.ajax.url(
            "<%=request.getContextPath()%>/arrayClass/teacher/getTeacherList?" +
            "arrayclassId="+arrayclassId+"&courseId="+courseId+
            "&teacherPersonId="+teacherPersonId+"&teacherDeptId="+teacherDeptId
        ).load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClass/teacher/getarrayClassList");
    }

</script>