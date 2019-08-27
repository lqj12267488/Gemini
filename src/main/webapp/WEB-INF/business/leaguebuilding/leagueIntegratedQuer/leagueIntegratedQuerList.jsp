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
                <div class="content controls" style="height: 85%">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="header">
                            <span id="leagueName"
                                  style="font-size: 15px;margin-left: 20px">团员信息</span>
                        </div>
                        <div class="content block-fill-white">
                            <div class="form-row">
                                <div class="col-md-1 tar">
                                    姓名：
                                </div>
                                <div class="col-md-3">
                                    <input id="sName" type="text"
                                           class="validate[required,maxSize[100]] form-control"/>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-default btn-clean" onclick="searchLeague()">
                                        查询
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                        清空
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="content">
                            <table id="leagueGrid" cellpadding="0" cellspacing="0" width="100%"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="branchCache" hidden>
</div>
<script>
    var leagueTable;
    var leagueTree;
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
                $("#branchCache").val(treeNode.id);
                $("#branchName").html(treeNode.name)
                leagueTable.ajax.url("<%=request.getContextPath()%>/league/getLeagueList?branchId=" + treeNode.id).load()
            }
        }
    };
    $(document).ready(function () {
        var branchId = $("#branchCache").val() + '%';
        $.get("<%=request.getContextPath()%>/league/getLeagueBranchTree", function (data) {
            leagueTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            leagueTree.expandAll(true);
        })
        leagueTable = $("#leagueGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/league/getLeagueList?branchId=' + branchId,
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "12%", "data": "leagueMembersNumber", "title": "团员证号"},
                {"width": "15%", "data": "studentName", "title": "姓名"},
                {"width": "15%", "data": "branchName", "title": "团组织名称"},
                {"width": "13%", "data": "memberDuties", "title": "团内职务"},
                {"width": "15%", "data": "joinleagueTime", "title": "入团时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作",
                    "render": function (data, type, row) {
                        var str = '<span class="icon-comment-alt" title="查看操作日志" onclick=showLeagueLog("' + row.id + '")/>';
                        return str;
                    },
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })
    function showLeagueLog(id) {
        $("#dialog").load("<%=request.getContextPath()%>/league/showLeagueLog?id=" + id);
        $("#dialog").modal("show");
    }
    function searchClear() {
        $("#sName").val("");
        searchLeague();
    }
    function searchLeague() {
        var branchId = $("#branchCache").val();
        var studentId = $("#sName").val();
        leagueTable.ajax.url("<%=request.getContextPath()%>/league/getLeagueList?studentId=" + studentId+"&branchId="+branchId).load();
    }
</script>