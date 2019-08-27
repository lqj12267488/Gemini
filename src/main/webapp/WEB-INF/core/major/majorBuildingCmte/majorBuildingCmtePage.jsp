<%--
  Description: 
  Creator: 郭千恺
  Date: 2018/9/30 10:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">专业:</div>
                            <div class="col-md-2">
                                <input id="searchMajorShow" onkeyup="keyup_submit()"/>
                            </div>
                            <div class="col-md-1 tar">委员会职务:</div>
                            <div class="col-md-2">
                                <input id="searchCmtePost" onkeyup="keyup_submit()"/>
                            </div>
                            <div class="col-md-1 tar">姓名:</div>
                            <div class="col-md-2">
                                <input id="searchTeacherName" onkeyup="keyup_submit()"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="clearSearch()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="add()">新增
                            </button>
                            <a type="button" class="btn btn-default btn-clean"
                               href="<%=request.getContextPath()%>/major/majorBuildingCmte/getCmteListGroupByMajor">导出
                            </a>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importExcel()">导入
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
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YJHFZT", function (data) {
            addOption(data, "replyFlag");
        });
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/major/majorBuildingCmte/majorBuildingCmteList'
            },
            "order": [3, 'DESC'],
            "destroy": true,
            "columns": [
                {"data": "majorShow", "title": "专业名称"},
                {"data": "cmtePost", "title": "专业建设指导委员会职务"},
                {"data": "teacherName", "title": "姓名"},
                {"data": "workUnit", "title": "工作单位"},
                {"data": "teacherPost", "title": "职务"},
                {"data": "teacherTitle", "title": "职称"},
                {"data": "telephone", "title": "联系电话"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-zoom-in" title="详情" onclick=detail("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-edit" title="编辑" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.teacherName + '")/>';
                    }
                }
            ],
            'order': [0, 'asc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    });

    <!-- 新增成员 -->
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/major/majorBuildingCmte/editMajorBuildingCmte");
        $("#dialog").modal("show");
    }

    <!-- 编辑成员 -->
    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/major/majorBuildingCmte/editMajorBuildingCmte?id=" + id);
        $("#dialog").modal("show");
    }

    <!-- 删除成员 -->
    function del(id, name) {
        swal({
            title: "您确定要删除教师 " + name + " ?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/major/majorBuildingCmte/delete", {
                id: id
            }, function (success) {
                if (success) {
                    successMessage("删除成功!");
                    $('#table').DataTable().ajax.reload();
                } else {
                    errorMessage("删除失败!");
                }
            });

        });
    }

    <!-- 导入 -->
    function importExcel() {
        $("#dialog").load("<%=request.getContextPath()%>/major/majorBuildingCmte/toImportCmte");
        $("#dialog").modal("show");
    }

    <!-- 查询 -->
    function search() {
        var searchMajorShow = $("#searchMajorShow").val();
        var searchCmtePost = $('#searchCmtePost').val();
        var searchTeacherName = $('#searchTeacherName').val();
        var url = '<%=request.getContextPath()%>/major/majorBuildingCmte/majorBuildingCmteList?majorShow=' + searchMajorShow
            + '&cmtePost=' + searchCmtePost
            + '&teacherName=' + searchTeacherName;
        $("#table").DataTable().ajax.url(url).load();
    }

    <!-- 清空查询 -->
    function clearSearch() {
        $("#searchMajorShow").val("");
        $('#searchCmtePost').val("");
        $('#searchTeacherName').val("");
        search();
    }

    <!-- 文本搜索框回车查询 -->
    function keyup_submit(e) {
        var evt = window.event || e;
        if (evt.keyCode == 13) {
            search();
        }
    }

    <!-- 详情 -->
    function detail(id) {
        $("#dialog").load("<%=request.getContextPath()%>/major/majorBuildingCmte/getDetailPage?id=" + id);
        $("#dialog").modal("show");
    }

    <!-- 提示*3 -->
    function infoMessage(msg, type) {
        swal({
            title: msg,
            type: type || "info"
        });
    }

    function successMessage(msg, type) {
        swal({
            title: msg,
            type: type || "success"
        });
    }

    function errorMessage(msg, type) {
        swal({
            title: msg,
            type: type || "error"
        });
    }
</script>
