<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <input id="planId" name="planId" hidden value="${planId}"/>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <table id="resultTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var resultTable;
    $(document).ready(function () {
        resultTable = $("#resultTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/info/getStandardList?planId=${planId}&studentId=${studentId}'
            },
            "destroy": true,
            "columns": [
                {"width": "5%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "5%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "classShow", "title": "班级"},
                {"width": "10%", "data": "planItemShow", "title": "缴费项目"},
                {"width": "10%", "data": "paymentStandard", "title": "缴费标准"},
                {"width": "10%", "data": "paymentAmount", "title": "缴费金额"},
                {"width": "10%", "data": "refundAmount", "title": "退费金额"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            "dom": 'rtlip',
            "language": language
        });
    });

    function back() {
        $("#right").load("<%=request.getContextPath()%>/core/parent/paymentResult");
        $("#right").modal("show")
    }

</script>




