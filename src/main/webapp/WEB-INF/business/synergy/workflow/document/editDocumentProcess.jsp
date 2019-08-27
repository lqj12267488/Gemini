<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:29
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
<input type="hidden" id="documentid" value="${document.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" readonly="readonly" value="${document.requestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${document.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        文件标题
    </div>
    <div class="col-md-9">
        <input id="f_fileTitle" type="text"  class="validate[required,maxSize[100]] form-control"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="100" placeholder="最多输入100个字"
               value="${document.fileTitle}" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        主送
    </div>
    <div class="col-md-9">
        <input id="className" value="${document.deliveryEmpIdShow}" style="height: 12%;"
               onclick="showMenu()"/>
        <div id="menuContentEdit" class="menuContent">
            <ul id="treeEdit" class="ztree"></ul>
        </div>
        <input id="classId" hidden placeholder="最多发送80人" value="${document.deliveryEmpId}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        抄送
    </div>
    <div class="col-md-9">
        <input id="makeClassName" value="${document.makeEmpIdShow}" style="height: 12%;"
               onclick="showMenuMake()"/>
        <div id="menuContentMake" class="menuContentMake">
            <ul id="makeTree" class="ztree"></ul>
        </div>
        <input id="makeClassId" hidden placeholder="最多发送80人" value="${document.makeEmpId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        密级
    </div>
    <div class="col-md-9">
        <select id="f_secretClass" class="validate[required,maxSize[100]] form-control"></select>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        标题
    </div>
    <div class="col-md-9">
        <input id="f_title" type="text"  class="validate[required,maxSize[100]] form-control"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="100" placeholder="最多输入100个字"
               value="${document.title}" />
    </div>
</div>--%>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        打印份数
    </div>
    <div class="col-md-9">
        <input id="f_printingNumber" type="number"  class="validate[required,maxSize[100]] form-control"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="10" placeholder="最多输入10个字"
               value="${document.printingNumber}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span> 文件上传：
    </div>
    <div class="col-md-9">
        <input id="fileUpload" type="file"/>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_INFO_DIFFUSION_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/document/printDocument?id=${document.id}">
<style type="text/css">
    textarea {
        resize: none;
    }

    #menuContentEdit {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style type="text/css">
    textarea {
        resize: none;
    }

    #menuContentMake {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script>

    var hiddenInput = "classId";
    var nameShow = "className";
    var hiddenInputMake = "makeClassId";
    var nameShowMake = "makeClassName";
    var classTree;
    var selectTreeId = "treeEdit";
    var makeClassTree;
    var selectTreeIdMake = "makeTree";
    var selectTreeMakeSetting = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "N": "s"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false,
            showLine: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClickMake,
            onCheck: onCheckMake,
        }
    };
    var selectTreeSetting = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "N": "s"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false,
            showLine: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck,
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MJ", function (data) {
            addOption(data, 'f_secretClass', '${document.secretClass}');
        });
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            classTree = $.fn.zTree.init($("#treeEdit"), selectTreeSetting, data);
            var classIds = '${document.deliveryEmpId}';
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = classTree.getNodeByParam("id", classId[i]);
                    classTree.checkNode(node, true, false);
                }
            }
        })

        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            makeClassTree = $.fn.zTree.init($("#makeTree"), selectTreeMakeSetting, data);
            var classIds = '${document.makeEmpId}';
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = classTree.getNodeByParam("id", classId[i]);
                    makeClassTree.checkNode(node, true, false);
                }
            }
        })
    })


    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T','');
        var emp = $("#classId").val();
        var makeEmp = $("#makeClassId").val();

        var formData = new FormData();
        var fileUpload = document.getElementById("fileUpload");
        if (fileUpload.files[0]!= undefined){
            formData.append("file", fileUpload.files[0]);
        }
        var fileUpload = $("#fileUpload").val();
        var fileUpload_end = fileUpload.split(".");

        if (fileUpload_end[1] == 'bat' || fileUpload_end[1] == "exe") {
            swal({title: "不可上传可执行文件！", type: "info"});
            return;
        }
        if ($("#f_fileTitle").val() == "" || $("#f_fileTitle").val() == undefined) {
            swal({
                title: "请填写文件标题!",
                type: "info"
            });
            return;
        }
       /* if (emp == '' || emp == undefined || emp == null) {
            swal({title: "请选择主送",type: "info" });
            return;
        }*/
        if(emp.length>3000){
            swal({title: "发送给个人数量，最多只能80人",type: "info" });
        }
        /*if (makeEmp == '' || makeEmp == undefined || makeEmp == null) {
            swal({title: "请选择抄送",type: "info" });
            return;
        }*/
        if(makeEmp.length>3000){
            swal({title: "发送给个人数量，最多只能80人",type: "info" });
        }
        if ($("#f_secretClass").val() == "" || $("#f_secretClass").val() == undefined) {
            swal({
                title: "请选择密级!",
                type: "info"
            });
            return;
        }
        /*if ($("#f_title").val() == "" || $("#f_title").val() == undefined) {
            swal({
                title: "请填写标题!",
                type: "info"
            });
            return;
        }*/
        if ($("#f_printingNumber").val() == "" || $("#f_printingNumber").val() == undefined) {
            swal({
                title: "请填写打印份数!",
                type: "info"
            });
            return;
        }
        formData.append("requestDate", date);
        formData.append("fileTitle", $("#f_fileTitle").val());
        formData.append("deliveryEmpId", emp);
        formData.append("makeEmpId", makeEmp);
        formData.append("secretClass", $("#f_secretClass").val());
        formData.append("title", $("#f_title").val());
        formData.append("printingNumber", $("#f_printingNumber").val());

        $.ajax({
            url: '<%=request.getContextPath()%>/document/saveDocument' +
            '?id=' + $("#documentid").val(),
            type: "post",
            processData: false,
            contentType: false,
            data: formData,
            success: function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#documentGrid').DataTable().ajax.reload();
            }

        });
        showSaveLoading();
        return true;
    }


    function beforeClickMake(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var v = "";
        for (var i = 0, l = treeNode.length; i < l; i++) {
            v += treeNode[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#" + nameShow).attr("value", v);

    }

    function onCheckMake(e, treeId, treeNode) {
        var v = "";
        for (var i = 0, l = treeNode.length; i < l; i++) {
            v += treeNode[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#" + nameShowMake).attr("value", v);

    }

    function showMenu() {
        var Obj = $("#" + nameShow);
        var Offset = $("#" + nameShow).offset();
        $("#menuContentEdit").css({
            left: Offset.left + "px",
            top: Offset.top + Obj.outerHeight() + "px",
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function showMenuMake() {
        var Obj = $("#" + nameShowMake);
        var Offset = $("#" + nameShowMake).offset();
        $("#menuContentMake").css({
            left: Offset.left + "px",
            top: Offset.top + Obj.outerHeight() + "px",
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDownMake);
    }

    function hideMenu() {
        $("#menuContentEdit").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function hideMenuMake() {
        $("#menuContentMake").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownMake);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == hiddenInput || event.target.id == "menuContentEdit" || $(event.target).parents("#menuContentEdit").length > 0)) {
            hideMenu();
            var nodes = $.fn.zTree.getZTreeObj(selectTreeId).getCheckedNodes(true);
            $("#" + hiddenInput).val(getChildNodes(nodes));//获取子节点
            $("#" + nameShow).val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function onBodyDownMake(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == hiddenInputMake || event.target.id == "menuContentMake" || $(event.target).parents("#menuContentMake").length > 0)) {
            hideMenuMake();
            var nodes = $.fn.zTree.getZTreeObj(selectTreeIdMake).getCheckedNodes(true);
            $("#" + hiddenInputMake).val(getChildNodes(nodes));//获取子节点
            $("#" + nameShowMake).val(getChildNodesSel(nodes));//获取子节点
        }
    }


    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 3) {
                nodes += treeNode[i].name + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 3) {
                nodes += treeNode[i].id + ",";
            }
        }
        if (nodes.length == 0) {
            swal({
                title: "请选择人员！",
                type: "info"
            });
            return;
        } else {
            return nodes.substring(0, nodes.length - 1);
        }
    }
</script>

