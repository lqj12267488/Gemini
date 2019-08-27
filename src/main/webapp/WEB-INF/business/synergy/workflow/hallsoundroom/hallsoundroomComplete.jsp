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
                                <button type="button" class="btn btn-default btn-clean" onclick="searchHallsoundroom()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclearHallsoundroom()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div>

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
        searchHallsoundroom();
        hallsoundroomTable.on('click', 'tr a', function () {
            //查看流程轨迹
            var data = hallsoundroomTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "handleHallsoundroom") {
                $("#right").load("/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_HALLSOUNDROOM_WF",
                    url: "/hallsoundroom/auditHallsoundroomById?id=" + id,
                    backUrl: "/hallsoundroom/complete"
                });
            }
            //反馈
            if (this.id == "feedbackHallsoundroom") {
                var data = hallsoundroomTable.row($(this).parent()).data();
                var flag = data.feedbackflag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("/getBusinessStatus", {
                        tableName: "T_BG_HALLSOUNDROOM_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg)
                        } else {
                            $("#right").load("/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_HALLSOUNDROOM_WF",
                                backUrl: "/hallsoundroom/complete"
                            });
                        }
                    })

                }else{
                    alert("本申请已经完成反馈！");
                }


            }
        });
    })
    function searchclearHallsoundroom() {
        $("#rdept").attr("keycode","").val("");
        $("#rname").attr("keycode","").val("");
        $("#date").val("");
        searchHallsoundroom();
    }

    function searchHallsoundroom() {
        var v_requestdept = $("#rdept").val();
        if (v_requestdept != "") {
            v_requestdept = '%' + v_requestdept + '%';
        }
        var v_requester = $("#rname").val();
        if (v_requester != "") {
            v_requester = '%' + v_requester + '%';
        }
        var v_requestdate = $("#date").val();
        hallsoundroomTable = $("#hallsoundroomGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '/complete/hallsoundroom/searchHallsoundroom',
                "data": {
                    requestdate: v_requestdate,
                    requester: v_requester,
                    requestdept: v_requestdept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%","data": "meetingcontent", "title": "会议内容"},
                {"width": "9%","data": "starttime", "title": "使用开始时间"},
                {"width": "9%","data": "endtime", "title": "使用结束时间"},
                {"width": "10%","data": "usedevice", "title": "使用设备"},
                {"width": "8%","data": "requestdept", "title": "申请部门"},
                {"width": "9%","data": "requester", "title": "申请人"},
                {"width": "6%","data": "requestdate", "title": "申请日期"},
                {"width": "10%","data": "requestflag", "title": "请求状态"},
                {"width": "10%","data": "feedbackflag", "title": "反馈状态"},
                {"width": "10%","data": "feedback", "title": "反馈意见"},
                {
                    "width": "9 %",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleHallsoundroom' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='feedbackHallsoundroom' class='icon-comments' title='反馈'></a>";
                    }
                }

            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>
