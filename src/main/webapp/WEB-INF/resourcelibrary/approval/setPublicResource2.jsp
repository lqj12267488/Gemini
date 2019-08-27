<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
            <span style="font-size: 14px;">${head} &nbsp;</span>
            <input id="approvalId" hidden value="${approvalId}"/>
            <input id="resourceId" hidden value="${resourceId}"/>
            <input id="approvalOpinion" hidden value="${approvalOpinion}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源名称
                    </div>
                    <div class="col-md-9">
                        ${resourceName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源格式
                    </div>
                    <div class="col-md-9">
                        <select id="resourceFormat"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseId" onchange="change()"/>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-3 tar">
                        提供人
                    </div>
                    <div class="col-md-9">
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
<input id="resourceName" hidden value="${resourceName}">
<input id="requester" hidden value="${requester}">
<input id="resourceType" hidden value="${resourceType}">
<input id="uploadPersonCode" hidden value="${uploadPersonCode}">
<input id="uploadDeptCode" hidden value="${uploadDeptCode}">
<script>
    $(document).ready(function () {
        $('#no').attr("checked", true);
        changejpk();
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
    function changejpk() {
        var jpkvalue = $('input[name="startFlag"]:checked').val();
        if (jpkvalue == '0') {
            $('#jpkdiv').hide();
        } else {
            $('#jpkdiv').show();
        }
    }

    function change() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id ",
                text: " resource_jpktypename ",
                tableName: " ZYK_EXCELLECT_TYPE  ",
                where: " where resource_subject_id = '" + $("#resourceSubjectId").val() + "' and resource_major_id = '" + $("#resourceMajorId").val() + "' and resource_course_id = '" + $("#resourceCourseId").val() + "'",
                orderby: " "
            },
            function (data) {
                addOption(data, "jpkResourceTypeName");
            })
    }

    function save() {
        var approvalId = $("#approvalId").val();
        var resourceId = $("#resourceId").val();
        var resourceFormat = $("#resourceFormat option:selected").val();
        var resourceSubjectId = $("#resourceSubjectId option:selected").val();
        var resourceMajorId = $("#resourceMajorId option:selected").val();
        var resourceCourseId = $("#resourceCourseId option:selected").val();
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
            $.post("<%=request.getContextPath()%>/resourceLibrary/approval/setResourceApproval", {
                approvalId:" ",
                resourceId:resourceId,
                approvalOpinion:" ",
                requestFlag:2,
                approvalFlag:1,
                requestType:1,
            }, function (msg) {})

            swal({title: msg.msg,type: msg.result});
            $("#dialog").modal('hide');
            $("#tablePrivate").DataTable().ajax.reload();
        })
        if ($('input[name="startFlag"]:checked').val() == '1') {
            $.post("<%=request.getContextPath()%>/resourceLibrary/saveExcellect/Private", {
                resourceId: resourceId,
                resourceName: '${resourceName}',
                resourceFormat: resourceFormat,
                resourceSubjectId: resourceSubjectId,
                resourceMajorId: resourceMajorId,
                resourceCourseId: resourceCourseId,
                resourceTypeCode: $('#resourceType').val(),
                uploadPersonCode: $('#uploadPersonCode').val(),
                uploadDeptCode: $('#uploadDeptCode').val(),
                jpkTypeName: $('#jpkResourceTypeName').val()
            }, function (msg) {
                swal({title: msg.msg, type: msg.result});
                $("#dialog").modal('hide');
                $('#tablePrivate').DataTable().ajax.reload();
            })
        }
    }
</script>


