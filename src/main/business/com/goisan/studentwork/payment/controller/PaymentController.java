package com.goisan.studentwork.payment.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.service.MajorService;
import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.enrollment.service.EnrollmentService;
import com.goisan.studentwork.payment.bean.*;
import com.goisan.studentwork.payment.service.PaymentService;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mcq on 2017/10/23.
 */
@Controller
public class PaymentController {
    @Resource
    private PaymentService paymentService;
    @Resource
    private MajorService majorService;
    @Resource
    private EnrollmentService enrollmentService;
    @Resource
    private StudentService studentService;
    @Resource
    private CommonService commonService;
    @Resource
    private ClassService classService;


    //收费项目URL
    @RequestMapping("/payment/item")
    public String toCostItem() {
        return "business/studentwork/payment/paymentItemList";
    }

    //缴费计划URL
    @RequestMapping("/payment/plan")
    public String toPaymentPlan() {
        return "business/studentwork/payment/paymentPlanList";
    }

    //新生缴费标准维护URL
    @RequestMapping("/payment/newStudent")
    public String toNewStudentPayment() {
        return "business/studentwork/payment/newStudentPaymentList";
    }

    //在籍学生缴费标准维护URL
    @RequestMapping("/payment/statusStudent")
    public String toStatusStudentPayment() {
        return "business/studentwork/payment/statusStudentPaymentList";
    }

    //缴费信息维护URL
    @RequestMapping("/payment/info")
    public String toPaymentInfo() {
        return "business/studentwork/payment/paymentInfoList";
    }

    //缴费结果URL
    @RequestMapping("/payment/result")
    public String toPaymentResult() {
        return "business/studentwork/payment/paymentResultList";
    }

    //个人缴费URL
    @RequestMapping("/payment/personal")
    public String toPersonalPayment() {
        return "business/studentwork/payment/personalPayment";
    }

    //个人缴费List
    @ResponseBody
    @RequestMapping("/payment/personal/getPersonalPaymentList")
    public Map getPersonalPaymentList(PaymentResult paymentResult) {
        paymentResult.setStudentId(CommonUtil.getPersonId());
        return CommonUtil.tableMap(paymentService.getPersonalPaymentList(paymentResult));
    }

    //缴费计划List
    @ResponseBody
    @RequestMapping("/payment/plan/getPaymentPlanList")
    public Map getPaymentPlanList(PaymentPlan paymentPlan) {
        paymentPlan.setCreateDept(CommonUtil.getDefaultDept());
        paymentPlan.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(paymentService.getPaymentPlanList(paymentPlan));
    }

    //缴费标准List
    @ResponseBody
    @RequestMapping("/payment/newStudent/getStandardList")
    public Map getNewStudentStandardList(EnrollmentStudent enrollmentStudent) {
        return CommonUtil.tableMap(paymentService.getNewStudentStandardList(enrollmentStudent));
    }

    //在籍缴费标准List
    @ResponseBody
    @RequestMapping("/payment/statusStudent/getStandardList")
    public Map getStatusStudentStandardList(Student student, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length).countColumn("*") ;
        Map<String, Object> data = new HashMap<>();
        List<Student> standardList = paymentService.getStatusStudentStandardList(student);
        PageInfo<Student> info = new PageInfo<>(standardList);
        data.put("draw", draw);
        data.put("recordsTotal", info.getTotal());
        data.put("recordsFiltered", info.getTotal());
        data.put("data", standardList);
        return data;
    }

    //缴费信息维护List
    @ResponseBody
    @RequestMapping("/payment/info/getStandardList")
    public Map getPaymentInfoStandardList(Student student) {
        return CommonUtil.tableMap(paymentService.getPaymentInfoStandardList(student));
    }

    //新增缴费计划
    @RequestMapping("/payment/plan/toAdd")
    public String toAddPaymentPlan(Model model) {
        model.addAttribute("head", "添加缴费计划");
        return "/business/studentwork/payment/editPaymentPlan";
    }

    //修改缴费计划
    @RequestMapping("/payment/plan/toEdit")
    public ModelAndView toEditPaymentPlan(String planId) {
        ModelAndView mv = new ModelAndView();
        PaymentPlan payment = paymentService.selectPaymentPlanByPlanId(planId);
        mv.addObject("payment", payment);
        mv.addObject("head", "修改缴费计划");
        mv.setViewName("/business/studentwork/payment/editPaymentPlan");
        return mv;
    }

    //删除缴费计划
    @ResponseBody
    @RequestMapping("/payment/plan/del")
    public Message delPaymentPlan(String planId) {
        paymentService.deletePaymentPlan(planId);
        paymentService.deletePaymentPlanItem(planId);
        paymentService.deletePaymentResult(planId);
        return new Message(1, "删除成功！", "success");
    }

    //删除缴费计划时校验
    @ResponseBody
    @RequestMapping("/payment/plan/checkPaymentPlan")
    public Message checkPaymentPlan(String planId) {
        List<PaymentResult> checkList = paymentService.findPaymentResultListByPlanId(planId);
        if (checkList.size() > 0) {
            return new Message(1, null, null);
        }
        return new Message(0, null, null);
    }

    //保存缴费计划
    @ResponseBody
    @RequestMapping("/payment/plan/save")
    public Message savePaymentPlan(PaymentPlan paymentPlan) {
        if (null == paymentPlan.getPlanId() || paymentPlan.getPlanId() == "") {
            //缴费计划表
            paymentPlan.setPlanId(CommonUtil.getUUID());
            CommonUtil.save(paymentPlan);
            paymentService.savePaymentPlan(paymentPlan);
            //保存缴费计划项目关联表
            PaymentPlanItem paymentPlanItem = new PaymentPlanItem();
            String itemId = paymentPlan.getPlanItem();
            String itemArray[] = itemId.split(",");
            for (String item : itemArray) {
                CommonUtil.save(paymentPlanItem);
                paymentPlanItem.setId(CommonUtil.getUUID());
                paymentPlanItem.setItemId(item);
                paymentPlanItem.setPlanId(paymentPlan.getPlanId());
                paymentService.savePaymentPlanItem(paymentPlanItem);
            }
            return new Message(0, "添加成功！", null);
        } else {
            //删除原有的缴费计划项目关联数据
            PaymentPlanItem paymentPlanItem = new PaymentPlanItem();
            String planId = paymentPlan.getPlanId();
            paymentService.deletePaymentPlanItem(planId);
            //修改缴费计划表
            CommonUtil.update(paymentPlan);
            paymentService.updatePaymentPlan(paymentPlan);
            PaymentPlanItem payitem = new PaymentPlanItem();
            //重新保存缴费计划项目关联表
            String itemId = paymentPlan.getPlanItem();
            String itemArray[] = itemId.split(",");
            for (String item : itemArray) {
                CommonUtil.save(payitem);
                payitem.setId(CommonUtil.getUUID());
                payitem.setItemId(item);
                payitem.setPlanId(paymentPlan.getPlanId());
                paymentService.savePaymentPlanItem(payitem);
            }
            return new Message(0, "修改成功！", null);
        }

    }

    //招生办缴费标准列表
    @RequestMapping("/payment/newStudent/toNewStudentPaymentStandard")
    public ModelAndView toNewStudentPaymentStandard(String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/newStudentPaymentStandard");
        return mv;
    }

    //学生处缴费标准列表
    @RequestMapping("/payment/statusStudent/toStatusStudentPaymentStandard")
    public ModelAndView toStatusStudentPaymentStandard(String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/statusStudentPaymentStandard");
        return mv;
    }

    //财务处缴费标准列表
    @RequestMapping("/payment/info/toPaymentInfoStandard")
    public ModelAndView toPaymentInfoStandard(String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/pamentInfoStandard");
        return mv;
    }

    //缴费结果列表（领导专用通道）
    @RequestMapping("/payment/result/toSearchPaymentResult")
    public ModelAndView toSearchPaymentResult(String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/searchPaymentResult");
        return mv;
    }

    //招生办设置缴费标准弹出页
    @RequestMapping("/payment/newStudent/toSetPaymentStandard")
    public ModelAndView toSetPaymentStandard(String ids, String check_value, String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("ids", ids);
        mv.addObject("check_value", check_value);
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/toSetPaymentStandard");
        return mv;
    }

    //财务处添加缴费结果弹出页
    @RequestMapping("/payment/info/addPaymentResult")
    public ModelAndView addPaymentResult(String ids, String check_value, String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("ids", ids);
        mv.addObject("check_value", check_value);
        mv.addObject("planId", planId);
        mv.setViewName("/business/studentwork/payment/addPaymentResult");
        return mv;
    }

    //保存缴费标准
    @ResponseBody
    @RequestMapping("/payment/newStudent/savePaymentStandard")
    public Message savePaymentStandard(String ids, String check_value, String paymentStandard, String planId) {
        String idsA[] = ids.split(";");
        String studentId = "";
        String itemId = "";
        String classId = "";
        for (String values : idsA) {
            PaymentResult payment = new PaymentResult();
            String valuesArray[] = values.split(",");
            studentId = valuesArray[0];
            itemId = valuesArray[1];
            classId = valuesArray[2];
            PaymentResult oldPaymentResult = paymentService.selectPaymentResultByIds(studentId, itemId);
            if (oldPaymentResult != null) {
                payment.setStudentId(studentId);
                payment.setItemId(itemId);
                payment.setPlanId(planId);
                payment.setPaymentStandard(paymentStandard);
                paymentService.updatePaymentResult(payment);
            } else {
                PaymentResult paymentResult = new PaymentResult();
                paymentResult.setId(CommonUtil.getUUID());
                paymentResult.setStudentId(studentId);
                paymentResult.setItemId(itemId);
                paymentResult.setClassId(classId);
                paymentResult.setPaymentStandard(paymentStandard);
                paymentResult.setPlanId(planId);
                CommonUtil.save(paymentResult);
                paymentService.savePaymentResult(paymentResult);
            }

        }

        return new Message(1, "保存成功", null);

    }

    //保存缴费结果
    @ResponseBody
    @RequestMapping("/payment/info/savePaymentResult")
    public Message savePaymentResult(String ids, String check_value, String paymentType,
                                     String paymentAmount, String refundAmount, String planId) {
        String idsA[] = ids.split(";");
        String studentId = "";
        String itemId = "";
        String classId = "";
        for (String values : idsA) {
            PaymentResult payment = new PaymentResult();
            String valuesArray[] = values.split(",");
            studentId = valuesArray[0];
            itemId = valuesArray[1];
            payment.setStudentId(studentId);
            payment.setItemId(itemId);
            if ("1".equals(paymentType)) {
                payment.setPaymentAmount(paymentAmount);
            }
            if ("2".equals(paymentType)) {
                payment.setRefundAmount(refundAmount);
            }
            payment.setPlanId(planId);
            paymentService.updatePaymentResult(payment);


        }

        return new Message(1, "保存成功", null);

    }


    /************************************************************/
    //【专业费用】

    //专业费用URL
    @RequestMapping("/payment/major")
    public ModelAndView toPaymentMajor() {
        ModelAndView mv = new ModelAndView();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());
        ;
        mv.addObject("year", year);
        mv.setViewName("/business/studentwork/payment/paymentMajorList");
        return mv;
    }

    //专业费用List
    @ResponseBody
    @RequestMapping("/payment/major/getPaymentPlanList")
    public Map getCostMajorList(CostMajor costMajor, String flag) {
        //String deptId=CommonUtil.getDefaultDept();
        if ("manage".equals(flag)) {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
            String year = formatDate.format(new java.util.Date());
            ;
            costMajor.setYear(year);
        }
        return CommonUtil.tableMap(paymentService.getCostMajorList(costMajor));
    }

    //设置招生计划页面
    @RequestMapping("/payment/major/addMajorCost")
    public ModelAndView addMajorCost(String majorId, String year) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("majorId", majorId);
        mv.addObject("year", year);
        mv.addObject("head", "设置专业费用");
        CostMajor costMajor = paymentService.selectCostMajorById(majorId, year);
        if (costMajor != null) {
            mv.addObject("costMajor", costMajor);
        }
        mv.setViewName("/business/studentwork/payment/addMajorCost");
        return mv;
    }

    //批量设置专业费用
    @RequestMapping("/payment/major/batchAddMajorCost")
    public ModelAndView batchAddMajorCost(String ids, String id, String year) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("ids", ids);
        mv.addObject("id", id);
        mv.addObject("hyear", year);
        mv.addObject("head", "批量设置专业费用");
        mv.setViewName("/business/studentwork/payment/batchAddMajorCost");
        return mv;
    }

    //保存设置专业费用
    @ResponseBody
    @RequestMapping("/payment/major/saveSingle")
    public Message saveSingle(CostMajor costMajor) {
        String majorId = costMajor.getMajorId();
        String year = costMajor.getYear();
        String fee = costMajor.getMajorFee();
        CostMajor old = paymentService.selectCostMajorById(majorId, year);
        if (old != null) {
            CommonUtil.update(costMajor);
            costMajor.setMajorId(majorId);
            costMajor.setMajorFee(fee);
            paymentService.updateCostMajor(costMajor);
        } else {
            Major major = majorService.getMajorByMajorId(majorId);
            costMajor.setId(CommonUtil.getUUID());
            costMajor.setDepartmentsId(major.getDepartmentsId());
            costMajor.setMajorId(majorId);
            costMajor.setMajorCode(major.getMajorCode());
            costMajor.setMajorDirection(major.getMajorDirection());
            costMajor.setSchoolSystem(major.getSchoolSystem());
            costMajor.setTrainingLevel(major.getTrainingLevel());
            costMajor.setMajorFee(fee);
            CommonUtil.save(costMajor);
            paymentService.saveCostMajor(costMajor);
        }
        return new Message(1, "保存成功", null);

    }

    //批量保存设置招生人数
    @ResponseBody
    @RequestMapping("/payment/major/saveMany")
    public Message saveManyPlan(String ids, String id, CostMajor costMajor) {
        String year = costMajor.getYear();
        String fee = costMajor.getMajorFee();
        String idArray[] = id.split(",");
        for (String majorId : idArray) {
            CostMajor old = paymentService.selectCostMajorById(majorId, year);
            if (old == null) {
                CostMajor newCostMajor = new CostMajor();
                Major major = majorService.getMajorByMajorId(majorId);
                newCostMajor.setId(CommonUtil.getUUID());
                newCostMajor.setMajorId(majorId);
                newCostMajor.setDepartmentsId(major.getDepartmentsId());
                newCostMajor.setMajorCode(major.getMajorCode());
                newCostMajor.setMajorDirection(major.getMajorDirection());
                newCostMajor.setSchoolSystem(major.getSchoolSystem());
                newCostMajor.setTrainingLevel(major.getTrainingLevel());
                newCostMajor.setYear(year);
                newCostMajor.setMajorFee(fee);
                CommonUtil.save(newCostMajor);
                paymentService.saveCostMajor(newCostMajor);
            } else {
                CostMajor encost = new CostMajor();
                encost.setMajorId(majorId);
                encost.setMajorFee(fee);
                encost.setYear(year);
                CommonUtil.update(encost);
                paymentService.updateCostMajor(encost);
            }
        }

        return new Message(1, "保存成功", null);

    }

    //删除专业费用信息
    @ResponseBody
    @RequestMapping("/payment/major/del")
    public Message delCostMajor(String id, String year) {
        CostMajor costMajor = new CostMajor();
        CostMajor old = paymentService.selectCostMajorById(id, year);
        if (old != null) {
            costMajor.setYear(year);
            costMajor.setMajorId(id);
            paymentService.deleteCostMajor(id, year);
            return new Message(0, "删除成功", null);
        } else {
            return new Message(1, "请先设置专业费用！", null);
        }


    }

    //批量删除招生计划
    @ResponseBody
    @RequestMapping("/payment/major/batchDelCost")
    public Message batchDelPlan(String ids, String id, String year) {
        CostMajor costMajor = new CostMajor();
        costMajor.setMajorId(ids);
        costMajor.setYear(year);
        paymentService.batchDeleteCostMajor(costMajor);
        return new Message(1, "批量删除成功", null);

    }

    //收费项目List
    @ResponseBody
    @RequestMapping("/payment/item/getCostItemList")
    public Map getCostItemList(CostItem costItem) {
        return CommonUtil.tableMap(paymentService.getCostItemList(costItem));
    }

    //新增收费项目
    @RequestMapping("/payment/item/toAdd")
    public String toAddCostItem(Model model) {
        model.addAttribute("head", "添加缴费项目");
        return "/business/studentwork/payment/editPaymentItem";
    }

    //修改收费项目
    @RequestMapping("/payment/item/toEdit")
    public String toeditPaymentItem(String costId, Model model) {
        model.addAttribute("cost", paymentService.selectCostItemByCostId(costId));
        model.addAttribute("head", "修改缴费项目");
        return "/business/studentwork/cost/editPaymentItem";
    }

    //保存收费项目
    @ResponseBody
    @RequestMapping("/payment/item/save")
    public Message saveCostItem(CostItem costItem) {
        if (null == costItem.getCostId() || costItem.getCostId() == "") {
            costItem.setCostId(CommonUtil.getUUID());
            CommonUtil.save(costItem);
            paymentService.saveCostItem(costItem);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(costItem);
            paymentService.updateCostItem(costItem);
            return new Message(0, "修改成功！", null);
        }

    }


    //删除收费项目
    @ResponseBody
    @RequestMapping("/payment/item/del")
    public Message delCostItem(String costId) {
        paymentService.deleteCostItem(costId);
        return new Message(1, "删除成功！", "success");
    }

    //删除缴费项目校验
    @ResponseBody
    @RequestMapping("/payment/item/checkPaymentItem")
    public Message checkPaymentItem(String itemId) {
        List<PaymentPlanItem> list = paymentService.checkPaymentItem(itemId);
        if (list.size() > 0) {
            return new Message(1, "此项目已关联缴费计划,不可删除!", null);
        } else {
            return new Message(0, null, null);
        }
    }

    //新生缴费导出数据
    @RequestMapping("/payment/exportNewStudentPayment")
    public void exportNewStudentPayment(HttpServletRequest request, HttpServletResponse response,
                                        EnrollmentStudent enrollmentStudent) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        List<EnrollmentStudent> studentList = paymentService.getNewStudentStandardList(enrollmentStudent);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(2, 30 * 256);
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("身份证号");
        row.createCell(1).setCellValue("姓名");
        row.createCell(2).setCellValue("系部");
        row.createCell(3).setCellValue("专业");
        row.createCell(4).setCellValue("班级");
        row.createCell(5).setCellValue("缴费项目");
        row.createCell(6).setCellValue("缴费标准(此项为必填项)");
        HSSFCellStyle cellStyle = wb.createCellStyle();
        tmp++;

        for (EnrollmentStudent studentobj : studentList) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
            HSSFRow.createCell(0).setCellValue(studentobj.getIdcard());
            HSSFRow.createCell(1).setCellValue(studentobj.getName());
            HSSFRow.createCell(2).setCellValue(studentobj.getDepartmentShow());
            HSSFRow.createCell(3).setCellValue(studentobj.getMajorShow());
            HSSFRow.createCell(4).setCellValue(studentobj.getClassShow());
            HSSFRow.createCell(5).setCellValue(studentobj.getPlanItemShow());
            HSSFRow.createCell(6).setCellValue(studentobj.getPaymentStandard());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("新生缴费基本信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //在籍学生缴费导出数据
    @RequestMapping("/payment/exportStatusStudentPayment")
    public void exportStatusStudentPayment(HttpServletRequest request, HttpServletResponse response, Student student) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //Student student = new Student();
        //student.setPlanId(planId);
        List<Student> studentList = paymentService.getStatusStudentStandardList(student);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(2, 30 * 256);
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("身份证号");
        row.createCell(1).setCellValue("姓名");
        row.createCell(2).setCellValue("系部");
        row.createCell(3).setCellValue("专业");
        row.createCell(4).setCellValue("班级");
        row.createCell(5).setCellValue("缴费项目");
        row.createCell(6).setCellValue("缴费标准(此项为必填项)");

        tmp++;

        for (Student studentobj : studentList) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
            HSSFRow.createCell(0).setCellValue(studentobj.getIdcard());
            HSSFRow.createCell(1).setCellValue(studentobj.getName());
            HSSFRow.createCell(2).setCellValue(studentobj.getDepartmentShow());
            HSSFRow.createCell(3).setCellValue(studentobj.getMajorShow());
            HSSFRow.createCell(4).setCellValue(studentobj.getClassShow());
            HSSFRow.createCell(5).setCellValue(studentobj.getPlanItemShow());
            HSSFRow.createCell(6).setCellValue(studentobj.getPaymentStandard());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("在籍学生缴费基本信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //导出缴费信息数据
    @RequestMapping("/payment/exportInfoStudentPayment")
    public void exportInfoStudentPayment(HttpServletRequest request, HttpServletResponse response,
                                         Student student, String flag) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //Student student = new Student();
        //student.setPlanId(planId);
        List<Student> studentList = paymentService.getPaymentInfoStandardList(student);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(2, 30 * 256);
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("身份证号");
        row.createCell(1).setCellValue("姓名");
        row.createCell(2).setCellValue("系部");
        row.createCell(3).setCellValue("专业");
        row.createCell(4).setCellValue("班级");
        row.createCell(5).setCellValue("缴费项目");
        row.createCell(6).setCellValue("缴费标准");
        if (flag.equals("1")) {
            row.createCell(7).setCellValue("缴费金额(此项为必填项)");
        } else {
            row.createCell(7).setCellValue("缴费金额");
        }

        row.createCell(8).setCellValue("退费金额");

        tmp++;

        for (Student studentobj : studentList) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
            HSSFRow.createCell(0).setCellValue(studentobj.getIdcard());
            HSSFRow.createCell(1).setCellValue(studentobj.getName());
            HSSFRow.createCell(2).setCellValue(studentobj.getDepartmentShow());
            HSSFRow.createCell(3).setCellValue(studentobj.getMajorShow());
            HSSFRow.createCell(4).setCellValue(studentobj.getClassShow());
            HSSFRow.createCell(5).setCellValue(studentobj.getPlanItemShow());
            HSSFRow.createCell(6).setCellValue(studentobj.getPaymentStandard());
            HSSFRow.createCell(7).setCellValue(studentobj.getPaymentAmount());
            HSSFRow.createCell(8).setCellValue(studentobj.getRefundAmount());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("缴费综合信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //导入弹窗页面
    @RequestMapping("/payment/toImportPayment")
    public ModelAndView toImportPayment(String planId, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/payment/toImportPayment");
        mv.addObject("planId", planId);
        mv.addObject("flag", flag);
        return mv;
    }

    //导入新生缴费标准
    @ResponseBody
    @RequestMapping("/payment/importNewStudentPayment")
    public Message importNewStudentPayment(@RequestParam(value = "file", required = false) CommonsMultipartFile file,
                                           @RequestParam("planId") String planId) {
        int count = 0;
        int errorCount = 0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            String className = "";
            for (int i = 1; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                String idcard = row.getCell(0).toString();
                HSSFCell classcell = row.getCell(4);
                String itemName = row.getCell(5).toString();
                String itemId = "";
                List<Select2> itemList = commonService.getUserDict("JFXM");
                for (Select2 item : itemList) {
                    if (item.getText().equals(itemName)) {
                        itemId = item.getId();
                    }
                }
                HSSFCell paycell = row.getCell(6);
                List<EnrollmentStudent> enrollmentStudents = enrollmentService.checkEnrollmentIdCard(idcard);
                List<PaymentResult> checkList = paymentService.findPaymentResultListByIds(idcard, itemId);
                if (enrollmentStudents.size() > 0 && checkList.size() > 0) {//判断学生是否合法（合法-导入；不合法-忽略）
                    //缴费结果之前设置过(修改)
                    PaymentResult paymentResult = new PaymentResult();
                    paymentResult.setStudentId(idcard);
                    paymentResult.setPlanId(planId);
                    if (paycell == null) {

                    } else {
                        paymentResult.setPaymentStandard(paycell.toString());
                        paymentResult.setItemId(itemId);
                        CommonUtil.update(paymentResult);
                        paymentResult.setPlanId(planId);
                        paymentService.updatePaymentResult(paymentResult);
                        count++;
                    }

                } else {
                    if (paycell != null) {
                        PaymentResult paymentResult = new PaymentResult();
                        for (Select2 item : itemList) {
                            if (item.getText().indexOf(itemName) != -1) {
                                paymentResult.setItemId(item.getId());
                            }
                        }

                        if (classcell == null) {

                        } else {
                            className = classcell.toString();
                            ClassBean classBean = classService.selectClassBeranByClassName(className, "");
                            if (classBean == null) {

                            } else {
                                paymentResult.setClassId(classBean.getClassId());


                            }
                        }
                        paymentResult.setPaymentAmount(paycell.toString());
                        paymentResult.setPaymentStandard(paycell.toString());
                        paymentResult.setId(CommonUtil.getUUID());
                        paymentResult.setStudentId(idcard);
                        paymentResult.setPlanId(planId);
                        CommonUtil.save(paymentResult);
                        paymentService.savePaymentResult(paymentResult);
                        count++;
                    } else {
                        errorCount++;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        if (count == 0) {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "error");
            } else {
                return new Message(1, "共计" + count + "条导入成功!", "error");
            }

        } else {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "success");
            } else {
                return new Message(1, "共计" + count + "条，导入成功！", "success");
            }
        }

    }

    //导入在籍学生缴费标准
    @ResponseBody
    @RequestMapping("/payment/importStatusStudentPayment")
    public Message importStatusStudentPayment(@RequestParam(value = "file", required = false) CommonsMultipartFile file,
                                              @RequestParam("planId") String planId) {
        int count = 0;
        int errorCount = 0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            String className = "";
            for (int i = 1; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                String idcard = row.getCell(0).toString();
                HSSFCell classcell = row.getCell(4);
                String itemName = row.getCell(5).toString();
                String itemId = "";
                List<Select2> itemList = commonService.getUserDict("JFXM");
                for (Select2 item : itemList) {
   /*                 if (item.getText().indexOf(itemName)!=-1) {
                        itemId= item.getId();
                    }*/
                    if (item.getText().equals(itemName)) {
                        itemId = item.getId();
                    }
                }
                HSSFCell paycell = row.getCell(6);
                List<EnrollmentStudent> enrollmentStudents = enrollmentService.checkEnrollmentIdCard(idcard);
                List<PaymentResult> checkList = paymentService.findPaymentResultListByIds(idcard, itemId);
                if (checkList.size() > 0) {//判断学生是否合法（合法-导入；不合法-忽略）
                    //缴费结果之前设置过(修改)
                    PaymentResult paymentResult = new PaymentResult();
                    paymentResult.setStudentId(idcard);
                    if (paycell == null) {

                    } else {
                        paymentResult.setPaymentStandard(paycell.toString());
                        paymentResult.setItemId(itemId);
                        paymentResult.setPlanId(planId);
                        CommonUtil.update(paymentResult);
                        paymentService.updatePaymentResult(paymentResult);
                        count++;
                    }

                } else {
                    if (paycell != null) {
                        PaymentResult paymentResult = new PaymentResult();
                        for (Select2 item : itemList) {
                            if (item.getText().indexOf(itemName) != -1) {
                                paymentResult.setItemId(item.getId());
                            }
                        }

                        paymentResult.setClassId(classcell.toString());
                        paymentResult.setPaymentStandard(paycell.toString());
                        paymentResult.setId(CommonUtil.getUUID());
                        paymentResult.setStudentId(idcard);
                        paymentResult.setPlanId(planId);
                        CommonUtil.save(paymentResult);
                        paymentService.savePaymentResult(paymentResult);
                        count++;
                    } else {
                        errorCount++;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        if (count == 0) {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "error");
            } else {
                return new Message(1, "导入失败!", "error");
            }

        } else {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "success");
            } else {
                return new Message(1, "共计" + count + "条，导入成功！", "success");
            }
        }

    }


    //导入缴费信息缴费标准（包括退费）
    @ResponseBody
    @RequestMapping("/payment/importInfoStudentPayment")
    public Message importInfoStudentPayment(@RequestParam(value = "file", required = false) CommonsMultipartFile file,
                                            @RequestParam("planId") String planId) {
        int count = 0;
        int errorCount = 0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            String className = "";
            for (int i = 1; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                String idcard = row.getCell(0).toString();
                HSSFCell classcell = row.getCell(4);
                String itemName = row.getCell(5).toString();
                String itemId = "";
                List<Select2> itemList = commonService.getUserDict("JFXM");
                for (Select2 item : itemList) {
                    if (item.getText().equals(itemName)) {
                        itemId = item.getId();
                    }
                }
                HSSFCell paycell = row.getCell(7);
                HSSFCell refundcell = row.getCell(8);
                List<EnrollmentStudent> enrollmentStudents = enrollmentService.checkEnrollmentIdCard(idcard);
                List<PaymentResult> checkList = paymentService.findPaymentResultListByIds(idcard, itemId);
                if (enrollmentStudents.size() > 0 && checkList.size() > 0) {//判断学生是否合法（合法-导入；不合法-忽略）
                    //缴费结果之前设置过(修改)
                    PaymentResult paymentResult = new PaymentResult();
                    paymentResult.setStudentId(idcard);
                    if (paycell == null) {

                    } else {
                        if (refundcell != null) {
                            paymentResult.setRefundAmount(refundcell.toString());
                        }
                        paymentResult.setPaymentAmount(paycell.toString());
                        paymentResult.setItemId(itemId);
                        CommonUtil.update(paymentResult);
                        paymentService.updatePaymentResult(paymentResult);
                        count++;
                    }


                } else {
                    if (paycell != null) {
                        PaymentResult paymentResult = new PaymentResult();
                        for (Select2 item : itemList) {
                            if (item.getText().indexOf(itemName) != -1) {
                                paymentResult.setItemId(item.getId());
                            }
                        }

                        paymentResult.setClassId(classcell.toString());
                        if (refundcell != null) {
                            paymentResult.setPaymentStandard(refundcell.toString());
                        }
                        paymentResult.setPaymentAmount(paycell.toString());
                        paymentResult.setId(CommonUtil.getUUID());
                        paymentResult.setStudentId(idcard);
                        paymentResult.setPlanId(planId);
                        CommonUtil.save(paymentResult);
                        paymentService.savePaymentResult(paymentResult);
                        count++;
                    } else {
                        errorCount++;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        if (count == 0) {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "error");
            } else {
                return new Message(1, "共计" + count + "条导入成功!", "error");
            }

        } else {
            if (errorCount > 0) {
                return new Message(1, "共计" + count + "条导入成功," + (errorCount) + "条数据异常！", "success");
            } else {
                return new Message(1, "共计" + count + "条，导入成功！", "success");
            }
        }

    }


}
