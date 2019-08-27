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
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class= "mainBodyClass">
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
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addMessage()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="messageGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_SYS_MESSAGE">
<input id="workflowCode" hidden value="T_SYS_MESSAGE_WF">
<input id="businessId" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var messageTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TZLX", function (data) {
            addOption(data, "typeSelect");
        })
        search();
        messageTable.on('click', 'tr a', function () {
            data = messageTable.row($(this).parent()).data();
            var messageId = data.id;
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + messageId + '&businessType=TEST&tableName=T_SYS_MESSAGE');
                $('#dialogFile').modal('show');
            }
            if (this.id == "editMessage") {
                $("#dialog").load("<%=request.getContextPath()%>/editMessage?id="+messageId);
                $("#dialog").modal("show");
            }
            if (this.id == "check"){
                $('#right').load('<%=request.getContextPath()%>/messagePersonList?id='+messageId);
                $('#right').modal('show');
            }
            //提交
            if (this.id == "submitNotice") {
                $("#businessId").val(messageId);
                getAuditer();
            }
            if (this.id == "delMessage") {
                //if (confirm("确定要删除此通知?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "通知标题："+data.title+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/deleteMessage?id=" + messageId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            messageTable.ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addMessage() {
        $("#dialog").load("<%=request.getContextPath()%>/addMessage?workflag=1");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }
    /*动态弹窗选择审批人*/
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer");
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
        showSaveLoadingByClass(".saveBtnClass button");
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_SYS_MESSAGE",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                hideSaveLoadingByClass(".saveBtnClass button");
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    //$("#dialog").modal().load("<%=request.getContextPath()%>/message/updatePublishFlag?id="+$("#businessId").val())
                    $("#dialog").modal("hide");
                    $('#messageGrid').DataTable().ajax.reload();
                }
            })
    }
    function search() {
        var selTitle =  $("#selTitle").val();
        var type = $("#typeSelect option:selected").val();
        if (selTitle != "")
            selTitle = '%' + selTitle + '%';

        messageTable = $("#messageGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/message/getMessageRequest',
                "data": {
                    title: selTitle,
                    type:type
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "type", "visible": false},
                {"width": "9%", "data": "requester", "title": "申请人"},
                {"width": "11%", "data": "requestDept", "title": "申请部门"},
                {"width": "11%", "data": "publicTime", "title": "申请日期"},
                {
                    "width": "11%", "data": "title", "title": "标题",
                    "render": function (data, type, row, meta) {
                        if(row.title!=null || row.title!=undefined || row.title!=0){
                            var tt=row.title +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "8%", "data": "typeShow", "title": "类型"},
                {"width": "5%", "data": "empIdShow", "title": "发送人员"},
                {"width": "22%", "data": "deptIdShow", "title": "发送部门"},
                {
                    "width": "8%", "data": "content", "title": "内容",
                    "render": function (data, type, row, meta) {
                        if(row.content!=null || row.content!=undefined || row.content!=0){
                            var ss=row.content +"";
                            return "<span title='" + ss + "'>" + ss.substr(0, 10) + "</span>";
                        }
                    }
                },
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editMessage' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            //"<a id='check' class='icon-xing' title='查看已读人员'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='submitNotice' class='icon-upload-alt' title='提交'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delMessage' class='icon-archive' title='撤销'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>