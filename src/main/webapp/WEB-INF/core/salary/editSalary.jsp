<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1000px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" min="0" value="${salary.idcard}"/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名
                    </div>
                    <div class="col-md-4">
                        <input id="name" type="text" value="${salary.name}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 年份
                    </div>
                    <div class="col-md-4">
                        <input id="year" type="number" min="2016" max="2050" value="${salary.year}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 月份
                    </div>
                    <div class="col-md-4">
                        <input id="month" type="number" min="1" max="12"  value="${salary.month}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        岗位工资
                    </div>
                    <div class="col-md-4">
                        <input id="postSalary" type="number" min="0"  value="${salary.postSalary}"/>
                    </div>
                    <div class="col-md-2 tar">
                        薪级工资
                    </div>
                    <div class="col-md-4">
                        <input id="wagePay" type="number" min="0" value="${salary.wagePay}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        百分之十
                    </div>
                    <div class="col-md-4">
                        <input id="bfzs" type="number" min="0"  value="${salary.bfzs}"/>
                    </div>
                    <div class="col-md-2 tar">
                        基础性绩效
                    </div>
                    <div class="col-md-4">
                        <input id="basicPerformance" type="number" min="0" value="${salary.basicPerformance}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        国家奖励性绩效
                    </div>
                    <div class="col-md-4">
                        <input id="rewardPerformance" type="number" min="0"  value="${salary.rewardPerformance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        独子补贴
                    </div>
                    <div class="col-md-4">
                        <input id="childAllowance" type="number" min="0" value="${salary.childAllowance}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教护龄
                    </div>
                    <div class="col-md-4">
                        <input id="seniorityAllowance" type="number" min="0" value="${salary.seniorityAllowance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        房租补贴
                    </div>
                    <div class="col-md-4">
                        <input id="rentSubsidies" type="number" min="0" value="${salary.rentSubsidies}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        特殊岗位津贴
                    </div>
                    <div class="col-md-4">
                        <input id="postAllowance" type="number" min="0" value="${salary.postAllowance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        补发津贴
                    </div>
                    <div class="col-md-4">
                        <input id="reissueAllowance" type="number" min="0" value="${salary.reissueAllowance}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同岗位工资
                    </div>
                    <div class="col-md-4">
                        <input id="lcPv" type="number" min="0"  value="${salary.lcPv}"/>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同学历工资
                    </div>
                    <div class="col-md-4">
                        <input id="lcAcademicSalary" type="number" min="0" value="${salary.lcAcademicSalary}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同职称津贴
                    </div>
                    <div class="col-md-4">
                        <input id="lcTitleAllowance" type="number" min="0"  value="${salary.lcTitleAllowance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同校龄工资
                    </div>
                    <div class="col-md-4">
                        <input id="lcAgeSalary" type="number" min="0" value="${salary.lcAgeSalary}"/>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        劳动合同调整津贴
                    </div>
                    <div class="col-md-4">
                        <input id="lcAdjustmentAllowance" type="number" min="0"  value="${salary.lcAdjustmentAllowance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        劳动合同绩效工资
                    </div>
                    <div class="col-md-4">
                        <input id="lcMeritPay" type="number" min="0" value="${salary.lcMeritPay}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        劳动合同独子补贴
                    </div>
                    <div class="col-md-4">
                        <input id="lcChildAllowance" type="number" min="0"  value="${salary.lcChildAllowance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        采暖费
                    </div>
                    <div class="col-md-4">
                        <input id="heatingFee" type="number" min="0"  value="${salary.heatingFee}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        讲课费1
                    </div>
                    <div class="col-md-4">
                        <input id="lectureFee" type="number" min="0" value="${salary.lectureFee}"/>
                    </div>
                    <div class="col-md-2 tar">
                        讲课费2
                    </div>
                    <div class="col-md-4">
                        <input id="lectureFeeSecond" type="number" min="0"  value="${salary.lectureFeeSecond}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        中专班主任费
                    </div>
                    <div class="col-md-4">
                        <input id="polytechnicHeadmasterFee" type="number" min="0"  value="${salary.polytechnicHeadmasterFee}"/>
                    </div>
                    <div class="col-md-2 tar">
                        大专班主任费
                    </div>
                    <div class="col-md-4">
                        <input id="juniorHeadmasterFee" type="number" min="0" value="${salary.juniorHeadmasterFee}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        绩效考核返还
                    </div>
                    <div class="col-md-4">
                        <input id="performanceAppraisalReturn" type="number" min="0"  value="${salary.performanceAppraisalReturn}"/>
                    </div>
                    <div class="col-md-2 tar">
                        责任绩效
                    </div>
                    <div class="col-md-4">
                        <input id="accountabilityPerformance" type="number" min="0" value="${salary.accountabilityPerformance}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        管理、教辅效益绩效
                    </div>
                    <div class="col-md-4">
                        <input id="managementPerformance" type="number" min="0"  value="${salary.managementPerformance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        内聘津贴
                    </div>
                    <div class="col-md-4">
                        <input id="internalAllowance" type="number" min="0" value="${salary.internalAllowance}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职大百分之十
                    </div>
                    <div class="col-md-4">
                        <input id="zdbfzs" type="number" min="0"  value="${salary.zdbfzs}"/>
                    </div>
                    <div class="col-md-2 tar">
                        职大商校职称差额
                    </div>
                    <div class="col-md-4">
                        <input id="titleDifference" type="number" min="0" value="${salary.titleDifference}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补发工资1
                    </div>
                    <div class="col-md-4">
                        <input id="replacementWage" type="number" min="0"  value="${salary.replacementWage}"/>
                    </div>
                    <div class="col-md-2 tar">
                        补发工资2
                    </div>
                    <div class="col-md-4">
                        <input id="replacementWageSecond" type="number" min="0" value="${salary.replacementWageSecond}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        招生项目绩效
                    </div>
                    <div class="col-md-4">
                        <input id="recruitStudentsAchievements" type="number" min="0"  value="${salary.recruitStudentsAchievements}"/>
                    </div>
                    <div class="col-md-2 tar">
                        大赛项目绩效
                    </div>
                    <div class="col-md-4">
                        <input id="contestAchievements" type="number" min="0" value="${salary.contestAchievements}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        科研项目绩效
                    </div>
                    <div class="col-md-4">
                        <input id="scientificAchievements" type="number" min="0"  value="${salary.scientificAchievements}"/>
                    </div>
                    <div class="col-md-2 tar">
                        其他
                    </div>
                    <div class="col-md-4">
                        <input id="others" type="number" min="0" value="${salary.others}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        绩效考核奖
                    </div>
                    <div class="col-md-4">
                        <input id="performanceAppraisalAward" type="number" min="0"  value="${salary.performanceAppraisalAward}"/>
                    </div>
                    <div class="col-md-2 tar">
                        应发合计
                    </div>
                    <div class="col-md-4">
                        <input id="totalPayable" type="number" min="0" value="${salary.totalPayable}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        个人所得税
                    </div>
                    <div class="col-md-4">
                        <input id="individualIncomeTax" type="number" min="0"  value="${salary.individualIncomeTax}"/>
                    </div>
                    <div class="col-md-2 tar">
                        养老保险
                    </div>
                    <div class="col-md-4">
                        <input id="endowmentInsurance" type="number" min="0" value="${salary.endowmentInsurance}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        医疗保险
                    </div>
                    <div class="col-md-4">
                        <input id="medicalInsurance" type="number" min="0"  value="${salary.medicalInsurance}"/>
                    </div>
                    <div class="col-md-2 tar">
                        住房基金
                    </div>
                    <div class="col-md-4">
                        <input id="housingFund" type="number" min="0" value="${salary.housingFund}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        职业年金
                    </div>
                    <div class="col-md-4">
                        <input id="occupationalPension" type="number" min="0"  value="${salary.occupationalPension}"/>
                    </div>
                    <div class="col-md-2 tar">
                        补扣养老保险
                    </div>
                    <div class="col-md-4">
                        <input id="supplementaryEi" type="number" min="0" value="${salary.supplementaryEi}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补扣医疗保险
                    </div>
                    <div class="col-md-4">
                        <input id="supplementaryMi" type="number" min="0"  value="${salary.supplementaryMi}"/>
                    </div>
                    <div class="col-md-2 tar">
                        补扣房基金
                    </div>
                    <div class="col-md-4">
                        <input id="supplementaryHf" type="number" min="0" value="${salary.supplementaryHf}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        补扣职业年金
                    </div>
                    <div class="col-md-4">
                        <input id="supplementaryOp" type="number" min="0"  value="${salary.supplementaryOp}"/>
                    </div>
                    <div class="col-md-2 tar">
                        补扣税
                    </div>
                    <div class="col-md-4">
                        <input id="supplementaryTax" type="number" min="0" value="${salary.supplementaryTax}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        扣款
                    </div>
                    <div class="col-md-4">
                        <input id="debit" type="number" min="0"  value="${salary.debit}"/>
                    </div>
                    <div class="col-md-2 tar">
                        会费
                    </div>
                    <div class="col-md-4">
                        <input id="membershipDues" type="number" min="0" value="${salary.membershipDues}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 实发合计
                    </div>
                    <div class="col-md-4">
                        <input id="realSalary" type="text" min="0"   value="${salary.realSalary}"/>
                    </div>
                </div>
                <%-- <div class="form-row">
                    <div class="col-md-2 tar">
                        教职工号
                    </div>
                    <div class="col-md-4">
                        <input id="staffId" type="number" min="0" value="${salary.staffId}"/>
                    </div>
                </div>--%>

                <%--<div class="form-row">
                    <div class="col-md-2 tar">
                        基本工资
                    </div>
                    <div class="col-md-4">
                        <input id="basicwage" type="number" min="0" value="${salary.basicwage}"/>
                    </div>
                    <div class="col-md-2 tar">
                        五险一金
                    </div>
                    <div class="col-md-4">
                        <input id="insuranceFund" type="number" min="0"  value="${salary.insuranceFund}"/>
                    </div>
                </div>--%>
                <%-- <div class="form-row">
                     <div class="col-md-2 tar">
                         帐号
                     </div>
                     <div class="col-md-4">
                         <input id="useraccounts" type="number" min="0" value="${salary.useraccounts}"/>
                     </div>
                 </div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveSalary()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="id" hidden value="${salary.id}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    })

    $(document).ready(function(){
        if($("#id").val()==null&&$("#month").val()==null){
            var date=new Date();
            $("#year").val(date.getFullYear());
            $("#month").val(date.getMonth()+1);
        }
        if ("${salary.id}" != ""){
            $("#idcard").attr("readonly","readonly");
            $("#name").attr("readonly","readonly");
        }
        /*$("#name").change(function (){
            name=$("#name").val();
            $.get("<%=request.getContextPath()%>/salary/getIdCardByName?name="+name, function (data) {
                $("#idcard").val(data);
            });
        })*/
    })
    function saveSalary() {
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
        if ($("#year").val() == "") {
            swal({
                title: "请填写年份",
                type: "info"
            });
            //alert("请填写年份");
            return;
        }
        if($("#year").val().length!=4){
            swal({
                title: "年份填写错误，请重新输入",
                type: "info"
            });
            //alert("年份填写错误，请重新输入");
            return;
        }
        if ($("#month").val() == "") {
            swal({
                title: "请填写月份",
                type: "info"
            });
            //alert("请填写月份");
            return;
        }
        if ($("#month").val() < 1 || $("#month").val() > 12) {
            swal({
                title: "月份填写错误，请重新输入",
                type: "info"
            });
            //alert("月份填写错误，请重新输入");
            return;
        }
        if ($("#name").val() == ""){
            swal({
                title: "请填写姓名",
                type: "info"
            });
            //alert("请填写姓名");
            return;
        }
        if ($("#idcard").val() == "") {
            swal({
                title: "请填写身份证号",
                type: "info"
            });
            //alert("请填写身份证号");
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if ( reg.test($("#idcard").val()) === false) {
            swal({
                title: "身份证输入不合法,请重新输入",
                type: "info"
            });
            //alert("身份证输入不合法,请重新输入");
            return;
        }
        if ($("#realSalary").val() == "") {
            swal({
                title: "请填写实发合计工资",
                type: "info"
            });
            //alert("请填写实发合计工资");
            return;
        }
        else if (!reg3.test($("#realSalary").val())) {
            swal({
                title: "预算小数位数超过2位,请重新填写",
                type: "info"
            });
            //alert("预算小数位数超过2位,请重新填写");
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/salary/checkSalary",{
            id:$("#id").val(),
            year: $("#year").val(),
            month: $("#month").val(),
            name: $("#name").val(),
            idcard: $("#idcard").val()
        },function(msg1) {
            if (msg1.status == 1) {
                var al = $("#year").val() + "年" +$("#month").val() + "月" + $("#name").val()  + ":" + $("#idcard").val()+ "的工资单已存在";
                swal({
                    title: al + msg1.msg,
                    type: "info"
                });
                //alert(al + msg1.msg);
            } else {
                $.post("<%=request.getContextPath()%>/salary/saveSalary", {
                    id: $("#id").val(),
                    year: $("#year").val(),
                    month: $("#month").val(),
                    name: $("#name").val(),
                    staffId: $("#staffId").val(),
                    idcard: $("#idcard").val(),
                    realSalary: $("#realSalary").val(),
                    basicwage: $("#basicwage").val(),
                    insuranceFund: $("#insuranceFund").val(),
                    others: $("#others").val(),
                    heatingFee: $("#heatingFee").val(),
                    useraccounts: $("#useraccounts").val(),
                    postSalary: $("#postSalary").val(),
                    wagePay: $("#wagePay").val(),
                    bfzs: $("#bfzs").val(),
                    basicPerformance: $("#basicPerformance").val(),
                    rewardPerformance: $("#rewardPerformance").val(),
                    childAllowance: $("#childAllowance").val(),
                    seniorityAllowance: $("#seniorityAllowance").val(),
                    rentSubsidies: $("#rentSubsidies").val(),
                    postAllowance: $("#postAllowance").val(),
                    reissueAllowance: $("#reissueAllowance").val(),
                    lcPv: $("#lcPv").val(),
                    lcAcademicSalary: $("#lcAcademicSalary").val(),
                    lcTitleAllowance: $("#lcTitleAllowance").val(),
                    lcAgeSalary: $("#lcAgeSalary").val(),
                    lcAdjustmentAllowance: $("#lcAdjustmentAllowance").val(),
                    lcMeritPay: $("#lcMeritPay").val(),
                    lcChildAllowance: $("#lcChildAllowance").val(),
                    lectureFee: $("#lectureFee").val(),
                    polytechnicHeadmasterFee: $("#polytechnicHeadmasterFee").val(),
                    juniorHeadmasterFee: $("#juniorHeadmasterFee").val(),
                    performanceAppraisalReturn: $("#performanceAppraisalReturn").val(),
                    accountabilityPerformance: $("#accountabilityPerformance").val(),
                    managementPerformance: $("#managementPerformance").val(),
                    internalAllowance: $("#internalAllowance").val(),
                    zdbfzs: $("#zdbfzs").val(),
                    titleDifference: $("#titleDifference").val(),
                    replacementWage: $("#replacementWage").val(),
                    replacementWageSecond: $("#replacementWageSecond").val(),
                    recruitStudentsAchievements: $("#recruitStudentsAchievements").val(),
                    contestAchievements: $("#contestAchievements").val(),
                    scientificAchievements: $("#scientificAchievements").val(),
                    totalPayable: $("#totalPayable").val(),
                    individualIncomeTax: $("#individualIncomeTax").val(),
                    endowmentInsurance: $("#endowmentInsurance").val(),
                    medicalInsurance: $("#medicalInsurance").val(),
                    housingFund: $("#housingFund").val(),
                    occupationalPension: $("#occupationalPension").val(),
                    supplementaryEi: $("#supplementaryEi").val(),
                    supplementaryMi: $("#supplementaryMi").val(),
                    supplementaryHf: $("#supplementaryHf").val(),
                    supplementaryOp: $("#supplementaryOp").val(),
                    supplementaryTax: $("#supplementaryTax").val(),
                    debit: $("#debit").val(),
                    membershipDues: $("#membershipDues").val(),
                    lectureFeeSecond: $("#lectureFeeSecond").val(),
                    performanceAppraisalAward: $("#performanceAppraisalAward").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $("#dialog").modal('hide');
                        $('#salaryGrid').DataTable().ajax.reload();
                    }
                })
            }
        });
    }

</script>