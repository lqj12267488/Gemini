<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${textBookDeclare.id}">
            <input id="textbook" hidden value="${textBookDeclare.textbookId}">
            <input id="personType" hidden value="${textBookDeclare.personType}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>所属学院
                    </div>
                    <div class="col-md-9">
                        <select id="college" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsIdSel" onchange="changeMajor1()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorCodeSel" onchange="changeClass();changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级
                    </div>
                    <div class="col-md-9">
                        <select id="classIdSel" onchange="getTrainingLevel()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年级
                    </div>
                    <div class="col-md-9">
                        <input id="gradeId" type="text"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.gradeId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培养层次
                    </div>
                    <div class="col-md-9">
                        <select id="trainingLevel" disabled></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="courseId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教材名称
                    </div>
                    <div class="col-md-9">
                        <input id="textbookId" type="text"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.textbookName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>预定数量
                    </div>
                    <div class="col-md-9">
                        <input id="declareNum" type="text"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.declareNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        单价
                    </div>
                    <div class="col-md-9">
                        <input id="unitPrice" type="text" readonly="readonly"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.unitPrice}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        主编
                    </div>
                    <div class="col-md-9">
                        <input id="s_editor" type="text" readonly="readonly" value="${textBookDeclare.editor}"
                               class="validate[required,maxSize[8]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        版本
                    </div>
                    <div class="col-md-9">
                        <input id="s_edition" type="text" readonly="readonly" value="${textBookDeclare.edition}"
                               class="validate[required,maxSize[8]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>圈订人
                    </div>
                    <div class="col-md-9">
                        <input id="boundPerson" type="text"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.boundPerson}"/>
                    </div>
                </div>
                <c:if test="${textBookDeclare.personType == 1}">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            教材使用者（可填多人）
                        </div>
                        <div class="col-md-9">
                            <div style="white-space:nowrap;">
                                <textarea id="empSel" type="text" style="height: 12%;"
                                          onclick="empType()">${textBookDeclare.textbookUserShow}</textarea>
                            </div>
                            <div id="empContent" class="empContent" style="width: 95%">
                                <ul id="empTree" class="ztree"></ul>
                            </div>
                            <input id="textbookUser" type="hidden" placeholder="最多发送80人"
                                   value="${textBookDeclare.textbookUser}"/>
                        </div>
                    </div>
                </c:if>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark">${textBookDeclare.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTextBookPlan()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    var personType = $("#personType").val();
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var zTree;

    $("#textbookId").change(function () {
        if ($("#textbookId").val() != "") {
            $.get("<%=request.getContextPath()%>/textbook/getUnitPriceByTextbookId?textbookId=" + $("#textbookId").attr("keycode"),
                function (data) {
                    if (data != null) {
                        console.log(data);
                        console.log(data.price);
                        console.log(data.editor);
                        console.log(data.edition);
                        $("#unitPrice").val(data.price);
                        $("#s_editor").val(data.editor);
                        $("#s_edition").val(data.edition);
                    }
                })
        }
    })


    var hiddenInputMake = "textbookUser";
    var nameShowMake = "makeClassName";
    var makeClassTree;
    var selectTreeIdMake = "makeTree";
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            makeClassTree = $.fn.zTree.init($("#makeTree"), selectTreeMakeSetting, data);
            var classIds = '${textBookDeclare.textbookUser}';
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = makeClassTree.getNodeByParam("id", classId[i]);
                    makeClassTree.checkNode(node, true, false);
                }
            }
        })

        // alert(personType)
        //学院类型 majorSchool
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XY", function (data) {
            addOption(data, 'college', '${textBookDeclare.college}');
        });
        // var r = $("#personType").val();
        // alert(r)
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: "dept_id",
            text: "dept_name",
            tableName: "T_SYS_DEPT",
            where: "WHERE dept_type = 8 ",
            orderBy: ""
        }, function (data) {
            addOption(data, 'departmentsIdSel', '${textBookDeclare.departmentsId}');
        });
        if ('${textBookDeclare.majorId}' != "") {
            var deptId = '${textBookDeclare.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCodeSel', '${textBookDeclare.majorId},${textBookDeclare.trainingLevel}');
            });
        } else {
            $("#majorCodeSel").append("<option value='' selected>请选择</option>")
        }

        if ('${textBookDeclare.majorId}' != "") {
            var majorCode = '${textBookDeclare.majorId}';
            var trainingLevel = '${textBookDeclare.trainingLevel}';
            <%--var majorDirection = '${data.majorDirection}';--%>
            $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + majorCode + "&trainingLevel=" +
                trainingLevel, function (data) {
                addOption(data, 'classIdSel', '${textBookDeclare.classId}');
            });
        } else {
            $("#classIdSel").append("<option value='' selected>请选择</option>")
        }
        if ($("#personType").val() == "1") {
            $("#roomProperty").hide();
        }
        $.get("<%=request.getContextPath()%>/common/getTableToTree", {
                id: "CLASS_ID",
                text: "CLASS_NAME",
                tableName: "T_XG_CLASS ",
                where: " WHERE MAJOR_CODE= '${textBookDeclare.majorId}'",
            },
            function (data) {
                zTree = $.fn.zTree.init($("#classTree"), setting, data);
                //多选下拉表选回显选中状态
                var node;
                var lis = $("#classId").val().split(",");
                for (var i = 0; i < lis.length; i++) {
                    node = zTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    zTree.checkNode(node, true, false, callbackFlag);
                }
            });
        var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
        if ($("#majorCodeSel option:selected").val() != "") {
            course_sql += " and major_code ='" + '${textBookDeclare.majorId}' + "' and training_level='" + '${textBookDeclare.trainingLevel}' + "' ";
        }
        course_sql += ")";
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: course_sql,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseId");
            })

        if ("" != '${textBookDeclare.courseId}') {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "course_id",
                text: "course_name",
                tableName: "T_JW_COURSE",
                where: " ",
                orderBy: ""
            }, function (data) {
                addOption(data, 'courseId', '${textBookDeclare.courseId}');
            });
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'trainingLevel', '${textBookDeclare.trainingLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getTextBook", function (data) {
            $("#textbookId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#textbookId").val(ui.item.label);
                    $("#textbookId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    });

    function getTrainingLevel() {
        var classId = $("#classIdSel").val();
        $.post("<%=request.getContextPath()%>/studentGrants/getTrainingLevelByClassId", {
            classId: classId
        }, function (data) {
            $("#trainingLevel").val(data.storeValue);
        })
    }


    function changeMajor1() {
        var deptId = $("#departmentsIdSel").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSel');
        });
    }

    function changeClass() {
        var majorCode = $("#majorCodeSel").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 'classIdSel');
        });
    }

    $("#textbookId").change(function () {
        if ($("#textbookId").val() != "") {
            $.get("<%=request.getContextPath()%>/textbook/getUnitPriceByTextbookId?textbookId=" + $("#textbookId").attr("keycode"),
                function (String) {

                    $("#f_area").val(decodeURI(decodeURI(String)));
                })
        }
    });

    function changeMajor() {
        var majorId = $("#majorCodeSel option:selected").val();
        var majorCode = majorId.split(",")[0];
        var trainingLevel = majorId.split(",")[1];
        $("#trainingLevel").val(trainingLevel);
        // $("#className").val("");
        //专业联动课程
        var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1 and  COURSE_TYPE='1' \n" +
            "union all  select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
        if ($("#majorCodeSel option:selected").val() != "") {
            course_sql += " and major_code ='" + majorCode + "' and training_level='" + trainingLevel + "' ";
        }
        course_sql += ")";
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: course_sql,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseId");
            })
        $.get("<%=request.getContextPath()%>/common/getTableToTree", {
                id: "CLASS_ID",
                text: "CLASS_NAME",
                tableName: "T_XG_CLASS ",
                where: " WHERE MAJOR_CODE='" + majorCode + "'"
            },
            function (data) {
                zTree = $.fn.zTree.init($("#classTree"), setting, data);
                //多选下拉表选回显选中状态
                var node;
                var lis = $("#classId").val().split(",");
                for (var i = 0; i < lis.length; i++) {
                    node = zTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    zTree.checkNode(node, true, false, callbackFlag);
                }
            });
    }

    function empType() {
        //人员多选树，初始化
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            var empTree = $.fn.zTree.init($("#empTree"), settingEmp, data);
            var node;
            var lis = $("#textbookUser").val().split(",");
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

    function saveTextBookPlan() {
        var college = $("#college").val();
        var departmentsId = $("#departmentsIdSel").val();
        var gradeId = $("#gradeId").val();
        var boundPerson = $("#boundPerson").val();
        var reg = new RegExp("^[0-9]*$");
        var id = $("#id").val();
        var personType = $("#personType").val();
        var majorId = $("#majorCodeSel option:selected").val();
        var majorCode = majorId.split(",")[0];
        var trainingLevel = $("#trainingLevel").val();
        // var trainingLevel = majorId.split(",")[1];
        var classId = $("#classIdSel").val();
        var courseId = $("#courseId").val();
        var textbookId = $("#textbookId").val();
        var declareNum = $("#declareNum").val();
        var submitState = $("#submitState").val();
        var remark = $("#remark").val();
        var unitPrice = $("#unitPrice").val();
        var textbookUser = $("#textbookUser").val();
        if (college == "" || college == undefined || college == null) {
            swal({
                title: "请选择所属学院！",
                type: "info"
            });
            return;
        }
        if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (personType == "0") {
            if (classId == "" || classId == undefined || classId == null) {
                swal({
                    title: "请选择班级！",
                    type: "info"
                });
                0
                return;
            }
        }
        if (gradeId == "" || gradeId == undefined || gradeId == null) {
            swal({
                title: "请选择年级！",
                type: "info"
            });
            return;
        }
        if (trainingLevel == "" || trainingLevel == undefined || trainingLevel == null) {
            swal({
                title: "请选择培养层次！",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        var textbook;
        if (null == $("#id").val() || "" == $("#id").val()) {
            if ($("#textbookId").attr("keycode") == "" || $("#textbookId").attr("keycode") == null || $("#textbookId").attr("keycode") == undefined) {
                swal({
                    title: "请输入教材简写名称，在点选正确教材名称！",
                    type: "info"
                });
                $("#textbookId").val("");
                return;
            }
            if ($("#textbookId").attr("keycode") == "" || $("#textbookId").attr("keycode") == null || $("#textbookId").attr("keycode") == undefined) {
                textbook = $("#textbook").val();
            } else {
                textbook = $("#textbookId").attr("keycode");
            }

        } else {
            if (textbookId == "" || textbookId == undefined || textbookId == null) {
                swal({
                    title: "请输入教材简写名称，在点选正确教材名称！",
                    type: "info"
                });
                return;
            } else {
                if ($("#textbookId").attr("keycode") == "" || $("#textbookId").attr("keycode") == null || $("#textbookId").attr("keycode") == undefined) {
                    if($("#textbookId").val()=='${textBookDeclare.textbookName}'){
                        textbook = $("#textbook").val();
                    }else{
                        swal({
                            title: "请输入教材简写名称，在点选正确教材名称！",
                            type: "info"
                        });
                        $("#textbookId").val("");
                        return;
                    }
                } else {
                    textbook = $("#textbookId").attr("keycode");
                }
            }
        }

        if ($("#declareNum").val() == "" || $("#declareNum").val() == null) {
            swal({
                title: "请填写教材预定数量！",
                type: "info"
            });
            return;
        } else if (!reg.test($("#declareNum").val())) {
            swal({
                title: "教材申报数量必须为整数！",
                type: "info"
            });
            return;
        }
        if (boundPerson == "" || boundPerson == undefined || boundPerson == null) {
            swal({
                title: "请填写圈定人！",
                type: "info"
            });
            return;
        }
        var makeEmp = $("#textbookUser").val();
        var name1 = $("#textbookUser").val();
        if ('${textBookDeclare.personType}' == 1) {
            if (name1 == null || name1 == undefined || name1 == '') {
                swal({
                    title: "请选择圈定人！",
                    type: "error"
                });
                return;
            }
            if (makeEmp.length > 3000) {
                swal({title: "圈定人数量，最多只能选择80人以下", type: "info"});
                return;
            }
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveTextBookDeclare", {
            id: $("#id").val(),
            college: college,
            gradeId: gradeId,
            departmentsId: departmentsId,
            boundPerson: boundPerson,
            majorId: majorCode,
            trainingLevel: trainingLevel,
            classId: classId,
            courseId: $("#courseId").val(),
            textbookId: textbook,
            declareNum: $("#declareNum").val(),
            submitState: $("#submitState").val(),
            remark: $("#remark").val(),
            personType: personType,
            unitPrice: unitPrice,
            textbookUser: name1,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#textBookGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
<style type="text/css">
    textarea {
        resize: none;
    }

    #edui_fixedlayer {
        z-index: 1060 !important;
    }

    modal-dialog {
        width: 1000px !important;
    }

    .edui-default {
        color: black;
    }

    #empContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }

    #menuContentMake {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script type="text/javascript">//多选树z-tree.js数据格式 end
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
    var v = "";
    for (var i = 0, l = treeNode.length; i < l; i++) {
        v += treeNode[i].name + ",";
    }
    if (v.length > 0) v = v.substring(0, v.length - 1);
    $("#" + nameShowMake).attr("value", v);

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
        nodes[i] = treeNode[i].name;
    }
    return nodes.join(",");
}

function getChildNodes(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");
}

function getChildNodesSelEmp(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        if (treeNode[i].id.length == 36) {
            nodes[i] = treeNode[i].name;
        }else{
            nodes[i] = "";
        }
    }
    if (nodes.length == 0) {
        swal({
            title: "请选择人员！",
            type: "info"
        });
        return;
    } else {
        return nodes.join(",").substring(3,nodes.join(",").length);//回显教师姓名，把系部部门去掉
    }

}

function getChildNodesEmp(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");

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
        var textbookUser = $("#textbookUser");
        textbookUser.attr("value", v);
    }

    function showMenuEmp() {
        var cityObj = $("#textbookUser");
        var cityOffset = $("#textbookUser").offset();
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
            $("#textbookUser").val(getChildNodesEmp(nodes));//获取子节点
            $("#empSel").val(getChildNodesSelEmp(nodes));//获取子节点
        }
    }

</script>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
