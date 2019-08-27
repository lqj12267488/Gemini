<%--寝室信息维护管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/15
  Time: 15:03
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
            <input id="c_id" hidden value="${dorm.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  寝室名称
                    </div>
                    <div class="col-md-9">
                        <input id="c_dormName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${dorm.dormName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   寝室类型
                    </div>
                    <div class="col-md-9">
                        <select id="qslx"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所在楼宇
                    </div>
                    <div class="col-md-9">
                        <select id="c_building"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 所在楼层
                    </div>
                    <div class="col-md-9">
                        <select id="c_floor"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  容纳人数
                    </div>
                    <div class="col-md-9">
                        <input id="c_peopleNumber" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${dorm.peopleNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="c_remark" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${dorm.remark}"/>
                    </div>
                </div>


            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "id",
                text: "building_name",
                tableName: "T_JW_BUILDING",
                where: "WHERE valid_flag ='1' AND building_type ='6'",
                orderby: "ORDER BY building_name"
            }
            , function (data) {
                addOption(data, 'c_building', '${dorm.buildingId}');
            });
        $("#c_floor").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+'${dorm.buildingId}',function (data) {
            addOption(data, 'c_floor','${dorm.floor}');
        });
        $("#c_building").change(function () {
            $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+$("#c_building").val(),function (data) {
                addOption(data, 'c_floor');
            });
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QSLX", function (data) {
            addOption(data, 'qslx', '${dorm.dormType}');
        });
    })

    function save() {
        var reg = /^[0-9]+?[0-9]*$/;
        if ($("#c_dormName").val() == "" || $("#c_dormName").val() == "0" || $("#c_dormName").val() == undefined) {
            swal({
                title: "请填写寝室名称!",
                type: "info"
            });
            return;
        }
        if ($("#qslx option:selected").val() == "" || $("#qslx option:selected").val() == "0" || $("#qslx option:selected").val() == undefined) {
            swal({
                title: "请选择寝室类型!",
                type: "info"
            });
            return;
        }
        if ($("#c_building option:selected").val() == "" || $("#c_building option:selected").val() == "0" || $("#c_building option:selected").val() == undefined) {
            swal({
                title: "请选择所在楼宇!",
                type: "info"
            });
            return;
        }
        if ($("#c_floor option:selected").val() == "" || $("#c_floor option:selected").val() == "0" || $("#c_floor option:selected").val() == undefined) {
            swal({
                title: "请选择所在楼层!",
                type: "info"
            });
            return;
        }
        if ($("#c_peopleNumber").val() == "" || $("#c_peopleNumber").val() == "0" || $("#c_peopleNumber").val() == undefined) {
            swal({
                title: "请填写容纳人数!",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#c_peopleNumber").val())) {
            swal({
                title: "容纳人数请填写整数!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/dorm/checkName", {
            dormName: $("#c_dormName").val(),
            id: $("#c_id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: "寝室名称重复，请重新填写!",
                    type: "error"
                });
            } else {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/dorm/saveDorm", {
                    id: $("#c_id").val(),
                    dormType: $("#qslx option:selected").val(),
                    dormName: $("#c_dormName").val(),
                    buildingId: $("#c_building option:selected").val(),
                    floor: $("#c_floor option:selected").val(),
                    peopleNumber: $("#c_peopleNumber").val(),
                    remark: $("#c_remark").val(),
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#dormGrid').DataTable().ajax.reload();
                    }
                })
            }
        })
    }
</script>
