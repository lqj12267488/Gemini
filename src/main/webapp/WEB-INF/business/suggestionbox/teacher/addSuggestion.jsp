<%--
  Description: 意见箱--教师--新增意见
  Creator: 郭千恺
  Date: 2018/9/27 10:43
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
            <span style="font-size: 14px;">我的意见</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>主题
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="title" type="text"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>内容
                    </div>
                    <div class="col-md-10">
                        <div>
                            <textarea id="suggestion" cols="30" rows="10"></textarea>
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

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    <!-- 保存意见 -->
    function save() {
        var title = $("#title").val();
        var suggestion = $("#suggestion").val();

        if (title=="" || title==undefined || title==null) {
            infoMessage("请填写主题!");
            return;
        } else if (title.length > 50) {
            infoMessage("主题太长,请不要超过50字符!");
            return;
        }

        if (suggestion=="" || suggestion==undefined || suggestion==null) {
            infoMessage("请填写意见!");
            return;
        } else if (title.length > 50) {
            infoMessage("意见太长,请不要超过500字符!");
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/suggestionBox/teacher/save", {
            title: title,
            suggestion: suggestion
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
