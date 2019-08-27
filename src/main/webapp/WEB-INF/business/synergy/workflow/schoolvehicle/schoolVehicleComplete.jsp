<%--校内车辆管理已办事项页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/10
  Time: 14:26
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
                                <input id="selDept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="selName"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="selDate" type="date"
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
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    var listTable;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/schoolVehicle/getDept", function (data) {
            $("#selDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selDept").val(ui.item.label);
                    $("#selDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        //申请人员姓名模糊程序下拉显示
        $.get("<%=request.getContextPath()%>/schoolVehicle/getPerson", function (data) {
            $("#selName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selName").val(ui.item.label);
                    $("#selName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "check") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_SCHOOLVEHICLE_WF",
                    url: "<%=request.getContextPath()%>/schoolVehicle/auditSchoolVehicleById?id=" + id,
                    backUrl: "/schoolVehicle/complete"
                });
            }
            //反馈
            if (this.id == "feedback") {
                var data = listTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_SCHOOLVEHICLE_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "error"});
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_SCHOOLVEHICLE_WF",
                                backUrl: "/schoolVehicle/complete"
                            });
                        }
                    })
                }else{
                    swal({
                        title: "本申请已经完成反馈！",
                        type: "info"
                    });
                }
            }
        });
    });
    //查询条件清空
    function searchclear() {
        $("#selDept").val("");
        $("#selName").val("");
        $("#selDate").val("");
        search();
    }
    //按条件查询
    function search() {
        var selDept = $("#selDept").val();
        if (selDept != "")
            selDept = '%' + selDept + '%';
        var selName = $("#selName").val();
        if (selName != "")
            selName = '%' + selName + '%';
        var selDate = $("#selDate").val();
        if (selDate != "") {
            selDate = '%' + selDate + '%';
        }
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/schoolVehicle/getSchoolVehicleCompleteList',
                "data": {
                    requestDept: selDept,
                    requester: selName,
                    requestTime: selDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "13%", "data": "vehicleModel", "title": "车辆品牌及型号"},
                {"width": "10%", "data": "vehicleNum", "title": "车牌号码"},
                {"width": "13%", "data": "vehicleIf", "title": "是否为本人车辆"},
                {"width": "10%", "data": "requestDept", "title": "申请部门"},
                {"width": "8%", "data": "requester", "title": "申请人"},
                {"width": "10%", "data": "requestTime", "title": "申请时间"},
                {"width": "7%", "data": "remark", "title": "备注"},
                {"width": "8%", "data": "requestFlag", "title": "请求状态"},
                {"width": "8%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "8%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "5%","title": "操作",
                    "render": function () {
                        return "<a id='check' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='feedback' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>