<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <h5>${arrayClassName} > 课程计划维护</h5>
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
                        <table id="arrayClassCourseGrid" cellpadding="0" cellspacing="0"
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
    var arrayClass;
    $(document).ready(function () {
        arrayClass = $("#arrayClassCourseGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassCourse/getArrayClassCourseList?arrayClassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"data": "arrayClassCourseId", "visible": false},
                {"data": "courseType", "visible": false},
                {"data": "courseID", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"width": "18%", "data": "courseTypeShow", "title": "课程类型"},
                {"width": "18%", "data": "courseShow", "title": "课程名称"},
                {"width": "18%", "data": "departmentShow", "title": "系部"},
                {"width": "18%", "data": "majorShow", "title": "专业"},
                {"width": "18%", "data": "credit", "title": "学分"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.arrayClassCourseId + '")/>&ensp;&ensp;' +
                        '<span class="icon-time" title="学时管理" onclick=courseWeekManage("' + row.arrayClassCourseId + '","' + row.courseType +
                            '","' +row.courseID +  '","' + row.departmentsId + '","' + row.majorCode + '","' + row.credit + '","' +row.courseShow + '")/>&ensp;&ensp;' +
                            '<span class="icon-th-list" title="添加上课班级" onclick=courseClassManage("' + row.arrayClassCourseId + '","' + row.courseType +
                                       '","' +row.courseID +  '","' + row.departmentsId + '","' + row.majorCode + '","' + row.credit + '")/>&ensp;&ensp;' +
                        '<span class="icon-trash" title="删除" onclick=del("' + row.arrayClassCourseId + '")/>';
                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc']],
            "dom": 'rtlip',
            language: language
        });
    })


    function courseWeekManage( arrayClassCourseId,courseType,courseID,departmentsId,majorCode,credit,courseShow) {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCourseWeek/request?arrayClassId=${arrayClassId}&arrayClassName=${arrayClassName}&arrayClassCourseId=" + arrayClassCourseId +
            "&term=${term}&courseType=" + courseType +"&courseID="+courseID + "&departmentsId="+departmentsId +"&majorCode="+majorCode+"&credit="+credit+"&courseShow="+courseShow )
    }

    function courseClassManage( arrayClassCourseId,courseType,courseID,departmentsId,majorCode,credit) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/toSelectClass?arrayClassId=${arrayClassId}&arrayClassCourseId=" + arrayClassCourseId +
            "&courseType=" + courseType +"&courseID="+courseID + "&departmentsId="+departmentsId +"&majorCode="+majorCode+"&credit="+credit )
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
            $.post("<%=request.getContextPath()%>/arrayClassCourse/deleteArrayClassCourseById", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#arrayClassCourseGrid').DataTable().ajax.reload();
            });
        })
    }


    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourse?arrayClassId=${arrayClassId}&term=${term}&id=" + id);
        $("#dialog").modal("show")
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCourse");
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCourse?arrayClassId=${arrayClassId}&term=${term}");
        $("#dialog").modal("show");
    }

</script>