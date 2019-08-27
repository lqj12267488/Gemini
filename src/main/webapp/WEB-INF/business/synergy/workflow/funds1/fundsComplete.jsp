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
                                <input id="e_manager" type=""
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
                        <table id="funds1" cellpadding="0" cellspacing="0"
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
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/funds1/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/funds1/getPerson", function (data) {
            $("#e_manager").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#e_manager").val(ui.item.label);
                    $("#e_manager").attr("keycode", ui.item.value);
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
            var id = data.id;
            if (this.id == "handleFunds") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_FUNDS1_WF",
                    url: "<%=request.getContextPath()%>/funds1/auditFundsById?id=" + id,
                    backUrl: "/funds1/complete"
                });
            }
            if (this.id == "relationFunds") {
                $("#right").load("<%=request.getContextPath()%>/funds1/relationRequest?id=" + id +"&type=2");
            }

            //反馈
            if (this.id == "addFundsComplete") {


                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_FUNDS1_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_FUNDS1_WF",
                                backUrl: "/funds1/complete"
                            });
                        }
                    })

                }else{
                    swal({
                        title: "本申请已经完成反馈",
                        type: "info"
                    });
                    //alert("本申请已经完成反馈！");
                }


            }
        });
    })

    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_requestDept").val("");
        $("#e_manager").val("");
        search()
    }

    function search() {
        var requestDate = $("#e_requestDate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';
        var requestDept = $("#e_requestDept").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        var manager = $("#e_manager").val();
        if (manager != "")
            manager = '%' + manager + '%';
        roleTable = $('#funds1').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/funds1/getFundsListComplete',
                "data": {
                    requestDate: requestDate,
                    requestDept: requestDept,
                    manager : manager
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%", "data": "reason", "title": "申请原因"},
                {"width": "9%", "data": "amount", "title": "小写金额"},
                {"width": "9%", "data": "amountUpper", "title": "大写金额"},
                {"width": "9%", "data": "requestDept", "title": "申请部门"},
                {"width": "9%", "data": "manager", "title": "申请人"},
                {"width": "9%", "data": "requestDate", "title": "申请日期"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {"width": "10%", "data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleFunds' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='relationFunds' class='icon-exchange' title='查看已关联的事物'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addFundsComplete' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],

            "dom": 'rtlip',
            language: language
        });

    }
</script>

