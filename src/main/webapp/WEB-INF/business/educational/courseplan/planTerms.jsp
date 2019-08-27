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
                    <span style="font-size: 15px;margin-left: 20px">${planName} > ${courseName} > 学期管理</span>
                </div>
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
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
    <input hidden id="courseName" value="${data.courseName}">
    <input hidden id="planName" value="${planName}">
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getPlanTerms?detailsId=${data.id}',
            },
            "destroy": true,
            "columns": [
                {"data": "courseId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "term", "visible": false},
                {"data": "detailsId", "visible": false},
                {"data": "schoolYear", "title": "学年"},
                {"data": "termShow", "title": "学期"},
                {"data": "weeksNumber", "title": "学周"},
                {"data": "weekType", "title": "学周类型"},
                {"data": "startWeek", "title": "开始学周"},
                {"data": "endWeek", "title": "结束学周"},
                {"data": "weeksHours", "title": "每周学时"},
                {"data": "totleHours", "title": "总学时"},
                {"data": "personId", "title": "签课教师(位)"},
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanDetailsQuery?id=${data.planId}&planName=${planName}")
    }
</script>