<%--申请编辑--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>计划名称
                    </div>
                    <div class="col-md-4">
                        <input id="planName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;
                                    " maxlength="30" placeholder="最多输入30个字"
                               value="${data.planName}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>系部名称
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" value="${data.departmentsId}" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 专业名称
                    </div>
                    <div class="col-md-4">
                        <select id="majorCode" onchange="change()"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-4">
                        <select id="courseId" value="${data.courseId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>课程类型
                    </div>
                    <div class="col-md-4">
                        <select id="courseType" value="${data.courseType}" onchange="changeCourseType()"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教材名称
                    </div>
                    <div class="col-md-4">
                        <select id="textbookId" value="${data.textbookId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>创建年份
                    </div>
                    <div class="col-md-4">
                        <select id="year" value="${data.year}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班级名称
                    </div>
                    <div class="col-md-4">
                        <input id="className" value="${data.className}" onclick="showMenu()"/>
                        <div id="menuContent" class="menuContent">
                            <ul id="tree" class="ztree"></ul>
                        </div>
                        <input id="classId" hidden value="${data.classId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学期
                    </div>
                    <div class="col-md-4">
                        <select id="fterm" value="${data.term}"/>
                    </div>
                </div>
                <%--    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 授课开始时间
                    </div>
                    <div class="col-md-4">
                        <input type="date" id="startTime" value="${data.startTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 授课结束时间
                    </div>
                    <div class="col-md-4">
                        <input type="date" id="endTime" value="${data.endTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>总学周
                    </div>
                    <div class="col-md-4">
                        <input id="totalWeeks" value="${data.totalWeeks}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 总学时
                    </div>
                    <div class="col-md-4">
                        <input id="totalHours" value="${data.totalHours}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 理论学周
                    </div>
                    <div class="col-md-4">
                        <input id="theoreticalWeeks" value="${data.theoreticalWeeks}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>实践教学学周
                    </div>
                    <div class="col-md-4">
                        <input id="practiceWeeks" value="${data.practiceWeeks}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 理论学时
                    </div>
                    <div class="col-md-4">
                        <input id="theoreticalHours" value="${data.theoreticalHours}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 实践教学学时
                    </div>
                    <div class="col-md-4">
                        <input id="practiceHours" value="${data.practiceHours}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 理论总学时
                    </div>
                    <div class="col-md-4">
                        <input id="totalTheoreticalHours" value="${data.totalTheoreticalHours}"/>
                    </div>

                    <div class="form-row">

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 实践教学总学时
                        </div>
                        <div class="col-md-4">
                            <input id="totalPracticeHours" value="${data.totalPracticeHours}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 理实结合学时
                        </div>
                        <div class="col-md-4">
                            <input id="theoryPracticeHours" value="${data.theoryPracticeHours}"/>
                        </div>
                    </div>--%>
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
<style type="text/css">
    textarea {
        resize: none;
    }

    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var hiddenInput = "classId";
    var selectTreeId = "tree";
    var nameShow = "className";
    var classTree;
    var selectTreeSetting = {
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
            beforeClick: beforeClick,
            onCheck: onCheck,
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${data.courseType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: "(select major_code || ',' || training_level code," +
                    "major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                    "from t_xg_major where 1=1  and DEPARTMENTS_ID ='" + deptId + "' and valid_flag = 1)",
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'majorCode', '${data.majorCode}' + ',' + '${data.trainingLevel}');
                })
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }
        if ('${data.courseId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " COURSE_ID ",
                    text: " COURSE_NAME ",
                    tableName: "T_JW_COURSE ",
                    where: " where 1=1  and MAJOR_CODE ='" + majorCode + "' ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'courseId', '${data.courseId}');
                })

        } else {
            $("#courseId").append("<option value='' selected>请选择</option>")
        }
        if ('${data.textbookId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " TEXTBOOK_ID ",
                    text: " TEXTBOOK_NAME ",
                    tableName: "T_JW_TEXTBOOK ",
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'textbookId', '${data.textbookId}');
                })
        } else {
            $("#textbookId").append("<option value='' selected>请选择</option>")
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data, 'fterm', '${data.term}');
        });
        $.get("<%=request.getContextPath()%>/student/getMajorClassTree", function (data) {
            classTree = $.fn.zTree.init($("#tree"), selectTreeSetting, data);
            var classIds = '${data.classId}';
            if (classIds != '') {
                var classId = classIds.split(",");
                for (var i = 0; i < classId.length; i++) {
                    var node = classTree.getNodeByParam("id", classId[i]);
                    classTree.checkNode(node, true, false);
                }
            }
        })

    });

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var v = "";
        for (var i = 0, l = treeNode.length; i < l; i++) {
            v += treeNode[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#" + nameShow).attr("value", v);
    }

    function showMenu() {
        var Obj = $("#" + nameShow);
        var Offset = $("#" + nameShow).offset();
        $("#menuContent").css({
            left: Offset.left + "px",
            top: Offset.top + Obj.outerHeight() + "px",
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == hiddenInput || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
            var nodes = $.fn.zTree.getZTreeObj(selectTreeId).getCheckedNodes(true);
            $("#" + hiddenInput).val(getChildNodes(nodes));//获取子节点
            $("#" + nameShow).val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 2) {
                nodes += treeNode[i].name + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 2) {
                nodes += treeNode[i].id + ",";
            }
        }
        if (nodes.length == 0) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        } else {
            return nodes.substring(0, nodes.length - 1);
        }
    }

    function save() {
        var id = $("#id").val();
        var planName = $("#planName").val();
        var departmentsId = $("#departmentsId option:selected").val();
        var majorCode = $("#majorCode option:selected").val();
        var trainingLevel = "";
        if (majorCode != "") {
            trainingLevel = majorCode.split(",")[1];
            majorCode = majorCode.split(",")[0];
        }
        var courseType = $("#courseType option:selected").val();
        var courseId = $("#courseId").val();
        var textbookId = $("#textbookId").val();
        var year = $("#year").val();
        var classId = $("#classId").val();
        var term = $("#fterm").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var totalWeeks = $("#totalWeeks").val();
        var totalHours = $("#totalHours").val();
        var theoreticalWeeks = $("#theoreticalWeeks").val();
        var theoreticalHours = $("#theoreticalHours").val();
        var totalTheoreticalHours = $("#totalTheoreticalHours").val();
        var practiceWeeks = $("#practiceWeeks").val();
        var practiceHours = $("#practiceHours").val();
        var totalPracticeHours = $("#totalPracticeHours").val();
        var theoryPracticeHours = $("#theoryPracticeHours").val();
        if (planName == "" || planName == undefined || planName == null) {
            swal({
                title: "请填写计划名称！",
                type: "info"
            });
            return;
        }
        if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请选择系部名称！",
                type: "info"
            });
            return;
        }
        if (majorCode == "" || majorCode == undefined || majorCode == null) {
            swal({
                title: "请选择专业名称！",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请选择课程名称！",
                type: "info"
            });
            return;
        }
        if (courseType == "" || courseType == undefined || courseType == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        }
        if (textbookId == "" || textbookId == undefined || textbookId == null) {
            swal({
                title: "请选择教材名称！",
                type: "info"
            });
            return;
        }
        if (year == "" || year == undefined || year == null) {
            swal({
                title: "请选择创建年份！",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级名称！",
                type: "info"
            });
            return;
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }/*
        if (startTime == "" || startTime == undefined || startTime == null) {
            swal({
                title: "请选择授课开始时间！",
                type: "info"
            });
            return;
        }
        if (endTime == "" || endTime == undefined || endTime == null) {
            swal({
                title: "请选择授课结束时间！",
                type: "info"
            });
            return;
        }
        if (startTime > endTime) {
            swal({
                title: "结束时间！",
                type: "info"
            });
            return;
        }
        if (totalWeeks == "" || totalWeeks == undefined || totalWeeks == null) {
            swal({
                title: "请填写总学周！",
                type: "info"
            });
            return;
        }
        if (isNaN(totalWeeks)) {
            swal({
                title: "总学周只能为数字！",
                type: "info"
            });
            return;
        }
        if (totalHours == "" || totalHours == undefined || totalHours == null) {
            swal({
                title: "请填写总学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(totalHours)) {
            swal({
                title: "总学时只能为数字！",
                type: "info"
            });
            return;
        }
        if (theoreticalWeeks == "" || theoreticalWeeks == undefined || theoreticalWeeks == null) {
            swal({
                title: "请填写理论学周！",
                type: "info"
            });
            return;
        }
        if (isNaN(theoreticalWeeks)) {
            swal({
                title: "理论学周只能为数字！",
                type: "info"
            });
            return;
        }
        if (practiceWeeks == "" || practiceWeeks == undefined || practiceWeeks == null) {
            swal({
                title: "请填写实践教学学周！",
                type: "info"
            });
            return;
        }
        if (isNaN(practiceWeeks)) {
            swal({
                title: "实践教学学周只能为数字！",
                type: "info"
            });
            return;
        }
        if (theoreticalHours == "" || theoreticalHours == undefined || theoreticalHours == null) {
            swal({
                title: "请填写理论学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(theoreticalHours)) {
            swal({
                title: "理论学时只能为数字！",
                type: "info"
            });
            return;
        }
        if (practiceHours == "" || practiceHours == undefined || practiceHours == null) {
            swal({
                title: "请填写实践教学学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(practiceHours)) {
            swal({
                title: "实践教学学时为数字！",
                type: "info"
            });
            return;
        }
        if (totalTheoreticalHours == "" || totalTheoreticalHours == undefined || totalTheoreticalHours == null) {
            swal({
                title: "请填写理论总学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(totalTheoreticalHours)) {
            swal({
                title: "理论总学时为数字！",
                type: "info"
            });
            return;
        }
        if (totalPracticeHours == "" || totalPracticeHours == undefined || totalPracticeHours == null) {
            swal({
                title: "请填写实践教学总学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(totalPracticeHours)) {
            swal({
                title: "实践教学总学时为数字！",
                type: "info"
            });
            return;
        }
        if (theoryPracticeHours == "" || theoryPracticeHours == undefined || theoryPracticeHours == null) {
            swal({
                title: "请填写理实结合学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(theoryPracticeHours)) {
            swal({
                title: "理实结合学时为数字！",
                type: "info"
            });
            return;
        }*/
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teachingPlan/save", {
            id: id,
            planName: planName,
            departmentsId: departmentsId,
            majorCode: majorCode,
            trainingLevel: trainingLevel,
            courseType: courseType,
            courseId: courseId,
            textbookId: textbookId,
            year: year,
            classId: classId,
            term: term,
            startTime: startTime,
            endTime: endTime,
            totalWeeks: totalWeeks,
            totalHours: totalHours,
            theoreticalWeeks: theoreticalWeeks,
            theoreticalHours: theoreticalHours,
            totalTheoreticalHours: totalTheoreticalHours,
            practiceWeeks: practiceWeeks,
            practiceHours: practiceHours,
            totalPracticeHours: totalPracticeHours,
            theoryPracticeHours: theoryPracticeHours,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select major_code || ',' || training_level code," +
                "major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                "from t_xg_major where 1=1  and DEPARTMENTS_ID ='" + deptId + "' and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'majorCode');
            })
    }

    function change() {
        var majorCode = $("#majorCode").val();
        majorCode = majorCode.split(",")[0];
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: " where 1=1  and MAJOR_CODE ='" + majorCode + "' ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            });
        if ($("#courseType option:selected").val() != 1 || $("#courseType option:selected").val() != '1') {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " TEXTBOOK_ID ",
                    text: " TEXTBOOK_NAME ",
                    tableName: "T_JW_TEXTBOOK ",
                    where: " where 1=1  and MAJOR_CODE ='" + majorCode + "' ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'textbookId', '${data.textbookId}');
                })
        }
    }

    function changeCourseType() {
        var courseType = $("#courseType option:selected").val();
        var majorCode = $("#majorCode option:selected").val();
        if (courseType == 1 || courseType == '1') {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " TEXTBOOK_ID ",
                    text: " TEXTBOOK_NAME ",
                    tableName: "T_JW_TEXTBOOK ",
                    where: " where 1=1  and textbook_type ='1' ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'textbookId');
                })
        } else {
            if (majorCode != "" && majorCode != undefined) {
                majorCode = majorCode.split(",")[0];
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                        id: " TEXTBOOK_ID ",
                        text: " TEXTBOOK_NAME ",
                        tableName: "T_JW_TEXTBOOK ",
                        where: " where 1=1  and MAJOR_CODE ='" + majorCode + "' ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, 'textbookId');
                    })
            }
        }
    }

</script>



