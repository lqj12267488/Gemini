<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
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
                                <input id="requestdept" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                经办人：
                            </div>
                            <div class="col-md-2">
                                <input id="manager" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="date"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchComputerProcess()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearComputerProcess()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="computerGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var computerTable;

    $(document).ready(function () {
        searchComputerProcess();

        $.get("<%=request.getContextPath()%>/computer/getDept", function (data) {
            $("#requestdept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestdept").val(ui.item.label);
                    $("#requestdept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/computer/getPerson", function (data) {
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


        computerTable.on('click', 'tr a', function () {
            //查看流程轨迹
            var data = computerTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "handleComputer") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_COMPUTER_WF",
                    url: "<%=request.getContextPath()%>/computer/auditComputerById?id=" + id,
                    backUrl: "/computer/complete"
                });
            }
            //反馈
            if (this.id == "feedbackComputer") {
                var data = computerTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_COMPUTER_WF",
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
                                tableName: "T_BG_COMPUTER_WF",
                                backUrl: "/computer/complete"
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
    function searchclearComputerProcess() {
        $("#requestdept").val("");
        $("#manager").val("");
        $("#requestdate").val("");
        searchComputerProcess();
    }

    function searchComputerProcess() {
        var v_requestdept = $("#requestdept").val();
        if (v_requestdept != "") {
            v_requestdept = '%' + v_requestdept + '%';
        }
        var v_requester = $("#manager").val();
        if (v_requester != "") {
            v_requester = '%' + v_requester + '%';
        }
        var v_requestdate = $("#requestdate").val();
        computerTable = $("#computerGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/complete/computer/searchComputer',
                "data": {
                    requestdate: v_requestdate,
                    manager: v_requester,
                    requestdept: v_requestdept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%","data": "reason", "title": "申请事由"},
                {"data": "suppliesname", "visible": false},
                {"width": "11%","data": "suppliesnameShow", "title": "外设名称"},
                {"width": "11%","data": "requestdept", "title": "申请部门"},
                {"width": "10%","data": "manager", "title": "经办人"},
                {"width": "8%","data": "requestdate", "title": "申请日期"},
                {"width": "8%","data": "remark", "title": "备注"},
                {"width": "11%","data": "requestflag", "title": "请求状态"},
                {"width": "11%","data": "feedbackflag", "title": "反馈状态"},
                {"width": "11%","data": "feedback", "title": "反馈意见"},
                {
                    "width":"8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleComputer' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='feedbackComputer' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>
