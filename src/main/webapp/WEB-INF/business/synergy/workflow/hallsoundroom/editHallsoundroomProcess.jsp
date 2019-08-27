<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <input id="id" hidden value="${hallsoundroom.id}">
    <div class="col-md-3 tar">
        会议内容
    </div>
    <div class="col-md-9">
        <input id="meetingcontent" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.meetingcontent}" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用开始时间
    </div>
    <div class="col-md-9">
        <input id="starttime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hallsoundroom.starttime}" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用结束时间
    </div>
    <div class="col-md-9">
        <input id="endtime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hallsoundroom.endtime}" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用设备
    </div>
    <div class="col-md-9">
        <div>
            <input id="usedeviceShow" type="text" onclick="showMenu()"  value="${hallsoundroom.usedeviceShow}" />
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="deviceNameTree" class="ztree"></ul>
        </div>
        <input id="usedevice" type="hidden" value="${hallsoundroom.usedevice}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestdept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requestdept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestdate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requestdate}" readonly="readonly"/>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_HALLSOUNDROOM_WF01">
<script>
    $(document).ready(function () {
        $.get("/common/getUserDictToTree?name=BGHC", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
            var node;
            var lis = $("#usedevice").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = deviceNameTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                deviceNameTree.checkNode(node, true, false, callbackFlag);
            }
        });

    })
    function save() {
        var v_starttime = $("#starttime").val();
        var v_endtime =$("#endtime").val();
        var v_requestdate =$("#requestdate").val();
        v_starttime = v_starttime.replace('T', '');
        v_endtime = v_endtime.replace('T', '');
        v_requestdate = v_requestdate.replace('T', '');
        if( $("#requestdept").val() =="" ||  $("#requestdept").val() =="0" || $("#requestdept").val() == undefined){
            alert("请填写申请部门");
            return;
        }
        if($("#meetingcontent").val()=="" ||  $("#meetingcontent").val() =="0" || $("#meetingcontent").val() == undefined){
            alert("请填写会议内容");
            return;
        }
        if($("#starttime").val()=="" ||  $("#starttime").val() =="0" || $("#starttime").val() == undefined){
            alert("请选择开始时间");
            return;
        }
        if($("#endtime").val()=="" ||  $("#endtime").val() =="0" || $("#endtime").val() == undefined){
            alert("请选择结束时间");
            return;
        }
        if($("#usedevice").val()=="" ||  $("#usedevice").val() =="0" || $("#usedevice").val() == undefined){
            alert("请选择设备");
            return;
        }

        if(v_starttime>v_endtime){
            alert("开始时间必须早于结束时间");
            return;
        }
        if(v_requestdate<v_requestdate){
            alert("开始时间必须晚于申请时间");
            return;
        }

        $.post("/hallsoundroom/saveHallsoundroom", {
            id: $("#id").val(),
            requestdept: $("#requestdept").val(),
            meetingcontent: $("#meetingcontent").val(),
            starttime: v_starttime,
            endtime: v_endtime,
            usedevice: $("#usedevice").val(),
            requester: $("#requester").val(),
            requestdate: v_requestdate
        }, function (msg) {
            if (msg.status == 1) {
                $('#hallsoundroomGrid').DataTable().ajax.reload();
            }
        })
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
    var zTree = $.fn.zTree.getZTreeObj("deviceNameTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#usedevice");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#usedevice");
    var cityOffset = $("#usedevice").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "usedeviceShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#usedevice").val(getChildNodes(nodes));//获取子节点
        $("#usedeviceShow").val(getChildNodesSel(nodes));//获取子节点
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
