<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<%--<jsp:include page="../../../../include.jsp"/>--%>
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
            <span style="font-size: 14px">${head}</span>
            <input id="documentid" name="documentid" type="hidden" value="${document.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${document.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" readonly="readonly" value="${document.requestDate}"
                               type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        拟稿
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${document.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        文件标题
                    </div>
                    <div class="col-md-9">
                        <input id="f_fileTitle" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${document.fileTitle}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        主送
                    </div>
                    <div class="col-md-9">
                        <input id="f_deliveryEmpIdShow"
                               readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${document.deliveryEmpIdShow}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        抄送
                    </div>
                    <div class="col-md-9">
                        <input id="f_makeEmpIdShow"
                               readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${document.makeEmpIdShow}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        密级
                    </div>
                    <div class="col-md-9">
                        <select id="f_secretClass" disabled="disabled"
                                class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        标题
                    </div>
                    <div class="col-md-9">
                        <input id="f_title" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${document.title}" readonly="readonly"/>
                    </div>
                </div>--%>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        打印份数
                    </div>
                    <div class="col-md-9">
                        <input id="f_printingNumber" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${document.printingNumber}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        文号
                    </div>
                    <div class="col-md-9">
                        <input id="f_symbol" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${document.symbol}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDocument()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MJ", function (data) {
            addOption(data, 'f_secretClass', '${document.secretClass}');
        });
    })
    function saveDocument() {
        if ($("#f_symbol").val() == "" || $("#f_symbol").val() == undefined) {
            swal({
                title: "请填写文号!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/document/updateDocumentSymbol", {
            id: $("#documentid").val(),
            symbol:$("#f_symbol").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#documentGrid').DataTable().ajax.reload();
            }else{
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $("#dialog").modal('hide');
                $('#documentGrid').DataTable().ajax.reload();
            }
        })

        showSaveLoading();
    }
</script>