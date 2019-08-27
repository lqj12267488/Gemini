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
                        <div class="block block-drop-shadow content">
                            <div class="form-row">
                                <h5>${name} > 关联教学计划</h5>
                                <input id="countCache" hidden value="${count}">
                            </div>
                        </div>
                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row">
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="back()">返回
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="add()">关联教学计划
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="exportCoursePlan()">按照已关联教学计划导入
                                    </button>

                                    <br>
                                </div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="arrayClassCoursePlanGrid" cellpadding="0" cellspacing="0"
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
    var arrayClassTime;
    var planId ;
    $(document).ready(function () {
        arrayClassTime = $("#arrayClassCoursePlanGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassCoursePlanList?arrayClassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "planId", "visible": false},
                {"width": "22%", "data": "arrayClassId", "title": "排课计划名称"},
                {"width": "22%", "data": "planName", "title": "教学计划名称"},
                {"width": "22%", "data": "schoolYear", "title": "学年"},
                {"width": "22%", "data": "term", "title": "学期"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editCoursePlan' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delCoursePlan' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order': [[1, 'asc']],
            "dom": 'rtlip',
            language: language
        });
        arrayClassTime.on('click', 'tr a', function () {
            var data = arrayClassTime.row($(this).parent()).data();
            var id = data.id;
            var planId = data.planId;
            if (this.id == "correlation") {
                $.get("<%=request.getContextPath()%>/arrayClass/checkCoursePlanForArrayClass", function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "info"});
                        return;
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/relateCoursePlanToArrayClass?id=" + id);
                        $("#dialog").modal("show");
                    }
                })
            }
            if (this.id == "delCoursePlan") {
                swal({
                    title: "您确定要删除本条信息?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/arrayClass/deleteArrayClassCoursePlanById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"}, function () {
                                $("#countCache").val(eval($("#countCache").val() - 1))
                            });
                            $('#arrayClassCoursePlanGrid').DataTable().ajax.reload();
                        }
                    });
                })
            }
            if (this.id == "editCoursePlan") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/relateCoursePlanToArrayClass?id=" + id);
                $("#dialog").modal("show");
            }
        });
    })

    function add() {
        $.get("<%=request.getContextPath()%>/arrayClass/checkCoursePlanForArrayClass", function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "info"});
                return;
            } else {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/relateCoursePlanToArrayClass?arrayClassId=${arrayClassId}");
                $("#dialog").modal("show");
            }
        })
    }

    function exportCoursePlan() {


        if ($("#countCache").val() == 0) {
            swal({title: "您还没有关联教学计划，请关联教学计划后在做此操作。", type: "error"});
            return;
        } else {
            swal({
                title: "将所关联教学计划中课程、班级、教师、场地信息覆盖现有信息，是否确认导入?",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确认",
                closeOnConfirm: false
            }, function () {
                $.get("<%=request.getContextPath()%>/arrayClass/exportCoursePlanForArrayClass?arrayClassId=${arrayClassId}&arr_planId=${planId}", function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        return;
                    } else {
                        swal({title: "导入失败！", type: "error"});
                        $.get("<%=request.getContextPath()%>/arrayClass/deleteCoursePlanForArrayClass?arrayClassId=${arrayClassId}", function (msg) {
                            if (msg.status == 1) {
                                return;
                            } else {
                                return;
                            }
                        })
                        return;
                    }
                })
            })

        }




    }


    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClass/request");
    }
</script>