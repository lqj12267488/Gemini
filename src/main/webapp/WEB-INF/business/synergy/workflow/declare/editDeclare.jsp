<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog" style="width: 1000px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="declareid" hidden value="${declare.id}">
        </div>
        <div class="modal-body clearfix">
        <%--<form class="modal-body clearfix">--%>
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <form id="dailySignUp">
                <input type="file" name="file" style="display: none" id="imgFile" onchange="fileChange(this)">
               <div class="form-row">
                   <div class="col-md-6" style="padding: 0;">
                       <div class="form-row">
                            <div class="col-md-4 tar"  style="float: left;">
                                申请部门
                            </div>
                            <div class="col-md-8" >
                                <input id="f_requestDept" type="text" readonly="readonly"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${declare.requestDept}" />
                            </div>
                       </div>
                       <div class="form-row">
                            <div class="col-md-4 tar"  style="float: left;">
                                申请人
                            </div>
                            <div class="col-md-8" >
                                <input id="f_requester" type="text" readonly="readonly"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${declare.requester}" />
                            </div>
                       </div>
                       <div class="form-row">
                            <div class="col-md-4 tar"  style="float: left;">
                                申请日期
                            </div>
                            <div class="col-md-8" >
                                <input id="f_requestDate" type="datetime-local"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${declare.requestDate}"/>
                            </div>
                       </div>
                       <div class="form-row">
                            <div class="col-md-4 tar"  style="float: left;">
                                姓名
                            </div>
                            <div class="col-md-8" >
                                <input id="name" type="text" readonly="readonly"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${declare.name}"/>
                            </div>
                       </div>
                   </div>
                   <div style="float: right;width:230px;height: 160px;">
                       <div style="width: 160px;height: 160px;margin-top: -4px;">
                           <c:choose>
                               <c:when test="${declare.img == null}">
                                   <img onclick="showInputFile()"
                                        style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                        src="<%=request.getContextPath()%>/libs/img/upload.png"
                                        height="130"
                                        width="110" alt="" id="userImg">
                               </c:when>
                               <c:otherwise>
                                   <img onclick="showInputFile()"
                                        style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                        src="data:image/png;base64,${declare.img}"
                                        height="130"
                                        width="110" alt="" id="userImg1">
                               </c:otherwise>
                           </c:choose>
                       </div>
                   </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex"
                                class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        民族
                    </div>
                    <div class="col-md-4">
                        <select id="nation"
                                class="validate[required,maxSize[20]] form-control"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birthday" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.birthday}"/>
                    </div>
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-4">
                        <select id="politicalStatus"
                                class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.idcard}"/>
                    </div>
                    <div class="col-md-2 tar">
                        毕业时间
                    </div>
                    <div class="col-md-4">
                        <input id="graduateTime"  type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.graduateTime}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        工作时间
                    </div>
                    <div class="col-md-4">
                        <input id="workTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.workTime}"/>
                    </div>

                    <div class="col-md-2 tar">
                        入职时间
                    </div>
                    <div class="col-md-4">
                        <input id="entryTime"  type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.entryTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        工作部门
                    </div>
                    <div class="col-md-4">
                        <input id="workDept" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.workDept}"/>
                    </div>
                    <div class="col-md-2 tar">
                        行政职务
                    </div>
                    <div class="col-md-4">
                        <input id="administrativePost" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.administrativePost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        现任专业技术职务
                    </div>
                    <div class="col-md-4">
                        <input id="technicalPosition" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.technicalPosition}"/>
                    </div>
                    <div class="col-md-2 tar">
                        任职时间
                    </div>
                    <div class="col-md-4">
                        <input id="appointmentTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.appointmentTime}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        拟申报职称层次
                    </div>
                    <div class="col-md-4">
                        <input id="appliedLevel" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.appliedLevel}"/>
                    </div>
                    <div class="col-md-2 tar">
                        从事专业时间
                    </div>
                    <div class="col-md-4">
                        <input id="majorTime" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.majorTime}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学位
                    </div>
                    <div class="col-md-4">
                        <select id="academicDegree"
                                class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        学历
                    </div>
                    <div class="col-md-4">
                        <select id="educationalLevel"
                                class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        毕业学校
                    </div>
                    <div class="col-md-4">
                        <input id="school"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.school}"/>
                    </div>
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <input id="major"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.major}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职业资格证书类别及获取时间
                    </div>
                    <div class="col-md-4">
                        <input id="acquisitionTime"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.acquisitionTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        参加学术团体及任职
                    </div>
                    <div class="col-md-4">
                        <input id="organizationsPositions"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.organizationsPositions}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学术技术荣誉称号
                    </div>
                    <div class="col-md-4">
                        <input id="academicTechnology"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.academicTechnology}"/>
                    </div>
                    <div class="col-md-2 tar">
                        继续教育证书获取时间
                    </div>
                    <div class="col-md-4">
                        <input id="continuingEducationTime"  type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.continuingEducationTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        通讯地址
                    </div>
                    <div class="col-md-4">
                        <input id="postalAddress"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.postalAddress}"/>
                    </div>
                    <div class="col-md-2 tar">
                        邮政编码
                    </div>
                    <div class="col-md-4">
                        <input id="postCode"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.postCode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        办公电话
                    </div>
                    <div class="col-md-4">
                        <input id="officePhone"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.officePhone}"/>
                    </div>
                    <div class="col-md-2 tar">
                        手机
                    </div>
                    <div class="col-md-4">
                        <input id="tel"  type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.tel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        电子信箱
                    </div>
                    <div class="col-md-4">
                        <input id="email"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.email}"/>
                    </div>
                    <div class="col-md-2 tar">
                        工作年限
                    </div>
                    <div class="col-md-4">
                        <input id="workingSeniority"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.workingSeniority}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职称
                    </div>
                    <div class="col-md-4">
                        <input id="positionalTitles"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.positionalTitles}"/>
                    </div>
                    <div class="col-md-2 tar">
                        现任职务
                    </div>
                    <div class="col-md-4">
                        <input id="presentPost"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.presentPost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        聘任时间
                    </div>
                    <div class="col-md-4">
                        <input id="engageTime"  type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.engageTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        现任岗位
                    </div>
                    <div class="col-md-4">
                        <input id="incumbentPost"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.incumbentPost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        聘任岗位
                    </div>
                    <div class="col-md-4">
                        <input id="appointmentPost"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${declare.appointmentPost}"/>
                    </div>
                    <div class="col-md-2 tar">
                        申报人代表性成果
                    </div>
                    <div class="col-md-4">
                        <textarea id="representativeAchievements"  type="text"
                               class="validate[required,maxSize[20]] form-control">${declare.representativeAchievements}</textarea>
                    </div>
                </div>
                </form>
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
            addOption(data, 'sex', '${declare.sex}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'nation', '${declare.nation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, 'politicalStatus', '${declare.politicalStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'academicDegree', '${declare.academicDegree}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'educationalLevel', '${declare.educationalLevel}');
        });
    })
    function fileChange(target) {
        var file = target;
        var img = document.getElementById("userImg");
        var reader = new FileReader();
        reader.onload = function (evt) {
            img.src = evt.target.result;
        };
        reader.readAsDataURL(file.files[0]);
    }

    function showInputFile() {
        $("#imgFile").click();
    }
    function saveDept() {
        var c_requestDate = $("#f_requestDate").val().replace('T',' ');
        /*
          $.post("
        <%=request.getContextPath()%>/declare/saveDeclare", {
            id: $("#declareid").val(),
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate: c_requestDate,
            name: $("#name").val(),
            sex: $("#sex option:selected").val(),
            nation: $("#nation option:selected").val(),
            birthday: $("#birthday").val(),
            politicalStatus: $("#politicalStatus option:selected").val(),
            idcard: $("#idcard").val(),
            workTime: $("#workTime").val(),
            workDept: $("#workDept").val(),
            administrativePost: $("#administrativePost").val(),
            technicalPosition: $("#technicalPosition").val(),
            appointmentTime: $("#appointmentTime").val(),
            appliedLevel: $("#appliedLevel").val(),
            majorTime: $("#majorTime").val(),
            academicDegree: $("#academicDegree option:selected").val(),
            educationalLevel: $("#educationalLevel option:selected").val(),
            school: $("#school").val(),
            major: $("#major").val(),
            entryTime: $("#entryTime").val(),
            graduateTime: $("#graduateTime").val(),
            acquisitionTime: $("#acquisitionTime").val(),
            organizationsPositions: $("#organizationsPositions").val(),
            academicTechnology: $("#academicTechnology").val(),
            continuingEducationTime: $("#continuingEducationTime").val(),
            postalAddress: $("#postalAddress").val(),
            postCode: $("#postCode").val(),
            officePhone: $("#officePhone").val(),
            tel: $("#tel").val(),
            email: $("#email").val(),
            workingSeniority: $("#workingSeniority").val(),
            positionalTitles: $("#positionalTitles").val(),
            presentPost: $("#presentPost").val(),
            engageTime: $("#engageTime").val(),
            incumbentPost: $("#incumbentPost").val(),
            appointmentPost: $("#appointmentPost").val(),
            representativeAchievements: $("#representativeAchievements").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#declare').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }*/
        var formData = new FormData(document.getElementById("dailySignUp"));
        formData.append("id", $("#declareid").val());
        formData.append("requestDept", $("#f_requestDept").val());
        formData.append("requester", $("#f_requester").val());
        formData.append("requestDate", c_requestDate);
        formData.append("name", $("#name").val());
        formData.append("sex", $("#sex option:selected").val());
        formData.append("nation", $("#nation option:selected").val());
        formData.append("birthday", $("#birthday").val());
        formData.append("politicalStatus", $("#politicalStatus option:selected").val());
        formData.append("idcard", $("#idcard").val());
        formData.append("workTime", $("#workTime").val());
        formData.append("workDept", $("#workDept").val());
        formData.append("administrativePost", $("#administrativePost").val());
        formData.append("technicalPosition", $("#technicalPosition").val());
        formData.append("appointmentTime", $("#appointmentTime").val());
        formData.append("appliedLevel", $("#appliedLevel").val());
        formData.append("majorTime", $("#majorTime").val());
        formData.append("academicDegree", $("#academicDegree option:selected").val());
        formData.append("educationalLevel", $("#educationalLevel option:selected").val());
        formData.append("school", $("#school").val());
        formData.append("major", $("#major").val());
        formData.append("entryTime", $("#entryTime").val());
        formData.append("graduateTime", $("#graduateTime").val());
        formData.append("acquisitionTime", $("#acquisitionTime").val());
        formData.append("organizationsPositions", $("#organizationsPositions").val());
        formData.append("academicTechnology", $("#academicTechnology").val());
        formData.append("continuingEducationTime", $("#continuingEducationTime").val());
        formData.append("postalAddress", $("#postalAddress").val());
        formData.append("postCode", $("#postCode").val());
        formData.append("officePhone", $("#officePhone").val());
        formData.append("tel", $("#tel").val());
        formData.append("email", $("#email").val());
        formData.append("workingSeniority", $("#workingSeniority").val());
        formData.append("positionalTitles", $("#positionalTitles").val());
        formData.append("presentPost", $("#presentPost").val());
        formData.append("engageTime", $("#engageTime").val());
        formData.append("incumbentPost", $("#incumbentPost").val());
        formData.append("appointmentPost", $("#appointmentPost").val());
        formData.append("representativeAchievements", $("#representativeAchievements").val());
        $.ajax({
            url: "<%=request.getContextPath()%>/declare/saveDeclare",
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
                    $('#declare').DataTable().ajax.reload();
                } else {
                    swal({
                        title: msg.msg,
                        type: "error"
                    });
                    $("#dialog").modal('hide');
                    $('#declare').DataTable().ajax.reload();
                }
            }
        });
    }
</script>

