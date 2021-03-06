<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/7
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="internshipId" hidden value="${internshipManage.internshipId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  学籍号
                    </div>
                    <div class="col-md-4">
                        <input id="studentNumber" type="text"  />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  实习形式
                    </div>
                    <div class="col-md-4">
                        <select id="internshipType" onchange="hideOtherProperty()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" disabled="disabled"  type="text"  class="js-example-basic-single" onchange="changeEditMajor()"></select>
                    </div>
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorCodeId" type="text" disabled="disabled" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" disabled="disabled" type="text" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classIdId" type="text"  disabled="disabled" class="js-example-basic-single"  ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" class="js-example-basic-single" disabled="disabled"></select>
                    </div>
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="f_idcard" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipManage.idcard}"/>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   学生电话
                    </div>
                    <div class="col-md-4">
                        <input id="f_tel" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipManage.tel}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 家长电话
                    </div>
                    <div class="col-md-4">
                        <input id="f_parentTel" type="text"
                                class="validate[required,maxSize[20]] form-control"
                                value="${internshipManage.parentTel}"/>
                    </div>
                </div>
                <div class="form-row" id="s_internshipUnitId">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   实习单位
                    </div>
                    <div class="col-md-4">
                        <select id="internshipUnitId" onchange="selectArea()" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 实习岗位
                    </div>
                    <div class="col-md-4">
                        <input id="f_internshipPositions" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipManage.internshipPositions}" />
                    </div>
                </div>
                <div class="form-row" id="s_postsTime">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   上岗时间
                    </div>
                    <div class="col-md-4">
                        <input id="f_postsTime" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${internshipManage.postsTime}" />
                    </div>
                    <div class="col-md-2 tar">
                       地区
                    </div>
                    <div class="col-md-4">
                        <input id="f_area" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipManage.area}" />
                    </div>
                </div>
                <div class="form-row" id="s_internshipScore">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  实习评分
                    </div>
                    <div class="col-md-4">
                        <input id="f_internshipScore" type="text" onchange="scroe()"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipManage.internshipScore}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  实习评价
                    </div>
                    <div class="col-md-4">
                        <select id="finternshipEvaluation"  disabled="disabled"/>
                    </div>

                </div>
                <div class="form-row" id="s_salary">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   工资
                    </div>
                    <div class="col-md-4">
                        <select id="salary" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  专业对口否
                    </div>
                    <div class="col-md-4">
                        <select id="majorMatchFlag" />
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    /*function scroe(){
        if($("#f_internshipScore").val()!=""){
            if($("#f_internshipScore").val()>=90 && $("#f_internshipScore").val()<=100){
                $("#finternshipEvaluation").val(1);
            }else if($("#f_internshipScore").val()>=80 && $("#f_internshipScore").val()<90){
                $("#finternshipEvaluation").val(2);
            }else if($("#f_internshipScore").val()>=70 && $("#f_internshipScore").val()<80){
                $("#finternshipEvaluation").val(3);
            }else if($("#f_internshipScore").val()>=60 && $("#f_internshipScore").val()<70){
                $("#finternshipEvaluation").val(4);
            }else{
                $("#finternshipEvaluation").val(5);
            }
        }
    }*/
    $("#f_internshipScore").blur(function () {
        if($("#f_internshipScore").val()!=""){
            if($("#f_internshipScore").val()>=90 && $("#f_internshipScore").val()<=100){
                $("#finternshipEvaluation").val(1);
            }else if($("#f_internshipScore").val()>=80 && $("#f_internshipScore").val()<90){
                $("#finternshipEvaluation").val(2);
            }else if($("#f_internshipScore").val()>=70 && $("#f_internshipScore").val()<80){
                $("#finternshipEvaluation").val(3);
            }else if($("#f_internshipScore").val()>=60 && $("#f_internshipScore").val()<70){
                $("#finternshipEvaluation").val(4);
            }else if($("#f_internshipScore").val()>=0 && $("#f_internshipScore").val()<60){
                $("#finternshipEvaluation").val(5);
            }else {
                swal({
                    title: "实习评分请填写100以下的整数！",
                    type: "info"
                });
            }
        }
    })
    $("#studentNumber").blur(function () {
        if($("#studentNumber").val()!=""){
            $.get("<%=request.getContextPath()%>/internshipManage/getStudentByStudentNumber?studentNumber="+$("#studentNumber").val(),
                function (data) {
                    if(data!= null){
                        console.log(data);
                        console.log(data.idcard);
                        console.log(data.sex);
                        console.log(data.studentId);
                        console.log(data.classId);
                        console.log(data.departmentsId);
                        console.log(data.majorCode);
                        console.log(data.trainingLevel);
                        $("#f_idcard").val(data.idcard);
                        $("#sex").val(data.sex);
                        $("#studentId").val(data.studentId);
                        $("#classIdId").val(data.classId);
                        $("#departmentsId").val(data.departmentsId);
                        $("#majorCodeId").val(data.majorCode);
                        $("#trainingLevelId").val(data.trainingLevel);
                        /*if($("#majorCodeId").val(data.majorCode)!=""){
                            $("#majorCodeId").val(  $("#majorCodeId").val(data.majorCode)+" --- "+$("#trainingLevelId").val(data.trainingLevel));
                        }*/
                    }
                })
        }
    });
    function hideOtherProperty() {
        var typeId = $("#internshipType").val();
        if ("3" == typeId) {
            $("#s_internshipUnitId").hide();
            $("#s_postsTime").hide();
            $("#s_majorMatchFlag").hide();
            $("#s_salary").hide();
            $("#s_internshipScore").hide();

        } else {
            $("#s_internshipUnitId").show();
            $("#s_postsTime").show();
            $("#s_majorMatchFlag").show();
            $("#s_salary").show();
            $("#s_internshipScore").show();
        }

    }
    function selectArea(){
        if($("#internshipUnitId").val() != ""){
            $.get("<%=request.getContextPath()%>/internshipManage/selectArea?internshipUnitId="+$("#internshipUnitId").val(),
                function (String) {

                    $("#f_area").val(decodeURI(decodeURI(String)));
                })
        }
    }
    /*function selectArea() {
        if($("#internshipUnitId").val() != ""){
            $.get("/internshipManage/selectArea?internshipUnitId="+$("#internshipUnitId").val(),
                function (String) {

                    $("#f_area").val(decodeURI(decodeURI(String)));
                })
        }
    }*/
    /*$("#internshipUnitId").blur(function () {
        if($("#internshipUnitId").val() != ""){
            $.get("/internshipManage/selectArea?internshipUnitId="+$("#internshipUnitId").val(),
                function (String) {

                    $("#f_area").val(decodeURI(decodeURI(String)));
             })
        }
    });*/
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "internshipUnitId", $("#internshipUnitIdShow").val());
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsId", $("#departmentsIdShow").val());
            });

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                addOption(data, "majorCodeId", $("#majorCodeShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " name ",
                tableName: "t_xg_student"
            },
            function (data) {
                addOption(data, "studentId", $("#studentIdShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: "t_xg_class"
            },
            function (data) {
                addOption(data, "classIdId", $("#classIdShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'trainingLevelId', $("#trainingLevelShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GZSRSP", function (data) {
            addOption(data, 'salary', $("#salaryShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SXXS", function (data) {
            addOption(data, 'internshipType', $("#internshipTypeShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'majorMatchFlag', $("#majorMatchFlagShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SXPJ", function (data) {
            addOption(data, 'finternshipEvaluation', $("#internshipEvaluationShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentGrants.departmentsId}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data,'sex', $("#sexShow").val());
        });

//       班级回显
        /*if ('{studentGrants.classId}' != "") {
            var majorCode = '{studentGrants.majorCode}';
            $.post("/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: " t_xg_class ",
            },function (data) {
                addOption(data, "classId", '{studentGrants.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>");
        }*/
        //      学生和培养层次回显
        /*if ('{studentGrants.studentId}' != "") {
            var classId = '{studentGrants.classId}';
            $.post("/studentGrants/getTrainingLevelByClassId",{
                classId:classId
            },function (data) {
                $("#trainingLevel").val(data.showValue);
                $("#trainingLevel").attr("storeValue",data.storeValue);
            })
            $.post("/studentGrants/getStudentByClassId", {
                classId:classId
            },function (data) {
                addOption(data, "studentId", '{studentGrants.studentId}');
            });
        }else {
            $("#studentId").append("<option value='' selected>请选择</option>");
        }*/

    });
    function add() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#studentNumber").val() == "" || $("#studentNumber").val() == undefined || $("#studentNumber").val() == null) {
             swal({
                title: "请填写学籍号！",
                type: "info"
            });
            return;
        }
       /* if(!reg.test($("#studentNumber").val())){
            swal({
                title: "学籍号填写错误，请填写数字！",
                type: "info"
            });
            return;
        }*/
        if ($("#internshipType").val() == "" || $("#internshipType").val() == undefined || $("#internshipType").val() == null) {
            swal({
                title: "请选择实习形式！",
                type: "info"
            });
            return;
        } else if ("3" == $("#internshipType").val()) {
            if ($("#f_tel").val() == "" || $("#f_tel").val() == "0" || $("#f_tel").val() == undefined) {
                swal({
                    title: "请填写学生电话！",
                    type: "info"
                });
                return;
            }
            var phoneNum = /^1\d{10}$/;
            if (phoneNum.test($("#f_tel").val()) === false) {
                swal({
                    title: "学生电话不正确请重新填写！",
                    type: "info"
                });
                return;
            }
            if ($("#f_parentTel").val() == "" || $("#f_parentTel").val() == "0" || $("#f_parentTel").val() == undefined) {
                swal({
                    title: "请填写家长电话！",
                    type: "info"
                });
                return;
            }
            if (phoneNum.test($("#f_parentTel").val()) === false) {
                swal({
                    title: "家长电话不正确请重新填写！",
                    type: "info"
                });
                return;
            }

        } else {
            if ($("#f_tel").val() == "" || $("#f_tel").val() == "0" || $("#f_tel").val() == undefined) {
                swal({
                    title: "请填写学生电话！",
                    type: "info"
                });
                return;
            }
            var phoneNum = /^1\d{10}$/;
            if (phoneNum.test($("#f_tel").val()) === false) {
                swal({
                    title: "学生电话不正确请重新填写！",
                    type: "info"
                });
                return;
            }
            if ($("#f_parentTel").val() == "" || $("#f_parentTel").val() == "0" || $("#f_parentTel").val() == undefined) {
                swal({
                    title: "请填写家长电话！",
                    type: "info"
                });
                return;
            }
            if (phoneNum.test($("#f_parentTel").val()) === false) {
                swal({
                    title: "家长电话不正确请重新填写！",
                    type: "info"
                });
                return;
            }
            if ($("#internshipUnitId option:selected").val() == "") {
               swal({
                    title: "请填写单位名称！",
                    type: "info"
                });
                return;
            }
            if ($("#f_internshipPositions").val() == "" || $("#f_internshipPositions").val() == "0" || $("#f_internshipPositions").val() == undefined) {
               swal({
                    title: "请填写实习岗位！",
                    type: "info"
                });
                return;
            }
            if ($("#f_postsTime").val() == "" || $("#f_postsTime").val() == "0" || $("#f_postsTime").val() == undefined) {
               swal({
                    title: "请填写上岗时间！",
                    type: "info"
                });
                return;
            }
            if ($("#f_internshipScore").val() == "" || $("#f_internshipScore").val() == "0" || $("#f_internshipScore").val() == undefined) {
               swal({
                    title: "请实习学分！",
                    type: "info"
                });
                return;
            }
            if ($("#salary option:selected").val() == "") {
                swal({
                    title: "请填写实习工资！",
                    type: "info"
                });
                return;
            }
            if ($("#majorMatchFlag option:selected").val() == "") {
               swal({
                    title: "请填写是否专业对口！",
                    type: "info"
                });
                return;
            }

        }

        var internshipChangeFlag;
        if($("#internshipType option:selected").val() == '3'){
            $("#f_postsTime").val("");

        }else{
            internshipChangeFlag = 0;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/internshipManage/saveInternshipManage", {
            internshipId: $("#internshipId").val(),
            studentId: $("#studentId option:selected").val(),
            classId: $("#classIdId option:selected").val(),
            sex: $("#sex option:selected").val(),
            idcard: $("#f_idcard").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: $("#majorCodeId option:selected").val(),
            trainingLevel: $("#trainingLevelId option:selected").val(),
            internshipUnitId: $("#internshipUnitId option:selected").val(),
            internshipPositions: $("#f_internshipPositions").val(),
            postsTime: $("#f_postsTime").val(),
            area: $("#f_area").val(),
            internshipType: $("#internshipType option:selected").val(),
            majorMatchFlag: $("#majorMatchFlag option:selected").val(),
            salary: $("#salary option:selected").val(),
            internshipChangeFlag: internshipChangeFlag,
            internshipScore: $("#f_internshipScore").val(),
            internshipEvaluation:$("#finternshipEvaluation").val(),
            tel: $("#f_tel").val(),
            studentNumber: $("#studentNumber").val(),
            parentTel: $("#f_parentTel").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#internshipManageGrid').DataTable().ajax.reload();

            }
        })
    }
        //选择系部后,根据系部id查询下属专业
        function changeEditMajor() {
            var deptId = $("#departmentsId").val();//获取当前选择的系部id
            $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//通过已选择的系部id查询专业
                addOption(data, 'majorCode');
            });
        }
        //选择专业后,根据系部id查询下属班级
        function changeEditClass() {
            var majorCode = $("#majorCode").val();
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: " t_xg_class ",
                where: " WHERE 1 = 1 and major_code = '"+ majorCode +"'" ,
                orderby: " order by create_time desc"
            },function (data) {
                addOption(data, "classId");
            });
        }
        //选择班级后,显示培养层次,查询班内所有学生
        function changeEditClassID() {
            var classId = $("#classId").val();
            $.post("<%=request.getContextPath()%>/studentGrants/getTrainingLevelByClassId",{
                classId:classId
            },function (data) {
                $("#trainingLevel").val(data.showValue);
                $("#trainingLevel").attr("storeValue",data.storeValue);
            })
            $.post("<%=request.getContextPath()%>/studentGrants/getStudentByClassId", {
                classId:classId
            },function (data) {
                addOption(data, "studentId", '${studentGrants.studentId}');
            });
        }

</script>
