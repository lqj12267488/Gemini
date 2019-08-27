<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${PersonalWork.id}">
        </div>
        <div class="modal-body clearfix">

            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        作品名称:
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        作品描述:
                    </div>
                    <div class="col-md-9">
                    <textarea id="remark"
                              class="validate[required,maxSize[100]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="savePersonalWork()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    function savePersonalWork() {
        if ($("#resourceName").val() == "" || $("#resourceName").val() == "0" || $("#resourceName").val() == undefined) {
            swal({title: "请填写作品名称!", type: "info"});
            return;
        }
        var resourceName = $("#resourceName").val();
        var remark= $("#remark").val();
        $.ajax({
            url:'<%=request.getContextPath()%>/StudentPersonalWorks/insertStudentPersonalWorks' +
            '?resourceName='+resourceName+'&remark='+remark,
            type:"post",
            processData:false,
            contentType:false,
            success:function(msg){
                swal({title: msg.msg, type: msg.result});
                if(msg.status == 1){
                    $("#dialog").modal("hide");
                    $('#personalWorksGrid').DataTable().ajax.reload();
                }
            }
        });
    }
</script>