<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    select {
        -webkit-appearance: none;
        -webkit-tap-highlight-color: #fff;
        outline: 0;
    }

</style>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>

        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <form id="dailySignUp" >
                    <input id="studentReissueid" hidden value="${studentReissue.id}">
                    <input type="file" name="file" style="display: none" id="imgFile" onchange="fileChange(this)">
                    <div class="form-row">
                        <div class="col-md-3 tar" style="float: left;">
                            申请时间
                        </div>
                        <div class="col-md-4" style="margin-top: 4px;">
                            <input id="f_requestDate" type="datetime-local" readonly="readonly"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${studentReissue.requestDate}"/>
                        </div>
                        <div style="float: right;width: 230px;height: 160px;">
                            <div style="width: 160px;height: 160px;margin-top: -4px;">
                        <c:choose>
                            <c:when test="${studentReissue.img == null}">
                                <img onclick="showInputFile()"
                                     style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                     src="<%=request.getContextPath()%>/libs/img/upload.png"
                                     height="150"
                                     width="110" alt="" id="userImg">
                            </c:when>
                            <c:otherwise>
                                <img onclick="showInputFile()"
                                     style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                     src="data:image/png;base64,${studentReissue.img}"
                                     height="150"
                                     width="110" alt="" id="userImg">
                            </c:otherwise>
                        </c:choose>
                            </div>
                        </div>
                        <div class="col-md-3 tar" style="float: left;">
                            学生姓名
                        </div>
                        <div class="col-md-4" style="margin-top: 4px;">
                            <select id="studentId" disabled="disabled"
                                    class="validate[required,maxSize[100]] form-control"></select>
                        </div>
                        <div class="col-md-3 tar" style="float: left;">
                            民族
                        </div>
                        <div class="col-md-4" style="margin-top: 4px;">
                            <select id="f_nation" disabled="disabled"
                                    class="validate[required,maxSize[100]] form-control"></select>
                        </div>
                        <div class="col-md-3 tar" style="float: left;">
                            性别
                        </div>
                        <div class="col-md-4" style="margin-top: 4px;">
                            <select id="f_sex" disabled="disabled"
                                    class="validate[required,maxSize[100]] form-control"></select>
                        </div>
                        <div class="col-md-3 tar" style="float: left;">
                            班级
                        </div>
                        <div class="col-md-4" style="margin-top: 4px;">
                            <select id="classIdId" type="text" disabled="disabled"
                                    class="validate[required,maxSize[100]] form-control"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            专业
                        </div>
                        <div class="col-md-9">
                            <select id="majorCodeId" type="text" disabled="disabled" readonly
                                    class="validate[required,maxSize[100]] form-control"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            学号
                        </div>
                        <div class="col-md-9">
                            <input id="studentNumber" type="text" readonly="readonly"
                                   value="${studentReissue.studentNumber}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            身份证号
                        </div>
                        <div class="col-md-9">
                            <input id="f_idcard" type="text" readonly="readonly" value="${studentReissue.idcard}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>乘车区间
                        </div>
                        <div class="col-md-9">
                            <input id="f_rideZone" maxlength="100" placeholder="最多输入100个字"
                                   style="resize:none;" value="${studentReissue.rideZone}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>家庭地址
                        </div>
                        <div class="col-md-9">
                            <input id="f_familyAddress" maxlength="100" placeholder="最多输入100个字"
                                   style="resize:none;" value="${studentReissue.familyAddress}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>新疆省
                        </div>
                        <div class="col-md-9">
                            <select id="houseProvince" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>地区（州）
                        </div>
                        <div class="col-md-9">
                            <select id="houseCity" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>市（县）
                        </div>
                        <div class="col-md-9">
                            <select id="houseCounty" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>申请项目
                        </div>
                        <div class="col-md-9">
                            <select id="f_requestProject" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>申请理由
                        </div>
                        <div class="col-md-9">
                            <input id="f_requestReason" maxlength="100" placeholder="最多输入100个字"
                                   style="resize:none;" value="${studentReissue.requestReason}"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="houseProvinceValue" type="hidden" value="${studentReissue.province}"/>
<input id="houseCityValue" type="hidden" value="${studentReissue.regional}"/>
<input id="houseCountyValue" type="hidden" value="${studentReissue.city}"/>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var path = "<%=request.getContextPath()%>";
        addAdministrativeDivisions("houseProvince", $("#houseProvinceValue").val(),
            "houseCity", $("#houseCityValue").val(),
            "houseCounty", $("#houseCountyValue").val(), path);
        //性别
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'f_sex', '${studentReissue.sex}');
        });
        //民族
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'f_nation', '${studentReissue.nation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SQXM", function (data) {
            addOption(data, 'f_requestProject', '${studentReissue.requestProject}');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                addOption(data, "majorCodeId", '${studentReissue.majorCode}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " name ",
                tableName: "t_xg_student",
            },
            function (data) {
                addOption(data, "studentId", '${studentReissue.studentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: "t_xg_class"
            },
            function (data) {
                addOption(data, "classIdId", '${studentReissue.classId}');
            });
    })

    function showInputFile() {
        $("#imgFile").click();
    }

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#imgFile").val() == "" || $("#imgFile").val() == "0" || $("#imgFile").val() == undefined) {
            alert("请上传头像");
            return;
        }
        if ($("#f_rideZone").val() == "" || $("#f_rideZone").val() == undefined) {
            swal({
                title: "请填写乘车区间",
                type: "info"
            });
            return;
        }
        if ($("#f_familyAddress").val() == "" || $("#f_familyAddress").val() == undefined) {
            swal({
                title: "请填写家庭地址",
                type: "info"
            });
            return;
        }
        if ($("#houseProvince").val() == "" || $("#houseProvince").val() == undefined) {
            swal({
                title: "请选择新疆省",
                type: "info"
            });
            return;
        }
        if ($("#houseCity").val() == "" || $("#houseCity").val() == undefined) {
            swal({
                title: "请选择地区（州）",
                type: "info"
            });
            return;
        }
        if ($("#houseCounty").val() == "" || $("#houseCounty").val() == undefined) {
            swal({
                title: "请选择市（县）",
                type: "info"
            });
            return;
        }
        if ($("#f_requestProject").val() == "" || $("#f_requestProject").val() == undefined) {
            swal({
                title: "请选择申请项目",
                type: "info"
            });
            return;
        }
        if ($("#f_requestReason").val() == "" || $("#f_requestReason").val() == undefined) {
            swal({
                title: "请选择申请理由",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        var formData = new FormData(document.getElementById("dailySignUp"));
        formData.append("id", $("#studentReissueid").val());
        formData.append("requestDate", date);
        formData.append("proveReason", $("#f_proveReason").val());
        formData.append("receiveCompany", $("#f_receiveCompany").val());
        formData.append("studentId", $("#studentId option:selected").val());
        formData.append("classId", $("#classIdId option:selected").val());
        formData.append("majorCode", $("#majorCodeId option:selected").val());
        formData.append("studentNumber", $("#studentNumber").val());
        formData.append("nation", $("#f_nation").val());
        formData.append("sex", $("#f_sex").val());
        formData.append("idcard", $("#f_idcard").val());
        formData.append("rideZone", $("#f_rideZone").val());
        formData.append("familyAddress", $("#f_familyAddress").val());
        formData.append("province", $("#houseProvince").val());
        formData.append("regional", $("#houseCity").val());
        formData.append("city", $("#houseCounty").val());
        formData.append("requestProject", $("#f_requestProject").val());
        formData.append("requestReason", $("#f_requestReason").val());
        $.ajax({
            url: "<%=request.getContextPath()%>/studentReissue/saveStudentReissue",
            type: 'POST',
            cache: false,
            data: formData,
            async: true,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal('hide');
                    $('#studentReissueGrid').DataTable().ajax.reload();
                } else {
                    swal({
                        title: msg.msg,
                        type: "error"
                    });
                    $("#dialog").modal('hide');
                    $('#studentReissueGrid').DataTable().ajax.reload();
                }
            }
        });
    }

    function fileChange(target) {
        var file = target;
        var img = document.getElementById("userImg");
        var reader = new FileReader();
        reader.onload = function (evt) {
            img.src = evt.target.result;
        };
        reader.readAsDataURL(file.files[0]);
    }

</script>

