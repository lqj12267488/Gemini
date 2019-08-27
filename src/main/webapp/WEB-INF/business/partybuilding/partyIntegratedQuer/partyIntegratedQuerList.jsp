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
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            党支部：
                        </div>
                        <div class="col-md-2">
                            <select id="branchId" type="text"
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
                    <table id="partyGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            </th>
                            <th>id</th>
                            <th>time</th>
                            <th>peopleRoles</th>
                            <th width="10%">成员类型</th>
                            <th width="10%">成员来源</th>
                            <th width="10%">姓名</th>
                            <th width="15%">党支部</th>
                            <th width="10%">成员角色</th>
                            <th width="10%">第一培养人</th>
                            <th width="10%">第二培养人</th>
                            <th width="15%">备注</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
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
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "peopleRoles", "visible": false},
                {"data": "personType"},
                {"data": "personSource"},
                {"data": "personId"},
                {"data": "branchId"},
                {"data": "memberRoles"},
                {"data": "firstCultivatePeopleId"},
                {"data": "secondCultivatePeopleId"},
                {"data": "remark"},
                {
                    "render": function (data, type, row) {
                        var str = '<span class="icon-search" title="查看详细" onclick=showDetailed("' + row.id + '")/>' +
                            '&ensp;&ensp;<span class="icon-comment-alt" title="查看操作日志" onclick=showPartyLog("' + row.id + '")/>';
                        return str;
                    },
                },
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [3, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
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

    function showDetailed(id) {
        $("#dialog").load("<%=request.getContextPath()%>/showDetailed?id=" + id);
        $("#dialog").modal("show");
    }
    function showPartyLog(id) {
        $("#dialog").load("<%=request.getContextPath()%>/showPartyLog?id=" + id);
        $("#dialog").modal("show");
    }

</script>





