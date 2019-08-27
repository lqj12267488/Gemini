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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="backTo()">返回
                        </button>
                        <br>
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
<input id="courseHonorId" hidden value="${courseHonorId}">
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



    function search() {
        roleTable = $("#coursehonor").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/coursehonor/getCoursehonorCheckList',
                "data": {
                    courseHonorId:$("#courseHonorId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "courseHonorId", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "12%", "data": "courseName",  "title": "课程名称"},
                {"width": "12%", "data": "chargeMan",   "title": "负责人"},
                {"width": "12%", "data": "honorMember", "title": "成员"},
                {"width": "12%", "data": "honorLevel",  "title": "荣誉等级"},
                {"width": "12%", "data": "ownTime",     "title": "获得时间"},
                {"width": "12%", "data": "validTime",   "title": "有效期"},
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
    function backTo() {
        $("#right").load("<%=request.getContextPath()%>/coursehonor/coursehonorList")
    }

</script>


