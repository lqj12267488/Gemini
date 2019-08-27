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
                                竞赛项目
                            </div>
                            <div class="col-md-2">
                                <input id="competitionProjectSearch"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;
    $(document).ready(function () {

        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacher/getCompetitionList'
            },
            "destroy": true,
            "columns": [
                {"data": "competitionId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "competitionProject", "title": "竞赛项目"},
                {"data": "competitionGroup", "title": "竞赛组别"},
                {"data": "competitionLevel", "title": "竞赛级别"},
                {"data": "hostUnit", "title": "主办单位"},
                {"data": "score", "title": "获奖情况"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.competitionId + '")/>&ensp;&ensp;' +
                            '<a id="upload" class="icon-cloud-upload" title="上传竞赛文件影像资料和证书" onclick=addFiles("' + row.competitionId + '")></a>&nbsp;&nbsp;&nbsp;'+
                            '<span class="icon-trash" title="删除" onclick=delCom("' + row.competitionId  + '")/>';
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    })



    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddCompetition")
        $("#dialog").modal("show")
    }

    function edit(teacherId) {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddCompetition?competitionId=" + teacherId)
        $("#dialog").modal("show")
    }

    function delCom(competitionId) {
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
                $.post("<%=request.getContextPath()%>/teacher/deleteCompetitionIdById", {
                    competitionId: competitionId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();

            });

        });

    }

    function search() {
        var competitionProjectSearch = $("#competitionProjectSearch").val();
        var url = "<%=request.getContextPath()%>/teacher/getCompetitionList?competitionProject=" + competitionProjectSearch;
        $("#table").DataTable().ajax.url(url).load();
    }

    function searchclear() {
        $("#competitionProjectSearch").val("");
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/teacher/getCompetitionList").load();
    }
    function addFiles(competitionId) {
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUploadCompetition?businessId="+competitionId+"&businessType=&tableName=");
        $("#dialogFile").modal("show");
    }
</script>
