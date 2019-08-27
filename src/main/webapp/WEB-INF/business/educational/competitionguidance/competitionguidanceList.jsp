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
                        <button type="button" class="btn btn-default btn-clean" onclick="addCompetitionGuidance()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="competitionGuidance" cellpadding="0" cellspacing="0" width="100%"
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
            var competitionName = data.competitionName;

            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/competitionGuidance/toCompetitionGuidanceEdit?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "竞赛项目：" + competitionName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/competitionGuidance/competitionGuidanceDel?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#competitionGuidance').DataTable().ajax.reload();
                        }
                    })
                });
            }

        });
    });

    function addCompetitionGuidance() {
        $("#dialog").load("<%=request.getContextPath()%>/competitionGuidance/toCompetitionGuidanceAdd");
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
            competitionProjectname = '%' + competitionProjectname + '%';
        var prize = $("#prize").val();
       var competitionLevel= $("#appraisalCompany").val()

        roleTable = $("#competitionGuidance").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/competitionGuidance/getCompetitionGuidanceList',
                "data": {
                    competitionName: competitionProjectname,
                    hostUnit:prize,
                    competitionLevel:competitionLevel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "teacherName", "title": "教师姓名"},
                {"width": "15%", "data": "departmentIdShow", "title": "所属系部"},
                {"width": "15%", "data": "competitionName", "title": "竞赛项目"},
                {"width": "15%", "data": "competitionLevel", "title": "竞赛级别"},
                {"width": "15%", "data": "hostUnit", "title": "主办单位"},
                {"width": "15%", "data": "counsellingContent", "title": "辅导内容"},
                {"width": "15%", "data": "semesterShow", "title": "学期"},
                {"width": "15%", "data": "majorId", "title": "专业"},
                {"width": "15%", "data": "classId", "title": "班级"},
                {"width": "15%", "data": "educationalLevel", "title": "学历层次"},
                {"width": "15%", "data": "competitionNumber", "title": "参赛人数"},
                {"width": "15%", "data": "trainingNumber", "title": "培训人数"},
                {"width": "15%", "data": "classHours", "title": "课时数"},
                {"width": "15%", "data": "place", "title": "授课地点"},
                {"width": "15%", "data": "competitionPerformance", "title": "竞赛成绩"},
                {"width": "15%", "data": "fileNumber", "title": "文件数量"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        var html = "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            '<span class="icon-download" title="下载" onclick=upload("' + row.id + '")></span>&ensp;&ensp;';
                        return html
                    }
                }
            ],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
    function upload(id){
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_LECTURE');
        $('#dialogFile').modal('show');
    }
    function reloadFileNumber() {
        $('#competitionGuidance').DataTable().ajax.reload();
    }
</script>


