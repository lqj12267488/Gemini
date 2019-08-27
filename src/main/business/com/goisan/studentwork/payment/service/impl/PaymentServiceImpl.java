package com.goisan.studentwork.payment.service.impl;

import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.payment.bean.*;
import com.goisan.studentwork.payment.dao.PaymentDao;
import com.goisan.studentwork.payment.service.PaymentService;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mcq on 2017/10/23.
 */
@Service
public class PaymentServiceImpl implements PaymentService {
    @Resource
    private PaymentDao paymentDao;
    @Override
    public void saveCostItem(CostItem costItem) {
        paymentDao.saveCostItem(costItem);
    }

    @Override
    public void deleteCostItem(String costId) {
        paymentDao.deleteCostItem(costId);
    }

    @Override
    public void updateCostItem(CostItem costItem) {
        paymentDao.updateCostItem(costItem);
    }

    @Override
    public List<PaymentPlan> getPaymentPlanList(PaymentPlan paymentPlan) {
        return  paymentDao.getPaymentPlanList(paymentPlan);
    }

    @Override
    public void savePaymentPlan(PaymentPlan paymentPlan) {
        paymentDao.savePaymentPlan(paymentPlan);
    }

    @Override
    public void deletePaymentPlan(String planId) {
        paymentDao.deletePaymentPlan(planId);
    }

    @Override
    public void updatePaymentPlan(PaymentPlan paymentPlan) {
        paymentDao.updatePaymentPlan(paymentPlan);
    }

    @Override
    public PaymentPlan selectPaymentPlanByPlanId(String planId) {
        return paymentDao.selectPaymentPlanByPlanId(planId);
    }

    @Override
    public void savePaymentPlanItem(PaymentPlanItem paymentPlanItem) {
        paymentDao.savePaymentPlanItem(paymentPlanItem);
    }

    @Override
    public List<EnrollmentStudent> getNewStudentStandardList(EnrollmentStudent enrollmentStudent) {
        return paymentDao.getNewStudentStandardList(enrollmentStudent);
    }

    @Override
    public void savePaymentResult(PaymentResult paymentResult) {
        paymentDao.savePaymentResult(paymentResult);
    }

    @Override
    public void updatePaymentResult(PaymentResult paymentResult) {
        paymentDao.updatePaymentResult(paymentResult);
    }

    @Override
    public PaymentResult selectPaymentResultByIds(String studentId, String itemId) {
        return paymentDao.selectPaymentResultByIds(studentId, itemId);
    }

    @Override
    public List<PaymentResult> findPaymentResultListByPlanId(String planId) {
        return paymentDao.findPaymentResultListByPlanId(planId);
    }

    @Override
    public List<PaymentResult> findPaymentResultListByIds(String idcard,String itemId) {
        return paymentDao.findPaymentResultListByIds(idcard,itemId);
    }

    @Override
    public void deletePaymentResult(String planId) {
        paymentDao.deletePaymentResult(planId);
    }

    @Override
    public void deletePaymentPlanItem(String planId) {
        paymentDao.deletePaymentPlanItem(planId);
    }

    @Override
    public List<Student> getStatusStudentStandardList(Student student) {
        return paymentDao.getStatusStudentStandardList(student);
    }

    @Override
    public List<PaymentPlanItem>  checkPaymentItem(String itemId) {
        return paymentDao.checkPaymentItem(itemId);
    }

    @Override
    public List<Student> getPaymentInfoStandardList(Student student) {
        return paymentDao.getPaymentInfoStandardList(student);
    }

    @Override
    public List<CostItem> getCostItemList(CostItem costItem) {
        return paymentDao.getCostItemList(costItem);
    }

    @Override
    public  CostItem selectCostItemByCostId(String costId) {
        return paymentDao.selectCostItemByCostId(costId);
    }

    @Override
    public List<CostMajor> getCostMajorList(CostMajor costMajor) {
        return paymentDao.getCostMajorList(costMajor);
    }

    @Override
    public void saveCostMajor(CostMajor costMajor) {
        paymentDao.saveCostMajor(costMajor);
    }

    @Override
    public void deleteCostMajor(String id,String year) {
        paymentDao.deleteCostMajor(id,year);
    }

    @Override
    public void batchDeleteCostMajor(CostMajor costMajor) {
        paymentDao.batchDeleteCostMajor(costMajor);
    }

    @Override
    public void updateCostMajor(CostMajor costMajor) {
        paymentDao.updateCostMajor(costMajor);
    }

    @Override
    public CostMajor selectCostMajorById(String majorId,String year) {
        return paymentDao.selectCostMajorById(majorId,year);
    }

    @Override
    public List<PaymentResult> getPersonalPaymentList(PaymentResult paymentResult) {
        return paymentDao.getPersonalPaymentList(paymentResult);
    }
}
