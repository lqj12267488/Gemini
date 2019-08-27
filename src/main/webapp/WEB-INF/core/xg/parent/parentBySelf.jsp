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
        <input id="parentId" hidden value="${data.parentId}"/>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        家长姓名
                    </div>
                    <div class="col-md-9">
                        ${data.parentName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        身份证号
                    </div>
                    <div class="col-md-9">
                        ${data.idcard}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        电话
                    </div>
                    <div class="col-md-9">
                        <input id="parentTel" value="${data.parentTel}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });


    function save() {
        var parentId = $("#parentId").val();
        var parentTel = $("#parentTel").val();
        if (parentTel == "" || parentTel == null) {
            swal({ title: "请填写电话", type: "info" });
            return;
        }

        if (parentTel != "") {
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test(parentTel) === false && telNum.test(parentTel) === false) {
                swal({ title: "电话不正确", type: "info" });
                return;
            }
        }

        $.post("<%=request.getContextPath()%>/core/parent/saveParent", {
            parentId:parentId,
            parentTel:parentTel,
        }, function (msg) {
            swal({title: msg.msg,type: "success"});
        })
    }
</script>



