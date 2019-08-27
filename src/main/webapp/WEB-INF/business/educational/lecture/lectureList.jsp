<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block block-drop-shadow">
            <div class="content block-fill-white">
                <div class="form-row">
                    <div class="col-md-1 tar">
                        讲座名称：
                    </div>
                    <div class="col-md-2">
                        <input id="lectureNameSel" type="text"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean" onclick="searchLecture()">
                            查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                            清空
                        </button>
                    </div>
                </div>
            </div>
            </div>
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
                "url": '<%=request.getContextPath()%>/lecture/getLectureList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"data": "teacherId", "title": "教师名称"},
                {"data": "deptId", "title": "所属系部"},
                {"data": "lectureName", "title": "讲座名称"},
                {"data": "majorCode", "title": "专业"},
                {"data": "classId", "title": "班级"},
                {"data": "studentNumber", "title": "人数"},
                {"data": "classHours", "title": "课时数"},
                {"data": "placeShow", "title": "授课地点"},
                {"data": "count", "title": "附件数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {

                        var html ='<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delData("' + row.id + '")></span>&ensp;&ensp;'+
                            '<span class="icon-download" title="下载" onclick=upload("' + row.id + '")></span>&ensp;&ensp;';
                        return html
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
        $("#dialog").load("<%=request.getContextPath()%>/lecture/toLectureAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/lecture/toLectureEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delData(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/lecture/delLecture?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
    function upload(id){
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_LECTURE');
        $('#dialogFile').modal('show');
    }
    function searchClear() {
        $("#lectureNameSel").val("");
        searchLecture();
    }
    function searchLecture() {
        var lectureNameSel = $("#lectureNameSel").val();
        table.ajax.url("/lecture/getLectureList?lectureName="+lectureNameSel).load();
    }
</script>