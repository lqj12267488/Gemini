<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog">
    <input id="examId" name="examId" value="${array.examId}" hidden>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="arrayId" name="arrayId" hidden value="${array.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div id="roomProperty"  class="form-row">
                    <div class="col-md-3 tar">
                        教室
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="roomShow" type="text" onclick="showTree()" value="${array.roomName}"readonly/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="roomTree" class="ztree"></ul>
                        </div>
                        <input id="roomid" type="hidden" value="${array.roomId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        考试开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" value="${array.startTime}"   type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        考试结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" value="${array.endTime}" type="datetime-local"  class="validate[required,maxSize[100]] form-control"/>
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
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var zTree;
    $(document).ready(function () {
        var examId= $("#examId").val();
        $.get("<%=request.getContextPath()%>/common/getTableToTree",{
                id: " ROOM_ID",
                text: " ROOM_NAME ",
                tableName: "T_JW_EXAM_ROOM ",
                where: " WHERE VALID_FLAG = 1 and EXAM_ID = '"+examId+"'"
            },
            function (data) {
                zTree = $.fn.zTree.init($("#roomTree"), setting, data);
                var node;
                var lis = $("#roomid").val().split(",");
                for(var i = 0;i< lis.length;i++){
                    node = zTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#"+lis[i]).attr("checked");
                    zTree.checkNode(node, true, false, callbackFlag);
                }

            });

    });

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
        zTree = $.fn.zTree.getZTreeObj("roomTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("roomTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].id + ",";
        }

        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var roomVal = $("#roomid");
        roomVal.attr("value", v);
    }

    function showTree() {
        var roomObj = $("#roomid");
        var roomOffset = $("#roomid").offset();
        $("#menuContent").css({left:roomOffset.left + "px", top:roomOffset.top + roomObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "roomShow" || $(event.target).parents("#menuContent").length>0)) {
            hideTree();
            zTree = $.fn.zTree.getZTreeObj("roomTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#roomid").val(getChildNodes(nodes));//获取子节点
            $("#roomShow").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function hideTree() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }


    function save() {
        var startTimeVal = $("#startTime").val();
        var endTimeVal = $("#endTime").val();
        var roomid = $("#roomid").val();
        var reg = new RegExp("^[^,]*$");
        if(roomid=="" || roomid == undefined || roomid == null){
            swal({
                title: "请选择教室！",
                type: "info"
            });
            return;
        }else{
            if (!reg.test(roomid)) {
                swal({
                    title: "教室只能选择一个！",
                    type: "info"
                });
                return;
            }
        }
        if(startTimeVal=="" || startTimeVal == undefined || startTimeVal == null){
            swal({
                title: "请设置考试开始时间！",
                type: "info"
            });
            return;
        }
        if(endTimeVal=="" || endTimeVal == undefined || endTimeVal == null){
            swal({
                title: "请设置考试结束时间！",
                type: "info"
            });
            return;
        }
        if(startTime>endTime){
            swal({
                title: "考试开始时间不能晚于考试结束时间！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/array/save", {
            id:$("#arrayId").val(),
            startTime:$("#startTime").val().replace('T',''),
            endTime:$("#endTime").val().replace('T',''),
            roomId : roomid
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#teacherArray').DataTable().ajax.reload();
        })
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
