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
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <input id="edit_staffName" class="js-example-basic-single" value="${Supermarket.staffName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个字">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="edit_staffidCard" class="js-example-basic-single" value="${Supermarket.staffidCard}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="18" placeholder="最多输入18个字">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所在岗位
                    </div>
                    <div class="col-md-4">
                        <input id="edit_staffPost" class="js-example-basic-single" value="${Supermarket.staffPost}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个字">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-4">
                        <select id="edit_staffSex" class="js-example-basic-single"
                               class="validate[required,maxSize[100]] form-control"
                               value="${Supermarket.staffSex}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>联系方式
                    </div>
                    <div class="col-md-4">
                        <input id="edit_staffTel" class="js-example-basic-single" value="${Supermarket.staffTel}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="11" placeholder="最多输入11个字">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所在超市
                    </div>
                    <div class="col-md-4">
                        <select id="edit_supermarketId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>家庭住址
                    </div>
                    <div class="col-md-10">
                        <input id="edit_staffAddress" class="js-example-basic-single"
                               value="${Supermarket.staffAddress}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字">
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'edit_staffSex','${Supermarket.staffSex}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "id",
                text: "name",
                tableName: "T_ZW_SUPERMARKET",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'edit_supermarketId','${Supermarket.supermarketId}');
            });
    })
    function closeView(){
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
    }
    function save() {
       var staffName = $('#edit_staffName').val();
       var staffAddress = $('#edit_staffAddress').val();
       var staffPost = $('#edit_staffPost').val();
       var staffidCard = $('#edit_staffidCard').val();
       var staffTel = $('#edit_staffTel').val();
       var staffSex = $('#edit_staffSex option:selected').val();
       var supermarketId = $('#edit_supermarketId').val();
        if (staffName == "") {
            swal({
                title: "填写员工姓名！",
                type: "info"
            });
            return;
        }
        if (staffAddress == "") {
            swal({
                title: "请填写家庭住址！",
                type: "info"
            });
            return;
        }

        if (staffidCard == "") {
            swal({
                title: "请填写负责人身份证号",
                type: "info"
            });
            return;
        }
        if(staffTel ==""){
            swal({
                title: "请填写电话！",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        var regTel = /^1[0-9]{10}$/;
        if (!reg.test($("#edit_staffTel").val())) {
            swal({
                title: "联系方式填写数字！",
                type: "info"
            });
            return;
        } else if (!regTel.test($("#edit_staffTel").val())) {
            swal({
                title: "联系方式请填写11位手机号！",
                type: "info"
            });
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if(reg.test($("#edit_staffCard").val()==false))
        {
            swal({
                title: "身份证输入不合法!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
            $.post("<%=request.getContextPath()%>/Supermarket/SupermarketStaffSave", {
                id:edit_id,
                staffName: staffName,
                staffAddress: staffAddress,
                staffidCard: staffidCard,
                staffTel: staffTel,
                staffPost: staffPost,
                staffSex: staffSex,
                supermarketId:supermarketId
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
