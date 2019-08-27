<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/17
  Time: 17:02
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
            <input id="id" hidden value="${deviceUseSupplies.id}">
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        设备编号
                    </div>
                    <div class="col-md-9">
                        <input id="diccode" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${deviceUseSupplies.diccode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        设备名称
                    </div>
                    <div class="col-md-9">
                        <input id="dicname" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${deviceUseSupplies.dicname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        排序
                    </div>
                    <div class="col-md-9">
                        <input id="dicorder" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${deviceUseSupplies.dicorder}"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    function saveDept() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if( $("#diccode").val() =="" ||  $("#diccode").val() =="0" || $("#diccode").val() == undefined){
             swal({
                title: "请填写设备编号!",
                type: "info"
            });
            return;
        }
        if($("#dicname").val()=="" ||  $("#dicname").val() =="0" || $("#dicname").val() == undefined){
            alert("");swal({
                title: "请填写设备名称!",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#dicorder").val())){
            swal({
                title: "排序请填写数字!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/deviceUseSupplies/checkName",{
            dicname: $("#dicname").val(),
            id:$("#id").val()
        },function(msg){
            if(msg.status == 1){
                 swal({
                    title: "设备名称重复,请重新填写!",
                    type: "error"
                });
            }else{
                $.post("<%=request.getContextPath()%>/deviceUseSupplies/checkCode",{
                    diccode: $("#diccode").val(),
                    id:$("#id").val()
                },function(msg){
                    if(msg.status == 2){
                        swal({
                            title: "设备编号重复,请重新填写!",
                            type: "error"
                        });
                    }else{
                        $.post("<%=request.getContextPath()%>/deviceUseSupplies/checkOrder",{
                            dicorder: $("#dicorder").val(),
                            id:$("#id").val()
                        },function(msg){
                            if(msg.status == 3){
                                swal({
                                    title: "设备排序重复,请重新填写!",
                                    type: "error"
                                });
                            }else{
                                $.post("<%=request.getContextPath()%>/deviceUse/saveDeviceUseSupplies", {
                                    id: $("#id").val(),
                                    diccode: $("#diccode").val(),
                                    dicname: $("#dicname").val(),
                                    dicorder: $("#dicorder").val()
                                }, function (msg) {
                                    if (msg.status == 1 ) {
                                         swal({
                                            title: msg.msg,
                                            type: "success"
                                        });
                                        $("#dialog").modal('hide');
                                        $('#deviceUseSuppliesGrid').DataTable().ajax.reload();
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    }

</script>
