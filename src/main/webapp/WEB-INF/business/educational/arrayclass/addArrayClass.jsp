<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">

            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${arrayClass.arrayClassId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        排课计划
                    </div>
                    <div class="col-md-9">
                        <input id="a_arrayClassName" value="${arrayClass.arrayClassName}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="a_term" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        早读学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_morningHours" value="${arrayClass.morningHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        上午学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_forenoonHours" value="${arrayClass.forenoonHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        中午学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_noonHours" value="${arrayClass.noonHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        下午学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_afternoonHours" value="${arrayClass.afternoonHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        晚自习学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_eveningHours" value="${arrayClass.eveningHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="a_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${arrayClass.remark}">${arrayClass.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'a_term', '${arrayClass.term}');
        });
    })

    function save() {
        if ($("#a_arrayClassName").val() == "" || $("#a_arrayClassName").val() == "0" || $("#a_arrayClassName").val() == undefined) {
            swal({
                title: "请填写排课计划！",
                type: "info"
            });
            return;
        }
        if ($("#a_term option:selected").val() == "" || $("#a_term option:selected").val() == "0" || $("#a_term option:selected").val() == undefined) {
            swal({
                title: "请选择要排课学期！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/arrayClass/saveArrayClass", {
            arrayClassId: $("#id").val(),
            arrayClassName: $("#a_arrayClassName").val(),
            term: $("#a_term option:selected").val(),
            forenoonHours:$("#a_forenoonHours").val(),
            morningHours:$("#a_morningHours").val(),
            noonHours:$("#a_noonHours").val(),
            afternoonHours:$("#a_afternoonHours").val(),
            eveningHours:$("#a_eveningHours").val(),
            remark: $("#a_remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#arrayClassGrid').DataTable().ajax.reload();
            }
        })
    }

</script>


