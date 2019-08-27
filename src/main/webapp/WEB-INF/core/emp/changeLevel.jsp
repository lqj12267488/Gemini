<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改人员级别</h4>
        </div>
        <div class="modal-body clearfix" style="font-size: 15px;">
            <div class="container">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        人员级别
                    </div>
                    <div class="col-md-9">
                        <select id="userLevel"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("getLevel", function (data) {
            addOption(data, "userLevel", "${level}");
        })
    });

    function save() {
        var level = $("#userLevel").val();
        if (level == '' || level == null || level == undefined) {
            swal({
                title: "请选择人员级别！",
                type: "error"
            });
            return;
        }
        $.post("saveLevel", {
            level: level,
            personId: '${personId}'
        }, function (msg) {
            swal({
                title: "修改成功！",
                type: "success"
            }, function () {
                $("#dialog").modal("hide");
                deptTable.ajax.reload();
            });
        })
    }

</script>