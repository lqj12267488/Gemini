<%--待办修改--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/common/treeSelect.jsp" %>
<div class="form-row">
    <div class="col-md-2 tar">
        计划名称
    </div>
    <div class="col-md-4">
        <input id="planName" value="${data.planName}" onclick="demo(this)"/>
    </div>
    <div class="col-md-2 tar">
        系部名称
    </div>
    <div class="col-md-4">
        <select id="departmentsId" onchange="changeMajor()"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        专业名称
    </div>
    <div class="col-md-4">
        <select id="majorCode" onchange="changemajorCode()"/>
    </div>
    <div class="col-md-2 tar">
        课程名称
    </div>
    <div class="col-md-4">
        <select id="courseId" value="${data.courseId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        课程类型
    </div>
    <div class="col-md-4">
        <select id="courseType" value="${data.courseType}" onchange="changeCourseType()"/>
    </div>
    <div class="col-md-2 tar">
        教材名称
    </div>
    <div class="col-md-4">
        <select id="textbookId" value="${data.textbookId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        创建年份
    </div>
    <div class="col-md-4">
        <select id="year" value="${data.year}"/>
    </div>
    <div class="col-md-2 tar">
        班级名称
    </div>
    <div class="col-md-4">
        <input id="className" value="${data.className}"/>
        <div id="menuContent" class="menuContent">
            <ul id="tree" class="ztree"></ul>
        </div>
        <input id="classId" hidden value="${data.classId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        学期
    </div>
    <div class="col-md-4">
        <select id="fterm" value="${data.term}"/>
    </div>
 <%--   <div class="col-md-2 tar">
        授课开始时间
    </div>
    <div class="col-md-4">
        <input type="date" id="startTime" value="${data.startTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        授课结束时间
    </div>
    <div class="col-md-4">
        <input type="date" id="endTime" value="${data.endTime}"/>
    </div>
    <div class="col-md-2 tar">
        总学周
    </div>
    <div class="col-md-4">
        <input id="totalWeeks" value="${data.totalWeeks}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        总学时
    </div>
    <div class="col-md-4">
        <input id="totalHours" value="${data.totalHours}"/>
    </div>
    <div class="col-md-2 tar">
        理论学周
    </div>
    <div class="col-md-4">
        <input id="theoreticalWeeks" value="${data.theoreticalWeeks}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        理论学时
    </div>
    <div class="col-md-4">
        <input id="theoreticalHours" value="${data.theoreticalHours}"/>
    </div>
    <div class="col-md-2 tar">
        理论总学时
    </div>
    <div class="col-md-4">
        <input id="totalTheoreticalHours" value="${data.totalTheoreticalHours}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        实践教学学周
    </div>
    <div class="col-md-4">
        <input id="practiceWeeks" value="${data.practiceWeeks}"/>
    </div>
    <div class="col-md-2 tar">
        实践教学学时
    </div>
    <div class="col-md-4">
        <input id="practiceHours" value="${data.practiceHours}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        实践教学总学时
    </div>
    <div class="col-md-4">
        <input id="totalPracticeHours" value="${data.totalPracticeHours}"/>
    </div>
    <div class="col-md-2 tar">
        理实结合学时
    </div>
    <div class="col-md-4">
        <input id="theoryPracticeHours" value="${data.theoryPracticeHours}"/>
    </div>--%>
</div>
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

        var deptId = '${data.departmentsId}';
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " code ",
                text: " value ",
                tableName: "(select major_code || ',' || training_level code," +
                "major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                "from t_xg_major where 1=1  and DEPARTMENTS_ID ='"+deptId+"' and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'majorCode','${data.majorCode}'+','+'${data.trainingLevel}');
            })

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data, 'fterm', '${data.term}');
        });

        if ('${data.textbookId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
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
        if ('${data.courseId}' != "") {
            var majorCode = '${data.majorCode}';
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " COURSE_ID ",
                    text: " COURSE_NAME ",
                    tableName: "T_JW_COURSE ",
                    where: " where 1=1  and MAJOR_CODE ='"+majorCode+"' ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'courseId','${data.courseId}');
                })

        } else {
            $("#courseId").append("<option value='' selected>请选择</option>")
        }
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


    function save() {
        var id = $("#id").val();
        var planName = $("#planName").val();
        var departmentsId = $("#departmentsId").val();
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
        var majorCode = $("#majorCode option:selected").val();
        var trainingLevel ="";
        if(majorCode!=""){
            trainingLevel =majorCode.split(",")[1];
            majorCode = majorCode.split(",")[0];
        }
        var courseType = $("#courseType option:selected").val();

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
        }
      /*  if (startTime == "" || startTime == undefined || startTime == null) {
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
        if (totalWeeks == "" || totalWeeks == undefined || totalWeeks == null) {
            swal({
                title: "请填写总学周！",
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
        if (theoreticalWeeks == "" || theoreticalWeeks == undefined || theoreticalWeeks == null) {
            swal({
                title: "请填写理论学周！",
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
        if (theoreticalHours == "" || theoreticalHours == undefined || theoreticalHours == null) {
            swal({
                title: "请填写理论学时！",
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
        if (totalTheoreticalHours == "" || totalTheoreticalHours == undefined || totalTheoreticalHours == null) {
            swal({
                title: "请填写理论总学时！",
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
        if (theoryPracticeHours == "" || theoryPracticeHours == undefined || theoryPracticeHours == null) {
            swal({
                title: "请填写理实结合学时！",
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
        }*/

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
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " code ",
                text: " value ",
                tableName: "(select major_code || ',' || training_level code," +
                "major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                "from t_xg_major where 1=1  and DEPARTMENTS_ID ='"+deptId+"' and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'majorCode');
            })
    }
    function change() {
        var majorId = $("#majorId").val();
        $.get("<%=request.getContextPath()%>/teachingPlan/getCourseByMajor?majorId="+majorId, function (data) {
            addOption(data, 'courseId', '${data.courseId}');
        });
        $.get("<%=request.getContextPath()%>/teachingPlan/getTextbookByMajor?majorId="+majorId, function (data) {
            addOption(data, 'textbookId', '${data.textbookId}');
        });
    }

    function changemajorCode() {
        var majorCode = $("#majorCode").val();
        majorCode = majorCode.split(",")[0];
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: " where 1=1  and MAJOR_CODE ='"+majorCode+"' ",
                orderby: " "
            },
            function (data) {
                addOption(data, 'courseId','${data.courseId}');
            })
        if($("#courseType option:selected").val() != 1 || $("#courseType option:selected").val() != '1') {
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " TEXTBOOK_ID ",
                    text: " TEXTBOOK_NAME ",
                    tableName: "T_JW_TEXTBOOK ",
                    where: " where 1=1  and MAJOR_CODE ='"+majorCode+"' ",
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
        if(courseType == 1 || courseType == '1'){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " TEXTBOOK_ID ",
                    text: " TEXTBOOK_NAME ",
                    tableName: "T_JW_TEXTBOOK ",
                    where: " where 1=1  and textbook_type ='1' ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, 'textbookId');
                })
        }else {
            if(majorCode!="" && majorCode!= undefined){
                majorCode = majorCode.split(",")[0];
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " TEXTBOOK_ID ",
                        text: " TEXTBOOK_NAME ",
                        tableName: "T_JW_TEXTBOOK ",
                        where: " where 1=1  and MAJOR_CODE ='"+majorCode+"' ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, 'textbookId');
                    })
            }
        }
    }

</script>



