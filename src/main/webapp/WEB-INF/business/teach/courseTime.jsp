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
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px;">新增</span>
                <input hidden name="id" id="id" value="${data.id}">
            </div>
            <div class="modal-body clearfix">
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>名称
                        </div>
                        <div class="col-md-9">
                            <input id="name" value="${data.name}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>开始时间
                        </div>
                        <div class="col-md-9">
                            <input id="startTime" type="time" value="${data.startTime}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>结束时间
                        </div>
                        <div class="col-md-9">
                            <input id="endTime" type="time" value="${data.endTime}"/>
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
    </form>
</div>

<script>

    function save() {
        var id = $("#id").val();
        var name = $("#name").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        if (name == "" || name == undefined || name == null) {
            swal({
                title: "请填写名称！",
                type: "info"
            });
            return;
        }
        if (startTime == "" || startTime == undefined || startTime == null) {
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if (endTime == "" || endTime == undefined || endTime == null) {
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }

        if ($("#startTime").val() >= $("#endTime").val()){
            swal({
                title: "开始时间应早于结束时间！",
                type: "info"
            });
            return;
        }


        $.post("<%=request.getContextPath()%>/teach/saveCourseTime", {
            id: id,
            name: name,
            startTime: startTime,
            endTime: endTime
        }, function (data) {
            swal({
                title: data.msg,
                type: "info"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



