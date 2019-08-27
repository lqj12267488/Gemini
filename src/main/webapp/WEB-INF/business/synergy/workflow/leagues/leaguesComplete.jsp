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
                                <input id="e_manager" type=""
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
                        <table id="leaguesTable" cellpadding="0" cellspacing="0"
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
    var leaguesTable;
    var tableName="T_BG_LEAGUE_WF";
    var workflowCode="T_BG_LEAGUE_WF01";

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/leagues/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/leagues/getPerson", function (data) {
            $("#e_manager").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#e_manager").val(ui.item.label);
                    $("#e_manager").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        leaguesTable = $("#leaguesTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/leagues/getLeagueListComplete',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%", "data": "reason", "title": "申请原因"},
                {"width": "9%", "data": "amount", "title": "小写金额"},
                {"width": "9%", "data": "amountUpper", "title": "大写金额"},
                {"width": "9%", "data": "requestDept", "title": "申请部门"},
                {"width": "9%", "data": "manager", "title": "申请人"},
                {"width": "9%", "data": "requestDate", "title": "申请日期"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {"width": "10%", "data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleLeagues' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='relationLeagues' class='icon-exchange' title='查看已关联的事物'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addLeaguesComplete' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        /*$("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
        leaguesTable.on('click', 'tr a', function () {
            var data = leaguesTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "handleLeagues") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_LEAGUE_WF",
                    url: "<%=request.getContextPath()%>/leagues/auditLeaguesById?id=" + id,
                    backUrl: "/leagues/complete"
                });
            }
            /*关联业务*/
            if (this.id == "relationLeagues") {
                $("#right").load("<%=request.getContextPath()%>/association/associtionList?id=" + id+"&type=2" +"&tableName="+tableName
                    +"&workflowCode="+workflowCode+"&backUrl="+"/leagues/complete");
            }

            //反馈
            if (this.id == "addLeaguesComplete") {
                var data = leaguesTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_LEAGUE_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_LEAGUE_WF",
                                backUrl: "/leagues/complete"
                            });
                        }
                    })

                }else{
                    swal({
                        title: "本申请已经完成反馈",
                        type: "info"
                    });
                    //alert("本申请已经完成反馈！");
                }


            }
        });
    })

    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_requestDept").val("");
        $("#e_manager").val("");
        search()
    }

    function search() {
        leaguesTable.ajax.url("<%=request.getContextPath()%>/leagues/getLeagueListComplete?requestDate="
            +$("#e_requestDate").val()+"&requestDept="+$("#e_requestDept").val()+"&manager="+$("#e_manager").val()).load();
    }
</script>

