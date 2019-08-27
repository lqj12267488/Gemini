<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <input id="teacherId"  name="teacherId" value="${teacherId}" hidden>
        <div class="col-md-12">
            <div class="block">
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <table id="teacherArray" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#teacherArray").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/workLoad/checkList?teacherId=${teacherId}',
            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {"data":"teachingSituation","title":"教学授课情况"},
                {"data":"hours","title":"教学授课情况课时数"},
                {"data":"raceClass","title":"竞赛辅导班级"},
                {"data":"raceClassNum","title":"竞赛辅导班级人数"},
                {"data":"raceClassContent","title":"竞赛辅导班级内容"},
                {"data":"raceHours","title":"竞赛辅导班级课时数"},
                {"data":"lectureClass","title":"讲座班级"},
                {"data":"lectureClassNum","title":"讲座班级人数"},
                {"data":"lectureClassContent","title":"讲座班级内容"},
                {"data":"lectureClassHours","title":"讲座班级课时数"},
                {"data":"teachingSecretariesHours","title":"教学秘书课时数"},
                {"data":"otherContent","title":"其他工作内容"},
                {"data":"otherHours","title":"其他工作内容课时数"},
                {"data":"term","title":"学期"},
                // {
                //     "title": "操作",
                //     "render": function (data, type, row) {
                //         return '<span class="icon-edit" title="修改" onclick=editTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;' +
                //             '<span class="icon-trash" title="删除" onclick=delTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;';
                //     }
                // }
            ],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc']],
            "dom": 'rtlip',
            language: language
        });
    })

    <%--function editTeacherArray(teacherId) {--%>
        <%--$("#dialog").load("<%=request.getContextPath()%>/workLoad/checkContentEdit?teacherId=" + teacherId)--%>
        <%--$("#dialog").modal("show")--%>
    <%--}--%>

    <%--function delTeacherArray(teacherId) {--%>
        <%--swal({--%>
            <%--title: "您确定要删除本条信息?",--%>
            <%--type: "warning",--%>
            <%--showCancelButton: true,--%>
            <%--cancelButtonText: "取消",--%>
            <%--confirmButtonColor: "#DD6B55",--%>
            <%--confirmButtonText: "删除",--%>
            <%--closeOnConfirm: false--%>
        <%--}, function () {--%>
            <%--$.post("<%=request.getContextPath()%>/workLoad/delContentById", {--%>
                <%--id: id--%>
            <%--}, function (msg) {--%>
                <%--swal({--%>
                    <%--title: msg.msg,--%>
                    <%--type: "success"--%>
                <%--});--%>
                <%--$('#teacherArray').DataTable().ajax.reload();--%>
            <%--});--%>
        <%--})--%>
    <%--}--%>

    function back() {
        $("#right").load("<%=request.getContextPath()%>/workLoad/check");
    }
</script>