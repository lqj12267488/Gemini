<%--
  Created by IntelliJ IDEA.
  User: hanyue
  Date: 2019/2/19
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="documentid" name="documentid" type="hidden" value="${document.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

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
                        <input id="f_requestDate" value="${document.requestDate}" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"/>
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
                        <div style="white-space:nowrap;" >
                            <textarea id="empSel" type="text" style="height: 12%;" onclick="empType()">${document.deliveryEmpIdShow}</textarea>
                        </div>
                        <div id="empContent" class="empContent" style="width: 95%">
                            <ul id="empTree" class="ztree" ></ul>
                        </div>
                        <input id="empId" type = "hidden" placeholder="最多发送80人" value="${document.deliveryEmpId}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        抄送
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;" >
                            <textarea id="makeEmpSel" type="text" style="height: 12%;" onclick="makeEmpType()">${document.makeEmpIdShow}</textarea>
                        </div>
                        <div id="makeEmpContent" class="makeEmpContent" style="width: 95%">
                            <ul id="makeEmpTree" class="ztree" ></ul>
                        </div>
                        <input id="makeEmpId" type = "hidden" placeholder="最多发送80人" value="${document.makeEmpId}"/>
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
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDocument()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MJ", function (data) {
            addOption(data, 'f_secretClass', '${document.secretClass}');
        });
    })
    function saveDocument() {
        var date = $("#f_requestDate").val();
        date = date.replace('T','');
        var emp=$("#empId").val();
        var makeEmp=$("#makeEmpId").val();

        if ($("#f_fileTitle").val() == "" || $("#f_fileTitle").val() == undefined) {
            swal({
                title: "请填写文件标题!",
                type: "info"
            });
            return;
        }
        /*if (emp == '' || emp == undefined || emp == null) {
            swal({title: "请选择主送",type: "info" });
            return;
        }*/
        if(emp.length>3000){
            swal({title: "发送给个人数量，最多只能80人",type: "info" });
        }
       /* if (makeEmp == '' || makeEmp == undefined || makeEmp == null) {
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
       /* if ($("#f_title").val() == "" || $("#f_title").val() == undefined) {
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

        $.post("<%=request.getContextPath()%>/document/updateDocument", {
            id: $("#documentid").val(),
            requestDate: date,
            fileTitle:$("#f_fileTitle").val(),
            deliveryEmpId:emp,
            makeEmpId:makeEmp,
            secretClass:$("#f_secretClass").val(),
            title:$("#f_title").val(),
            printingNumber:$("#f_printingNumber").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#documentGrid').DataTable().ajax.reload();
            }
        })

        showSaveLoading();
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

    function empType() {
        //人员多选树，初始化
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            var empTree = $.fn.zTree.init($("#empTree"), settingEmp, data);
            var node;
            var lis = $("#empId").val().split(",");
            //设置选择节点
            if(lis!="")
                for(var i = 0;i< lis.length;i++){
                    node = empTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#"+lis[i]).attr("checked");
                    empTree.checkNode(node, true, false, callbackFlag);
                }
        });
        showMenuEmp();
    }

    function makeEmpType() {
        //人员多选树，初始化
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            var makeEmpTree = $.fn.zTree.init($("#makeEmpTree"), settingEmp, data);
            var node;
            var lis = $("#makeEmpId").val().split(",");
            //设置选择节点
            if(lis!="")
                for(var i = 0;i< lis.length;i++){
                    node = makeEmpTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#"+lis[i]).attr("checked");
                    makeEmpTree.checkNode(node, true, false, callbackFlag);
                }
        });
        showMenuMakeEmp();
    }

</script>

<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var settingEmp = {
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
            beforeClick: beforeClickEmp,
            onCheck: onCheckEmp
        }
    };

    function beforeClickEmp(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("empTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheckEmp(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("empTree");
        nodes = zTree.getCheckedNodes(true);
        v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var empId = $("#empId");
        empId.attr("value", v);
    }

    function showMenuEmp() {
        var cityObj = $("#empId");
        var cityOffset = $("#empId").offset();
        $("#empContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDownEmp);
    }

    function hideMenuEmp() {
        $("#empContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownEmp);
    }

    function onBodyDownEmp(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "empSel" || event.target.id == "empContent" || $(event.target).parents("#empContent").length>0)) {
            hideMenuEmp();
            var zTree = $.fn.zTree.getZTreeObj("empTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#empId").val(getChildNodes(nodes));//获取子节点
            $("#empSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }

</script>

<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var settingEmp = {
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
            beforeClick: beforeClickEmp,
            onCheck: onCheckEmp
        }
    };

    function beforeClickEmp(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("makeEmpTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheckEmp(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("makeEmpTree");
        nodes = zTree.getCheckedNodes(true);
        v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var empId = $("#makeEmpId");
        empId.attr("value", v);
    }

    function showMenuMakeEmp() {
        var cityObj = $("#makeEmpId");
        var cityOffset = $("#makeEmpId").offset();
        $("#makeEmpContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDownMakeEmp);
    }

    function hideMenuMakeEmp() {
        $("#makeEmpContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownMakeEmp);
    }

    function onBodyDownMakeEmp(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "makeEmpSel" || event.target.id == "makeEmpContent" || $(event.target).parents("#makeEmpContent").length>0)) {
            hideMenuMakeEmp();
            var zTree = $.fn.zTree.getZTreeObj("makeEmpTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#makeEmpId").val(getChildNodes(nodes));//获取子节点
            $("#makeEmpSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }

</script>
<style>
    #empContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>

<style>
    #makeEmpContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
</script>