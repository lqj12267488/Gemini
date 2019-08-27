.<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white" style="width: 130%">
        <div class="modal-header" style="height: 10%">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        标题
                    </div>
                    <div class="col-md-10">
                        <input id="title" type="text"
                               class="validate[required,maxSize[20]] form-control" maxlength="30" placeholder="最多输入30个字"
                               value="${message.title}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        类型
                    </div>
                    <div class="col-md-4">
                        <select id="type" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        接收部门
                    </div>
                    <div class="col-md-10">
                        <div style="white-space:nowrap;">
                            <textarea id="deptSel" type="text" style="height: 7%;" onclick="deptType()">${message.deptIdShow}</textarea>
                        </div>
                        <div id="deptContent" class="deptContent" style="width: 95%">
                            <ul id="deptTree" class="ztree" ></ul>
                        </div>
                        <input id="deptId" type = "hidden" value="${message.deptId} " placeholder="最多选择400个部门"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        接收人员
                    </div>
                    <div class="col-md-10">
                        <div style="white-space:nowrap;" >
                            <textarea id="empSel" type="text" style="height: 12%;" onclick="empType()">${message.empIdShow}</textarea>
                        </div>
                        <div id="empContent" class="empContent" style="width: 95%">
                            <ul id="empTree" class="ztree" ></ul>
                        </div>
                        <input id="empId" type = "hidden" placeholder="最多发送80人" value="${message.empId}"/>
                    </div>
                </div>
                <%--<div class="form-row" style="display: none">
                    <div class="col-md-2 tar">
                        接收学生
                    </div>
                    <div class="col-md-10">
                        <div style="white-space:nowrap;" >
                            <textarea id="stuSel" type="text" style="height: 12%;" onclick="StuType()"/>${message.stuId}
                        </div>
                        <div id="stuContent" class="stuContent" style="width: 95%">
                            <ul id="stuTree" class="ztree" ></ul>
                        </div>
                        <input id="stuId" type = "hidden"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        接收家长<br>(以班级为单位)
                    </div>
                    <div class="col-md-10">
                        <div style="white-space:nowrap;" >
                            <textarea id="parSel" type="text" style="height: 12%;" onclick="ParType()">${message.parIdShow}</textarea>
                        </div>
                        <div id="parContent" class="parContent" style="width: 95%">
                            <ul id="parTree" class="ztree" ></ul>
                        </div>
                        <input id="parId" type = "hidden" value="${message.parId}"/>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        内容
                    </div>
                    <div class="col-md-10 tar">
                        <textarea name="content" id="content" cols="30" rows="10" maxlength="330" placeholder="最多输入330个字">${message.content}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveMessage()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="m_id" hidden value="${message.id}">
<input id="workflag" hidden value="${workflag}">
<input id="isDean" hidden value="${isDean}">
<script>

    console.error($("#isDean").val());
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var classTreeDate ;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TZLX", function (data) {
            addOption(data, "type","${message.type}");
        })

        $.get("<%=request.getContextPath()%>/student/getMajorClassTree", function (data) {
            classTreeDate = data;
        })

        /*empType();
         deptType();*/
    })

    function deptType() {
        //部门多选树，初始化
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var deptTree = $.fn.zTree.init($("#deptTree"), settingDept, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            if(lis!="")
                for(var i = 0;i< lis.length;i++){
                    node = deptTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#"+lis[i]).attr("checked");
                    deptTree.checkNode(node, true, false, callbackFlag);
                }
        });
        showMenuDept();
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

    function StuType() {
        //学生多选树，初始化
        var stuTree = $.fn.zTree.init($("#stuTree"), settingStu, classTreeDate);
        var node;
        var lis = $("#stuId").val().split(",");
        //设置选择节点
        if(lis!="")
            for(var i = 0;i< lis.length;i++){
                node = stuTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                stuTree.checkNode(node, true, false, callbackFlag);
            }
        showMenuStu();
    }

    function ParType() {
        //家长多选树，初始化
        var parTree = $.fn.zTree.init($("#parTree"), settingPar, classTreeDate);
        var node;
        var lis = $("#parId").val().split(",");
        //设置选择节点
        if(lis!="")
            for(var i = 0;i< lis.length;i++){
                node = parTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                parTree.checkNode(node, true, false, callbackFlag);
            }
        showMenuPar();
    }

    function saveMessage() {
        var title = $("#title").val();
        var range=$("#range option:selected").val();
        var type = $("#type option:selected").val();
        var content = $("#content").val();
        var dept=$("#deptId").val();
        var emp=$("#empId").val();
        var stuId=$("#stuId").val();
        var parId=$("#parId").val();
        var isDean = $("#isDean").val();
        /*alert(emp.length)*/
        if (!title == '' || !title == undefined || !title == null) {
            if (title.indexOf(" ") !=-1 || title.indexOf("/")!=-1 || title.indexOf("@")!=-1){
                swal({title: "标题中不可包含特殊符号。例如[空格]、[/]、[@]等！",type: "info" });
                return;
            }
            if(title.length>100)
            {
                swal({title: "标题内容不可超过30字",type: "info"});
            }
        }else{
            swal({ title: "请填写标题",type: "info"});
            return;
        }
        if ((dept == '' || dept == undefined || dept == null) && (emp == '' || emp == undefined || emp == null)) {
            swal({title: "请选择接收部门或者接收人员",type: "info" });
            return;
        }
       /* if ((dept == '' || dept == undefined || dept == null) && (emp == '' || emp == undefined || emp == null)
                && (stuId == '' || stuId == undefined || stuId == null)&& (parId == '' || parId == undefined || parId == null) ) {
            swal({title: "请选择接收部门或者接收人员或者接收学生或者接受家长！",type: "info" });
            return;
        }*/
        if(emp.length>3000){
            swal({title: "发送给个人数量，最多只能80人",type: "info" });
            return;
        }
        if (type == '' || type == undefined || type == null) {
            swal({title: "请选择类型",type: "info" });
            return;
        }
        if (content == '' || content == undefined || content == null) {
            swal({title: "请编辑内容",type: "info"});
            return;
        }
        $.post("<%=request.getContextPath()%>/saveMessage", {
            id: $("#m_id").val(),
            title: title,
            type: type,
            empId:emp,
            deptId:dept,
            content: content,
            workFlowFlag:$("#workflag").val(),
            isDean:isDean
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal("hide");
                messageTable.ajax.reload();
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
    var settingDept = {
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
            beforeClick: beforeClickDept,
            onCheck: onCheckDept
        }
    };

    function beforeClickDept(treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("deptTree");
        zTree.checkNode(treeNode2, !treeNode2.checked, null, true);
        return false;
    }

    function onCheckDept(e, treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("deptTree");
        var nodes = zTree.getCheckedNodes(true);
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var dId = $("#deptId");
        dId.attr("value", v);
    }

    function showMenuDept() {
        var cityObj = $("#deptId");
        var cityOffset = $("#deptId").offset();
        $("#deptContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDownDept);
    }
    function hideMenuDept() {
        $("#deptContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownDept);
    }
    function onBodyDownDept(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "deptSel" || event.target.id == "deptContent" || $(event.target).parents("#deptContent").length>0)) {
            hideMenuDept();
            var zTree = $.fn.zTree.getZTreeObj("deptTree");
            var nodes = zTree.getCheckedNodes(true);
            $("#deptId").val(getChildNodes(nodes));//获取子节点
            $("#deptSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }
</script>
<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var settingStu = {
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
            beforeClick: beforeClickStu,
            onCheck: onCheckStu
        }
    };

    function beforeClickStu(treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("stuTree");
        zTree.checkNode(treeNode2, !treeNode2.checked, null, true);
        return false;
    }

    function onCheckStu(e, treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("stuTree");
        var nodes = zTree.getCheckedNodes(true);
        v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var dId = $("#stuId");
        dId.attr("value", v);
    }

    function showMenuStu() {
        var cityObj = $("#stuId");
        var cityOffset = $("#stuId").offset();
        $("#stuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDownStu);
    }

    function hideMenuStu() {
        $("#stuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownStu);
    }

    function onBodyDownStu(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "stuSel" ||
            event.target.id == "stuContent" || $(event.target).parents("#stuContent").length>0)) {
            hideMenuStu();
            var zTree = $.fn.zTree.getZTreeObj("stuTree");
            var nodes = zTree.getCheckedNodes(true);
            $("#stuId").val(getChildNodes(nodes));//获取子节点
            $("#stuSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }
</script>
<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var settingPar = {
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
            beforeClick: beforeClickPar,
            onCheck: onCheckPar
        }
    };

    function beforeClickPar(treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("parTree");
        zTree.checkNode(treeNode2, !treeNode2.checked, null, true);
        return false;
    }

    function onCheckPar(e, treeId, treeNode2) {
        var zTree = $.fn.zTree.getZTreeObj("parTree");
        var nodes = zTree.getCheckedNodes(true);
        v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var dId = $("#parId");
        dId.attr("value", v);
    }

    function showMenuPar() {
        var cityObj = $("#parId");
        var cityOffset = $("#parId").offset();
        $("#parContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDownPar);
    }

    function hideMenuPar() {
        $("#parContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownPar);
    }

    function onBodyDownPar(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "parSel" ||
            event.target.id == "parContent" || $(event.target).parents("#parContent").length>0)) {
            hideMenuPar();
            var zTree = $.fn.zTree.getZTreeObj("parTree");
            var nodes = zTree.getCheckedNodes(true);
            $("#parId").val(getChildNodes(nodes));//获取子节点
            $("#parSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }
</script>
<style>
    #deptContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
    #empContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
    #stuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
    #parContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>