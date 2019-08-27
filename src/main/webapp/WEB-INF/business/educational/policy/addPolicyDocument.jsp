<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 650px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" onclick="closedwindow()" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="pid" hidden value="${policyDocument.id}">
            <input id="f_documentSign" hidden value="${documentSign}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>文件名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_documentName" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${policyDocument.documentName}"/>
                    </div>
                </div>


                <div class="form-row">
                    
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>上传时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_time" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${policyDocument.time}"/>
                    </div>
                </div>



            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    })

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }

    function saveDept() {
        var date = $("#f_time").val();
        date = date.replace('T', '');

        if($("#f_documentName").val()==""  || $("#f_documentName").val() == undefined){
            swal({
                title: "请填写文件名称！",
                type: "info"
            });
            return;
        }
        if($("#f_time").val()=="" ||  $("#f_time").val() =="0" || $("#f_time").val() == undefined){
            swal({
                title: "请填写上传时间！",
                type: "info"
            });
            return;
        }
        var pid=$("#pid").val();

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/policyDocument/updatePolicyDocumentById", {
            id: pid,
            documentName: $("#f_documentName").val(),
            time: date,
            documentSign: $("#f_documentSign").val(),

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#policyDocumentGrid').DataTable().ajax.reload();
            }else if(msg.status == 2){
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#provincialDocumentGrid').DataTable().ajax.reload();
            }else{
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#collegeDocumentGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



