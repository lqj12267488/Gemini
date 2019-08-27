<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">导入缴费标准</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form id="importNewStudent" action='<%=request.getContextPath()%>/payment/importNewStudentPayment?planId=${planId}&flag=${flag}'  enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                            <input id="planId" type="hidden" value="${planId}"/>
                            <input id="flag" type="hidden" value="${flag}"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" class="btn btn-info btn-clean" onclick="importEmp()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var planId = $("#planId").val();
    var flag = $("#flag").val();
    function importEmp() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "info"
            });
            return;
        }
        var file = $("#file").val();
        var fileTypes = new Array("xls","xlsx");
        var fileTypeFlag = "0";
        var newFileName = file.split('.');
        newFileName = newFileName[newFileName.length-1];
        for(var i=0;i<fileTypes.length;i++){
            if(fileTypes[i] == newFileName){
                fileTypeFlag = "1";
                break;
            }
        }
        if(fileTypeFlag == "0"){
            swal({title:"导入文件必须未为xls或xlsx格式的表格！",type:"info"});
            return;
        }else {
            showSaveLoading();
            var form = new FormData(document.getElementById("importNewStudent"));
            if (flag == "new" && fileTypeFlag == "1") {
                $.ajax({
                    url: '<%=request.getContextPath()%>/payment/importNewStudentPayment?planId=' + planId,
                    type: "post",
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        hideSaveLoading();
                        swal({
                            title: data.msg,
                            type: data.result
                        });
                        if (data.status == 1) {
                            $("#dialog").modal("hide");
                            $('#standardGrid').DataTable().ajax.reload();
                        }
                    }
                });
            }
            if (flag == "status") {
                $.ajax({
                    url: '<%=request.getContextPath()%>/payment/importStatusStudentPayment?planId=' + planId,
                    type: "post",
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        swal({
                            title: data.msg,
                            type: data.result
                        },function () {
                            if (data.status == 1) {
                                $("#dialog").modal("hide");
                                $('#statusStandardGrid').DataTable().ajax.reload();
                            }
                        });
                    }

                });
            }
            if (flag == "info") {
                $.ajax({
                    url: '<%=request.getContextPath()%>/payment/importInfoStudentPayment?planId=' + planId,
                    type: "post",
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        swal({
                            title: data.msg,
                            type: data.result
                        });
                        if (data.status == 1) {
                            $("#dialog").modal("hide");
                            $('#paymentInfoGrid').DataTable().ajax.reload();
                        }
                    }
                });
            }
        }
    }
</script>