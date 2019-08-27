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
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        快捷菜单1
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="menuShowOne" type="text" onclick="showTree('One')" />
                        </div>
                        <div id="menuContentOne" class="menuContent" style="display:none;">
                            <div class="col-md-9">
                                <ul id="menuTreeOne" class="ztree"></ul>
                            </div>
                            <div class="col-md-3 tar">
                                <a style="color: white;  line-height:25px;   " href="#" onclick="hideTree()">关闭</a>
                            </div>
                        </div>
                        <input id="menuIdOne" type="hidden" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        快捷菜单2
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="menuShowTwo" type="text" onclick="showTree('Two')" />
                        </div>
                        <div id="menuContentTwo" class="menuContent" style="display:none;">
                            <div class="form-row">
                                <div class="col-md-9">
                                    <ul id="menuTreeTwo" class="ztree"></ul>
                                </div>
                                <div class="col-md-3 tar">
                                    <a style="color: white;  line-height:25px;   " href="#" onclick="hideTree()">关闭</a>
                                </div>
                            </div>
                        </div>
                        <input id="menuIdTwo" type="hidden" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        快捷菜单3
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="menuShowThree" type="text" onclick="showTree('Three')" />
                        </div>
                        <div id="menuContentThree" class="menuContent" style="display:none;">
                            <div class="col-md-9">
                                <ul id="menuTreeThree" class="ztree"></ul>
                            </div>
                            <div class="col-md-3 tar">
                                <a style="color: white;  line-height:25px;   " href="#" onclick="hideTree()">关闭</a>
                            </div>
                        </div>
                        <input id="menuIdThree" type="hidden" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input hidden id="userId" value="${userId}">
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>

<script>
    var zTree ;
    var zTreeTwo ;
    var zTreeThree ;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/quickmenu/getQuickmenuTree?userId=${userId}", function (data) {
            var mentTreeCheck = data.data;
            var node;
            zTree = $.fn.zTree.init($("#menuTreeOne"), setting, data.menuTree);
            zTree.expandAll(true);
            if(mentTreeCheck.length>=1){
                $("#menuIdOne").val(mentTreeCheck[0].resourceId);//获取子节点
                $("#menuShowOne").val(mentTreeCheck[0].resourceName);//获取子节点
            }
            zTreeTwo = $.fn.zTree.init($("#menuTreeTwo"), setting, data.menuTree);
            zTreeTwo.expandAll(true);
            if(mentTreeCheck.length>=2){
                $("#menuIdTwo").val(mentTreeCheck[1].resourceId);//获取子节点
                $("#menuShowTwo").val(mentTreeCheck[1].resourceName);//获取子节点
            }
            zTreeThree = $.fn.zTree.init($("#menuTreeThree"), setting, data.menuTree);
            zTreeThree.expandAll(true);
            if(mentTreeCheck.length>=3){
                $("#menuIdThree").val(mentTreeCheck[2].resourceId);//获取子节点
                $("#menuShowThree").val(mentTreeCheck[2].resourceName);//获取子节点
            }

        })
    });

    var menutype = "";
    function showTree(t) {
        menutype = t;
        var cityObj = $("#menuId"+menutype);
        var cityOffset = $("#menuId"+menutype).offset();
        $("#menuContent"+menutype).css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
//        $("body").bind("mousedown", hideTree);
    }

    function hideTree() {
        $("#menuContentOne").fadeOut("fast");
        $("#menuContentTwo").fadeOut("fast");
        $("#menuContentThree").fadeOut("fast");
//        $("body").unbind("mousedown", hideTree);
    }

    function clickCheck(e, treeId, treeNode) {
        var childrenNodes = treeNode.children;
        if (childrenNodes == undefined ){
            $("#menuId"+menutype).val(treeNode.id);//获取子节点
            $("#menuShow"+menutype).val(treeNode.name);//获取子节点
            hideTree();
        }else{

        }
    }

    function save() {
        var userId = $("#userId").val();
        var mentuValue = '';
        if($("#menuIdOne").val()!=null && $("#menuIdOne").val()!= '' ){
            mentuValue = $("#menuIdOne").val();
        }
        if($("#menuIdTwo").val()!=null && $("#menuIdTwo").val()!= '' ){
            mentuValue = mentuValue+',' + $("#menuIdTwo").val();
        }
        if($("#menuIdThree").val()!=null && $("#menuIdThree").val()!= '' ){
            mentuValue =  mentuValue+',' + $("#menuIdThree").val();
        }

        $.post("<%=request.getContextPath()%>/quickmenu/saveQuickmenu", {
            userId:userId,
            mentuValue:mentuValue,
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }

    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: clickCheck
        }
    };


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
