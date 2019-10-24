<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>类别：
                    </div>
                    <div class="col-md-9">
                        <input id="mtNameEdit" value="${mtTypeEdit.mtName}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script type="text/javascript">

    function save() {

        if ("" == $("mtNameEdit").val()) {
            swal({title: "请填写内容", type: "error"});
        } else {
            if (!isNaN(parseInt($("#mtNameEdit").val()))) {
                swal({title: "不能填写纯数字类型", type: "error"});
            } else {
                $.post("<%=request.getContextPath()%>/mtType/saveMtType", {
                    mtId: "${mtTypeEdit.mtId}",
                    mtName: $("#mtNameEdit").val(),
                }, function (msg) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#mtTypeGrid').DataTable().ajax.reload();
                })
            }
        }
    }
</script>
