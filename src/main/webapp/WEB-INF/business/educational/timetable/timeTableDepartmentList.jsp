<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px"><a onclick="back()" style="color:#6ad6ff;text-decoration: underline">${timeTableName}</a> >> 课程表管理 </span>
                    <input type="hidden" id="timeTableId" value="${timeTableId}">
                </div>
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            系部名称:
                        </div>
                        <div class="col-md-2">
                            <select id="departmentIdSearch"></select>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
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
   /* var isDean = $("#isDean").val();
    console.error(isDean);*/

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentIdSearch');
        });
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/timeTableDepartment/getTimeTableDepartmentList?timeTableId=' + $("#timeTableId").val()
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "departmentId", "title": "系部名称"},
                {"data": "majorId", "title": "专业名称"},
                {"data": "classId", "title": "班级名称"},
                {"data": "peopleNumber", "title": "人数 "},
                {"data": "classRom", "title": "教室 "},
                {

                    "title": "操作",
                    "render": function (data, type, row) {

                       /* if(isDean==1) {
                            return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                                '<span class="icon-eye-open" title="课程表管理" onclick=toTimeTableCourse("' + row.id + '","' + row.departmentId + '")/>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.departmentId + '")/>';

                        }
                        if(isDean==0) {
                            return'<span class="icon-eye-open" title="课程表管理" onclick=toTimeTableCourse("' + row.id + '","' + row.departmentId + '")/>&ensp;&ensp;';
                        }*/


                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="课程表管理" onclick=toTimeTableCourse("' + row.id + '","' + row.departmentId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.departmentId + '")/>';
                    }

                }
            ],
            'order': [0, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        var timeTableId= $("#timeTableId").val();
        $("#dialog").load("<%=request.getContextPath()%>/timeTableDepartment/toTimeTableDepartmentAdd", {
            timeTableId: timeTableId
        });
        $("#dialog").modal("show")
    }

    function edit(id) {
        var timeTableId= $("#timeTableId").val();
        $("#dialog").load("<%=request.getContextPath()%>/timeTableDepartment/toTimeTableDepartmentAdd", {
            id: id,
            timeTableId: timeTableId
        });
        $("#dialog").modal("show")
    }

    function del(id, departmentId) {
        swal({
            title: "您确定要删除本条信息?",
            text: "系部：" + departmentId + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/timeTableDepartment/deleteTimeTableDepartment?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })

        });
    }



    function search() {
        var timeTableId= $("#timeTableId").val();
        var departmentIdSearch = $("#departmentIdSearch option:selected").val();
        if (departmentIdSearch == undefined || departmentIdSearch == null) {
            departmentIdSearch = "";
        }
        table.ajax.url("<%=request.getContextPath()%>/timeTableDepartment/getTimeTableDepartmentList?departmentId=" + departmentIdSearch+"&timeTableId="+timeTableId
        ).load();
    }

    function searchclear() {
        $("#departmentIdSearch option:selected").val("");
        $("#departmentIdSearch").val("");
        search();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/timeTable/toTimeTable");
    }


    function toTimeTableCourse(timeTableDepartmentId, departmentName) {
        var timeTableId= $("#timeTableId").val();
        $("#right").load("<%=request.getContextPath()%>/timeTableCourse/toTimeTableCourse?timeTableDepartmentId=" + timeTableDepartmentId + "&departmentName=" + departmentName+"&timeTableId="+timeTableId);
    }


</script>
