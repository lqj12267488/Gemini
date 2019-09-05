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
            <input id="parentId" hidden value="${data.parentId}"/>
            <input id="ifIndex" hidden value="${ifIndex}"/>

        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学生身份证件号码
                    </div>
                    <div class="col-md-9">
                        <input id="studentId" value="${data.studentId}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx"></span>学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="studentName" value="${data.studentName}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx"></span>学生户籍地址（与身份证上一致）
                    </div>
                    <div class="col-md-9">
                        <input id="householdRegisterPlace" value="${data.householdRegisterPlace}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人1姓名
                    </div>
                    <div class="col-md-9">
                        <input id="parentName" value="${data.parentName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人1身份证件类型
                    </div>
                    <div class="col-md-9">
                        <select id="idCardType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人1身份证件号码
                    </div>
                    <div class="col-md-9">
                        <input id="idcard" value="${data.idcard}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>父母或监护人1联系方式
                    </div>
                    <div class="col-md-9">
                        <input id="parentTel" value="${data.parentTel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人2姓名
                    </div>
                    <div class="col-md-9">
                        <input id="parentNameSecond" value="${data.parentNameSecond}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人2身份证件类型
                    </div>
                    <div class="col-md-9">
                        <select id="idCardTypeSecond" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 父母或监护人2身份证件号码
                    </div>
                    <div class="col-md-9">
                        <input id="idcardSecond" value="${data.idcardSecond}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>父母或监护人2联系方式
                    </div>
                    <div class="col-md-9">
                        <input id="parentTelSecond" value="${data.parentTelSecond}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $('#studentId').on('input propertychange', function () {
            if ($("#studentId").val() != "") {
                $.get("<%=request.getContextPath()%>/core/parent/getStudentByStudentId?studentId=" + $("#studentId").val(),
                    function (data) {
                        $("#householdRegisterPlace").val(data.householdRegisterPlace);
                        $("#studentName").val(data.studentName);
                    })
            }
        })
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=JZZJLX", function (data) {
            addOption(data, "idCardType",'${data.idCardType}');
        });

        $.get("<%=request.getContextPath()%>/common/getUserDict?name=JZZJLX", function (data) {
            addOption(data, "idCardTypeSecond",'${data.idCardTypeSecond}' );
        });

    });

    function save() {
        var studentName = $("#studentName").val();
        var parentName = $("#parentName").val();
        var studentId = $("#studentId").val();
        var idcard = $("#idcard").val();
        var idcardSecond = $("#idcardSecond").val();
        var parentTel = $("#parentTel").val();
        var parentTelSecond = $("#parentTelSecond").val();
        var idCardType = $("#idCardType").val();
        var idCardTypeSecond = $("#idCardTypeSecond").val();
        var parentNameSecond = $("#parentNameSecond").val();
        var householdRegisterPlace = $("#householdRegisterPlace").val();
        var parentId = $("#parentId").val();

        if (studentId == "" || studentId == undefined || studentId == null) {
            swal({title: "请填写学生身份证件号码！",type: "info"});
            return;
        }
        if (studentName == "" || studentName == undefined || studentName == null) {
            swal({title: "此学生身份证件号码不存在！请重新填写",type: "info"});
            return;
        }

        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (reg.test(studentId) == false) {
            swal({title: "身份证输入不合法",type: "info"});
            return;
        }
        if (parentName == "" || parentName == undefined || parentName == null) {
            swal({title: "请选择父母或监护人1姓名！",type: "info"});
            return;
        }
        if (parentName.indexOf(" ")>0) {
            swal({title: "请消除父母或监护人1姓名中的空格！",type: "info"});
            return;
        }
        if (idCardType == "" || idCardType == null) {
            swal({title: "请填写父母或监护人1身份证件类型",type: "info"});
            return;
        }
        if (idcard == "" || idcard == null) {
            swal({title: "请填写父母或监护人1身份证件号码",type: "info"});
            return;
        }
        if (reg.test(idcard) == false) {
            swal({title: "身份证输入不合法",type: "info"});
            return;
        }

        if (parentTel == "" || parentTel == null) {
            swal({title: "请填写父母或监护人1联系方式",type: "info"});
            return;
        }

        if (parentTel != "") {
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test(parentTel) === false && telNum.test(parentTel) === false) {
                swal({title: "父母或监护人1联系方式不正确！请重新选择",type: "info"});
                return;
            }
        }

        if (parentNameSecond == "" || parentNameSecond == undefined || parentNameSecond == null) {
            swal({title: "请填写父母或监护人2姓名！",type: "info"});
            return;
        }

        if (parentNameSecond.indexOf(" ")>0) {
            swal({title: "请消除父母或监护人2姓名中的空格！",type: "info"});
            return;
        }

        if (idCardTypeSecond == "" || idCardTypeSecond == null) {
            swal({title: "请填写父母或监护人2身份证件类型",type: "info"});
            return;
        }

        if (idcardSecond == "" || idcardSecond == null) {
            swal({title: "父母或监护人2身份证件号码",type: "info"});
            return;
        }
        if (reg.test(idcardSecond) == false) {
            swal({title: "身份证输入不合法",type: "info"});
            return;
        }

        if (parentTelSecond == "" || parentTelSecond == null) {
            swal({title: "请填写父母或监护人2联系方式",type: "info"});
            return;
        }

        if (parentTelSecond != "") {
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test(parentTelSecond) === false && telNum.test(parentTelSecond) === false) {
                swal({title: "电话不正确",type: "info"});
                return;
            }
        }


        showSaveLoading();
        $.post("<%=request.getContextPath()%>/core/parent/saveParent", {
            parentName: parentName,
            idcard: idcard,
            idcardSecond: idcardSecond,
            parentTel: parentTel,
            parentTelSecond: parentTelSecond,
            idCardType: idCardType,
            idCardTypeSecond: idCardTypeSecond,
            parentNameSecond: parentNameSecond,
            studentId: studentId,
            householdRegisterPlace: householdRegisterPlace,
            studentName: studentName,
            parentId: parentId,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal("hide");
            if(null == ifIndex || ifIndex!='1'){
                $('#parentTable').DataTable().ajax.reload();
            }
        })
    }
</script>



