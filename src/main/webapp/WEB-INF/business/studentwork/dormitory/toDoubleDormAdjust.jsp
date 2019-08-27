<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
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
                        <span class="iconBtx">*</span>  寝室名称
                    </div>
                    <div class="col-md-4">
                        <select id="firstDorm" class="js-example-basic-single" onchange="changeFirstMember()"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  入住人员
                    </div>
                    <div class="col-md-4">
                          <div style="white-space:nowrap;">
                            <input id="firstMemberShow" type="text" onclick="showFirstTree()" readonly/>
                        </div>
                        <div id="firstContent" class="firstContent">
                            <ul id="firstMemberTree" class="ztree"></ul>
                        </div>
                        <input id="firstMemberId" type="hidden"/>
                    </div>
                </div>
                <br>
                <br>
                <br>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   寝室名称
                    </div>
                    <div class="col-md-4">
                        <select id="secondDorm" class="js-example-basic-single"
                                onchange="changeSecondMember()"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  入住人员
                    </div>
                    <div class="col-md-4">
                        <div style="white-space:nowrap;">
                            <input id="secondMemberShow" type="text" onclick="showSecondTree()" />
                        </div>
                        <div id="secondContent" class="secondContent">
                            <ul id="secondMemberTree" class="ztree"></ul>
                        </div>
                        <input id="secondMemberId" type="hidden"/>
                    </div>

                </div>


            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="doubleAdjust()">两寝互调</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>


<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var zTree;
    $(document).ready(function () {
        //寝室1
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select id code,DORM_NAME  value from T_JW_DORM where 1 = 1  and valid_flag = 1 order by dorm_type)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "firstDorm");
            })

        //寝室2
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select id code,DORM_NAME  value from T_JW_DORM where 1 = 1  and valid_flag = 1 order by dorm_type)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "secondDorm");
            })
        var firstDorm = $("#firstDorm").val();
        var secondDorm = $("#secondDorm").val();
       /*if(firstDorm==null){
            setting1.check = "";
            data = [
                {
                    "id": "123456",
                    "name": "请选择寝室",
                    "checked": false,
                    "open": false,
                    "panrent": false
                }
            ]
            zTree = $.fn.zTree.init($("#firstMemberTree"), setting1, data);
        }
        if(secondDorm==null){
            setting2.check = "";
            data = [
                {
                    "id": "123456",
                    "name": "请选择寝室",
                    "checked": false,
                    "open": false,
                    "panrent": false
                }
            ]
            zTree = $.fn.zTree.init($("#secondMemberTree"), setting2, data);
        }
*/




    })


    function changeFirstMember() {
        $("#firstMemberShow").val('');
        $("#firstMemberId").val('');
        var firstDorm = $("#firstDorm").val();
        if (firstDorm != null) {
            $.get("<%=request.getContextPath()%>/common/getTableToTree", {
                    id: " t.student_id || '-' || c.class_id ",
                    text: " s.name ",
                    tableName: "T_XG_DORM_ADJUST_RESULT t,T_XG_STUDENT s, T_XG_STUDENT_CLASS r, T_XG_CLASS c",
                    where: " WHERE t.student_id=s.student_id and  r.student_id = s.student_id and r.class_id = c.class_id  and t.dorm_id = '" + firstDorm + "'"
                },
                function (data) {
                    if (data.length=="" || data.length==0) {
                        setting1.check = "";
                        data = [
                            {
                                "id": "123456",
                                "name": "暂无人员",
                                "checked": false,
                                "open": false,
                                "panrent": false
                            }
                        ]
                        zTree = $.fn.zTree.init($("#firstMemberTree"), setting1, data);
                    }else {
                        setting1.check = {
                            enable: true,
                                chkboxType: {"Y": "", "N": ""}
                        },
                        zTree = $.fn.zTree.init($("#firstMemberTree"), setting1, data);
                    }

                });

        }

    }
    function changeSecondMember() {
        $("#secondMemberShow").val('');
        $("#secondMemberId").val('');
        var secondDorm = $("#secondDorm").val();
        $.get("<%=request.getContextPath()%>/common/getTableToTree", {
                id: " t.student_id || '-' || c.class_id ",
                text: " s.name ",
                tableName: "T_XG_DORM_ADJUST_RESULT t,T_XG_STUDENT s, T_XG_STUDENT_CLASS r, T_XG_CLASS c",
                where: " WHERE t.student_id=s.student_id and  r.student_id = s.student_id and r.class_id = c.class_id  and t.dorm_id = '" + secondDorm + "'"
            },
            function (data) {
                if (data.length=="" || data.length==0) {
                    setting2.check = "";
                    data = [
                        {
                            "id": "123456",
                            "name": "暂无人员",
                            "checked": false,
                            "open": false,
                            "panrent": false
                        }
                    ]
                    zTree = $.fn.zTree.init($("#secondMemberTree"), setting2, data);
                }else {
                    setting2.check = {
                        enable: true,
                        chkboxType: {"Y": "", "N": ""}
                    },
                        zTree = $.fn.zTree.init($("#secondMemberTree"), setting2, data);
                }

            });

    }


    function doubleAdjust() {
        var firstDorm = $("#firstDorm option:selected").val();
        var secondDorm = $("#secondDorm option:selected").val()
        var firstMemberId = $("#firstMemberId").val();
        var secondMemberId = $("#secondMemberId").val();
        if (firstDorm == "") {
             swal({
                title: "请选择寝室！",
                type: "info"
            });
            return;
        }
        if (firstMemberId == "") {
             swal({
                title: "请选择要调寝的学生！",
                type: "info"
            });
            return;
        }
        if (secondDorm == "") {
             swal({
                title: "请选择寝室！",
                type: "info"
            });
            return;
        }

        if (secondMemberId == "") {
             swal({
                title: "请选择要调寝的学生！",
                type: "info"
            });
            return;
        }
        if (firstDorm == secondDorm) {
             swal({
                title: "寝室不能相同！",
                type: "info"
            });
            return;
        }
        $.get("<%=request.getContextPath()%>/dorm/checkDoubleDormAdjust?firstDorm=" + firstDorm + "&secondDorm=" + secondDorm + "&firstMemberId=" + firstMemberId + "&secondMemberId=" + secondMemberId, function (data) {
            if (data.status == 1 || data.status == 2 || data.status == 3) {
                swal({
                    title: data.msg,
                    type: "error"
                });
            } else {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/dorm/saveDoubleDormAdjust", {
                    firstDorm: firstDorm,
                    secondDorm: secondDorm,
                    firstMemberId: firstMemberId,
                    secondMemberId: secondMemberId

                }, function (data) {
                    hideSaveLoading();
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                        $("#dialog").modal('hide');
                        $('#adjustTable').DataTable().ajax.reload();

                })
            }

        })

    }

</script>
<style>
    #firstContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    #secondContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script>
    var setting1= {
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
            beforeClick: beforeClick1,
            onCheck: onCheck1
        }
    };
    function showFirstTree() {
        var firstMemberIdObj = $("#firstMemberId");
        var firstMemberIdOffset = $("#firstMemberId").offset();
        $("#firstContent").css({left: firstMemberIdOffset.left + "px", top: firstMemberIdOffset.top + firstMemberIdObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown1);

    }
    function hideMenu1() {
        $("#firstContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown1);
    }
    function onBodyDown1(event) {
        if (!(event.target.id == "firstMemberShow" || $(event.target).parents("#firstContent").length > 0)) {
            hideMenu1();
            var zTree = $.fn.zTree.getZTreeObj("firstMemberTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#firstMemberId").val(getChildNodes1(nodes));//获取子节点
            $("#firstMemberShow").val(getChildNodesSel1(nodes));//获取子节点
        }
    }
    function onCheck1(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("firstMemberTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var firstMemberId = $("#firstMemberId");
        firstMemberId.attr("value", v);
    }
    function beforeClick1(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("firstMemberTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodes1(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
    function getChildNodesSel1(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }


</script>

<script>
    var setting2 = {
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
            beforeClick: beforeClick2,
            onCheck: onCheck2
        }
    };
    function showSecondTree() {
        var secondObj = $("#secondMemberId");
        var secondOffset = $("#secondMemberId").offset();
        $("#secondContent").css({
            left: secondOffset.left + "px",
            top: secondOffset.top + secondObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown2);
    }
    function hideTree2() {
        $("#secondContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown2);
    }
    function onBodyDown2(event) {
        if (!(event.target.id == "secondMemberShow" || $(event.target).parents("#secondContent").length > 0)) {
            hideTree2();
            zTree = $.fn.zTree.getZTreeObj("secondMemberTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#secondMemberId").val(getChildNodes2(nodes));//获取子节点
            $("#secondMemberShow").val(getChildNodesSel2(nodes));//获取子节点
        }
    }
    function onCheck2(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("secondMemberTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].id + ",";
        }

        if (v.length > 0) v = v.substring(0, v.length - 1);
        var roomVal = $("#secondMemberId");
        roomVal.attr("value", v);
    }

    function beforeClick2(treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("secondMemberTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function getChildNodes2(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }

    function getChildNodesSel2(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }


</script>