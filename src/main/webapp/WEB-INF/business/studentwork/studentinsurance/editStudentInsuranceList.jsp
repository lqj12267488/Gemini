<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/28
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
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
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>身份证号：
                    </div>
                    <div class="col-md-9">
                        <input id="idcardEdit" type="text"
                               class="validate[required,maxSize[50]] form-control autoInput"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               placeholder="请输入身份证号，并点选" value="${stuInsuranceEdit.idcard}"/>
                    </div>
                </div>
                <input id="studentId" value="${stuInsuranceEdit.studentId}" hidden>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>性别：
                    </div>
                    <div class="col-md-9">
                        <input id="sexEdit"  value="${stuInsuranceEdit.sexShow}" readonly  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>姓名：
                    </div>
                    <div class="col-md-9">
                        <input id="nameEdit" value="${stuInsuranceEdit.name}" readonly  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学号：
                    </div>
                    <div class="col-md-9">
                        <input id="studentNumberEdit" value="${stuInsuranceEdit.studentNumber}" readonly  class="validate[required,maxSize[100]] form-control"/>

                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级：
                    </div>
                    <div class="col-md-9">
                        <input id="classEdit"  value="${stuInsuranceEdit.classShow}" readonly  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        宿舍号：
                    </div>
                    <div class="col-md-9">
                        <input id="dormEdit" type="text"
                               class="validate[required,maxSize[50]] form-control autoInput"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               placeholder="请输入宿舍号，并点选" value="${stuInsuranceEdit.dormName}"/>
                        <input id="dormIdEdit" value="${stuInsuranceEdit.dormId}" hidden>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 生源地
                    </div>
                    <div class="col-md-9">
                        <input id="stuSourceAddrEdit" value="${stuInsuranceEdit.stuSourceAddr}" readonly class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>民族：
                    </div>
                    <div class="col-md-9">
                        <input id="nationEdit" value="${stuInsuranceEdit.nationShow}" readonly  class="validate[required,maxSize[100]] form-control"/>
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
    $(function () {
        $.get("<%=request.getContextPath()%>/common/getIdCard", function (data) {
            $("#idcardEdit").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#idcardEdit").val(ui.item.label);
                    $("#idcardEdit").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });

        $.get("<%=request.getContextPath()%>/common/getDorm", function (data) {
            $("#dormEdit").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dormEdit").val(ui.item.label);
                    $("#dormIdEdit").val(ui.item.value);
                    $("#dormEdit").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
    })

    $("#idcardEdit").blur(function(){
        $.get("<%=request.getContextPath()%>/student/getStudentByIdcard?idcard="+$("#idcardEdit").val(),function (data) {
            $("#sexEdit").val(data.sexShow).attr("readonly","readonly");
            $("#nameEdit").val(data.name).attr("readonly","readonly");
            $("#studentNumberEdit").val(data.studentNumber).attr("readonly","readonly");
            $("#stuSourceAddrEdit").val(data.stuSourceAddr);
            $("#studentId").val(data.studentId);
            $("#classEdit").val(data.classShow).attr("readonly","readonly");
            $("#nationEdit").val(data.nationShow).attr("readonly","readonly");
            })});

    function save() {

        if($("#studentId").val()=="" || $("#studentId").val() == undefined){
            swal({
                title: "请填写身份证账号",
                type: "info"
            });
            return;
        }


        $.post("<%=request.getContextPath()%>/studentInsurance/saveStudentInsurance", {
            id:"${stuInsuranceEdit.id}",
            studentId: $("#studentId").val(),
            dormId:$("#dormIdEdit").val(),
            insuranceType:"${insuranceType}"
        },function (msg) {
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#stuInsuranceGrid').DataTable().ajax.reload();
        })

    }
</script>
