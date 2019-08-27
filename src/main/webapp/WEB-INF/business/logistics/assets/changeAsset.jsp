<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">资产变更</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2">
                        资产名称：
                    </div>
                    <div class="col-md-10">
                        ${assetsName}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3">
                        <span class="iconBtx">*</span>
                        变更类型：
                    </div>
                    <div class="col-md-6">
                        <select id="status" onchange="changeMajor()"></select>
                    </div>
                </div>
                <div class="form-row" id="usedeviceShowDiv">
                    <div class="col-md-3">
                        <span class="iconBtx">*</span>
                       报废类型：
                    </div>
                    <div class="col-md-6">
                        <select id="status2"></select>
                    </div>
                </div>
                <div class="form-row" id="deptShow">
                    <div class="col-md-3">
                        <span class="iconBtx">*</span>
                        部门：
                    </div>
                    <div class="col-md-6">
                        <input id="dept">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3">
                        <span class="iconBtx">*</span>
                        位置：
                    </div>
                    <div class="col-md-6">
                        <input id="direction" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="65" placeholder="最多输入65个字">
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XCZT", function (data) {
            addOption(data, 'status', $("#sexSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BFLY", function (data) {
            addOption(data, 'status2', $("#scrapReson").val());
        });
        $.get("<%=request.getContextPath()%>/common/getDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
        if($("#status").val() !='5'){
            $('#usedeviceShowDiv').hide();
        }
        if($("#status").val() !='8'){
            $('#deptShow').hide();
        }
    });

    function changeMajor() {
        status = $('#status option:selected').val();
        if(status=='5'){
            $('#usedeviceShowDiv').show();
        }else{
            $("#scrapReson").val('');
            $('#usedeviceShowDiv').hide();
        }
        if(status=='8'){
            $('#deptShow').show();
        }else{
            $("#dept").val('');
            $('#deptShow').hide();
        }
    }

    function save() {
        var ids = '${ids}';
        var status = $("#status").val();
        var status2=$("#status2").val();
        if(status == "" || status=="0" || status == undefined){
            swal({
                title: "请选择变更类型!",
                type: "info"
            });
        }
        if (status=='8') {
            var deptId = $("#dept").attr("keycode");
            if (deptId == "" || deptId == undefined || deptId == null) {
                swal({
                    title: "请选择部门!",
                    type: "info"
                });
                return;
            }
        }
        var direction = $("#direction").val();
        $.post("<%=request.getContextPath()%>/assets/changeAssets", {
            ids: ids,
            status: status,
            scrapReson:status2,
            direction: direction,
            deptid:$("#dept").attr("keycode")
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $("#assetsGrid").DataTable().ajax.reload();
        })
        showSaveLoading();
    }
</script>



