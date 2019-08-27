<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:04
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
                        入库日期:
                    </div>
                    <div class="col-md-2">
                        <input id="date" type="date"/>
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
                <table id="changedGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>time</th>
                        <th>资产名称</th>
                        <th>资产类型</th>
                        <th>资产数量</th>
                        <th>计量单位</th>
                        <th>品牌</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>备注</th>
                        <th>使用部门</th>
                        <th>使用人</th>
                        <th>使用时间</th>
                       <%-- <th>变更去向</th>--%>
                        <th>入库时间</th>
                        <th>操作</th>
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
        table = $("#changedGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/assets/getAssetsDetailsList',
            },
            "columns": [
                {"data": "assetsId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "assetsName"},
                {"data": "assetsType"},
                {"data": "assetsNum"},
                {"data": "unit"},
                {"data": "brand"},
                {"data": "price"},
                {"data": "specifications"},
                {"data": "remark"},
                {"data": "userDept"},
                {"data": "userId"},
                {"data": "useTimeShow"},
                //{"data": "direction"},
                {"data": "inTime"},
                {
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="使用日志" onclick=viewLog("' + row.assetsId + '")/>';
                    }
                },
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function searchClear() {
        $("#date").val("");
        table.ajax.url("<%=request.getContextPath()%>/assets/getAssetsDetailsList").load()
    }

    function search() {
        if ($("#date").val() == "" || $("#date").val() == undefined) {
            alert("请填写入库时间！")
        } else {
            $("#changedGrid").DataTable().ajax.url("<%=request.getContextPath()%>/assets/getAssetsDetailsList?inTime=" + $("#date").val()).load()
        }

    }


    function viewLog(id) {

        $("#dialog").load("<%=request.getContextPath()%>/assets/viewLog?id=" + id);
        $("#dialog").modal("show");

    }
</script>





