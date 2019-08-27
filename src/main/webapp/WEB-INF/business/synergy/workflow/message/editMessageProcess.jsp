<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:03
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
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${message.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${message.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly="readonly"
               value="${message.publicTime}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <input id="m_title" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${message.title}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        类型
    </div>
    <div class="col-md-9">
        <select id="m_type" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        发送给个人
    </div>
    <div class="col-md-9">
        <div style="white-space:nowrap;" id="person">
            <textarea id="deptSel" type="text" onclick="messageType()">${message.empIdShow}</textarea>
        </div>
        <div id="menuContent1" class="menuContent1">
            <ul id="treeDemo" class="ztree" ></ul>
        </div>
        <input id="empId" type = "hidden" value="${message.stuId}"/>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        发送人员
    </div>
    <div class="col-md-9">
        <input id="shootingMethod"
               class="validate[required,maxSize[100]] form-control"
               value="${message.shootingMethod}"/>
    </div>
</div>--%>
<div class="form-row">
    <div class="col-md-3 tar">
        发送给部门
    </div>
    <div class="col-md-9">
        <div style="white-space:nowrap;">
            <textarea id="dSel" type="text" style="height: 7%;" onclick="deptType()">${message.deptIdShow}</textarea>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="treeDemo1" class="ztree" ></ul>
        </div>
        <input id="deptId" type = "hidden" value="${message.deptId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        内容
    </div>
    <div class="col-md-9">
        <input id="m_content" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${message.content}"/>
    </div>
</div>
<input id="h_Id" hidden value="${message.id}"/>
<input id="workflowCode" hidden value="T_SYS_MESSAGE_WF">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/message/printMessage?id=${message.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TZLX", function (data) {
            addOption(data, "m_type","${message.type}");
        })
    })

    function messageType() {
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#empId").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });
        showMenu();
    }
    function deptType() {
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo1"), setting2, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });
        showMenu2();

    }
    function save(){
        var title = $("#m_title").val();
        var range=$("#range option:selected").val();
        var type = $("#m_type option:selected").val();
        var content = $("#m_content").val();
        var dept=$("#deptId").val();
        var emp=$("#empId").val();
        /*alert(emp.length)*/
        if (!title == '' || !title == undefined || !title == null) {
            if (title.indexOf(" ") !=-1 || title.indexOf("/")!=-1 || title.indexOf("@")!=-1){
                swal({
                    title: "标题中不可包含特殊符号。例如[空格]、[/]、[@]等！",
                    type: "info"
                });
                //alert("标题中不可包含特殊符号。例如[空格]、[/]、[@]等！");
                return;
            }

        }else{
            swal({
                title: "请填写标题",
                type: "info"
            });
            //alert("请填写标题！");
            return;
        }
        if(emp.length>3000){
            swal({
                title: "发送给个人数量，最多只能80人",
                type: "info"
            });
            //alert("发送给个人数量，最多只能80人");
        }
        if (type == '' || type == undefined || type == null) {
            swal({
                title: "请选择类型",
                type: "info"
            });
            //alert("请选择类型！");
            return;
        }
        if ((dept == '' || dept == undefined || dept == null) && (emp == '' || emp == undefined || emp == null)) {
            swal({
                title: "请选择发送部门或者发送人员",
                type: "info"
            });
            //alert("请选择发送部门或者发送人员！");
            return;
        }
        if (content == '' || content == undefined || content == null) {
            swal({
                title: "请编辑内容",
                type: "info"
            });
            //alert("请编辑内容！");
            return;
        }
        $.post("<%=request.getContextPath()%>/message/saveProcessMessage", {
            id: $("#h_Id").val(),
            title: title,
            type: type,
            empId:emp,
            deptId:dept,
            content: content
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg)
                $("#dialog").modal("hide");
                messageTable.ajax.reload();
            }
        })
        return true;
    }
</script>
<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "Y": "ps"}
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
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var empId = $("#empId");
        empId.attr("value", v);
    }

    function showMenu() {
        var cityObj = $("#empId");
        var cityOffset = $("#empId").offset();
        $("#menuContent1").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        /*$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");*/
        $("body").bind("mousedown", onBodyDown);
        //}
    }
    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        /* $("#menuContent").fadeOut("fast");*/
        $("body").unbind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "deptSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length>0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getCheckedNodes(true);
            $("#empId").val(getChildNodes(nodes));//获取子节点
            $("#deptSel").val(getChildNodesSel(nodes));//获取子节点
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
<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var setting2 = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "Y": "ps"}
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

    function beforeClick2(treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
        zTree.checkNode(treeNode2, !treeNode2.checked, null, true);
        return false;
    }

    function onCheck2(e, treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var dId = $("#deptId");
        dId.attr("value", v);
    }

    function showMenu2() {
        var cityObj = $("#deptId");
        var cityOffset = $("#deptId").offset();
        $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown2);
    }
    function hideMenu2() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown2);
    }
    function onBodyDown2(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "dSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
            hideMenu2();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo1"),
                nodes = zTree.getCheckedNodes(true);
            $("#deptId").val(getChildNodes2(nodes));//获取子节点
            $("#dSel").val(getChildNodesSel2(nodes));//获取子节点
        }
    }

    function getChildNodesSel2(treeNode2) {
        var nodes = new Array();
        for(i = 0; i < treeNode2.length; i++) {
            nodes[i] = treeNode2[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes2(treeNode2) {
        var nodes = new Array();
        for(i = 0; i < treeNode2.length; i++) {
            nodes[i] = treeNode2[i].id;
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
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>

