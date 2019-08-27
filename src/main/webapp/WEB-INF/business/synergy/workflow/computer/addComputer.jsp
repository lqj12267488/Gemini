<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
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
                <input id="id" hidden value="${computer.id}">
            </div>
            <div class="modal-body clearfix">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                    <div class="controls" >
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                <span class="iconBtx">*</span>
                                申请事由
                            </div>
                            <div class="col-md-9">
                                <input id="reason" type="text" maxlength="330" placeholder="最多输入330个字"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                       class="validate[required,maxSize[100]] form-control"
                                       value="${computer.reason}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                <span class="iconBtx">*</span>
                                外设名称
                            </div>
                            <div class="col-md-9">
                                <div>
                                    <input id="suppliesnameShow" type="text" onclick="showMenu()"
                                           placeholder="请点击选择" value="${computer.suppliesnameShow}"/>
                                </div>
                                <div id="menuContent" class="menuContent">
                                    <ul id="suppliesnameTree" class="ztree"></ul>
                                </div>
                                <input id="suppliesname" type="hidden" value="${computer.suppliesname}"/>
                                <%-- <select  id="suppliesname" />--%>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-md-3 tar">
                                <span class="iconBtx">*</span>
                                申请部门
                            </div>
                            <div class="col-md-9">
                                <input id="requestdept" type="text"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${deptName}" readonly="readonly"/>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-md-3 tar">
                                <span class="iconBtx">*</span>
                                经办人
                            </div>
                            <div class="col-md-9">
                                <input id="manager" type="text"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${personName}" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                <span class="iconBtx">*</span>
                                申请日期
                            </div>
                            <div class="col-md-9">
                                <input id="requestdate" type="datetime-local"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${computer.requestdate}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                备注
                            </div>
                            <div class="col-md-9">
                                <input id="remark" type="text" maxlength="330" placeholder="最多输入330个字"
                                       class="validate[required,maxSize[20]] form-control"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${computer.remark}"/>
                            </div>
                        </div>
                        
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=JSJHC", function (data) {
            //addOption(data, 'suppliesname','$ {computer.suppliesname}');
            var suppliesnameTree = $.fn.zTree.init($("#suppliesnameTree"), setting, data);
        });
    })

    function saveDept() {
        var v_requestDate = $("#requestdate").val();
        v_requestDate = v_requestDate.replace('T','');
        if( $("#requestdept").val() =="" ||  $("#requestdept").val() =="0" || $("#requestdept").val() == undefined){
           swal({
                title: "请填写申请部门!",
                type: "info"
            });
            return;
        }
        if($("#reason").val()=="" ||  $("#reason").val() =="0" || $("#reason").val() == undefined){
           swal({
                title: "请填写申请事由!",
                type: "info"
            });
            return;
        }
        if($("#suppliesname").val()=="" ||  $("#suppliesname").val() =="0" || $("#suppliesname").val() == undefined){
           swal({
                title: "请填写外设名称!",
                type: "info"
            });
            return;
        }
        if($("#manager").val()=="" ||  $("#manager").val() =="0" || $("#manager").val() == undefined){
           swal({
                title: "请填写经办人!",
                type: "info"
            });
            return;
        }
        if($("#requestdate").val()=="" ||  $("#requestdate").val() =="0" || $("#requestdate").val() == undefined){
           swal({
                title: "请填写申请日期!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/computer/saveComputer", {
            id: $("#id").val(),
            requestdept: $("#requestdept").val(),
            reason: $("#reason").val(),
            suppliesname: $("#suppliesname").val(),
            manager: $("#manager").val(),
            requestdate: v_requestDate,
            remark: $("#remark").val(),
            creator:$("#creator").val(),
            createtime:$("#createtime").val(),
            createdept:$("#createdept").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#computerGrid').DataTable().ajax.reload();
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
    var zTree = $.fn.zTree.getZTreeObj("suppliesnameTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("suppliesnameTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#suppliesname");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#suppliesname");
    var cityOffset = $("#suppliesname").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "suppliesnameShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("suppliesnameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#suppliesname").val(getChildNodes(nodes));//获取子节点
        $("#suppliesnameShow").val(getChildNodesSel(nodes));//获取子节点
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


