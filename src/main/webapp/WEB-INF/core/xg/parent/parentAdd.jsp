<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>家长姓名
                    </div>
                    <div class="col-md-9">
                        <input id="parentName" value="${data.parentName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 身份证号
                    </div>
                    <div class="col-md-9">
                        <input id="idcard" value="${data.idcard}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>电话
                    </div>
                    <div class="col-md-9">
                        <input id="parentTel" value="${data.parentTel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生
                    </div>
                    <div class="col-md-9">
                        <input id="studentId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>关系
                    </div>
                    <div class="col-md-9">
                        <select id="relation" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSJZGX", function (data) {
            addOption(data, "relation" );
        });

        $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#studentId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#studentId").val(ui.item.label);
                    $("#studentId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

    });


    function save() {
        var parentName = $("#parentName").val();
        var idcard = $("#idcard").val();
        var parentTel = $("#parentTel").val();
        if (parentName == "" || parentName == undefined || parentName == null) {
            swal({title: "请填写家长姓名！",type: "info"});
            return;
        }
        if (parentName.indexOf(" ")>0) {
            swal({title: "请消除家长姓名中的空格！",type: "info"});
            return;
        }
        if (idcard == "" || idcard == null) {
            swal({title: "请填写身份证号码",type: "info"});
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (reg.test(idcard) == false) {
            swal({title: "身份证输入不合法",type: "info"});
            return;
        }

        if (parentTel == "" || parentTel == null) {
            swal({title: "请填写电话",type: "info"});
            return;
        }

        if (parentTel != "") {
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test(parentTel) === false && telNum.test(parentTel) === false) {
                swal({title: "电话不正确",type: "info"});
                return;
            }
        }

        var studentId =$("#studentId").attr("keycode");
        var studentName =$("#studentId").val();
        var relation = $("#relation").val();

        if (studentId == "" || studentId == undefined || studentId == null|| studentId == 'undefined') {
            swal({title: "请输入学生姓名后在下拉提示中选择！",type: "info"});;
            return;
        }
        if (relation == "" || relation == undefined || relation == null) {
            swal({title: "请选择关系！",type: "info"});;
            return;
        }
	
        studentId = studentId.split(",")[1];
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/core/parent/saveParent", {
            parentName:parentName,
            idcard:idcard,
            parentTel:parentTel,
            studentId:studentId,
            relationVal:relation,
            studentName:studentName
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: msg.result});
            if( msg.status == 1 ||  msg.status == '1'){
                $("#dialog").modal('hide');
                $('#parentTable').DataTable().ajax.reload();
            }
        })
    }
</script>



