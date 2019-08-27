<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/1
  Time: 20:27
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
                                <input id="studentIdSel" placeholder="请输入学生姓名"   type="text"/>
                                <%-- <input id="studentIdSel" class="js-example-basic-single"/>--%>
                            </div>
                            <div class="col-md-1 tar">
                                单位名称：
                            </div>
                            <div class="col-md-2">
                                <select id="internshipUnitIdSel" class="js-example-basic-single"></select>
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
                                onclick="addInternshipManage()">新增
                        </button>

                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="internshipManageGrid" cellpadding="0" cellspacing="0"
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
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "internshipUnitIdSel");
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });

        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var internshipId = data.internshipId;
            var studentIdShow = data.studentIdShow;
            if (this.id == "getInternshipManageById") {
                $.get("<%=request.getContextPath()%>/internshipManage/selectInternshipType?internshipId=" + internshipId, function (String) {
                    if (String == 3) {
                        $("#dialog").load("<%=request.getContextPath()%>/internshipManage/editAddInternshipManageById?internshipId=" + internshipId);
                        $("#dialog").modal("show");
                    }else{
                        $("#dialog").load("<%=request.getContextPath()%>/internshipManage/getInternshipManageById?internshipId=" + internshipId);
                        $("#dialog").modal("show");
                    }
                })
            }


            if(this.id == "change"){
                $.get("<%=request.getContextPath()%>/internshipManage/selectInternshipType?internshipId=" + internshipId, function (String) {
                    if (String == 3) {
                        swal({
                            title: "实习形式为升学，没有实习单位，不能进行实习单位变更！",
                            type: "error"
                        });
                        $('#internshipManageGrid').DataTable().ajax.reload();
                    }
                    else{
                        $("#dialog").load("<%=request.getContextPath()%>/internshipManage/addInternshipChangeLog?internshipId="+internshipId);
                        $("#dialog").modal("show");
                    }
                })
            }
            if(this.id == "getDicMapping"){
                $("#right").load("<%=request.getContextPath()%>/internshipManage/getInternshipManage?internshipId="+internshipId+"&studentIdShow="+studentIdShow);
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
                    $.get("<%=request.getContextPath()%>/internshipManage/deleteInternshipManageById?internshipId=" + internshipId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#internshipManageGrid').DataTable().ajax.reload();
                        }
                    })

                });
               /* if (confirm("确定要删除本条记录?")) {
                    $.get("/internshipManage/deleteInternshipManageById?internshipId=" + internshipId, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#internshipManageGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })


    function addInternshipManage() {
        $("#dialog").load("<%=request.getContextPath()%>/internshipManage/addInternshipManage");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#fstudentNumber").val("");
        $("#studentIdSel").val("");
        $("#internshipUnitIdSel").val("");
        $("#internshipUnitIdSel option:selected").val("");
        search();
    }

    function search() {
        roleTable = $("#internshipManageGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/internshipManage/InternshipManageAction',
                "data": {
                    studentId : $("#studentIdSel").val(),
                    internshipUnitId:$("#internshipUnitIdSel option:selected").val(),
                    studentNumber: $("#fstudentNumber").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "internshipId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%", "data": "studentIdShow", "title": "学生"},
                {"width": "9%", "data": "studentNumber", "title": "学籍号"},
                {"width": "9%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "9%", "data": "majorCodeShow", "title": "专业"},
                {"width": "9%", "data": "classIdShow", "title": "班级"},
                {"width": "10%", "data": "internshipTypeShow", "title": "实习形式"},
                {"width": "9%", "data": "internshipUnitIdShow", "title": "实习单位"},
                {"width": "9%", "data": "internshipPositions", "title": "实习岗位"},
                {"width": "9%", "data": "internshipChangeFlagShow", "title": "单位变动"},
                {"width": "9%", "data": "internshipEvaluationShow", "title": "实习评价"},
                {
                    "width": "9%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getInternshipManageById' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='change' class='icon-refresh' title='变更'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='getDicMapping' class='icon-search' title='查看变更记录'></a>";

                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

