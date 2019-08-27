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
                                <select id="typeSelect"/>
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addNotice()">新增
                        </button>
                        <br>
                    </div>
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
<div class="modal modal-draggable" id="modal_default_13" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 60%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">查看</h4>
            </div>
            <div id="concent" class="modal-body clearfix">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_SYS_NOTICE">
<input id="workflowCode" hidden value="T_SYS_NOTICE_WF">
<input id="businessId" hidden>
<input id="loginUser" hidden value="${loginUser}">
<script>
    var noticeTable;
    var loginUser = $("#loginUser").val();

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "typeSelect");
        })
        search();
        noticeTable.on('click', 'tr a', function () {
            var data = noticeTable.row($(this).parent()).data();
            var noticeId = data.id;
            if (this.id == "editNotice") {
                $("#dialog").load("<%=request.getContextPath()%>/getNoticeById?id=" + noticeId);
                $("#dialog").modal("show");
            }

            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + noticeId + '&businessType=TEST&tableName=T_SYS_NOTICE');
                $('#dialogFile').modal('show');
            }
            if (this.id == "noticePublish") {
                //if('${loginDept}'==001006 || '${loginDept}'==001008) {
                if (data.publishFlag == "已发布") {
                    swal({
                        title: "此公告已发布，不可重发发布",
                        type: "error"
                    });
                }
                else {
                    swal({
                        title: "您确定要发布本条公告吗?",
                        text: "公告标题：" + data.title,
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "发布",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/noticePublish", {
                            id: noticeId
                        }, function (msg) {
                            swal({title: "发布成功!", type: "success"});
                            $("#dialog").modal('hide');
                            noticeTable.ajax.reload();
                        });
                    })
                }
            }
            if (this.id == "check") {
                $('#right').load('<%=request.getContextPath()%>/noticePersonList?id=' + noticeId);
                $('#right').modal('show');
            }
            if (this.id == "delNotice") {
                swal({
                    title: "您确定要删除本条公告?",
                    text: "公告标题：" + data.title + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/deleteNoticeById", {
                        id: noticeId
                    }, function (msg) {
                        swal({title: msg.msg, type: msg.result});
                        $("#dialog").modal('hide');
                        noticeTable.ajax.reload();
                    });
                })
            }
        });
    })

    function addNotice() {
        $("#dialog").load("<%=request.getContextPath()%>/addNotice?workflag=0");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function search() {
        var selTitle = $("#selTitle").val();
        var type = $("#typeSelect option:selected").val();
        if (selTitle != "")
            selTitle = '%' + selTitle + '%';

        noticeTable = $("#noticeGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/getNoticeList',
                "data": {
                    title: selTitle,
                    type: type,
                    listType: 1
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "type", "visible": false},
                {"data": "requestFlag", "visible": false},
                {"width": "12%", "data": "creator", "title": "申请人"},
                {"width": "12%", "data": "createDept", "title": "申请部门"},
                {"width": "13%", "data": "publicTime", "title": "申请日期"},
                {"width": "13%", "data": "title", "title": "标题"},
                {"width": "12%", "data": "typeShow", "title": "类型"},
                {"width": "12%", "data": "publishFlag", "title": "发布状态"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        if('已发布'==row.publishFlag){
                                return "<a id='noticePublish' class='icon-arrow-up' title='发布'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='check' class='icon-xing' title='查看已读未读人员'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='delNotice' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                            }
                        if('未发布'==row.publishFlag){
                            return "<a id='noticePublish' class='icon-arrow-up' title='发布'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='editNotice' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                                "<a id='check' class='icon-xing' title='查看已读未读人员'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='delNotice' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"
                            ;
                        }

                    }

                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>