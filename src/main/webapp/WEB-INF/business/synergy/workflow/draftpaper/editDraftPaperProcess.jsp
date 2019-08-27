<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="draftId" value="${draftPaper.id}">
<input id="checkDept" type="hidden" value="${draftPaper.checkDept}">
<input id="drafterShow" type="hidden" value="${draftPaper.drafterShow}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        标题
    </div>
    <div class="col-md-9">
        <input id="title" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               value="${draftPaper.title}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        文号
    </div>
    <div class="col-md-9">
        <input id="paperNumber" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               value="${draftPaper.paperNumber}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿人
    </div>
    <div class="col-md-9">
        <input id="drafter"  readonly="readonly" value="${draftPaper.drafter}" type="text"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿人部门
    </div>
    <div class="col-md-9">
        <input id="draftDept" readonly="readonly" value="${draftPaper.draftDept}" type="text"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        核稿人
    </div>
    <div class="col-md-9">
        <input id="checker" readonly="readonly" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               placeholder="请输入核稿人姓名" value="${draftPaper.checkerShow}" type="text"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿日期
    </div>
    <div class="col-md-9">
        <input id="draftDate" value="${draftPaper.draftDate}" type="date" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        内容
    </div>
    <div class="col-md-9">
        <textarea id="content" maxlength="665" placeholder="最多输入665个字"
                  class="validate[required,maxSize[100]] form-control">${draftPaper.content}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        机密等级
    </div>
    <div class="col-md-9">
        <input id="secretLevel" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               value="${draftPaper.secretLevel}" type="text"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        份数
    </div>
    <div class="col-md-9">
        <input id="copies" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               value="${draftPaper.copies}" type="number"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        主送部门
    </div>
    <div class="col-md-9">
        <div style="white-space:nowrap;">
            <input id="sendDeptIdSel" type="text" onclick="showMenu1()"  value="${draftPaper.sendDeptIdShow}" readonly/>
        </div>
        <div id="menuContent1" class="menuContent1">
            <ul id="treeDemo1" class="ztree"></ul>
        </div>
        <input id="sendDeptId" type="hidden" value="${draftPaper.sendDeptId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        抄送部门
    </div>
    <div class="col-md-9">
        <div style="white-space:nowrap;">
            <input id="copyDeptIdSel" type="text" onclick="showMenu2()" placeholder="请点击选择"
                   value="${draftPaper.copyDeptIdShow}" readonly/>
        </div>
        <div id="menuContent2" class="menuContent2">
            <ul id="treeDemo2" class="ztree"></ul>
        </div>
        <input id="copyDeptId" type="hidden" value="${draftPaper.copyDeptId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        报送部门
    </div>
    <div class="col-md-9">
        <div style="white-space:nowrap;">
            <input id="submitDeptIdSel" type="text" onclick="showMenu3()" placeholder="请点击选择"
                   value="${draftPaper.submitDeptIdShow}" readonly/>
        </div>
        <div id="menuContent3" class="menuContent3">
            <ul id="treeDemo3" class="ztree"></ul>
        </div>
        <input id="submitDeptId" type="hidden" value="${draftPaper.submitDeptId}"/>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_DRAFTPAPER_WF01">
<script>
    $(document).ready(function () {
        //主送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo1"), setting, data);
            var node;
            var lis = $("#sendDeptId").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });
        //抄送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree2 = $.fn.zTree.init($("#treeDemo2"), setting, data);
            var node;
            var lis = $("#copyDeptId").val().split(",");
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree2.getNodeByParam("id", lis[i], null);
                var callbackFlag2 = $("#"+lis[i]).attr("checked");
                editRangezTree2.checkNode(node, true, false, callbackFlag2);
            }
        });
        //报送多选
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree3 = $.fn.zTree.init($("#treeDemo3"), setting, data);
            var node;
            var lis = $("#submitDeptId").val().split(",");
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree3.getNodeByParam("id", lis[i], null);
                var callbackFlag3 = $("#"+lis[i]).attr("checked");
                editRangezTree3.checkNode(node, true, false, callbackFlag3);
            }
        });
        //拟稿人自动完成框初始化
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#drafterId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#drafterId").val(ui.item.label);
                    $("#drafterId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        //核稿人自动完成框初始化
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#checker").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#checker").val(ui.item.label);
                    $("#checker").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })


    function save() {
        //核稿人自动完成框
        var  checkerAuto=$("#checker").attr("keycode");
        var  checkerDept="";
        var  checkerId="";
        //核稿人判断
        if(checkerAuto =="" || checkerAuto == undefined){
            checkerId=$("#checker").val();
            checkerDept=$("#checkerDept").val();
        }else{
            checkerDept=checkerAuto.substring(0,6);
            checkerId=checkerAuto.substring(7,checkerAuto.length);
        }
        var co1=$("#copies").val()
        if($("#draftDate").val() =="" || $("#draftDate").val() == undefined){
            swal({
                title: "请选择拟稿时间",
                type: "info"
            });
            //alert("请选择拟稿时间");
            return;
        }
        if($("#title").val() =="" || $("#title").val() == undefined){
            swal({
                title: "请填写标题",
                type: "info"
            });
            //alert("请填写标题");
            return;
        }
        if($("#paperNumber").val() =="" || $("#paperNumber").val() == undefined){
            swal({
                title: "请填写文号",
                type: "info"
            });
            //alert("请填写文号");
            return;
        }
        if(parseInt(co1)<0){
            swal({
                title: "份数请填写整数",
                type: "info"
            });
            $("#copies").val("");
            return;
        }
        if($("#content").val() =="" || $("#content").val() == undefined){
            swal({
                title: "请填写内容",
                type: "info"
            });
            //alert("请填写内容");
            return;
        }
        if($("#sendDeptId").val() =="" ||  $("#sendDeptId").val() == undefined){
            swal({
                title: "请选择主送部门",
                type: "info"
            });
            //alert("请选择主送部门");
            return;
        }

        $.post("<%=request.getContextPath()%>/draftPaper/saveDraftPaper", {
            id: $("#draftId").val(),
            checkDept: checkerDept,
            checker: checkerId,
            draftDate: $("#draftDate").val(),
            paperNumber: $("#paperNumber").val(),
            secretLevel: $("#secretLevel").val(),
            copies: $("#copies").val(),
            title: $("#title").val(),
            content: $("#content").val(),
            sendDeptId:$("#sendDeptId").val(),
            copyDeptId:$("#copyDeptId").val(),
            submitDeptId:$("#submitDeptId").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#draftTable').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>
<!--主送部门-->
<script type="text/javascript">
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
    function showMenu1() {
        var sendDeptIdObj = $("#sendDeptId");
        var sendDeptIdOffset = $("#sendDeptId").offset();
        $("#menuContent1").css({left:sendDeptIdOffset.left + "px", top:sendDeptIdOffset.top + sendDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }
    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "sendDeptIdSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length>0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
                nodes = zTree.getCheckedNodes(true);
            $("#sendDeptId").val(getChildNodes(nodes));//获取子节点
            $("#sendDeptIdSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }
    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var sendDeptId = $("#sendDeptId");
        sendDeptId.attr("value", v);
    }
    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
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
<!--抄送部门-->
<script type="text/javascript">
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
            beforeClick: beforeClick2,
            onCheck: onCheck2
        }
    };
    function showMenu2() {
        var copyDeptIdObj = $("#copyDeptId");
        var copyDeptIdOffset = $("#copyDeptId").offset();
        $("#menuContent2").css({left:copyDeptIdOffset.left + "px", top:copyDeptIdOffset.top + copyDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown2);
    }
    function hideMenu2() {
        $("#menuContent2").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown2);
    }
    function onBodyDown2(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "copyDeptIdObj" || event.target.id == "menuContent2" || $(event.target).parents("#menuContent2").length>0)) {
            hideMenu2();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
                nodes = zTree.getCheckedNodes(true);
            $("#copyDeptId").val(getChildNodes2(nodes));//获取子节点
            $("#copyDeptIdSel").val(getChildNodesSel2(nodes));//获取子节点
        }
    }
    function onCheck2(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var copyDeptId = $("#copyDeptId");
        copyDeptId.attr("value", v);
    }
    function beforeClick2(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodesSel2(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes2(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
</script>
<!--报送部门-->
<script type="text/javascript">
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
            beforeClick: beforeClick3,
            onCheck: onCheck3
        }
    };
    function showMenu3() {
        var submitDeptIdObj = $("#submitDeptId");
        var submitDeptIdOffset = $("#submitDeptId").offset();
        $("#menuContent3").css({left:submitDeptIdOffset.left + "px", top:submitDeptIdOffset.top + submitDeptIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown3);
    }
    function hideMenu3() {
        $("#menuContent3").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown3);
    }
    function onBodyDown3(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "submitDeptIdObj" || event.target.id == "menuContent3" || $(event.target).parents("#menuContent3").length>0)) {
            hideMenu3();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo3"),
                nodes = zTree.getCheckedNodes(true);
            $("#submitDeptId").val(getChildNodes3(nodes));//获取子节点
            $("#submitDeptIdSel").val(getChildNodesSel3(nodes));//获取子节点
        }
    }
    function onCheck3(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo3"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var submitDeptId = $("#submitDeptId");
        submitDeptId.attr("value", v);
    }
    function beforeClick3(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodesSel3(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes3(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
</script>
<style>
    #menuContent1{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent2{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #menuContent3{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>

