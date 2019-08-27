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
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form id="importExcel" enctype="multipart/form-data" method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-default btn-clean" id="saveBtn" onclick="importExcel()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function importExcel() {

        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "warning"
            });
            return;
        }
        var fileName = $("#file").val();
        var ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
        if (ext != "xls") {
            swal({
                title: "请选择excel文件！",
                type: "warning"
            });
            return;
        }
        var form = new FormData(document.getElementById("importExcel"));
        showSaveLoading();
        $.ajax({
            url: '<%=request.getContextPath()%>/teachingTask/importExcel',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {
                hideSaveLoading();
                swal({
                    title: data.msg,
                    type: "info"
                });
                $("#bMGrid").DataTable().ajax.reload();
                $("#dialog").modal('hide');
            }
        });
    }
</script>