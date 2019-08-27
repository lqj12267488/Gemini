<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/26
  Time: 9:54
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
                                <input id="requester"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                        <table id="photographyid" cellpadding="0" cellspacing="0" width="100%"
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
    var hotelStayTable;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/photography/getDept", function (data) {
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
        //申请人员姓名模糊程序下拉显示
        $.get("<%=request.getContextPath()%>/photography/getPerson", function (data) {
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
        })

        search();

        hotelStayTable.on('click', 'tr a', function () {
            var data = hotelStayTable.row($(this).parent()).data();
            var deviceid = data.id;
            //办理
            if (this.id == "transact") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_PHOTOGRAPHY_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: deviceid,
                            tableName: "T_BG_PHOTOGRAPHY_WF",
                            url: "/photography/auditPhotography?id=" + deviceid,
                            backUrl: "/photography/process"
                        });
                    }
                })
            }
            //修改
            if (this.id == "update") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_PHOTOGRAPHY_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: deviceid,
                            tableName: "T_BG_PHOTOGRAPHY_WF",
                            url: "<%=request.getContextPath()%>/photography/editPhotographyProcess?id=" + deviceid,
                            backUrl: "<%=request.getContextPath()%>/photography/process"
                        });
                    }
                })
            }
        });
    });
    //查询条件清空
    function searchclear() {
        $("#dept").val("");
        $("#requester").val("");
        $("#date").val("");
        search();
    }
    //按条件查询
    function search() {
        var dept = $("#dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var requester = $("#requester").val();
        if (requester != "")
            requester = '%' + requester + '%';
        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        hotelStayTable = $("#photographyid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/photography/getPhotographyListProcess',
                "data": {
                    requester: requester,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width": "12%", "data": "shootDate", "title": "拍摄时间"},
                { "width": "10%", "data":"shootingLocation", "title": "拍摄地点"},
                { "width":"10%", "data": "shootingMethod", "title": "拍摄方法"},
                { "width":"18%", "data": "machineNumber", "title": "摄影机机位数"},
                { "width": "11%", "data":"content", "title": "活动内容"},
                { "width":"9%", "data": "requestDept", "title": "申请部门"},
                { "width": "10%", "data": "requester", "title": "申请人"},
                { "width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "10%","title": "操作","render": function () {return "<a id='transact' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='update' class='icon-edit' title='修改'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>



