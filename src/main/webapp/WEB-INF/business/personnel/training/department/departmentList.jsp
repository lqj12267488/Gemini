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
                                培训类别：
                            </div>
                            <div class="col-md-2">
                                <select id="type"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addTraining()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="departmentTrainingGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_RS_TRAINING_WF">
<input id="workflowCode" hidden value="T_RS_TRAINING_WF01">
<input id="businessId" hidden>
<script>
    var table;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'type');
        });
        table = $("#departmentTrainingGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/training/department/getTrainingList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "trainingProjectName", "title": "培训项目名称"},
                {"width": "10%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "trainingTypeShow", "title": "培训类别"},
                {"width": "10%","data": "trainingDate", "title": "培训日期"},
                {"data": "trainingDays", "visible": false},
                {"data": "trainingPlace", "visible": false},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<a id='editTraining' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='delTraining' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editTraining") {
                $("#dialog").load("<%=request.getContextPath()%>/training/department/getTrainingById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delTraining") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "培训项目名称："+data.trainingProjectName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/training/department/deleteTrainingById?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                            //alert(msg.msg);
                            $('#departmentTrainingGrid').DataTable().ajax.reload();

                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_RS_TRAINING_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addTraining() {
        $("#dialog").load("<%=request.getContextPath()%>/training/department/editTraining");
        $("#dialog").modal("show");
    }
    function search() {
        var date = $("#date").val();
        var type = $("#type option:selected").val();
        if (type == "" && date == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/training/department/getTrainingList?trainingType="+type+"&requestDate="+date).load();
        }
    }

    function searchclear() {
        $("#date").val("");
        $("#type").val("");
        table.ajax.url("<%=request.getContextPath()%>/training/department/getTrainingList").load();
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
                tableName: "T_RS_TRAINING_WF",
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
                    $('#departmentTrainingGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
