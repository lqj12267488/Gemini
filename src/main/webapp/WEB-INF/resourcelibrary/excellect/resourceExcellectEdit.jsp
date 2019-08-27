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
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" value="${data.resourceName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源类型
                    </div>
                    <div class="col-md-9">
                        <select id="resourceType"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        学段
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectId" onchange="changexuaduan()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        年级
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorId" onchange="changenianji()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        科目
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseId"  onchange="change()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        精品课类型
                    </div>
                    <div class="col-md-9">
                        <select id="jpkResourceTypeName" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版本
                    </div>
                    <div class="col-md-9">
                        <select id="f_edition" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源格式
                    </div>
                    <div class="col-md-9">
                        <select id="resourceFormat" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        提供人
                    </div>
                    <div class="col-md-9">
                        <input id="publicName" value="${data.publicPersonIdShow}" readonly/>
                    </div>
                </div>
     <%--           <div class="col-md-3 tar">
                    是否设置为精品课
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio"  class="validate[required]"
                                   name="startFlag"
                                   value="0" id="no" onchange="changejpk()"/> 否
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" class="validate[required]"
                                   name="startFlag" value="1" id="ok" onchange="changejpk()"/> 是
                        </label>
                    </div>

                </div>
                <div class="form-row" id="jpkdiv">
                    <div class="col-md-3 tar">
                        精品课类型
                    </div>
                    <div class="col-md-9">
                        <select id="jpkResourceTypeName" />
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"  value="${data.remark}"/>
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
<input id="f_excellectId" hidden value="${data.excellectId}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data, 'resourceType','${data.resourceType}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            addOption(data, 'resourceFormat','${data.resourceFormat}');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=ZYK_BB", function (data) {
            addOption(data, 'f_edition','${data.edition}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " id ",
                text: " resource_jpktypename ",
                tableName: " ZYK_EXCELLECT_TYPE  ",
                where: " where resource_subject_id = '"+'${data.resourceSubjectId}'+"' and resource_major_id = '"+'${data.resourceMajorId}'+"' and resource_course_id = '"+'${data.resourceCourseId}'+"'",
                orderby: " "
            },
            function (data) {
                addOption(data, "jpkResourceTypeName",'${data.jpkTypeName}');
            })
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
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                where: " where RESOURCE_SUBJECT_ID ='"+'${data.resourceSubjectId}'+"'",
                orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceMajorId",'${data.resourceMajorId}');
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_COURSE_ID ",
                text: " RESOURCE_COURSE_NAME ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where RESOURCE_MAJOR_ID ='"+'${data.resourceMajorId}'+"' ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "resourceCourseId",'${data.resourceCourseId}');
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
                    addOption(data, "resourceCourseId",'${data.resourceMajorId}');
                })
        }
    });

    function changexuaduan(){
        $('#resourceMajorId').val('');
        $('#resourceCourseId').val('');
        $('#jpkResourceTypeName').val('');
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                where: " where RESOURCE_SUBJECT_ID ='"+$("#resourceSubjectId").val()+"'",
                orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceMajorId");
            })
    }
    function changenianji() {
        $('#resourceCourseId').val('');
        $('#jpkResourceTypeName').val('');
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_COURSE_ID ",
                text: " RESOURCE_COURSE_NAME ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where RESOURCE_MAJOR_ID ='"+$("#resourceMajorId").val()+"' ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "resourceCourseId",'${data.resourceMajorId}');
            })
    }
    function change() {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " id ",
                text: " resource_jpktypename ",
                tableName: " ZYK_EXCELLECT_TYPE  ",
                where: " where resource_subject_id = '"+$("#resourceSubjectId").val()+"' and resource_major_id = '"+$("#resourceMajorId").val()+"' and resource_course_id = '"+$("#resourceCourseId").val()+"'",
                orderby: " "
            },
            function (data) {
                addOption(data, "jpkResourceTypeName");
            })
    }
    function save() {
        var resourceName = $("#resourceName").val();
        var resourceType = $("#resourceType").val();
        var resourceSubjectId = $("#resourceSubjectId").val();
        var resourceMajorId = $("#resourceMajorId").val();
        var resourceCourseId = $("#resourceCourseId").val();
        var resourceFormat = $("#resourceFormat").val();
        var aedition = $("#f_edition").val();
        var remark = $("#remark").val();
        var jpkTypeName = $("#jpkResourceTypeName").val();
        var f_excellectId = $("#f_excellectId").val();
        if(jpkTypeName =="" || jpkTypeName ==null || jpkTypeName==undefined){
            swal({
                title: "请填写精品课类型名称！",
                type: "info"
            });
            return;
        }
        if (resourceName == "" || resourceName == undefined || resourceName == null) {
            swal({
                title: "请填写资源名称！",
                type: "info"
            });
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({
                title: "请选择学段！",
                type: "info"
            });
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({
                title: "请选择年级！",
                type: "info"
            });
            return;
        }
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({
                title: "请选择科目！",
                type: "info"
            });
            return;
        }
        if (aedition == "" || aedition == undefined || aedition == null) {
            swal({
                title: "请选择版本！",
                type: "info"
            });
            return;
        }
        if (resourceFormat == "" || resourceFormat == undefined || resourceFormat == null) {
            swal({
                title: "请选择资源格式！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/resourcePublic/excellect/updateExcellect", {
            excellectId: f_excellectId,
            resourceName: resourceName,
            resourceType: resourceType,
            resourceSubjectId: resourceSubjectId,
            resourceMajorId: resourceMajorId,
            resourceCourseId: resourceCourseId,
            resourceFormat: resourceFormat,
            edition: aedition,
            remark: remark,
            jpkTypeName: jpkTypeName,
        }, function(msg){
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#tableResource').DataTable().ajax.reload();
            }
        })

    }
</script>



