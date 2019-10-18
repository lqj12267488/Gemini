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
                                <input id="rcDate" type="date"
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
                        <table id="ccTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var ccTable;
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
        ccTable = $('#ccTable').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/reportManagement/getReportManagementCompleteList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "13%", "data": "manager", "title": "姓名"},
                {"width": "13%", "data": "requestDept", "title": "部门/班级"},
                {"width": "13%", "data": "requestDate", "title": "申请日期"},
                {"width": "13%", "data": "reportContent", "title": "申诉内容"},
                {"width": "13%", "data": "reportTypeShow", "title": "申诉类型"},
                {"width": "13%", "data": "requestFlag", "title": "请求状态"},
                {
                    "width": "13%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='logLoan' class='icon-search' title='查看流程轨迹'></a>"
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        ccTable.on('click', 'tr a', function () {
            var data = ccTable.row($(this).parent()).data();
            var id = data.id;
            var name = data.manager
            var requestFlag = data.requestFlag;
            if (this.id == "logLoan") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_DT_REPORT_MANAGEMENT",
                    url: "<%=request.getContextPath()%>/reportManagement/auditReportManagementById?id=" + id+"&name="+name,
                    backUrl: "/reportManagement/complete",
                    requestFlag:requestFlag,
                });
            }
           
        });
    })

    function searchClear() {
        $("#rcDate").val("");
        $("#e_reportType").val("");
        $("#s_nameSel").val("");
        $("#s_nameSel").removeAttr("keycode");
        search()
    }

    function search() {
        var requestDate = $("#rcDate").val();
        var reportType = $("#e_reportType").val();
        var headT = $("#s_nameSel").attr("keycode");
        var person = "";
        if (null == headT){
        } else{
            var personList = headT.split(",");
            person = personList[1];
            var dept = personList[0];
        }
        ccTable.ajax.url("<%=request.getContextPath()%>/reportManagement/getReportManagementCompleteList?requestDate="+requestDate+"&reportType="
            +reportType+"&manager="+person).load();
    }
</script>





