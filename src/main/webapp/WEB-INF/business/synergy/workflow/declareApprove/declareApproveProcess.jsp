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
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="date"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                拟申报职称层次：
                            </div>
                            <div class="col-md-2">
                                <input id="appliedLevelSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="declareApprove" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="h_id" hidden value="${declareApprove.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/declareApprove/printFunds?id=${declareApprove.id}">
<script>
    var roleTable;

    $(document).ready(function () {

        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "handleFunds") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_DECLARE_APPROVE_WF",
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
                            tableName: "T_BG_DECLARE_APPROVE_WF",
                            url: "/declareApprove/auditDeclareApproveById?id=" + id,
                            backUrl: "/declareApprove/process"
                        });
                    }
                })
            }

            if (this.id=="preview") {
                $("#dialog").load("<%=request.getContextPath()%>/files/filesUploadTable1?businessId=" + id );
                $("#dialog").modal("show");
            }
        });
    })

    function searchClear() {
        $("#requestdate").val("");
        $("#nameSel").val("");
        $("#appliedLevelSel").val("");

        search();
    }

    function search() {
        var name = $("#nameSel").val();
        var appliedLevel = $("#appliedLevelSel").val();
        var requestDate = $("#requestdate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';

        roleTable = $("#declareApprove").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/declareApprove/getProcessList',
                "data": {
                    requestDate: requestDate,
                    name: name,
                    appliedLevel: appliedLevel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "14%", "data": "requestDate", "title": "申请日期"},
                {"width": "14%", "data": "name", "title": "姓名"},
                {"width": "14%", "data": "sexShow", "title": "性别"},
                {"width": "14%", "data": "workDept", "title": "工作部门"},
                {"width": "14%", "data": "appliedLevel", "title": "拟申报职称层次"},
                {"width": "14%", "data": "requestFlag", "title": "请求状态"},
                {
                    "width": "14%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='handleFunds' class=' icon-file-text-alt' title='办理'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>

