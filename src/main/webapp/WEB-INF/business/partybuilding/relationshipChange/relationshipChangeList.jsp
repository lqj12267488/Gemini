<%--
  Created by IntelliJ IDEA.
  User: fn
  Date: 2017/7/27
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container"><%--最外层div--%>
    <div class="row"><%--top_extend_div--%>
        <div class="block">
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <div class="col-md-1 tar">
                        党支部：
                    </div>
                    <div class="col-md-2">
                        <select id="branchId"
                                class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-1 tar">
                        党员类型：
                    </div>
                    <div class="col-md-2">
                        <select id="personType"
                                class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="block block-drop-shadow content"
                     style="background: none;border-bottom: none;padding-left: 2px;box-shadow: 0px 0px;">
                    <div class="col-md-1 tar" style="margin-left: -1px;margin-top: 6px;">
                        姓名：
                    </div>
                    <div class="col-md-2">
                        <input id="personId" style="width: 101.5%;" type=""
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                        成员角色：
                    </div>
                    <div class="col-md-2">
                        <select id="memberRoles" style="width: 101.5%;"
                                class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchClear()">清空
                        </button>
                    </div>
                </div>
            </div>
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="changeRelationship()">党组织关系变更
                    </button>
                </div>
                <table id="partyGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                        </th>
                        <th>id</th>
                        <th>time</th>
                        <th>peopleRoles</th>
                        <th width="10%">成员类型</th>
                        <th width="12%">成员来源</th>
                        <th width="15%">姓名</th>
                        <th width="15%">党支部</th>
                        <th width="12%">成员角色</th>
                        <th width="15%">变更类型</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " branch_name ",
                tableName: "T_DT_PARTYBRANCH",
                where: " WHERE 1 = 1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "branchId", '${party.branchId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYDXLX", function (data) {
            addOption(data, 'personType', '${party.personType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYLY", function (data) {
            addOption(data, 'personSource', '${party.personSource}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYJS", function (data) {
            addOption(data, 'memberRoles', '${party.memberRoles}');
        });

        table = $("#partyGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/getRelationshipChangeList',
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "peopleRoles", "visible": false},
                {"data": "personType"},
                {"data": "personSource"},
                {"data": "personId"},
                {"data": "branchId"},
                {"data": "memberRoles"},
                {"data": "relationshipChangeType"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [3, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function addParty() {
        $("#dialog").load("<%=request.getContextPath()%>/addParty");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#branchId").val("");
        $("#personType").val("");
        $("#personId").val("");
        $("#memberRoles").val("");
        search();
    }

    function search() {
        var branchId = $("#branchId option:selected").val();
        var personType = $("#personType option:selected").val();
        var personId = $("#personId").val();
        var memberRoles = $("#memberRoles option:selected").val();
        table.ajax.url("<%=request.getContextPath()%>/getRelationshipChangeList?branchId=" + branchId + "&personType=" + personType + "&personId=" + personId + "&memberRoles=" + memberRoles).load();
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/editParty?id=" + id);
        $("#dialog").modal("show");
    }

    function del(id) {
        if (confirm("请确认是否要删除该条记录?")) {
            $.get("<%=request.getContextPath()%>/deletePartyById?id=" + id, function (msg) {
                if (msg.status == 1) {
                    alert(msg.msg);
                    $("#partyGrid").DataTable().ajax.reload();
                }
            });
        }
    }
    function turnRoles(id) {
        $("#dialog").load("<%=request.getContextPath()%>/editRolesTimeById?id=" + id);
        $("#dialog").modal("show");
    }
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function changeRelationship() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/toChangeRelationship?ids=" + chk_value);
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择需要变更的记录!",
                type: "info"
            });
        }

    }
</script>





