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
            <input id="id" hidden value="${competitionRequest.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 竞赛名称：
                    </div>
                    <div class="col-md-9">
                        <input id="teacherInfoName" type="text" value="${competitionRequest.competitionNameShow}"/>
                        <input id="perId" type="hidden" value="${competitionRequest.competitionName}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        分赛项
                    </div>
                    <div class="col-md-9">
                        <input id="f_branchMatch" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.branchMatch}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="f_department" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="f_major"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        指导教师
                    </div>
                    <div class="col-md-9">
                        <input id="f_instructor" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.instructor}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        参赛性质
                    </div>
                    <div class="col-md-9" onchange="csxz()">
                        <select id="f_competitionNature"/>
                    </div>
                </div>
                <div class="form-row" id="oneStu" hidden>
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="stuId" value="${competitionRequest.studentName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="请输入学生姓名"/>
                        <input hidden id="stustu" value="${competitionRequest.studentId}"/>
                    </div>
                </div>
                <div class="form-row" id="allStu" hidden>
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学生姓名
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <textarea id="empSel" type="text" style="height: 12%;"
                                      onclick="empType()">${competitionRequest.studentName}</textarea>
                        </div>
                        <div id="empContent" class="empContent" style="width: 95%">
                            <ul id="empTree" class="ztree"></ul>
                        </div>
                        <input id="empId" type="hidden" placeholder="最多发送80人" value="${competitionRequest.studentId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        参赛时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_time" type="month"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.time}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        承办单位
                    </div>
                    <div class="col-md-9">
                        <input id="f_organizationUnit" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.organizationUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        发证机关
                    </div>
                    <div class="col-md-9">
                        <input id="sDept" type="text" value="${competitionRequest.sendDept}"/>
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
    var aa = "";
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/competition/competitionName", function (data) {
            $("#teacherInfoName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoName").val(ui.item.label);
                    $("#teacherInfoName").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: "dept_id",
            text: "dept_name",
            tableName: "T_SYS_DEPT",
            where: "WHERE dept_type = 8 ",
            orderBy: ""
        }, function (data) {
            addOption(data, 'f_department', '${competitionRequest.department}');
        });
        $("#f_department").change(function () {
            if ($("#f_department").val() != null) {
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "major_code",
                    text: "major_name",
                    tableName: "T_XG_MAJOR",
                    where: "WHERE departments_id = '" + $("#f_department").val() + "' ",
                    orderBy: ""
                }, function (data) {
                    addOption(data, 'f_major');
                });
            }
        })

        $.get("/common/getSysDict?name=CSXZ", function (data) {
            addOption(data, 'f_competitionNature', '${competitionRequest.competitionNature}');
        });
        if ("" != '${competitionRequest.major}') {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "major_code",
                    text: "major_name",
                    tableName: "T_XG_MAJOR",
                    where: "",
                    orderBy: ""
                }
                , function (data) {
                    addOption(data, 'f_major', '${competitionRequest.major}');
                });
        }
        /*学生自动完成框*/
        $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#stuId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#stuId").val(ui.item.label);
                    $("#stuId").attr("keycode", ui.item.value);
                    $("#studentId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        if ('${competitionRequest.competitionNature}' == 1) {
            $("#oneStu").show();
            $("#allStu").hide();
        } else {
            $("#allStu").show();
            $("#oneStu").hide();
        }

    })

    function csxz() {
        aa = $("#f_competitionNature").val();
        if (aa == 1) {
            $("#oneStu").show();
            $("#allStu").hide();
        } else {
            $("#allStu").show();
            $("#oneStu").hide();
        }
    }

    function empType() {
        //人员多选树，初始化
        $.get("<%=request.getContextPath()%>/competitionRequest/getStuTree", function (data) {
            var empTree = $.fn.zTree.init($("#empTree"), settingEmp, data);
            var node;
            var lis = $("#empId").val().split(",");
            // console.log(lis)
            //设置选择节点
            if (lis != "")
                for (var i = 0; i < lis.length; i++) {
                    node = empTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    empTree.checkNode(node, true, false, callbackFlag);
                }
        });
        showMenuEmp();
    }

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null) {
            swal({
                title: "请填写竞赛名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_branchMatch").val() == "" || $("#f_branchMatch").val() == "0") {
            swal({
                title: "请填写分赛项！",
                type: "info"
            });
            return;
        }
        if ($("#f_instructor").val() == "" || $("#f_instructor").val() == "0" || $("#f_instructor").val() == undefined) {
            swal({
                title: "请填写指导教师！",
                type: "info"
            });
            return;
        }
        if ($("#f_competitionNature").val() == "" || $("#f_competitionNature").val() == "0") {
            swal({
                title: "请选择参赛性质！",
                type: "info"
            });
            return;
        }
        var stuId = "";
        if ($("#id").val() == "" || $("#id").val() == null) {
            if ("1" == $("#f_competitionNature").val()) {
                if ($("#stuId").attr("keycode") == "" || $("#stuId").attr("keycode") == "0" || $("#stuId").attr("keycode") == undefined) {
                    swal({
                        title: "请选择学生！",
                        type: "info"
                    });
                    return;
                }
            } else {
                if ($("#empId").val() == "" || $("#empId").val() == undefined) {
                    swal({
                        title: "请选择学生！",
                        type: "info"
                    });
                    return;
                }
            }
        } else {
            if ("1" == $("#f_competitionNature").val()) {
                if ($("#stuId").val() == "" || $("#stuId").val() == "0" || $("#stuId").val() == undefined) {
                    swal({
                        title: "请选择学生！",
                        type: "info"
                    });
                    return;
                }else{
                    if($("#stuId").attr("keycode") == "" || $("#stuId").attr("keycode") == undefined){
                        if($("#stuId").val() == '${competitionRequest.studentName}'){
                            stuId = $("#stustu").val();
                        }else{
                            swal({
                                title: "请选择学生！",
                                type: "info"
                            });
                            $("#stuId").val("");
                            return;
                        }
                    }else{
                        stuId = $("#stuId").attr("keycode").split(",")[1];
                    }
                }

            } else {
                if ($("#empId").val() == "" || $("#empId").val() == undefined) {
                    swal({
                        title: "请选择学生！",
                        type: "info"
                    });
                    return;
                }
                stuId = $("#empId").val();
            }
        }


        if ($("#f_time").val() == "" || $("#f_time").val() == "0" || $("#f_time").val() == undefined) {
            swal({
                title: "请填写参赛时间！",
                type: "info"
            });
            return;
        }
        if ($("#f_organizationUnit").val() == "" || $("#f_organizationUnit").val() == "0" || $("#f_organizationUnit").val() == undefined) {
            swal({
                title: "请填写承办单位！",
                type: "info"
            });
            return;
        }
        if ($("#sDept").val() == "" || $("#sDept").val() == "0" || $("#sDept").val() == undefined) {
            swal({
                title: "请填写发证机关！",
                type: "info"
            });
            return;
        }
        if ($("#teacherInfoName").attr("keycode") == "" || $("#teacherInfoName").attr("keycode") == null) {
            $("#teacherInfoName").attr("keycode", $("#perId").val())
        }
        if ($("#id").val() == "" || $("#id").val() == null) {
            if (aa == 1) {
                stuId = $("#stuId").attr("keycode").split(",")[1];
            } else {
                stuId = $("#empId").val();
            }
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/competitionRequest/saveCompetitionRequest", {
            id: $("#id").val(),
            competitionName: $("#teacherInfoName").attr("keycode"),
            branchMatch: $("#f_branchMatch").val(),
            department: $("#f_department").val(),
            major: $("#f_major").val(),
            instructor: $("#f_instructor").val(),
            competitionNature: $("#f_competitionNature").val(),
            time: $("#f_time").val(),
            organizationUnit: $("#f_organizationUnit").val(),
            studentId: stuId,
            sendDept: $("#sDept").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#competitionRequest').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].level == 5) {
                // nodes[i] = treeNode[i].name;
                nodes += treeNode[i].name + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
        //return nodes.join(",");
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
                nodes += treeNode[i].id + ",";
        }
        return nodes.substring(0, nodes.length - 1);
        //return nodes.join(",");
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
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var empId = $("#empId");
        empId.attr("value", v);
    }

    function showMenuEmp() {
        var cityObj = $("#empId");
        var cityOffset = $("#empId").offset();
        $("#empContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDownEmp);
    }

    function hideMenuEmp() {
        $("#empContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownEmp);
    }

    function onBodyDownEmp(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "empSel" || event.target.id == "empContent" || $(event.target).parents("#empContent").length > 0)) {
            hideMenuEmp();
            var zTree = $.fn.zTree.getZTreeObj("empTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#empId").val(getChildNodes(nodes));//获取子节点
            $("#empSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }

</script>

<style>
    #edui_fixedlayer {
        z-index: 1060 !important;
    }

    modal-dialog {
        width: 1000px !important;
    }

    .edui-default {
        color: black;
    }

</style>
<style>
    #empContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>