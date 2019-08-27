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
                                <input id="requestdept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="requester"/>

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="date"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <%--     <div class="form-row">
                             <button type="button" class="btn btn-default btn-clean" onclick="addSoftInstall()">
                                 新增
                             </button>
                             <br>
                         </div>--%>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="softInstallGrid" cellpadding="0" cellspacing="0"
                               width="100%"
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

        $.get("<%=request.getContextPath()%>/softInstall/getDept", function (data) {
            $("#requestdept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestdept").val(ui.item.label);
                    $("#requestdept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/softInstall/getPerson", function (data) {
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

        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var softid = data.id;
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: softid,
                    tableName: "T_BG_SOFTINSTALL_WF",
                    url: "<%=request.getContextPath()%>/softInstall/auditEdit?id=" + softid,
                    backUrl: "/softInstall/complete"
                });
            }
            if (this.id == "feedbackReport") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_SOFTINSTALL_WF",
                        businessId: softid,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: softid,
                                tableName: "T_BG_SOFTINSTALL_WF",
                                backUrl: "/softInstall/complete"
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
    function addSoftInstall() {
        $("#dialog").load("<%=request.getContextPath()%>/softInstall/addSoftInstall");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#requestdept").attr("keycode","");
        $("#requester").attr("keycode","");
        $("#requestdate").val("");
        $("#requestdept").val("");
        $("#requester").val("");
        search();
    }

    function search() {
        var v_requestdept = $("#requestdept").val();
        if (v_requestdept != ""||v_requestdept!=undefined) {
            v_requestdept = '%' + v_requestdept + '%';
        }

        var v_requester = $("#requester").val();
        if (v_requester != "" || v_requester!=undefined) {
            v_requester = '%' + v_requester + '%';
        }
        if(v_requester=='undefined'){
            v_requester ='';
        }
        var v_requestdate = $("#requestdate").val();
        if(v_requestdate!=''){
            v_requestdate ='%' + v_requestdate + '%';
        }
        roleTable = $("#softInstallGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/softInstall/searchSoftInstallComplete',
                "data": {
                    requestDate: v_requestdate,
                    requester: v_requester,
                    requestDept: v_requestdept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "softName", "title": "软件名称"},
                {"width": "10%", "data": "requester", "title": "申请人"},
                {"width": "11%", "data": "requestDept", "title": "申请部门"},
                {"width": "11%", "data": "requestDate", "title": "申请日期"},
                {"width": "17%", "data": "reason", "title": "安装原因"},
                {"width": "11%", "data": "requestFlag", "title": "请求状态"},
                {"width": "11%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "11%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "7%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='feedbackReport' class='icon-comments' title='反馈'></a>"
                                /*     "<a id='addRelation' class='icon-sitemap' title='授权人员'></a>&nbsp;&nbsp;&nbsp;"+
                                 "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";*/;
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
        /* $("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/

    }
</script>
<%--
<style>
    .sorting{
        width: 10% !important;
    }
</style>--%>
