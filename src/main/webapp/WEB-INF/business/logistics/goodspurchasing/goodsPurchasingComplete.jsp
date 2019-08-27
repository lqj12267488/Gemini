<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 15:41
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
                                <input id="requester" />
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
                        <table id="goodsPurchasingGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/goodsPurchasing/printGoodsPurchasing?id=${goodsPurchasing.id}">
<script>
    var goodsPurchasingTable;
    var td_FilesDownName = '查看';

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/goodsPurchasing/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/goodsPurchasing/getPerson", function (data) {
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
        });
        search();
        goodsPurchasingTable.on('click', 'tr a', function () {
            var data = goodsPurchasingTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_ZW_GOODSPURCHASING_WF",
                    url: "<%=request.getContextPath()%>/goodsPurchasing/auditGoodsPurchasingById?id=" + id,
                    backUrl: "/goodsPurchasing/complete"
                });
            }
            //分配至资产
            if(this.id=="feedbackAssets"){
                // alert(data.requestFlag);
                if(data.requestFlag=="已办理") {
                    $.post("<%=request.getContextPath()%>/goodsPurchasing/checkName",{
                        id:id
                    },function(msg){
                        if(msg.status == 1){
                            swal({title: "同一个采购物品不可多次分配至资产!", type: "error"});
                            return;
                        }else{
                            $("#dialog").load("<%=request.getContextPath()%>/goodsPurchasing/backSetAssets?id=" + id);
                            $("#dialog").modal("show");
                        }

                    })

                }else {
                    swal({
                        title: "本申请只有已办理，才可分配至资产管理中!",
                        type: "error"
                    });
                }
            }
            //反馈
            if (this.id == "feedbackReport") {
                var data = goodsPurchasingTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_ZW_GOODSPURCHASING_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_ZW_GOODSPURCHASING_WF",
                                backUrl: "/goodsPurchasing/complete"
                            });
                        }
                    })

                }else{
                    swal({
                        title: "本申请已经完成反馈!",
                        type: "error"
                    });

                }

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
        var dept = $("#dept").val();
        var requester = $("#requester").val();
        if (dept != "")
            dept = '%' + dept + '%';
        if (requester != "")
            requester = '%' + requester + '%';
        var requestDate = $("#date").val();
        if (requestDate != "")
            requestDate = '%'+ requestDate +'%';
        goodsPurchasingTable = $('#goodsPurchasingGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/goodsPurchasing/getGoodsPurchasingListComplete',
                "data": {
                    requestDept: dept,
                    requester: requester,
                    requestDate:requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "8%","data": "goodsName","title": "采购物品"},
                {"width": "8%","data": "goodsNum","title": "采购数量"},
                {"width": "8%","data": "reason","title": "申请事由"
                },
                {"width": "11%","data": "budget","title": "预算(万元)"},
                {"width": "8%","data": "requestDate","title": "申请日期"},
                {"width": "8%","data": "requestDept","title": "申请部门"},
                {"width": "8%","data": "requester","title": "申请人"},
                {"width": "6%","data": "remark", "title": "备注"
                },
                {"width": "8%", "data": "requestFlag","title": "请求状态"},
                {"width": "8%", "data": "feedbackFlag",
                    // "render": function(data,type,row,meta){
                    //     data = row.feedbackFlag;
                    //     qtip_num = 3;
                    //     return qtip_td(data,type,row,meta,qtip_num,$('#goodsPurchasingGrid tr a'));
                    // },
                    "title": "反馈状态"},
                {"width": "8%", "data": "feedback",
                    // "render": function(data,type,row,meta){
                    //     data = row.feedback;
                    //     qtip_num = 3;
                    //     return qtip_td(data,type,row,meta,qtip_num,$('#goodsPurchasingGrid tr a'));
                    // },
                    "title": "反馈意见"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='feedbackReport' class='icon-comments' title='反馈'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='feedbackAssets' class='icon-share' title='分配至资产'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function turnFilesDownload(e) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/lookFiles?personFilesId='+e);
        $('#dialogFile').modal('show');
    }
</script>









