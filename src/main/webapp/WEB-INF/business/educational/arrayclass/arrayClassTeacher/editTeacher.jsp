<%--suppress ALL --%>
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
            <span style="font-size: 14px">新增</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        授课教师
                    </div>
                    <div class="col-md-9">
                        <input id="teacherPersonId" type="text"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorCode" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程类型
                    </div>
                    <div class="col-md-9" >
                        <select id="courseType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="courseId" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        总学时数
                    </div>
                    <div class="col-md-9">
                        <input id="totleHours" type="number" value="${arrayTeacher.totleHours}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="id" value="${arrayTeacher.id}" hidden >
    <input id="departmentsIdShow" value="${arrayTeacher.departmentsId}" hidden >
    <input id="majorCodeShow" value="${arrayTeacher.majorCode}" hidden >
    <input id="trainingLevelShow" value="${arrayTeacher.trainingLevel}" hidden >
    <input id="courseTypeShow" value="${arrayTeacher.courseType}" hidden >
    <input id="courseIdShow" value="${arrayTeacher.courseId}" hidden >

    <input id="teacherPersonIdShow" value="${arrayTeacher.teacherPersonId}" hidden >
    <input id="teacherPersonShow" value="${arrayTeacher.teacherPersonShow}" hidden >
    <input id="teacherDeptIdShow" value="${arrayTeacher.teacherDeptId}" hidden >
    <input id="teacherDeptShow" value="${arrayTeacher.teacherDeptShow}" hidden >
</div>
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherPersonId").val(ui.item.label);
                    $("#teacherPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        if($("#departmentsIdShow").val()!=""){
            $("#teacherPersonId").val( $("#teacherPersonShow").val()+" --- "+$("#teacherDeptShow").val());
            $("#teacherPersonId").attr("keycode",$("#teacherDeptIdShow").val()+","+$("#teacherPersonIdShow").val());
        }

        $.get("<%=request.getContextPath()%>/common/getSelectDept",{type: "8" },
            function (data1) {
                addOption(data1, "departmentsId",$("#departmentsIdShow").val());
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " distinct id ",
                text: " name ",
                tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                                    " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                            "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentsIdShow").val()+"'  ) ",
                where: " ",
                orderby: " "
            },
            function (data1) {
                addOption(data1, "majorCode", $("#majorCodeShow").val()+","+$("#trainingLevelShow").val() );
            })

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', $("#courseTypeShow").val());
        });

        var courseType = $("#courseTypeShow").val();
        if(courseType =="1" || courseType ==1 ){
            wheresql = "where COURSE_TYPE ='"+courseType+"'";
        }else{
            wheresql = "where major_Code = '"+$("#majorCodeShow").val()+"' and TRAINING_LEVEL = '"+$("#trainingLevelShow").val()+"' " +
                " and COURSE_TYPE = '"+courseType+"' ";
        }
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "(select COURSE_ID , COURSE_NAME from T_JW_COURSE " + wheresql +")" ,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseId",$("#courseIdShow").val() );
            })

    })


    $("#departmentsId").blur(function() {
        if($("#departmentsId option:selected").val()!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " distinct id ",
                    text: " name ",
                    tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                    " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                    "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentsId option:selected").val()+"'  ) ",
                    where: " ",
                    orderby: " "
                },
                function (data1) {
                    addOption(data1, "majorCode");
                })
        }
    });

    $("#majorCode").blur(function() {
        if($("#majorCode option:selected").val()!="" && $("#courseType option:selected").val()!=""){
            var mCode = $("#majorCode option:selected").val();
            var majorCode = mCode.split(",")[0];
            var trainingLevel = mCode.split(",")[1];
            var wheresql = "";
            var courseType = $("#courseType option:selected").val();
            if(courseType =="1" || courseType ==1 ){
                wheresql = "where COURSE_TYPE ='"+courseType+"'";
            }else{
                wheresql = "where major_Code = '"+majorCode+"' and TRAINING_LEVEL = '"+trainingLevel+"' " +
                                " and COURSE_TYPE = '"+courseType+"' ";
            }
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " COURSE_ID ",
                    text: " COURSE_NAME ",
                    tableName: "(select COURSE_ID , COURSE_NAME from T_JW_COURSE " + wheresql +")" ,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "courseId");
                })
        }
    });

    $("#courseType").blur(function() {
        if($("#majorCode option:selected").val()!="" && $("#courseType option:selected").val()!=""){
            var mCode = $("#majorCode option:selected").val();
            var majorCode = mCode.split(",")[0];
            var trainingLevel = mCode.split(",")[1];
            var wheresql = "";
            var courseType = $("#courseType option:selected").val();
            if(courseType =="1" || courseType ==1 ){
                wheresql = "where COURSE_TYPE ='"+courseType+"'";
            }else{
                wheresql = "where major_Code = '"+majorCode+"' and TRAINING_LEVEL = '"+trainingLevel+"' " +
                    " and COURSE_TYPE = '"+courseType+"' ";
            }
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " COURSE_ID ",
                    text: " COURSE_NAME ",
                    tableName: "(select COURSE_ID , COURSE_NAME from T_JW_COURSE " + wheresql +")" ,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "courseId");
                })
        }
    });


    function save() {
        var teacherPersonId = $("#teacherPersonId").attr("keycode");
        if (teacherPersonId == "" ||teacherPersonId == undefined) {
            swal({
                title: "请填写授课教师！",
                type: "info"
            });
            return;
        }

        var teacherPersonIdList = teacherPersonId.split(",");
        var perId = teacherPersonIdList[1];
        var perDeptId = teacherPersonIdList[0];

        var courseId = $("#courseId option:selected").val();
        if (courseId == "" ||courseId == undefined) {
            swal({
                title: "请填写课程！",
                type: "info"
            });
            return;
        }

        var courseType = $("#courseType option:selected").val();
        var departmentsId = $("#departmentsId option:selected").val();
        if (departmentsId == "" ||departmentsId == undefined) {
            swal({
                title: "请填写系部！",
                type: "info"
            });
            return;
        }

        var mCode = $("#majorCode option:selected").val();
        if (mCode == "" ||mCode == undefined) {
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        var majorCodeList = mCode.split(",");
        var majorCode = majorCodeList[0];
        var trainingLevel = majorCodeList[1];

        var totleHours = $("#totleHours").val();
        if (totleHours == "" ||totleHours == undefined) {
            swal({
                title: "请填写总课时！",
                type: "info"
            });
            return;
        }
        if (totleHours == 0 ||totleHours <0 ) {
            swal({
                title: "总课时不能为非正数！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/arrayClass/updateArrayClassTeacher", {
            id:  $("#id").val(),
            teacherPersonId: perId,
            teacherDeptId: perDeptId,
            courseType: courseType,
            courseId: courseId,
            departmentsId: departmentsId,
            majorCode: majorCode,
            trainingLevel: trainingLevel,
            totleHours: totleHours
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                searchGrid();
            }
        })
    }
</script>


