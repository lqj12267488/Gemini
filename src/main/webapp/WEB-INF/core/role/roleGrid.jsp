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
                                角色名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rerolename" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                角色说明：
                            </div>
                            <div class="col-md-2">
                                <input id="reroledescription" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                角色类型：
                            </div>
                            <div class="col-md-2">
                                <select class="select2" id="searchreroletype"></select>
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
                                onclick="addEmp()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="roleGrid" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYJB", function (data) {
            addOption(data, "searchreroletype");
        })
        search();
        /*$("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var roleid = data.roleid;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/getRoleById?id=" + roleid);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "角色名称："+data.rolename+"\n\n角色删除后，用户将不再拥有该角色所授予的菜单权限，对于用户拥有的其他角色权限将不受影响。删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    //if (confirm("确定要删除" + data.rolename + "?")) {
                    $.get("<%=request.getContextPath()%>/deleteRoleById?id=" + roleid, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            //alert(msg.msg);
                            $('#roleGrid').DataTable().ajax.reload();
                        }
                    })
                    //}
                });

            }
            if (this.id == "addEmpRole") {
                $("#dialog").load("<%=request.getContextPath()%>/rolePerRelationByRole?roleid=" + roleid);
                $("#dialog").modal("show");
            }
            if (this.id == "addStudentRole") {
                $("#dialog").load("<%=request.getContextPath()%>/role/roleStuRel?roleid=" + roleid);
                $("#dialog").modal("show");
            }
            if (this.id == "addPersonRole") {
                $("#dialog").load("<%=request.getContextPath()%>/role/roleParStuRel?roleid=" + roleid);
                $("#dialog").modal("show");
            }
            if (this.id == "addRelationMenu") {
                $("#dialog").load("<%=request.getContextPath()%>/roleMenuRelationByRole?roleid=" + roleid);
                $("#dialog").modal("show");
            }
        });
    })

    function addEmp() {
        $("#dialog").load("<%=request.getContextPath()%>/addRole");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#rerolename").val("");
        $("#reroledescription").val("");
        $("#searchreroletype").val("");
        search();
    }

    function search() {
        var rolename = $("#rerolename").val();
        if (rolename != "")
            rolename = '%' + rolename + '%';
        var searchreroletype = $("#searchreroletype option:selected").val()
        if (searchreroletype != "")
            searchreroletype = searchreroletype;
        var roledescription = $("#reroledescription").val();
        if (roledescription != "")
            roledescription = '%' + roledescription + '%';
        roleTable = $("#roleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/role/search',
                "data": {
                    rolename: rolename,
                    roledescription: roledescription,
                    roletype: searchreroletype
                }
            },
            "destroy": true,
            "columns": [
                {"data": "roleid", "visible": false},
                {"data": "roletype", "visible": false},
                {"width": "25%", "data": "rolename", "title": "角色名称"},
                {"width": "35%", "data": "roledescription", "title": "角色描述"},
                {"width": "25%", "data": "roletypeshow", "title": "角色类型"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addEmpRole' class='icon-tags' title='授权教职员工'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addStudentRole' class='icon-book' title='授权学生'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addPersonRole' class='icon-screenshot' title='授权学生家长'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });

    }
</script>