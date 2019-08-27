<%--资产报废管理已办事项页面
  Created by IntelliJ IDEA.
  User: wq
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
                                <input id="requestDept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="manager"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestDate" type="date"
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
                        <table id="softInstallGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    var roleTable;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/assetsScrap/selectDept", function (data) {
            $("#requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestDept").val(ui.item.label);
                    $("#requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/assetsScrap/getPerson", function (data) {
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
            var assetsId = data.id;
            //查看流程轨迹
            if (this.id == "uRole") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: assetsId,
                    tableName: "T_BG_ASSETSSCRAP_WF",
                    url: "<%=request.getContextPath()%>/assetsScrap/auditAssetsById?id=" + assetsId,
                    backUrl: "/assetsscrap/requestComplete"
                });
            }
            //反馈
            if (this.id == "delRole") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_ASSETSSCRAP_WF",
                        businessId: assetsId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: assetsId,
                                tableName: "T_BG_ASSETSSCRAP_WF",
                                backUrl: "/assetsscrap/requestComplete"
                            });
                        }
                    })
                }else{
                    swal({
                        title: "本申请已经完成反馈！",
                        type: "error"
                    });
                }
            }
        });
    });
    function searchclear() {
        $("#requestDate").val("");
        $("#manager").val("");
        $("#requestDept").val("");
        search();
    }

    function search() {
        var requestDept = $("#requestDept").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        var manager = $("#manager").val();
        if (manager != "")
            manager = '%' + manager + '%';
        var requestDate = $("#requestDate").val();
        if (requestDate != "") {
            requestDate = '%' + requestDate + '%';
        }
        roleTable = $("#softInstallGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/assetsScrap/getCompleteList',
                "data": {
                    manager: manager,
                    requestDate: requestDate,
                    requestDept: requestDept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
               /* {"width": "10%", "data": "assetsId", "title": "资产编号"},*/
                {"width": "10%", "data": "assetsName", "title": "资产名称"},
                {"width": "10%", "data": "reason", "title": "报废原因"},
                {"width": "10%", "data": "requestDept", "title": "申请部门"},
                {"width": "10%", "data": "manager", "title": "经办人"},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "7%", "data": "remark", "title": "备注"},
                {"width": "8%", "data": "requestFlag", "title": "请求状态"},
                {"width": "8%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedBack", "title": "反馈意见"},
                {"width": "7%","title": "操作","render": function () {return "<a id='uRole' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delRole' class='icon-comments' title='反馈'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

