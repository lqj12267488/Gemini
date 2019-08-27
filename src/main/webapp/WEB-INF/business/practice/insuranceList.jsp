<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--楼宇场地维护首页--%>
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
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="insuranceName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                性别：
                            </div>
                            <div class="col-md-2">
                                <select id="prize"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classId" type="text"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                身份证号：
                            </div>
                            <div class="col-md-2">
                                <input id="s_idcard" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                保险单号：
                            </div>
                            <div class="col-md-2">
                                <input id="s_insurance" type="text"
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addInsurance()">
                            新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="importDialog()">
                            导入
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="insurance" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_JY_PRACTICE_MATERIAL">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'prize');
        });

        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var name = data.name;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/insurance/getInsuranceById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JY_PRACTICE_MATERIAL');
                $('#dialogFile').modal('show');
            }

            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "姓名："+name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/insurance/deleteInsuranceById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#insurance').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addInsurance() {
        $("#dialog").load("<%=request.getContextPath()%>/insurance/addInsurance");
        $("#dialog").modal("show");
    }
    function importDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/insurance/toImportInsurance");
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#insuranceName").val("");
        $("#prize").val("");
        $("#prize option:selected").val("");
        $("#classId").val("");
        $("#s_insurance").val("");
        $("#s_idcard").val("");
        search();
    }

    function search() {
        var insurancename = $("#insuranceName").val();
        if (insurancename != "")
            insurancename =  '%'+insurancename+ '%';
        roleTable = $("#insurance").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/insurance/getInsuranceList',
                "data": {
                    name: insurancename,
                    sex:$("#prize option:selected").val(),
                    classId:$("#classId").val(),
                    idcard: $("#s_idcard").val(),
                    insuranceNumber:$("#s_insurance").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "name", "title": "姓名"},
                {"width": "15%", "data": "sex", "title": "性别"},
                {"width": "15%", "data": "idcard", "title": "身份证号"},
                {"width": "15%", "data": "classId", "title": "班级"},
                {"width": "15%", "data": "insuranceNumber", "title": "保险单号"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });

    }
</script>


