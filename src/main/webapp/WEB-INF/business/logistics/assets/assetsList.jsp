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
                            onclick="addAssets()">新增
                    </button>
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="importList()">批量导入
                    </button>
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="allot()">资产分配
                    </button>
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="changeAsset()">资产变更
                    </button>
                    <%--<button type="button" class="btn btn-default btn-clean"
                            onclick="exportAsset()">批量导出--%>
                    <a class="btn btn-default btn-clean"
                       onclick="exportList()">批量导出
                    </a>
                    <a id="exportList" style="display: none"></a>
                    <%--</button>--%>
                </div>
                <table id="assetsGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                        </th>
                        <th>id</th>
                        <th>createTime</th>
                        <th width="7%">资产名称</th>
                        <th width="7%">资产类型</th>
                        <th width="7%">资产数量</th>
                        <th width="7%">在库数量</th>
                        <th width="7%">计量单位</th>
                        <th width="7%">品牌</th>
                        <th width="5%">单价</th>
                        <th width="5%">规格</th>
                        <th width="5%">备注</th>
                        <th width="5%">入库时间</th>
                        <th width="5%">操作</th>
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
            "processing": false,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/assets/getAssetsList',
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "assetsName"},
                {"data": "assetsType"},
                {"data": "assetsNumAll"},
                {"data": "assetsNumIn"},
                {"data": "unit"},
                {"data": "brand"},
                {"data": "price"},
                {"data": "specifications"},
                {"data": "remark"},
                {"data": "inTime"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "" + "<a id='upAssets' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delAssets' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var assetsName = data.assetsName;
            if (this.id == "upAssets") {
                $("#dialog").load("<%=request.getContextPath()%>/assets/getAssetsById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delAssets") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "资产名称：" + assetsName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/assets/deleteAssetsById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#assetsGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }
        });
    });

    function addAssets() {
        $("#dialog").load("<%=request.getContextPath()%>/assets/editAssets");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#f_date").val("");
        table.ajax.url("<%=request.getContextPath()%>/assets/getAssetsList").load()
    }

    function search() {
        if ($("#f_date").val() == "" || $("#f_date").val() == undefined) {
            swal({
                title: "请填写入库时间!",
                type: "info"
            });
        } else {
            table.ajax.url("<%=request.getContextPath()%>/assets/getAssetsList?inTime=" + $("#f_date").val()).load()
        }

    }

    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
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
            $("#dialog").load("<%=request.getContextPath()%>/assets/toAllot?ids=" + chk_value);
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择资产!",
                type: "info"
            });
        }

    }

    function changeAsset() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/assets/toChangeAsset?ids=" + chk_value + "&status=1");
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择资产!",
                type: "info"
            });
        }

    }

    /*批量导出*/
    function exportList() {
        var taskIds = "";
        // if ($("#checkAll").attr("checked")) {
        //     taskIds = "all";
        // } else {
            $('input[name="checkbox"]:checked').each(function () {
                taskIds = taskIds + "'" + $(this).val() + "',";
            });
            taskIds = taskIds.substring(0, taskIds.length - 1);
        // }
        if (null == taskIds || taskIds == "") {
            swal({
                title: "请选择需要导出结果的在库资产信息任务!",
                type: "info"
            });
            return;
        }
        // alert(taskIds)
        $("#exportList").attr("href", "<%=request.getContextPath()%>/assets/exportAssetsList?ids=" + taskIds);
        document.getElementById("exportList").click();
    }

    function importList() {
        $("#dialog").load("<%=request.getContextPath()%>/assets/viewImportList");
        $("#dialog").modal("show");

    }

</script>





