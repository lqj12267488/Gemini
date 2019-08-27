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
                            学段
                        </div>
                        <div class="col-md-2">
                            <select id="SubjectIdSel" onchange="changgeSubject()"/>
                        </div>
                        <div class="col-md-1 tar">
                            年级
                        </div>
                        <div class="col-md-2">
                            <select id="majorIdSel" onchange="changeMajor()"/>
                        </div>
                        <div class="col-md-1 tar">
                            科目
                        </div>
                        <div class="col-md-2">
                            <select id="courseNameSel" ></select>
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
                            <table id="tableJPKType" cellpadding="0" cellspacing="0"
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
        //  ZYK_TYPE_SUBJECT 学段   --> ZYK_TYPE_MAJOR  年级 -->

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

        tableCourse = $("#tableJPKType").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/JPK/getJPKResourceTypeList',
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible": false},
                {"data":"createTime","visible": false},
                {"data":"resourceSubjectIdShow","title":"学段"},
                {"data":"resourceMajorIdShow","title":"年级"},
                {"data":"resourceCourseName","title":"科目"},
                {"data":"jpkTypeName","title":"精品课类型"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editCourse("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=delCourse("' + row.id + '","'+row.jpkTypeName+'")></span>';
                    }
                }
            ],
            'order' : [1,'asc'],
            "dom": 'rtlip',
            language: language
        });
    })

    $("#SubjectIdSel").change(function(){
        $("#majorIdSel").val('');
        if( $("#SubjectIdSel").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " resource_major_id ",
                    text: " resource_major_name ",
                    tableName: " ZYK_TYPE_MAJOR ",
                    where: " where RESOURCE_SUBJECT_ID='"+$("#SubjectIdSel").val()+"'",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "majorIdSel");
                })
        }
    });
    function changeMajor() {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_COURSE_ID ",
                text: " RESOURCE_COURSE_NAME ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where RESOURCE_SUBJECT_ID ='"+$("#SubjectIdSel").val()+"' and RESOURCE_MAJOR_ID = '"+$("#majorIdSel").val()+"'",
                orderby: "  "
            },
            function (data) {
                addOption(data, "courseNameSel");
            })
    }
    function changgeSubject() {
        $("#majorIdSel").val('');
        $("#courseNameSel").val('');
    }
    function addCourse() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/JPK/JPKResourceTypeAddSkip")
        $("#dialog").modal("show")
    }

    function editCourse(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/JPK/JPKResourceTypeEditSkip?id=" + id)
        $("#dialog").modal("show")
    }

    function delCourse(id,resourceCourseName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "科目名称："+resourceCourseName+"  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/JPK/delJPKResourceType", {
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
        tableCourse.ajax.url("<%=request.getContextPath()%>/resourceLibrary/JPK/getJPKResourceTypeList?resourceMajorId="+majorId+
                    "&resourceSubjectId="+SubjectId+"&resourceCourseId="+courseName).load();
    }

</script>