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
            <span style="font-size: 14px;">选择课程计划</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程计划
                    </div>
                    <div class="col-md-9">
                        <select id="id"></select>
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

    $(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term');
        });
        $.get("<%=request.getContextPath()%>/teachingplanNew/getTimeTableSelect", function (data) {
            addOption(data, 'id');
        });
    });

    function save() {
        var term = $("#term").val();
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        var id = $("#id").val();
        if (id == "" || id == undefined || id == null) {
            swal({
                title: "请选择课程计划！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/teachingplanNew/importData", {
            id: id,
            term: term
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "info"
            });
            $('#table').DataTable().ajax.reload();
            $("#dialog").modal('hide');
        })

    }
</script>



