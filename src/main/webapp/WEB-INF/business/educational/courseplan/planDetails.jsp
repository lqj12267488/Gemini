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
                    <span style="font-size: 15px;margin-left: 20px">${planName} > 计划管理</span>
                </div>
                <div class="block block-drop-shadow content block-fill-white">
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
<script>
    var majorCode = '${majorCode}';
    var trainingLevel = '${trainingLevel}';

    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getPlanDetails?planId=${id}',
            },
            "destroy": true,
            "columns": [
                {"data": "courseName", "title": "课程名称"},
                {"data": "textbookName", "title": "教材名称"},
                {"data": "theoreticalHours", "title": "理论学时"},
                {"data": "practiceHours", "title": "实践学时"},
                {"data": "theoryPracticeHours", "title": "理实结合学时"},
                {"data": "totalHours", "title": "总学时"},
                {"data": "examType", "title": "考核方式"},
                {"data": "credit", "title": "学分"},
                {"data": "practicePlace", "title": "理实实践地点"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="学期管理" onclick=toPlanTerms("' + row.id + '","'+row.courseName+'")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.courseName + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toAddPlanDetail?planId=${id}"+ "&majorCode=" + majorCode  + "&trainingLevel=" + trainingLevel);
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toEditPlanDetail?id=" + id+ "&majorCode=" + majorCode  + "&trainingLevel=" + trainingLevel);
        $("#dialog").modal("show")
    }

    function del(id,courseName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "课程名称："+courseName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/courseplan/delPlanDetail?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })


        });

    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toCoursePlan");
    }

    function toPlanTerms(id,courseName) {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanTermList?planName=${planName}&id=" + id + "&courseName="+courseName);
    }

</script>
