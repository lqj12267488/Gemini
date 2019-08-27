<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
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
                                作品名称：
                            </div>
                            <div class="col-md-2">
                                <input id="resourceName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="searchPersonalWorks()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addPersonalWorks()">
                            新增作品
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="personalWorksGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
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
        searchBranch();

        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var resourceName = data.resourceName;
            if (this.id == "editPersonalWorks") {
                $("#dialog").load("<%=request.getContextPath()%>/StudentPersonalWorks/toStudentPersonalWorksEdit?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delPersonalWorks") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "作品名称：" + resourceName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/StudentPersonalWorks/delStudentPersonalWorks", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        table.ajax.reload();

                    });
                })
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_XS_PERSONALWORKS');
                $('#dialogFile').modal('show');
            }
        });
    });

    function addPersonalWorks() {
        $("#dialog").load("<%=request.getContextPath()%>/studentSpace/toStudentPersonalWorksAdd");
        $("#dialog").modal("show");
    }
    function searchClear() {
        $("#resourceName").val("");
        searchBranch();
    }
    function searchPersonalWorks() {
        var resourceName = $("#resourceName").val();
        if (resourceName != "")
            resourceName = '%'+resourceName+'%';
        table = $("#personalWorksGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentSpace/getPersonalWorksList',
                "data": {
                    resourceName: resourceName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "18%", "data": "resourceName", "title": "作品名称"},
                {"width": "20%", "data": "remark", "title": "作品描述"},
                {"width": "18%", "data": "uploadTime", "title": "上传时间"},
                {
                    "width": "10%", "title": "操作", "render": function () {
                    return "<a id='editPersonalWorks' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delPersonalWorks' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>";
                }
                }
            ],
            'order': [4, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>
