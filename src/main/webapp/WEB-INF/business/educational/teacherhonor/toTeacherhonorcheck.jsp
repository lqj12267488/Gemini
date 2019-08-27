<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--维护首页--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">


                <div class="block block-drop-shadow content">

                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                    </div>

                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="coursehonor" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="teacherId" hidden value="${teacherId}">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"CLASS_NAME",
            tableName:"T_JW_COURSECONSTR",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'courseName');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=RYMC", function (data) {
            addOption(data, 'honorName');
        });
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.courseHonorId;
            var courseName = data.courseName;

        });
    });


    function back() {
        $("#right").load("<%=request.getContextPath()%>/teacherhonor/teacherhonorList");
        $("#right").modal("show");
    }




    function search() {
        roleTable = $("#coursehonor").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacherhonor/getTeacherhonorCheckList',
                "data": {
                    teacherId:$("#teacherId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false },
                {"width": "12%", "data": "departmentsIdShow",  "title": "系部"},
                {"width": "12%", "data": "teacherIdShow",   "title": "教师"},
                {"width": "12%", "data": "sexShow", "title": "性别"},
                {"width": "12%", "data": "honorName",  "title": "荣誉名称"},
                {"width": "12%", "data": "ownTime",     "title": "获得时间"},
                {"width": "12%", "data": "honorLevel",   "title": "荣誉等级"},
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });

    }

</script>


