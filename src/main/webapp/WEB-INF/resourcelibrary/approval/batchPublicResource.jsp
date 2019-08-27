<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>
<div class="modal-dialog">
    <div class="tanchu-content">
        <div class="tanchu-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="margin-left:30px">批量上传</span>
        </div>
        <div class="tanchu">
            <div class="tc_list">
                <div class="tc_l_l">
                    学科
                </div>
                <div class="tc_l_r">
                    <select id="resourceSubjectId" style="width:100%"/>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    专业
                </div>
                <div class="tc_l_r">
                    <select id="resourceMajorId" style="width:100%">
                        <option value="">
                            请选择
                        </option>
                    </select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    课程
                </div>
                <div class="tc_l_r">
                    <select id="resourceCourseId" style="width:100%">
                        <option value="">
                            请选择
                        </option>
                    </select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    课程
                </div>
                <div class="tc_l_r">
                    <input id="ssi-upload" type="file" multiple/>
                </div>
            </div>
        </div>
        <div class="tc_an">
            <button type="button" class="tc_btn2" onclick="closeDialog()">关闭
            </button>
        </div>
    </div>
</div>
<input id="personId" type="hidden" value="${personId}">
<script>
    var resourceSubjectId = "";
    var resourceMajorId = "";
    var resourceCourseId = ""
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " RESOURCE_SUBJECT_ID ",
            text: " RESOURCE_SUBJECT_NAME ",
            tableName: " ZYK_TYPE_SUBJECT ",
            where: " ",
            orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
        }, function (data) {
            addOption(data, "resourceSubjectId");
        })
        $('#ssi-upload').ssi_uploader({
            url: "<%=request.getContextPath()%>/resourcePublic/batchUpdate?resourceSubjectId=" + resourceSubjectId +
            "&resourceMajorId=" + resourceMajorId + "&resourceCourseId=" + resourceCourseId,
            maxFileSize: 2048,
            preview: false,
            allowed: ['jpg', 'gif', 'txt', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'rar', 'zip', 'ppt', 'pptx',
                'avi', 'wmv', 'mpeg', 'mp4', 'mov', 'mkv', 'flv', 'f4v', 'm4v', 'rmvb', 'rm', '3gp', 'dat', 'ts', 'mts', 'vob'],
            beforeUpload: function () {
                resourceSubjectId = $("#resourceSubjectId").val()
                resourceMajorId = $("#resourceMajorId").val()
                resourceCourseId = $("#resourceCourseId").val()
                if (resourceSubjectId == "") {
                    swal({
                        title: "请选择学科！",
                        type: "success"
                    })
                }
            },
            onUpload: function () {
                $("#dialog").modal("hide")
                swal({
                    title: "上传成功！",
                    type: "success"
                }, function () {
                    tablePrivate.ajax.reload()
                });
            }
        });
    });

    $("#resourceSubjectId").change(function () {
        if ($("#resourceSubjectId").val() != "") {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                where: " where RESOURCE_SUBJECT_ID ='" + $("#resourceSubjectId").val() + "'",
                orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
            }, function (data) {
                addOption(data, "resourceMajorId", '${data.resourceMajorId}');
            })
        }
    });

    $("#resourceMajorId").change(function () {
        if ($("#resourceMajorId").val() != "") {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " RESOURCE_COURSE_ID ",
                text: " RESOURCE_COURSE_NAME ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where RESOURCE_MAJOR_ID ='" + $("#resourceMajorId").val() + "' ",
                orderby: "  "
            }, function (data) {
                addOption(data, "resourceCourseId");
            })
        }
    });
</script>

