<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${planName} > 授课计划详情</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
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
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teachingPlanDetail/getList?planId=${planId}',
            },
            "destroy": true,
            "columns": [
                {"width": "10%", "data": "planName", "title": "授课计划"},
                {"width": "8%", "data": "week", "title": "周次"},
                {"width": "14%", "data": "content", "title": "教学内容提要"},
                {"width": "12%", "data": "theoreticalHours", "title": "理论学时"},
                {"width": "12%", "data": "practiceHours", "title": "实践学时"},
                {"width": "12%", "data": "theoryPracticeHours", "title": "理实结合学时"},
                {"width": "12%", "data": "totalHours", "title": "合计学时"},
                {"width": "14%", "data": "practicePlace", "title": "实践上课地点"},
                {"width": "8%", "data": "focus", "title": "重点"},
                {"width": "8%", "data": "difficulty", "title": "难点"},
                {"width": "6%", "data": "homework", "title": "作业"},

            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teachingPlanDetail/toAdd?planId=${planId}");
        $("#dialog").modal("show")
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/teachingPlan/process");
        $("#right").modal("show")
    }
    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/teachingPlanDetail/toEdit?id=" + id)
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
            $.post("<%=request.getContextPath()%>/teachingPlanDetail/del", {
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
</script>