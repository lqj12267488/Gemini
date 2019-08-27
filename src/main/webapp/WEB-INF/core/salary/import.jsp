<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">导入</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 tar">
                        <form action='<%=request.getContextPath()%>/salary/importSalary' id="importSalary"
                              enctype="multipart/form-data"
                              method="post">
                            <input type="file" name="file" id="file">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-info btn-clean"
               href="<%=request.getContextPath()%>/salary/getSalaryExcelTemplate">下载模板</a>
            <button class="btn btn-info btn-clean" onclick="importEmp()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    function importEmp() {
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
        if ($("#file").val() == "") {
            swal({
                title: "请选择文件",
                type: "error"
            });
            return;
        }

        var file = $("#file").val();
        var fileTypes = new Array("xls", "xlsx");  //定义可支持的文件类型数组
        var fileTypeFlag = "0";
        var newFileName = file.split('.');
        newFileName = newFileName[newFileName.length - 1];
        for (var i = 0; i < fileTypes.length; i++) {
            if (fileTypes[i] == newFileName) {
                fileTypeFlag = "1";
            }
        }
        if (fileTypeFlag == "0") {
            swal({
                title: "请导入表格文件!",
                type: "error"
            });
            return false;
        }
        var form = new FormData(document.getElementById("importSalary"));

            if (!reg3.test(form.realSalary) && form.realSalary!=undefined) {

                swal({
                    title: "实发合计位数不可超过俩位",
                    type: "error"
                });
                return;
            }
            var reg2 = /^[0-9]+.?[0-9]*$/;
            var reg4 = /^[1-12]+.?[1-12]*$/;
            if (form.postSalary!=undefined && (!reg2.test(form.postSalary))) {
                swal({
                    title: "岗位工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.wagePay) && form.wagePay!=undefined) {
                swal({
                    title: "薪级工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.bfzs) && form.bfzs!=undefined) {
                swal({
                    title: "百分之十填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.basicPerformance) && form.basicPerformance!=undefined) {
                swal({
                    title: "基础性绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.rewardPerformance) && form.rewardPerformance!=undefined) {
                swal({
                    title: "国家奖励性绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.childAllowance) && form.childAllowance!=undefined) {
                swal({
                    title: "独子补贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.seniorityAllowance) && form.seniorityAllowance!=undefined) {
                swal({
                    title: "教护龄填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.rentSubsidies) && form.rentSubsidies!=undefined) {
                swal({
                    title: "房租补贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.postAllowance) && form.postAllowance!=undefined) {
                swal({
                    title: "特殊岗位津贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.reissueAllowance) && form.reissueAllowance!=undefined) {
                swal({
                    title: "补发津贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcPv) && form.lcPv!=undefined) {
                swal({
                    title: "劳动合同岗位工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcAcademicSalary) && form.lcAcademicSalary!=undefined) {
                swal({
                    title: "劳动合同学历工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcTitleAllowance) && form.lcTitleAllowance!=undefined) {
                swal({
                    title: "劳动合同职称津贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcAgeSalary) && form.lcAgeSalary!=undefined) {
                swal({
                    title: "劳动合同校龄工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcAdjustmentAllowance) && form.lcAdjustmentAllowance!=undefined) {
                swal({
                    title: "劳动合同调整津贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcMeritPay) && form.lcMeritPay!=undefined) {
                swal({
                    title: "劳动合同绩效工资填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }if (!reg2.test(form.lcChildAllowance) && form.lcChildAllowance!=undefined) {
                swal({
                    title: "劳动合同独子补贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }

            if (!reg2.test(form.heatingFee) && form.heatingFee!=undefined) {
                swal({
                    title: "采暖费填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.lectureFee) && form.lectureFee!=undefined) {
                swal({
                    title: "讲课费1填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.lectureFeeSecond) && form.lectureFeeSecond!=undefined) {
                swal({
                    title: "讲课费2填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.polytechnicHeadmasterFee) && form.polytechnicHeadmasterFee!=undefined) {
                swal({
                    title: "中专班主任费填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.juniorHeadmasterFee) && form.juniorHeadmasterFee!=undefined) {
                swal({
                    title: "大专班主任费填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.performanceAppraisalReturn) && form.performanceAppraisalReturn!=undefined) {
                swal({
                    title: "绩效考核返还填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.accountabilityPerformance) && form.accountabilityPerformance!=undefined) {
                swal({
                    title: "责任绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.managementPerformance) && form.managementPerformance!=undefined) {
                swal({
                    title: "管理、教辅效益绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }



            if (!reg2.test(form.internalAllowance) && form.internalAllowance!=undefined) {
                swal({
                    title: "内聘津贴填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }

            if (!reg2.test(form.zdbfzs) && form.zdbfzs!=undefined) {
                swal({
                    title: "职大百分之十填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.titleDifference) && form.titleDifference!=undefined) {
                swal({
                    title: "职大商校职称差额填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.replacementWage) && form.replacementWage!=undefined) {
                swal({
                    title: "补发工资1填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.replacementWageSecond) && form.replacementWageSecond!=undefined) {
                swal({
                    title: "补发工资2填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.recruitStudentsAchievements) && form.recruitStudentsAchievements!=undefined) {
                swal({
                    title: "招生项目绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.contestAchievements) && form.contestAchievements!=undefined) {
                swal({
                    title: "大赛项目绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.scientificAchievements) && form.scientificAchievements!=undefined) {
                swal({
                    title: "科研项目绩效填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.others) && form.others!=undefined) {
                swal({
                    title: "其他填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.performanceAppraisalAward) && form.performanceAppraisalAward!=undefined) {
                swal({
                    title: "绩效考核奖填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }

            if (!reg2.test(form.totalPayable) && form.totalPayable!=undefined) {
                swal({
                    title: "应发合计填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.individualIncomeTax) && form.individualIncomeTax!=undefined) {
                swal({
                    title: "个人所得税填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }

            if (!reg2.test(form.endowmentInsurance) && form.endowmentInsurance!=undefined) {
                swal({
                    title: "养老保险填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.medicalInsurance) && form.medicalInsurance!=undefined) {
                swal({
                    title: "医疗保险填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.housingFund) && form.housingFund!=undefined) {
                swal({
                    title: "住房基金填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.occupationalPension) && form.occupationalPension!=undefined) {
                swal({
                    title: "职业年金填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }


            if (!reg2.test(form.supplementaryEi) && form.supplementaryEi!=undefined) {
                swal({
                    title: "补扣养老保险填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.supplementaryMi) && form.supplementaryMi!=undefined) {
                swal({
                    title: "补扣医疗保险填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.supplementaryHf) && form.supplementaryHf!=undefined) {
                swal({
                    title: "补扣房基金填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.supplementaryOp) && form.supplementaryOp!=undefined) {
                swal({
                    title: "补扣职业年金填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }


            if (!reg2.test(form.supplementaryTax) && form.supplementaryTax!=undefined) {
                swal({
                    title: "补扣税填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.debit) && form.debit!=undefined) {
                swal({
                    title: "扣款填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.membershipDues) && form.membershipDues!=undefined) {
                swal({
                    title: "会费填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }
            if (!reg2.test(form.realSalary) && form.realSalary!=undefined) {
                swal({
                    title: "实发合计填写错误,请输入正确标准（数字）",
                    type: "error"
                });
                return;
            }

            if (!reg4.test(form.month) && form.month!=undefined) {
                swal({
                    title: "请输入有效的月份（数字）",
                    type: "error"
                });
            return;
            }




        $.ajax({


        url: '<%=request.getContextPath()%>/salary/importSalary',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {

                if (data.status == 1) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#salaryGrid').DataTable().ajax.reload();
                }else{
                    swal({
                        title: data.msg,
                        type: "error"
                    });
                    $("#dialog").modal("hide");
                    $('#salaryGrid').DataTable().ajax.reload();
                }
            }
        });
    }
</script>