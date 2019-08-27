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
        <div class="modal-header" style="height: 50px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
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
                               value="${sysDic.dicname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        字典编码
                    </div>
                    <div class="col-md-9">
                        <input id="diccode" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${sysDic.diccode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        字典排序
                    </div>
                    <div class="col-md-9">
                        <input id="dicorder" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${sysDic.dicorder}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDic()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
        <div class="content">
            <table id="sysDicMappingGrid" cellpadding="0" cellspacing="0" width="100%"
                   class="table table-bordered table-striped sortable_default">
            </table>
        </div>
    </div>
</div>
<input id="id" hidden value="${sysDic.id}">
<input id="pid" hidden value="${sysDic.parentid}">
<script>
   /* alert($("#id").val())
    alert($("#pid").val())*/
    function saveDic() {
        if($("#dicname").val()=="" ||  $("#dicname").val() =="0" || $("#dicname").val() == undefined){
            swal({
                title: "请填写字典名称",
                type: "info"
            });
            //alert("请填写字典名称");
            return;
        }
        if($("#diccode").val()=="" || $("#diccode").val() == undefined){
            swal({
                title: "请填写字典编码",
                type: "info"
            });
            //alert("请填写字典编码");
            return;
        }
        if($("#dicorder").val()=="" || $("#dicorder").val() == undefined){
            swal({
                title: "请填写字典排序",
                type: "info"
            });
            //alert("请填写字典排序");
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        if(!reg.test($("#dicorder").val())){
            swal({
                title: "字典排序请填写数字。",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/sysDic/sysDicName",{
            id:$("#id").val(),
            parentid:$("#pid").val(),
            dicname: $("#dicname").val(),
        },function(msg) {
            if (msg.status == 1) {
                swal({
                    title: "字典名称重复，请重新填写！",
                    type: "info"
                });
                //alert("字典名称重复，请重新填写！");
            } else {
                $.post("<%=request.getContextPath()%>/sysDic/sysDicCode", {
                    id: $("#id").val(),
                    parentid:$("#pid").val(),
                    diccode: $("#diccode").val(),
                }, function (msg) {
                    if (msg.status == 2) {
                        swal({
                            title: "字典编码重复，请重新填写！",
                            type: "info"
                        });
                        //alert("字典编码重复，请重新填写！");
                    } else {
                        $.post("<%=request.getContextPath()%>/sysDic/saveSysDicMapping", {
                            id: $("#id").val(),
                            parentid:$("#pid").val(),
                            dicname: $("#dicname").val(),
                            dicorder: $("#dicorder").val(),
                            diccode: $("#diccode").val()
                        }, function (msg) {
                            if (msg.status == 1) {
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                //alert(msg.msg);
                                $("#dialog").modal('hide');
                                $('#sysDicMappingGrid').DataTable().ajax.reload();
                            }
                        })
                    }
                })
            }
        })
    }

</script>