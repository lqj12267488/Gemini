<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/5/24
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="addRepairSuppliesList()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="repairSupplies" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_ZW_REPAIRSUPPLIES">
<input id="repairid" hidden value="${repair.repairID}">
<script>
    /*alert($("#repairid").val())*/
    var repairSupplies;

    $(document).ready(function () {
        repairSupplies = $("#repairSupplies").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/getRepairItemList',//跳转到controller中的/repairSupplies/getRepairSuppliesList注解
                "data": {"repairID": $("#repairid").val()},
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "suppliesid", "visible": false},
                {"width": "16%", "data": "suppliestype", "title": "耗材类型"},
                {"width": "16%", "data": "suppliesnameShow", "title": "耗材名称"},
                {"width": "16%", "data": "suppliesInnum", "title": "库存数量"},
                {"width": "16%", "data": "suppliesnum", "title": "使用数量"},
                {"width": "16%", "data": "remark", "title": "备注"},
                {
                    "width": "16%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='delRole' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

        repairSupplies.on('click', 'tr a', function () {
            //var data = repairSupplies.row(this.parent).data();
            var data = repairSupplies.row($(this).parent()).data();
            var id = data.id;
            var suppliesname = data.suppliesnameShow;
            var snum = parseInt(data.suppliesInnum);
            var suppliesnum = parseInt(data.suppliesnum);
            var suppliesInnum = snum+suppliesnum;
            var suppliesid = data.suppliesid;
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "报修物品：" + suppliesname + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/repairSupplies/deleteSupplies?id=" + id + "&repairId=${repair.repairID}"+"&suppliesInnum="+suppliesInnum+"&suppliesid="+suppliesid, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#repairSupplies').DataTable().ajax.reload();
                        }
                    })

                });
            }
        });
    });

    function addRepairSuppliesList() { //跳转到controller中的/repairSupplies/addRepairSupplies注解
        $("#dialog").load("<%=request.getContextPath()%>/repairSupplies/editSupplies?repairID=" + $("#repairid").val());
        $("#dialog").modal("show");
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/repair/logisticsRepair");
    }
</script>