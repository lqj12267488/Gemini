<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:16
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
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学籍号：
                            </div>
                            <div class="col-md-2">
                                <input id="fstudentNumber" class="js-example-basic-single"/>
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="studentIdSel" placeholder="请输入学生姓名"  class="js-example-basic-single"/>
                            </div>
                            <div class="col-md-1 tar">
                                单位名称：
                            </div>
                            <div class="col-md-2">
                                <select id="employmentUnitIdSel" class="js-example-basic-single"></select>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addEmploymentManage()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="employmentManageGrid" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " employment_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_EMPLOYMENT_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "employmentUnitIdSel");
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });
        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var employmentId = data.employmentId;
            var studentIdShow = data.studentIdShow;
            if (this.id == "getEmploymentManageById") {
                $.get("<%=request.getContextPath()%>/employmentManage/selectEmploymentType?employmentId=" + employmentId, function (String) {
                    if(String == 3){
                        $("#dialog").load("<%=request.getContextPath()%>/employmentManage/editAddEmploymentManageById?employmentId=" + employmentId);
                        $("#dialog").modal("show");
                    }else{
                        $("#dialog").load("<%=request.getContextPath()%>/employmentManage/getEmploymentManageById?employmentId=" + employmentId);
                        $("#dialog").modal("show");
                    }
                })
            }
            if(this.id == "selectId"){
                $("#right").load("<%=request.getContextPath()%>/employmentManage/getEmploymentManageId?employmentId="+employmentId);
            }
            if (this.id == "del") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "学生姓名："+studentIdShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/employmentManage/deleteEmploymentManageById?employmentId=" + employmentId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#employmentManageGrid').DataTable().ajax.reload();
                        }
                    })
                });
               /* if (confirm("确定要删除本条记录?")) {
                    $.get("/employmentManage/deleteEmploymentManageById?employmentId=" + employmentId, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#employmentManageGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })


    function addEmploymentManage() {
        $("#dialog").load("<%=request.getContextPath()%>/employmentManage/addEmploymentManage");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#fstudentNumber").val("");
        $("#studentIdSel").val("");
        $("#employmentUnitIdSel").val("");
        $("#employmentUnitIdSel option:selected").val("");
        search();
    }

    function search() {
        roleTable = $("#employmentManageGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/employmentManage/EmploymentManageAction',
                "data": {
                    studentId : $("#studentIdSel").val(),
                    studentNumber: $("#fstudentNumber").val(),
                    employmentUnitId:$("#employmentUnitIdSel option:selected").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "employmentId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "studentIdShow", "title": "学生"},
                {"width": "11%", "data": "studentNumber", "title": "学籍号"},
                {"width": "12%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "11%", "data": "classIdShow", "title": "班级"},
                {"width": "11%", "data": "majorCodeShow", "title": "专业"},
                {"width": "11%", "data": "employmentTypeShow", "title": "就业形式"},
                {"width": "11%", "data": "employmentUnitIdShow", "title": "就业单位"},
                {"width": "11%", "data": "employmentYear", "title": "就业年份"},
                {
                    "width": "11%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getEmploymentManageById' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='selectId' class='icon-search' title='详情'></a>";

                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

