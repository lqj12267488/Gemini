<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/5/24
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
                         <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                         <div class="controls">
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    耗材名称
                                </div>
                                <div class="col-md-9">
                                    <select id="suname"  class="js-example-basic-single"></select>
                                </div>
                                <%--<div class="col-md-9">
                                    <input id="supplies_name" type="text"
                                           class="validate[required,maxSize[100]] form-control"
                                           value="${RepairSupplies.suppliesname}"/>
                                </div>--%>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    耗材类型
                                </div>
                                <div class="col-md-9">
                                    <select id="suppliestype"  class="js-example-basic-single"></select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    耗材数量
                                </div>
                                <div class="col-md-9">
                                    <input id="supplies_num" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           placeholder="请输入数字" class="validate[required,maxSize[20]] form-control"
                                           value="${RepairSupplies.suppliesnum}" readonly="readonly"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    计量单位
                                </div>
                                <div class="col-md-9">
                                    <input id="unit" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           maxlength="15" placeholder="最多输入15个字"
                                           class="validate[required,maxSize[100]] form-control"
                                           value="${RepairSupplies.unit}" readonly="readonly"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    单价(元)
                                </div>
                                <div class="col-md-9">
                                    <input id="price" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           placeholder="请输入数字" class="validate[required,maxSize[100]] form-control"
                                           value="${RepairSupplies.price}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    规格
                                </div>
                                <div class="col-md-9">
                                    <input id="specifications" value="${RepairSupplies.specifications}"
                                           onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           maxlength="15" placeholder="最多输入15个字"
                                           class="validate[required,maxSize[100]] form-control" />
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    品牌
                                </div>
                                <div class="col-md-9">
                                    <input id="rbrand" value="${RepairSupplies.brand}"
                                           onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           maxlength="15" placeholder="最多输入15个字"
                                           class="validate[required,maxSize[100]] form-control" />
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    备注
                                </div>
                                <div class="col-md-9">
                                    <input id="remark" value="${RepairSupplies.remark}"
                                           onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           maxlength="165" placeholder="最多输入165个字"
                                           class="validate[required,maxSize[100]] form-control" />
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    入库时间
                                </div>
                                <div class="col-md-9">
                                    <input id="in_time"  type="datetime-local"
                                           class="validate[required,maxSize[100]] form-control"
                                           value="${RepairSupplies.intime}" />
                                </div>
                            </div>
                         </div>
                    </div>
            <div class="modal-footer">
                <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
                <%--点击保存跳转到save()方法--%>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
                <%--点击关闭返回到上一个页面--%>
            </div>
    </div>
</div>
<input id="id" hidden value="${RepairSupplies.id}">
<input id="stype" hidden value="${RepairSupplies.suppliestype}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_USERDIC",
                where: " WHERE 1 = 1 and dic_type='WXHCLX'and VALID_FLAG = '1'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "suppliestype", $("#stype").val());
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_USERDIC",
                where: " WHERE 1 = 1 and dic_type='WXHCXX' and  VALID_FLAG=1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "suname", '${RepairSupplies.suppliesname}');
            });
    })

    function save() {
        var reg1 = new RegExp("^[0-9]*$");
        var reg = /^[0-9]+.?[0-9]*$/;/*用来判断输入的是否是数字*/
        var date = $("#in_time").val();/*从数据库中通过id获取时间*/
        date = date.replace('T', '');/*将从数据库中获取的时间中的T用空字符串替换*/
        if ($("#suname").val() == "" || $("#suname").val() == "0" || $("#suname").val() == undefined ) {
            swal({
                title: "请填写耗材名称！",
                type: "info"
            });
            return;
        }/*判断耗材名称是否为空串，0，是否定义*/
        if ($("#suppliestype").val() == "" || $("#suppliestype").val() == "0" || $("#suppliestype").val() == undefined ) {
            swal({
                title: "请选择耗材类型！",
                type: "info"
            });
            return;
        }/*判断耗材类型是否为空串，0，是否定义*/
        if ($("#supplies_num").val() == "" || $("#supplies_num").val() == "0" || $("#supplies_num").val() == undefined) {
            swal({
                title: "请填耗材数量！",
                type: "info"
            });
            return;
        }/*判断数量是否为空串，0，是否定义*/
        if(!reg1.test($("#supplies_num").val())){
            swal({
                title: "申请数量请填写整数！",
                type: "info"
            });
            return;
        }/*判断数量是否为整数*/
        if ($("#unit").val() == "" || $("#unit").val() == undefined || $("#unit").val() == "0") {
            swal({
                title: "请填写计量单位！",
                type: "info"
            });
            return;
        }/*判断计量单位是否为空串，0，是否定义*/
        if ($("#price").val() == "" || $("#price").val() == "0" || $("#price").val() == undefined) {
            swal({
                title: "总分数只能为数字！",
                type: "info"
            });
            return;
        }/*判断单价是否为空串，0，是否定义*/
        if(!reg.test($("#price").val())){
            swal({
                title: "单价填写数字！",
                type: "info"
            });
            return;
        }/*判断单价是否为数字*/
        if ($("#specifications").val() == "" || $("#specifications").val() == "0" || $("#specifications").val() == undefined) {
            swal({
                title: "请填写规格！",
                type: "info"
            });
            return;
        }/*判断规格是否为空串，0，是否定义*/
        if ($("#rbrand").val() == "" || $("#rbrand").val() == "0" || $("#rbrand").val() == undefined){
            swal({
                title: "请填写品牌！",
                type: "info"
            });
            return;
        }/*判断品牌是否为空串，0，是否定义*/
        if ($("#in_time").val() == "") {
            swal({
                title: "请填写入库日期！",
                type: "info"
            });
            return;
        }/*判断单价是否为空串*/
        $.post("<%=request.getContextPath()%>/repairSupplies/saveRepairSupplies", {
            /*跳转到controller中的/repairSupplies/saveRepairSupplies注解，通过saveRepairSupplies方法将数据存储到数据库中*/
            id: $("#id").val(),
            suppliesname: $("#suname").val(),
            suppliestype: $("#suppliestype").val(),
            suppliesnum: $("#supplies_num").val(),
            unit: $("#unit").val(),
            price: $("#price").val(),
            specifications: $("#specifications").val(),
            brand: $("#rbrand").val(),
            remark: $("#remark").val(),
            intime: date
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#repairSupplies').DataTable().ajax.reload();/*将前台所有数据传到数据库表里*/
            }
        })
        showSaveLoading();
    }

</script>


