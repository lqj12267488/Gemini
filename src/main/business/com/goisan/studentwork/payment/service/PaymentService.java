package com.goisan.studentwork.payment.service;

import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.payment.bean.*;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mcq on 2017/10/23.
 */
public interface PaymentService {
    List<PaymentPlan> getPaymentPlanList(PaymentPlan paymentPlan);

    void savePaymentPlan(PaymentPlan paymentPlan);

    void deletePaymentPlan(String planId);

    void updatePaymentPlan(PaymentPlan paymentPlan);

    PaymentPlan selectPaymentPlanByPlanId(String planId);
    //缴费计划项目关联
    void savePaymentPlanItem(PaymentPlanItem paymentPlanItem);
    //缴费标准
    List<EnrollmentStudent> getNewStudentStandardList(EnrollmentStudent enrollmentStudent);
    //保存设置缴费标准
    void savePaymentResult(PaymentResult paymentResult);
    //修改缴费标准
    void updatePaymentResult(PaymentResult paymentResult);
    //查询学生是否已设置缴费标准
    PaymentResult selectPaymentResultByIds(@Param("studentId") String studentId, @Param("itemId") String itemId);
    //删除缴费计划校验
    List<PaymentResult>  findPaymentResultListByPlanId(String planId);
    //导入缴费标准查看结果表是否存在
    List<PaymentResult>  findPaymentResultListByIds(String idcard,String itemId);
    //删除缴费计划时删除缴费结果
    void deletePaymentResult(String planId);
    //删除缴费计划时删除缴费计划项目关联表
    void deletePaymentPlanItem(String planId);
    //在籍学生缴费List
    List<Student> getStatusStudentStandardList(Student student);
    List<PaymentPlanItem> checkPaymentItem(String itemId);
    //学生处缴费信息List
    List<Student> getPaymentInfoStandardList(Student student);
    //收费项目
    List<CostItem> getCostItemList(CostItem costItem);

    void saveCostItem(CostItem costItem);

    void deleteCostItem(String costId);

    void updateCostItem(CostItem costItem);

    CostItem selectCostItemByCostId(String id);

    //专业费用
    List<CostMajor> getCostMajorList(CostMajor costMajor);

    void saveCostMajor(CostMajor costMajor);

    void deleteCostMajor(String id,String year);

    void batchDeleteCostMajor(CostMajor CostMajor);

    void updateCostMajor(CostMajor CostMajor);

    CostMajor selectCostMajorById(String majorId,String year);
    //个人缴费查询
    List<PaymentResult> getPersonalPaymentList(PaymentResult paymentResult);
}
