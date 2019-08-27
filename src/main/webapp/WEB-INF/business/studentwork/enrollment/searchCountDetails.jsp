<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div class="modal-dialog" style="width: 700px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <input id="studentId" name="studentId" type="hidden" value="${enrollmentstudent.studentId}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-6">
                        <select id="hiddenDid" />
                    </div>


                   </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-6">
                        <select id="hiddenMid" />
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        专业方向
                    </div>
                    <div class="col-md-6">
                        <select id="derection"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        培养层次
                    </div>
                    <div class="col-md-6">
                        <select id="level" ></select>
                    </div>

                </div>



                <div class="form-row">
                    <div class="col-md-2 tar">
                        招生年份
                    </div>
                    <div class="col-md-6">
                        <select id="emyear"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学习形式
                    </div>
                    <div class="col-md-6">
                        <select id="type" ></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        班级数
                    </div>
                    <div class="col-md-6">
                        <input id="amount" value="${enrollment.classAmount}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        计划招生人数
                    </div>
                    <div class="col-md-6">
                        <input id="plan_number" value="${enrollment.planNumber}"></input>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报到人数
                    </div>
                    <div class="col-md-6">
                        <input id="real_number" value="${enrollment.realNumber}"></input>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        主干课程
                    </div>
                    <div class="col-md-6">
                        <input id="course" value="${enrollment.mainCourse}"></input>
                    </div>


                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        合作企业
                    </div>
                    <div class="col-md-6">
                        <input id="enterprise" value="${enrollment.cooperativeEnterprise}"></input>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        技能证书
                    </div>
                    <div class="col-md-6">
                        <input id="ticket" value="${enrollment.skillTicket}"></input>
                    </div>

                </div>


            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>


<input id="departmentsIdValue" type="hidden" value="${enrollment.departmentsId}"/>
<input id="majorCodeValue" type="hidden" value="${enrollment.majorCode}"/>
<input id="trainingLevelValue" type="hidden" value="${enrollment.trainingLevel}"/>
<input id="majorDirectionValue" type="hidden" value="${enrollment.majorDirection}"/>
<input id="trainingLevelValue" type="hidden" value="${enrollment.trainingLevel}"/>
<input id="yearValue" type="hidden" value="${enrollment.year}"/>
<input id="learningTypeValue" type="hidden" value="${enrollment.learningType}"/>

<script>
    $(document).ready(function () {
        $("#ticket").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#enterprise").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#course").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#real_number").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#plan_number").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#amount").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#hiddenDid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenMid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenCid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#learn_system").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#type").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#emyear").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#level").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#derection").attr("disabled","disabled").css("background-color","#2c5c82;");
        //方向
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYFX", function (data) {
            addOption(data, 'derection', $("#majorDirectionValue").val());
        });
        //培养层次
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'level', $("#trainingLevelValue").val());
        });
        //学制
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'learn_system', $("#nationalitySHOW").val());
        });
        //招生年份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, "emyear", $("#yearValue").val());
        });
        //学习形式
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXS", function (data) {
            addOption(data, 'type',$("#learningTypeValue").val());
        });

        //系部回显
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "hiddenDid",$("#departmentsIdValue").val());
            });
        //专业回显
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " major_code || ',' || major_direction  || ',' || training_level",
                text: " major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') ",
                tableName: "T_XG_MAJOR",
                where: "",
                orderby: ""
            },
            function (data) {
                var detailVar=$("#majorCodeValue").val()+","+$("#majorDirectionValue").val()+","+$("#trainingLevelValue").val();
                addOption(data, "hiddenMid",detailVar);
            });


    })

</script>

<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
