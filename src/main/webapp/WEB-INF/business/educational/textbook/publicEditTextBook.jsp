<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<
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
            <input id="textbookId" hidden value="${textbook.textbookId}"/>
            <input id="type" hidden value="${type}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教材名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="textbookName" type="text" value="${textbook.textbookName}"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                         教材编号
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="textbookNumber" type="text"
                                   value="${textbook.textbookNumber}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                       教材性质
                    </div>
                    <div class="col-md-9">
                        <select id="textbookNature"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教材类型
                    </div>
                    <div class="col-md-9">
                        <select id="textbookCategory"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第一主编单位
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="firstEditorCompany" type="text"
                                   value="${textbook.firstEditorCompany}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        出版社
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="publishingHouse" type="text"
                                   value="${textbook.publishingHouse}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        主编
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="editor" type="text" value="${textbook.editor}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版次
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="edition" type="text" value="${textbook.edition}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        单价(元)
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="price" type="text" value="${textbook.price}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版本日期
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="versionDate" type="date" value="${textbook.versionDate}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark">${textbook.remark}</textarea>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JCXZ", function (data) {
            addOption(data, 'textbookNature', '${textbook.textbookNature}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JCLB", function (data) {
            addOption(data, 'textbookCategory', '${textbook.textbookCategory}');
        });
    });

    function save() {
        var textbookId = $("#textbookId").val();
        var textbookName = $("#textbookName").val();
        var textbookNumber = $("#textbookNumber").val();
        var textbookNature = $("#textbookNature").val();
        var publishingHouse = $("#publishingHouse").val();
        var textbookCategory = $("#textbookCategory").val();
        var firstEditorCompany = $("#firstEditorCompany").val();
        var editor = $("#editor").val();
        var edition = $("#edition").val();
        var price = $("#price").val();
        var remark = $("#remark").val();
        if (textbookName == "" || textbookName == undefined || textbookName == null) {
            swal({
                title: "请填写教材名称！",
                type: "info"
            });
            return;
        }
        if (isNaN(price)) {
            swal({
                title: "单价只能是数字！",
                type: "info"
            });
            return;
        }
        if(textbookId!=""){
            var textbookType='${textbook.textbookType}'
        }else{
            var textbookType = $("#type").val();
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveTextBook", {
            textbookId: textbookId,
            textbookName: textbookName,
            textbookNumber: textbookNumber,
            textbookNature: textbookNature,
            textbookType: textbookType,
            textbookCategory:textbookCategory,
            firstEditorCompany:firstEditorCompany,
            publishingHouse: publishingHouse,
            editor: editor,
            edition: edition,
            price: price,
            versionDate: $("#versionDate").val(),
            remark: remark,
        }, function (msg) {
            hideSaveLoading();
            if(msg.status==1){
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }else {
                swal({
                    title: msg.msg,
                    type: "error"
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>



