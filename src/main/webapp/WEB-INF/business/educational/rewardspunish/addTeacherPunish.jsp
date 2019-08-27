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
            <button type="button" onclick="closedwindow()" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="pid" hidden value="${punish.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 被惩处人
                    </div>
                    <div class="col-md-4">
                        <input id="edit_punishPersonId" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${punish.punishPersonId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处名称
                    </div>
                    <div class="col-md-4">
                        <input id="edit_punishName" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${punish.punishName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处日期
                    </div>
                    <div class="col-md-4">
                        <input id="edit_punishTime" type="date" value="${punish.punishTime}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处级别
                    </div>
                    <div class="col-md-4">
                        <select id="edit_punishLevel" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处学期
                    </div>
                    <div class="col-md-4">
                        <select type="text" id="edit_punishTerm" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处文号
                    </div>
                    <div class="col-md-4">
                        <input type="text" id="edit_punishDocumentNumber"
                               class="validate[required,maxSize[100]] form-control"
                               value="${punish.punishDocumentNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处内容
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_punishContent" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${punish.punishContent}">${punish.punishContent}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处原因
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_punishReason" type="text"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${punish.punishReason}">${punish.punishReason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处状态
                    </div>
                    <div class="col-md-4">
                        <select id="edit_punishStatus"
                                class="validate[required,maxSize[20]] form-control"
                                value="${punish.punishStatus}" onchange="punishStatusChange()"/>
                    </div>
                </div>
                <div id="cancelTimeDiv" class="form-row">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>撤销时间
                        </div>
                        <div class="col-md-4">
                            <input id="edit_cancelTime"
                                   class="validate[required,maxSize[100]] form-control"
                                   type="date"
                                   value="${punish.cancelTime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 撤销文号
                        </div>
                        <div class="col-md-4">
                            <input id="edit_cancelDocumentNumber" value="${punish.cancelDocumentNumber}"
                                   class="validate[required,maxSize[100]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>撤销原因
                        </div>
                        <div class="col-md-10">
                            <textarea id="edit_cancelReason"
                                      class="validate[required,maxSize[100]] form-control">${punish.cancelReason}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_remark"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${punish.remark}">${punish.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button id="btn1" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        if ('${punish.punishStatus}' == "2") {
            $("#cancelTimeDiv").hide();
        }
        else {
            $("#cancelTimeDiv").show();
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'edit_punishTerm', '${punish.punishTerm}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSCCJB", function (data) {
            addOption(data, 'edit_punishLevel', '${punish.punishLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSCCZT", function (data) {
            addOption(data, 'edit_punishStatus', '${punish.punishStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#edit_punishPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#edit_punishPersonId").val(ui.item.label);
                    $("#edit_punishPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

        })
        var ppid = $("#pid").val();
        if (ppid != "") {
            $("#edit_punishPersonId").val("${punish.punishPersonId}");
            $("#edit_punishPersonId").attr("keycode", "${punish.punishPersonDeptId}");
        }

        if ($("#flag").val() == '1' || $("#flag").val() == 1) {
            $("#btn1").hide();
            $("input").attr('readOnly', 'readOnly');
            $("select").attr('disabled', 'disabled');
            $("textarea").attr('readOnly', 'readOnly');
        }

    })

    function closedwindow() {
        $("input").removeAttr("readOnly");
    }

    function saveDept() {

        if ($("#edit_punishPersonId").attr("keycode") == "" || $("#edit_punishPersonId").attr("keycode") == undefined) {
            swal({
                title: "请填写并选择被惩处人姓名！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishName").val() == "" || $("#edit_punishName").val() == undefined) {
            swal({
                title: "请填写惩处名称！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishTime").val() == "" || $("#edit_punishTime").val() == undefined) {
            swal({
                title: "请填写惩处日期！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishLevel option:selected").val() == "" || $("#edit_punishLevel option:selected").val() == undefined) {
            swal({
                title: "请选择惩处级别！",
                type: "info"
            });
            return;
        }

        if ($("#edit_punishReason").val() == "" || $("#edit_punishReason").val() == undefined) {
            swal({
                title: "请填写惩处原因！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishContent").val() == "" || $("#edit_punishContent").val() == undefined) {
            swal({
                title: "请填写惩处内容！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishDocumentNumber").val() == "" || $("#edit_punishDocumentNumber").val() == undefined) {
            swal({
                title: "请填写惩处文号！",
                type: "info"
            });
            return;
        }
        if ($("#edit_punishStatus option:selected").val() == "" || $("#edit_punishStatus option:selected").val() == undefined) {
            swal({
                title: "请选择惩处状态！",
                type: "info"
            });
            return;
        }

        if ($("#edit_punishStatus option:selected").val() == 1) {
            if ($("#edit_cancelTime").val() == "" || $("#edit_cancelTime").val() == undefined) {
                swal({
                    title: "请填写撤销日期！",
                    type: "info"
                });
                return;
            }
            if ($("#edit_cancelReason").val() == "" || $("#edit_cancelReason").val() == undefined) {
                swal({
                    title: "请填写撤销原因！",
                    type: "info"
                });
                return;
            }
            if ($("#edit_cancelDocumentNumber").val() == "" || $("#edit_cancelDocumentNumber").val() == undefined) {
                swal({
                    title: "请填写撤销文号！",
                    type: "info"
                });
                return;
            }

            if (new Date($("#edit_punishTime").val()).getTime() > new Date($("#edit_cancelTime").val()).getTime()) {
                swal({
                    title: "惩处日期要早于撤销日期！",
                    type: "info"
                });
                return;
            }
        }


        if ($("#edit_punishTerm option:selected").val() == "" || $("#edit_punishTerm option:selected").val() == undefined) {
            swal({
                title: "请填写惩处学期！",
                type: "info"
            });
            return;
        }
        var pid = $("#pid").val();
        var headT = $("#edit_punishPersonId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/punishs/updatepunishById", {
            id: pid,
            punishPersonId: headTList[1],
            punishPersonDeptId: headTList[0],
            punishName: $("#edit_punishName").val(),
            punishTime: $("#edit_punishTime").val(),
            punishLevel: $("#edit_punishLevel option:selected").val(),
            punishReason: $("#edit_punishReason").val(),
            punishContent: $("#edit_punishContent").val(),
            punishDocumentNumber: $("#edit_punishDocumentNumber").val(),
            punishTerm: $("#edit_punishTerm").val(),
            cancelTime: $("#edit_cancelTime").val(),
            cancelReason: $("#edit_cancelReason").val(),
            cancelDocumentNumber: $("#edit_cancelDocumentNumber").val(),
            punishStatus: $("#edit_punishStatus option:selected").val(),
            remark: $("#edit_remark").val(),

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#punishGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end
function punishStatusChange() {
    var tmp = $("#edit_punishStatus").val();
    if (tmp == "2") {
        $("#cancelTimeDiv").hide();
    }
    else {
        $("#cancelTimeDiv").show();
    }

}
</script>



