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
                            <input id="name"/>
                        </div>
                        <div class="col-md-1 tar">
                            打卡状态
                        </div>
                        <div class="col-md-2">
                            <select id="flag">
                                <option value="">请选择</option>
                                <option value="is null">未打卡</option>
                                <option value="is not null">已打卡</option>
                            </select>
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
                                onclick="back()">返回
                        </button>
                    </div>
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
                "url": '<%=request.getContextPath()%>/teach/getTaskLogDetails',
                "data": function (d) {
                    return $.extend({}, d, {
                        "taskId": "${taskId}",
                        "classId": "${classId}",
                        "major": "${major}",
                        "xz": "${xz}",
                        "name": $("#name").val(),
                        "flag": $("#flag").val(),
                    });
                }
            },
            "destroy": true,
            "columns": [
                {"data": "NAME", "title": "姓名"},
                {
                    "data": "flag", "title": "打卡状态",
                    "render": function (data, type, row) {
                        switch (row.flag) {
                            case '1':
                                return "已打卡";
                            default:
                                return "未打卡";
                        }
                    }
                },
                {"data": "CREATE_TIME", "title": "打卡时间"},
                {"data": "mac", "title": "MAC"},
                {"data": "ipAddr", "title": "IP地址"},
            ],
            "dom": 'rtlip',
            "language": language
        });
    });

    function searchclear() {
        $("#name").val("");
        $("#flag").val("");
        search();
    }

    function search() {
        $("#table").DataTable().ajax.reload();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/teach/toTaskLog");
    }

</script>