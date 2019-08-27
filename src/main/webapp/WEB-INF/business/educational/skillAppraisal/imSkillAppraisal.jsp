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
            <h4 class="modal-title">导入1</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form action='<%=request.getContextPath()%>/skillAppraisal/importSkillAppraisal' id="importStudent" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" onclick="checkIsImport()">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importEmp()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>

    function checkIsImport() {
        $.post("/skillAppraisal/checkIsImport", function (res) {
            if(res.status==0){
                swal({
                    title: res.msg,
                    type: "warning"
                });
                return;
            }else {
                window.location.href="<%=request.getContextPath()%>/skillAppraisal/getSkillAppraisalExcelTemplate";
            }
        });
    }


    function importEmp() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "error"
            });
            return;
        }
        var form = new FormData(document.getElementById("importStudent"));
        $.ajax({
            url:'<%=request.getContextPath()%>/skillAppraisal/importSkillAppraisal',
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                swal({
                    title: data.msg,
                    type: "success"
                });
                if(data.status == 1 ){
                    $("#dialog").modal("hide");
                    $('#skill').DataTable().ajax.reload();
                }
            }

        });
    }
</script>