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
                                    耗材类型
                                </div>
                                <div class="col-md-9">
                                    <select id="suppliestype" ></select>
                                </div>
                            </div>
                             <div class="form-row">
                                 <div class="col-md-3 tar">
                                     <span class="iconBtx">*</span>
                                     耗材名称
                                 </div>
                                 <div class="col-md-9">
                                     <select id="suppliesname"  onchange="changeData()"></select>
                                 </div>
                             </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    库存数量
                                </div>
                                <div class="col-md-9">
                                    <input id="supplies_in_num"  name="now_number" placeholder="请填写数字"
                                           type="text" readonly="readonly"/>
                                </div>
                            </div>
                             <div class="form-row">
                                 <div class="col-md-3 tar">
                                     <span class="iconBtx">*</span>
                                     使用数量
                                 </div>
                                 <div class="col-md-9">
                                     <input id="supplies_num" placeholder="请填写数字"  type="text"/>
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
                                           value="${RepairSupplies.unit}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    备注
                                </div>
                                <div class="col-md-9">
                                    <input id="remark" value="${RepairSupplies.remark}"
                                           onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           maxlength="15" placeholder="最多输入15个字"
                                           class="validate[required,maxSize[100]] form-control" />
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 tar">
                                    <span class="iconBtx">*</span>
                                    使用日期
                                </div>
                                <div class="col-md-9">
                                    <input id="in_time"  type="date"
                                           class="validate[required,maxSize[100]] form-control"
                                           value="${RepairSupplies.intime}" />
                                </div>
                            </div>
                         </div>
                    </div>
            <div class="modal-footer">
                <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveSupplies()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
    </div>
</div>
<input id="id" hidden value="${RepairSupplies.id}">
<input id="repairId"  hidden value="${RepairSupplies.repairID}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var sname;
    var  newsum;
    $(document).ready(function () {
        /*耗材类型*/
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_USERDIC",
                where: " WHERE 1 = 1 and dic_type='WXHCLX' and VALID_FLAG = '1'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "suppliestype");
            })
        /*耗材名称连动*/
        $("#suppliestype").change(function() {
            var name_sql = "(select supplies_id,func_get_userdicvalue(supplies_name,'WXHCXX') ||' ('||SUPPLIES_IN_NUM||')' as suppliesname " +
                "from T_ZW_REPAIRSUPPLIES where 1=1";
            if($("#suppliestype option:selected").val()!="") {
                name_sql+= "  and SUPPLIES_TYPE= '" + $("#suppliestype option:selected").val() +"'";
            }
            name_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " supplies_id ",
                    text: " suppliesname ",
                    tableName: name_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "suppliesname");
                })
        });
    })
    /*连动库存数量*/
    function  changeData(){
        $.get("<%=request.getContextPath()%>/repairSupplies/getSuppliesInnum?id="+$("#suppliesname option:selected").val(), function (data) {
            var now_number=$("#supplies_in_num").val(data);
            newsum=data;
        });
        $.post("<%=request.getContextPath()%>/repairSupplies/getName",{
            id:$("#suppliesname option:selected").val()
        }, function (data) {
            /*alert(data.msg)*/
            sname=data.msg;
        });
    }
    function saveSupplies() {
        var reg1 = new RegExp("^[0-9]*$");
        var reg = /^[0-9]+.?[0-9]*$/;/*用来判断输入的是否是数字*/
        var date = $("#in_time").val();/*从数据库中通过id获取时间*/
       /* date = date.replace('T', '');/!*将从数据库中获取的时间中的T用空字符串替换*!/!*/
        var num=$("#supplies_num").val();
        if ($("#suppliesname").val() == "" || $("#suppliesname").val() == "0" || $("#suppliesname").val() == undefined ) {
            swal({
                title: "请选择耗材名称！",
                type: "info"
            });
            return;
        }
        if ($("#suppliestype").val() == "" || $("#suppliestype").val() == "0" || $("#suppliestype").val() == undefined ) {
            swal({
                title: "请选择耗材类型！",
                type: "info"
            });
            return;
        }
        if ($("#supplies_num").val() == "" || $("#supplies_num").val() == "0" || $("#supplies_num").val() == undefined) {
            swal({
                title: "请填写使用数量！",
                type: "info"
            });
            $("#supplies_num").val("");
            return;
        }
        if(!reg1.test($("#supplies_num").val())){
            swal({
                title: "耗材数量请填写正整数！",
                type: "info"
            });
            $("#supplies_num").val("");
            return;
        }
        /*alert(num);
        alert(newsum);*/
        if(newsum-num<0){
            swal({
                title: "使用数量超出库存数量，请重新填写！",
                type: "info"
            });
            $("#supplies_num").val("");
            return;
        }
        if ($("#unit").val() == "" || $("#unit").val() == "0" || $("#unit").val() == undefined ) {
            swal({
                title: "请填写计量单位！",
                type: "info"
            });
            return;
        }
        if ($("#in_time").val() == "") {
            swal({
                title: "请选择使用日期！",
                type: "info"
            });
            return;
        }
      /* alert($("#suppliesname option:selected").val())*/
        $.post("<%=request.getContextPath()%>/repairSupplies/saveAddSupplies", {
            suppliesid: $("#suppliesname option:selected").val(),
            suppliesname:sname,
            repairID: $("#repairId").val(),
            suppliestype: $("#suppliestype option:selected").val(),
            suppliesnum: num,
            suppliesInnum:newsum-num,
            unit: $("#unit").val(),
            remark: $("#remark").val(),
            intime: $("#in_time").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#repairSupplies').DataTable().ajax.reload();/*将前台所有数据传到数据库表里*/
            }
        })
        hideSaveLoading();
    }

</script>


