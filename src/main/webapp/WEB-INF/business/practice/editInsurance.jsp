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
            <input id="insuranceid" hidden value="${insurance.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="f_departmentId" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="f_majorId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        班级
                    </div>
                    <div class="col-md-9">
                        <select id="f_classId"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        姓名
                    </div>
                    <div class="col-md-9">
                        <select id="f_name"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        性别
                    </div>
                    <div class="col-md-9">
                        <select id="f_sex" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        身份证号
                    </div>
                    <div class="col-md-9">
                        <input id="f_idcard" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${insurance.idcard}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        保险单号
                    </div>
                    <div class="col-md-9">
                        <input id="f_insuranceNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${insurance.insuranceNumber}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'f_sex','${insurance.sex}');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_departmentId','${insurance.departmentsId}');
        });
        $("#f_departmentId").change(function () {
            if($("#f_departmentId").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#f_departmentId").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_majorId');
                });
            }
        })

        if("" != '${insurance.majorCode}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_majorId','${insurance.majorCode}');
                });
        }

        $("#f_majorId").change(function () {
            if($("#f_majorId").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"CLASS_ID",
                    text:"CLASS_NAME",
                    tableName:"T_XG_CLASS",
                    where:"WHERE departments_id = '" + $("#f_departmentId").val() +"' AND major_code = '" + $("#f_majorId").val() +"'",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_classId');
                });
            }
        })

        if("" != '${insurance.classId}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"CLASS_ID",
                    text:"CLASS_NAME",
                    tableName:"T_XG_CLASS",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_classId','${insurance.classId}');
                });
        }

        $("#f_classId").change(function () {
            if($("#f_classId").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"STUDENT_ID",
                    text:" FUNC_GET_TABLEVALUE(STUDENT_ID,'T_XG_STUDENT','STUDENT_ID','NAME') ",
                    tableName:"T_XG_STUDENT_CLASS",
                    where:"WHERE class_id = '" + $("#f_classId").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_name');
                });
            }
        })
        if("" != '${insurance.name}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"STUDENT_ID",
                    text:"FUNC_GET_TABLEVALUE(STUDENT_ID,'T_XG_STUDENT','STUDENT_ID','NAME')",
                    tableName:"T_XG_STUDENT_CLASS",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_name','${insurance.name}');
                });
        }


        $("#f_name").change(function () {
            if($("#f_name").val()!=""){
                $("#f_idcard").val($("#f_name").val());
            }
        });

    })

    function saveDept() {

        if ($("#f_departmentId").val() == "" || $("#f_departmentId").val() == "0" || $("#f_departmentId").val() == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#f_majorId").val() == "" || $("#f_majorId").val() == "0" || $("#f_majorId").val() == undefined) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if ($("#f_classId").val() == "" || $("#f_classId").val() == "0" || $("#f_classId").val() == undefined) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if ($("#f_name").val() == "" || $("#f_name").val() == "0") {
            swal({
                title: "请填写选择学生姓名！",
                type: "info"
            });
            return;
        }
        if ($("#f_sex").val() == "" || $("#f_sex").val() == "0") {
            swal({
                title: "请选择性别！",
                type: "info"
            });
            return;
        }
        if ($("#f_idcard").val() == "" || $("#f_idcard").val() == "0" || $("#f_idcard").val() == undefined) {
            swal({
                title: "请填写身份证号！",
                type: "info"
            });
            return;
        }
        var reg2 = /^[0-9]+.?[0-9]*$/;
        if( $("#f_insuranceNumber").val() == "" || $("#f_insuranceNumber").val() == "0" || $("#f_insuranceNumber").val() == undefined){
            swal({
                title: "请填写保险单号！",
                type: "info"
            });
            return;
        }
        if(!reg2.test($("#f_insuranceNumber").val())){
            swal({
                title: "保险单号请填写数字！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/insurance/saveInsurance", {
            id: $("#insuranceid").val(),
            departmentsId: $("#f_departmentId").val(),
            majorCode: $("#f_majorId").val(),
            classId: $("#f_classId").val(),
            name: $("#f_name").val(),
            sex: $("#f_sex").val(),
            idcard : $("#f_idcard").val(),
            insuranceNumber: $("#f_insuranceNumber").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#insurance').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

