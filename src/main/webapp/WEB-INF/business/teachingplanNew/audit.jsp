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
            <span style="font-size: 14px;">审核</span>
            <input id="id" hidden value="${id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        是否通过
                    </div>
                    <div class="col-md-9">
                        <select id="status">
                            <option value="">请选择</option>
                            <option value="3">通过</option>
                            <option value="4">不通过</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        意见
                    </div>
                    <div class="col-md-9">
                        <input id="opinion"/>
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
    function save() {
        var id = $("#id").val();
        var status = $("#status").val();
        var opinion = $("#opinion").val();

        if (status == "" || status == undefined || status == null) {
            swal({
                title: "请选择是否通过！",
                type: "info"
            });
            return;
        }
        if (opinion == "" || opinion == undefined || opinion == null) {
            swal({
                title: "请填写意见！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/teachingplanNew/audit", {
            id: id,
            status: status,
            opinion: opinion
        }, function () {
            swal({
                title: "操作成功！",
                type: "info"
            });
            $('#table').DataTable().ajax.reload();
            $("#dialog").modal('hide');
        })

    }
</script>



