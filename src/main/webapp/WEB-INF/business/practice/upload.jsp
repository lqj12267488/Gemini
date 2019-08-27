<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">上传附件</span>
            <input id="id" hidden value="${id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        附件
                    </div>
                    <div class="col-md-9">
                        <form action='' id="upload" enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">上传
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>

    function save() {
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件！",
                type: "info"
            });
            return;
        }
        var form = new FormData(document.getElementById("upload"));
        form.append("id", $("#id").val());
        alert("1")
        $.ajax({
            url: '<%=request.getContextPath()%>/tableManagement/upload',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (msg) {
                if(msg.status==0){
                    swal({
                        title: msg.msg,
                        type: "info"
                    });
                }else {
                    swal({
                        title: "上传成功！",
                        type: "info"
                    });
                }
                $('#table').DataTable().ajax.reload();
                $("#dialog").modal('hide');
            }
        });
    }
</script>



