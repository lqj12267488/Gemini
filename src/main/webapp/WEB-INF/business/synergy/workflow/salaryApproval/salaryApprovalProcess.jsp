<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/18
  Time: 17:33
  To change this template use File | Settings | File Templates.
 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="f_requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                        <table id="salaryApprovalGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/salaryApproval/autoCompleteDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/salaryApproval/autoCompleteEmployee", function (data) {
            $("#f_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requester").val(ui.item.label);
                    $("#f_requester").attr("keycode", ui.item.value);
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
            var salaryApprovalProcessId = data.id;
            //修改
            if (this.id == "eidtSalaryApprovalProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_SALARYAPPROVAL_WF",
                    businessId: salaryApprovalProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: salaryApprovalProcessId,
                            tableName: "T_BG_SALARYAPPROVAL_WF",
                            url: "<%=request.getContextPath()%>/salaryApproval/auditSalaryApprovalEdit?id=" + salaryApprovalProcessId,
                            backUrl: "<%=request.getContextPath()%>/salaryApproval/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_SALARYAPPROVAL_WF",
                    businessId: salaryApprovalProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: salaryApprovalProcessId,
                            tableName: "T_BG_SALARYAPPROVAL_WF",
                            url: "/salaryApproval/auditSalaryApprovalById?id=" + salaryApprovalProcessId,
                            backUrl: "/salaryApproval/process"
                        });
                    }
                })
            }

        });
    });

    function searchclear() {
        $("#dept").val("");
        $("#f_requester").val("");
        $("#date").val("");
        search();
    }

    function search() {
        var dept = $("#dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var f_requester = $("#f_requester").val();
        if (f_requester != "")
            f_requester = '%' + f_requester + '%';
        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#salaryApprovalGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/salaryApproval/getProcessList',
                "data": {
                    requester:f_requester,
                    requestDept:dept,
                    requestDate:date
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "14%", "data": "requestDept", "title": "申请部门"},
                {"width": "14%", "data": "requester", "title": "申请人"},
                {"width": "12%", "data": "requestDate", "title": "申请日期"},
                {"width": "12%", "data": "year", "title": "年份"},
                {"width": "12%", "data": "month", "title": "月份"},
                {"width": "14%", "data": "fileName", "title": "工资单名称"},
                {"width": "12%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='eidtSalaryApprovalProcess' class='icon-edit' title='修改'></a>";
                    }
                },
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

</script>

