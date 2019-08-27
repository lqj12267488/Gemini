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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                分组名称：
                            </div>
                            <div class="col-md-2">
                                <input id="groupNameSel" ></input>
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
                                onclick="addClass()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="commonGroupGrid" cellpadding="0" cellspacing="0"
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
    var classTable;

    $(document).ready(function () {
        search();
        classTable.on('click', 'tr a', function () {
            var data = classTable.row($(this).parent()).data();
            var groupId = data.groupId;
            if (this.id == "updateGroup") {
                $("#dialog").load("<%=request.getContextPath()%>/commonGroup/editGroup?groupId=" + groupId);
                $("#dialog").modal("show");
            }
            if (this.id == "delGroup") {
                //if(confirm("请确认是否要删除此分组?")){
                swal({
                    title: "您确定要删除本条信息?",
                    text: "分组名称："+data.groupName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/commonGroup/delGroup?groupId="+groupId,function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        search();
                    });
                })

            }
            if (this.id == "editEmp") {
                $("#dialog").load("<%=request.getContextPath()%>/commonGroup/editEmp?groupId=" + groupId);
                $("#dialog").modal("show");
            }
            if (this.id == "editRoles") {
                $("#dialog").load("<%=request.getContextPath()%>/commonGroup/editRole?groupId=" + groupId);
                $("#dialog").modal("show");
            }
            if (this.id == "viewMenu") {
                $("#dialog").load("<%=request.getContextPath()%>/commonGroup/viewMenu?groupId=" + groupId);
                $("#dialog").modal("show");
            }
        });
    })

    function addClass() {
        $("#dialog").load("<%=request.getContextPath()%>/commonGroup/addGroup");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#groupNameSel").val("");
        search();
    }

    function search() {

        var groupNameSel = $("#groupNameSel").val();
        if (groupNameSel != "")
            groupNameSel = '%' + groupNameSel + '%';

        classTable = $("#commonGroupGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/commonGroup/getGroupList',
                "data": {
                    groupName: groupNameSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "groupId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "groupName", "title": "分组名称"},
                {"width": "10%", "data": "remarks", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateGroup' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='editEmp' class='icon-user' title='添加分组人员'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='editRoles' class='icon-cogs' title='分组授权管理'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='viewMenu' class='icon-eye-open' title='查看分组权限'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='delGroup' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>