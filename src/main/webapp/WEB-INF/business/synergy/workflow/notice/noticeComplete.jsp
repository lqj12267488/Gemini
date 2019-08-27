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
                                标题：
                            </div>
                            <div class="col-md-2">
                                <input id="selTitle" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                类型：
                            </div>
                            <div class="col-md-2">
                                <select id="typeSelect" />
                            </div>
                            <%--<div class="col-md-1 tar">
                                角色类型
                            </div>
                            <div class="col-md-2">
                                <select class="select2" id="searchreroletype"></select>
                            </div>--%>
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
                    <%--<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addNotice()">新增
                        </button>
                        <br>
                    </div>--%>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="noticeGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_SYS_NOTICE">
<input id="workflowCode" hidden value="T_SYS_NOTICE_WF">
<input id="businessId" hidden>
<script>
    var noticeTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "typeSelect");
        })
        noticeTable = $("#noticeGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/notice/listComplete'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "type", "visible": false},
                {"width": "12%", "data": "creator", "title": "申请人"},
                {"width": "12%", "data": "createDept", "title": "申请部门"},
                {"width": "13%", "data": "publicTime", "title": "申请日期"},
                {"width": "13%", "data": "title", "title": "标题",
                    "render": function (data, type, row, meta) {
                        if(row.title!=null || row.title!=undefined || row.title!=0){
                            var ss=row.title +"";
                            return "<span title='" + ss + "'>" + ss.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "12%", "data": "typeShow", "title": "类型"},
                {"width": "12%", "data": "publishFlag", "title": "发布状态"},
                {
                    "width": "14%", "data": "content", "title": "内容",
                    "render": function (data, type, row, meta) {
                        if(row.content!=null || row.content!=undefined || row.content!=0){
                            var tt=row.content +"";
                            return "<span title='" + tt + "'>" + tt.substr(0,10) + "</span>";
                        }
                    }
                },
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"
                                /*"<a id='feedbackReport' class='icon-comments' title='反馈'></a>"*/;
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
        noticeTable.on('click', 'tr a', function () {
            var data = noticeTable.row($(this).parent()).data();
            var noticeId = data.id;
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: noticeId,
                    tableName: "T_SYS_NOTICE",
                    url: "<%=request.getContextPath()%>/notice/auditNotice?id=" + noticeId,
                    backUrl: "/notice/complete"
                });
            }
            if (this.id == "feedbackReport") {
                var data = noticeTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_SYS_NOTICE",
                        businessId: noticeId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "info"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: noticeId,
                                tableName: "T_SYS_NOTICE",
                                backUrl: "/notice/complete"
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

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function search() {
        var seltitle=$("#selTitle").val();
        var seltype=$("#typeSelect option:selected").val();
        noticeTable.ajax.url("<%=request.getContextPath()%>/notice/listComplete?title="+seltitle+ "&type="+seltype).load();
    }
</script>