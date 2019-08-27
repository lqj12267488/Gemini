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
                        <div class="col-md-2">
                            <select id="SubjectIdSel" />
                        </div>
                        <div class="col-md-1 tar">
                            专业名称
                        </div>
                        <div class="col-md-2">
                            <select id="majorIdSel" />
                        </div>
                        <div class="col-md-1 tar">
                            课程名称
                        </div>
                        <div class="col-md-2">
                            <input id="courseNameSel" >
                        </div>
                        <div class="col-md-3 tar">
                            <button type="button" class="btn btn-default btn-clean pull-right"
                                    onclick="searchclear()">清空
                            </button>

                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchResource()">查询
                            </button>

                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addCourse()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tableCourse" cellpadding="0" cellspacing="0"
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
    var tableCourse;
    $(document).ready(function () {
        //  ZYK_TYPE_SUBJECT 学科   --> ZYK_TYPE_MAJOR  专业 -->

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0')"
            },
            function (data) {
                addOption(data, "SubjectIdSel");
            })

        tableCourse = $("#tableCourse").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/typeCourse/getResourceTypeCourseList',
            },
            "destroy": true,
            "columns": [
                {"data":"resourceCourseId","visible": false},
                {"data":"resourceCourseName","title":"课程名称"},
                {"data":"resourceCourseOrder","title":"课程排序"},
                {"data":"resourceMajorIdShow","title":"专业"},
                {"data":"resourceSubjectIdShow","title":"学科"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editCourse("' + row.resourceCourseId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=delCourse("' + row.resourceCourseId + '","'+row.resourceCourseName+'")></span>';
                    }
                }
            ],
            'order' : [2,'asc'],
            "dom": 'rtlip',
            language: language
        });
    })

    $("#SubjectIdSel").change(function(){
        if( $("#SubjectIdSel").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " resource_major_id ",
                    text: " resource_major_name ",
                    tableName: " ZYK_TYPE_MAJOR ",
                    where: " where RESOURCE_SUBJECT_ID='"+$("#SubjectIdSel").val()+"'",
                    orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                },
                function (data) {
                    addOption(data, "majorIdSel");
                })
        }
    });

    function addCourse() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCourse/toResourceTypeCourseAdd")
        $("#dialog").modal("show")
    }

    function editCourse(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCourse/toResourceTypeCourseEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delCourse(id,resourceCourseName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "课程名称："+resourceCourseName+"  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/typeCourse/delResourceTypeCourse", {
                id: id
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                if(msg.status=='1' || msg.status==1) {
                    tableCourse.ajax.reload();
                }
            });
        })
    }

    function searchclear() {
        $("#SubjectIdSel").val("");
        $("#majorIdSel").val("");
        $("#courseNameSel").val("");
        searchResource();
    }

    function searchResource() {
        var SubjectId = $("#SubjectIdSel").val();
        var majorId = $("#majorIdSel").val();
        var courseName = $("#courseNameSel").val();
        tableCourse.ajax.url("<%=request.getContextPath()%>/resourceLibrary/typeCourse/getResourceTypeCourseList?resourceMajorId="+majorId+
                    "&resourceSubjectId="+SubjectId+"&resourceCourseName="+courseName).load();
    }

</script>