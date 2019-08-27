<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/1
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input id="internshipUnitId" hidden value="${internshipExt.internshipUnitId}">
<div class="container" id="fuye">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${internshipUnitName} > 实习生实习设置</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addInternshipExt()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="internshipExtIdGrid" cellpadding="0" cellspacing="0"
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
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });

        search1();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var internshipUnitId = data.internshipUnitId;
            var internshipUnitIdShow = data.internshipUnitIdShow;
            if (this.id == "getInternshipExtById") {
                $("#dialog").load("<%=request.getContextPath()%>/internshipExt/getInternshipExtById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "selectId"){
                $("#right").load("<%=request.getContextPath()%>/internships/getInternships?id=" + id);
            }

            if (this.id == "del") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "单位名称："+internshipUnitIdShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/internshipExt/deleteInternshipExtById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#internshipExtIdGrid').DataTable().ajax.reload();
                        }
                    })

                });
                /*if (confirm("确定要删除这条记录?")) {
                    $.get("/internshipExt/deleteInternshipExtById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#internshipExtIdGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })
    function addInternshipExt(){
        $("#dialog").load("<%=request.getContextPath()%>/internshipExt/addInternshipExt?internshipUnitId="+$("#internshipUnitId").val());
        $("#dialog").modal("show");
    }
    function back(){
        $("#right").load("<%=request.getContextPath()%>/internshipExt/internshipsList1");

    }

    function search1() {
        roleTable = $("#internshipExtIdGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/internshipExt/internshipExtActionById',
                "data": {
                    internshipUnitId: $("#internshipUnitId").val(),
                    departmentsId: $("#departmentsIdSel option:selected").val(),

                }
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "internshipUnitIdShow", "title": "单位名称"},
                {"width": "20%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "25%", "data": "receiveNumber", "title": "接收实习生数量"},
                {"width": "20%", "data": "salaryShow", "title": "补贴工资"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getInternshipExtById' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='selectId' class='icon-search' title='详情'></a>&nbsp;&nbsp;&nbsp;";

                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
