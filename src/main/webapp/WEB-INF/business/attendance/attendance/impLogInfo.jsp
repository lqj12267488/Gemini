<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 900px">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <table id="infoGrid" cellpadding="0" cellspacing="0"
                       width="100%" style="max-height: 50%;min-height: 10%;"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input hidden id="codingval" value="${coding}">
</div>
<script>

    $(document).ready(function () {
        var infoTable = $("#infoGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/attendance/getInfoByCoding',
                "data": {
                    coding: $("#codingval").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"width": "8%", "data": "name", "title": "姓名"},
                {"width": "3%", "data": "year", "title": "年"},
                {"width": "3%", "data": "month", "title": "月"},
                {"width": "12%", "data": "basicFrequency", "title": "应签到<br/>次数"},
                {"width": "12%", "data": "noSignInFrequency", "title": "未签到<br/>次数"},
                {"width": "12%", "data": "latestOutOfSignIn", "title": "最新<br/>未签到"},
                {"width": "12%", "data": "leaveNoSign", "title": "调休<br/>未签到"},
                {"width": "8%", "data": "publicHolidays", "title": "公假"},
                {"width": "8%", "data": "compassionateLeave", "title": "事假"},
                {"width": "8%", "data": "sickLeave", "title": "病假"},
                {"width": "14%", "data": "wrongSignOnBusiness", "title": "因公(因故)误签"},
            ],
            "dom": 'rtlip',
            language: language
        });
    })


</script>