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
                                申请部门：
                            </div>
                            <div class="col-md-2">
                                <input id="e_requestDept" type=""
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="e_requester" type=""
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="e_requestDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="itDeviceRepair" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var roleTable;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/itdevicerepai/getDept", function (data) {
            $("#e_requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#e_requestDept").val(ui.item.label);
                    $("#e_requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/itdevicerepai/getPerson", function (data) {
            $("#e_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#e_requester").val(ui.item.label);
                    $("#e_requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


        search();
        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "addITDevice") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_ITDEVICEREPAIR_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: id,
                            tableName: "T_BG_ITDEVICEREPAIR_WF",
                            url: "/itdevicerepai/auditITDeviceRepaiById?id=" + id,
                            backUrl: "/itdevicerepai/process"
                        });
                    }
                })
            }
            if (this.id == "editITDevice") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_ITDEVICEREPAIR_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: id,
                            tableName: "T_BG_ITDEVICEREPAIR_WF",
                            url: "<%=request.getContextPath()%>/itDeviceRepair/auditEdit?id=" + id,
                            backUrl: "<%=request.getContextPath()%>/itdevicerepai/process"
                        });
                    }
                })

            }

        });
    });

    function searchclear() {
        $("#e_requestDate").val("");
        $("#e_requester").val("");
        $("#e_requestDept").val("");
        search();
    }

    function search() {

        var requestDate = $("#e_requestDate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';
        var requestDept = $("#e_requestDept").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        var requester = $("#e_requester").val();
        if (requester != "")
            requester = '%' + requester + '%';
        roleTable = $("#itDeviceRepair").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/itdevicerepai/getITDeviceListProcess',
                "data": {
                    requester: requester,
                    requestDept: requestDept,
                    requestDate:requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "30%", "data": "reason", "title": "申请原因"},
                {"width": "10%", "data": "requestDept", "title": "申请部门"},
                {"width": "10%", "data": "requester", "title": "申请人"},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "30%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='addITDevice' class=' icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='editITDevice' class='icon-edit' title='修改'></a>";
                    }
                }

            ],
            "dom": '<"rtlip">rtlip',
            language: language
        });
        /* $("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/

    }
</script>
