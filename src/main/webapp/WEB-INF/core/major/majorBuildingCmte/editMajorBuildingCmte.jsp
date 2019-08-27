<%--
  Description: 
  Creator: 郭千恺
  Date: 2018/10/8 11:27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>专业名称
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="majorShow" type="text" value="${detail.majorShow}"/>
                            <input id="majorId" type="hidden" value="${detail.majorId}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>专业建设指导委员会职务
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="cmtePost" type="text" value="${detail.cmtePost}" maxlength="50"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-8">
                        <input id="teacherName" type="text" value="${detail.teacherName}"/>
                        <input id="personId" type="hidden" value="${detail.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>工作单位
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="workUnit" type="text" value="${detail.workUnit}" maxlength="50"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>职务
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="mpost" type="text" value="${detail.teacherPost}" maxlength="50"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        <span class="iconBtx">*</span>职称
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="mtitle" type="text" value="${detail.teacherTitle}" maxlength="50"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        联系电话
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="telephone" type="text" value="${detail.telephone}" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();" maxlength="11"/>
                        </div>
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
<input id="mid" hidden value="${detail.id}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $.get("<%=request.getContextPath()%>/major/majorBuildingCmte/getMajorList", function (data) {
        $("#majorShow").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#majorShow").val(ui.item.label);
                $("#majorShow").attr("keycode", ui.item.value);
                $("#majorId").val(ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        }
    });

    $.get("<%=request.getContextPath()%>/major/majorBuildingCmte/getTeacherList", function (data) {
        $("#teacherName").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#teacherName").val(ui.item.label);
                $("#teacherName").attr("keycode", ui.item.value);
                $("#personId").val(ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };
    });

    $(document).ready(function () {
        <%--$.get("<%=request.getContextPath()%>/common/getMajorByDeptId", function (data) {--%>
            <%--addOption(data, "majorId", "${detail.majorId}");--%>
        <%--});--%>
        <%--$.get("<%=request.getContextPath()%>/major/majorBuildingCmte/getTeacherList", function (data) {--%>
            <%--addOption(data, "personId", "${detail.personId}");--%>
        <%--});--%>
    });
    <!-- 保存成员 -->
    function save() {
        var majorId = $('#majorId').val();
        var cmtePost = $('#cmtePost').val();
        var personId = $('#personId').val();
        var workUnit = $('#workUnit').val();
        var telephone = $('#telephone').val();
        var mpost = $('#mpost').val();
        var mtitle = $('#mtitle').val();
        var mid = $('#mid').val();

        if (majorId=="" || majorId==undefined || majorId==null) {
            infoMessage("请选择专业!");
            return;
        }
        if (cmtePost=="" || cmtePost==undefined || cmtePost==null) {
            infoMessage("请填写职务!");
            return;
        }
        if (personId=="" || personId==undefined || personId==null) {
            infoMessage("请填写姓名!");
            return;
        }
        if (workUnit=="" || workUnit==undefined || workUnit==null) {
            infoMessage("请填写工作单位!");
            return;
        }
        if (mpost=="" || mpost==undefined || mpost==null) {
            infoMessage("请填写职务!");
            return;
        }
        if (mtitle=="" || mtitle==undefined || mtitle==null) {
            infoMessage("请填写职称!");
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/major/majorBuildingCmte/save", {
            id:mid,
            majorId: majorId,
            cmtePost: cmtePost,
            personId: personId,
            workUnit: workUnit,
            telephone: telephone,
            teacherPost:mpost,
            teacherTitle:mtitle
        }, function (success) {
            hideSaveLoading();
            if (success) {
                successMessage("保存成功!");
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                errorMessage("保存失败!");
            }
        });
    }
    <!-- 提示*3 -->
    function infoMessage(msg, type) {
        swal({
            title: msg,
            type: type || "info"
        });
    }
    function successMessage(msg, type) {
        swal({
            title: msg,
            type: type || "success"
        });
    }
    function errorMessage(msg, type) {
        swal({
            title: msg,
            type: type || "error"
        });
    }
</script>