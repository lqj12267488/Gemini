<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/29
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%-- 申请人确认首页--%>
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
<div class="container" >
    <div class="row" >
        <div class="col-md-12" >
            <div class="block" >
                <div class="block block-drop-shadow" >
                    <div class="content block-fill-white" >
                        <div class="form-row" >
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
                            <div class="col-md-2" >
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content" >
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="businessCar" cellpadding="0" cellspacing="0"
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
            var id = data.id;
            var flag = data.requesterConfirmFlag;
            if (this.id == "handleBusinessCar") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_BUSINESSCAR_WF",
                    url: "<%=request.getContextPath()%>/businessCar/auditBusinessCarById?id=" + id,
                    backUrl: "<%=request.getContextPath()%>/businessCar/requester"
                });
            }
            //确认
            if (this.id == "delBusinessCar") {
                if(flag == "未确认" || flag == undefined){
                    swal({
                        title: "申请人确定要确认吗?",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "green",
                        confirmButtonText: "确认",
                        closeOnConfirm: false
                    }, function () {
                        $.get("<%=request.getContextPath()%>/businessCar/updateBusinessCarMessage?id=" + id, function (msg) {
                            if (msg.status == 1) {
                                swal({title: msg.msg, type: "success"});
                                $('#businessCar').DataTable().ajax.reload();
                            }
                        })
                    })
                }else{
                    swal({
                        title: "本申请已经完成确认！",
                        type: "info"
                    });
                }

            }
        });
    })
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
        roleTable = $("#businessCar").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/businessCar/getBusinessCarListOne',
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
                {"width": "6%", "data": "requestDept", "title": "申请部门"},
                {"width": "6%", "data": "requester", "title": "申请人"},
                {"width": "7%", "data": "requestDate", "title": "申请日期"},
                {"width": "9%", "data": "useType", "title": "用车方式"},
                {"width": "9%", "data": "carCost", "title": "用车费用"},
                {"width": "9%", "data": "hireCompany", "title": "租用公司"},
                {"width": "8%", "data": "carManager", "title": "检查员"},
                {"width": "9%", "data": "checkTime", "title": "检查时间"},
                {"width": "11%", "data": "carManagerDept", "title": "检查员部门"},
                {"width": "9%", "data": "checkFlag", "title": "检查状态"},
                {"width": "9", "data": "requesterConfirmFlag", "title": "确认状态"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='handleBusinessCar' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delBusinessCar' class='icon-check' title='确认'></a>";
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

