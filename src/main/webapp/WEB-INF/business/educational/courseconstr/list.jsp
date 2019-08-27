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
                <div class="block block-drop-shadow">
                </div>
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

        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch', '${course.departmentsId}');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")

        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseconstr/getList',
            },
            "destroy": true,
            "columns": [
                {"data": "classId", "visible": false},
                {"data": "className", "title": "课程名称"},
                {"data": "classTypes", "title": "课程类型"},
                {"data": "courseProperties", "title": "课程属性"},
                {"data": "prescribedPeriods", "title": "规定课时"},
                {"data": "practiceClass", "title": "实践课时"},
                {"data": "coreCurriculum", "title": "核心课程"},
                {"data": "schoolEnterpriseCooperation", "title": "校企合作"},
                {"data": "excellentCourse", "title": "精品课程"},
                {"data": "venue", "title": "授课地点"},
                {"data": "teachingMethod", "title": "授课方式"},
                {"data": "testMethod", "title": "考试方法"},
                {"data": "classCertifiate", "title": "课证融通"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.classId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.classId + '","' + '")/>';
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/courseconstr/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSearch');
        });
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseconstr/toAdd", {

        })
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/courseconstr/toEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id,courseName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "课程名称："+courseName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/courseconstr/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();

            });

        });
       /* if (confirm("确定要删除这条记录？")) {
            $.get("/course/del?id=" + id, function (data) {
                alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        }*/
    }

    function search() {
        var courseName = $("#searchCourseName").val();
        var departmentsId = $("#departmentsIdSearch").val();
        var major = $("#majorCodeSearch").val();
        var arr = major.split(",");
        var url = "<%=request.getContextPath()%>/courseconstr/getList?courseType=${type}&courseName=" + courseName + "&departmentsId=" + departmentsId +
            "&majorCode=" + arr[0] + "&trainingLevel=" + arr[1];
        $("#table").DataTable().ajax.url(url).load();
    }

    function searchclear() {
        $("#searchCourseName").val("");
        $("#departmentsIdSearch").val("");
        $("#majorCodeSearch").val("");
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/courseconstr/getList?courseType=${type}").load();
    }

</script>