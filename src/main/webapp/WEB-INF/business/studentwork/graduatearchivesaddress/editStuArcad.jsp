<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/30
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>省：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadProvinceEdit" onchange="arcadProvinceChange()" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>市：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCityEdit"  onchange="arcadCityChange()"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>县区：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCountyEdit"  onchange="arcadCountyChange()" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>详细地址：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadDetailEdit" />
                    </div>
                </div>

                <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            学生姓名：
                            <div  id="menuContentMake" class="menuContentMake">
                                <ul id="makeTree" class="ztree" checked></ul>
                            </div>
                        </div>
                        <%--<div class="col-md-9">
                            <input type="textarea" id="makeClassName" style="height: 12%;"
                                   onclick="showMenuMake()" value="${stuArcadEdit.studentNames}"/>
                            <input id="honorMember" hidden placeholder="最多选择80人" autocomplete="off" />
                        </div>--%>
                        <div class="col-md-9">
                            <textarea type="textarea" id="makeClassName" onclick="showMenuMake()"
                                       style="height: 12%;">${stuArcadEdit.studentNames}</textarea>
                            <textarea id="honorMember" hidden placeholder="最多选择80人" autocomplete="off" />
                        </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var path = '<%=request.getContextPath()%>';
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
    $(function () {
        <%--获取省--%>
        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_province ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_province,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1'"
            },
            function (data) {
                addOption(data, "arcadProvinceEdit",'${stuArcadEdit.arcadProvince}');
            });

        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_city ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_city,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"'"
            },
            function (data) {
                addOption(data, "arcadCityEdit",'${stuArcadEdit.arcadCity}');
            });

        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_county ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_county,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"' and t.arcad_city= '"+'${stuArcadEdit.arcadCity}'+"'"
            },
            function (data) {
                addOption(data, "arcadCountyEdit",'${stuArcadEdit.arcadCounty}');
            });

            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " t.arcad_detail ",
                    text: " t.arcad_detail ",
                    tableName: "  T_XG_ARCHIVESADDR t ",
                    where: "  WHERE t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"' and t.arcad_city= '"+'${stuArcadEdit.arcadCity}'+"'and  t.arcad_county ='"+'${stuArcadEdit.arcadCounty}'+"' and t.valid_flag = '1'",
                },
                function (data) {
                    addOption(data, "arcadDetailEdit",'${stuArcadEdit.arcadDetail}');
                });

            if ('${editFlag}'=='1'){
                $("#arcadProvinceEdit").attr("disabled","disabled");
                $("#arcadCityEdit").attr("disabled","disabled");
                $("#arcadCountyEdit").attr("disabled","disabled");
                $("#arcadDetailEdit").attr("disabled","disabled");
             }

        $.get("<%=request.getContextPath()%>/competitionRequest/getStuTreeGrad", function (data) {
            makeClassTree = $.fn.zTree.init($("#makeTree"), selectTreeMakeSetting, data);
            //根据或取到的honorMember进行初始化
            var classIds = '${stuArcadEdit.studentIds}';
            $("#honorMember").val(classIds);
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = makeClassTree.getNodeByParam("id", classId[i]);
                    makeClassTree.checkNode(node, true, false);
                }
            }
        })


    })

    function arcadProvinceChange() {

        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_city ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_city,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+$("#arcadProvinceEdit").val()+"'"
            },
            function (data) {
                addOption(data, "arcadCityEdit",'${data.arcadCityEdit}');
            });
    }

    function arcadCityChange() {
        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_county ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_county,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+$("#arcadProvinceEdit").val()+"' and t.arcad_city= '"+$("#arcadCityEdit").val()+"'"
            },
            function (data) {
                addOption(data, "arcadCountyEdit",'${data.arcadCountyEdit}');
            });
    }
    function arcadCountyChange() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.arcad_detail ",
                text: " t.arcad_detail ",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where: "  WHERE t.arcad_province = '"+$("#arcadProvinceEdit").val()+"' and t.arcad_city= '"+$("#arcadCityEdit").val()+"'and  t.arcad_county ='"+$("#arcadCountyEdit").val()+"' and t.valid_flag = '1'",
            },
            function (data) {
                addOption(data, "arcadDetailEdit",'${data.arcadDetailEdit}');
            });
    }
    function save() {
        $.post("<%=request.getContextPath()%>/stuArcad/saveStuArcad", {
            arcadId:'${stuArcadEdit.arcadId}',
            arcadProvince: $("#arcadProvinceEdit").val(),
            arcadCity:$("#arcadCityEdit").val(),
            arcadCounty:$("#arcadCountyEdit").val(),
            arcadDetail:$("#arcadDetailEdit").val(),
            studentIds:$("#honorMember").val()
        },function (msg) {
            swal(
                {title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#stuArcadGrid').DataTable().ajax.reload();
        })
    }

    function beforeClickMake(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
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
