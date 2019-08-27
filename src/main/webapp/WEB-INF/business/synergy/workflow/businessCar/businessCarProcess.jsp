<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:55
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
                                <input id="e_requestDept" type="text"
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
                        <table id="businessCarGrid" cellpadding="0" cellspacing="0"
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
        $.get("<%=request.getContextPath()%>/businessCar/getDept", function (data) {
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
        $.get("<%=request.getContextPath()%>/businessCar/getPerson", function (data) {
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
            var businessCarProcessId = data.id;
            //修改
            if (this.id == "uBusinessCar") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_BUSINESSCAR_WF",
                    businessId: businessCarProcessId ,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: businessCarProcessId ,
                            tableName: "T_BG_BUSINESSCAR_WF",
                            url: "<%=request.getContextPath()%>/businessCar/auditBusinessCarEdit?id=" + businessCarProcessId ,
                            backUrl: "<%=request.getContextPath()%>/businessCar/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleBusinessCar") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_BUSINESSCAR_WF",
                    businessId: businessCarProcessId ,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: businessCarProcessId ,
                            tableName: "T_BG_BUSINESSCAR_WF",
                            url: "/businessCar/auditBusinessCarById?id=" + businessCarProcessId ,
                            backUrl: "/businessCar/process"
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

        roleTable = $("#businessCarGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/businessCar/getProcessList',
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
                {"width": "8%", "data": "requestDept", "title": "申请部门"},
                {"width": "8%", "data": "requester", "title": "申请人"},
                {"width": "8%", "data": "requestDate", "title": "申请日期"},
                {"width": "9%", "data": "startTime", "title": "起始时间"},
                {"width": "9%", "data": "endTime", "title": "结束时间"},
                {"width": "8%", "data": "startPlace", "title": "始发地"},
                {"width": "8%", "data": "endPlace", "title": "目的地"},
                {"data": "carType", "visible": false},
                {"width": "7%", "data": "carTypeShow", "title": "用车类型"},
                {"width": "9%", "data": "reason","title": "申请事由"},
                {"width": "8%", "data": "peopleNum", "title": "人数"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleBusinessCar' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='uBusinessCar' class='icon-edit' title='修改'></a>";
                    }
                },
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

</script>



