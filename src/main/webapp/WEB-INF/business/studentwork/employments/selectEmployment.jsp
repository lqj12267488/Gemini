<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/17
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button onclick="back()" class="btn btn-default btn-clean">返回</button>

            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        单位名称
                    </div>
                    <div class="col-md-4">
                        <input id="f_internshipUnitName" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.internshipUnitName}" />
                    </div>
                    <div class="col-md-2 tar">
                        所在地区
                    </div>
                    <div class="col-md-4">
                        <input id="f_area" type="text"  readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.area}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        地址
                    </div>
                    <div class="col-md-4">
                        <input id="f_address" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.address}"/>
                    </div>
                    <div class="col-md-2 tar">
                        联系人
                    </div>
                    <div class="col-md-4">
                        <input id="f_contactPerson" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.contactPerson}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        联系电话
                    </div>
                    <div class="col-md-4">
                        <input id="f_contactNumber" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.contactNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        单位编码
                    </div>
                    <div class="col-md-4">
                        <input id="f_unitEncoding" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.unitEncoding}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        法人
                    </div>
                    <div class="col-md-4">
                        <input id="f_legalPerson" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.legalPerson}"/>
                    </div>
                    <div class="col-md-2 tar">
                        注册资金
                    </div>
                    <div class="col-md-4">
                        <input id="f_registeredCapital" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.registeredCapital}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        员工数
                    </div>
                    <div class="col-md-4">
                        <input id="f_personNumber" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.personNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        单位性质
                    </div>
                    <div class="col-md-4">
                        <input id="f_unitProperty" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.unitPropertyShow}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        就业产业
                    </div>
                    <div class="col-md-4">
                        <input id="f_employmentIndustry" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.employmentIndustryShow}" />
                    </div>
                    <div class="col-md-2 tar">
                        就业地域
                    </div>
                    <div class="col-md-4">
                        <input id="f_employmentArea" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.employmentAreaShow}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        就业地点
                    </div>
                    <div class="col-md-4">
                        <input id="employmentPlace" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.employmentPlaceShow}" />
                    </div>
                    <div class="col-md-2 tar">
                        企业类别
                    </div>
                    <div class="col-md-4">
                        <input id="enterpriseCategory" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.enterpriseCategoryShow}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        就业渠道
                    </div>
                    <div class="col-md-4">
                        <input id="employmentChannels" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.employmentChannelsShow}" />
                    </div>
                    <div class="col-md-2 tar">
                        对口性质
                    </div>
                    <div class="col-md-4">
                        <input id="counterpartProperty" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.counterpartPropertyShow}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        就业性质
                    </div>
                    <div class="col-md-4">
                        <input id="employmentNature" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.employmentNatureShow}" />
                    </div>
                    <div class="col-md-2 tar">
                        企业规模
                    </div>
                    <div class="col-md-4">
                        <input id="enterpriseScale" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.enterpriseScaleShow}" />
                    </div>
                </div>
            <div class="form-row">
                <div class="col-md-2 tar">
                    是否是原实习单位
                </div>
                <div class="col-md-4">
                    <input id="internshipUnitFlag" type="text" readonly="readonly"
                           class="validate[required,maxSize[20]] form-control"
                           value="${employments.internshipUnitFlagShow}" />
                </div>
            </div>
            </div>


<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/employments/request");
    }
</script>