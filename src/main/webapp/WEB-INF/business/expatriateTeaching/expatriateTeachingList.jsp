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
                            姓名
                        </div>
                        <div class="col-md-2">
                            <input id="nameShow"/>
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
                "url": '<%=request.getContextPath()%>/educational/expatriateTeaching/getExpatriateTeachingList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "teacherDeptId", "title": "部门"},
                {"data": "teacherId", "title": "姓名"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {"data": "content", "title": "授课内容"},
                {"data": "place", "title": "授课地点"},
                {"data": "crowd", "title": "授课人群"},
                {"data": "sum", "title": "授课人数"},
                {"data": "timeSum", "title": "课时数"},
                {"data": "count", "title": "附件数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var html = '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delData("' + row.id + '")></span>&nbsp;&nbsp;&nbsp;'+
                            '<span class="icon-download" title="下载" onclick=upload("' + row.id + '")></span>&ensp;&ensp;';
                        return html;
                    }
                }
            ],
            'order' : [[1,'desc']],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    });

    function searchclear() {
        $("#nameShow").val("");
        table.ajax.url("<%=request.getContextPath()%>/educational/expatriateTeaching/getExpatriateTeachingList").load();
    }

    function search() {
        var nameShow = $("#nameShow").val();
        table.ajax.url("<%=request.getContextPath()%>/educational/expatriateTeaching/getExpatriateTeachingList?nameShow=" + nameShow).load();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/educational/expatriateTeaching/toExpatriateTeachingAdd");
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/educational/expatriateTeaching/toExpatriateTeachingEdit?id=" + id);
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
            $.get("<%=request.getContextPath()%>/educational/expatriateTeaching/delExpatriateTeaching?id=" + id, function (msg) {
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
</script>