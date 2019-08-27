<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 15:40
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="goodsPurchasingBigGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var td_FilesDownName = '点击查看文件';
    var thisFilesID = '';

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/goodsPurchasingBig/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/goodsPurchasingBig/getPerson", function (data) {
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
            var goodsPurchasingBigProcessId = data.id;
            //修改
            if (this.id == "uGoodsPurchasingBigProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_ZW_GOODSPURCHASINGBIG_WF",
                    businessId: goodsPurchasingBigProcessId
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: goodsPurchasingBigProcessId,
                            tableName: "T_ZW_GOODSPURCHASINGBIG_WF",
                            url: "<%=request.getContextPath()%>/goodsPurchasingBig/auditGoodsPurchasingBigEdit?id=" + goodsPurchasingBigProcessId,
                            backUrl: "<%=request.getContextPath()%>/goodsPurchasingBig/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_ZW_GOODSPURCHASINGBIG_WF",
                    businessId: goodsPurchasingBigProcessId
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: goodsPurchasingBigProcessId,
                            tableName: "T_ZW_GOODSPURCHASINGBIG_WF",
                            url: "/goodsPurchasingBig/auditGoodsPurchasingBigById?id=" + goodsPurchasingBigProcessId,
                            backUrl: "/goodsPurchasingBig/process"
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
        roleTable = $('#goodsPurchasingBigGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/goodsPurchasingBig/getGoodsPurchasingBigListProcess',
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
                {
                    "width": "10%", "data": "goodsBigName", "title": "采购物品",
                    "render": function (data, type, row, meta) {
                        if(row.goodsBigName!=null || row.goodsBigName!=undefined || row.goodsBigName!=0){
                            var tt=row.goodsBigName +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "10%","data": "goodsBigNum", "title": "采购数量"},
                {"width": "10%", "data": "unit", "title": "物品单位"},
                {
                    "width": "10%", "data": "reason", "title": "申请事由",
                    "render": function (data, type, row, meta) {
                        if(row.reason!=null || row.reason!=undefined || row.reason!=0){
                            var tt=row.reason +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "11%","data": "budget", "title": "预算(万元)"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "申请人"},
                {
                    "width": "9%", "data": "remark", "title": "备注",
                    "render": function (data, type, row, meta) {
                        if(row.remark!=null || row.remark!=undefined || row.remark!=0){
                            var tt=row.remark +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {
                    "width": "10%","title": "操作",
                    "render": function () {
                        return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"  +
                                "<a id='uGoodsPurchasingBigProcess' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    /*TODO BEGIN*/
    function turnFilesDownload(e) {
        /*if(completeFilesFlag){
            return alert('已经有文件上传过');
        }*/
        $('#dialogFile').load('<%=request.getContextPath()%>/files/lookFiles?personFilesId='+e);
        $('#dialogFile').modal('show');
    }
</script>

