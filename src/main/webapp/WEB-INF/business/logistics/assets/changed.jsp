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
<style type="text/css">
    div.dataTables_wrapper {
        width: 100%;
    }
</style>
<div class="container"><%--最外层div--%>
    <div class="row"><%--top_extend_div--%>
        <div class="block">
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <div class="col-md-1 tar">
                        变更日期:
                    </div>
                    <div class="col-md-2">
                        <input id="f_date" type="date"/>
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
                            onclick="changeAsset()">资产变更
                    </button>
                </div>
                <table id="assetsGrid" cellpadding="0" cellspacing="0" style="width: 100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                        </th>
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
                        <th>变更时间</th>
                        <th>变更去向</th>
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
        table = $("#assetsGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/assets/getChanged',
            },
            "columns": [
                {
                    "width": "10%",
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.assetsId + "'/>";
                    },

                },
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
                {"data": "usePosition"},
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
        $("#f_date").val("");
        table.ajax.url("<%=request.getContextPath()%>/assets/getChanged").load()
    }

    function search() {
        if ($("#f_date").val() == "" || $("#f_date").val() == undefined) {
            swal({
                title: "请填写入库时间!",
                type: "info"
            });
        } else {
            table.ajax.url("<%=request.getContextPath()%>/assets/getChanged?inTime=" + $("#f_date").val()).load()
        }

    }

    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }


    function changeAsset() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/assets/toChangeAsset?ids=" + chk_value + "&status=3");
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择资产!",
                type: "info"
            });
        }

    }
</script>





