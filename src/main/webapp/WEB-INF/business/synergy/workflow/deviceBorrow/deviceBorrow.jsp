<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
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
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="deviceBorrowGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_DEVICEBORROW_WF">
<input id="workflowCode" hidden value="T_BG_DEVICEBORROW_WF01">
<input id="businessId" hidden>
<script>
    var deviceBorrowTable;
    $(document).ready(function () {
        search();

        deviceBorrowTable.on('click', 'tr a', function () {
            var data = deviceBorrowTable.row($(this).parent()).data();
            var id = data.id;
            var deviceList = data.deviceList;
            if (this.id == "editdeviceBorrow") {
                $("#dialog").load("<%=request.getContextPath()%>/deviceBorrow/getDeviceBorrowById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deldeviceBorrow") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "设备清单："+deviceList+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/deviceBorrow/deleteDeviceBorrowById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#deviceBorrowGrid').DataTable().ajax.reload();
                        }
                    })

                });


            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_DEVICEBORROW_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/deviceBorrow/editDeviceBorrow");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        search();
    }
    function search() {
        var date = $("#date").val();

        if (date != "")
            date = date;

        deviceBorrowTable = $("#deviceBorrowGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/deviceBorrow/getDeviceBorrowList',
                "data": {
                    requestDate: date
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "12%","data": "requester", "title": "申请人"},
                {"width": "12%","data": "requestDate", "title": "申请日期"},
                {"width": "13%","data": "borrowTime", "title": "借用时间"},
                {"width": "13%","data": "revertTime", "title": "归还时间"},
                {"width": "13%","data": "deviceList", "title": "设备清单"},
                {"width": "13%","data": "activityContent", "title": "活动内容"},
                {"width": "12%","title": "操作", "render": function () {return "<a id='editdeviceBorrow' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='deldeviceBorrow' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

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
                tableName: "T_BG_DEVICEBORROW_WF",
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
                    $("#dialog").modal("hide");
                    $('#deviceBorrowGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
