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
                                <input id="rdept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="rname" />

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
                        <table id="hallsoundroomGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var hallsoundroomTable;
    $(document).ready(function () {

        $.get("/hallsoundroom/getDept", function (data) {
            $("#rdept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rdept").val(ui.item.label);
                    $("#rdept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("/hallsoundroom/getPerson", function (data) {
            $("#rname").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rname").val(ui.item.label);
                    $("#rname").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();

        hallsoundroomTable.on('click', 'tr a', function () {
            var data = hallsoundroomTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "transact") {
                $.post("/getRejectState", {
                    tableName: "T_BG_HALLSOUNDROOM_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        alert(msg.msg)
                    } else {
                        $("#right").load("/toAudit", {
                            businessId: id,
                            tableName: "T_BG_HALLSOUNDROOM_WF",
                            url: "/hallsoundroom/auditHallsoundroomById?id=" + id,
                            backUrl: "/hallsoundroom/process"
                        });
                    }
                })
            }
            if (this.id == "update") {
                $.post("/getStartState", {
                    tableName: "T_BG_HALLSOUNDROOM_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        alert(msg.msg)
                    } else {
                        $("#right").load("/toEditBusiness", {
                            businessId: id,
                            tableName: "T_BG_HALLSOUNDROOM_WF",
                            url: "/hallsoundroom/HallsoundroomUpdateById?id=" + id,
                            backUrl: "/hallsoundroom/process"
                        });
                    }
                })

            }
        });
    });


    function searchclear() {
        $("#rdept").attr("keycode","").val("");
        $("#rname").attr("keycode","").val("");
        $("#date").val("");
        search();
    }

    function search() {
        var dept = $("#rdept").val();
        if (dept != "") {
            dept ='%' + dept + '%';
        }
        var jbr = $("#rname").val();
        if (jbr != "") {
            jbr = '%' + jbr + '%';
        }

        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        hallsoundroomTable = $("#hallsoundroomGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '/hallsoundroom/getProcessList',
                "data": {
                    requester: jbr,
                    requestdate: date,
                    requestdept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "13%","data": "meetingcontent", "title": "会议内容"},
                {"width": "13%","data": "starttime", "title": "使用开始时间"},
                {"width": "13%","data": "endtime", "title": "使用结束时间"},
                {"width": "12%","data": "usedevice", "title": "使用设备"},
                {"width": "12%","data": "requestdept", "title": "申请部门"},
                {"width": "12%","data": "requester", "title": "申请人"},
                {"width": "13%","data": "requestdate", "title": "申请日期"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='transact' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='update' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>

