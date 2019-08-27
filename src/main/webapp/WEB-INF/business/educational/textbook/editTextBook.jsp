<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="textbookId" hidden value="${textbook.textbookId}"/>
            <input id="type" hidden value="${type}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教材名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="textbookName" type="text" value="${textbook.textbookName}"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教材编号
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="textbookNumber" type="text"
                                   value="${textbook.textbookNumber}"/>
                        </div>
                    </div>
                </div>
                <div id="roomProperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教材性质
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="textbookNatureName" type="text" onclick="showTree()" value="${textbook.textbookNatureName}" readonly/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="textbookNatureTree" class="ztree"></ul>
                        </div>
                        <input id="textbookNature" type="hidden" value="${textbook.textbookNature}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教材类型
                    </div>
                    <div class="col-md-9">
                        <select id="textbookCategory"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第一主编单位
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="firstEditorCompany" type="text"
                                   value="${textbook.firstEditorCompany}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        出版社
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="publishingHouse" type="text"
                                   value="${textbook.publishingHouse}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        主编
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="editor" type="text" value="${textbook.editor}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版次
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="edition" type="text" value="${textbook.edition}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        单价(元)
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="price" type="text" value="${textbook.price}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        征订代号
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="subscribeCode" type="text" value="${textbook.subscribeCode}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版本日期
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="versionDate" type="date" value="${textbook.versionDate}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark">${textbook.remark}</textarea>
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
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableToTree", {
                id: "DIC_CODE",
                text: "DIC_NAME",
                tableName: "T_SYS_DIC ",
                where: " WHERE PARENT_ID= (SELECT id FROM T_SYS_DIC WHERE DIC_CODE= 'JCXZ' )",
            },
            function (data) {
                zTree = $.fn.zTree.init($("#textbookNatureTree"), setting, data);
                //多选下拉表选回显选中状态
                var node;
                var lis = $("#textbookNature").val().split(",");
                for (var i = 0; i < lis.length; i++) {
                    node = zTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    zTree.checkNode(node, true, false, callbackFlag);
                }
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JCLB", function (data) {
            addOption(data, 'textbookCategory', '${textbook.textbookCategory}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${textbook.departmentsId}');
        });
        if ('${textbook.majorCode}' != "") {
            var deptId = '${textbook.departmentsId}';
            $.get("<%=request.getContextPath()%>/textbook/getMajorByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorId', '${textbook.majorCode},${textbook.trainingLevel}');
            });
        } else {
            $("#majorId").append("<option value='' selected>请选择</option>")
        }

    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/textbook/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorId');
        });
    }
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


    function beforeClick(treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("textbookNatureTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("textbookNatureTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].id + ",";
        }

        if (v.length > 0) v = v.substring(0, v.length - 1);
        var roomVal = $("#textbookNature");
        roomVal.attr("value", v);
    }
    function showTree() {
        var roomObj = $("#textbookNature");
        var roomOffset = $("#textbookNature").offset();
        $("#menuContent").css({
            left: roomOffset.left + "px",
            top: roomOffset.top + roomObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "textbookNatureName" || $(event.target).parents("#menuContent").length > 0)) {
            hideTree();
            zTree = $.fn.zTree.getZTreeObj("textbookNatureTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#textbookNature").val(getChildNodes(nodes));//获取子节点
            $("#textbookNatureName").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
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
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }

    function save() {
        var textbookId = $("#textbookId").val();
        var textbookName = $("#textbookName").val();
        var textbookNumber = $("#textbookNumber").val();
        var textbookNature = $("#textbookNature").val();
        var textbookCategory = $("#textbookCategory").val();
        var firstEditorCompany = $("#firstEditorCompany").val();
        var publishingHouse = $("#publishingHouse").val();
        var editor = $("#editor").val();
        var edition = $("#edition").val();
        var price = $("#price").val();
        var remark = $("#remark").val();
        if (textbookName == "" || textbookName == undefined || textbookName == null) {
            swal({
                title: "请填写教材名称！",
                type: "info"
            });
            return;
        }
        /*if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请填写系部名称！",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请填写专业名称！",
                type: "info"
            });
            return;
        }*/
        if (isNaN(price)) {
            swal({
                title: "单价只能是数字！",
                type: "info"
            });
            return;
        }
        if(textbookId!=""){
            var textbookType='${textbook.textbookType}'
        }else{
            var textbookType = $("#type").val();
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveTextBook", {
            textbookId: textbookId,
            textbookName: textbookName,
            textbookNumber: textbookNumber,
            textbookNature: textbookNature,
            textbookType: textbookType,
            textbookCategory:textbookCategory,
            firstEditorCompany:firstEditorCompany,
            publishingHouse: publishingHouse,
            editor: editor,
            edition: edition,
            versionDate: $("#versionDate").val(),
            subscribeCode: $("#subscribeCode").val(),
            price: price,
            remark: remark,
        }, function (msg) {
            hideSaveLoading();
            if(msg.status==1){
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }else {
                swal({
                    title: msg.msg,
                    type: "error"
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }

        })
    }
</script>


<style>
    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
