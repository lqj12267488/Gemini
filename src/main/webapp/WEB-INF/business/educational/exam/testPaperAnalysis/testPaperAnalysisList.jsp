<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
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
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/testPaperAnalysis/getTestPaperAnalysisList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "courseIdShow", "title": "考试课程"},
                {"data": "classIdShow", "title": "考试班级"},
                {"data": "teacherIdShow", "title": "授课教师"},
                {"data": "examNature", "title": "考核方式"},
                {"data": "examMode", "title": "考试类型"},
                {"data": "examTime", "title": "考试时间"},
                {"data": "examStunum", "title": "考试人数"},
                {"data": "missExamStunum", "title": "缺考人数"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-search" title="预览" onclick=yulan("' + row.id + '")></span>';
                    }
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/testPaperAnalysis/toTestPaperAnalysisAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/testPaperAnalysis/toTestPaperAnalysisEdit?id=" + id)
        $("#dialog").modal("show")
    }
    function yulan(id){
        $("#dialog").load("<%=request.getContextPath()%>/testPaperAnalysis/toTestPaperAnalysisSearch?id=" + id)
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
            $.get("<%=request.getContextPath()%>/testPaperAnalysis/delTestPaperAnalysis?id=" + id, function (msg) {
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