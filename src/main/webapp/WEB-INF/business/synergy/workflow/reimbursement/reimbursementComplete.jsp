<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:03
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
                                <input id="requestDept"
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
                                <input id="requestDate" type="date"
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
                        <table id="reimbursementGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var tableName="T_BG_REIMBURSEMENT_WF";
    var workflowCode="T_BG_REIMBURSEMENT_WF01";
    var reimbursementTable;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/reimbursement/getDept", function (data) {
            $("#requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestDept").val(ui.item.label);
                    $("#requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        //申请人员姓名模糊程序
        $.get("<%=request.getContextPath()%>/reimbursement/getPerson", function (data) {
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

        reimbursementTable = $("#reimbursementGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/reimbursement/getReimbursementComplete',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width":"10%", "data": "rcause","title": "报销事由"},
                { "width": "10%", "data": "content", "title": "报销内容"},
                { "width":"12%", "data": "money", "title": "报销金额"},
                { "width":"10%", "data": "requestDept", "title": "申请部门"},
                { "width": "10%", "data": "requester", "title": "申请人"},
                { "width": "9%", "data": "requestDate", "title": "申请日期"},
                {"width": "9%", "data": "requestFlag", "title": "请求状态"},
                {"width": "9%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedBack", "title": "反馈意见"},
                {"width": "11%","title": "操作","render": function () {return "<a id='seReimbursement' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='relationAssociation' class='icon-exchange' title='查看已关联的事物'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delRole' class='icon-comments' title='反馈'></a>";}}
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
        reimbursementTable.on('click', 'tr a', function () {
            var data = reimbursementTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "seReimbursement") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_REIMBURSEMENT_WF",
                    url: "<%=request.getContextPath()%>/reimbursement/auditReimbursement?id=" + id,
                    backUrl: "/reimbursement/reimbursementComplete"
                });
            }
            /*关联业务*/
            if (this.id == "relationAssociation") {
                $("#right").load("<%=request.getContextPath()%>/association/associtionList?id=" + id+"&type=2" +"&tableName="+tableName
                    +"&workflowCode="+workflowCode+"&backUrl="+"/reimbursement/reimbursementComplete");
            }
            //反馈
            if (this.id == "delRole") {
                var data = reimbursementTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_REIMBURSEMENT_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "error"});
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_REIMBURSEMENT_WF",
                                backUrl: "<%=request.getContextPath()%>/reimbursement/reimbursementComplete"
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
    });
    //查询条件清空
    function searchclear() {
        $("#requestDate").val("");
        $("#requester").val("");
        $("#requestDept").val("");
        search();
    }
    //按条件查询
    function search() {
        var requestDate = $("#requestDate").val();
        var requester = $("#requester").val();
        var requestDept = $("#requestDept").val();
        reimbursementTable.ajax.url("<%=request.getContextPath()%>/reimbursement/getReimbursementComplete?requestDate="+requestDate+ "&requester="+requester +"&requestDept="+requestDept).load();
    }
</script>


