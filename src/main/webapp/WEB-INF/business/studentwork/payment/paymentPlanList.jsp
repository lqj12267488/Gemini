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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addPaymentPlan()">新增计划
                        </button>
                        <br>
                    </div>
                    <table id="costPlanTable" cellpadding="0" cellspacing="0" width="100%"
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termVal');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearVal');
        });
        table = $("#costPlanTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/plan/getPaymentPlanList',
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
                        return '<span class="icon-edit" title="修改" onclick=editPaymentPlan("' + row.planId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delPaymentPlan("' + row.planId + '","' +row.planName+ '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function addPaymentPlan() {
        $("#dialog").load("<%=request.getContextPath()%>/payment/plan/toAdd")
        $("#dialog").modal("show")
    }

    function editPaymentPlan(id) {
        $("#dialog").load("<%=request.getContextPath()%>/payment/plan/toEdit?planId=" + id)
        $("#dialog").modal("show")
    }

    function delPaymentPlan(id,planName) {
        $.get("<%=request.getContextPath()%>/payment/plan/checkPaymentPlan?planId=" + id, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: "您即将删除的缴费计划下存在缴费信息,是否继续删除?",
                    text: "缴费计划名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/payment/plan/del", {
                        planId: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#costPlanTable').DataTable().ajax.reload();
                    });
                })
            }else{
                swal({
                    title: "您确定要删除本条信息?",
                    text: "缴费计划名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/payment/plan/del", {
                        planId: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#costPlanTable').DataTable().ajax.reload();
                    });
                })
            }
        })

    }
    function searchclear() {
        $("#nameVal").val("");
        $("#yearVal").val("");
        $("#termVal").val("");
        table.ajax.url("<%=request.getContextPath()%>/payment/plan/getPaymentPlanList").load();
    }

    function search() {
        var nameVal = $("#nameVal").val();
        var yearVal = $("#yearVal").val();
        var termVal = $("#termVal").val();
        if (nameVal == "" && yearVal == "" && termVal == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/payment/plan/getPaymentPlanList?planName="+nameVal+"&year="+yearVal+"&term="+termVal).load();
        }
    }


</script>