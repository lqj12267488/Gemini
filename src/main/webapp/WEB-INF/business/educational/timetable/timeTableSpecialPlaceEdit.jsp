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
                        <span class="iconBtx">*</span> 特殊标识
                    </div>
                    <div class="col-md-9">
                        <div>
                            <select id="specialFlag">
                                <option value="虚线顶部" selected>虚线顶部</option>
                                <option value="虚线底部">虚线底部</option>
                                <option value="虚线左部">虚线左部</option>
                                <option value="虚线右部">虚线右部</option>
                                <option value="实线顶部">实线顶部</option>
                                <option value="实线底部">实线底部</option>
                                <option value="实线左部">实线左部</option>
                                <option value="实线右部">实线右部</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 特殊地点
                    </div>
                    <div class="col-md-9">
                        <input id="specialPlace" type="text" placeholder="请输入特殊地点" value="${data.specialPlace}"/>
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
        var specialFlag = "${data.specialFlag}";
        $("#specialFlag").val(specialFlag);
    });

    function save() {
        var id = $("#id").val();
        var specialFlag = $("#specialFlag").val();
        var specialPlace = $("#specialPlace").val();
        if (specialFlag == "" || specialFlag == undefined || specialFlag == null) {
            swal({
                title: "请选择特殊标识!",
                type: "info"
            });
            return;
        }
        if (specialPlace == "" || specialPlace == undefined || specialPlace == null) {
            swal({
                title: "请填写特殊地点!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/timeTableSpecialPlace/saveTimeTableSpecialPlace", {
            id: id,
            specialFlag: specialFlag,
            specialPlace: specialPlace
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: msg.result});
            if (msg.status == '0') {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                return;
            }
        })
    }
</script>



