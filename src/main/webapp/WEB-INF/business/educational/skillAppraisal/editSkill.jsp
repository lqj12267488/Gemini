<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="skillid" hidden value="${skill.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="s_major" onchange="changeMajorId()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        班级
                    </div>
                    <div class="col-md-9">
                        <select id="f_grade"  onchange="changeClassId()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        姓名
                    </div>
                    <div class="col-md-9">
                            <select id="s_studentName"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        入学时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_entranceDate" type="month"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.entranceDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学制
                    </div>
                    <div class="col-md-9">
                     <%--   <input id="f_schoolSystem" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.schoolSystem}" />--%>
                        <select id="f_schoolSystem" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        项目名称
                    </div>
                    <div class="col-md-9">
                        <select id="f_preAppProfession"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        级别
                    </div>
                    <div class="col-md-9">
                        <input id="f_level" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.professionLevel}" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        拟鉴定时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_preAppDate" type="date"
                               class="validate[required,maxSize[100]] form-control"
                               value="${skill.preAppDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        项目级别
                    </div>
                    <div class="col-md-9">
                        <input id="projectLevel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.projectLevel}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        发证机关
                    </div>
                    <div class="col-md-9">
                        <input id="issuingOffice" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.issuingOffice}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveSkillAppraisal()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input hidden id="grade" value="${skill.grade}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name",
                tableName: "t_xg_major",
                where: "  ",
                orderby: " "
            }, function (data) {
                addOption(data, "s_major",'${skill.major}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.class_id ",
                text: " t.class_name ",
                tableName: "  t_xg_class t ",
                where: "  WHERE t.major_code = '${skill.major}' ",
                orderby: "   "
            },
            function (data) {
                addOption(data, "f_grade",'${skill.grade}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.STUDENT_ID ",
                text: " t.NAME ",
                tableName: "  T_XG_STUDENT t ",
                where: "  WHERE t.class_name = '${skill.grade}' ",
                orderby: "   "
            },
            function (data) {
                addOption(data, "s_studentName");
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"ID",
            text:"PROJECT_NAME",
            tableName:"T_JW_SKILL",
            where:"WHERE VALID_FLAG = 1 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_preAppProfession','${skill.preAppProfession}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'f_schoolSystem','${skill.schoolSystem}');
        })
        $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#grade").val(), function (data) {
            addOption(data, "s_studentName",'${skill.studentName}');
        })
    })

    function changeMajorId() {
        var majorCodeList = $("#s_major option:selected").val();
        var mCList = majorCodeList.split(",");
        var majorCode = mCList[0];
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.class_id ",
                text: " t.class_name ",
                tableName: "  t_xg_class t ",
                where: "  WHERE t.major_code = '"+majorCode+"'" ,
                orderby: "   "
            },
            function (data) {
                addOption(data, "f_grade");
            });
    }

    function changeClassId() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " s.STUDENT_ID ",
                text: " FUNC_GET_TABLEVALUE(\n" +
                    "                          s.STUDENT_ID,\n" +
                    "                  'T_XG_STUDENT t',\n" +
                    "                  'STUDENT_ID',\n" +
                    "                  'NAME') ",
                tableName: "  T_XG_STUDENT_CLASS s ",
                where: "  WHERE s.class_id= '"+$("#f_grade").val()+"'" ,
                orderby: "   "
            },
            function (data) {
                addOption(data, "s_studentName");
            });
    }

    function saveSkillAppraisal() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#s_major").val() == "" || $("#s_major").val() == "0" || $("#s_major").val() == undefined) {
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        if ($("#f_grade").val() == "" || $("#f_grade").val() == "0" || $("#f_grade").val() == undefined) {
            swal({
                title: "请填写班级！",
                type: "info"
            });
            return;
        }
        if ($("#s_studentName").val() == "" || $("#s_studentName").val() == "0" || $("#s_studentName").val() == undefined) {
            swal({
                title: "请填写姓名！",
                type: "info"
            });
            return;
        }
        if ($("#f_entranceDate").val() == "" || $("#f_entranceDate").val() == "0" || $("#f_entranceDate").val() == undefined) {
            swal({
                title: "请填写入学时间！",
                type: "info"
            });
            return;
        }

        if ($("#f_schoolSystem").val() == "" || $("#f_schoolSystem").val() == "0" || $("#f_schoolSystem").val() == undefined) {
            swal({
                title: "请填写学制！",
                type: "info"
            });
            return;
        }


        if ($("#f_preAppProfession").val() == "" || $("#f_preAppProfession").val() == "0" || $("#f_preAppProfession").val() == undefined) {
            swal({
                title: "请选择项目名称！",
                type: "info"
            });
            return;
        }

        if ($("#f_level").val() == "" || $("#f_level").val() == "0" || $("#f_level").val() == undefined) {
            swal({
                title: "请填写级别！",
                type: "info"
            });
            return;
        }

        if ($("#f_preAppDate").val() == "" || $("#f_preAppDate").val() == "0" || $("#f_preAppDate").val() == undefined) {
            swal({
                title: "请填写拟鉴定时间！",
                type: "info"
            });
            return;
        }
        if ($("#projectLevel").val() == "" || $("#projectLevel").val() == "0" || $("#projectLevel").val() == undefined) {
            swal({
                title: "请填写项目级别！",
                type: "info"
            });
            return;
        }
        if ($("#issuingOffice").val() == "" || $("#issuingOffice").val() == "0" || $("#issuingOffice").val() == undefined) {
            swal({
                title: "请填写发证机关！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/skillAppraisal/saveSkillAppraisal", {
            id: $("#skillid").val(),
            major: $("#s_major").val(),
            grade: $("#f_grade").val(),
            entranceDate: $("#f_entranceDate").val(),
            schoolSystem: $("#f_schoolSystem").val(),
            preAppProfession: $("#f_preAppProfession").val(),
            professionLevel: $("#f_level").val(),
            studentName: $("#s_studentName").val(),
            preAppDate: $("#f_preAppDate").val(),
            projectLevel:$("#projectLevel").val(),
            issuingOffice:$("#issuingOffice").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#skill').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

