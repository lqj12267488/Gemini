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
                                <input id="dept" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                经办人：
                            </div>
                            <div class="col-md-2">
                                <input id="manager"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <%--<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addDeviceUse()">办理
                        </button>
                        <br>
                    </div>--%>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="deviceUseGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/deviceUse/getDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/deviceUse/getPerson", function (data) {
            $("#manager").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#manager").val(ui.item.label);
                    $("#manager").attr("keycode", ui.item.value);
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
            var data = roleTable.row($(this).parent()).data();
            var deviceUseProcessId = data.id;
            //修改
            if (this.id == "uDeviceUseProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_DEVICEUSE_WF",
                    businessId: deviceUseProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: deviceUseProcessId,
                            tableName: "T_BG_DEVICEUSE_WF",
                            url: "<%=request.getContextPath()%>/deviceUse/auditDeviceUseEdit?id=" + deviceUseProcessId,
                            backUrl: "<%=request.getContextPath()%>/deviceUse/process",
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_DEVICEUSE_WF",
                    businessId: deviceUseProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: deviceUseProcessId,
                            tableName: "T_BG_DEVICEUSE_WF",
                            url: "/deviceUse/auditDeviceUseById?id=" + deviceUseProcessId,
                            backUrl: "/deviceUse/process"
                        });
                    }
                })
            }
        });
    })

    /*function addDeviceUse() {
        $("#dialog").load("/deviceUse/editDeviceUse");
        $("#dialog").modal("show");
    }*/

    function searchClear() {
        $("#dept").val("");
        $("#manager").val("");
        $("#date").val("");
        search();
    }
    function search(){
        var requestDept = $("#dept").val();
        var manager = $("#manager").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        if (manager != "")
            manager = '%' + manager + '%';
        var date = $("#date").val();
        if(date != ""){
            date = '%' + date + '%';
        }
        roleTable = $('#deviceUseGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/deviceUse/getDeviceUseListProcess',
                "data": {
                    requestDept: requestDept,
                    manager: manager,
                    requestDate: date
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "deviceName", "visible": false},
                {"width": "16%","data": "deviceUseNameShow", "title": "设备名称"},
                {"width": "18%","data": "reason", "title": "申请事由"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "manager", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "18%","data": "remark", "title": "备注"},
                {"width": "16%","title": "操作","render": function () {return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"  +
                    "<a id='uDeviceUseProcess' class='icon-edit' title='修改'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
