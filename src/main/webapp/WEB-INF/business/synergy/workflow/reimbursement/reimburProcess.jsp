<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:02
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
                                <input id="rdept"
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
                                <input id="rdate" type="date"
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
<input id="r_id" hidden value="${reimbursement.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/reimbursement/printFunds?id=${reimbursement.id}">
<script>
    var tableName="T_BG_REIMBURSEMENT_WF";
    var workflowCode="T_BG_REIMBURSEMENT_WF01";
    var reimbursementGrid;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/camera/getDept", function (data) {
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
        //申请人员姓名模糊程序下拉显示
        $.get("<%=request.getContextPath()%>/camera/getPerson", function (data) {
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

        reimbursementGrid = $("#reimbursementGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/reimbursement/getReimbursementProcess',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width": "15%", "data":"rcause", "title": "报销事由"},
                { "width":"15%", "data": "content", "title": "报销内容"},
                { "width":"14%", "data": "money", "title": "报销金额"},
                { "width":"14%", "data": "requestDept", "title": "申请部门"},
                { "width": "14%", "data":"requester", "title": "申请人"},
                { "width": "14%", "data":"requestDate", "title": "申请日期"},
                {
                    "width": "14%","title": "操作","render":
                    function () {
                        return "<a id='transact' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='relationAssociation' class='icon-exchange' title='查看已关联的事物'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='update' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
        reimbursementGrid.on('click', 'tr a', function () {
            var data = reimbursementGrid.row($(this).parent()).data();
            var deviceid = data.id;
            //办理
            if (this.id == "transact") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_REIMBURSEMENT_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: deviceid,
                            tableName: "T_BG_REIMBURSEMENT_WF",
                            url: "/reimbursement/auditReimbursement?id=" + deviceid,
                            backUrl: "/reimbursement/reimbursementProcess"
                        });
                    }
                })
            }
            /*关联业务*/
            if (this.id == "relationAssociation") {
                $("#right").load("<%=request.getContextPath()%>/association/associtionList?id=" + deviceid+"&type=1" +"&tableName="+tableName
                    +"&workflowCode="+workflowCode+"&backUrl="+"/reimbursement/reimbursementProcess");
            }
            //修改
            if (this.id == "update") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_REIMBURSEMENT_WF",
                    businessId: deviceid,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: deviceid,
                            tableName: "T_BG_REIMBURSEMENT_WF",
                            url: "<%=request.getContextPath()%>/reimbursement/editReimbursementProcess?id=" + deviceid,
                            backUrl: "<%=request.getContextPath()%>/reimbursement/reimbursementProcess"
                        });
                    }
                })
            }
        });
    });
    //查询条件清空
    function searchclear() {
        $("#rdept").val("");
        $("#requester").val("");
        $("#rdate").val("");
        search();
    }
    //按条件查询
    function search() {
        var requestDate = $("#rdate").val();
        var requester = $("#requester").val();
        var requestDept = $("#rdept").val();
        reimbursementGrid.ajax.url("<%=request.getContextPath()%>/reimbursement/getReimbursementProcess?requestDate="+requestDate+ "&requester="+requester +"&requestDept="+requestDept).load();
    }
</script>


