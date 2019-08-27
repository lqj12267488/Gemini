<%--资产报废管理申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="f_Id" name="f_Id" type="hidden" value="${assetsScrap.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        资产编号
                    </div>
                    <div class="col-md-9">
                        <input id="f_assetsId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="12" placeholder="最多输入12个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${assetsScrap.assetsId}"/>
                    </div>
                </div>--%>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        资产名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_assetsName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${assetsScrap.assetsName}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        报废原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${softinstall.reason}">${assetsScrap.reason}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${assetsScrap.requestDept}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        经办人
                    </div>
                    <div class="col-md-9">
                        <input id="f_manager" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${assetsScrap.manager}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${assetsScrap.requestDate}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${assetsScrap.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">
                保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getDept", function (data) {
            $("#f_requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requestDept").val(ui.item.label);
                    $("#f_requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })
    })

    function saveDept(){
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
       /* if ($("#f_assetsId").val() == "" || $("#f_assetsId").val() == "0" || $("#f_assetsId").val() == undefined) {
             swal({
                title: "请填写资产编号!",
                type: "info"
            });
            return;
        }*/
        if ($("#f_assetsName").val() == "" || $("#f_assetsName").val() == "0" || $("#f_assetsName").val() == undefined) {
             swal({
                title: "请填写资产名称!",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
             swal({
                title: "请填写报废原因!",
                type: "info"
            });
            return;
        }
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
             swal({
                title: "请填写申请部门!",
                type: "info"
            });
            return;
        }
        if ($("#f_manager").val() == "" || $("#f_manager").val() == "0" || $("#f_manager").val() == undefined) {
             swal({
                title: "请填写经办人!",
                type: "info"
            });
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0" || $("#f_reason").val() == undefined) {
             swal({
                title: "请填写申请时间!",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        /*if(!reg.test($("#f_assetsId").val())){
             swal({
                title: "资产编号请填写数字!",
                type: "info"
            });
            return;
        }*/
        $.post("<%=request.getContextPath()%>/assetsScrap/saveAssetsScrap", {
            id:$("#f_Id").val(),
            assetsName: $("#f_assetsName").val(),
            manager: $("#f_manager").val(),
            requestDept: $("#f_requestDept").val(),
            requestDate:date,
            reason: $("#f_reason").val(),
            remark:$("#f_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
