<%--用户字典新增页
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
            <input id="dictype" hidden value="${userDic.dictype}">
            <input id="name" hidden value="${userDic.name}">
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        字典名称
                    </div>
                    <div class="col-md-9">
                        <input id="dicname" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${userDic.dicname}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDic()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
        <div class="content">
            <table id="userDicTable" cellpadding="0" cellspacing="0" width="100%"
                   class="table table-bordered table-striped sortable_default">
            </table>
        </div>
    </div>
</div>
<input id="id" hidden value="${userDic.id}">
<script>
    function saveDic() {
        if($("#dicname").val()=="" ||  $("#dicname").val() =="0" || $("#dicname").val() == undefined){
            swal({
                title: "请填写字典名称",
                type: "info"
            });
            //alert("请填写耗材名称");
            return;
        }
        $.post("<%=request.getContextPath()%>/userDic/dicName?dictype=" + $("#dictype").val(),{
            dicname: $("#dicname").val(),
            id:$("#id").val(),
        },function(msg){
            if(msg.status == 1){
                swal({title: "字典名称重复，请重新填写！", type: "error"});
                //alert("耗材名称重复，请重新填写！");
            }else{
               /* alert($("#dictype").val())*/
                $.post("<%=request.getContextPath()%>/userDic/saveDic?dictype=" + $("#dictype").val(), {
                    id: $("#id").val(),
                    dicname: $("#dicname").val(),
                    name:$("#name").val()
                }, function (msg) {
                    if (msg.status == 1 ) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $("#dialog").modal('hide');
                        $('#userDicTable').DataTable().ajax.reload();
                    }
                })
            }

        })
    }

</script>