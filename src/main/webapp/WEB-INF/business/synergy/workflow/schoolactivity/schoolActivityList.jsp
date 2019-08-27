<%--协同办公-校外人员进校参加活动管理申请页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/11
  Time: 09:51
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
                                <input id="selDate" type="date"
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addAssets()">
                            新增</button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_SCHOOLACTIVITY_WF">
<input id="workflowCode" hidden value="T_BG_SCHOOLACTIVITY_WF01">
<input id="businessId" hidden>
<script>
    var listTable;

    $(document).ready(function () {
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            //修改
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/schoolActivity/getSchoolActivityById?id=" + id);
                $("#dialog").modal("show");
            }
            //上传附件
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_NEWSDRAFT_WF');
                $('#dialogFile').modal('show');
            }
            //删除
            if (this.id == "delete") {
                swal({
                    title: "请确认是否要删除本条申请?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "red",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/schoolActivity/deleteSchoolActivity?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            //提交
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });
    })
    /*添加函数*/
    function addAssets() {
        $("#dialog").load("<%=request.getContextPath()%>/schoolActivity/addSchoolActivity");
        $("#dialog").modal("show");
    }
    /*清空函数*/
    function searchclear() {
        $("#selDate").val("");
        search();
    }
    /*查询函数*/
    function search() {
        var requestTime = $("#selDate").val();
        if (requestTime != "")
            requestTime = requestTime;
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/schoolActivity/getSchoolActivityList',
                "data": {
                    requestTime: requestTime
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "requestDept", "title": "组织部门"},
                {"width": "8%", "data": "requester", "title": "负责人"},
                {"width": "10%", "data": "requestTime", "title": "申请时间"},
                {"width": "10%", "data": "activityName", "title": "活动名称"},
                {"width": "10%", "data": "activityContent", "title": "活动内容"},
                {"width": "10%", "data": "activityPlace", "title": "活动地点"},
                {"width": "10%", "data": "startTime", "title": "开始时间"},
                {"width": "10%", "data": "endTime", "title": "结束时间"},
                {"width": "8%", "data": "peopleNumber", "title": "进校人数"},
                {"width": "8%", "data": "carNumber", "title": "车辆数量"},
                {
                    "width": "6%","title": "操作",
                    "render": function () {
                        return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    /*动态弹窗选择审批人*/
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
                tableName: "T_BG_SCHOOLACTIVITY_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal("hide");
                    $('#listGrid').DataTable().ajax.reload();
                }
            }
        )
    }
</script>