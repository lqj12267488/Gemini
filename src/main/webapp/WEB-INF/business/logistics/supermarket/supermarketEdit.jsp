<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/21
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>食堂名称
                    </div>
                    <div class="col-md-9">
                        <input id="SupermarketName" class="js-example-basic-single" value="${Supermarket.name}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="15" placeholder="最多输入15个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>食堂位置
                    </div>
                    <div class="col-md-9">
                        <input id="address" class="js-example-basic-single" value="${Supermarket.address}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>负责人
                    </div>
                    <div class="col-md-9">
                        <input id="personName" class="js-example-basic-single" value="${Supermarket.personName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>身份证号
                    </div>
                    <div class="col-md-9">
                        <input id="personidCard" class="js-example-basic-single" value="${Supermarket.personidCard}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="18" placeholder="最多输入18个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>联系方式
                    </div>
                    <div class="col-md-9">
                        <input id="personTel" class="js-example-basic-single" value="${Supermarket.personTel}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="11" placeholder="最多输入11个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>租赁开始时间
                    </div>
                    <div class="col-md-4">
                        <input id="startTime" class="js-example-basic-single"
                               type="date" class="validate[required,maxSize[100]] form-control"
                               value="${Supermarket.startTime}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>租赁结束时间
                    </div>
                    <div class="col-md-4">
                        <input id="endTime" class="js-example-basic-single"
                               type="date" class="validate[required,maxSize[100]] form-control"
                               value="${Supermarket.endTime}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="edit_id" value="${Supermarket.id}" type="hidden" >
</div>

<script>
    var edit_id = $("#edit_id").val();
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){

    })
    function closeView(){
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
    }
    function save() {
       var name = $('#SupermarketName').val();
       var address = $('#address').val();
       var personName = $('#personName').val();
       var personidCard = $('#personidCard').val();
       var personTel = $('#personTel').val();
       var startTime = $('#startTime').val();
       var endTime = $('#endTime').val();
        if (name == "") {
            swal({
                title: "填写超市名称！",
                type: "info"
            });
            return;
        }
        if (address == "") {
            swal({
                title: "请填写超市相信位置！",
                type: "info"
            });
            return;
        }
        if (personName == "") {
            swal({
                title: "请填写负责人名称！",
                type: "info"
            });
            return;
        }
        if (personidCard == "") {
            swal({
                title: "请填写负责人身份证号",
                type: "info"
            });
            return;
        }
        if(personTel ==""){
            swal({
                title: "请填写电话！",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        var regTel = /^1[0-9]{10}$/;
        if (!reg.test($("#personTel").val())) {
            swal({
                title: "联系方式填写数字！",
                type: "info"
            });
            return;
        } else if (!regTel.test($("#personTel").val())) {
            swal({
                title: "联系方式请填写11位手机号！",
                type: "info"
            });
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if(reg.test($("#personidCard").val()==false))
        {
            swal({
                title: "身份证输入不合法!",
                type: "info"
            });
            return;
        }
        if(startTime>endTime){
            swal({
                title: "租赁开始日期必须早于租赁结束时间",
                type: "info"
            });
            return;
        }
        showSaveLoading();
            $.post("<%=request.getContextPath()%>/Supermarket/SupermarketSave", {
                id:edit_id,
                name: name,
                address: address,
                personName: personName,
                personidCard: personidCard,
                personTel: personTel,
                startTime: startTime,
                endTime: endTime
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#schoolBurseGrid').DataTable().ajax.reload();
            })
        hideSaveLoading();
    }
</script>
