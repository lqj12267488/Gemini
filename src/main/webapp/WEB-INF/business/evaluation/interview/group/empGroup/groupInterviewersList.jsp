<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                被评人组名称：
                            </div>
                            <div class="col-md-2">
                                <input id="groupNameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
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
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="groupTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var groupTable;
    var eType = '2';
    $(document).ready(function () {
        search();
    })
    function search() {
        var groupName = $("#groupNameSel").val();
        if (groupName != "")
            groupName = '%' + groupName + '%';
        groupTable = $("#groupTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/evaluation/getEmpGroupList',
                "data": {
                    groupName: groupName ,
                    evaluationType:eType,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "groupId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "30%", "data": "groupName", "title": "被评人组名称"},
                {"width": "30%", "data": "membersNum", "title": "被评人数量"},
                {
                    "width": "40%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-user" title="面试人员设置" onclick="addEmps(\'' +row.groupId + '\',\''+eType+'\')"/>&ensp;&ensp;' +
                            '<span class="icon-edit" title="修改" onclick="edit(\'' + row.groupId + '\')"/>&ensp;&ensp;' +
                            '<span class="icon-copy" title="复制被评人组" ' + ' onclick="editCopy(\'' + row.groupId + '\')"/>' +
                            '&ensp;&ensp;<span class="icon-trash" title="删除" onclick="del(\'' + row.groupId + '\',\'' + row.groupName + '\')"/>';
                    },
                    "width": "8%"
                }
            ],
//            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function searchclear() {
        $("#groupNameSel").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toEmpGroupInterviewersAdd");
        $("#dialog").modal("show");
    }

    function addEmps(id, eType) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toSelectInterviewersEmp", {
            id: id,
            evaluationType: eType
        });
        $("#dialog").modal("show");
    }


    function editCopy(id) {
        swal({
            title: "您确定要复制本条信息？ ",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "复制",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/editCopyEmpGroup", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#groupTable').DataTable().ajax.reload();
            });

        });
    }

    function del(id, groupName) {
        swal({
            title: "您确定要删除本条信息？ ",
            text: "被评人组名称："+groupName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/deleteEmpGroup", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#groupTable').DataTable().ajax.reload();
            });

        });
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toEmpGroupInterviewersEdit?id=" + id);
        $("#dialog").modal("show");
    }
</script>