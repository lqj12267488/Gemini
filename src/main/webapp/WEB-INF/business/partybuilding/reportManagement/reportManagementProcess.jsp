<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 上午 10:53
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
                                申诉类型：
                            </div>
                            <div class="col-md-2">
                                <select id="e_reportType"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="s_nameSel" type="text"
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
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="cpTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="l_id" hidden value="${reportManagement.id}">
<input id="printReportManagement" hidden value="<%=request.getContextPath()%>/reportManagement/printReportManagement?id=${reportManagement.id}">
<script>
    var cpTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDeptAndClass", function (data) {
            $("#s_nameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_nameSel").val(ui.item.label);
                    $("#s_nameSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SSLX", function (data) {
            addOption(data,'e_reportType');
        });
        cpTable = $('#cpTable').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/reportManagement/getReportManagementProcessList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "manager", "title": "姓名"},
                {"width": "15%", "data": "requestDept", "title": "部门/班级"},
                {"width": "15%", "data": "requestDate", "title": "申请日期"},
                {"width": "15%", "data": "reportContent", "title": "申请内容"},
                {"width": "15%", "data": "reportTypeShow", "title": "申请类型"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleLoan' class=' icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='editLoan' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        cpTable.on('click', 'tr a', function () {
            var data = cpTable.row($(this).parent()).data();
            var id = data.id;
            var name = data.manager;
            if (this.id == "handleLoan") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_DT_REPORT_MANAGEMENT",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: id,
                            tableName: "T_DT_REPORT_MANAGEMENT",
                            url: "/reportManagement/auditReportManagementById?id=" + id+"&name="+name,
                            backUrl: "/reportManagement/process",
                            sfPrint:"1"
                        });
                    }
                })
            }

            if (this.id == "editLoan") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_DT_REPORT_MANAGEMENT",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: id,
                            tableName: "T_DT_REPORT_MANAGEMENT",
                            url: "<%=request.getContextPath()%>/reportManagement/auditEditReportManagement?id=" + id+"&name="+name,
                            backUrl: "<%=request.getContextPath()%>/reportManagement/process"
                        });
                    }
                })
            }
        });
    })

    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_reportType").val("");
        $("#s_nameSel").val("");
        $("#s_nameSel").removeAttr("keycode");
        search()
    }

    function search() {
        var requestDate = $("#e_requestDate").val();
        var reportType = $("#e_reportType").val();
        var headT = $("#s_nameSel").attr("keycode");
        var person = "";
        if (null == headT){
        } else{
            var personList = headT.split(",");
            person = personList[1];
            var dept = personList[0];
        }
        cpTable.ajax.url("<%=request.getContextPath()%>/reportManagement/getReportManagementProcessList?requestDate="+requestDate+"&reportType="
            +reportType+"&manager="+person).load();
    }
</script>

