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
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        参数名称
                    </div>
                    <div class="col-md-9">
                        <input id="parametername" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${parameter.parametername}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        参数代码
                    </div>
                    <div class="col-md-9">
                        <input id="parametercode" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${parameter.parametercode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        参数类型
                    </div>
                    <div class="col-md-9">
                        <input id="parametertype" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${parameter.parametertype}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        参数值
                    </div>
                    <div class="col-md-9">
                        <input id="parametervalue" type="text"
                                class="validate[required,maxSize[100]] form-control"
                                value="${parameter.parametervalue}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDic()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
        <div class="content">
            <table id="parameterGrid" cellpadding="0" cellspacing="0" width="100%"
                   class="table table-bordered table-striped sortable_default">
            </table>
        </div>
    </div>
</div>
<input id="id" hidden value="${parameter.id}">
<script>
    /*alert($("#ids").val())*/
    function saveDic() {
        if($("#parametername").val()=="" ||  $("#parametername").val() =="0" || $("#parametername").val() == undefined){
            swal({
                title: "请填写参数名称",
                type: "info"
            });
            //alert("请填写参数名称");
            return;
        }
        if($("#parametercode").val()=="" ||  $("#parametercode").val() =="0" || $("#parametercode").val() == undefined){
            swal({
                title: "请填写参数代码",
                type: "info"
            });
            //alert("请填写参数代码");
            return;
        }
        if($("#parametervalue").val()=="" ||  $("#parametervalue").val() =="0" || $("#parametervalue").val() == undefined){
            swal({
                title: "请填写参数值",
                type: "info"
            });
            //alert("请填写参数代码");
            return;
        }
        $.post("<%=request.getContextPath()%>/parameter/checkName",{
            id:$("#id").val(),
            parametername: $("#parametername").val(),
        },function(msg){
            if(msg.status == 1){
                swal({
                    title: "参数名称重复，请重新填写！",
                    type: "info"
                });
                //alert("参数名称重复，请重新填写！");
            }else {
                $.post("<%=request.getContextPath()%>/parameter/checkCode",{
                    id:$("#id").val(),
                    parametercode: $("#parametercode").val(),
                },function(msg){
                    if(msg.status == 2){
                        swal({
                            title: "参数代码重复，请重新填写！",
                            type: "info"
                        });
                        //alert("参数代码重复，请重新填写！");
                    }else {
                        /*$.post("/parameter/checkType",{
                            id:$("#id").val(),
                            parametertype: $("#parametertype").val(),
                        },function(msg) {
                            if (msg.status == 3) {
                                alert("参数类型重复，请重新填写！");
                            } else {
                                $.post("/parameter/checkValue", {
                                    id: $("#id").val(),
                                    parametervalue: $("#parametervalue").val(),
                                }, function (msg) {
                                    if (msg.status == 4) {
                                        alert("参数值重复，请重新填写！");
                                    } else {*/

                                        $.post("<%=request.getContextPath()%>/parameter/saveParameter", {
                                            id: $("#id").val(),
                                            parametername: $("#parametername").val(),
                                            parametercode: $("#parametercode").val(),
                                            parametertype: $("#parametertype").val(),
                                            parametervalue: $("#parametervalue").val()
                                        }, function (msg) {
                                            if (msg.status == 1) {
                                                swal({
                                                    title: msg.msg,
                                                    type: "success"
                                                });
                                                //alert(msg.msg);
                                                $("#dialog").modal('hide');
                                                $('#parameterGrid').DataTable().ajax.reload();
                                            }
                                        })
                                   /* }
                                })
                            }
                        })*/


                    }
                })
            }

        })
    }

</script>