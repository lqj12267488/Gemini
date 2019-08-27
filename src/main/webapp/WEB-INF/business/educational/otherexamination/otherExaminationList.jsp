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
                            学期
                        </div>
                        <div class="col-md-2">
                            <select id="term"/>
                        </div>
                        <div class="col-md-1 tar">
                            考试名称:
                        </div>
                        <div class="col-md-2">
                            <input id="examName" type="text"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            科目:
                        </div>
                        <div class="col-md-2">
                            <input id="courseId" type="text"/>
                        </div>

                        <div class="col-md-1 tar">
                            考核方式:
                        </div>
                        <div class="col-md-2">
                            <select id="examType" name="examMethod" class="required" msg="请选择考核方式！"></select>
                        </div>

                        <%--<div class="col-md-1 tar">--%>
                            <%--考试时间:--%>
                        <%--</div>--%>
                        <%--<div class="col-md-2">--%>
                            <%--<input id="examDateSearch" type="date"/>--%>
                        <%--</div>--%>
                        <%--<div class="col-md-1 tar">--%>
                            <%--上传人:--%>
                        <%--</div>--%>
                        <%--<div class="col-md-2">--%>
                            <%--<input id="uploadingPersonSearch" type="text"/>--%>
                        <%--</div>--%>
                        <div class="col-md-2">
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'examType');
        });
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherExamination/getOtherExaminationList'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "term", "visible": false},
                {"data": "examType", "visible": false},
                {"data": "course", "visible": false},

                // {"data": null, "targets": 0, "title": "序号"},
                {"data": "termShow", "title": "学期"},
                {"data": "examName", "title": "考试名称"},
                {"data": "courseShow", "title": "科目"},
                {"data": "examTypeShow", "title": "考核方式"},
                // {"data": "uploadingPerson", "title": "上传人"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-align-justify" title="成绩录入" onclick=toImport("' + row.id + '","' + row.term + '","' + row.examName + '","' + row.course + '","' + row.examType + '")/>';
                    }
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            // "fnRowCallback": function (nRow, aData, iDisplayIndex) {
            //     $("td:first", nRow).html(iDisplayIndex + 1);//设置序号位于第一列，并顺次加一
            //     return nRow;
            // },
            language: language
        });
    })

    function toImport(id,term,examName,course,examType) {
        $("#right").load("<%=request.getContextPath()%>/otherExamination/import?id=" + id +"&term="+term+"&examName="+examName+"&course="+course+"&examType="+examType)
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/toOtherExaminationAdd", {});
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/toOtherExaminationAdd?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
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
            $.get("<%=request.getContextPath()%>/otherExamination/deleteOtherExamination?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })

        });
    }

    function search() {
        var term = $("#term").val();
        var examName = $("#examName").val();
        var courseId = $("#courseId").val();
        var examType = $("#examType").val();
        table.ajax.url("<%=request.getContextPath()%>/otherExamination/getOtherExaminationList?" + "examName=" + examName + "&term=" + term + "&course=" + courseId+"&examType="+examType
        ).load();
    }

    function searchclear() {
        $("#term").val("");
        $("#examName").val("");
        $("#courseId").val("");
        $("#examType").val("");
        search();
    }

    function uploadFile(id) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id);
        $('#dialogFile').modal('show');
    }

</script>
