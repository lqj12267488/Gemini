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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                耗材名称：
                            </div>
                            <div class="col-md-2">
                                <input id="sname" type=""
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                品牌：
                            </div>
                            <div class="col-md-2">
                                <input id="brand" type=""
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                入库时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"  class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="sch()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="schclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
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
<input id="businessId" hidden>
<script>
    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=WXHCLX", function (data) {
            addOption(data, "searchreroletype")
        })
        roleTable = $("#repairSupplies").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repairSupplies/getRepairSuppliesList',//跳转到controller中的/repairSupplies/getRepairSuppliesList注解
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "11%", "data": "suppliesname", "title": "耗材名称"},
                {"width": "9%", "data": "suppliestypeShow", "title": "耗材类型"},
                {"width": "11%", "data": "suppliesnum", "title": "耗材数量"},
                {"width": "11%", "data": "suppliesInnum", "title": "库存数量"},
                {"width": "9%", "data": "unit", "title": "单位"},
                {"width": "11%", "data": "price", "title": "单价(元)"},
                {"width": "9%", "data": "specifications", "title": "规格"},
                {"width": "9%", "data": "brand", "title": "品牌"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {"width": "5%", "data": "intime", "title": "入库时间"},
                {
                    "width": "7%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var suppliesname = data.suppliesname;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/repairSupplies/getRepairSuppliesById?id=" +id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "耗材名称："+suppliesname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/repairSupplies/deleteRepairSuppliesById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type:"success"
                        });
                        $('#repairSupplies').DataTable().ajax.reload();

                    });

                });
               /* if (confirm("请确认是否要删除本条申请?")) {
                    //删除数据通过controller中/repairSupplies/deleteRepairSuppliesById方法
                    $.get("/repairSupplies/deleteRepairSuppliesById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#repairSupplies').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
        });
    });
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        $.post("/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_ZW_REPAIRSUPPLIES",
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#repairSupplies').DataTable().ajax.reload();
                }
            })
    }
    function addRepairSuppliesList() { //跳转到controller中的/repairSupplies/addRepairSupplies注解
        $("#dialog").load("<%=request.getContextPath()%>/repairSupplies/addRepairSupplies");
        $("#dialog").modal("show");
    }

    function schclear() {
        $("#sname").val("");
        $("#brand").val("");
        $("#date").val("");
        sch();
    }

    function sch() {
        var suppliesname = $("#sname").val();
        var brand=$("#brand").val();
        var date=$("#date").val();
        roleTable.ajax.url("<%=request.getContextPath()%>/repairSupplies/search?suppliesname=" +suppliesname +"&brand=" +brand +"&intime=" +date).load();
    }
</script>