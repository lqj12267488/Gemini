<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                计划名称：
                            </div>
                            <div class="col-md-2">
                                <input type="text" name="nameVal" id="nameVal"/>
                            </div>
                            <div class="col-md-1 tar">
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="yearVal" ></select>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="termVal" ></select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <table id="resultPaymentTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
        <input id="studentId" hidden value="${studentId}">
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termVal');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearVal');
        });
        table = $("#resultPaymentTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/plan/getPaymentPlanList?planId='+$("#studentId").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "planId", "visible": false},
                {"data":"planName","title":"缴费计划名称"},
                {"data":"planItemShow","title":"缴费项目"},
                {"data":"year","title":"年份"},
                {"data":"termShow","title":"学期"},
                {"data":"startTime","title":"缴费开始时间"},
                {"data":"endTime","title":"缴费结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-search" title="查看缴费结果" onclick=searchPaymentResult("' + row.planId + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function searchPaymentResult(id) {
        $("#right").load("<%=request.getContextPath()%>/core/parent/toPaymentResult?planId="+id);
    }


    function searchclear() {
        $("#nameVal").val("");
        $("#yearVal").val("");
        $("#termVal").val("");
        table.ajax.url("<%=request.getContextPath()%>/payment/plan/getPaymentPlanList?planId="+$("#studentId").val()).load();
    }

    function search() {
        var nameVal = $("#nameVal").val();
        var yearVal = $("#yearVal").val();
        var termVal = $("#termVal").val();
        if (nameVal == "" && yearVal == "" && termVal == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/payment/plan/getPaymentPlanList"
                +"?planName="+nameVal+"&year="+yearVal+"&term="+termVal+"&planId="+$("#studentId").val()).load();
        }
    }


</script>