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
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">

                        <div class="form-row">
                            <div class="col-md-1 tar">
                                竞赛项目：
                            </div>
                            <div class="col-md-2">
                                <input id="competitionProjectName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                竞赛级别：
                            </div>
                            <div class="col-md-2">
                                <select id="appraisalCompany"/>
                            </div>
                            <div class="col-md-1 tar">
                                主办单位：
                            </div>
                            <div class="col-md-2">
                                <input id="prize" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addCompetitionProject()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="competitionProject" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_competitionProject">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJB", function (data) {
            addOption(data, 'appraisalCompany');
        });
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var competitionProject = data.competitionProject;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/competitionProject/getCompetitionProjectById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                $.get("<%=request.getContextPath()%>/competitionProject/selectCompetitionProject?id=" + id, function (aa) {
                    if(aa == true){
                        swal({
                            title: "您要删除的竞赛项目正在使用不能删除！",
                            type: "error"
                        });
                        return;
                    }else {
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "竞赛项目：" + competitionProject + "\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/competitionProject/deleteCompetitionProjectById?id=" + id, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#competitionProject').DataTable().ajax.reload();
                                }
                            })

                        });
                    }
                });

            }

        });
    });
    function addCompetitionProject() {
        $("#dialog").load("<%=request.getContextPath()%>/competitionProject/addCompetitionProject");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#competitionProjectName").val("");
        $("#prize").val("");
        $("#appraisalCompany").val("");
        $("#appraisalCompany option:selected").val("");
        search();
    }

    function search() {
        var competitionProjectname = $("#competitionProjectName").val();
        if (competitionProjectname != "")
            competitionProjectname =  '%'+competitionProjectname+ '%';
        var prize = $("#prize").val();
        roleTable = $("#competitionProject").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/competitionProject/getCompetitionProjectList',
                "data": {
                    competitionProject: competitionProjectname,
                    competitionLevel:$("#appraisalCompany option:selected").val(),
                    competitionCompany:prize
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "competitionProject", "title": "竞赛项目"},
                {"width": "15%", "data": "competitionLevel", "title": "竞赛级别"},
                {"width": "15%", "data": "competitionCompany", "title": "主办单位"},
                {"width": "15%", "data": "year", "title": "年份"},
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

    }
</script>


