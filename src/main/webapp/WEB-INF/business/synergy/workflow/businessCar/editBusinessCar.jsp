<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
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
                        <input id="f_requestDate" type="datetime-local"
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
                        <input id="f_startTime" type="datetime-local"
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
                        <input id="f_endTime" type="datetime-local"
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
                        <input id="f_startPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
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
                        <input id="f_endPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
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
                            <input id="cartypeShow" type="text" placeholder="请点击选择"
                                   onclick="showMenu()"  value="${businessCar.carTypeShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="cartypeTree" class="ztree"></ul>
                        </div>
                        <input id="cartype" type="hidden" value="${businessCar.carType}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请事由
                    </div>
                    <div class="col-md-9">
                        <input id="f_reason" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="330" placeholder="最多输入330个字"
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
                        <input id="f_peopleNum"  type="text" placeholder="请填写数字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${businessCar.peopleNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="f_remark" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="330" placeholder="最多输入330个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${businessCar.remark}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=GWYCGL", function (data) {
            var cartypeTree = $.fn.zTree.init($("#cartypeTree"), setting, data);
            var node;
            var lis = $("#cartype").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = cartypeTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                cartypeTree.checkNode(node, true, false, callbackFlag);
            }

        });
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
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
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0") {
            swal({
                title: "请填写起始日期！",
                type: "info"
            });
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0") {
            swal({
                title: "请填写结束日期！",
                type: "info"
            });
            return;
        }
        if( $("#f_startTime").val() > $("#f_endTime").val()){
            swal({
                title: "请选择开始时间需要在结束时间之前！",
                type: "info"
            });
            return;
        }
        if( $("#f_requestDate").val()+1 > $("#f_startTime").val()){
            swal({
                title: "请选择申请时间需要在开始时间的1天之前！",
                type: "info"
            });
            return;
        }
        if ($("#f_startPlace").val() == "" || $("#f_startPlace").val() == "0" || $("#f_startPlace").val() == undefined) {
            swal({
                title: "请填写始发地！",
                type: "info"
            });
            return;
        }
        if ($("#f_endPlace").val() == "" || $("#f_endPlace").val() == "0" || $("#f_endPlace").val() == undefined) {
            swal({
                title: "请填写目的地！",
                type: "info"
            });
            return;
        }
        if ($("#cartype").val() == "" || $("#cartype").val() == "0" || $("#cartype").val() == undefined) {
            swal({
                title: "请填写用车类型！",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写申请事由！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_peopleNum").val()) || $("#f_peopleNum").val() == "" || $("#f_peopleNum").val() == "0" || $("#f_peopleNum").val() == undefined){
            swal({
                title: "人数请填写整数！",
                type: "info"
            });
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T',' ');
        var c_startTime = $("#f_startTime").val().replace('T',' ');
        var c_endTime = $("#f_endTime").val().replace('T',' ');
        $.post("<%=request.getContextPath()%>/businessCar/saveBusinessCar", {
            id: $("#businessCarid").val(),
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate: c_requestDate,
            startTime: c_startTime,
            endTime: c_endTime,
            startPlace: $("#f_startPlace").val(),
            endPlace: $("#f_endPlace").val(),
            carType:$("#cartype").val(),
            reason: $("#f_reason").val(),
            peopleNum: $("#f_peopleNum").val(),
            remark: $("#f_remark").val()
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
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#cartype");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#cartype");
    var cityOffset = $("#cartype").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "cartypeTreeShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#cartype").val(getChildNodes(nodes));//获取子节点
        $("#cartypeShow").val(getChildNodesSel(nodes));//获取子节点
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
