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
<input id="loginUser" hidden value="${loginUser}">
<script>
    var messageTable;
    var loginUser=$("#loginUser").val();

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TZLX", function (data) {
            addOption(data, "typeSelect");
        })
        search();
        messageTable.on('click', 'tr a', function () {
            var data = messageTable.row($(this).parent()).data();
            var messageId = data.id;
            if (this.id == "editMessage") {
//                    if (data.creator != loginUser) {
//                        swal({title: "不是您发布的通知，您无法修改。", type: "error"});
//                        return;
//                    }
//                    else {
//                        if(data.requestFlag!=0){
//                            swal({ title: "此通知已提交流程，您无法修改。",type: "error"});
//                        }
//                        else {
                            $("#dialog").load("<%=request.getContextPath()%>/editMessage?id=" + messageId);
                            $("#dialog").modal("show");
//                        }
//                    }
                }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + messageId + '&businessType=TEST&tableName=T_SYS_MESSAGE');
                $('#dialogFile').modal('show');
            }
            if (this.id == "check"){
                $('#right').load('<%=request.getContextPath()%>/messagePersonList?id='+messageId);
                $('#right').modal('show');
            }
            if (this.id == "noticePublish") {
                /*alert(data.publishFlag)*/
                /*if('${loginDept}'==001006 || '${loginDept}'==001008) {*/
                    if(data.publishFlag==1){
                        swal({
                            title: "此通知已发布，不可重复发布",
                            type: "error"
                        });
                    }
                    else {
                        swal({
                            title: "您确定要发布本条通知吗?",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "发布",
                            closeOnConfirm: false
                        }, function () {
                            $.post("<%=request.getContextPath()%>/messagePublish", {
                                id: messageId
                            }, function (msg) {
                                swal({
                                    title: msg.msg,
                                    type:"success"
                                });
                                $("#dialog").modal('hide');
                                messageTable.ajax.reload();
                            });
                        })
                    }
                //}
               /* else {
                    swal({
                        title: "您无权发布此通知",
                        type: "error"
                    });
                }*/
            }


            if (this.id == "delMessage") {
                swal({
                    title: "您确定要删除本条通知?",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/deleteMessage", {
                        id: messageId
                    }, function (msg) {
                        swal({title: msg.msg, type: msg.result});
                        $("#dialog").modal('hide');
                        messageTable.ajax.reload();
                    });
                })
            }
        });
    })

    function addMessage() {
        $("#dialog").load("<%=request.getContextPath()%>/addMessage?workflag=0");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function search() {
        var title =  $("#selTitle").val();
        if (title != "")
            title = '%' + title + '%';
        var type = $("#typeSelect option:selected").val();
        messageTable = $("#messageGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/getMessageList',
                "data": {
                    title: title,
                    type:type,
                    messageType:1
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "type", "visible": false},
                {"data": "requestFlag", "visible": false},
                {"data":"publishFlag","visible":false},
                {"width": "9%", "data": "requester", "title": "发布人"},
                {"width": "12%", "data": "requestDept", "title": "发布人部门"},
                {"width": "11%", "data": "publicTime", "title": "发布日期"},
                {
                    "width": "8%", "data": "title", "title": "标题",
                    "render": function (data, type, row, meta) {
                        if(row.title!=null || row.title!=undefined){
                            var ss=row.title +"";
                            return "<span title='" + ss + "'>" + ss.substr(0,10) + "</span>";
                        }
                    }
                },
                {"width": "8%", "data": "typeShow", "title": "类型"},
                {"width": "5%", "data": "empIdShow", "title": "发送人员"},
                {"width": "24%", "data": "deptIdShow", "title": "发送部门"},
                {
                    "width": "8%", "data": "content", "title": "内容",
                    "render": function (data, type, row, meta) {
                        if(row.content!=null || row.content!=undefined || row.content!=0){
                            var tt=row.content +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='noticePublish' class='icon-arrow-up' title='发布'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='editMessage' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='check' class='icon-xing' title='查看已读人员'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delMessage' class='icon-archive' title='撤销'></a>";
                    }
                }
            ],
            'order' : [4,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>