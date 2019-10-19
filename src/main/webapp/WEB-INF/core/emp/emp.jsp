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
<div class="container ">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls"  id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div class="block block-drop-shadow">
                        <div class="content block-fill-white">
                            <div class="form-row">
                                <div class="col-md-1 tar">
                                    姓名：
                                </div>
                                <div class="col-md-2">
                                    <input id="empSearch"/>
                                </div>
                                <div class="col-md-1 tar">
                                    证件号：
                                </div>
                                <div class="col-md-2">
                                    <input id="idCardSel"/>
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
                    <div class="block">
                        <div class="header">
                            <span id="deptName"
                                  style="font-size: 15px;margin-left: 20px">所有人员</span>
                        </div>
                        <div class="content">
                            <table id="empGrid" cellpadding="0" cellspacing="0" width="100%"
                                   class="table table-bordered table-striped sortable_default">
                                <thead>
                                <tr>
                                    <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                                    </th>
                                    <th>personId</th>
                                    <th width="10%">姓名</th>
                                    <th width="10%">登陆账号</th>
                                    <th width="10%">所在部门</th>
                                    <th width="10%">身份证号</th>
                                    <th width="10%">性别</th>
                                    <th width="10%">民族</th>
                                    <th width="10%">电话</th>
                                    <th width="10%">操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="deptCache" hidden>
</div>
<script>
    var deptTable;
    var deptTree;
    var deptId;
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                $("#empSearch").val("");
                if (!treeNode.isParent) {
                    $("#deptCache").val(treeNode.id);
                } else {
                    $("#deptCache").val("");
                }
                $("#deptName").html(treeNode.name);
                deptId = treeNode.id;
                deptTable.ajax.url("<%=request.getContextPath()%>/getEmpList?deptId=" + treeNode.id).load();
                $("div.toolbar").html('');
                $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="addEmp()">新增</button>&ensp;' +
                    '<a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/exportEmp?deptId=' + deptId + '">导出</a>&ensp;' +
                    '<button class="btn btn-info btn-clean" onclick="showEmpDialog()" ">导入</button>'+
                    '<button class="btn btn-info btn-clean" onclick="allot()">批量授权</button>&ensp;');
            }
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true);
        })
        deptTable = $("#empGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: '<%=request.getContextPath()%>/getEmpList',
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.personId + "'/>";
                    },"orderable":false
                },
                {"data": "personId", "visible": false},
                {"width": "10%", "data": "name", "title": "姓名"},
                {"width": "10%", "data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "deptName", "title": "所在部门"},
                {"width": "10%", "data": "idCard", "title": "身份证号"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "nationShow", "title": "民族"},
                {"width": "10%", "data": "tel", "title": "电话"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<span id='editEmp' title='修改' class='icon-edit'></span>&ensp;" +
                            "<span id='deleteEmp' title='删除' class='icon-trash'></span>&ensp;" +
                            //                            "<span id='changeDept' title='修改部门' class='icon-sitemap'></span>&ensp;" +
                            "<span id='assignRole' title='分配角色' class='icon-tags'></span>&ensp;" +
                            "<span id='repeatPwd' title='初始化密码' class='icon-repeat'></span>&ensp;" +
                            "<span id='changeLevel' title='设置级别' class='icon-sitemap'></span>&ensp;";
                    }
                }
            ],
            paging: true,
            "dom": '<"toolbar">rtlip',
            "language": language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="addEmp()">新增</button>&ensp;' +
            '<a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/exportEmp?deptId=' + deptId + '">导出</a>&ensp;' +
            '<button class="btn btn-info btn-clean" onclick="showEmpDialog()" ">导入</button>'+
            '<button class="btn btn-info btn-clean" onclick="allot()">批量授权</button>&ensp;');
        deptTable.on('click', 'tr span', function () {
            var data = deptTable.row($(this).parent()).data();
            var personId = data.personId;
            if (this.id == "editEmp") {
                $("#dialog").load("<%=request.getContextPath()%>/toEditEmp?personId=" + personId + "&deptId=" + data.deptId);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteEmp") {
                //if (confirm("确定要删除" + data.name + "?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "用户名：" + data.name + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/deleteEmp?", {
                        personId: personId,
                        deptId: data.deptId
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            deptTable.ajax.reload();
                        }
                    })
                })
            }
            /*
                        if (this.id == "changeDept") {
                            $("#dialog").load("/toChangeEmpDept?personId=" + personId);
                            $("#dialog").modal("show");
                        }
            */
            if (this.id == "assignRole") {
                $("#dialog").load("<%=request.getContextPath()%>/toAssignRole?personId=" + personId + "&deptId=" + data.deptId);
                $("#dialog").modal("show");
            }
            if (this.id == 'changeLevel') {
                $("#dialog").load("<%=request.getContextPath()%>/toChangeLevel?personId=" + personId);
                $("#dialog").modal("show");
            }

            if (this.id == "repeatPwd") {
                //if (confirm("确定要初始化用户 " + data.name + " 的密码?")) {
                swal({
                    title: "您确定要初始化用户：" + data.name + "的密码?",
                    //text: "用户名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/saveLoginPwd?", {
                        personId: personId,
                        password: '123456'
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: "密码初始化成功",
                                type: "success"
                            });
                            //alert("密码初始化成功");
                            //deptTable.ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addEmp() {
        var deptId = $("#deptCache").val();
        if (null == deptId || deptId == "") {
            swal({
                title: "请在左侧选择部门后再进行人员添加",
                type: "info"
            });
            //alert("请在左侧选择部门后再进行人员添加");
            return;
        } else {
            $("#dialog").load("<%=request.getContextPath()%>/addEmp?deptId=" + deptId);
            $("#dialog").modal("show");
        }
    }

    function showEmpDialog() {
        if ($("#deptCache").val() == "") {
            swal({
                title: "请选择部门！",
                type: "warning"
            });
        } else {
            $("#dialog").load("<%=request.getContextPath()%>/toImportEmp");
            $("#dialog").modal("show");
        }
    }

    function searchclear() {
        $("#empSearch").val("");
        $("#idCardSel").val("");
        search();
    }

    function search() {
        var empName = $("#empSearch").val();
        /*var idCard = $("#idCardSel").val();*/
        deptTable.ajax.url("<%=request.getContextPath()%>/getEmpList?deptId=" + $("#deptCache").val() + "&name="
            + empName +"&idCard=" + $("#idCardSel").val()).load();
    }
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked",true);
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function allot() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });

            $("#dialog").load("<%=request.getContextPath()%>/toAssignRoles?personIds=" + chk_value+"&deptId="+deptId);
            $("#dialog").modal("show");
        } else {
            swal({title: "请选择要录入的班级！",type: "info"});
        }

    }
</script>
<style>
    #style-4::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar {
        width: 5px;
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar-thumb {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>