<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:17
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
            <input id="employmentId" hidden value="${employmentManage.employmentId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学籍号
                    </div>
                    <div class="col-md-4">
                        <input id="studentNumber" type="text" value="${employmentManage.studentNumber}" readonly="readonly" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  就业形式
                    </div>
                    <div class="col-md-4">
                        <select id="employmentType" onchange="hideOtherProperty()"/>
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
                        培养层次
                    </div>
                    <div class="col-md-4">
                        <select readonly id="trainingLevelId"  disabled="disabled" type="text" class="js-example-basic-single" ></select>
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
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" disabled="disabled" type="text" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" class="js-example-basic-single" disabled="disabled"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  学生电话
                    </div>
                    <div class="col-md-4">
                        <input id="f_tel" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employmentManage.tel}"/>
                    </div>
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="f_idcard" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employmentManage.idcard}"/>
                    </div>
                </div>

                <div class="form-row" id="s_employmentUnitId">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  就业单位
                    </div>
                    <div class="col-md-4">
                        <select id="employmentUnitId" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  就业岗位
                    </div>
                    <div class="col-md-4">
                        <input id="f_employmentPositions" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employmentManage.employmentPositions}" />
                    </div>
                </div>
                <div class="form-row" id="s_employmentYear">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 上岗时间
                    </div>
                    <div class="col-md-4">
                        <input id="f_employmentYear" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${employmentManage.employmentYear}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 地区
                    </div>
                    <div class="col-md-4">
                        <input id="f_area" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employmentManage.area}" />
                    </div>
                </div>
                <div class="form-row" id="s_salary">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  工资
                    </div>
                    <div class="col-md-4">
                        <select id="salary" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 专业对口否
                    </div>
                    <div class="col-md-4">
                        <select id="majorMatchFlag" />
                    </div>
                </div>
                <div class="form-row" id="s_signContract">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 签订合同否
                    </div>
                    <div class="col-md-4">
                        <select id="signContract" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  保险类型
                    </div>
                    <div class="col-md-4">
                        <select id="employmentInsuranceType" />
                    </div>
                </div>
                <div class="form-row" id="s_employmentSatisfaction">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 就业满意度
                    </div>
                    <div class="col-md-4">
                        <select id="employmentSatisfaction" />
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	 class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="departmentsIdShow" hidden value="${employmentManage.departmentsId}">
<input id="studentIdShow" hidden value="${employmentManage.studentId}">
<input id="sexShow" hidden value="${employmentManage.sex}">
<input id="classIdShow" hidden value="${employmentManage.classId}">
<input id="employmentUnitIdShow" hidden value="${employmentManage.employmentUnitId}">
<input id="majorCodeShow" hidden value="${employmentManage.majorCode}">
<input id="employmentTypeShow" hidden value="${employmentManage.employmentType}">
<input id="majorMatchFlagShow" hidden value="${employmentManage.majorMatchFlag}">
<input id="salaryShow" hidden value="${employmentManage.salary}">
<input id="trainingLevelShow" hidden value="${employmentManage.trainingLevel}">
<input id="signContractShow" hidden value="${employmentManage.signContract}">
<input id="employmentInsuranceTypeShow" hidden value="${employmentManage.employmentInsuranceType}">
<input id="employmentSatisfactionShow" hidden value="${employmentManage.employmentSatisfaction}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
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
                    }
                })
        }
    });
    function hideOtherProperty() {
        var typeId = $("#employmentType").val();
        if ("3" == typeId) {
            $("#s_employmentUnitId").hide();
            $("#s_employmentYear").hide();
            $("#s_salary").hide();
            $("#s_signContract").hide();
            $("#s_employmentSatisfaction").hide();

        } else {
            $("#s_employmentUnitId").show();
            $("#s_employmentYear").show();
            $("#s_salary").show();
            $("#s_signContract").show();
            $("#s_employmentSatisfaction").show();
        }

    }
    $("#employmentUnitId").blur(function () {
        if($("#employmentUnitId").val() != ""){
            $.get("<%=request.getContextPath()%>/employmentManage/selectEmploymentArea?employmentUnitId="+$("#employmentUnitId").val(),
                function (String) {
                    $("#f_area").val(decodeURI(decodeURI(String)));
                })
        }
    });
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: "employment_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_EMPLOYMENT_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "employmentUnitId", $("#employmentUnitIdShow").val());
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
            addOption(data, 'employmentType', $("#employmentTypeShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'majorMatchFlag', $("#majorMatchFlagShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', $("#sexShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'signContract', $("#signContractShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYBXXZ", function (data) {
            addOption(data, 'employmentInsuranceType', $("#employmentInsuranceTypeShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYMYD", function (data) {
            addOption(data, 'employmentSatisfaction', $("#employmentSatisfactionShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${employmentManage.departmentsId}');
        });
        //      专业回显
        if ('{employmentManage.majorCode}' != "") {//判断需要回显的专业Code是否为空
            var deptId = '{employmentManage.departmentsId}';//获取回显的系部id
            $.get("/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//通过系部id查询专业id和名称
                addOption(data, 'majorCode', '{employmentManage.majorCode}');//将回显的专业id通过下拉选项转换为专业名称
            });
        } else {//如果回显专业为空,下拉列表显示请选择
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }
        //       班级回显
        if ('{employmentManage.classId}' != "") {
            var majorCode = '{employmentManage.majorCode}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: " t_xg_class ",
                where: " WHERE 1 = 1 and major_code = '"+ majorCode +"'" ,
                orderby: " order by create_time desc"
            },function (data) {
                addOption(data, "classId", '{employmentManage.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>");
        }
        //      学生和培养层次回显
        if ('{employmentManage.studentId}' != "") {
            var classId = '{employmentManage.classId}';
            $.post("<%=request.getContextPath()%>/studentGrants/getTrainingLevelByClassId",{
                classId:classId
            },function (data) {
                $("#trainingLevel").val(data.showValue);
                $("#trainingLevel").attr("storeValue",data.storeValue);
            })
            $.post("<%=request.getContextPath()%>/studentGrants/getStudentByClassId", {
                classId:classId
            },function (data) {
                addOption(data, "studentId", '{employmentManage.studentId}');
            });
        }else {
            $("#studentId").append("<option value='' selected>请选择</option>");
        }
        /*$("#studentId").blur(function () {
         if($("#studentId option:selected").val()!=""){
         $.get("/student/getStudentByStudentId?studentId="+$("#studentId option:selected").val(),
         function (data) {
         if(data!= null){
         console.log(data);
         console.log(data.idcard);
         console.log(data.sex);
         $("#f_idcard").val(data.idcard);
         $("#sex").val(data.sex);

         }
         })
         }
         });*/
    });





    function add() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#studentNumber").val() == ""|| $("#f_idcard").val() == "0" || $("#f_idcard").val() == undefined) {
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
        if ($("#employmentType").val() == "" || $("#employmentType").val() == undefined || $("#employmentType").val() == null) {
            swal({
                title: "请选择就业形式！",
                type: "info"
            });
            return;
        } else if ("3" == $("#employmentType").val()) {
            if ($("#f_tel").val()== "" || $("#f_tel").val() == undefined || $("#f_tel").val() == null) {
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
        } else {
            if ($("#f_tel").val()== "" || $("#f_tel").val() == undefined || $("#f_tel").val() == null) {
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
            /*if ($("#departmentsId option:selected").val() == "") {
                swal({
                    title: "请填写实习工资！",
                    type: "info"
                });
                return;
            }*/
            if ($("#employmentUnitId option:selected").val() == "") {
                swal({
                    title: "请选择就业单位！",
                    type: "info"
                });
                return;
            }
            if ($("#f_employmentPositions").val() == "" || $("#f_employmentPositions").val() == "0" || $("#f_employmentPositions").val() == undefined) {
                swal({
                    title: "请填写就业岗位！",
                    type: "info"
                });
                return;
            }
            if ($("#f_employmentYear").val() == "" || $("#f_employmentYear").val() == "0" || $("#f_employmentYear").val() == undefined) {
                swal({
                    title: "请填写上岗时间！",
                    type: "info"
                });
                return;
            }
            if ($("#f_area").val() == "" || $("#f_area").val() == "0" || $("#f_area").val() == undefined) {
                swal({
                    title: "请填写地区！",
                    type: "info"
                });
                return;
            }

            if ($("#salary option:selected").val() == "") {
                swal({
                    title: "请选择就业工资！",
                    type: "info"
                });
                return;
            }
            if ($("#majorMatchFlag option:selected").val() == "") {
                swal({
                    title: "请选择是否签订合同！",
                    type: "info"
                });
                return;
            }
            if ($("#signContract option:selected").val() == "") {
                swal({
                    title: "请选择是否专业对口！",
                    type: "info"
                });
                return;
            }
            if ($("#employmentInsuranceType option:selected").val() == "") {
                swal({
                    title: "请选择就业保险类型！",
                    type: "info"
                });
                return;
            }
            if ($("#employmentSatisfaction option:selected").val() == "") {
                swal({
                    title: "请选择就业满意度！",
                    type: "info"
                });
                return;
            }
        }
        if($("#employmentType option:selected").val() == '3'){
            $("#f_employmentYear").val("");

        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/employmentManage/saveEmploymentManage", {
            employmentId:$("#employmentId").val(),
            studentId:$("#studentId option:selected").val(),
            classId: $("#classIdId option:selected").val(),
            sex: $("#sex option:selected").val(),
            idcard: $("#f_idcard").val(),
            departmentsId: $("#departmentsId option:selected").val(),
            majorCode: $("#majorCodeId option:selected").val(),
            trainingLevel: $("#trainingLevelId option:selected").val(),
            employmentUnitId:  $("#employmentUnitId option:selected").val(),
            employmentPositions: $("#f_employmentPositions").val(),
            employmentYear: $("#f_employmentYear").val(),
            area: $("#f_area").val(),
            employmentType: $("#employmentType option:selected").val(),
            majorMatchFlag: $("#majorMatchFlag option:selected").val(),
            salary: $("#salary option:selected").val(),
            tel: $("#f_tel").val(),
            signContract:$("#signContract option:selected").val(),
            employmentInsuranceType:$("#employmentInsuranceType option:selected").val(),
            employmentSatisfaction:$("#employmentSatisfaction option:selected").val(),
            studentNumber:$("#studentNumber").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#employmentManageGrid').DataTable().ajax.reload();

            }
        })
    }
    //选择系部后,根据系部id查询下属专业
    /*function changeEditMajor() {
     var deptId = $("#departmentsId").val();//获取当前选择的系部id
     $.get("/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//通过已选择的系部id查询专业
     addOption(data, 'majorCode');
     });
     }*/
    //选择专业后,根据系部id查询下属班级
    /* function changeEditClass() {
     var majorCode = $("#majorCode").val();
     $.post("/common/getTableDict", {
     id: " class_id",
     text: " class_name ",
     tableName: " t_xg_class ",
     where: " WHERE 1 = 1 and major_code = '"+ majorCode +"'" ,
     orderby: " order by create_time desc"
     },function (data) {
     addOption(data, "classId");
     });
     }*/
    //选择班级后,显示培养层次,查询班内所有学生
    function changeEditClassID() {
        var classId = $("#classId").val();
        $.post("/studentGrants/getTrainingLevelByClassId",{
            classId:classId
        },function (data) {
            $("#trainingLevel").val(data.showValue);
            $("#trainingLevel").attr("storeValue",data.storeValue);
        })
        $.post("/studentGrants/getStudentByClassId", {
            classId:classId
        },function (data) {
            addOption(data, "studentId", '${employmentManage.studentId}');
        });
    }

</script>
