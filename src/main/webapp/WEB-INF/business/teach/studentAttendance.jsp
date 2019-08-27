<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script src="<%=request.getContextPath()%>/libs/js/jquery.qrcode.min.js"></script>
<div class="col-md-12">
    <div class="block block-drop-shadow">
        <div class="content controls">
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    课程
                </div>
                <div class="col-md-7">
                    <select id="courseId" onchange="courseChange()"></select>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    班级
                </div>
                <div class="col-md-7">
                    <input id="classId" onclick="showMenu()"  readonly>
                    <div id="menuContent" class="menuContent">
                        <ul id="tree" class="ztree"></ul>
                    </div>
                    <input id="classIds" type="hidden"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    课节
                </div>
                <div class="col-md-7">
                    <select id="courseTime"></select>
                </div>
            </div>
            <%--<div class="form-row">--%>
                <%--<div class="col-md-3 tar">--%>
                    <%--<span class="iconBtx">*</span>--%>
                    <%--专业--%>
                <%--</div>--%>
                <%--<div class="col-md-7">--%>
                    <%--<input id="majorName" onclick="showMajorMenu()" readonly>--%>
                    <%--<div id="menuMajorContent" class="menuContent">--%>
                        <%--<ul id="majorTree" class="ztree"></ul>--%>
                    <%--</div>--%>
                    <%--<input id="majorId" type="hidden"/>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="form-row">
                <div style="text-align: center">
                    <button id="saveBtn" class="btn btn-default btn-clean" onclick="make()">生成二维码</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal-draggable" id="qrcode" tabindex="999" role="dialog"
     aria-labelledby="adialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px" onclick="stop()">二维码</span>
            </div>
            <div class="modal-body clearfix">
                <div id="codeimg" align="center" style="height: 400px">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="stop()">关闭</button>
            </div>
        </div>
    </div>
</div>
<script>
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y": "", "N": ""}
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
    var majorSetting = {
        check: {
            enable: true,
            chkboxType: {"Y": "", "N": ""}
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
            beforeClick: beforeMajorClick,
            onCheck: onMajorCheck
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/teach/getCourseByPerson", function (data) {
            addOption(data, "courseId")
        });
        <%--$.get("<%=request.getContextPath()%>/teach/getClassByPerson", function (data) {--%>
            <%--$.fn.zTree.init($("#tree"), setting, data);--%>
        <%--});--%>
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ID ",
            text: " NAME ",
            tableName: "T_KQ_COURSE_TIME",
            where: "  ",
            orderby: " "
        }, function (data) {
            addOption(data, "courseTime")
        });
    });

    function beforeMajorClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("majorTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onMajorCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("majorTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#majorName").attr("value", v);
    }

    function showMajorMenu() {
        var cityObj = $("#majorName");
        var cityOffset = $("#majorName").offset();
        $("#menuMajorContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onMajorBodyDown);
    }

    function onMajorBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "majorName" || event.target.id == "menuMajorContent" || $(event.target).parents("#menuMajorContent").length > 0)) {
            hideMajorMenu();
            var zTree = $.fn.zTree.getZTreeObj("majorTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#majorId").val(getChildNodes(nodes));//获取子节点
            $("#majorName").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function hideMajorMenu() {
        $("#menuMajorContent").fadeOut("fast");
        $("body").unbind("mousedown", onMajorBodyDown);
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#classId").attr("value", v);
    }

    function showMenu() {
        var cityObj = $("#classId");
        var cityOffset = $("#classId").offset();
        $("#menuContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "classId" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("tree"),
                nodes = zTree.getCheckedNodes(true);
            $("#classIds").val(getChildNodes(nodes));//获取子节点
            $("#classId").val(getChildNodesSel(nodes));//获取子节点
            <%--$.post("<%=request.getContextPath()%>/teach/getMajorByClassIs", {--%>
                <%--ids: getChildNodes(nodes)--%>
            <%--}, function (data) {--%>
                <%--$.fn.zTree.init($("#majorTree"), majorSetting, data);--%>
            <%--});--%>
        }
    }

    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function getChildNodesSel(treeNode) {
        var nodes = [];
        for (var i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function getChildNodes(treeNode) {
        var nodes = [];
        for (var i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }

    function make() {
        var courseId = $("#courseId").val();
        var classIds = $("#classIds").val();
        var courseTime = $("#courseTime").val();
        // var major = $("#majorId").val();
        if ($("#courseId").val() == "" || $("#courseId").val() == null || $("#courseId").val() == undefined) {
            swal({
                title: "请选择课程!",
                type: "info"
            });
            return;
        }
        if ($("#classIds").val() == "" || $("#classIds").val() == null || $("#classIds").val() == undefined) {
            swal({
                title: "请选择班级!",
                type: "info"
            });
            return;
        }
        if ($("#courseTime").val() == "" || $("#courseTime").val() == null || $("#courseTime").val() == undefined) {
            swal({
                title: "请选择课节!",
                type: "info"
            });
            return;
        }
        // if (major == "") {
        //     major = null
        // }
        var data = {
            courseId: courseId,
            classId: classIds,
            courseTimeId: courseTime,
            // major: major
        };
        window.kqData = data;
        $.post("<%=request.getContextPath()%>/teach/saveTask", data, function (res) {
            if (res.status == 2) {
                swal({
                    title: "当前班级正在上课不能重复上课!",
                    type: "info"
                });
            } else {
                data["id"] = res.msg;
                if (res.status == 0) {
                    swal({
                        title: "当前任务已经存在直接展示二维码!",
                        type: "info"
                    });
                }
                qrcode();
                $("#qrcode").modal('show');
                $("#qrcode .modal-backdrop").remove();
                window.timeoutID = window.setInterval(function () {
                    qrcode()
                }, 5000);
            }
        });
    }

    function qrcode() {
        window.kqData["now"] = new Date().getTime();
        $("#codeimg").html("");
        $("#codeimg").qrcode({
            width: 400, //宽度
            height: 400, //高度
            text: JSON.stringify(window.kqData) //任意内容
        });
    }

    function stop() {
        window.clearInterval(timeoutID);
    }

    function courseChange(){
        var courseId = $("#courseId").val();
        $.get('/teach/getClassByPerson?courseId='+courseId,function (data) {
            // 初始化树
            $.fn.zTree.init($("#tree"), setting, data);
            showMenu();
        })
    }
</script>
