<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="classId" hidden value="${classBean.classId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班级名称
                    </div>
                    <div class="col-md-4">
                        <input id="className" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入12个字" type="text" value="${classBean.className}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班级代码
                    </div>
                    <div class="col-md-4">
                        <input id="classCode" type="text"
                               value="${classBean.classCode}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>入学年份
                    </div>
                    <div class="col-md-4">
                        <select id="year" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班级类型
                    </div>
                    <div class="col-md-4">
                        <select id="classType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>班级教室
                    </div>
                    <div class="col-md-4">
                        <select id="roomId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorCode" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学习形式
                    </div>
                    <div class="col-md-4">
                        <select id="studyType" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班主任
                    </div>
                    <div class="col-md-4">
                        <input id="headTeacher" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>春秋季
                    </div>
                    <div class="col-md-4">
                        <select id="springAutumn" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>创建学期
                    </div>
                    <div class="col-md-4">
                        <select id="createTerm" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>毕业标识
                    </div>
                    <div class="col-md-4">
                        <select id="graduationFlag"/>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveClass()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="departmentsIdSHOW" hidden value="${classBean.departmentsId}">
<input id="classTypeSHOW" hidden value="${classBean.classType}">
<input id="yearSHOW" hidden value="${classBean.year}">
<input id="studyTypeSHOW" hidden value="${classBean.studyType}">
<input id="majorCodeSHOW" hidden value="${classBean.majorCode}">
<input id="springAutumnSHOW" hidden value="${classBean.springAutumn}">
<input id="createTermSHOW" hidden value="${classBean.createTerm}">
<input id="graduationFlagSHOW" hidden value="${classBean.graduationFlag}">
<input id="majorDirectionSHOW" hidden value="${classBean.majorDirection}">
<input id="trainingLevelSHOW" hidden value="${classBean.trainingLevel}">
<input id="headTeacherId" hidden value="${classBean.headTeacher}">
<input id="headTeacherSHOW" hidden value="${classBean.headTeacherShow}">
<input id="headTeacherDeptId" hidden value="${classBean.headTeacherDept}">
<input id="headTeacherDeptSHOW" hidden value="${classBean.headTeacherDeptShow}">


<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsId", $("#departmentsIdSHOW").val());
            })
        var maojorwhere = "";
        if ($("#classTypeSHOW").val() != "")
            maojorwhere = " and training_level ='" + $("#classTypeSHOW").val() + "'";
        if ($("#departmentsIdSHOW").val() != "") {
            maojorwhere = maojorwhere + " and departments_id ='" + $("#departmentsIdSHOW").val() + "' ";
        }

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select major_code ||',' || major_direction|| ',' || training_level code," +
                    " major_name ||  ' -- '|| FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  " +
                    "' -- ' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                    "from t_xg_major where 1=1  and valid_flag = 1 " + maojorwhere + " )",
                where: " ",
                orderby: " "
            },
            function (data) {
                var va = $("#majorCodeSHOW").val() + "," + $("#majorDirectionSHOW").val() + "," + $("#trainingLevelSHOW").val();
                addOption(data, "majorCode", va);
            })
        //班级教室
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "id",
                text: " class_room_name ",
                tableName: "T_JW_CLASSROOM",
                where: " WHERE ROOM_TYPE =1 ",
                orderby: " order by class_room_name"
            },
            function (data) {
                addOption(data, 'roomId', '${classBean.roomId}');
            })
        //毕业标识 graduationFlagSHOW
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BJZT", function (data) {
            addOption(data, 'graduationFlag', $("#graduationFlagSHOW").val());
        })
        //班级类型 classType
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZJBJLX", function (data) {
            addOption(data, 'classType', $("#classTypeSHOW").val());
        });
        //春秋季 springAutumn
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CQJ", function (data) {
            addOption(data, 'springAutumn', $("#springAutumnSHOW").val());
        });
        //创建学期 createTerm
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'createTerm', $("#createTermSHOW").val());
        });
        //入学年份 year
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', $("#yearSHOW").val());
        });
        //学习形式 studyType
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXS", function (data) {
            addOption(data, 'studyType', $("#studyTypeSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#headTeacher").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#headTeacher").val(ui.item.label);
                    $("#headTeacher").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
            if ($("#classId").val() != "") {
                if ($("#headTeacherId").val() != "") {
                    $("#headTeacher").val($("#headTeacherSHOW").val() + " --- " + $("#headTeacherDeptSHOW").val());
                    $("#headTeacher").attr("keycode", $("#headTeacherDeptId").val() + "," + $("#headTeacherId").val());
                }
            }
        })


        $("#departmentsId").change(function () {
            var major_sql = "(select major_code ||',' || major_direction|| ',' || training_level code," +
                " major_name ||  ' -- '|| FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  " +
                "' -- ' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                " from t_xg_major where 1=1  and valid_flag = 1 ";
            if ($("#departmentsId option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#departmentsId option:selected").val() + "' ";
            }

            if ($("#classType option:selected").val() != "") {
                major_sql += " and training_level ='" + $("#classType option:selected").val() + "' ";
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
                    addOption(data, "majorCode");
                })
        });

        $("#classType").change(function () {
            var major_sql = "(select major_code ||',' || major_direction|| ',' || training_level code," +
                " major_name ||  ' -- '|| FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  " +
                "' -- ' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value " +
                " from t_xg_major where 1=1 and valid_flag = 1 ";
            if ($("#departmentsId option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#departmentsId option:selected").val() + "' ";
            }

            if ($("#classType option:selected").val() != "") {
                major_sql += " and training_level ='" + $("#classType option:selected").val() + "' ";
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
                    addOption(data, "majorCode");
                })
        });

    })

    function saveClass() {
        var majorCodeList = $("#majorCode option:selected").val();
        var mCList = majorCodeList.split(",");
        var majorcode = mCList[0];
        var majorD = mCList[1];
        var traininglevel = mCList[2];
        var headT = $("#headTeacher").attr("keycode");
        if ($("#className").val() == "") {
            swal({
                title: "请填写班级名称!",
                type: "info"
            });
            return;
        }
        if ($("#classCode").val() == "") {
            swal({
                title: "请填写班级代码!",
                type: "info"
            });
            return;
        }
        if ($("#year").val() == "") {
            swal({
                title: "请填写入学年份!",
                type: "info"
            });
            return;
        }
        if ($("#departmentsId option:selected").val() == "") {
            swal({
                title: "请填写系部!",
                type: "info"
            });
            return;
        }
        if ($("#classType option:selected").val() == "") {
            swal({
                title: "请填写班级类型!",
                type: "info"
            });
            return;
        }
        /* if ($("#roomId option:selected").val() == "") {
             swal({
                 title: "请选择班级教室!",
                 type: "info"
             });
             return;
         }*/
        if ($("#majorCode option:selected").val() == "") {
            swal({
                title: "请填写专业!",
                type: "info"
            });
            return;
        }
        if ($("#studyType").val() == "") {
            swal({
                title: "请填写学习形式!",
                type: "info"
            });
            return;
        }
        /* if ($("#headTeacher").val() == "") {
             swal({
                 title: "请填写班主任!",
                 type: "info"
             });
             return;
         }else{
             if ($("#headTeacher").attr("keycode") == undefined||$("#headTeacher").attr("keycode") == "") {
                 swal({
                     title: "请在弹出列表中选择班主任!",
                     type: "info"
                 });
                 return;
             }
         }
         if ($("#springAutumn").val() == "") {
             swal({
                 title: "请填写春秋季!",
                 type: "info"
             });
             return;
         }
         if ($("#createTerm").val() == "") {
             swal({
                 title: "请填写创建学期!",
                 type: "info"
             });
             return;
         }*/
        if ($("#graduationFlag").val() == "") {
            swal({
                title: "请填写毕业标识!",
                type: "info"
            });
            return;
        }
        if (headT == null || headT == '' || headT == undefined) {
            swal({
                title: "请填写班主任!",
                type: "info"
            });
            return;
        }
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/classManagement/savaClass", {
            classId: $("#classId").val(),
            className: $("#className").val(),
            classCode: $("#classCode").val(),
            year: $("#year").val(),
            departmentsId: $("#departmentsId option:selected").val(),
            classType: $("#classType option:selected").val(),
            roomId: $("#roomId option:selected").val(),
            majorCode: majorcode,
            majorDirection: majorD,
            trainingLevel: traininglevel,
            studyType: $("#studyType option:selected").val(),
//            headTeacher: $("#headTeacher").attr("keycode"),
            springAutumn: $("#springAutumn option:selected").val(),
            createTerm: $("#createTerm option:selected").val(),
            graduationFlag: $("#graduationFlag option:selected").val(),
            headTeacher: headTList[1],
            headTeacherDept: headTList[0],
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#classGrid').DataTable().ajax.reload();
            }else{
                swal({
                    title: msg.msg,
                    type: "error"
                });
                $("#dialog").modal('hide');
                $('#classGrid').DataTable().ajax.reload();
            }
        })
    }

</script>