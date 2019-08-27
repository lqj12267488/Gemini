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
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课程表名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="timeTableName" type="text" placeholder="请输入课程表名称" value="${data.timeTableName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 执行日期
                    </div>
                    <div class="col-md-9">
                        <input id="executionDate" type="date" placeholder="请输入执行日期" value="${data.executionDate}"/>
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

    });

    function save() {
        var id = $("#id").val();
        var timeTableName = $("#timeTableName").val();
        var executionDate = $("#executionDate").val();

        if (timeTableName == "" || timeTableName == undefined || timeTableName == null) {
            swal({
                title: "请填写课程表名称!",
                type: "info"
            });
            return;
        }
        if (executionDate == "" || executionDate == undefined || executionDate == null) {
            swal({
                title: "请填写执行日期!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/timeTable/saveTimetable", {
            id: id,
            timeTableName: timeTableName,
            executionDate: executionDate,
        }, function (msg) {
            hideSaveLoading();

            if (msg.status == 1) {
                swal({title: msg.msg, type: msg.result});
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                swal({title: msg.msg, type: msg.result});
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>



