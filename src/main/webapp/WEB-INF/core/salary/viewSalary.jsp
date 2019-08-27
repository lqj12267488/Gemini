<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1300px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">${salary.idcard}
                        <%--<input id="idcard" type="text" min="0" value="${salary.idcard}"/>--%>
                    </div>

                    <div class="col-md-2 tar">
                        姓名
                    </div>
                    <div class="col-md-4">${salary.name}
                        <%--<input id="name" type="text" value="${salary.name}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        年份
                    </div>
                    <div class="col-md-4">${salary.year}
                        <%--<input id="year" type="number" min="2016" max="2050" value="${salary.year}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        月份
                    </div>
                    <div class="col-md-4">${salary.month}
                        <%--<input id="month" type="number" min="1" max="12"  value="${salary.month}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        岗位工资
                    </div>
                    <div class="col-md-4">${salary.postSalary}
                        <%--<input id="postSalary" type="number" min="0"  value="${salary.postSalary}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        薪级工资
                    </div>
                    <div class="col-md-4">${salary.wagePay}
                        <%--<input id="wagePay" type="number" min="0" value="${salary.wagePay}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        百分之十
                    </div>
                    <div class="col-md-4">${salary.bfzs}
                        <%--<input id="bfzs" type="number" min="0"  value="${salary.bfzs}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        基础性绩效
                    </div>
                    <div class="col-md-4">${salary.basicPerformance}
                        <%--<input id="basicPerformance" type="number" min="0" value="${salary.basicPerformance}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        国家奖励性绩效
                    </div>
                    <div class="col-md-4">${salary.rewardPerformance}
                        <%--<input id="rewardPerformance" type="number" min="0"  value="${salary.rewardPerformance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        独子补贴
                    </div>
                    <div class="col-md-4">${salary.childAllowance}
                        <%--<input id="childAllowance" type="number" min="0" value="${salary.childAllowance}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教护龄
                    </div>
                    <div class="col-md-4">${salary.seniorityAllowance}
                        <%--<input id="seniorityAllowance" type="number" min="0" value="${salary.seniorityAllowance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        房租补贴
                    </div>
                    <div class="col-md-4">${salary.rentSubsidies}
                        <%--<input id="rentSubsidies" type="number" min="0" value="${salary.rentSubsidies}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        特殊岗位津贴
                    </div>
                    <div class="col-md-4">${salary.postAllowance}
                        <%--<input id="postAllowance" type="number" min="0" value="${salary.postAllowance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        补发津贴
                    </div>
                    <div class="col-md-4">${salary.reissueAllowance}
                        <%--<input id="reissueAllowance" type="number" min="0" value="${salary.reissueAllowance}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同岗位工资
                    </div>
                    <div class="col-md-4">${salary.lcPv}
                        <%--<input id="lcPv" type="number" min="0"  value="${salary.lcPv}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同学历工资
                    </div>
                    <div class="col-md-4">${salary.lcAcademicSalary}
                        <%--<input id="lcAcademicSalary" type="number" min="0" value="${salary.lcAcademicSalary}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同职称津贴
                    </div>
                    <div class="col-md-4">${salary.lcTitleAllowance}
                        <%--<input id="lcTitleAllowance" type="number" min="0"  value="${salary.lcTitleAllowance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同校龄工资
                    </div>
                    <div class="col-md-4">${salary.lcAgeSalary}
                        <%--<input id="lcAgeSalary" type="number" min="0" value="${salary.lcAgeSalary}"/>--%>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        劳动合同调整津贴
                    </div>
                    <div class="col-md-4">${salary.lcAdjustmentAllowance}
                        <%--<input id="lcAdjustmentAllowance" type="number" min="0"  value="${salary.lcAdjustmentAllowance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同绩效工资
                    </div>
                    <div class="col-md-4">${salary.lcMeritPay}
                        <%--<input id="lcMeritPay" type="number" min="0" value="${salary.lcMeritPay}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同独子补贴
                    </div>
                    <div class="col-md-4">${salary.lcChildAllowance}
                        <%--<input id="lcChildAllowance" type="number" min="0"  value="${salary.lcChildAllowance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        采暖费
                    </div>
                    <div class="col-md-4">${salary.heatingFee}
                        <%--<input id="heatingFee" type="number" min="0"  value="${salary.heatingFee}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        讲课费1
                    </div>
                    <div class="col-md-4">${salary.lectureFee}
                        <%--<input id="lectureFee" type="number" min="0" value="${salary.lectureFee}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        讲课费2
                    </div>
                    <div class="col-md-4">${salary.lectureFeeSecond}
                        <%--<input id="lectureFeeSecond" type="number" min="0"  value="${salary.lectureFeeSecond}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        中专班主任费
                    </div>
                    <div class="col-md-4">${salary.polytechnicHeadmasterFee}
                        <%--<input id="polytechnicHeadmasterFee" type="number" min="0"  value="${salary.polytechnicHeadmasterFee}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        大专班主任费
                    </div>
                    <div class="col-md-4">${salary.juniorHeadmasterFee}
                        <%--<input id="juniorHeadmasterFee" type="number" min="0" value="${salary.juniorHeadmasterFee}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        绩效考核返还
                    </div>
                    <div class="col-md-4">${salary.performanceAppraisalReturn}
                        <%--<input id="performanceAppraisalReturn" type="number" min="0"  value="${salary.performanceAppraisalReturn}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        责任绩效
                    </div>
                    <div class="col-md-4">${salary.accountabilityPerformance}
                        <%--<input id="accountabilityPerformance" type="number" min="0" value="${salary.accountabilityPerformance}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        管理、教辅效益绩效
                    </div>
                    <div class="col-md-4">${salary.managementPerformance}
                        <%--<input id="managementPerformance" type="number" min="0"  value="${salary.managementPerformance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        内聘津贴
                    </div>
                    <div class="col-md-4">${salary.internalAllowance}
                        <%--<input id="internalAllowance" type="number" min="0" value="${salary.internalAllowance}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职大百分之十
                    </div>
                    <div class="col-md-4">${salary.zdbfzs}
                        <%--<input id="zdbfzs" type="number" min="0"  value="${salary.zdbfzs}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        职大商校职称差额
                    </div>
                    <div class="col-md-4">${salary.titleDifference}
                        <%--<input id="titleDifference" type="number" min="0" value="${salary.titleDifference}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补发工资1
                    </div>
                    <div class="col-md-4">${salary.replacementWage}
                        <%--<input id="replacementWage" type="number" min="0"  value="${salary.replacementWage}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        补发工资2
                    </div>
                    <div class="col-md-4">${salary.replacementWageSecond}
                        <%--<input id="replacementWageSecond" type="number" min="0" value="${salary.replacementWageSecond}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        招生项目绩效
                    </div>
                    <div class="col-md-4">${salary.recruitStudentsAchievements}
                        <%--<input id="recruitStudentsAchievements" type="number" min="0"  value="${salary.recruitStudentsAchievements}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        大赛项目绩效
                    </div>
                    <div class="col-md-4">${salary.contestAchievements}
                        <%--<input id="contestAchievements" type="number" min="0" value="${salary.contestAchievements}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        科研项目绩效
                    </div>
                    <div class="col-md-4">${salary.scientificAchievements}
                        <%--<input id="scientificAchievements" type="number" min="0"  value="${salary.scientificAchievements}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        其他
                    </div>
                    <div class="col-md-4">${salary.others}
                        <%--<input id="others" type="number" min="0" value="${salary.others}"/>--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        绩效考核奖
                    </div>
                    <div class="col-md-4">${salary.performanceAppraisalAward}
                        <%--<input id="performanceAppraisalAward" type="number" min="0"  value="${salary.performanceAppraisalAward}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        应发合计
                    </div>
                    <div class="col-md-4">${salary.totalPayable}
                        <%--<input id="totalPayable" type="number" min="0" value="${salary.totalPayable}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        个人所得税
                    </div>
                    <div class="col-md-4">${salary.individualIncomeTax}
                        <%--<input id="individualIncomeTax" type="number" min="0"  value="${salary.individualIncomeTax}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        养老保险
                    </div>
                    <div class="col-md-4">${salary.endowmentInsurance}
                        <%--<input id="endowmentInsurance" type="number" min="0" value="${salary.endowmentInsurance}"/>--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        医疗保险
                    </div>
                    <div class="col-md-4">${salary.medicalInsurance}
                        <%--<input id="medicalInsurance" type="number" min="0"  value="${salary.medicalInsurance}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        住房基金
                    </div>
                    <div class="col-md-4">${salary.housingFund}
                        <%--<input id="housingFund" type="number" min="0" value="${salary.housingFund}"/>--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职业年金
                    </div>
                    <div class="col-md-4">${salary.occupationalPension}
                        <%--<input id="occupationalPension" type="number" min="0"  value="${salary.occupationalPension}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        补扣养老保险
                    </div>
                    <div class="col-md-4">${salary.supplementaryEi}
                        <%--<input id="supplementaryEi" type="number" min="0" value="${salary.supplementaryEi}"/>--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补扣医疗保险
                    </div>
                    <div class="col-md-4">${salary.supplementaryMi}
                        <%--<input id="supplementaryMi" type="number" min="0"  value="${salary.supplementaryMi}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        补扣房基金
                    </div>
                    <div class="col-md-4">${salary.supplementaryHf}
                        <%--<input id="supplementaryHf" type="number" min="0" value="${salary.supplementaryHf}"/>--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补扣职业年金
                    </div>
                    <div class="col-md-4">${salary.supplementaryOp}
                        <%--<input id="supplementaryOp" type="number" min="0"  value="${salary.supplementaryOp}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        补扣税
                    </div>
                    <div class="col-md-4">${salary.supplementaryTax}
                        <%--<input id="supplementaryTax" type="number" min="0" value="${salary.supplementaryTax}"/>--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        扣款
                    </div>
                    <div class="col-md-4">${salary.debit}
                        <%--<input id="debit" type="number" min="0"  value="${salary.debit}"/>--%>
                    </div>
                    <div class="col-md-2 tar">
                        会费
                    </div>
                    <div class="col-md-4">${salary.membershipDues}
                        <%--<input id="membershipDues" type="number" min="0" value="${salary.membershipDues}"/>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        实发合计
                    </div>
                    <div class="col-md-4">${salary.realSalary}
                        <%--<input id="realSalary" type="text" min="0"   value="${salary.realSalary}"/>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
           <%-- <button type="button" class="btn btn-success btn-clean" onclick="saveClass()">保存</button>--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="id" hidden value="${salary.id}">