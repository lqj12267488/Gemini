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
                            <span id="studentName"
                                  style="font-size: 15px;margin-left: 20px">团员信息</span>
                        </div>
                        <div class="content">
                            <table id="leagueGrid" cellpadding="0" cellspacing="0" width="100%"
                                   class="table table-bordered table-striped sortable_default">
                                <thead>
                                <tr>
                                    <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/></th>
                                    <th>id</th>
                                    <th width="10%">团员证号</th>
                                    <th width="12%">姓名</th>
                                    <th width="15%">团组织名称</th>
                                    <th width="15%">团内职务</th>
                                    <th width="12%">入团时间</th>
                                    <th width="12%">团组织变更类型</th>
                                    <th width="15%">备注</th>
                                </tr>
                                </thead>
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
            showLine: false,

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

            "columns": [{
                "render": function (data, type, row) {
                    return "<input type='checkbox' name='checkbox' value='" + row.id + "'/>";
                }
            },
                {"data": "id", "visible": false},
                {"data": "leagueMembersNumber"},
                {"data": "studentName"},
                {"data": "branchName"},
                {"data": "memberDuties"},
                {"data": "joinleagueTime"},
                {"data": "relationshipChangeType"},
                {"data": "relationshipRemark"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [3, 'desc'],
            "dom": '<"toolbar">rtlip',
            language: language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="changeRelationship()">团组织关系变更</button>');
    })

    function changeRelationship() {
        var ids = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                ids += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/league/changeLeagueRelationship?ids=" + ids);
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择需要变更的记录！",
                type: "info"
            });
        }
    }
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }

</script>