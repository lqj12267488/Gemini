<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/21
  Time: 16:42
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
                                销假部门：
                            </div>
                            <div class="col-md-2">
                                <input id="f_dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                销假人：
                            </div>
                            <div class="col-md-2">
                                <input id="f_requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>

                            </div>
                            <div class="col-md-1 tar">
                                销假时间：
                            </div>
                            <div class="col-md-2">
                                <input id="f_date" type="date"
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
                        <table id="leaveCancelGrid" cellpadding="0" cellspacing="0" width="100%"
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

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/leaveCancel/autoCompleteDept", function (data) {
            $("#f_dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_dept").val(ui.item.label);
                    $("#f_dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/leaveCancel/autoCompleteEmployee", function (data) {
            $("#f_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requester").val(ui.item.label);
                    $("#f_requester").attr("keycode", ui.item.value);
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
            var leaveCancelProcessId = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: leaveCancelProcessId,
                    tableName: "T_RS_LEAVE_CANCEL_WF",
                    url: "<%=request.getContextPath()%>/leaveCancel/auditLeaveCancelById?id=" + leaveCancelProcessId,
                    backUrl: "/leaveCancel/complete"
                });
            }
            //反馈
            /*if (this.id == "feedbackReport") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("/getBusinessStatus", {
                        tableName: "T_RS_LEAVE_CANCEL_WF",
                        businessId: leaveCancelProcessId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg)
                        } else {
                            $("#right").load("/getFeedback", {
                                businessId: leaveCancelProcessId,
                                tableName: "T_RS_LEAVE_CANCEL_WF",
                                backUrl: "/leaveCancel/complete"
                            });
                        }
                    })

                }else{
                    alert("本申请已经完成反馈！");
                }
            }*/

        });
    });

    function searchclear() {
        $("#f_dept").val("");
        $("#f_requester").val("");
        $("#f_date").val("");
        search();
    }

    function search() {
        var dept = $("#f_dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#f_requester").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#f_date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#leaveCancelGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/leaveCancel/getCompleteList',
                "data": {
                    cancelRequester: jbr,
                    cancelRequestDate: date,
                    cancelRequestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "cancelRequestDept", "title": "申请销假部门"},
                {"width": "12%","data": "cancelRequester", "title": "申请销假人"},
                {"width": "12%","data": "cancelRequestDate", "title": "申请销假日期"},
                {"width": "12%","data": "cancelStartTime", "title": "销假开始时间"},
                {"width": "12%","data": "cancelEndTime", "title": "销假结束时间"},
                {"width": "10%","data": "realDays", "title": "实际请假天数"},
                {"width": "10%","data": "cancelReason", "title": "销假原因"},
                {"width": "10%","data": "requestFlag", "title": "请求状态"},
                {
                    "width": "10%",  "title": "操作",
                    "render": function () {
                        return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>"
                                /*+"<a id='feedbackReport' class='icon-comments' title='反馈'></a>"*/;
                    }
                },
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>


