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
            <input id="resourceId" hidden value="${data.resourceId}"/>
            <input id="publicPersonIdValue" hidden value="${data.publicPersonId}"/>
            <input id="publicDeptIdValue" hidden value="${data.publicDeptId}"/>
            <input id="publicPersonIdShowValue" hidden value="${data.publicPersonIdShow}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>

            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资源名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" value="${data.resourceName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资源类型
                    </div>
                    <div class="col-md-9">
                        <select id="resourceType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectId" value="${data.resourceSubjectId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorId" value="${data.resourceMajorId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseId" value="${data.resourceCourseId}"/>
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
                        <span class="iconBtx">*</span>提供人
                    </div>
                    <div class="col-md-9">
                        <input id="publicPersonId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>公开时间
                    </div>
                    <div class="col-md-9">
                        <input id="publicTime" type="date" value="${data.publicTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"  maxlength="150" placeholder="最多输入150个字" value="${data.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
       var resourceId=$("#resourceId").val();
        if(resourceId!=null){
            $("#publicPersonId").attr("readonly","readonly").css("background-color","#2c5c82;");
            $("#publicTime").attr("readonly","readonly").css("background-color","#2c5c82;");

        }
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#publicPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#publicPersonId").val(ui.item.label);
                    $("#publicPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data, 'resourceType','${data.resourceType}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            addOption(data, 'resourceFormat','${data.resourceFormat}');
        });

        if($("#publicPersonIdValue").val()!=""){
            $("#publicPersonId").val( $("#publicPersonIdShowValue").val());
            $("#publicPersonId").attr("keycode",$("#publicDeptIdValue").val()+","+$("#publicPersonIdValue").val());
        }

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

        if('${data.resourceSubjectId}'!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " resource_major_id ",
                    text: " resource_major_name ",
                    tableName: " ZYK_TYPE_MAJOR ",
                    where: " where RESOURCE_SUBJECT_ID ='${data.resourceSubjectId}' ",
                    orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                },
                function (data) {
                    addOption(data, "resourceMajorId",'${data.resourceMajorId}');
                })
        }

        if('${data.resourceMajorId}'!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_MAJOR_ID ='${data.resourceMajorId}' ",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "resourceCourseId",'${data.resourceCourseId}');
                })
        }
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
        var resourceId = $("#resourceId").val();
        var resourceName = $("#resourceName").val();
        var resourceType = $("#resourceType").val();
        var resourceSubjectId = $("#resourceSubjectId").val();
        var resourceMajorId = $("#resourceMajorId").val();
        var resourceCourseId = $("#resourceCourseId").val();
        var resourceFormat = $("#resourceFormat").val();
        var publicPersonId = $("#publicPersonId").attr("keycode");
        var remark = $("#remark").val();
        var publicDeptId;
        if(publicDeptId!=undefined){
            publicDeptId =   publicPersonId.split(",")[0];
        }
        var publicPersonId;
        if(publicPersonId!=undefined){
            publicPersonId =   publicPersonId.split(",")[1];
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
                title: "请选择学科！",
                type: "info"
            });
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        if (publicPersonId == "" || publicPersonId == undefined || publicPersonId == null) {
            swal({
                title: "请填写提供人！",
                type: "info"
            });
            return;
        }

        var publicTime =$("#publicTime").val().toString();
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/resourcePublic/saveResourcePublic", {
            resourceId:resourceId,
            resourceName:resourceName,
            resourceType:resourceType,
            resourceSubjectId:resourceSubjectId,
            resourceMajorId:resourceMajorId,
            resourceCourseId:resourceCourseId,
            resourceFormat:resourceFormat,
            publicPersonId:publicPersonId,
            publicDeptId:publicDeptId,
            remark:remark,
            publicTime :publicTime,
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#tableResource').DataTable().ajax.reload();
        })
    }
</script>



