<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/4
  Time: 9:51
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
                        <form action='/salaryApproval/importSalary' id="importSalary" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" href="/salaryApproval/getSalaryExcelTemplate">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importEmp()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    function importEmp() {
        if ($("#file").val() == "") {
            alert("请选择文件！");
            return;
        }
        var form = new FormData(document.getElementById("importSalary"));
        $.ajax({
            url:'/salaryApproval/importSalary',
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                alert(data.msg);
                if(data.status == 1 ){
                    $("#dialog").modal("hide");
                    $('#salaryApprovalGrid').DataTable().ajax.reload();
                }
            }
        });
    }
</script>