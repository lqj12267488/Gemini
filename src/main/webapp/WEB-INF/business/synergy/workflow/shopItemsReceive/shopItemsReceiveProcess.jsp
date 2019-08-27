<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 上午 10:53
  To change this template use File | Settings | File Templates.
--%>
<%-- 代办 首页--%>
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
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="shopItemsReceive" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $.get("<%=request.getContextPath()%>/shopItemsReceive/getPerson", function (data) {
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
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/shopItemsReceive/getDept", function (data) {
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

        search()

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            //修改
            if (this.id == "uShopItemsReceive") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_SHOPITEMSRECEIVE_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: id,
                            tableName: "T_BG_SHOPITEMSRECEIVE_WF",
                            url: "<%=request.getContextPath()%>/shopItemsReceive/auditShopItemsReceiveEdit?id=" + id,
                            backUrl: "<%=request.getContextPath()%>/shopItemsReceive/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleShopItemsReceive") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_SHOPITEMSRECEIVE_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: id,
                            tableName: "T_BG_SHOPITEMSRECEIVE_WF",
                            url: "/shopItemsReceive/auditShopItemsReceiveById?id=" + id,
                            backUrl: "/shopItemsReceive/process"
                        });
                    }
                })
            }

        });
    })

    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_requester").val("");
        $("#e_requestDept").val("");
        search()
    }

    function search() {
        var requestDate = $("#e_requestDate").val();
        if (requestDate != "") {
            requestDate = '%'+requestDate+'%' ;
        }
        var requester = $("#e_requester").val();
        if (requester != "") {
            requester = requester ;
        }
        var requestDept = $("#e_requestDept").val();
        if (requestDept != "") {
            requestDept =  requestDept ;
        }

        roleTable = $("#shopItemsReceive").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/shopItemsReceive/getProcessList',
                "data": {
                    requestDate: requestDate,
                    requester: requester,
                    requestDept: requestDept

                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "requestDept", "title": "申请部门"},
                {"width": "11%", "data": "requester", "title": "申请人"},
                {"width": "11%", "data": "requestDate", "title": "申请日期"},
                {"width": "12%", "data": "standard", "title": "标准(元/人)"},
                {"width": "11%", "data": "peopleNumber", "title": "人数"},
                {"width": "11%", "data": "totalAmount","title": "总金额"},
                {"width": "11%", "data": "use", "title": "用途"},
                {"width": "11%", "data": "remark", "title": "备注"},
                {
                    "width": "11%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleShopItemsReceive' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='uShopItemsReceive' class='icon-edit' title='修改'></a>";
                    }
                },
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

</script>


