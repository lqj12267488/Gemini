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
        <div class="col-md-12" id="roleList">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="block block-drop-shadow">

                            <div class="content block-fill-white">

                                <div class="form-row">
                                    <div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">
                                        <div class="col-md-2 tar">
                                            姓名：
                                        </div>
                                        <div class="col-md-2" style="width: 30%;">
                                            <input id="empSearch"/>
                                        </div>
                                        <div class="col-md-2 tar">
                                            学工号：
                                        </div>
                                        <div class="col-md-2" style="width: 30%;">
                                            <input id="staffIdSearch"/>
                                        </div>
                                    </div>
                                    <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">
                                        <div class="col-md-2 tar">
                                            身份证号：
                                        </div>
                                        <div class="col-md-2" style="width: 30%;">
                                            <input id="idCardSearch" placeholder="末位字母请大写"/>
                                        </div>
                                        <div class="col-md-2 tar">
                                            性别：
                                        </div>
                                        <div class="col-md-2" style="width: 30%;">
                                            <select id="sexSearch"
                                                    class="validate[required,maxSize[100]] form-control"/>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                        </button>
                                        <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                            清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="recovery" cellpadding="0" cellspacing="0" width="100%"
                                           style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sexSearch');
        });
    })
    $(document).ready(function () {
        table = $("#recovery").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/emp/getDeletedEmpList',
            },
            "destroy": true,
            "columns": [
                {"data": "personId", "visible": false},
                {"width": "10%", "data": "name", "title": "姓名"},
                {"width": "25%", "data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "deptName", "title": "所在部门"},
                {"width": "15%", "data": "idCard", "title": "身份证号"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "nationShow", "title": "民族"},
                {"width": "10%", "data": "tel", "title": "电话"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return"<span id='showDetailed' title='查看详细' class='icon-search'></span>&ensp;"+
                            "<span id='recoveryEmp' title='恢复' class='icon-reply'></span>&ensp;"
                    }
                }
            ],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr span', function () {
            var data = table.row($(this).parent()).data();
            var personId = data.personId;
            if (this.id == "showDetailed") {
                $("#dialog").load("<%=request.getContextPath()%>/emp/showDetailed?personId=" + personId);
                $("#dialog").modal("show");
            }
            if (this.id === "recoveryEmp") {
                swal({
                    title: "您确定恢复" + data.name + "?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "恢复",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/emp/recoveryEmpById?personId=" + personId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#recovery').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })
    function searchClear() {
        $("#empSearch").val("");
        $("#staffIdSearch").val("");
        $("#idCardSearch").val("");
        $('#sexSearch option:selected').val("");
        $('#sexSearch').val("");
        search();
    }

    function search() {
        var empName = $("#empSearch").val();
        var staffId = $("#staffIdSearch").val();
        var idCard = $("#idCardSearch").val();
        var sexSearch = $('#sexSearch option:selected').val();
        table.ajax.url("<%=request.getContextPath()%>/emp/getDeletedEmpList?name="
            + empName + "&staffId=" + staffId + "&idCard=" + idCard + "&sex=" + sexSearch).load();
    }
</script>
