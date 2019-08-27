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
<input id="tableName" hidden value="T_SYS_NOTICE">
<input id="workflowCode" hidden value="T_SYS_NOTICE_WF">
<input id="businessId" hidden>
<script>
    var noticeTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "typeSelect");
        })
        search();
        /*$("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
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
            if (this.id == "check") {
                $('#right').load('<%=request.getContextPath()%>/noticePersonList?id=' + noticeId);
                $('#right').modal('show');
            }
            //提交
            if (this.id == "submitNotice") {
                $("#businessId").val(noticeId);
                getAuditer();
            }
            if (this.id == "delNotice") {
                //if (confirm("确定要撤销此公告？")) {
                swal({
                    title: "确定要撤销此公告?",
                    text: "公告标题：" + data.title + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/deleteNoticeById?id=" + noticeId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            noticeTable.ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addNotice() {
        $("#dialog").load("<%=request.getContextPath()%>/addNotice?workflag=1");
        $("#dialog").modal("show");
    }

    /*动态弹窗选择审批人*/
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer");
    }

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_SYS_NOTICE",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#noticeGrid').DataTable().ajax.reload();
                }
            })
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
                "url": '<%=request.getContextPath()%>/notice/getNoticeRequest',
                "data": {
                    title: selTitle,
                    type: type
                }
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
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editNotice' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            //"<a id='check' class='icon-xing' title='查看已读未读人员'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submitNotice' class='icon-upload-alt' title='提交'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delNotice' class='icon-archive' title='撤销'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>