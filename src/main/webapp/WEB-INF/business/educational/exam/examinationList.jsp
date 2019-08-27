<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 巡考</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="searchName">
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="edit()">新增
                        </button>
                        <br>
                    </div>
                    <table id="grid" cellpadding="0" cellspacing="0" width="100%" class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'did');
        });
        table = $("#grid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/getExaminationTeacherList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "teacherPersonShow", "title": "姓名"},
                {"data": "examDate", "title": "日期"},
                {"data": "startTime", "title": "考试开始时间"},
                {"data": "endTime", "title": "考试结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toEditExamination", {
            id: id,
            examId: "${examId}",
        });
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
            $.post("<%=request.getContextPath()%>/exam/delExamination", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#grid').DataTable().ajax.reload();
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/toExaminationExamList");
    }

    function searchclear() {
        $("#searchName").val("");
        search()
    }

    function search() {
        var searchName = $("#searchName").val();
        table.ajax.url("<%=request.getContextPath()%>/exam/getExaminationTeacherList?teacherPersonId=" + searchName+"&examId=${examId}").load();
    }
</script>