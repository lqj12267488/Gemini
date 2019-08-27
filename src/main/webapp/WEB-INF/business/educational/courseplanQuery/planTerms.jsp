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
                <%--<div class="block block-drop-shadow content">
                    <div class="form-row">
                        <h5>${planName}>${data.courseName}学时管理</h5>
                    </div>
                </div>--%>
                <div class="block block-drop-shadow content block-fill-white">
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
                {"data": "schoolYear", "title": "学年"},
                {"data": "term", "title": "学期"},
                {"data": "weeks", "title": "学周"},
                {"data": "weekType", "title": "学周类型"},
                {"data": "startWeek", "title": "开始学周"},
                {"data": "endWeek", "title": "结束学周"},
                {"data": "weeksHours", "title": "每周学时"},
                {"data": "totleHours", "title": "总学时"},
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanDetails?id=${data.planId}&planName=${planName}")
    }
</script>