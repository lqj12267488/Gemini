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
                            项目名称：
                        </div>
                        <div class="col-md-2">
                            <input id="saiProNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目类别：
                        </div>
                        <div class="col-md-2">
                            <select id="saiProTypeSel"></select>
                        </div>
                        <div class="col-md-1 tar">
                            级别：
                        </div>
                        <div class="col-md-2">
                            <select id="saiLevelSel"></select>
                        </div>
                        <div class="col-md-2 tar">
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

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=	XSHJXMLB", function (data) {
            addOption(data, 'saiProTypeSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JB", function (data) {
            addOption(data, 'saiLevelSel');
        });

        search();
    })

    function search() {
        $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/StuAwardInfo/getStuAwardInfoList',
                "data": {
                    saiProName: $("#saiProNameSel").val(),
                    saiProType: $("#saiProTypeSel").val(),
                    saiLevel: $("#saiLevelSel").val(),
                    awardTime: $("#awardTimeSel").val(),
                    studentList: $("#studentListSel").val(),
                    coach: $("#coachSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键id", "visible": false},
                {"data": "saiProName", "title": "项目名称"},
                {"data": "saiProTypeShow", "title": "项目类别"},
                {"data": "saiLevelShow", "title": "级别"},
                {"data": "awardTime", "title": "获奖日期"},
                {"data": "studentList", "title": "学生名单"},
                {"data": "coach", "title": "指导老师名单"},
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
        $("#dialog").load("<%=request.getContextPath()%>/StuAwardInfo/toStuAwardInfoAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/StuAwardInfo/toStuAwardInfoEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/StuAwardInfo/delStuAwardInfo?id=" + id, function (msg) {
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