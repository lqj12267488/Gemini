<%--流程查看--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="form-row">
    <div class="col-md-2 tar">
        计划名称
    </div>
    <div class="col-md-4">
        <input id="planName" readonly value="${data.planName}" onclick="demo(this)"/>
    </div>
    <div class="col-md-2 tar">
        系部名称
    </div>
    <div class="col-md-4">
        <select id="departmentsId" disabled value="${data.departmentsId}" onchange="changeMajor()"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        专业名称
    </div>
    <div class="col-md-4">
        <select id="majorCode" disabled value="${data.majorCode}"/>
    </div>
    <div class="col-md-2 tar">
        课程名称
    </div>
    <div class="col-md-4">
        <select id="courseId" disabled value="${data.courseId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        课程类型
    </div>
    <div class="col-md-4">
        <select id="courseType" value="${data.courseType}"/>
    </div>
    <div class="col-md-2 tar">
        教材名称
    </div>
    <div class="col-md-4">
        <select id="textbookId" disabled value="${data.textbookId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        创建年份
    </div>
    <div class="col-md-4">
        <select id="year" disabled value="${data.year}"/>
    </div>
    <div class="col-md-2 tar">
        班级名称
    </div>
    <div class="col-md-4">
        <input id="className" readonly value="${data.className}"/>
        <%--<div id="menuContent" class="menuContent">--%>
        <%--<ul id="tree" class="ztree"></ul>--%>
        <%--</div>--%>
        <input id="classId" readonly hidden value="${data.classId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        学期
    </div>
    <div class="col-md-4">
        <select id="fterm" disabled value="${data.term}"/>
    </div>
   <%-- <div class="col-md-2 tar">
        授课开始时间
    </div>
    <div class="col-md-4">
        <input type="date" id="startTime" readonly value="${data.startTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        授课结束时间
    </div>
    <div class="col-md-4">
        <input type="date" id="endTime" readonly value="${data.endTime}"/>
    </div>
    <div class="col-md-2 tar">
        总学周
    </div>
    <div class="col-md-4">
        <input id="totalWeeks" readonly value="${data.totalWeeks}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        总学时
    </div>
    <div class="col-md-4">
        <input id="totalHours" readonly value="${data.totalHours}"/>
    </div>
    <div class="col-md-2 tar">
        理论学周
    </div>
    <div class="col-md-4">
        <input id="theoreticalWeeks" readonly value="${data.theoreticalWeeks}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        理论学时
    </div>
    <div class="col-md-4">
        <input id="theoreticalHours" readonly value="${data.theoreticalHours}"/>
    </div>
    <div class="col-md-2 tar">
        理论总学时
    </div>
    <div class="col-md-4">
        <input id="totalTheoreticalHours" readonly value="${data.totalTheoreticalHours}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        实践教学学周
    </div>
    <div class="col-md-4">
        <input id="practiceWeeks" readonly value="${data.practiceWeeks}"/>
    </div>
    <div class="col-md-2 tar">
        实践教学学时
    </div>
    <div class="col-md-4">
        <input id="practiceHours" readonly value="${data.practiceHours}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        实践教学总学时
    </div>
    <div class="col-md-4">
        <input id="totalPracticeHours" readonly value="${data.totalPracticeHours}"/>
    </div>
    <div class="col-md-2 tar">
        理实结合学时
    </div>
    <div class="col-md-4">
        <input id="theoryPracticeHours" readonly value="${data.theoryPracticeHours}"/>
    </div>--%>
</div>
<input id="workflowCode" hidden value="T_JW_TEACHINGPLAN01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/teachingPlan/printTeacherPlan?id=${data.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${data.courseType}');
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

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data, 'fterm', '${data.term}');
        });

        if ('${data.textbookId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " TEXTBOOK_ID ",
                text: " TEXTBOOK_NAME ",
                tableName: "T_JW_TEXTBOOK ",
                where: " ",
                orderby: " "
            }, function (data) {
                addOption(data, 'textbookId', '${data.textbookId}');
            })
        } else {
            $("#textbookId").append("<option value='' selected>请选择</option>")
        }
        if ('${data.courseId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: " where 1=1  and MAJOR_CODE ='" + majorCode + "' ",
                orderby: " "
            }, function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            })

        } else {
            $("#courseId").append("<option value='' selected>请选择</option>")
        }
        var classIds = '${data.classId}';
        /*
                var className ="";
                if(classIds!=null && classIds!=""){
                    var list=classIds.split(',');
                    for(var i=0;i<list.length;i++){
                        $.post("/common/getTableDict", {
                            id: " ID",
                            text: " CLASS_ROOM_NAME ",
                            tableName: " T_JW_CLASSROOM ",
                            where: " WHERE 1 = 1 and ID = '"+ list[i] +"'"
                        },function (data) {
                            className+=data+',';
                        });
                    }

                }
                className=className.substring(0,className.length-1)
        */
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
        initSelectTree("<%=request.getContextPath()%>/student/getMajorClassTree", "tree", "className", "classId");
    });

    var selectTreeId;
    var hiddenInput;
    var nameShow;

    function initSelectTreeByData(data, zTreeId, nameShowId, hiddenInputId, setting) {
        if (setting != undefined) {
            selectTreeSetting = setting;
        }
        $("#" + nameShowId).attr("onclick", "showMenu()");
        selectTreeId = zTreeId;
        nameShow = nameShowId;
        hiddenInput = hiddenInputId;
        $.fn.zTree.init($("#" + selectTreeId), selectTreeSetting, data);
    }

    function initSelectTree(url, zTreeId, nameShowId, hiddenInputId, setting) {
        if (setting != undefined) {
            selectTreeSetting = setting;
        }
        $("#" + nameShowId).attr("onclick", "showMenu()");
        selectTreeId = zTreeId;
        nameShow = nameShowId;
        hiddenInput = hiddenInputId;
        $.get(url, function (data) {
            $.fn.zTree.init($("#" + selectTreeId), selectTreeSetting, data);
        });
    }

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
            alert(getChildNodes(nodes))
            $("#" + nameShow).val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 3) {
                nodes += treeNode[i].name + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999" && treeNode[i].level == 3) {
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
</script>



