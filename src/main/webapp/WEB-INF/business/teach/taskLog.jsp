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
                        <div class="col-md-1 tar">
                            班级
                        </div>
                        <div class="col-md-2">
                            <input id="className"/>
                        </div>
                        <div class="col-md-1 tar">
                            课程
                        </div>
                        <div class="col-md-2">
                            <input id="courseName"/>
                        </div>
                        <div class="col-md-1 tar">
                            日期
                        </div>
                        <div class="col-md-2">
                            <input id="data" type="date" value="${now}"/>
                        </div>
                    </div>
                    <div class="row" style="text-align: right;padding-right: 50px">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchclear()">清空
                        </button>
                    </div>
                </div>
            </div>
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row block">
                        <table id="table" class="table table-bordered table-striped sortable_default">
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
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teach/getTaskLog',
                "data": function (d) {
                    return $.extend({}, d, {
                        "name": $('#nameShow').val(),
                        "className": $('#className').val(),
                        "courseName": $('#courseName').val(),
                        "data": $('#data').val()
                    });
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "creator", "title": "姓名"},
                {"data": "courseName", "title": "课程"},
                {"data": "startTime", "title": "上课开始时间"},
                {"data": "endTime", "title": "上课结束时间"},
                {"data": "className", "title": "班级"},
                {"data": "count", "title": "应打卡人数"},
                {"data": "sum", "title": "打卡人数"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="查看详情" ' +
                            'onclick=view("' + row.id + '","' + row.classId + '","' + row.MAJOR + '","' + row.XZ + '")></span>&ensp;&ensp;';
                    }
                }
            ],
            "paging": true,
            "processing": true,
            "serverSide": true,
            "dom": 'rtlip',
            "language": language
        });
    });

    function view(taskId, classId, major, xz) {
        $("#right").load("<%=request.getContextPath()%>/teach/toTaskLogDetails?taskId="
            + taskId + "&classId=" + classId + "&major=" + major + "&xz=" + xz)
    }

    function searchclear() {
        $("#nameShow").val("");
        $("#className").val("");
        $("#courseName").val("");
        $("#data").val("");
        table.ajax.reload();
    }

    function search() {
        table.ajax.reload();
    }

</script>