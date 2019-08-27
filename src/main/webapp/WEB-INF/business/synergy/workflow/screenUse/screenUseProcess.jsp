<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/28
  Time: 9:56
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
                                <input id="dept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                经办人：
                            </div>
                            <div class="col-md-2">
                                <input id="requester"
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
                        <table id="screenUseGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/screenUse/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/screenUse/getPerson", function (data) {
            $("#requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requester").val(ui.item.label);
                    $("#requester").attr("keycode", ui.item.value);
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
            var screenUseProcessId = data.id;
            //修改
            if (this.id == "uScreenUseProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_SCREENUSE_WF",
                    businessId: screenUseProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: screenUseProcessId,
                            tableName: "T_BG_SCREENUSE_WF",
                            url: "<%=request.getContextPath()%>/screenUse/auditScreenUseEdit?id=" + screenUseProcessId,
                            backUrl: "<%=request.getContextPath()%>/screenUse/process",
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_SCREENUSE_WF",
                    businessId: screenUseProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: screenUseProcessId,
                            tableName: "T_BG_SCREENUSE_WF",
                            url: "/screenUse/auditScreenUseById?id=" + screenUseProcessId,
                            backUrl: "/screenUse/process"
                        });
                    }
                })
            }
        });
    })

    function searchClear() {
        $("#dept").val("");
        $("#requester").val("");
        $("#date").val("");
        search();
    }
    function search(){
        var requestDept = $("#dept").val();
        var requester = $("#requester").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        if (requester != "")
            requester = '%' + requester + '%';
        var date = $("#date").val();
        if(date != ""){
            date = '%' + date + '%';
        }
        roleTable = $('#screenUseGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/screenUse/getScreenUseListProcess',
                "data": {
                    requestDept: requestDept,
                    requester: requester,
                    requestDate: date
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "screen", "visible": false},
                {"width": "14%",
                    "render": function(data,type,row,meta){
                        data = row.content;
                        return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                    },"title": "申请内容"
                },
                {"width": "14%","data": "screenShow","title": "大屏幕"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "usingTime", "title": "使用日期"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "14%","data": "remark",
                    "render": function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                    }, "title": "备注"
                },
                {"width": "16%","title": "操作","render": function () {return  "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"  +
                    "<a id='uScreenUseProcess' class='icon-edit' title='修改'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>

