<%--资产报废管理申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span style="font-size: 14px">${head}</span>
            <input id="f_Id" name="f_Id" type="hidden" value="${slowExamination.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${slowExamination.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        班级
                    </div>
                    <div class="col-md-9">
                        <input id="f_classId" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${slowExamination.classId}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        姓名
                    </div>
                    <div class="col-md-9">
                        <input id="f_manager" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${slowExamination.manager}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="d_semester" class="validate[required,maxSize[100]] form-control" disabled></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        缓考科目
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="cartypeShow" type="text" placeholder="请点击选择"
                                   onclick="showMenu()"  value="${businessCar.carTypeShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="cartypeTree" class="ztree"></ul>
                        </div>
                        <input id="cartype" type="hidden" value="${businessCar.carType}"/>
                        <%--<select id="f_course" class="js-example-basic-single"></select>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        缓考原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.reason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${slowExamination.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">
                保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭
            </button>
        </div>
    </div>
</div>
<input id="majorCode" type="hidden" value="${slowExamination.majorId}">
<input id="courseId" type="hidden" value="${slowExamination.courseId}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var majorCode=$("#majorCode").val();
        $.get("<%=request.getContextPath()%>/slowExamination/getCourseSelect",
            {
                requestDept:$("#f_requestDept").val()
            }
            , function (data) {
            var cartypeTree = $.fn.zTree.init($("#cartypeTree"), setting, data);
            var node;
            var lis = $("#cartype").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = cartypeTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                cartypeTree.checkNode(node, true, false, callbackFlag);
            }

        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, "d_semester", '${slowExamination.termId}');
        });
    })

    function saveDept() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写缓考原因!",
                type: "info"
            });
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写申请时间!",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        $.post("<%=request.getContextPath()%>/slowExamination/saveSlowExamination", {
            id: $("#f_Id").val(),
            courseId: $("#cartype").val(),
            reason: $("#f_reason").val(),
            remark: $("#f_remark").val(),
            requestDate: date
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
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
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#cartype");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#cartype");
    var cityOffset = $("#cartype").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "cartypeTreeShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#cartype").val(getChildNodes(nodes));//获取子节点
        $("#cartypeShow").val(getChildNodesSel(nodes));//获取子节点
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
