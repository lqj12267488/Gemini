<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            教学改革及研究项目名称：
                        </div>
                        <div class="col-md-2">
                            <input id="rsProNameSel">
                        </div>
                        <div class="col-md-2 tar">
                            师资建设项目名称：
                        </div>
                        <div class="col-md-2">
                            <input id="tcProNameSel">
                        </div>
                        <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
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
        search();
    })

    function search() {
        $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/SchExpend/getSchExpendList',
                "data": {
                    rsProName: $("#rsProNameSel").val(),
                    tcProName: $("#tcProNameSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键id", "visible": false},
                {"data": "expInf", "title": "基础设施建设（万元）"},
                {"data": "expDevAll", "title": "设备采购"},
                {"data": "rsProName", "title": "教学项目名称"},
                {"data": "rsProMoney", "title": "教学项目金额"},
                {"data": "tcProName", "title": "师资建设项目名称"},
                {"data": "tcProMoney", "title": "项目金额"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="查看" onclick=see("' + row.id + '")></span>&ensp;&ensp;'+
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
        $("#dialog").load("<%=request.getContextPath()%>/SchExpend/toSchExpendAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/SchExpend/toSchExpendEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function see(id) {
        $("#dialog").load("<%=request.getContextPath()%>/SchExpend/toSchExpendEdit?id=" + id+"&seeFlag=1")
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
            $.get("<%=request.getContextPath()%>/SchExpend/delSchExpend?id=" + id, function (msg) {
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