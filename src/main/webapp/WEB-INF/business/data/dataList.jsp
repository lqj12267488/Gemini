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
                <div class="block block-drop-shadow content"
                     style="background: none;border-bottom: none;padding-left: 2px;box-shadow: 0px 0px;">
                    <div class="col-md-1 tar">
                        一级类别：
                    </div>
                    <div class="col-md-2">
                        <select id="one" onchange="oneChenge()"></select>
                    </div>
                    <div class="col-md-1 tar">
                        二级类别：
                    </div>
                    <div class="col-md-2">
                        <select id="two">
                            <option value="">请选择一级类别</option>
                        </select>
                    </div>
                    <div class="col-md-1 tar" style="margin-left: -1px;margin-top: 6px;">
                        资料名称：
                    </div>
                    <div class="col-md-2">
                        <input id="dataNameSel" style="width: 101.5%;" type=""
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
                            onclick="addData()">新增
                    </button>
                </div>
                <table id="dataGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        </th>
                        <th>dataId</th>
                        <th>time</th>
                        <th width="8%">资料名称</th>
                        <th width="10%">一级菜单</th>
                        <th width="10%">二级菜单</th>
                        <th width="10%">三级菜单</th>
                        <th width="10%">日期</th>
                        <th width="12%">房间</th>
                        <th width="12%">柜号</th>
                        <th width="12%">档案盒名称</th>
                        <th width="10%">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var table;

    function oneChenge() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " type_id",
            text: " type_name ",
            tableName: "T_ZL_DATA_TYPE",
            where: " WHERE PARENT_TYPE_ID = " + $("#one").val() + " ",
            orderby: " "
        }, function (data) {
            addOption(data, "two");
        });
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " type_id",
            text: " type_name ",
            tableName: "T_ZL_DATA_TYPE",
            where: " WHERE PARENT_TYPE_ID = 0 ",
            orderby: " "
        }, function (data) {
            addOption(data, "one");
        });

        table = $("#dataGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/data/getDataList',
            },
            "columns": [
                {"data": "dataId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "dataName"},
                {"data": "dataFirstType"},
                {"data": "dataSecondType"},
                {"data": "dataThirdType"},
                {"data": "submitTime"},
                {"data": "bookshelfName"},
                {"data": "bookshelfLayer"},
                {"data": "arrayLocation"},
                {
                    "render": function (data, type, row) {
                        var str = '<span class="icon-edit" title="修改" onclick=edit("' + row.dataId + '")/>' +
                            '&ensp;&ensp;<span class="icon-trash" title="删除" onclick=del("' + row.dataId + '","' + row.dataName + '")/>';
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

    function addData() {
        $("#dialog").load("<%=request.getContextPath()%>/data/addData");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#dataNameSel").val("");
        $("#one").val("");
        $("#two").val("");
        search();
    }

    function search() {
        var dataName = $("#dataNameSel").val();
        table.ajax.url("<%=request.getContextPath()%>/data/getDataList?dataName=" + dataName + "&dataFirstType=" + $("#one").val()
            + "&dataSecondType=" + $("#two").val()).load();
    }

    function edit(dataId) {
        $("#dialog").load("<%=request.getContextPath()%>/data/editData?dataId=" + dataId);
        $("#dialog").modal("show");
    }

    function del(dataId, dataName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "资料名称：" + dataName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/data/deleteDataById", {
                dataId: dataId
            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    table.ajax.reload();
                }
            });
        })
    }
</script>





