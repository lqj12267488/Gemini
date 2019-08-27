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
                                <input id="dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="jbr"/>

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                        <table id="ITSuppliesRepairGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/ITSuppliesRepair/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/ITSuppliesRepair/getPerson", function (data) {
            $("#jbr").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#jbr").val(ui.item.label);
                    $("#jbr").attr("keycode", ui.item.value);
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
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var deviceid = data.id;
            if (this.id == "examine") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: deviceid,
                    tableName: "T_BG_ITSUPPLIESREPAIR_WF",
                    url: "<%=request.getContextPath()%>/ITSuppliesRepair/auditITSuppliesRepairById?id=" + deviceid,
                    backUrl: "/itsuppliesrepair/complete"
                });
            }
            //反馈
            if (this.id == "feedbackReport") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if (flag == "未反馈" || flag == undefined) {
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_ITSUPPLIESREPAIR_WF",
                        businessId: deviceid,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: deviceid,
                                tableName: "T_BG_ITSUPPLIESREPAIR_WF",
                                backUrl: "/itsuppliesrepair/complete"
                            });
                        }
                    })
                } else {
                    swal({
                        title: "本申请已经完成反馈",
                        type: "error"
                    });
                    //alert("本申请已经完成反馈！");
                }
            }
        });
    });


    function searchclear() {
        $("#dept").attr("keycode", "").val("");
        $("#jbr").attr("keycode", "").val("");

        $("#date").val("");
        search();
    }

    function search() {
        var dept = $("#dept").val();
        if (dept != "") {
            dept = '%' + dept + '%';
        }
        var jbr = $("#jbr").val();
        if (jbr != "") {
            jbr = '%' + jbr + '%';
        }

        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#ITSuppliesRepairGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/itsuppliesrepair/getCompleteList',
                "data": {
                    manager: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "deviceName", "visible": false},
                {"width": "10%", "data": "deviceNameShow", "title": "设备名称"},
                {"width": "10%", "data": "reason", "title": "申请事由"},
                {"width": "8%", "data": "requestDept", "title": "申请部门"},
                {"width": "8%", "data": "manager", "title": "申请人"},
                {"width": "8%", "data": "requestDate", "title": "申请日期"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {"width": "8%", "data": "requestFlag", "title": "请求状态"},
                {"width": "8%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "8%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='examine' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='feedbackReport' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
