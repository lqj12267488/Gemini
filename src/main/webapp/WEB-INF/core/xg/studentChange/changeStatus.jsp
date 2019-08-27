<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    学生姓名：
                </div>
                <div class="col-md-3 ">
                    ${student.name}
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    现学籍状态：
                </div>
                <div class="col-md-3 ">
                    ${student.studentStatusShow}
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 人员状态异动：
                </div>
                <div class="col-md-3 ">
                    <select id="studentStatusSelect" />
                    <input id="sStatus" value="${student.studentStatus}" hidden >
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="updateStatus()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input hidden id="studentId" value="${studentId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSZT", function (data) {
            addOption(data, 'studentStatusSelect','${student.studentStatus}');
        });
    });

    function updateStatus() {
        var staffStatus = $("#studentStatusSelect option:selected").val();
        if(null == staffStatus || staffStatus ==""){
            swal({
                title: "请选择人员状态!",
                type: "info"
            });
            return;
        }
        if( staffStatus ==$("#sStatus").val()){
            swal({
                title: "请更改人员状态!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post('<%=request.getContextPath()%>/studentChangeLog/updateStatus', {
            studentId: $('#studentId').val(),
            studentStatus: staffStatus
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal("hide");
            $('#studentChangeGrid').DataTable().ajax.reload();
        })
    }
</script>