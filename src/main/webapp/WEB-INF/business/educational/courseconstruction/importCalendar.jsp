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
                        <form action='<%=request.getContextPath()%>/student/importCalendar' id="importCalendar" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean" href="<%=request.getContextPath()%>/courseconstruction/getCalendarExcelTemplate">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importCalendar()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    function importCalendar() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "error"
            });
            return;
        }


        var form = new FormData(document.getElementById("importCalendar"));
        $.ajax({
            url:'<%=request.getContextPath()%>/courseconstruction/importCalendar',
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
                    $('#table').DataTable().ajax.reload();
                }
            }

        });
    }
</script>