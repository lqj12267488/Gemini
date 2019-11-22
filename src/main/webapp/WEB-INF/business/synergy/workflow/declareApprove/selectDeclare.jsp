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
            <input id="declareApproveid" hidden value="${declareApprove.id}">
        </div>
        <div class="modal-body clearfix">
            <%--<form class="modal-body clearfix">--%>
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <form id="dailySignUp">
                    <input type="file" name="file" style="display: none" id="imgFile" onchange="fileChange(this)">
                    <div class="form-row">
                        <div class="col-md-6" style="padding: 0;">
                            <div class="form-row">
                                <div class="col-md-4 tar" style="float: left;">
                                    申请部门
                                </div>
                                <div class="col-md-8">
                                    <input id="f_requestDept" type="text" readonly="readonly"
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${declareApprove.requestDept}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-4 tar" style="float: left;">
                                    申请人
                                </div>
                                <div class="col-md-8">
                                    <input id="f_requester" type="text" readonly="readonly"
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${declareApprove.requester}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-4 tar" style="float: left;">
                                    申请日期
                                </div>
                                <div class="col-md-8">
                                    <input id="f_requestDate" type="datetime-local" readonly="readonly"
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${declareApprove.requestDate}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-4 tar" style="float: left;">
                                    姓名
                                </div>
                                <div class="col-md-8">
                                    <input id="name" type="text" readonly="readonly"
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${declareApprove.name}"/>
                                </div>
                            </div>
                        </div>
                        <div style="float: right;width:230px;height: 160px;">
                            <div style="width: 160px;height: 160px;margin-top: -4px;">
                                <c:choose>
                                    <c:when test="${declareApprove.img == null}">
                                        <img onclick="showInputFile()"
                                             style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                             src="<%=request.getContextPath()%>/libs/img/upload.png"
                                             height="130"
                                             width="110" alt="" id="userImg">
                                    </c:when>
                                    <c:otherwise>
                                        <img onclick="showInputFile()"
                                             style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                                             src="data:image/png;base64,${declareApprove.img}"
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
                            <input id="sex" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.academicDegree}"/>
                        </div>
                        <div class="col-md-2 tar">
                            出生日期
                        </div>
                        <div class="col-md-4">
                            <input id="birthday" type="date" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.birthday}"/>
                        </div>

                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            入职时间
                        </div>
                        <div class="col-md-4">
                            <input id="entryTime" type="date" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.entryTime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            工作部门
                        </div>
                        <div class="col-md-4">
                            <input id="workDept" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.workDept}"/>
                        </div>
                    </div>

                    <div class="form-row">

                        <div class="col-md-2 tar">
                            任职时间
                        </div>
                        <div class="col-md-4">
                            <input id="appointmentTime" type="date" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.appointmentTime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            拟申报职称层次
                        </div>
                        <div class="col-md-4">
                            <input id="appliedLevel" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.appliedLevel}"/>
                        </div>

                    </div>


                    <div class="form-row">
                        <div class="col-md-2 tar">
                            学位
                        </div>
                        <div class="col-md-4">
                            <input id="academicDegree" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.academicDegree}"/>

                        </div>
                        <div class="col-md-2 tar">
                            学历
                        </div>
                        <div class="col-md-4">
                            <input id="educationalLevel" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.academicDegree}"/>

                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            毕业学校
                        </div>
                        <div class="col-md-4">
                            <input id="school" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.school}"/>
                        </div>
                        <div class="col-md-2 tar">
                            工作年限
                        </div>
                        <div class="col-md-4">
                            <input id="workingSeniority" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.workingSeniority}"/>
                        </div>
                    </div>


                    <div class="form-row">
                        <div class="col-md-2 tar">
                            职称
                        </div>
                        <div class="col-md-4">
                            <input id="positionalTitles" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.positionalTitles}"/>
                        </div>
                        <div class="col-md-2 tar">
                            现任职务
                        </div>
                        <div class="col-md-4">
                            <input id="presentPost" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.presentPost}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            聘任时间
                        </div>
                        <div class="col-md-4">
                            <input id="engageTime" type="date" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.engageTime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            现任岗位
                        </div>
                        <div class="col-md-4">
                            <input id="incumbentPost" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.incumbentPost}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            聘任岗位
                        </div>
                        <div class="col-md-4">
                            <input id="appointmentPost" type="text" readonly="readonly"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${declareApprove.appointmentPost}"/>
                        </div>
                        <div class="col-md-2 tar">
                            申请专业技术（职称）评审的基本条件概述
                        </div>
                        <div class="col-md-4">
                        <textarea id="representativeAchievements" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  readonly="readonly">${declareApprove.representativeAchievements}</textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <%--<button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");


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

</script>

