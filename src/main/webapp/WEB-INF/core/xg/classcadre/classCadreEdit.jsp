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
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  班级
                    </div>
                    <div class="col-md-9">
                        <input id="className" value="${classCadre.className}" readonly/>
                        <input id="classId" hidden value="${classCadre.classId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   学生
                    </div>
                    <div class="col-md-9">
                        <select id="studentId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  职位
                    </div>
                    <div class="col-md-9">
                        <select id="cadrecoad" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BGB", function (data) {
            addOption(data, 'cadrecoad' );
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " t.student_id ",
                text: " t.name ",
                tableName: "  T_XG_STUDENT t, T_XG_STUDENT_CLASS c ",
                where: "  WHERE t.student_id = c.student_id and c.class_id = '${classCadre.classId}' ",
                orderby: "   "
            },
            function (data) {
                addOption(data, "studentId" );
            });

    });

    function save() {
        var classId = $("#classId").val();
        var studentId = $("#studentId").val();
        var cadrecoad = $("#cadrecoad").val();
        var courseId = $("#courseId").val();
        var courseName = $("#courseName").val();

        if (studentId == "" || studentId == undefined || studentId == null) {
            swal({
                title: "请填写学生！",
                type: "info"
            });
            return;
        }
        if (cadrecoad == "" || cadrecoad == undefined || cadrecoad == null) {
            swal({
                title: "请选择职位！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/classCadre/saveClassCadre", {
            classId:classId,
            studentId:studentId,
            cadrecoad:cadrecoad,
            courseId:'',
            courseName:'',
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: "success"}, function () {
                $("#dialog").modal('hide');
                $('#classCadreTable').DataTable().ajax.reload();
            });
        })
    }
</script>



