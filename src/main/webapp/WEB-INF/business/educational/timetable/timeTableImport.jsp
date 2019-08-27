<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/11/21
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">导入</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form id="impScore" enctype="multipart/form-data" method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/timeTable/exportTimeTableTemplate">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importScore()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="timeTableDepartmentId" hidden value="${timeTableDepartmentId}">
</div>
<script>
    function importScore() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件",
                type: "error"
            });
            return;
        }
        var file = $("#file").val();
        var fileTypes = new Array("xls", "xlsx");  //定义可支持的文件类型数组
        var fileTypeFlag = "0";
        var fileNameArray = file.split('.');
        var fileType = fileNameArray[fileNameArray.length - 1];
        for (var i = 0; i < fileTypes.length; i++) {
            if (fileTypes[i] == fileType) {
                fileTypeFlag = "1";
            }
        }
        if (fileTypeFlag == "0") {
            swal({
                title: "请导入表格文件!",
                type: "error"
            });
            return false;
        }
        var form = new FormData(document.getElementById("impScore"));
        var timeTableDepartmentId=$("#timeTableDepartmentId").val();
        $.ajax({
            url: '<%=request.getContextPath()%>/timeTable/importTimeTableExcel?timeTableDepartmentId='+timeTableDepartmentId,
            type: "post",
            data: form ,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.status == 1) {
                    swal({
                        title: data.msg,
                        type: data.result
                    });
                    $("#dialog").modal("hide");
                    $('#table').DataTable().ajax.reload();
                }else{
                    swal({
                        title: data.msg,
                        type: data.result
                    });
                    $("#dialog").modal("hide");
                    $('#table').DataTable().ajax.reload();
                }
            }
        });
    }
</script>
