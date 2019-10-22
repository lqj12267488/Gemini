<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
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
                                <input id="s_name" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                性别：
                            </div>
                            <div class="col-md-2">
                                <select id="s_sex" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                个人薪资要求：
                            </div>
                            <div class="col-md-2">
                                <input id="s_person" type="text" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学历：
                            </div>
                            <div class="col-md-2">
                                <select id="s_education" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                民族：
                            </div>
                            <div class="col-md-2">
                                <select id="s_nation" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                本人求职岗位：
                            </div>
                            <div class="col-md-2">
                                <input id="s_post" type="text" class="validate[required,maxSize[20]] form-control"/>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addInterviewers()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="interviewers" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_interviewers">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 's_education', '${interviewers.education}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 's_nation', '${interviewers.nation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 's_sex', '${interviewers.sex}');
        });
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var projectName = data.name;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/interviewers/getInterviewersById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "selectId"){
                $("#dialog").load("<%=request.getContextPath()%>/interviewers/searchDetils?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "姓名：" + projectName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/interviewers/deleteInterviewersById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#interviewers').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });

    function addInterviewers() {
        $("#dialog").load("<%=request.getContextPath()%>/interviewers/addInterviewers");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#s_name").val("");
        $("#s_sex").val("");
        $("#s_person").val("");
        $("#s_education").val("");
        $("#s_nation").val("");
        $("#s_post").val("");
        search();
    }

    function search() {
        roleTable = $("#interviewers").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/interviewers/getInterviewersList',
                "data": {
                    name: $("#s_name").val(),
                    sex: $("#s_sex option:selected").val(),
                    personSalary: $("#s_person").val(),
                    education: $("#s_education option:selected").val(),
                    nation: $("#s_nation option:selected").val(),
                    job: $("#s_post").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "term", "title": "学期"},
                {"width": "10%", "data": "name", "title": "姓名"},
                {"width": "10%", "data": "sex", "title": "性别"},
                {"width": "10%", "data": "nation", "title": "民族"},
                {"width": "10%", "data": "education", "title": "学历"},
                {"width": "10%", "data": "job", "title": "求职岗位"},
                {"width": "10%", "data": "personSalary", "title": "个人薪资要求"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='selectId' class='icon-search' title='详情'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>


