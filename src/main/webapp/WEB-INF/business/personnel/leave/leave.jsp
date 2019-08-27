<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:17
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
                            <div class="col-md-1 tar">
                                请假类型：
                            </div>
                            <div class="col-md-2">
                                <select id="eleaveType"/>
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
                        <table id="leaveGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_RS_LEAVE_WF">
<input id="workflowCode" hidden>
<input id="businessId" hidden>
<script>
    var leaveTable;

    $(document).ready(function () {

            $.get("<%=request.getContextPath()%>/common/getSysDict?name=QJLX", function (data) {
                addOption(data, 'eleaveType', '${leave.leaveType}');
            });

        search();

        leaveTable.on('click', 'tr a', function () {
            var data = leaveTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editleave") {
                $("#dialog").load("<%=request.getContextPath()%>/leave/getLeaveById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delleave") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请人："+data.requester+"的请假\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/leave/deleteLeaveById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#leaveGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer(data.requestDays);
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_RS_LEAVE_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/leave/editLeave");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        $("#eleaveType ").val("");
        $("#eleaveType option:selected").val("");
        search();
    }
    function search() {
        var date = $("#date").val();

        if (date != "")
            date = date;


        leaveTable = $("#leaveGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/leave/getLeaveList',
                "data": {
                    requestDate: date,
                    leaveType: $("#eleaveType option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%","data": "requestDept", "title": "申请部门"},
                {"width": "11%","data": "requester", "title": "申请人"},
                {"width": "11%","data": "requestDate", "title": "申请日期"},
                {"width": "11%","data": "startTime", "title": "开始时间"},
                {"width": "11%","data": "endTime", "title": "结束时间"},
                {"width": "11%","data": "requestDays", "title": "请假天数"},
                {"width": "11%","data": "leaveType", "title": "请假类型"},
                {"width": "12%","data": "reason", "title": "请假原因"},
                {"width": "11%", "title": "操作", "render": function () {return "<a id='editleave' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='delleave' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

    function getAuditer(e) {
        // if (e == 1) {
        //     $('#workflowCode').val("T_RS_LEAVE_WF02");
        // }
        // else if (e > 1 && e <= 3) {
        //     $('#workflowCode').val("T_RS_LEAVE_WF03");
        // }
        // else {
        //     $('#workflowCode').val("T_RS_LEAVE_WF04");
        // }
        $('#workflowCode').val("T_RS_LEAVE_WF01");
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
        if(personId == '' || personId==null || personId=="" || personId==undefined)
        {
            swal({
                title: "请选择办理人!",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_RS_LEAVE_WF",
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
                    $('#leaveGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
