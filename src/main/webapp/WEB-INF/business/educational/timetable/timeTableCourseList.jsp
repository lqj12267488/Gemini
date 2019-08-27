<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px"><a onclick="back()"
                                                                       style="color:#6ad6ff;text-decoration: underline">${timeTableDepartmentName}</a> >> 课程管理 </span>
                    <input type="hidden" id="timeTableDepartmentId" value="${timeTableDepartmentId}">
                    <input type="hidden" id="timeTableId" value="${timeTableId}">
                    <%--<input id="isDean" hidden value="${isDean}">--%>
                </div>
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                      <%-- <c:if test="${isDean ==1}">--%>
                           <button type="button" class="btn btn-default btn-clean"
                                   onclick="add()">新增
                           </button>
                           <button type="button" class="btn btn-default btn-clean"
                                   onclick="toImportTimeTable()">导入
                           </button>
                           <br>

                     <%--  </c:if>--%>

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

    /*var isDean = $("#isDean").val();
    console.error(isDean);*/


    function back() {
        var timeTableId = $("#timeTableId").val();
        $("#right").load("<%=request.getContextPath()%>/timeTableDepartment/toTimeTableDepartment?timeTableName=课程管理&id=" + timeTableId);
    }

    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": "<%=request.getContextPath()%>/timeTableCourse/getTimeTableCourseList?timeTableDepartmentId=${timeTableDepartmentId}"
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "weeks", "title": "周时"},
                {"data": "courseNum", "title": "课时"},
                {"data": "courseName", "title": "课程名称"},
                {"data": "courseTeacher", "title": "授课老师"},
                {"data": "specialPlace", "title": "特殊地点"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                       /*if(isDean==1) {
                            return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';

                        }
                        if(isDean==0) {
                            return' ';
                        }*/

                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';



                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });


    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/timeTableCourse/toTimeTableCourseAdd?timeTableId=" + '${timeTableId}');
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/timeTableCourse/toTimeTableCourseAdd?id=" + id + "&timeTableId=" + '${timeTableId}');
        $("#dialog").modal("show");
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/timeTableCourse/deleteTimeTableCourse?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })

        });
    }


    function toImportTimeTable() {
        $("#dialog").load("<%=request.getContextPath()%>/timeTable/timeTableImport?timeTableDepartmentId=" + '${timeTableDepartmentId}');
        $("#dialog").modal("show");
    }

</script>
