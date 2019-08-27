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
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="awardWinningName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                竞赛名：
                            </div>
                            <div class="col-md-2">
                                <select id="appraisalCompany" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                奖项：
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addAwardWinning()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="awardWinning" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_awardWinning">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id:"id",
                text:"competition_project",
                tableName:"T_JW_COMPETITION_PROJECT",
                where:"WHERE valid_flag ='1'",
                orderBy:""}
            , function (data) {
                addOption(data, 'appraisalCompany');
            });

        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var name = data.name;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/awardWinning/getAwardWinningById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_AWARDWINNING');
                $('#dialogFile').modal('show');
            }

            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "姓名："+name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/awardWinning/deleteAwardWinningById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#awardWinning').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addAwardWinning() {
        $("#dialog").load("<%=request.getContextPath()%>/awardWinning/addAwardWinning");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#awardWinningName").val("");
        $("#prize").val("");
        $("#appraisalCompany").val("");
        search();
    }

    function search() {
        var awardWinningname = $("#awardWinningName").val();
        if (awardWinningname != "")
            awardWinningname =  '%'+awardWinningname+ '%';
        var prize = $("#prize").val();
        var appraisalCompany = $("#appraisalCompany").val();
        roleTable = $("#awardWinning").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/awardWinning/getAwardWinningList',
                "data": {
                    name: awardWinningname,
                    prize:prize,
                    competitionName:appraisalCompany
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "name", "title": "姓名"},
                {"width": "15%", "data": "competitionName", "title": "竞赛名"},
                {"width": "15%", "data": "awardTime", "title": "获奖时间"},
                {"width": "15%", "data": "prize", "title": "奖项"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
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


