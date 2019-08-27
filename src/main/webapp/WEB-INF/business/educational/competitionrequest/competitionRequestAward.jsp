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
                                赛项名称：
                            </div>
                            <div class="col-md-2">
                                <input id="competitionRequestName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                指导教师：
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addCompetitionRequest()">
                            新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="importPaperPrize1()">导入</button>
                        <a id="expdata" class="btn btn-default btn-clean" >导出</a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="competitionRequestAward" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_competitionRequest">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {

        search();
        exportGrade();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var name = data.competitionName;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/competitionRequest/getCompetitionRequestAwardById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_COMPETITION_REQUEST');
                $('#dialogFile').modal('show');
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "参赛名称："+name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/competitionRequest/deleteCompetitionRequestById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#competitionRequestAward').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addCompetitionRequest() {
        $("#dialog").load("<%=request.getContextPath()%>/competitionRequest/addCompetitionRequest");
        $("#dialog").modal("show");
    }
    function exportGrade() {
        var href = "<%=request.getContextPath()%>/competitionRequest/exportCompetitionRequestAward";
        $("#expdata").attr("href",href);
    }
    function importPaperPrize1() {
        $("#dialog").load("<%=request.getContextPath()%>/competitionRequest/toImportCompetitionRequest");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#competitionRequestName").val("");
        $("#prize").val("");
        search();
    }

    function search() {
        var competitionRequestname = $("#competitionRequestName").val();
        if (competitionRequestname != "")
            competitionRequestname =  '%'+competitionRequestname+ '%';
        var prize = $("#prize").val();
        var appraisalCompany = $("#appraisalCompany").val();
        roleTable = $("#competitionRequestAward").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/competitionRequest/getCompetitionRequestList',
                "data": {
                    competitionName: competitionRequestname,
                    instructor:prize,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "8%", "data": "competitionName", "title": "竞赛名称"},
                {"width": "8%", "data": "branchMatch", "title": "分赛项"},
                {"width": "8%", "data": "department", "title": "系部"},
                {"width": "8%", "data": "major", "title": "专业"},
                {"width": "8%", "data": "instructor", "title": "指导教师"},
                {"width": "7%", "data": "studentName", "title": "学生姓名"},
                {"width": "8%", "data": "competitionNature", "title": "参赛性质"},
                {"width": "8%", "data": "time", "title": "参赛时间"},
                {"width": "8%", "data": "organizationUnit", "title": "承办单位"},
                {"width": "7%", "data": "sendDept", "title": "发证机关"},
                {"width": "8%", "data": "grade", "title": "级别"},
                {"width": "8%", "data": "score", "title": "成绩"},
                {"width": "8%", "data": "count", "title": "附件数量"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });

    }
</script>


