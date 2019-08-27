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
                <div class="block block-drop-shadow">
                </div>
                <div class="block block-drop-shadow content">

                    <table id="personlResultTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">

                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {

        
        table = $("#personlResultTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/personal/getPersonalPaymentList'
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "classId", "visible": false},
                {"data": "planId", "visible": false},
                {"width": "10%", "data": "studentName", "title": "学生姓名"},
                {"width": "10%", "data": "planName", "title": "缴费计划"},
                {"width": "10%", "data": "planItemShow", "title": "缴费项目"},
                {"width": "10%", "data": "paymentStandard", "title": "缴费标准"},
                {"width": "10%", "data": "paymentAmount", "title": "缴费金额"},
                {"width": "10%", "data": "refundAmount", "title": "退费金额"},


            ],
            'order' : [[3,'desc'],[2,'desc'],[1,'desc']],
            "dom": 'rtlip',
            "language": language
        });
    });










</script>




