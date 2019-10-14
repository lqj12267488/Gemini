<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            职业技能鉴定站（所）：
                        </div>
                        <div class="col-md-2">
                            <input id="evaNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            工种证书名称：
                        </div>
                        <div class="col-md-2">
                            <input id="certNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            等级：
                        </div>
                        <div class="col-md-2">
                            <select id="evaLevelSel"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            建立单位级别：
                        </div>
                        <div class="col-md-2">
                            <select id="buildDepLevSel"></select>
                        </div>
                        <div class="col-md-1 tar">
                            部门：
                        </div>
                        <div class="col-md-2">
                            <input id="departSel">
                        </div>
                        <div class="col-md-2 tar">
                            <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                            <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="add()">新增
                    </button>
                    <br>
                </div>
                <div class="form-row block" style="overflow-y:auto;">
                    <table id="table" cellpadding="0" cellspacing="0"
                           width="100%" style="max-height: 50%;min-height: 10%;"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=	ZYDJ", function (data) {
            addOption(data, 'evaLevelSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=	DWBMDJ", function (data) {
            addOption(data, 'buildDepLevSel');
        });

        search();
    })

    function search() {
        $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/ProEvaAgency/getProEvaAgencyList',
                "data": {
                    evaName: $("#evaNameSel").val(),
                    certName: $("#certNameSel").val(),
                    evaLevel: $("#evaLevelSel").val(),
                    buildDepLev: $("#buildDepLevSel").val(),
                    depart: $("#departSel").val(),
                    ssEvaNum: $("#ssEvaNumSel").val(),
                    schEvaNum: $("#schEvaNumSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键id", "visible": false},
                {"data": "evaName", "title": "职业技能鉴定站（所）"},
                {"data": "certName", "title": "工种证书名称"},
                {"data": "evaLevelShow", "title": "等级"},
                {"data": "buildDepLevShow", "title": "建立单位级别"},
                {"data": "depart", "title": "部门"},
                {"data": "ssEvaNum", "title": "社会鉴定数（人天）"},
                {"data": "schEvaNum", "title": "在校生鉴定数(人天)"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/ProEvaAgency/toProEvaAgencyAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/ProEvaAgency/toProEvaAgencyEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/ProEvaAgency/delProEvaAgency?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>