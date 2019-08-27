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
                        <button type="button" class="btn btn-default btn-clean" onclick="addSkill()">
                            新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="showSkillAppraisalDialog()">
                            导入
                        </button>
                        <%--<button type="button" class="btn btn-default btn-clean"   id="expdata"  >
                            导出
                        </button>--%>
                        <a id="expdata" class="btn btn-default btn-clean" >导出</a>

                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="skill" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_skillappraisal">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var projectName = data.preAppProfessionShow;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/skillAppraisal/getskillAppraisalById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "项目名称："+projectName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/skillAppraisal/deleteSkillAppraisalById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#skill').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addSkill() {
        $("#dialog").load("<%=request.getContextPath()%>/skillAppraisal/addskillAppraisal");
        $("#dialog").modal("show");
    }

    function searchclear() {

        search();
    }

    //  导向导入页面
    function showSkillAppraisalDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/toImportSkillAppraisal");
        $("#dialog").modal("show");
    }

    function exportSkillAppraisal() {
        $("#dialog").load("<%=request.getContextPath()%>/skillAppraisal/exportSkillAppraisalt");
        $("#dialog").modal("show");
    }


    function search() {

        roleTable = $("#skill").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/skillAppraisal/getskillAppraisalList',
                "data": {

                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "gradeShow", "title": "班级"},
                {"width": "10%", "data": "entranceDate", "title": "入学时间"},
                {"width": "10%", "data": "schoolSystemShow", "title": "学制"},
                {"width": "10%", "data": "preAppProfessionShow", "title": "项目名称"},
                {"width": "10%", "data": "professionLevel", "title": "级别"},
                {"width": "10%", "data": "studentNameShow", "title": "姓名"},
                {"width": "10%", "data": "preAppDate", "title": "拟鉴定时间"},
                {"width": "10%", "data": "projectLevel", "title": "项目级别"},
                {"width": "10%", "data": "issuingOffice", "title": "发证机关"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
        exportInfo();
    }

    function exportInfo(){
        var hhh = "<%=request.getContextPath()%>/skillAppraisal/exportSkillAppraisalt";
        $("#expdata").attr("href",hhh);
    }
</script>


