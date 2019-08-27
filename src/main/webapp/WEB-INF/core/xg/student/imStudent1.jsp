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
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form action='<%=request.getContextPath()%>/student/importStudent1130?classId=${classId}' id="importStudent1" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                            <input id="classId" type="hidden" value="${classId}"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/student/getStudentExcelTemplate1">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importEmp1()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    var classId = $("#classId").val();
    function importEmp1() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "error"
            });
            return;
        }
        var form = new FormData(document.getElementById("importStudent1"));
        $.ajax({
            url:'<%=request.getContextPath()%>/student/importStudent1130?classId='+classId,
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){

                if (data.status == 1) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#studentGrid').DataTable().ajax.reload();
                } else if(data.status == 3) {
                    swal({
                        title: data.msg + ",部分数据导入失败！请点击确定下载错误数据，修改后重新导入！",
                        type: "error"
                    }, function () {
                        window.location.href = "<%=request.getContextPath()%>" + data.result;
                    });
                } else {
                    swal({
                        title: data.msg,
                        type: "error"
                    });
                }
            }

        });
    }
</script>