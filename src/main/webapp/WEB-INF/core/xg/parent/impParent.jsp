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
            <h4 class="modal-title">导入</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form action='<%=request.getContextPath()%>/core/parent/importParent' id="importParent" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/core/parent/getParentTemplate">下载模板</a>
            <button class="btn btn-info btn-clean" id="saveBtn" onclick="importEmp()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var classId = $("#classId").val();
    function importEmp() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "error"
            });
            return;
        }
        var form = new FormData(document.getElementById("importParent"));
        showSaveLoading();
        $.ajax({
            url:'<%=request.getContextPath()%>/core/parent/importParent',
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(msg){
                hideSaveLoading();
                swal({title: msg.msg,type: msg.result});
                $("#dialog").modal("hide");
                $('#parentTable').DataTable().ajax.reload();
            }
        });
    }
</script>