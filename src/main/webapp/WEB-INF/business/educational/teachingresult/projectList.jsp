<%--项目(课题)管理
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/24
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="personId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                所属部门：
                            </div>
                            <div class="col-md-2">
                                <input id="deptId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                项目名称：
                            </div>
                            <div class="col-md-2">
                                <input id="projectName" type="text"/>                                    </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addProject()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="projectGrid" cellpadding="0" cellspacing="0"
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
    var projectTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/teacherResult/getPerson", function (data) {
            $("#personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#personId").val(ui.item.label);
                    $("#personId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/businessCar/getDept", function (data) {
            $("#deptId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#deptId").val(ui.item.label);
                    $("#deptId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();

        projectTable.on('click', 'tr a', function () {
            var data = projectTable.row($(this).parent()).data();
            var id = data.id;
            var projectName = data.projectName;
            var flag="0";
            //修改
            if (this.id == "uProject") {
                $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project?id=" + id);
                $("#dialog").modal("show");
            }
            //附件上传
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=JKYCG');
                $('#dialogFile').modal('show');
            }
            //查看emp
            if (this.id == "check") {
                $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project",{id:id,flag:"on"});
                $("#dialog").modal("show");
            }
            //删除
            if (this.id == "delProject") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "项目名称：" + projectName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/teacherResult/deleteTeachingResult/project?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#projectGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })
    //新增
    function addProject() {
        $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project");
        $("#dialog").modal("show");
    }
    //清空
    function searchClear() {
        $("#deptId").val("");
        $("#personId").val("");
        $("#projectName").val("");
        search();
    }
    //列表查询
    function search(){
        var personId = $("#personId").val();
        var deptId = $("#deptId").val();
        var projectName = $("#projectName").val();
        projectTable = $("#projectGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacherResult/getResultList/project',
                "data": {
                    personId: personId,
                    deptId: deptId,
                    projectName: projectName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "7%", "data": "personId", "title": "姓名"},
                {"width": "12%", "data": "deptId", "title": "所属部门"},
                {"width": "17%", "data": "projectName", "title": "项目名称"},
                {"width": "12%", "data": "projectType", "title": "项目类型"},
                {"width": "12%", "data": "typicalFlag", "title": "代表项目"},
                {"width": "12%", "data": "projectRole", "title": "本人角色"},
                {"width": "12%", "data": "subject", "title": "学科领域"},
                {"width": "10%", "data": "remark", "title": "备注"},
//                {
//                    "width": "7%",
//                    "title": "附件",
//                    "render": function () {
//                        return "<button style='text-align:center' type='button' id='upload' onclick='uploadFiles()'>上传附件</button>";
//                    }
//                },
                {"width": "6%","title": "操作","render": function () {return "<a id='uProject' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='check' class='icon-search' title='查看'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delProject' class='icon-trash' title='删除'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function uploadFiles() {
        alert(00);
    }
</script>
