<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%--公务用车申请首页--%>
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
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="date"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addBusinessCar()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="businessCar" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_BUSINESSCAR_WF">
<input id="workflowCode" hidden value="T_BG_BUSINESSCAR_WF01">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        search();

        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var carTypeShow = data.carTypeShow;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/businessCar/getBusinessCarById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "用车类型："+carTypeShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/businessCar/deleteBusinessCarById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#businessCar').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_BUSINESSCAR_WF');
                $('#dialogFile').modal('show');
            }
        });
    });
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
                tableName: "T_BG_BUSINESSCAR_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal("hide");
                    $('#businessCar').DataTable().ajax.reload();
                }
            })
    }
    function addBusinessCar() {
        $("#dialog").load("<%=request.getContextPath()%>/businessCar/addBusinessCar");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#requestdate").val("");
        search();
    }

    function search() {

        var requestDate = $("#requestdate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';

        roleTable = $("#businessCar").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/businessCar/getBusinessCarList',
                "data": {
                    requestDate: requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"data": "carType", "visible": false},
                {"width": "8%", "data": "requestDept", "title": "申请部门"},
                {"width": "8%", "data": "requester", "title": "申请人"},
                {"width": "8%", "data": "requestDate", "title": "申请日期"},
                {"width": "9%", "data": "startTime", "title": "起始时间"},
                {"width": "9%", "data": "endTime", "title": "结束时间"},
                {"width": "8%", "data": "startPlace", "title": "始发地"},
                {"width": "8%", "data": "endPlace", "title": "目的地"},
                {"width": "7%", "data": "carTypeShow", "title": "用车类型"},
                {"width": "9%", "data": "reason","title": "申请事由"},
                {"width": "8%", "data": "peopleNum", "title": "人数"},
                {"width": "8%", "data": "remark", "title": "备注"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
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

