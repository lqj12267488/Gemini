<%--新闻稿发布管理待办事项页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/20
  Time: 13:40
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
                                <input id="requester"
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
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="newsDraftGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var newsDraftTable;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/newsDraft/getDept", function (data) {
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
        //申请人员姓名模糊程序下拉显示
        $.get("<%=request.getContextPath()%>/newsDraft/getPerson", function (data) {
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
        newsDraftTable.on('click', 'tr a', function () {
            var data = newsDraftTable.row($(this).parent()).data();
            var deviceid = data.id;
            //办理
            if (this.id == "transact") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_NEWSDRAFT_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: deviceid,
                            tableName: "T_BG_NEWSDRAFT_WF",
                            url: "/newsDraft/auditNewsDraftById?id=" + deviceid,
                            backUrl: "/newsDraft/process"
                        });
                    }
                })
            }
            //修改
            if (this.id == "update") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_NEWSDRAFT_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: deviceid,
                            tableName: "T_BG_NEWSDRAFT_WF",
                            url: "<%=request.getContextPath()%>/newsDraft/editNewsDraftProcess?id=" + deviceid,
                            backUrl: "<%=request.getContextPath()%>/newsDraft/process"
                        });
                    }
                })
            }
        });
    });
    //查询条件清空
    function searchclear() {
        $("#requestDept").val("");
        $("#requester").val("");
        $("#requestDate").val("");
        search();
    }
    //按条件查询
    function search() {
        var requestDept = $("#requestDept").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        var requester = $("#requester").val();
        if (requester != "")
            requester = '%' + requester + '%';
        var requestDate = $("#requestDate").val();
        if (requestDate != "") {
            requestDate = '%' + requestDate + '%';
        }
        newsDraftTable = $("#newsDraftGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/newsDraft/getNewsDraftProcessList',
                "data": {
                    requester: requester,
                    requestDate: requestDate,
                    requestDept: requestDept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%", "data": "requestDept", "title": "拟稿部门"},
                {"width": "7%", "data": "requester", "title": "拟稿人"},
                {"width": "10%", "data": "requestDate", "title": "拟稿日期"},
                {"width": "16%","data":"newsTitle",
                    "render": function(data,type,row,meta){
                        data = row.newsTitle;
                        return qtip_td(data,type,row,meta,qtip_num,$('#newsDraftGrid tr a'));
                    },"title": "标题"
                },
                {"width": "16%","data":"newsContent",
                    "render": function(data,type,row,meta){
                        data = row.newsContent;
                        return qtip_td(data,type,row,meta,qtip_num,$('#newsDraftGrid tr a'));
                    },"title": "内容"
                },
                {"width": "8%", "data": "auditor", "title": "核稿人"},
                {"width": "10%", "data": "newsType", "title": "新闻稿类型"},
                {"width": "16%","data":"remark",
                    "render": function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#newsDraftGrid tr a'));
                    },"title": "备注"
                },
                {
                    "width": "6%","title": "操作",
                    "render": function () {
                        return "<a id='transact' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='update' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
