<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--楼宇场地维护首页--%>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addCoursehonor()">
                            新增
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
<input id="tableName" hidden value="T_JW_EXAM_TOPIC">
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
    function addCoursehonor() {
        $("#dialog").load("<%=request.getContextPath()%>/coursehonor/addCoursehonor");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#courseName").val("");
        $("#courseName option:selected").val("");
        $("#honorName").val("");
        $("#honorName option:selected").val("");
        $("#ownTime").val("");
        search();
    }

    function search() {
        roleTable = $("#coursehonor").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/coursehonor/getCoursehonorList',
                "data": {
                    courseName:$("#courseName option:selected").val(),
                    honorName:$("#honorName option:selected").val(),
                    ownTime:$("#ownTime").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "courseHonorId", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "12%", "data": "courseName",  "title": "课程名称"},
                {"width": "12%", "data": "chargeMan",   "title": "负责人"},
                {"width": "12%", "data": "honorMember", "title": "成员"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.courseHonorId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.courseHonorId + '")/>&ensp;&ensp;' +
                            '<span class="icon-asterisk" title="管理" onclick=manage("' + row.courseHonorId + '")/>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="查看" onclick=check("' + row.courseHonorId + '")/>&ensp;&ensp;' ;
                    }
                }
            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }




    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/coursehonor/getCoursehonorById?id=" + id);
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
            $.get("<%=request.getContextPath()%>/coursehonor/deleteCoursehonorById?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#coursehonor').DataTable().ajax.reload();
            })

        });
    }

    function manage(id) {
        $("#right").load("<%=request.getContextPath()%>/coursehonor/toCoursehonorManager?id=" + id);
    }


    function check(id) {
        $("#right").load("<%=request.getContextPath()%>/coursehonor/toCoursehonorCheck?id=" + id);
    }





</script>


