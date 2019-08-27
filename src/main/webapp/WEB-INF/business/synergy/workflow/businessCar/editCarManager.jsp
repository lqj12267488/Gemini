<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 17:08
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
            <input id="businessCarid" hidden value="${businessCar.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.requestDept}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.requester}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        起始时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_startTime" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.startTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_endTime" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.endTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        始发地
                    </div>
                    <div class="col-md-9">
                        <input id="f_startPlace" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.startPlace}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        目的地
                    </div>
                    <div class="col-md-9">
                        <input id="f_endPlace" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.endPlace}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        用车类型
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="businessCarShow" type="text"  value="${businessCar.carTypeShow}" readonly="readonly" />
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="businessCarTree" class="ztree"></ul>
                        </div>
                        <input id="businessCar" type="hidden" value="${businessCar.carType}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请事由
                    </div>
                    <div class="col-md-9">
                        <input id="f_reason" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.reason}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_peopleNum"  type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.peopleNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="f_remark" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${businessCar.remark}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        用车方式
                    </div>
                    <div class="col-md-9">
                        <input id="f_useType" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.useType}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        用车费用
                    </div>
                    <div class="col-md-9">
                        <input id="f_carCost" type="text" placeholder="请输入数字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.carCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        租用公司
                    </div>
                    <div class="col-md-9">
                        <input id="f_hireCompany" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.hireCompany}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        检查员
                    </div>
                    <div class="col-md-9">
                        <input id="f_carManager" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.carManager}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        检查时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_checkTime" type="datetime-local"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.checkTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        检查员部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_carManagerDept"  type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${businessCar.carManagerDept}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function saveDept() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
            swal({
                title: "请填写申请部门！",
                type: "info"
            });
            return;
        }
        if ($("#f_requester").val() == "" || $("#f_requester").val() == "0" || $("#f_requester").val() == undefined) {
            swal({
                title: "请填写申请人！",
                type: "info"
            });
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期！",
                type: "info"
            });
            return;
        }
        if ($("#f_useType").val() == "" || $("#f_useType").val() == "0" || $("#f_useType").val() == undefined) {
            swal({
                title: "请填写用车方式！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_carCost").val())){
            swal({
                title: "用车费用请输入数字！",
                type: "info"
            });
            return;
        }
        if ($("#f_hireCompany").val() == "" || $("#f_hireCompany").val() == "0" || $("#f_hireCompany").val() == undefined) {
            swal({
                title: "请填写租用公司！",
                type: "info"
            });
            return;
        }
        if ($("#f_checkTime").val() == "" || $("#f_checkTime").val() == "0") {
            swal({
                title: "请填写检查时间！",
                type: "info"
            });
            return;
        }
        if($("#f_requestDate").val() > $("#f_checkTime").val()){
            swal({
                title: "申请时间应该在检查员检查时间之前！",
                type: "info"
            });
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T',' ');
        var c_checkTime = $("#f_checkTime").val().replace('T',' ');
        var c_startTime = $("#f_startTime").val().replace('T',' ');
        var c_endTime = $("#f_endTime").val().replace('T',' ');
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/businessCar/saveBusinessCarManager", {
            id: $("#businessCarid").val(),
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate: c_requestDate,
            startTime: c_startTime,
            endTime: c_endTime,
            startPlace: $("#f_startPlace").val(),
            endPlace: $("#f_endPlace").val(),
            reason: $("#f_reason").val(),
            peopleNum: $("#f_peopleNum").val(),
            remark: $("#f_remark").val(),
            useType:$("#f_useType").val(),
            carCost:$("#f_carCost").val(),
            hireCompany:$("#f_hireCompany").val(),
            carManager:$("#f_carManager").val(),
            checkTime:c_checkTime,
            carManagerDept:$("#f_carManagerDept").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#businessCar').DataTable().ajax.reload();

            }
        })
        showSaveLoading();
    }
</script>
<%--
<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: {"Y":"", "N":""}
    },
    view: {
        dblClickExpand: false,
        showIcon: false
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        beforeClick: beforeClick,
        onCheck: onCheck
    }
};

function beforeClick(treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("businessCarTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("businessCarTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#businessCar");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#businessCar");
    var cityOffset = $("#businessCar").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "businessCarTreeShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("businessCarTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#businessCar").val(getChildNodes(nodes));//获取子节点
        $("#businessCarShow").val(getChildNodesSel(nodes));//获取子节点
    }
}

function getChildNodesSel(treeNode) {
    var nodes = new Array();
    for(i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].name;
    }
    return nodes.join(",");
}

function getChildNodes(treeNode) {
    var nodes = new Array();
    for(i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");
}
</script>
<style>
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
--%>


