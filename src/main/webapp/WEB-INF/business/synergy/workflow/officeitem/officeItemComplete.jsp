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
                        <table id="officeItem" cellpadding="0" cellspacing="0"
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
        $.get("<%=request.getContextPath()%>/officeItem/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/officeItem/getPerson", function (data) {
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

        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "handleOfficeItem") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_OFFICEITEM_WF",
                    url: "<%=request.getContextPath()%>/officeItem/auditOfficeItemById?id=" + id,
                    backUrl: "/officeItem/complete"
                });
            }
            //反馈
            if (this.id == "delOfficeItem") {
                var data = roleTable.row($(this).parent()).data();
                var flag =  data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_OFFICEITEM_WF",
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
                                tableName: "T_BG_OFFICEITEM_WF",
                                backUrl: "/officeItem/complete"
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
    })

    function addOfficeItem() {
        $("#dialog").load("<%=request.getContextPath()%>/officeItem/addOfficeItem");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_requestDept").val("");
        $("#e_requester").val("");

        search()
    }

    function search() {
        var e_requestDate = $("#e_requestDate").val();
        if (e_requestDate != "")
            e_requestDate =  '%'+e_requestDate+'%' ;
        var requestDept = $("#e_requestDept").val();
        if (requestDept != "")
            requestDept =  requestDept ;
        var requester = $("#e_requester").val();
        if (requester != "")
            requester =  requester;
        roleTable = $("#officeItem").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/officeItem/getOfficeItemListComplete',
                "data": {
                    requestDate: e_requestDate,
                    requestDept: requestDept,
                    requester: requester
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "itemName", "title": "物品名称"},
                {"width": "8%", "data": "itemNumber", "title": "数量"},
                {"width": "9%", "data": "requestDept", "title": "申请部门"},
                {"width": "9%", "data": "requester", "title": "申请人"},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "10%", "data": "remark", "title": "备注"},
                {"width": "11%", "data": "requestFlag", "title": "请求状态"},
                {"width": "11%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "11%", "data": "feedback", "title": "反馈意见"},

                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleOfficeItem' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delOfficeItem' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        /* $("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
    }

</script>

