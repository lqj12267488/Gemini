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
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="pid" name="pid" hidden value="${userDic.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  缴费项目
                    </div>
                    <div class="col-md-9">
                        <input id="namee" type="text" value="${userDic.dicname}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    });

    function save() {
        var name = $("#namee").val();
        if (name == "" || name == undefined || name == null) {
            swal({
                title: "请填写缴费项目！",
                type: "info"
            });
            return;
        }else{
            if (name.indexOf(" ") !=-1 || name.indexOf("/")!=-1 || name.indexOf("@")!=-1){
                swal({title: "缴费项目中不可包含特殊符号。例如[空格]、[/]、[@]等！",type: "info"});
                return;
            }

        }


        $.post("<%=request.getContextPath()%>/userDic/checkName",{
            dicname: $("#namee").val(),
            id:$("#pid").val()
        },function(msg){

                if(msg.status == 1){
                    swal({
                        title: "缴费项目名称重复，请重新填写！",
                        type: "error"
                    });

            } else{
                    showSaveLoading();
                $.post("<%=request.getContextPath()%>/userDic/saveUserDicSupplies", {
                    id: $("#pid").val(),
                    dicname: $("#namee").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1 ) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#costItemTable').DataTable().ajax.reload();
                    }
                })
            }
        })




    }
</script>


