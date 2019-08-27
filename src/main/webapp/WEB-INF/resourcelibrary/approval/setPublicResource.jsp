<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="approvalId" hidden value="${approvalId}"/>
            <input id="resourceId" hidden value="${resourceId}"/>
            <input id="approvalOpinion" hidden value="${approvalOpinion}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md">
                        资源名称
                    </div>
                    <div class="col-md">
                        ${resourceName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        资源格式
                    </div>
                    <div class="col-md">
                        <select id="resourceFormat"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        学科
                    </div>
                    <div class="col-md">
                        <select id="resourceSubjectId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        专业
                    </div>
                    <div class="col-md">
                        <select id="resourceMajorId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        课程
                    </div>
                    <div class="col-md">
                        <select id="resourceCourseId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md">
                        提供人
                    </div>
                    <div class="col-md">
                        ${requester}
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            addOption(data,'resourceFormat');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceSubjectId",'${data.resourceSubjectId}');
            })
    });

    $("#resourceSubjectId").blur(function(){
        if( $("#resourceSubjectId").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " resource_major_id ",
                    text: " resource_major_name ",
                    tableName: " ZYK_TYPE_MAJOR ",
                    where: " where RESOURCE_SUBJECT_ID ='"+$("#resourceSubjectId").val()+"'",
                    orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                },
                function (data) {
                    addOption(data, "resourceMajorId",'${data.resourceMajorId}');
                })
        }
    });

    $("#resourceMajorId").blur(function(){
        if( $("#resourceMajorId").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_MAJOR_ID ='"+$("#resourceMajorId").val()+"' ",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "resourceCourseId");
                })
        }
    });


    function save() {
        var approvalId = $("#approvalId").val();
        var resourceId = $("#resourceId").val();
        var resourceFormat = $("#resourceFormat").val();
        var resourceSubjectId = $("#resourceSubjectId").val();
        var resourceMajorId = $("#resourceMajorId").val();
        var resourceCourseId = $("#resourceCourseId").val();
        var approvalOpinion = $("#approvalOpinion").val();

        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({title: "请选择学科！",type: "info"});
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({title: "请选择专业！",type: "info"});
            return;
        }
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({title: "请选择课程！",type: "info"});
            return;
        }

        $.post("<%=request.getContextPath()%>/resourcePublic/addResourcePublic", {
            approvalId:approvalId,
            resourceId:resourceId,
            resourceFormat:resourceFormat,
            resourceSubjectId:resourceSubjectId,
            resourceMajorId:resourceMajorId,
            resourceCourseId:resourceCourseId,
            approvalOpinion:approvalOpinion,
        }, function (msg) {
            swal({title: msg.msg,type: msg.result});
            closeDialog();
            $('#tableApproval').DataTable().ajax.reload();

        })
    }
</script>
<style>
    .modal-dialog {
        width: 400px;
        height: 400px;
    }

</style>


