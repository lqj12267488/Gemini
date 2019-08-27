<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            学科名称
                        </div>
                        <div class="col-md-3">
                            <input id="subjectNameSql"/>
                        </div>
                        <div class="col-md-8">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addSubject()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tableSubject" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var tableSubject;
    $(document).ready(function () {
        tableSubject = $("#tableSubject").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/typeSubject/getResourceTypeSubjectList',
            },
            "destroy": true,
            "columns": [
                {"data":"resourceSubjectId","visible": false},
                {"data":"resourceSubjectName","title":"学科名称"},
                {"data":"resourceSubjectOrder","title":"学科排序"},
                {"data":"remark","title":"备注"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editSubject("'+row.resourceSubjectId+'")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delSubject("'+row.resourceSubjectId+'","'+row.resourceSubjectName+'")></span>';
                    }
                }
            ],
            'order' : [2,'asc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function addSubject() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeSubject/toResourceTypeSubjectAdd")
        $("#dialog").modal("show")
    }

    function editSubject(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeSubject/toResourceTypeSubjectEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delSubject(id,resourceSubjectName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "学科名称："+resourceSubjectName+"  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/typeSubject/delResourceTypeSubject", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#tableSubject').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#subjectNameSql").val("");
        search();
    }

    function search() {
        var subjectName = $("#subjectNameSql").val();
        tableSubject.ajax.url("<%=request.getContextPath()%>/resourceLibrary/typeSubject/getResourceTypeSubjectList?resourceSubjectName="+subjectName).load();
    }

</script>