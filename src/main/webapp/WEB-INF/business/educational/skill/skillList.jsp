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
                                项目名称：
                            </div>
                            <div class="col-md-2">
                                <input id="skillName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                承办单位：
                            </div>
                            <div class="col-md-2">
                                <input id="appraisalCompany" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                鉴定时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="month"
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addSkill()">
                            新增
                        </button>
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
<input id="tableName" hidden value="t_jw_skill">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var projectName = data.projectName;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/skill/getSkillById?id=" + id);
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
                    $.get("<%=request.getContextPath()%>/skill/deleteSkillById?id=" + id, function (msg) {
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
        $("#dialog").load("<%=request.getContextPath()%>/skill/addSkill");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#skillName").val("");
        $("#requestdate").val("");
        $("#appraisalCompany").val("");
        search();
    }

    function search() {
        var skillname = $("#skillName").val();
        if (skillname != "")
            skillname =  '%'+skillname+ '%';
        var date = $("#requestdate").val();
        var appraisalCompany = $("#appraisalCompany").val();
        roleTable = $("#skill").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/skill/getSkillList',
                "data": {
                    projectName: skillname,
                    appraisalTime:date,
                    appraisalCompany:appraisalCompany
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "projectName", "title": "项目名称"},
                {"width": "15%", "data": "appraisalTime", "title": "鉴定时间"},
                {"width": "15%", "data": "appraisalCompany", "title": "承办单位"},
                {"width": "15%", "data": "appraisalNumber", "title": "鉴定人数"},
                {"width": "15%", "data": "projectLevel", "title": "项目级别"},
                {"width": "15%", "data": "issuingOffice", "title": "发证机关"},
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
            "dom": 'rtlip',
            language: language
        });

    }
</script>


