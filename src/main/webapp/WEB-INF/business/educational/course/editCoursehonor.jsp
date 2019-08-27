<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="coursehonorid" hidden value="${coursehonor.courseHonorId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="f_courseName" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        负责人
                    </div>
                    <div class="col-md-9">
                        <input id="person" type="text" value="${coursehonor.personIdShow}"/>
                        <input id="perId" type="hidden" value="${coursehonor.chargeMan}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        成员
                        <div  id="menuContentMake" class="menuContentMake">
                            <ul id="makeTree" class="ztree" checked></ul>
                        </div>
                    </div>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_honorMember" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"--%>
                               <%--maxlength="10" placeholder="最多输入10个字"--%>
                               <%--class="validate[required,maxSize[20]] form-control"--%>
                               <%--value="${coursehonor.honorMember}" />--%>
                    <%--</div>--%>
                    <div class="col-md-9">
                        <input id="makeClassName" value="${coursehonor.honorMemberShow}" style="height: 12%;"
                               onclick="showMenuMake()"/>
                            <input id="honorMember" hidden placeholder="最多选择80人" autocomplete="off"
                                   value="${coursehonor.honorMember}"/>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    var hiddenInputMake = "honorMember";
    var nameShowMake = "makeClassName";
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
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            makeClassTree = $.fn.zTree.init($("#makeTree"), selectTreeMakeSetting, data);
            //根据或取到的honorMember进行初始化
            var classIds = '${coursehonor.honorMember}';
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = makeClassTree.getNodeByParam("id", classId[i]);
                    makeClassTree.checkNode(node, true, false);
                }
            }
        })


        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DJ", function (data) {
            addOption(data, 'f_honorLevel','${coursehonor.honorLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=RYMC", function (data) {
            addOption(data, 'f_honorName', '${coursehonor.honorName}');
        });
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_courseName','${coursehonor.courseName}');
        });
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_courseName").val() == "" || $("#f_courseName").val() == "0" || $("#f_courseName").val() == undefined) {
            swal({
                title: "请选择课程名称！",
                type: "info"
            });
            return;
        }

        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null) {
            swal({
                title: "请点选负责人!",
                type: "info"
            });
            return;
        }
        if( $("#honorMember").val() == "" || $("#honorMember").val() == "0" || $("#honorMember").val() == undefined){
            swal({
                title: "请填写成员！",
                type: "info"
            });
            return;
        }
        if($("#person").attr("keycode")=="" || $("#person").attr("keycode") ==null){
            $("#person").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/coursehonor/saveCoursehonor", {
            courseHonorId: $("#coursehonorid").val(),
            courseName: $("#f_courseName").val(),
            chargeMan: $("#person").attr("keycode"),
            honorMember: $("#honorMember").val(),

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#coursehonor').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function beforeClickMake(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree"),
            nodes = zTree.getCheckedNodes(true),
            v = ""; //节点名称
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var deptId = $("#vehicle");
        deptId.attr("value", v);
    }

    function onCheckMake(e, treeId, treeNode) {
        var nodes = $.fn.zTree.getZTreeObj(selectTreeIdMake).getCheckedNodes(true);
        $("#" + nameShowMake).val(getChildNodesSel(nodes));//获取子节点
        $("#" + hiddenInputMake).val(getChildNodes(nodes));//获取子节点
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
    function hideMenuMake() {
        $("#menuContentMake").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownMake);
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
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            if (undefined == treeNode[i].children){
                 nodes.push(treeNode[i].name);
            }
        }
        return nodes.join(",");
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            if (undefined == treeNode[i].children) {
                nodes.push(treeNode[i].id);
            }
        }
        return nodes.join(",");
    }

</script>

<style type="text/css">
    textarea {
        resize: none;
    }

    #menuContentMake {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 0px !important;
        background: #ffffff;
        z-index: 9999999;
    }
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }


    element.style {
        left: 953.5px;
        top: 0px;
        display: block;
    }
    .modal-dialog {
        left: 50%;
        right: auto;
        width: 700px;
        padding-top: 30px;
        padding-bottom: 30px;
    }
</style>