<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="teacherId" hidden value="${teacherId}">
            <input id="teacherHonorManageId" hidden value="${teacherhonor.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>荣誉名称
                </div>
                <div class="col-md-9">
                    <SELECT id="honorName"/>
                </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        获得时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_ownTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${teacherhonor.ownTime}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        荣誉级别
                    </div>
                    <div class="col-md-9">
                        <select id="f_honorLevel" />
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DJ", function (data) {
            addOption(data, 'f_honorLevel','${teacherhonor.honorLevel}');
        });

        $.get("<%=request.getContextPath()%>/common/getUserDict?name=RYMC", function (data) {
            addOption(data, 'honorName','${teacherhonor.honorName}');
        });

        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if( $("#honorName").val() == "" || $("#honorName").val() == "0" || $("#honorName").val() == undefined){
            swal({
                title: "请填写荣誉名称！",
                type: "info"
            });
            return;
        }
        if( $("#f_ownTime").val() == "" || $("#f_ownTime").val() == "0" || $("#f_ownTime").val() == undefined){
            swal({
                title: "请填写获得时间！",
                type: "info"
            });
            return;
        }
        if ($("#f_honorLevel").val() == "" || $("#f_honorLevel").val() == "0") {
            swal({
                title: "请选择荣誉级别！",
                type: "info"
            });
            return;
        }
        if($("#person").attr("keycode")=="" || $("#person").attr("keycode") ==null){
            $("#person").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/teacherhonor/saveTeacherhonorManage", {
            id:$("#teacherHonorManageId").val(),
            teacherId: $("#teacherId").val(),
            honorLevel: $("#f_honorLevel").val(),
            ownTime: $("#f_ownTime").val(),
            honorName: $("#honorName").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#coursehonor').DataTable().ajax.reload();
            }
        showSaveLoading();
    }
        )}
</script>

