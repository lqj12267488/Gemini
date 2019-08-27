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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
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
                        晨读学时数
                    </div>
                    <div class="col-md-9">
                        <select id="a_morningHours" class="js-example-basic-single" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        上午学时数
                    </div>
                    <div class="col-md-9">
                        <select id="a_forenoonHours" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        中午学时数
                    </div>
                    <div class="col-md-9">
                        <select id="a_noonHours" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        下午学时数
                    </div>
                    <div class="col-md-9">
                        <select id="a_afternoonHours" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        晚自习学时数
                    </div>
                    <div class="col-md-9">
                        <select id="a_eveningHours" class="js-example-basic-single"></select>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXS", function (data) {
            addOption(data, 'a_forenoonHours', '${arrayClass.forenoonHours}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXS", function (data) {
            addOption(data, 'a_morningHours', '${arrayClass.morningHours}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXS", function (data) {
            addOption(data, 'a_noonHours', '${arrayClass.noonHours}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXS", function (data) {
            addOption(data, 'a_afternoonHours', '${arrayClass.afternoonHours}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXS", function (data) {
            addOption(data, 'a_eveningHours', '${arrayClass.eveningHours}');
        });
    })

    function save() {
        if ($("#a_arrayClassName").val() == "" || $("#a_arrayClassName").val() == "0" || $("#a_arrayClassName").val() == undefined) {
            swal({
                title: "请填写排课计划",
                type: "info"
            });
            //alert("请填写排课计划");
            return;
        }
        if ($("#a_term option:selected").val() == "" || $("#a_term option:selected").val() == "0" || $("#a_term option:selected").val() == undefined) {
            swal({
                title: "请选择要排课学期",
                type: "info"
            });
            //alert("请选择要排课学期");
            return;
        }
        if ($("#a_morningHours option:selected").val() == "" || $("#a_morningHours option:selected").val() == undefined) {
            swal({
                title: "请选择晨读学时数",
                type: "info"
            });
            //alert("请选择晨读学时数");
            return;
        }
        if ($("#a_forenoonHours option:selected").val() == "" || $("#a_forenoonHours option:selected").val() == undefined) {
            swal({
                title: "请选择上午学时数",
                type: "info"
            });
            //alert("请选择上午学时数");
            return;
        }
        if ($("#a_noonHours option:selected").val() == "" || $("#a_noonHours option:selected").val() == undefined) {
            swal({
                title: "请选择中午学时数",
                type: "info"
            });
            //alert("请选择中午学时数");
            return;
        }
        if ($("#a_afternoonHours option:selected").val() == "" || $("#a_afternoonHours option:selected").val() == undefined) {
            swal({
                title: "请选择下午学时数",
                type: "info"
            });
            //alert("请选择下午学时数");
            return;
        }
        if ($("#a_eveningHours option:selected").val() == "" || $("#a_eveningHours option:selected").val() == undefined) {
            swal({
                title: "请选择晚自习学时数",
                type: "info"
            });
            //alert("请选择晚自习学时数");
            return;
        }
        if ($("#id").val() == ""){
            $.post("<%=request.getContextPath()%>/arrayClass/saveArrayClass", {
                arrayClassId: $("#id").val(),
                arrayClassName: $("#a_arrayClassName").val(),
                term: $("#a_term option:selected").val(),
                forenoonHours:$("#a_forenoonHours option:selected").val(),
                morningHours:$("#a_morningHours option:selected").val(),
                noonHours:$("#a_noonHours option:selected").val(),
                afternoonHours:$("#a_afternoonHours option:selected").val(),
                eveningHours:$("#a_eveningHours option:selected").val(),
                remark: $("#a_remark").val()
            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal('hide');
                    $('#arrayClassGrid').DataTable().ajax.reload();
                }
            })
        }else{
            //if (confirm("修改后需重新填写学时时间信息，确认修改？")){
            swal({
                title: "修改后需重新填写学时时间信息，确认修改?",
                //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/arrayClass/saveArrayClass", {
                    arrayClassId: $("#id").val(),
                    arrayClassName: $("#a_arrayClassName").val(),
                    term: $("#a_term option:selected").val(),
                    forenoonHours:$("#a_forenoonHours option:selected").val(),
                    morningHours:$("#a_morningHours option:selected").val(),
                    noonHours:$("#a_noonHours option:selected").val(),
                    afternoonHours:$("#a_afternoonHours option:selected").val(),
                    eveningHours:$("#a_eveningHours option:selected").val(),
                    remark: $("#a_remark").val()
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $("#dialog").modal('hide');
                        $('#arrayClassGrid').DataTable().ajax.reload();
                    }
                })
            })
        }

    }

</script>


