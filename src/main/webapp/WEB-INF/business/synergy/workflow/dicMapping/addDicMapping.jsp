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
        <div class="modal-header" style="height: 6%">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${userDic.id}">
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
                <div class="form-row">
                    <div class="col-md-3 tar">
                        字典类型
                    </div>
                    <div class="col-md-9">
                        <input id="dmtype" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${userDic.dictype}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        URL
                    </div>
                    <div class="col-md-9">
                        <input id="dmurl" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${userDic.dicurl}"/>
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
        if ($("#dicname").val() == "" || $("#dicname").val() == "0" || $("#dicname").val() == undefined) {
            swal({
                title: "请填写字典名称",
                type: "info"
            });
            //alert("请填写字典名称");
            return;
        }
        if ($("#dmtype").val() == "" || $("#dmtype").val() == "0" || $("#dmtype").val() == undefined) {
            swal({
                title: "请填写字典类型",
                type: "info"
            });
            //alert("请填写字典类型");
            return;
        }
        if ($("#dmurl").val() == "" || $("#dmurl").val() == "0" || $("#dmurl").val() == undefined) {
            swal({
                title: "请填写URL",
                type: "info"
            });
            //alert("请填写URL");
            return;
        }
        $.post("<%=request.getContextPath()%>/dicMapping/checkName", {
            dicname: $("#dicname").val(),
            id: $("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: "字典名称重复，请重新填写！",
                    type: "info"
                });
                //alert("字典名称重复，请重新填写！");
            }
            else {
                $.post("<%=request.getContextPath()%>/dicMapping/checkType", {
                    dictype: $("#dmtype").val(),
                    id: $("#id").val()
                }, function (msg) {
                    if (msg.status == 2) {
                        swal({
                            title: "字典类型重复，请重新填写！",
                            type: "info"
                        });
                        //alert("字典类型重复，请重新填写！");
                    }
                    else {
                        $.post("<%=request.getContextPath()%>/dicMapping/checkUrl", {
                            dicurl: $("#dmurl").val(),
                            id: $("#id").val()
                        }, function (msg) {
                            if (msg.status == 3) {
                                swal({
                                    title: "URL重复，请重新填写！",
                                    type: "info"
                                });
                                //alert("URL重复，请重新填写！");
                            }
                            else {
                                $.post("<%=request.getContextPath()%>/dicMapping/saveDicMapping", {
                                    id: $("#id").val(),
                                    dicname: $("#dicname").val(),
                                    dictype: $("#dmtype").val(),
                                    dicurl: $("#dmurl").val()
                                }, function (msg) {
                                    if (msg.status == 1) {
                                        swal({
                                            title: msg.msg,
                                            type: "success"
                                        });
                                        //alert(msg.msg);
                                        $("#dialog").modal('hide');
                                        $('#dicMappingGrid').DataTable().ajax.reload();
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