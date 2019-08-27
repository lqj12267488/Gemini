<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="planId" name="planId" hidden value="${payment.planId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 缴费计划名称
                    </div>
                    <div class="col-md-9">
                        <input id="planName" value="${payment.planName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  缴费项目
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="planItemShow" type="text" onclick="showMenu()"  value="${payment.planItemShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="deviceNameTree" class="ztree"></ul>
                        </div>
                        <input id="usedevice" type="hidden" value="${payment.planItem}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 年份
                    </div>
                    <div class="col-md-9">
                        <select id="year" />
                    </div>
                </div>
                <div  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  学期
                    </div>
                    <div class="col-md-9">
                        <select id="term" />
                    </div>
                </div>
                <div  id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" value="${payment.startTime}" type="date" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="coursePproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" value="${payment.endTime}" type="date" class="validate[required,maxSize[100]] form-control"/>
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
    var zTree;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=JFXM", function (data) {
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term','${payment.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year','${payment.year}');
        });
    });

    function save() {
        var planName = $("#planName").val();
        var term = $("#term").val();
        var year = $("#year").val();
        var planItem = $("#usedevice").val();
        var startVal = $("#startTime").val();
        var endVal = $("#endTime").val();
        var startTime =new Date(startVal).getTime();
        var endTime= new Date(endVal).getTime();
        if (planName == "" || planName == undefined || planName == null) {
            swal({
                title: "请填写缴费计划名称！",
                type: "info"
            });
            return;
        }
        if (planItem == "" || planItem == undefined || planItem == null) {
            swal({
                title: "请选择缴费项目！",
                type: "info"
            });
            return;
        }
        if (year == "" || year == undefined || year == null) {
            swal({
                title: "请选择年份！",
                type: "info"
            });
            return;
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if(startVal=="" || startVal == undefined || startVal == null){
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if(endVal=="" || endVal == undefined || endVal == null){
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }
        if(startTime>endTime){
            swal({
                title: "开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/payment/plan/save", {
            planId: $("#planId").val(),
            planName:planName,
            year:year,
            term:term,
            planItem:planItem,
            startTime:startVal,
            endTime:endVal,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#costPlanTable').DataTable().ajax.reload();
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
         zTree = $.fn.zTree.getZTreeObj("deviceNameTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
        }

        function onCheck(e, treeId, treeNode) {
         zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].id + ",";
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
        if (!(event.target.id == "planItemShow" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
         zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
        nodes = zTree.getCheckedNodes(true);
        $("#usedevice").val(getChildNodes(nodes));//获取子节点
        $("#planItemShow").val(getChildNodesSel(nodes));//获取子节点
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
