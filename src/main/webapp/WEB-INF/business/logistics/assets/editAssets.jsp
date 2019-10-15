<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog"><%--整个页面(有新增页)--%>
    <div class="modal-content block-fill-white"><%--新增页框--%>
        <div class="modal-header"><%--新增页头部--%>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="assetsId" hidden value="${assets.id}"/>
        </div>
        <div class="modal-body clearfix"><%--新增页体部--%>
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls"><%--''--%>
                <div class="form-row"><%--第一行整体--%>
                    <div class="col-md-3 tar"><%--第一行左侧--%>
                        <span class="iconBtx">*</span>
                        资产名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="assetsName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   maxlength="15" placeholder="最多输入15个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.assetsName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        资产类型
                    </div>
                    <div class="col-md-9">
                        <select id="assetsType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        资产数量
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="assetsNumAll" type="text" placeholder="请输入数字"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.assetsNumAll}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        计量单位
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="unit" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   maxlength="15" placeholder="最多输入15个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.unit}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        单价(元)
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="price" type="text" placeholder="请输入数字"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.price}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        规格
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="specifications" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   maxlength="15" placeholder="最多输入15个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.specifications}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        品牌
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="brand" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   maxlength="15" placeholder="最多输入15个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${assets.brand}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                            <textarea id="remark" maxlength="165" placeholder="最多输入165个字"
                                      class="validate[required,maxSize[100]] form-control"
                            >${assets.remark}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        入库时间
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="inTime" type="date" value="${assets.inTime}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        资产购买时间
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="buyTime" type="date" value="${assets.inTime}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer"><%--新增页尾部--%>
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveAssets()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=XCLB", function (data) {
            addOption(data, 'assetsType', '${assets.assetsType}');
        });
    });

    function saveAssets() {
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
        if ($("#assetsName").val() == "" || $("#assetsName").val() == undefined) {
             swal({
                title: "请填写资产名称!",
                type: "info"
            });
            return;
        }
        if ($("#assetsType  option:selected").val() == "" || $("#assetsType").val() == undefined) {
             swal({
                title: "请选择资产类型!",
                type: "info"
            });
            return;
        }
        if ($("#assetsNumAll").val() == "" || $("#assetsNumAll").val() == undefined) {
             swal({
                title: "请填写资产数量!",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#assetsNumAll").val())) {
             swal({
                title: "资产数量请填写整数!",
                type: "info"
            });
            return;
        }
        if ($("#unit").val() == "" || $("#unit").val() == undefined) {
             swal({
                title: "请填写计量单位!",
                type: "info"
            });
            return;
        }
        if ($("#price").val() == "" || $("#price").val() == undefined) {
             swal({
                title: "请填写单价!",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#price").val())) {
             swal({
                title: "单价请填写数字!",
                type: "info"
            });
            return;
        } else if (!reg3.test($("#price").val())) {
             swal({
                title: "单价小数位数超过两位,请重新填写!",
                type: "info"
            });
            return;
        }
        if ($("#specifications").val() == "" || $("#specifications").val() == undefined) {
             swal({
                title: "请填写规格!",
                type: "info"
            });
            return;
        }
        if ($("#brand").val() == "" || $("#brand").val() == undefined) {
             swal({
                title: "请填写品牌!",
                type: "info"
            });
            return;
        }
        if ($("#inTime").val() == "" || $("#inTime").val() == undefined) {
             swal({
                title: "请填写入库时间!",
                type: "info"
            });
            return;
        }
        if ($("#buyTime").val() == "" || $("#inTime").val() == undefined) {
            swal({
                title: "请填写资产购买时间!",
                type: "info"
            });
            return;
        }
        var id = $("#assetsId").val();
        var assetsName = $("#assetsName").val();
        var assetsType = $("#assetsType  option:selected").val();
        var assetsNumAll = $("#assetsNumAll").val();
        var unit = $("#unit").val();
        var price = $("#price").val();
        var specifications = $("#specifications").val();
        var brand = $("#brand").val();
        var remark = $("#remark").val();
        var inTime = $("#inTime").val();
        inTime = inTime.replace("T", " ");
        var buyTime = $("#buyTime").val();
        buyTime = buyTime.replace("T"," ");
        $.post("<%=request.getContextPath()%>/assets/saveAssets", {
            id: id,
            assetsName: assetsName,
            assetsType: assetsType,
            assetsNumAll: assetsNumAll,
            assetsNumIn: '${assetsNumIn}',
            unit: unit,
            price: price,
            specifications: specifications,
            brand: brand,
            remark: remark,
            inTime: inTime,
            buyTime:buyTime
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#assetsGrid').DataTable().ajax.reload();
        })
        showSaveLoading();
    }
</script>



