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
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
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
    var deptTable1;
    var deptTree;
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
                $("#deptName").html(treeNode.name)
                deptTable1.ajax.url("<%=request.getContextPath()%>/getEmpList?deptId=" + treeNode.id).load()
            }
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true)
        })
        deptTable1 = $("#empGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/getEmpList',
            },
            "destroy": true,
            "columns": [
                {"data": "personId", "visible": false},
                {"width": "10%", "data": "name", "title": "姓名"},
                {"width": "15%", "data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "idCard", "title": "身份证号"},
                {"width": "15%", "data": "sexShow", "title": "性别"},
                {"width": "15%", "data": "nationShow", "title": "民族"},
                {"width": "10%", "data": "tel", "title": "电话"},
                {"width": "15%", "data": "staffStatusShow", "title": "人员状态"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<span id='changeDept' title='部门异动' class='icon-sitemap'></span>&ensp;&ensp;" +
                            "<span id='changeStatus' title='状态异动' class='icon-edit'></span>&ensp;&ensp;" +
                            "<span id='searchLog' title='查看异动日志' class='icon-search'></span> ";
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        deptTable1.on('click', 'tr span', function () {
            var data = deptTable1.row($(this).parent()).data();
            var personId = data.personId;
            if (this.id == "searchLog") {
                $("#dialog").load("<%=request.getContextPath()%>/empChangeLog/searchLog?personId=" + personId);
                $("#dialog").modal("show");
            }
            if (this.id == "changeDept") {
                $("#dialog").load("<%=request.getContextPath()%>/empChangeLog/toChangeEmpDept?personId=" + personId);
                $("#dialog").modal("show");
            }
            if (this.id == "changeStatus") {
                $("#dialog").load("<%=request.getContextPath()%>/empChangeLog/toChangeEmpStatus?personId=" + personId + "&name=" + data.name);
                $("#dialog").modal("show");
            }
        });
    })

    function showEmpDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/toImportEmp");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#empSearch").val("");
        search();
    }

    function search() {
        var empName = $("#empSearch").val();
        deptTable1.ajax.url("<%=request.getContextPath()%>/getEmpList?deptId=" + $("#deptCache").val() + "&name="
            + empName).load();
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