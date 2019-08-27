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
                            专业名称
                        </div>
                        <div class="col-md-3">
                            <input id="majorNameSel" >
                        </div>
                        <div class="col-md-1 tar">
                            学科名称
                        </div>
                        <div class="col-md-3">
                            <select id="SubjectIdSel" />
                        </div>
                        <div class="col-md-3 tar">
                            <button type="button" class="btn btn-default btn-clean pull-right" style="margin-right: 17%"
                                    onclick="searchclear()">清空
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addMajor()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tableMajor" cellpadding="0" cellspacing="0"
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
    var tableMajor;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
            },
            function (data) {
                addOption(data, "SubjectIdSel");
            })

        tableMajor = $("#tableMajor").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/typeMajor/getResourceTypeMajorList',
            },
            "destroy": true,
            "columns": [
                {"data":"resourceMajorId","visible": false},
                {"data":"resourceMajorName","title":"专业名称"},
                {"data":"resourceMajorOrder","title":"专业排序"},
                {"data":"resourceSubjectIdShow","title":"学科名称"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editMajor("' + row.resourceMajorId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delMajor("' + row.resourceMajorId + '","'+row.resourceMajorName+'")></span>';
                    }
                }
            ],
            'order' : [2,'asc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function addMajor() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeMajor/toResourceTypeMajorAdd")
        $("#dialog").modal("show")
    }

    function editMajor(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeMajor/toResourceTypeMajorEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delMajor(id,resourceMajorName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "专业名称："+resourceMajorName+"  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/typeMajor/delResourceTypeMajor", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#tableMajor').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#majorNameSel").val("");
        $("#SubjectIdSel").val("");
        $("#SubjectIdSel option:selected").val("");
        search();
    }

    function search() {
        var majorName = $("#majorNameSel").val();
        var resourceSubject = $("#SubjectIdSel").val();
        tableMajor.ajax.url("<%=request.getContextPath()%>/resourceLibrary/typeMajor/getResourceTypeMajorList?resourceMajorName="+majorName
                  +"&resourceSubjectId="+ resourceSubject
            ).load();
    }

</script>