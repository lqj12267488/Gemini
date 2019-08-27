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
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="requestDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addSoftInstall()">新增
                        </button>
                        <br>
                    </div>
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
<input id="tableName" hidden value="T_BG_SOFTINSTALL_WF">
<input id="workflowCode" hidden value="T_BG_SOFTINSTALL_WF01">
<input id="businessId" hidden>
<script>
    var roleTable;
    var handleName = "";
    var personId = "";

    $(document).ready(function () {
        search();

        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var softid = data.id;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/softInstall/getSoftById?id=" + softid);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "软件名称："+data.softName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/softInstall/deleteSoftById?id=" + softid, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#softInstallGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
                if (this.id == "submit") {
                    $("#businessId").val(softid);
                    getAuditer();
                }

            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + softid + '&businessType=TEST&tableName=T_BG_SOFTINSTALL_WF');
                $('#dialogFile').modal('show');
            }

        });
    });
    function addSoftInstall() {
        $("#dialog").load("<%=request.getContextPath()%>/softInstall/addSoftInstall");
        $("#dialog").modal("show");
    }

    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
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
        if (personId == '') {
            swal({title: '请选择人员！',type: "warning"});
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_SOFTINSTALL_WF",
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
                    $('#softInstallGrid').DataTable().ajax.reload();
                }
            })
    }
    function searchClear() {
        $("#requestDate").val("");
        search();
    }

    function search() {
        var v_requestdate = $("#requestDate").val();
        if (v_requestdate != "") {
            v_requestdate = '%' + v_requestdate + '%';
        }
        roleTable = $("#softInstallGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/softInstall/searchSoftInstall',
                "data": {
                    requestDate: v_requestdate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "softName", "title": "软件名称"},
                {"width": "15%", "data": "requester", "title": "申请人"},
                {"width": "15%", "data": "requestDept", "title": "申请部门"},
                {"width": "15%", "data": "requestDate", "title": "申请日期"},
                {"width": "30%", "data": "reason", "title": "安装原因"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>"
                                /* "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";*/;
                    }
                }

            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>
