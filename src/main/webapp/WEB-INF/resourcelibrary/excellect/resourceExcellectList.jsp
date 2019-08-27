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
                            学科
                        </div>
                        <div class="col-md-2">
                            <select id="SubjectIdSel" />
                        </div>
                        <div class="col-md-1 tar">
                            专业
                        </div>
                        <div class="col-md-2">
                            <select id="majorIdSel" />
                        </div>
                        <div class="col-md-1 tar">
                            课程
                        </div>
                        <div class="col-md-2">
                            <select id="CourseIdSel" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            资源名称
                        </div>
                        <div class="col-md-2">
                            <input id="resourceNameSel" />
                        </div>
                        <div class="col-md-9 tar">
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
                                    onclick="add()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tableResource" cellpadding="0" cellspacing="0"
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
    var tableResource;
    $(document).ready(function () {

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


        tableResource = $("#tableResource").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourcePublic/getResourceEcellectList',
            },
            "destroy": true,
            "columns": [
                {"data":"excellectId","visible": false},
                {"data":"resourceSubjectId","visible": false},
                {"data":"resourceMajorId","visible": false},
                {"data":"resourceCourseId","visible": false},
                {"data":"resourceName","title":"资源名称"},
                {"data":"resourceType","title":"资源类型"},/* 使用ZYK_ZYLX字典 */
                {"data":"resourceSubjectIdShow","title":"学段"},
                {"data":"resourceMajorIdShow","title":"年级"},
                {"data":"resourceCourseIdShow","title":"科目"},
                {"data":"jpkTypeName","title":"精品课类型"},
                {"data":"resourceFormat","title":"资源格式"},/* 使用ZYK_ZYGS字典 */
                {"data":"publicFlag","title":"公共资源","visible": false},
                {"data":"classicFlagCode","title":"精品课","visible": false},
                {"data":"publicPersonIdShow","title":"提供人"},
                {"data":"publicTime","title":"公开时间"},
             //   {"data":"classicFlag","title":"精品课标识"},

                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var re = "";
/*
                        if(row.resourceSubjectId=="4fe5842b-5811-4a9d-aea8-d475b394e77a"){
                            r  = '<span class="icon-file-text-alt" title="设置"' +
                                ' onclick=add("' + row.resourceId + '")></span>&ensp;&ensp;';
                        }
*/                /*        if(row.classicFlagCode == 0 || row.classicFlagCode == '0' ){
                            re = re + '<span class="icon-gift" title="设置精品课" onclick=upreasources("' + row.resourceId + '")/></span>&ensp;&ensp;';
                        }*/
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.excellectId + '")></span>&ensp;&ensp;' +
                            re+
                            '<span class="icon-trash" title="删除" onclick=del("' + row.excellectId + '","'+row.resourceName+'")></span>';
                    }
                }
            ],
            'order' : [10,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    $("#SubjectIdSel").blur(function(){
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

    $("#majorIdSel").blur(function(){
        if( $("#majorIdSel").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_MAJOR_ID='"+$("#majorIdSel").val()+"'",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "CourseIdSel");
                })
        }
    });

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePublic/toResourceExcellectAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePublic/toResourceExcellectEdit?excellectId=" + id)
        $("#dialog").modal("show")
    }

    function del(id,resourceName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "资源名称：《"+resourceName+"》  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourcePublic/excellect/deleteExcellect", {
                excellectId: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#tableResource').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#SubjectIdSel option:selected").val("");
        $("#majorIdSel option:selected").val("");
        $("#CourseIdSel option:selected").val("");
        $("#SubjectIdSel").val("");
        $("#majorIdSel").val("");
        $("#CourseIdSel").val("");
        $("#resourceNameSel").val("");
        searchResource();
    }

    function searchResource() {
        var SubjectId = $("#SubjectIdSel").val();
        var majorId = $("#majorIdSel").val();
        var CourseId = $("#CourseIdSel").val();
        var resourceName = $("#resourceNameSel").val();

        tableResource.ajax.url("<%=request.getContextPath()%>/resourcePublic/getResourceEcellectList?resourceSubjectId="+SubjectId+
            "&resourceMajorId="+majorId+"&resourceCourseId="+CourseId+"&resourceName="+resourceName).load();
    }

/*    function upreasources(resourceId) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/JPK/setJPKResourceSkip" +
            "?resourceId="+resourceId);
        $("#dialog").modal("show")
    }*/
</script>