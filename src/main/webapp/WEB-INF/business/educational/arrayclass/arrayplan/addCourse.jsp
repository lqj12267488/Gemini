<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
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
            <input id="id" hidden value="${arrayClassCourse.arrayClassCourseId}">
            <input id="a_arrayClassId" hidden value="${arrayClassId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseType" class="js-example-basic-single"
                                onchange="hideOtherProperty()"></select>
                    </div>
                </div>
                <div class="form-row" id="departmentsId">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="a_departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row" id="majorId">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="a_majorId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseID" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学周类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_weekType" class="js-example-basic-single"  onchange="changeWeekNumber()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        开始学周（包括）
                    </div>
                    <div class="col-md-9">
                        <input id="a_startWeek" value="${arrayClassCourse.startWeek}" onchange="changeWeekNumber()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束学周（包括）
                    </div>
                    <div class="col-md-9">
                        <input id="a_endWeek" value="${arrayClassCourse.endWeek}" onchange="changeWeekNumber()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学周数
                    </div>
                    <div class="col-md-9">
                        <input id="a_weekNumber" disabled value="${arrayClassCourse.weekNumber}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        每周学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_weekHours" value="${arrayClassCourse.weekHours}" onchange="changeTotleHours()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        总学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_totleHours" disabled value="${arrayClassCourse.totleHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        上课类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_teachType" class="js-example-basic-single"   onchange="changeOtherProperty()"></select>
                    </div>
                </div>
                <div class="form-row" id = "roomType">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教室名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="roomShow" type="text" onclick="showMenu()"  value="${arrayClassCourse.roomShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="classTree" class="ztree"></ul>
                        </div>
                        <input id="classRoom" type="hidden" value="${arrayClassCourse.roomId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学分
                    </div>
                    <div class="col-md-9">
                        <input id="a_credit" value="${arrayClassCourse.credit}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="10" placeholder="最多输入10位数字">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $("#roomType").hide();
        if ('${arrayClassCourse.teachType}' =='1' || '${arrayClassCourse.teachType}' == ''){
            $("#roomType").hide();
        }else{
            $("#roomType").show();
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XZLX", function (data) {
            addOption(data, 'a_weekType', '${arrayClassCourse.weekType}');
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SKXS", function (data) {
            addOption(data, 'a_teachType', '${arrayClassCourse.teachType}');
        });
        var courseType = $("#a_courseType option:selected").val();
        if ("1" == courseType) {
            $("#departmentsId").hide();
            $("#majorId").hide();
        } else {
            $("#departmentsId").show();
            $("#majorId").show();
        }
        //课程类型
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'a_courseType', '${arrayClassCourse.courseType}');
        });
        //系部下拉回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                addOption(data, "a_departmentsId", '${arrayClassCourse.departmentsId}');
            })
        //专业下拉回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                var major = '${arrayClassCourse.majorCode}' +"," +'${arrayClassCourse.trainingLevel}';
                addOption(data, "a_majorId", major);
            });
        //课程回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "a_courseID", '${arrayClassCourse.courseID}');
            });
        //系部联动专业
        $("#a_departmentsId").change(function () {
           /* var major_sql = "(select major_code || ',' || major_direction || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX') ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";*/
            var major_sql = "(select major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#a_departmentsId option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#a_departmentsId option:selected").val() + "' ";
            }
            major_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "a_majorId");
                })
        });
        //专业联动课程
        $("#a_majorId").change(function () {
            var majorId = $("#a_majorId option:selected").val();
            var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
            if (majorId != "") {
                /*course_sql += " and major_code ='" + majorId.substring(0, 6) + "' and major_direction ='"+ majorId.substring(7, 9) +"' and training_level='" + majorId.substring(10, majorId.length) + "' ";*/
                course_sql += " and major_code ='" + majorId.substring(0, 6) + "' and training_level='" + majorId.substring(7, majorId.length) + "' ";

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
                    addOption(data, "a_courseID");
                })
        });
        //课程类型联动课程
        $("#a_courseType").change(function () {
            var typeId = $("#a_courseType option:selected").val();
            if (typeId == 1) {
                var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and course_type=1 and  valid_flag = 1";
                course_sql += ")";
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                        id: " code ",
                        text: " value ",
                        tableName: course_sql,
                        where: " ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, "a_courseID");
                    })
            }

        });

    })
    function hideOtherProperty() {
        var typeId = $("#a_courseType").val();
        if ("1" == typeId) {
            $("#departmentsId").hide();
            $("#majorId").hide();
        } else {
            $("#departmentsId").show();
            $("#majorId").show();
        }

    }


    function changeOtherProperty(){
        var teachType= $("#a_teachType").val();
        if("1"==teachType){
            $("#roomType").hide();
        }else{
            $("#roomType").show();
            $.get("<%=request.getContextPath()%>/common/getTableToTree",{
                    id: " id",
                    text: " class_room_name ",
                    tableName: "T_JW_CLASSROOM ",
                    where: " WHERE VALID_FLAG = 1 and ROOM_TYPE = '"+$("#a_teachType").val()+"'"
                },
                function (data) {
                    zTree = $.fn.zTree.init($("#classTree"), setting, data);
                    var node;
                });
        }



    }
    var weekNumber = 0;
    var totleHours = 0;
    var number = 0;
    var weekType = "";
    function clearWeekNumber(){
        $("#a_weekNumber").val("");
    }
    function changeWeekNumber() {
        weekNumber = (Number($("#a_endWeek").val())-Number($("#a_startWeek").val()))+1;
        weekType = $("#a_weekType option:selected").val();
        if ($("#a_endWeek").val() == "" || $("#a_startWeek").val() == ""){
            number = "";
        }else {
            if (weekType == '1'){
                if((weekNumber%2)!=0){
                    if ($("#a_startWeek").val()%2!=0){
                        number = Math.ceil(weekNumber/2);
                    }else {
                        number = Math.floor(weekNumber/2);
                    }
                }else {
                    number = weekNumber/2;
                }
            }else if (weekType == '2'){
                if((weekNumber%2)!=0){
                    if ($("#a_startWeek").val()%2!=0){
                        number = Math.floor(weekNumber/2);
                    }else {
                        number = Math.ceil(weekNumber/2);
                    }
                }else {
                    number = weekNumber/2;
                }
            }else {
                number = weekNumber;
            }
        }
        $("#a_weekNumber").val(""+number+"");
        changeTotleHours();
    }
    function changeTotleHours() {
        totleHours = number * $("#a_weekHours").val();
        $("#a_totleHours").val(""+totleHours+"");
    }

    weekNumber = (Number($("#a_endWeek").val())-Number($("#a_startWeek").val()))+1;
    weekType = $("#a_weekType option:selected").val();
    if ($("#a_endWeek").val() == "" || $("#a_startWeek").val() == ""){
        number = "";
    }else {
        if (weekType == '1'){
            if((weekNumber%2)!=0){
                if ($("#a_startWeek").val()%2!=0){
                    number = Math.ceil(weekNumber/2);
                }else {
                    number = Math.floor(weekNumber/2);
                }
            }else {
                number = weekNumber/2;
            }
        }else if (weekType == '2'){
            if((weekNumber%2)!=0){
                if ($("#a_startWeek").val()%2!=0){
                    number = Math.floor(weekNumber/2);
                }else {
                    number = Math.ceil(weekNumber/2);
                }
            }else {
                number = weekNumber/2;
            }
        }else {
            number = weekNumber;
        }
    }
    $("#a_weekNumber").val(""+number+"");

    totleHours = number * $("#a_weekHours").val();
    $("#a_totleHours").val(""+totleHours+"");
    function save() {
        var trainingLevel = "";
        /*var majorDirection = "";*/
        var majorData = "";
        var majorId = $("#a_majorId option:selected").val();
        if ($("#a_courseType option:selected").val() == "" || $("#a_courseType option:selected").val() == undefined || $("#a_courseType option:selected").val() == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        } else if ("1" == $("#a_courseType option:selected").val()) {

        } else {
            if ($("#a_departmentsId option:selected").val() == "" || $("#a_departmentsId option:selected").val() == undefined || $("#a_departmentsId option:selected").val() == null) {
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
            if ($("#a_courseID option:selected").val() == "" || $("#a_courseID option:selected").val() == undefined || $("#a_courseID option:selected").val() == null) {
                swal({
                    title: "请选择课程！",
                    type: "info"
                });
                return;
            }
            majorData = majorId.substring(0, 6);
            /*majorDirection = majorId.substring(7,9);*/
            trainingLevel = majorId.substring(7, majorId.length);
        }
        if ($("#a_weekType option:selected").val() == "" || $("#a_weekType option:selected").val() == undefined || $("#a_weekType option:selected").val() == null) {
            swal({
                title: "请选择学周类型！",
                type: "info"
            });
            return;
        }
        if ($("#a_startWeek").val() == "" || $("#a_startWeek").val() == undefined || $("#a_startWeek").val() == null) {
            swal({
                title: "请填写开始学周！",
                type: "info"
            });
            return;
        }
        if ($("#a_endWeek").val() == "" || $("#a_endWeek").val() == undefined || $("#a_endWeek").val() == null) {
            swal({
                title: "请填写结束学周！",
                type: "info"
            });
            return;
        }
        if($("#a_startWeek").val()>$("#a_endWeek").val()){
            swal({
                title: "开始学周应早于结束学周！",
                type: "info"
            });
            return;
        }
        if ($("#a_weekHours").val() == "" || $("#a_weekHours").val() == undefined || $("#a_weekHours").val() == null) {
            swal({
                title: "请填写每周学时数！",
                type: "info"
            });
            return;
        }
        if ($("#a_teachType option:selected").val() == "" || $("#a_teachType option:selected").val() == undefined || $("#a_teachType option:selected").val() == null) {
            swal({
                title: "请选择上课类型！",
                type: "info"
            });
            return;
            if($("#a_teachType option:selected").val() != "0"){
                if ($("#classRoom").val() == "" || $("#classRoom").val() == undefined || $("#classRoom").val() == null) {
                    swal({
                        title: "请选择教室！",
                        type: "info"
                    });
                    return;
                }
            }
        }
        if ($("#a_credit").val() == "" || $("#a_credit").val() == undefined || $("#a_credit").val() == null) {
            swal({
                title: "请填写学分！",
                type: "info"
            });
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayClassCourse/saveArrayClassCourse", {
            arrayClassId: $("#a_arrayClassId").val(),
            courseType: $("#a_courseType option:selected").val(),
            arrayClassCourseId: $("#id").val(),
            departmentsId: $("#a_departmentsId option:selected").val(),
            majorCode: majorData,
            /*majorDirection: majorDirection,*/
            trainingLevel: trainingLevel,
            courseID: $("#a_courseID option:selected").val(),
            credit: $("#a_credit").val(),
            term: '${term}',
            weekType: $("#a_weekType option:selected").val(),
            startWeek: $("#a_startWeek").val(),
            endWeek: $("#a_endWeek").val(),
            weekNumber: weekNumber,
            weekHours: $("#a_weekHours").val(),
            totleHours: totleHours,
            teachType: $("#a_teachType option:selected").val(),
            roomId : $("#classRoom").val()
        }, function (msg) {
            hideSaveLoading();

            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#arrayClassCourseGrid').DataTable().ajax.reload();
            }
        })
    }

</script>

<script>
    var zTree;
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
        zTree = $.fn.zTree.getZTreeObj("classTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("classTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].id + ",";
        }

        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var roomVal = $("#classRoom");
        roomVal.attr("value", v);
    }

    function showMenu () {
        var roomObj = $("#classRoom");
        var roomOffset = $("#classRoom").offset();
        $("#menuContent").css({left:roomOffset.left + "px", top:roomOffset.top + roomObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "roomShow" || $(event.target).parents("#menuContent").length>0)) {
            hideTree();
            zTree = $.fn.zTree.getZTreeObj("classTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#classRoom").val(getChildNodes(nodes));//获取子节点
            $("#roomShow").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
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
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>

