<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/17
  Time: 9:56
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
                        <form action='<%=request.getContextPath()%>/scoreImport/importSalary' id="importSalary" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                            <input id="courseFlag" value="${courseFlag}" hidden>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean"
               href="<%=request.getContextPath()%>/scoreImport/exportScoreImport?scoreClassId=${scoreClassId}&courseId=${courseId}&subjectId=${subjectId}&scoreExamName=${scoreExamName}&courseFlag=${courseFlag}">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importScore()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input id="scoreClassId" value="${scoreClassId}" hidden/>
    <input id="courseId" value="${courseId}" hidden/>
    <input id="subjectId" value="${subjectId}" hidden/>
    <input id="scoreExamName" value="${scoreExamName}" hidden/>
</div>
<script>
    function importScore() {
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
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
        var newFileName = file.split('.');
        newFileName = newFileName[newFileName.length - 1];
        for (var i = 0; i < fileTypes.length; i++) {
            if (fileTypes[i] == newFileName) {
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
        var form = new FormData(document.getElementById("importSalary"));
            $.ajax({
                url: '<%=request.getContextPath()%>/scoreImport/importSalary',
                type: "post",
                data: form,
                processData: false,
                contentType: false,
                success: function (data) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    if (data.status == 1) {
                        $("#dialog").modal("hide");
                        $('#importGrid').DataTable().ajax.reload();
                    }
                }
            });
    }
</script>