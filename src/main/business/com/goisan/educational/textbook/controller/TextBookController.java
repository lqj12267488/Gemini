package com.goisan.educational.textbook.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.competition.bean.CompetitionRequest;
import com.goisan.educational.skill.bean.Skill;
import com.goisan.educational.textbook.bean.*;
import com.goisan.educational.textbook.service.TextBookLogService;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.service.ParameterService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/textbook")
public class TextBookController {

    @Resource
    private TextBookService textBookService;
    @Resource
    private StudentService studentService;
    @Resource
    private TextBookLogService textBookLogService;
    @Resource
    private ParameterService parameterService;

    /**
     * @param type
     * @param model
     * @Description 专业教材/公共教材管理页面
     * @author FanNing
     */
    @RequestMapping("/toTextBook")
    public String toTextBook(String type, Model model) {
        model.addAttribute("type", type);
        if ("1".equals(type)) {
            return "business/educational/textbook/publicTextBookList";
        } else {
            return "business/educational/textbook/textBookList";
        }
    }

    /**
     * @param textBook
     * @Description 获取教材list
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookList")
    public Map<String, Object> getTextBookList(TextBook textBook, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookList = new HashMap<String, Object>();
        textBook.setCreateDept(CommonUtil.getDefaultDept());
        textBook.setLevel(CommonUtil.getLoginUser().getLevel());
        List<TextBook> list = textBookService.getTextBookList(textBook);
        PageInfo<List<TextBook>> info = new PageInfo(list);
        textBookList.put("draw", draw);
        textBookList.put("recordsTotal", info.getTotal());
        textBookList.put("recordsFiltered", info.getTotal());
        textBookList.put("data", list);
        return textBookList;
    }

    /**
     * @param type
     * @param model
     * @Description 专业教材/公共教材新增
     * @author FanNing
     */
    @RequestMapping("/toAddTextBook")
    public String toAddTextBook(String type, Model model) {
        model.addAttribute("type", type);
        model.addAttribute("head", "新增");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        TextBook textBook = new TextBook();
        textBook.setVersionDate(date);
        model.addAttribute("textBook", textBook);
        if ("1".equals(type)) {
            return "business/educational/textbook/publicEditTextBook";
        } else {
            return "business/educational/textbook/editTextBook";
        }
    }

    /**
     * @param textBook
     * @Description 专业教材/公共教材新增修改保存方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/saveTextBook")
    public Message saveTextBook(TextBook textBook) {
        if ("".equals(textBook.getTextbookId())) {
            List<TextBook> list = textBookService.getTextBookByTextBook(textBook);
            textBook.setTextbookId(CommonUtil.getUUID());
            if(list.size()>0){
                return new Message(0, "添加失败，教材重复！", null);
            }else{
                CommonUtil.save(textBook);
                textBookService.saveTextBook(textBook);
                return new Message(1, "添加成功！", null);
            }
        } else {
            List<TextBook> list = textBookService.getTextBookByTextBook(textBook);
            if(list.size()>0){
                return new Message(0, "修改失败，教材重复！", null);
            }else{
                CommonUtil.update(textBook);
                textBookService.updateTextBook(textBook);
                return new Message(1, "修改成功！", null);
            }
        }

    }

    /**
     * @param id
     * @param type
     * @param model
     * @Description 修改专业/公共教材页面
     * @author FanNing
     */
    @RequestMapping("/toEditTextBook")
    public String toEditTextBook(String id, String type, Model model) {
        model.addAttribute("textbook", textBookService.getTextBookById(id));
        model.addAttribute("head", "修改");
        if ("1".equals(type)) {
            return "business/educational/textbook/publicEditTextBook";
        } else {
            return "business/educational/textbook/editTextBook";
        }
    }

    /**
     * @param id
     * @Description 专业/公共教材删除方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/delTextBook")
    public Message delTextBook(String id) {
        List size = textBookService.isExistInTextBook(id);
        if (size.size() > 0) {
            return new Message(0, "该教材数据已经被引用，不可以被删除！", "error");
        } else {
            textBookService.delTextBook(id);
            //菜单,按钮权限删除
            return new Message(1, "删除成功！", "success");
        }
    }

    /**
     * @param request
     * @param response
     * @Description 公共教材信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBook")
    public void exportTextBook(HttpServletRequest request, HttpServletResponse response) {
        TextBook textBook = new TextBook();
        String textbookType = request.getParameter("textbookType");
        textBook.setTextbookType(textbookType);
        List<TextBook> textBookList = textBookService.getTextBookList(textBook);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("公共基础教材信息表");

        //创建HSSFRow对象
        int tmp = 0;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("教材编号");
        row1.createCell(3).setCellValue("教材性质");
        row1.createCell(4).setCellValue("出版社");
        row1.createCell(5).setCellValue("主编");
        row1.createCell(6).setCellValue("版次");
        row1.createCell(7).setCellValue("单价（元）");
        row1.createCell(8).setCellValue("折扣");
        row1.createCell(9).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBook textBookObj : textBookList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookObj.getTextbookName());
            row.createCell(2).setCellValue(textBookObj.getTextbookNumber());
            row.createCell(3).setCellValue(textBookObj.getTextbookNature());
            row.createCell(4).setCellValue(textBookObj.getPublishingHouse());
            row.createCell(5).setCellValue(textBookObj.getEditor());
            row.createCell(6).setCellValue(textBookObj.getEdition());
            row.createCell(7).setCellValue(textBookObj.getPrice());
            row.createCell(8).setCellValue(textBookObj.getDiscount());
            row.createCell(9).setCellValue(textBookObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("公共基础教材信息表.xls", "utf-8"));
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

    /**
     * @param request
     * @param response
     * @Description 专业教材信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportMajorTextBook")
    public void exportMajorTextBook(HttpServletRequest request, HttpServletResponse response) {
        TextBook textBook = new TextBook();
        String textbookType = request.getParameter("textbookType");
        textBook.setTextbookType(textbookType);
        List<TextBook> textBookList = textBookService.getTextBookList(textBook);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("专业教材信息表");

        //创建HSSFRow对象
        int tmp = 0;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("教材编号");
        row1.createCell(3).setCellValue("教材性质");
        row1.createCell(4).setCellValue("系部");
        row1.createCell(5).setCellValue("专业");
        row1.createCell(6).setCellValue("培养层次");
        row1.createCell(7).setCellValue("出版社");
        row1.createCell(8).setCellValue("主编");
        row1.createCell(9).setCellValue("版次");
        row1.createCell(10).setCellValue("单价（元）");
        row1.createCell(11).setCellValue("折扣");
        row1.createCell(12).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBook textBookObj : textBookList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookObj.getTextbookName());
            row.createCell(2).setCellValue(textBookObj.getTextbookNumber());
            row.createCell(3).setCellValue(textBookObj.getTextbookNature());
            row.createCell(4).setCellValue(textBookObj.getDepartmentsId());
            row.createCell(5).setCellValue(textBookObj.getMajorCode());
            row.createCell(6).setCellValue(textBookObj.getTrainingLevel());
            row.createCell(7).setCellValue(textBookObj.getPublishingHouse());
            row.createCell(8).setCellValue(textBookObj.getEditor());
            row.createCell(9).setCellValue(textBookObj.getEdition());
            row.createCell(10).setCellValue(textBookObj.getPrice());
            row.createCell(11).setCellValue(textBookObj.getDiscount());
            row.createCell(12).setCellValue(textBookObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("专业教材信息表.xls", "utf-8"));
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

    /**
     * @param deptId
     * @Description 根据系部Id获取系部下专业
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getMajorByDeptId")
    public List<Select2> getMajorByDeptId(String deptId) {
        return textBookService.getMajorByDeptId(deptId);
    }

    /**
     * @Description 教材计划页面
     * @author FanNing
     */
    @RequestMapping("/textBookPlanList")
    public ModelAndView TextBookPlanList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookPlanList");
        return mv;
    }

    /**
     * @param textBookPlan
     * @Description 教材计划维护
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookPlanList")
    public Map<String, List<TextBookPlan>> getTextBookPlanList(TextBookPlan textBookPlan) {
        Map<String, List<TextBookPlan>> textBookPlanMap = new HashMap<String, List<TextBookPlan>>();
        textBookPlanMap.put("data", textBookService.textBookPlanList(textBookPlan));
        return textBookPlanMap;
    }

    /**
     * @Description 新增教材计划
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/addTextBookPlan")
    public ModelAndView addTextBookPlan() {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editTextBookPlan");
        TextBookPlan textBookPlan = new TextBookPlan();
        mv.addObject("textBookPlan", textBookPlan);
        mv.addObject("head", "新增");
        return mv;
    }

    /**
     * @param id
     * @Description 教材计划修改页面
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/editTextBookPlan")
    public ModelAndView editTextBookPlan(String id) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editTextBookPlan");
        TextBookPlan textBookPlan = textBookService.getTextBookPlanById(id);
        mv.addObject("head", "修改");
        mv.addObject("textBookPlan", textBookPlan);
        return mv;
    }

    /**
     * @param textBookPlan
     * @Description 教材计划新增修改保存方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/saveTextBookPlan")
    public Message saveTextBookPlan(TextBookPlan textBookPlan) {
        if (textBookPlan.getId() == null || textBookPlan.getId().equals("") || textBookPlan.getId() == "") {
            textBookPlan.setCreator(CommonUtil.getPersonId());
            textBookPlan.setCreateDept(CommonUtil.getDefaultDept());
            textBookService.insertTextBookPlan(textBookPlan);
            return new Message(1, "新增成功！", null);
        } else {
            textBookPlan.setChanger(CommonUtil.getPersonId());
            textBookPlan.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            textBookService.updateTextBookPlan(textBookPlan);
            return new Message(1, "修改成功！", "success");
        }
    }

    /**
     * @param id
     * @Description 教材计划删除方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/deleteTextBookPlanById")
    public Message deleteTextBookPlanById(String id) {
        List size = textBookService.isExistInTextBookPlan(id);
        if (size.size() > 0) {
            return new Message(1, "该教材计划数据已经被引用，不可以被删除！", "error");
        } else {
            textBookService.deleteTextBookPlanById(id);
            //菜单,按钮权限删除
            return new Message(1, "删除成功！", "success");
        }
    }

    /**
     * @param textbookPlanId
     * @Description 判断当前日期是否在本教材计划起止时间内
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/checkTextbookPlanByTime")
    public Message checkTextbookPlanByTime(String textbookPlanId) throws ParseException {
        TextBookPlan textbookPlan = textBookService.checkTextbookPlanByTime(textbookPlanId);
        String startTime = textbookPlan.getStartTime();
        String endTime = textbookPlan.getEndTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟
        Date start = sdf.parse(startTime);
        Date end = sdf.parse(endTime);
        Calendar cal = Calendar.getInstance();
        Date now = cal.getTime();
        return new Message(1, "", null);

    }

    /**
     * @Description 通过当前登录人系部下所在专业信息
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getMajorByMajorPrincipal")
    public List<Select2> getMajorByMajorPrincipal() {
        String majorPrincipal = CommonUtil.getLoginUser().getDefaultDeptId();
        String studentId = CommonUtil.getPersonId();
        String s = textBookService.getUserTypeByPersonId(CommonUtil.getPersonId());
        String departmentsId = "";
        if ("0".equals(s)) {
            departmentsId = CommonUtil.getDefaultDept();
        } else if ("1".equals(s)) {
            departmentsId = studentService.getDepartmentsIdByStudentId(studentId);
        }
        return textBookService.getMajorByMajorPrincipal(departmentsId);
    }

    /**
     * @Description 学生教材申报列表页
     * @author FanNing
     */
    @RequestMapping("/textBookDeclareList")
    public ModelAndView textBookDeclareList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookDeclareList");
        mv.addObject("personType", "0");
        return mv;
    }

    /**
     * @Description 教师教材申报列表页
     * @author FanNing
     */
    @RequestMapping("/textBookTeacherDeclareList")
    public ModelAndView textBookTeacherDeclareList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookTeacherDeclareList");
        mv.addObject("personType", "1");
        return mv;
    }

    /**
     * @param textBookStatistics
     * @Description 教材结款明细list
     * @author FanNing
     */
   /* @ResponseBody
    @RequestMapping("/getTextbookPaymentList")
    public Map<String, List<TextBookStatistics>> getTextbookPaymentList(TextBookStatistics textBookStatistics) {
        Map<String, List<TextBookStatistics>> textBookStatisticsMap = new HashMap<String, List<TextBookStatistics>>();
//        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
//        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatisticsMap.put("data", textBookService.getTextbookPaymentList(textBookStatistics));
        return textBookStatisticsMap;
    }*/


    /**
     * @param textBookDeclare
     * @Description 获取结款明细list
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookDeclareList")
    public Map<String, Object> getTextBookDeclareList(TextBookDeclare textBookDeclare, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookDeclareList = new HashMap<String, Object>();
        textBookDeclare.setCreateDept(CommonUtil.getDefaultDept());
        textBookDeclare.setLevel(CommonUtil.getLoginUser().getLevel());
        if("".equals(textBookDeclare.getMajorId())|| null == textBookDeclare.getMajorId()){

        }else{
            String [] strings =textBookDeclare.getMajorId().split(",");
            textBookDeclare.setMajorId(strings[0]);
        }


        List<TextBookDeclare> list = textBookService.textBookDeclareList(textBookDeclare);
        PageInfo<List<TextBookDeclare>> info = new PageInfo(list);
        textBookDeclareList.put("draw", draw);
        textBookDeclareList.put("recordsTotal", info.getTotal());
        textBookDeclareList.put("recordsFiltered", info.getTotal());
        textBookDeclareList.put("data", list);
        return textBookDeclareList;
    }


    /**
     * @Description 学生/教师教材申报新增页面
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/addTextBookDeclare")
    public ModelAndView addTextBookDeclare(String personType) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editTextBookDeclare");
        TextBookDeclare textBookDeclare = new TextBookDeclare();
        textBookDeclare.setPersonType(personType);
        mv.addObject("textBookDeclare", textBookDeclare);
        mv.addObject("head", "新增");
        return mv;
    }


    /**
     * @param id
     * @Description 学生/教师教材申报修改页面
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/editTextBookDeclare")
    public ModelAndView editTextBookDeclare(String id, String personType) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editTextBookDeclare");
        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(id);
        textBookDeclare.setPersonType(personType);
        String majorPrincipal = CommonUtil.getPersonId();
        mv.addObject("majorPrincipal", majorPrincipal);
        mv.addObject("head", "修改");
        mv.addObject("textBookDeclare", textBookDeclare);
        return mv;
    }

    /**
     * @param textBookDeclare
     * @Description 学生/教师教材申报保存方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/saveTextBookDeclare")
    public Message saveTextBookDeclare(TextBookDeclare textBookDeclare) {
        if (textBookDeclare.getId() == null || textBookDeclare.getId().equals("") || textBookDeclare.getId() == "") {
            textBookDeclare.setCreator(CommonUtil.getPersonId());
            textBookDeclare.setCreateDept(CommonUtil.getDefaultDept());
            textBookDeclare.setTerm(parameterService.getParameterValue());
            textBookService.insertTextBookDeclare(textBookDeclare);
            return new Message(1, "新增成功！", null);
        } else {
            textBookDeclare.setChanger(CommonUtil.getPersonId());
            textBookDeclare.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            textBookService.updateTextBookDeclare(textBookDeclare);
            return new Message(1, "修改成功！", "success");
        }
    }

    /**
     * @param id
     * @Description 教材申报删除方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/deleteTextBookDeclareById")
    public Message deleteTextBookDeclareById(String id) {
        List<TextBookDeclare> list = textBookService.getTextBookDeclareByDeclareId(id);
        if(list.size()>0){
            return new Message(0, "删除失败，申报信息已提交不能删除！", "success");
        }else {
            textBookService.deleteTextBookDeclareById(id);
            //菜单,按钮权限删除
            return new Message(1, "删除成功！", "success");
        }

    }

    /**
     * @param
     * @Description 教材申报提交方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/submitTextBookDeclareById")
    public Message submitTextBookDeclareById(TextBookDeclare tbd) {
        textBookService.submitTextBookDeclareById(tbd.getId());
        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(tbd.getId());
        TextBook textBook = textBookService.getTextBookById(textBookDeclare.getTextbookId());
        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setTextbookId(textBookDeclare.getTextbookId());
        textBookStatistics.setSubscribeCode(textBook.getSubscribeCode());
        textBookStatistics.setPersonType(tbd.getPersonType());

        //单价
        Integer price;
        //总价
        Integer num;
        if (textBook.getPrice() == null || textBook.getPrice().equals("")) {
            price = 0;
        } else {
            price = Integer.parseInt(textBook.getPrice());
        }
        if (textBookDeclare.getDeclareNum() == null || textBookDeclare.getDeclareNum().equals("")) {
            num = 0;
        } else {
            num = Integer.parseInt(textBookDeclare.getDeclareNum());
        }
        textBookStatistics.setTotal(String.valueOf(price * num));
        textBookStatistics.setDeclareNum(textBookDeclare.getDeclareNum());
        textBookStatistics.setActualNum(textBookDeclare.getDeclareNum());
        textBookStatistics.setPersonType(tbd.getPersonType());
        textBookStatistics.setDeclareId(tbd.getId());
        textBookService.insertTextBookStatistics(textBookStatistics);
        TextBookOrderLog textBookOrderLog = new TextBookOrderLog();
        textBookOrderLog.setDiscount("1");
        textBookOrderLog.setTextbookId(textBookStatistics.getTextbookId());
        textBookOrderLog.setDeclareId(textBookStatistics.getDeclareId());
        textBookOrderLog.setCreator(CommonUtil.getPersonId());
        textBookOrderLog.setCreateDept(CommonUtil.getDefaultDept());
        textBookOrderLog.setActualNum(textBookStatistics.getActualNum());
        textBookOrderLog.setTerm(parameterService.getParameterValue());
        textBookOrderLog.setPersonType(tbd.getPersonType());
        textBookService.insertTextbookOrderLog(textBookOrderLog);
        return new Message(1, "提交成功！", "success");
    }

    /**
     * @param textbookId
     * @Description 教材申报详情
     * @author FanNing
     */
    @RequestMapping("/showTextBookDeclareDetails")
    public ModelAndView returnList(String textbookId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/showTextBookDeclareDetail");
        mv.addObject("textbookId", textbookId);
        return mv;
    }

    /**
     * @param textbookId
     * @Description 教材申报详情
     * @author FanNing
     */
    @RequestMapping("/showTextBookTeacherDeclareDetails")
    public ModelAndView showTextBookTeacherDeclareDetails(String textbookId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/showTextBookTeacherDeclareDetail");
        mv.addObject("textbookId", textbookId);
        return mv;
    }

    /**
     * @param request
     * @param response
     * @Description 学生教材征订信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBookDeclare")
    public void exportTextBookDeclare(HttpServletRequest request, HttpServletResponse response, String departmentsId, String majorCode, String textbookName, String classId) {
        TextBookDeclare textBookDeclare = new TextBookDeclare();
        textBookDeclare.setSubmitState("1");
        textBookDeclare.setPersonType("0");
        List<TextBookDeclare> textBookLogList = textBookService.textBookDeclareList(textBookDeclare);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("学生教材征订信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 8, (short) 5000);
        sheet.setColumnWidth((short) 9, (short) 5000);
        sheet.setColumnWidth((short) 10, (short) 5000);
        sheet.setColumnWidth((short) 11, (short) 5000);
        int tmp = 0;
//        HSSFRow row2 = sheet.createRow(tmp);
//        row2.createCell(0).setCellValue("");
//        row2.createCell(1).setCellValue("");
//        row2.createCell(2).setCellValue("");
//        row2.createCell(3).setCellValue("");
//        row2.createCell(4).setCellValue("");
//        row2.createCell(5).setCellValue("");
//        row2.createCell(6).setCellValue("");
//        row2.createCell(7).setCellValue("");
//        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("专业名称");
        row1.createCell(2).setCellValue("培养层次");
        row1.createCell(3).setCellValue("班级名称");
        row1.createCell(4).setCellValue("课程名称");
        row1.createCell(5).setCellValue("教材名称");
        row1.createCell(6).setCellValue("申报数量");
        row1.createCell(7).setCellValue("所属学院");
        row1.createCell(8).setCellValue("系部");
        row1.createCell(9).setCellValue("年级");
        row1.createCell(10).setCellValue("单价");
        row1.createCell(11).setCellValue("圈订人");
        tmp++;
        int i = 1;
        for (TextBookDeclare textBookDeclareObj : textBookLogList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookDeclareObj.getMajorIdShow());
            row.createCell(2).setCellValue(textBookDeclareObj.getTrainingLevel());
            row.createCell(3).setCellValue(textBookDeclareObj.getClassIdShow());
            row.createCell(4).setCellValue(textBookDeclareObj.getCourseId());
            row.createCell(5).setCellValue(textBookDeclareObj.getTextbookId());
            row.createCell(6).setCellValue(textBookDeclareObj.getDeclareNum());
            row.createCell(7).setCellValue(textBookDeclareObj.getCollegeShow());
            row.createCell(8).setCellValue(textBookDeclareObj.getDepartmentsIdShow());
            row.createCell(9).setCellValue(textBookDeclareObj.getGradeId());
            row.createCell(10).setCellValue(textBookDeclareObj.getUnitPrice());
            row.createCell(11).setCellValue(textBookDeclareObj.getBoundPerson());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("学生教材征订信息表.xls", "utf-8"));
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

    /**
     * @param request
     * @param response
     * @Description 教材入库信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBookTeacherDeclare")
    public void exportTextBookTeacherDeclare(HttpServletRequest request, HttpServletResponse response) {
        TextBookDeclare textBookDeclare = new TextBookDeclare();
        textBookDeclare.setSubmitState("1");
        textBookDeclare.setPersonType("1");
        List<TextBookDeclare> textBookLogList = textBookService.textBookDeclareList(textBookDeclare);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教师教材征订信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 8, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 9, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 10, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 11, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 12, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 13, (short) 5000);// 空列设置小一些
        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("");
        row2.createCell(1).setCellValue("");
        row2.createCell(2).setCellValue("");
        row2.createCell(3).setCellValue("");
        row2.createCell(4).setCellValue("");
        row2.createCell(5).setCellValue("");
        row2.createCell(6).setCellValue("");
        row2.createCell(7).setCellValue("");
        row2.createCell(8).setCellValue("");
        row2.createCell(9).setCellValue("");
        row2.createCell(10).setCellValue("");
        row2.createCell(11).setCellValue("");
        row2.createCell(12).setCellValue("");
        row2.createCell(13).setCellValue("");
        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("所属学院");
        row1.createCell(2).setCellValue("专业名称");
        row1.createCell(3).setCellValue("培养层次");
        row1.createCell(4).setCellValue("申报人");
        row1.createCell(5).setCellValue("课程名称");
        row1.createCell(6).setCellValue("教材名称");
        row1.createCell(7).setCellValue("预定数量");
        row1.createCell(8).setCellValue("系部");
        row1.createCell(9).setCellValue("班级名称");
        row1.createCell(10).setCellValue("单价");
        row1.createCell(11).setCellValue("圈订人");
        row1.createCell(12).setCellValue("教材使用者");
        row1.createCell(13).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBookDeclare textBookDeclareObj : textBookLogList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookDeclareObj.getCollegeShow());
            row.createCell(2).setCellValue(textBookDeclareObj.getMajorIdShow());
            row.createCell(3).setCellValue(textBookDeclareObj.getTrainingLevel());
            row.createCell(4).setCellValue(textBookDeclareObj.getCreator());
            row.createCell(5).setCellValue(textBookDeclareObj.getCourseId());
            row.createCell(6).setCellValue(textBookDeclareObj.getTextbookId());
            row.createCell(7).setCellValue(textBookDeclareObj.getDeclareNum());
            row.createCell(8).setCellValue(textBookDeclareObj.getDepartmentsIdShow());
            row.createCell(9).setCellValue(textBookDeclareObj.getClassIdShow());
            row.createCell(10).setCellValue(textBookDeclareObj.getUnitPrice());
            row.createCell(11).setCellValue(textBookDeclareObj.getBoundPerson());
            row.createCell(12).setCellValue(textBookDeclareObj.getTextbookUser());
            row.createCell(13).setCellValue(textBookDeclareObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教师教材征订信息表.xls", "utf-8"));
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

    /**
     * @Description 学生教材发放列表页
     * @author FanNing
     */
    @RequestMapping("/textBookReleaseList")
    public ModelAndView textBookReleaseList(String personType,String textbookId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookReleaseStatisticsList");
        mv.addObject("textbookId",textbookId);
        mv.addObject("personType",personType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exportTextBookReleaseList")
    public void exportTextBookReleaseList(HttpServletRequest request, HttpServletResponse response) {
        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setPersonType("0");
        List<TextBookStatistics> textBookStatisticsList = textBookService.textBookStatisticsList(textBookStatistics);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("学生教材发放信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("");
        row2.createCell(1).setCellValue("");
        row2.createCell(2).setCellValue("");
        row2.createCell(3).setCellValue("");
        row2.createCell(4).setCellValue("");
        row2.createCell(5).setCellValue("");
        row2.createCell(6).setCellValue("");
        row2.createCell(7).setCellValue("");
        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("单价");
        row1.createCell(3).setCellValue("预定数量");
        row1.createCell(4).setCellValue("库存数量");
        row1.createCell(5).setCellValue("实订数量");
        row1.createCell(6).setCellValue("折扣");
        row1.createCell(7).setCellValue("折后总金额");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookStatisticsObj : textBookStatisticsList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookStatisticsObj.getTextbookName());
            row.createCell(2).setCellValue(textBookStatisticsObj.getUnitPrice());
            row.createCell(3).setCellValue(textBookStatisticsObj.getDeclareNum());
            row.createCell(4).setCellValue(textBookStatisticsObj.getRemainderNum());
            row.createCell(5).setCellValue(textBookStatisticsObj.getTextbookNumIn());
            row.createCell(6).setCellValue(textBookStatisticsObj.getDiscount());
            row.createCell(7).setCellValue(textBookStatisticsObj.getTotal());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("学生教材发放信息表.xls", "utf-8"));
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

    /**
     * @param request
     * @param response
     * @Description 教材入库信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBookRelease")
    public void exportTextBookRelease(HttpServletRequest request, HttpServletResponse response, String departmentsId, String majorId, String classId) {
        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setPersonType("0");
        textBookStatistics.setDepartmentsId(departmentsId);
        textBookStatistics.setMajorId(majorId);
        textBookStatistics.setClassId(classId);
        List<TextBookStatistics> textBookStatisticsList = textBookService.textBookStatisticsList(textBookStatistics);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("学生教材发放信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 8, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 9, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 10, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 11, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 12, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 13, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 14, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 15, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("");
        row2.createCell(1).setCellValue("");
        row2.createCell(2).setCellValue("");
        row2.createCell(3).setCellValue("");
        row2.createCell(4).setCellValue("");
        row2.createCell(5).setCellValue("");
        row2.createCell(6).setCellValue("");
        row2.createCell(7).setCellValue("");
        row2.createCell(8).setCellValue("");
        row2.createCell(9).setCellValue("");
        row2.createCell(10).setCellValue("");
        row2.createCell(11).setCellValue("");
        row2.createCell(12).setCellValue("");
        row2.createCell(13).setCellValue("");
        row2.createCell(14).setCellValue("");
        row2.createCell(15).setCellValue("");
        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("所属学院");
        row1.createCell(2).setCellValue("专业名称");
        row1.createCell(3).setCellValue("年级");
        row1.createCell(4).setCellValue("班级名称");
        row1.createCell(5).setCellValue("课程名称");
        row1.createCell(6).setCellValue("教材名称");
        row1.createCell(7).setCellValue("单价");
        row1.createCell(8).setCellValue("预定数量");
        row1.createCell(9).setCellValue("库存数量");
        row1.createCell(10).setCellValue("实发数量");
        row1.createCell(11).setCellValue("折扣");
        row1.createCell(12).setCellValue("折后总金额");
        row1.createCell(13).setCellValue("领取人");
        row1.createCell(14).setCellValue("备注");
        row1.createCell(15).setCellValue("状态");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookStatisticsObj : textBookStatisticsList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookStatisticsObj.getCollege());
            row.createCell(2).setCellValue(textBookStatisticsObj.getMajorIdShow());
            row.createCell(3).setCellValue(textBookStatisticsObj.getGradeId());
            row.createCell(4).setCellValue(textBookStatisticsObj.getClassIdShow());
            row.createCell(5).setCellValue(textBookStatisticsObj.getCourseId());
            row.createCell(6).setCellValue(textBookStatisticsObj.getTextbookName());
            row.createCell(7).setCellValue(textBookStatisticsObj.getUnitPrice());
            row.createCell(8).setCellValue(textBookStatisticsObj.getDeclareNum());
            row.createCell(9).setCellValue(textBookStatisticsObj.getRemainderNum());
            row.createCell(10).setCellValue(textBookStatisticsObj.getActualNum());
            row.createCell(11).setCellValue(textBookStatisticsObj.getDiscount());
            row.createCell(12).setCellValue(textBookStatisticsObj.getTotal());
            row.createCell(13).setCellValue(textBookStatisticsObj.getReceiver());
            row.createCell(14).setCellValue(textBookStatisticsObj.getRemark());
            if (textBookStatisticsObj.getActualNum().equals("0")) {
                row.createCell(15).setCellValue("待发放");
            } else if (textBookStatisticsObj.getActualNum().equals("1")) {
                row.createCell(15).setCellValue("已完成");
            } else {
                row.createCell(15).setCellValue("发放不足");
            }
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("学生教材征订信息表.xls", "utf-8"));
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

    /**
     * @param request
     * @param response
     * @Description 教材入库信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBookTeacherRelease")
    public void exportTextBookTeacherRelease(HttpServletRequest request, HttpServletResponse response, String departmentsId, String majorId, String classId) {

        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setPersonType("1");
        textBookStatistics.setDepartmentsId(departmentsId);
        textBookStatistics.setMajorId(majorId);
        textBookStatistics.setClassId(classId);
        List<TextBookStatistics> textBookStatisticsList = textBookService.textBookStatisticsList(textBookStatistics);

        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教师教材发放信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("单价");
        row1.createCell(3).setCellValue("预定数量");
        row1.createCell(4).setCellValue("库存数量");
        row1.createCell(5).setCellValue("实订数量");
        row1.createCell(6).setCellValue("折扣");
        row1.createCell(7).setCellValue("折后总金额");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookStatisticsObj : textBookStatisticsList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookStatisticsObj.getTextbookName());
            row.createCell(2).setCellValue(textBookStatisticsObj.getUnitPrice());
            row.createCell(3).setCellValue(textBookStatisticsObj.getDeclareNum());
            row.createCell(4).setCellValue(textBookStatisticsObj.getRemainderNum());
            row.createCell(5).setCellValue(textBookStatisticsObj.getTextbookNumIn());
            row.createCell(6).setCellValue(textBookStatisticsObj.getDiscount());
            row.createCell(7).setCellValue(textBookStatisticsObj.getTotal());
            tmp++;
            i++;
        }
        //创建HSSFWorkbook对象
    /*    HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教师教材发放信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 3000);
        sheet.setColumnWidth((short) 2, (short) 3000);
        sheet.setColumnWidth((short) 3, (short) 4500);
        sheet.setColumnWidth((short) 4, (short) 2500);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 2000);// 空列设置小一些
        sheet.setColumnWidth((short) 7, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 8, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 9, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 10, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 11, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 12, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 13, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 14, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 15, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("");
        row2.createCell(1).setCellValue("");
        row2.createCell(2).setCellValue("");
        row2.createCell(3).setCellValue("");
        row2.createCell(4).setCellValue("");
        row2.createCell(5).setCellValue("");
        row2.createCell(6).setCellValue("");
        row2.createCell(7).setCellValue("");
        row2.createCell(8).setCellValue("");
        row2.createCell(9).setCellValue("");
        row2.createCell(10).setCellValue("");
        row2.createCell(11).setCellValue("");
        row2.createCell(12).setCellValue("");
        row2.createCell(13).setCellValue("");
        row2.createCell(14).setCellValue("");
        row2.createCell(15).setCellValue("");
        tmp++;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("所属学院");
        row1.createCell(2).setCellValue("专业名称");
        row1.createCell(3).setCellValue("年级");
        row1.createCell(4).setCellValue("班级名称");
        row1.createCell(5).setCellValue("课程名称");
        row1.createCell(6).setCellValue("教材名称");
        row1.createCell(7).setCellValue("单价");
        row1.createCell(8).setCellValue("预定数量");
        row1.createCell(9).setCellValue("库存数量");
        row1.createCell(10).setCellValue("实发数量");
        row1.createCell(11).setCellValue("折扣");
        row1.createCell(12).setCellValue("折后总金额");
        row1.createCell(13).setCellValue("领取人");
        row1.createCell(14).setCellValue("备注");
        row1.createCell(15).setCellValue("状态");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookStatisticsObj : textBookStatisticsList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookStatisticsObj.getCollege());
            row.createCell(2).setCellValue(textBookStatisticsObj.getMajorIdShow());
            row.createCell(3).setCellValue(textBookStatisticsObj.getGradeId());
            row.createCell(4).setCellValue(textBookStatisticsObj.getClassIdShow());
            row.createCell(5).setCellValue(textBookStatisticsObj.getCourseId());
            row.createCell(6).setCellValue(textBookStatisticsObj.getTextbookName());
            row.createCell(7).setCellValue(textBookStatisticsObj.getUnitPrice());
            row.createCell(8).setCellValue(textBookStatisticsObj.getDeclareNum());
            row.createCell(9).setCellValue(textBookStatisticsObj.getRemainderNum());
            row.createCell(10).setCellValue(textBookStatisticsObj.getActualNum());
            row.createCell(11).setCellValue(textBookStatisticsObj.getDiscount());
            row.createCell(12).setCellValue(textBookStatisticsObj.getTotal());
            row.createCell(13).setCellValue(textBookStatisticsObj.getReceiver());
            row.createCell(14).setCellValue(textBookStatisticsObj.getRemark());
            if (textBookStatisticsObj.getActualNum().equals("0")) {
                row.createCell(15).setCellValue("待发放");
            } else if (textBookStatisticsObj.getActualNum().equals("1")) {
                row.createCell(15).setCellValue("已完成");
            } else {
                row.createCell(15).setCellValue("发放不足");
            }
            tmp++;
            i++;
        }*/
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教师教材征订信息表.xls", "utf-8"));
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

    /**
     * @Description 教材结款明细
     * @author FanNing
     */
    @RequestMapping("/payment")
    public ModelAndView textBookPayment() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/paymentList");
        return mv;
    }


    /**
     * @Description 教材结款汇总
     * @author FanNing
     */
    @RequestMapping("/textBookPayment")
    public ModelAndView textBookPayments() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookPaymentList");
        return mv;
    }

    /**
     * 教材发放统计
     * @return
     */
    @RequestMapping("/textBookTeacherReleaseList")
    public ModelAndView textBookTeacherReleaseList(String personType,String textbookId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookTeacherReleaseList");
        mv.addObject("textbookId",textbookId);
        mv.addObject("personType",personType);
        return mv;
    }
    /**
     * @Description 教师教材发放列表页
     * @author FanNing
     */
    @RequestMapping("/textBookTeacherStatisticsList")
    public ModelAndView textBookTeacherStatisticsList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookTeacherStatisticsList");
        return mv;
    }


    /**
     * @Description 教材结款汇总
     */
   /* @RequestMapping("/textBookPayment")
    public ModelAndView textBookPayment() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookTeacherReleaseList");
        return mv;
    }

    /**
     * @param textBookDeclare
     * @Description 教师教材发放list
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookReleaseList")
    public Map<String, List<TextBookDeclare>> getTextBookReleaseList(TextBookDeclare textBookDeclare) {
        Map<String, List<TextBookDeclare>> textBookDeclareMap = new HashMap<String, List<TextBookDeclare>>();
        textBookDeclareMap.put("data", textBookService.getTextBookReleaseList(textBookDeclare));
        return textBookDeclareMap;
    }

    /**
     * @param declareId
     * @Description 教师教材发放页面
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/releaseTextbookById")
    public ModelAndView releaseTextbookById(String declareId, String personType) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/releaseTextBook");
        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(declareId);
        mv.addObject("head", "教材发放");
        mv.addObject("textBookDeclare", textBookDeclare);
        mv.addObject("personType", personType);
        return mv;
    }

    /**
     * 教材发放详情
     * @param declareId
     * @param personType
     * @return
     */
    @ResponseBody
    @RequestMapping("/releaseSearchTextbookById")
    public ModelAndView releaseSearchTextbookById(String declareId, String personType) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/releaseSearchTextBook");
        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(declareId);
        mv.addObject("head", "教材发放详情");
        mv.addObject("textBookDeclare", textBookDeclare);
        mv.addObject("personType", personType);
        return mv;
    }
    /**
     * 学生教材发放记录查询
     * @return
     */
    @ResponseBody
    @RequestMapping("/getGrantList")
    public Map<String, List<TextBookDeclare>> getGrantList(String declareId) {
        Map<String, List<TextBookDeclare>> textBookDeclareMap = new HashMap<String, List<TextBookDeclare>>();
        textBookDeclareMap.put("data", textBookService.getGrantList(declareId));
        return textBookDeclareMap;
    }

    @ResponseBody
    @RequestMapping("/editActualNum")
    public ModelAndView editActualNum(String id, String personType) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editActualNum");
//        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(id);
        TextBookDeclare textBookDeclare1 = new TextBookDeclare();
        textBookDeclare1.setId(id);
        textBookDeclare1.setPersonType(personType);
        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclareById(id);
//        TextBookDeclare textBookDeclare = textBookService.getTextBookDeclare(textBookDeclare1);
        mv.addObject("head", "修改");
        mv.addObject("textBookDeclare", textBookDeclare);
        return mv;
    }

    /**
     * @param textBookLog
     * @Description 教材发放保存
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/saveTextBookRelease")
    public Message saveTextBookRelease(TextBookLog textBookLog) {
        //本次发放的数量
        String receivers = textBookLog.getReceiver();
        Integer releaseNum = Integer.parseInt(textBookLog.getOperationNum());
        TextBook textBook = textBookService.getTextBookNumInById(textBookLog.getTextbookId());
        TextBook tb = new TextBook();
        TextBookDeclare textBookDeclare = new TextBookDeclare();
        //库存剩余数量
        String textBookNumIn = textBook.getTextbookNumIn();
        TextBookDeclare tbd = textBookService.getTextBookDeclareById(textBookLog.getId());
        //剩余发放数量
        Integer remainderNum = Integer.parseInt(tbd.getRemainderNum());
        if (textBookNumIn != null || textBookNumIn != "") {
            //库存剩余数量
            Integer textBookNum = Integer.parseInt(textBookNumIn);
            //如果库存数量小于本次操作数量，库存将不足
            if (textBookNum < releaseNum) {
                return new Message(1, "库存数量不足，请检查！", "error");
            } else {
                //如果本次操作与剩余发放数量相等，更新状态：全部发放完成
                if (remainderNum == releaseNum) {
                    //更新库存
                    tb.setChanger(CommonUtil.getPersonId());
                    tb.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                    tb.setReleaseNum(textBookLog.getOperationNum());
                    tb.setTextbookId(textBookLog.getTextbookId());
                    textBookService.updateTextBookNumIn(tb);
                    //更新发放状态以及剩余发放数量
                    textBookDeclare.setId(textBookLog.getId());
                    textBookDeclare.setRemainderNum(textBookLog.getOperationNum());
                    textBookDeclare.setGiveState("3");
                    textBookService.updateTextBookRemainderNum(textBookDeclare);
                    //库存操作日志
                    textBookLog.setCreator(CommonUtil.getPersonId());
                    textBookLog.setCreateDept(CommonUtil.getDefaultDept());
                    textBookLog.setOperationType("2");
                    textBookLogService.insertTextBookLog(textBookLog);
                    TextBookDeclare tt = new TextBookDeclare();
                    tt.setTextbookPlanId(tbd.getId());
                    tt.setMajorId(tbd.getMajorId());
                    tt.setClassId(tbd.getClassId());
                    tt.setCourseId(tbd.getCourseId());
                    tt.setTextbookId(tbd.getTextbookId());
                    tt.setDeclareNum(textBookLog.getOperationNum());
                    tt.setPersonType(textBookLog.getPersonType());
                    tt.setCreator(CommonUtil.getPersonId());
                    tt.setCreateDept(CommonUtil.getDefaultDept());
                    tt.setReceiver(receivers);
                    textBookService.insertTextbookDeclareLog(tt);
                    return new Message(1, "发放成功！", "success");
                    //如果本次操作小于剩余发放数量，更新状态：未全部发放
                } else if (remainderNum > releaseNum) {
                    //更新库存
                    tb.setChanger(CommonUtil.getPersonId());
                    tb.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                    tb.setReleaseNum(textBookLog.getOperationNum());
                    tb.setTextbookId(textBookLog.getTextbookId());
                    textBookService.updateTextBookNumIn(tb);
                    //更新发放状态以及剩余发放数量
                    textBookDeclare.setId(textBookLog.getId());
                    textBookDeclare.setRemainderNum(textBookLog.getOperationNum());
                    textBookDeclare.setGiveState("2");
                    textBookDeclare.setReceiver(receivers);
                    textBookService.updateTextBookRemainderNum(textBookDeclare);
                    //库存操作日志
                    textBookLog.setCreator(CommonUtil.getPersonId());
                    textBookLog.setCreateDept(CommonUtil.getDefaultDept());
                    textBookLog.setOperationType("2");
                    textBookLogService.insertTextBookLog(textBookLog);
                    TextBookDeclare tt = new TextBookDeclare();
                    tt.setTextbookPlanId(tbd.getId());
                    tt.setMajorId(tbd.getMajorId());
                    tt.setClassId(tbd.getClassId());
                    tt.setCourseId(tbd.getCourseId());
                    tt.setTextbookId(tbd.getTextbookId());
                    tt.setDeclareNum(textBookLog.getOperationNum());
                    tt.setPersonType(textBookLog.getPersonType());
                    tt.setCreator(CommonUtil.getPersonId());
                    tt.setCreateDept(CommonUtil.getDefaultDept());
                    tt.setReceiver(receivers);
                    textBookService.insertTextbookDeclareLog(tt);
                    return new Message(1, "发放成功！", "success");
                    //如果本次发放数量大于剩余发放数量
                } else {
                    return new Message(1, "发放数量不得大于剩余发放数量！", "error");
                }
            }
        } else {
            return new Message(1, "该教材尚未入库，发放失败！", "error");
        }
    }

    @ResponseBody
    @RequestMapping("/saveActualNum")
    public Message saveActualNum(TextBookDeclare textBookDeclare) {
//        int yifa=Integer.parseInt(textBookDeclare.getDeclareNum())-Integer.parseInt(textBookDeclare.getSubmitState());
//        if(Integer.parseInt(textBookDeclare.getActualNum())<yifa){
//            return new Message(0, "实订数不可少于已发放总数！", "success");
//        }else {
//            int i=Integer.parseInt(textBookDeclare.getActualNum())-yifa;
//            textBookService.saveActualNum(textBookDeclare);
//            textBookDeclare.setRemainderNum(""+i);
        textBookService.updateDeclareNum(textBookDeclare);
        return new Message(1, "修改成功！", "success");
//        }
    }

    /**
     * @Description 教材发放统计列表页
     * @author FanNing
     */
    @RequestMapping("/textBookReleaseStatisticsList")
    public ModelAndView textBookReleaseStatisticsList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookReleaseStatisticsList");
        return mv;
    }

    /**
     * @param textBookDeclare
     * @Description 教材发放统计list
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookReleaseStatisticsList")
    public Map<String, List<TextBookDeclare>> getTextBookReleaseStatisticsList(TextBookDeclare textBookDeclare) {
        Map<String, List<TextBookDeclare>> textBookDeclareMap = new HashMap<String, List<TextBookDeclare>>();
        textBookDeclareMap.put("data", textBookService.getTextBookReleaseStatisticsList(textBookDeclare));
        return textBookDeclareMap;
    }

    /**
     * @param textbookId
     * @Description 学生教材发放详细列表页
     * @author FanNing
     */
    @RequestMapping("/showTextBookReleaseDetails")
    public ModelAndView showTextBookReleaseDetails(String textbookId, String declareId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/showTextBookReleaseDetail");
        mv.addObject("textbookId", textbookId);
        mv.addObject("declareId", declareId);
        return mv;
    }

    /**
     * @param textbookId
     * @Description 教师教材发放详细列表页
     * @author FanNing
     */
    @RequestMapping("/showTextBookTeacherReleaseDetails")
    public ModelAndView showTextBookTeacherReleaseDetails(String textbookId) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/showTextBookTeacherReleaseDetail");
        mv.addObject("textbookId", textbookId);
        return mv;
    }

    /**
     * @Description 学生教材发放记录列表页
     * @author FanNing
     */
    @RequestMapping("/textBookStatisticsList")
    public ModelAndView textBookStatisticsList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookStatisticsListRecord");
        return mv;
    }
    /**
     * @Description 学生教材发放统计列表页 1111111111111
     */
    @RequestMapping("/textBookStudentGrantStatisticsList")
    public ModelAndView textBookStudentGrantStatisticsList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookStudentGrantStatisticsList");
        mv.addObject("personType", "0");
        return mv;
    }
    /**
     * @Description 教师教材发放统计列表页
     */
    @RequestMapping("/textBookTeacherGrantStatisticsList")
    public ModelAndView textBookTeacherGrantStatisticsList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookTeacherGrantStatisticsList");
        mv.addObject("personType", "1");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/getTextBookGrantStatisticsList")
    public Map<String, Object> getTextBookGrantStatisticsList(TextBookStatistics textBookStatistics, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookStatisticsList = new HashMap<String, Object>();
        textBookStatistics.setTerm(parameterService.getParameterValue());
        List<TextBookStatistics> list = textBookService.textBookGrantStatisticsList(textBookStatistics);
        PageInfo<List<TextBookStatistics>> info = new PageInfo(list);
        textBookStatisticsList.put("draw", draw);
        textBookStatisticsList.put("recordsTotal", info.getTotal());
        textBookStatisticsList.put("recordsFiltered", info.getTotal());
        textBookStatisticsList.put("data", list);
        return textBookStatisticsList;
    }
    /**
     * @param textBookStatistics
     * @Description 教材发放记录list
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/getTextBookStatisticsList")
    public Map<String, Object> getTextBookStatisticsList(TextBookStatistics textBookStatistics, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookStatisticsList = new HashMap<String, Object>();
        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatistics.setTerm(parameterService.getParameterValue());
        List<TextBookStatistics> list = textBookService.textBookStatisticsList(textBookStatistics);
        PageInfo<List<TextBookStatistics>> info = new PageInfo(list);
        textBookStatisticsList.put("draw", draw);
        textBookStatisticsList.put("recordsTotal", info.getTotal());
        textBookStatisticsList.put("recordsFiltered", info.getTotal());
        textBookStatisticsList.put("data", list);
        return textBookStatisticsList;
    }

    /**
     * @param textBookStatistics
     * @Description 教材结款list
     * @author
     */
    @ResponseBody
    @RequestMapping("/getTextBookPaymentList")
    public Map<String, Object> getTextBookPaymentList(TextBookStatistics textBookStatistics, int draw, int start, int length) {

        Map<String, Object> textBookStatisticsList = new HashMap<String, Object>();
        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatistics.setTerm(parameterService.getParameterValue());
        PageHelper.startPage(start / length + 1, length);
        List<TextBookStatistics> list = textBookService.textBookPaymentList(textBookStatistics);
        PageInfo<TextBookStatistics> info = new PageInfo<>(list);
        for (TextBookStatistics lists: list){
            if("".equals(lists.getStudentCount())|| null == lists.getStudentCount()){
                lists.setStudentCount("0");
                if("".equals(lists.getTeacherCount())|| null == lists.getTeacherCount()){
                    lists.setTeacherCount("0");
                    lists.setDeclareNum("0");
                }else{
                    lists.setDeclareNum(lists.getTeacherCount());
                }
            }else{
                if("".equals(lists.getTeacherCount())|| null == lists.getTeacherCount()){
                    lists.setTeacherCount("0");
                    lists.setDeclareNum(lists.getStudentCount());
                }else{
                    lists.setDeclareNum((Integer.parseInt(lists.getStudentCount())+Integer.parseInt(lists.getTeacherCount()))+"");
                }
            }
            TextBookOrderLog textBookOrderLog  = new TextBookOrderLog();
            textBookOrderLog.setTerm(parameterService.getParameterValue());
            textBookOrderLog.setTextbookId(lists.getTextbookId());
            String num = textBookLogService.getTotalByTermTextBookId(textBookOrderLog);
            if("".equals(lists.getPrice()) || null == lists.getPrice()){
                lists.setTotal("");
            }else{
                lists.setTotal((Integer.parseInt(lists.getPrice())*Double.parseDouble(num))+"");
            }

        }
        textBookStatisticsList.put("draw", draw);
        textBookStatisticsList.put("recordsTotal", info.getTotal());
        textBookStatisticsList.put("recordsFiltered", info.getTotal());
        textBookStatisticsList.put("data", list);
        return textBookStatisticsList;
    }


    /**
     * @param textBookStatistics
     * @Description 教材结款明细
     * @author
     */
    @ResponseBody
    @RequestMapping("/getPaymentList")
    public Map<String, Object> getPaymentList(TextBookStatistics textBookStatistics, int draw, int start, int length) {

        Map<String, Object> textBookStatisticsList = new HashMap<String, Object>();
        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatistics.setTerm(parameterService.getParameterValue());
        PageHelper.startPage(start / length + 1, length);
        List<TextBookStatistics> list = textBookService.getPaymentList(textBookStatistics);
        PageInfo<TextBookStatistics> info = new PageInfo<>(list);
        for (TextBookStatistics s: list){
            if("".equals(s.getClassId()) || null == s.getClassId()){
                s.setClassNum("");
            }else{
                s.setClassNum(textBookService.getStudentByClassId(s.getClassId()));
            }
        }

        textBookStatisticsList.put("draw", draw);
        textBookStatisticsList.put("recordsTotal", info.getTotal());
        textBookStatisticsList.put("recordsFiltered", info.getTotal());
        textBookStatisticsList.put("data", list);
        return textBookStatisticsList;
    }


    /**
     * @param id
     * @Description 实订数修改页面
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/editTextBookStatistics")
    public ModelAndView editTextBookStatistics(String id) {
        ModelAndView mv = new ModelAndView("business/educational/textbook/editTextBookStatistics");
        mv.addObject("head", "修改");
        mv.addObject("id", id);
        return mv;
    }

    /**
     * @param textBookStatistics
     * @Description 实订数保存方法
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/saveTextBookStatistics")
    public Message saveTextBookStatistics(TextBookStatistics textBookStatistics) {
        textBookStatistics.setChanger(CommonUtil.getPersonId());
        textBookStatistics.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        textBookService.updateTextBookStatistics(textBookStatistics);
        return new Message(1, "修改成功！", "success");
    }

    /**
     * 发放记录
     */
    @ResponseBody
    @RequestMapping("/getFaFang")
    public Map<String, List<TextBookDeclare>> getFaFang(TextBookDeclare textBookDeclare) {
        Map<String, List<TextBookDeclare>> textBookDeclareMap = new HashMap<String, List<TextBookDeclare>>();
        textBookDeclare.setCreateDept(CommonUtil.getDefaultDept());
        textBookDeclare.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookDeclareMap.put("data", textBookService.getFaFang(textBookDeclare));
        return textBookDeclareMap;
    }


    /**
     * 导出获奖情况
     *
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping("/exportTextBookPayment")
    public void exportCompetitionRequestAward(HttpServletRequest request, HttpServletResponse response) {

        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatistics.setPersonType("0");

        Calendar cale = null;

        cale = Calendar.getInstance();

        int month = cale.get(Calendar.MONTH) + 1;  //获得当前月份

        String title = TextBookController.getTitle(month);     //获得当前学期


        Date date = new java.sql.Date(System.currentTimeMillis());  // 获得当前时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);


        List<TextBookStatistics> courseList = textBookService.textBookPaymentList(textBookStatistics);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教材结款汇总表");

        //新建font实体
        HSSFFont hssfFont = wb.createFont();

        //字体大小
        hssfFont.setFontHeightInPoints((short) 24);
        hssfFont.setFontName("楷体");
        //粗体

        CellStyle cellStyle0 = wb.createCellStyle();
        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        cellStyle0.setFont(hssfFont);

        //创建HSSFRow对象
        int tmp = 0;

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 11));

        tmp++;

        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0);
        cell00.setCellValue(title);
        cell00.setCellStyle(cellStyle0);


        tmp++;

        Row row2 = sheet.createRow(1);
        Cell cell02 = row2.createCell(11);

        cell02.setCellValue(dateString);
        cell00.setCellStyle(cellStyle0);

        HSSFRow row1 = sheet.createRow(tmp);

        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("课程名称");
        row1.createCell(2).setCellValue("教材名称");
        row1.createCell(3).setCellValue("主编");
        row1.createCell(4).setCellValue("出版社");
        row1.createCell(5).setCellValue("学生用书合计");
        row1.createCell(6).setCellValue("教师用书合计");
        row1.createCell(7).setCellValue("合计");
        row1.createCell(8).setCellValue("每本单价");
        row1.createCell(9).setCellValue("折扣");
        row1.createCell(10).setCellValue("合计实付款");
        row1.createCell(11).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBookStatistics courseObj : courseList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(courseObj.getCourseId());
            row.createCell(2).setCellValue(courseObj.getTextbookName());
            row.createCell(3).setCellValue(courseObj.getEditor());
            row.createCell(4).setCellValue(courseObj.getPublishingHouse());
            row.createCell(5).setCellValue(courseObj.getDeclareNum());
            row.createCell(6).setCellValue(courseObj.getStudentCount());
            row.createCell(7).setCellValue(courseObj.getTeacherCount());
            row.createCell(8).setCellValue(courseObj.getPrice());
            row.createCell(9).setCellValue(courseObj.getDiscount());
            row.createCell(10).setCellValue(courseObj.getTotal());
            row.createCell(11).setCellValue(courseObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("教材结款汇总表.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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


    @ResponseBody
    @RequestMapping("/exportTextBookPayment1")
    public void exportTextBookPayment1(HttpServletRequest request, HttpServletResponse response) {

        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setCreateDept(CommonUtil.getDefaultDept());
        textBookStatistics.setLevel(CommonUtil.getLoginUser().getLevel());
        textBookStatistics.setPersonType("0");
        List<Map<String, String>> depts = textBookService.getDeptList();
        Calendar cale;
        cale = Calendar.getInstance();
        int month = cale.get(Calendar.MONTH) + 1;  //获得当前月份
        String title = TextBookController.getTitle(month);     //获得当前学期
        Date date = new java.sql.Date(System.currentTimeMillis());  // 获得当前时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //新建font实体
        HSSFFont hssfFont = wb.createFont();
        //字体大小
        hssfFont.setFontHeightInPoints((short) 24);
        hssfFont.setFontName("楷体");
        //粗体
        CellStyle cellStyle0 = wb.createCellStyle();
        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        cellStyle0.setFont(hssfFont);
        //创建HSSFSheet对象
        for (Map<String, String> dept : depts) {
            HSSFSheet sheet = wb.createSheet(dept.get("deptName"));
            sheet.setColumnWidth(0, 10 * 256);
            sheet.setColumnWidth(1, 10 * 256);
            sheet.setColumnWidth(2, 10 * 256);
            sheet.setColumnWidth(3, 30 * 256);
            sheet.setColumnWidth(4, 30 * 256);
            sheet.setColumnWidth(5, 10 * 256);
            sheet.setColumnWidth(6, 10 * 256);
            sheet.setColumnWidth(7, 10 * 256);
            sheet.setColumnWidth(8, 10 * 256);
            sheet.setColumnWidth(9, 10 * 256);
            sheet.setColumnWidth(10, 40 * 256);
            //创建HSSFRow对象
            int tmp = 0;
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));
            tmp++;
            Row row0 = sheet.createRow(0);
            Cell cell00 = row0.createCell(0);
            cell00.setCellValue(title);
            cell00.setCellStyle(cellStyle0);
            tmp++;
            Row row2 = sheet.createRow(1);
            Cell cell = row2.createCell(0);
            cell.setCellValue("系（部）名称：" + dept.get("deptName"));
            Cell cell02 = row2.createCell(10);
            cell02.setCellValue(dateString);
            cell00.setCellStyle(cellStyle0);
            HSSFRow row1 = sheet.createRow(tmp);
            row1.createCell(0).setCellValue("序号");
            row1.createCell(1).setCellValue("班级");
            row1.createCell(2).setCellValue("人数");
            row1.createCell(3).setCellValue("课程名称");
            row1.createCell(4).setCellValue("教材名称");
            row1.createCell(5).setCellValue("主编");
            row1.createCell(6).setCellValue("出版社");
            row1.createCell(7).setCellValue("每本单价");
            row1.createCell(8).setCellValue("折扣");
            row1.createCell(9).setCellValue("合计实付款");
            row1.createCell(10).setCellValue("备注");
            tmp++;
            int i = 1;
            Integer total = 0;
            List<Map<String, Object>> classes = textBookService.getClassesByDeptId(dept.get("deptId"));
            for (Map<String, Object> classMap : classes) {
                List<TextBookStatistics> courseList = textBookService.getResult((String) classMap.get("classId"));
                if (courseList.size() > 0) {
                    for (int j = 0; j < courseList.size(); j++) {
                        HSSFRow row = sheet.createRow(tmp);
                        row.createCell(0).setCellValue(i);
                        if (j == 0) {
                            row.createCell(1).setCellValue((String) classMap.get("className"));
                            row.createCell(2).setCellValue(String.valueOf(classMap.get("sum")));
                            if (courseList.size() > 1) {
                                sheet.addMergedRegion(new CellRangeAddress(tmp, tmp + courseList.size() - 1, 1, 1));
                                sheet.addMergedRegion(new CellRangeAddress(tmp, tmp + courseList.size() - 1, 2, 2));
                            }
                        }
                        row.createCell(3).setCellValue(courseList.get(j).getCourseId());
                        row.createCell(4).setCellValue(courseList.get(j).getTextbookName());
                        row.createCell(5).setCellValue(courseList.get(j).getEditor());
                        row.createCell(6).setCellValue(courseList.get(j).getPublishingHouse());
                        row.createCell(7).setCellValue(courseList.get(j).getPrice());
                        row.createCell(8).setCellValue(courseList.get(j).getDiscount());
                        row.createCell(9).setCellValue(courseList.get(j).getTotal());
                        row.createCell(10).setCellValue(courseList.get(j).getRemark());
                        i++;
                        tmp++;
                        if(""==courseList.get(j).getTotal() || null == courseList.get(j).getTotal()){
                            total += 0;
                        }else{
                            total += Integer.parseInt(courseList.get(j).getTotal());
                        }
                    }
                    HSSFRow rowSum = sheet.createRow(tmp);
                    rowSum.createCell(0).setCellValue("班级实付书款合计");
                    sheet.addMergedRegion(new CellRangeAddress(tmp, tmp, 0, 2));
                    rowSum.createCell(3).setCellValue(total);
                    sheet.addMergedRegion(new CellRangeAddress(tmp, tmp, 3, 10));
                    total = 0;
                    tmp++;
                }
            }
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教材结款明细表.xls", "utf-8"));
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


    public static String getTitle(int month) {
        if (month > 8) {

            Calendar cale = null;

            cale = Calendar.getInstance();

            int year = cale.get(Calendar.YEAR); //2019

            int nextYear = year + 1;

            System.err.println(year + "————" + nextYear + "学年" + "第一学期教材结款明细表");

            return year + "————" + nextYear + "学年" + "第一学期教材结款明细表";
        } else {

            Calendar cale = null;

            cale = Calendar.getInstance();

            int year = cale.get(Calendar.YEAR); //2019

            int beforeYear = year - 1;

            System.err.println(beforeYear + "————" + year + "学年" + "第二学期教材结款明细表");

            return beforeYear + "————" + year + "学年" + "第二学期教材结款明细表";
        }
    }

    /**
     * 通过教材id查询单价，主编，版本
     *
     * @param textbookId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getUnitPriceByTextbookId")
    public Map getUnitPriceByTextbookId(String textbookId) {
        TextBook textBook = textBookService.getUnitPriceByTextbookId(textbookId);
        Map textBookList = new HashMap();
        textBookList.put("price", textBook.getPrice());
        textBookList.put("editor", textBook.getEditor());
        textBookList.put("edition", textBook.getEdition());
        return textBookList;
    }

    @RequestMapping("/updateTextbookDeclare")
    public String updateTextbookDeclare(String id, String textbookId, String actualNum, String discount, String declareId, Model model) {
        model.addAttribute("head", "实订数折扣修改");
        model.addAttribute("id", id);
        if ("".equals(discount) || null == discount) {
            model.addAttribute("discount", 1);
        } else {
            model.addAttribute("discount", discount);
        }
        model.addAttribute("textbookId", textbookId);
        model.addAttribute("actualNum", actualNum);
        model.addAttribute("declareId", declareId);
        return "business/educational/textbook/editDeclareDiscount";
    }

    /**
     * 修改订购日志折扣
     * @param textBookDeclare
     * @return
     */
    @Transactional
    @ResponseBody
    @RequestMapping("/saveTextbookDeclareDiscount")
    public Message saveTextbookDeclareDiscount(TextBookDeclare textBookDeclare) {
        String giveNum = textBookLogService.getSumTextBookOrderLogGiveNum(textBookDeclare);
        if("".equals(giveNum) || null == giveNum){
            TextBookOrderLog textBookOrderLog = new TextBookOrderLog();
            textBookService.updateTextBookDeclareDiscount(textBookDeclare);
            textBookService.updateTextBookDeclareActualNum(textBookDeclare);
            textBookService.updateTextBookDeclareRemainderNum(textBookDeclare);
            textBookOrderLog.setDeclareId(textBookDeclare.getDeclareId());
            textBookOrderLog.setTextbookId(textBookDeclare.getTextbookId());
            textBookOrderLog.setActualNum(textBookDeclare.getActualNum());
            textBookOrderLog.setDiscount(textBookDeclare.getDiscount());
            textBookOrderLog.setChanger(CommonUtil.getPersonId());
            textBookOrderLog.setChangeDept(CommonUtil.getDefaultDept());
            textBookService.updateTextbookOrderLog(textBookOrderLog);
            return new Message(1, "修改成功！", "success");
        }else{
            if(Integer.parseInt(textBookDeclare.getActualNum())<Integer.parseInt(giveNum)){
                return new Message(0, "修改失败,实订数不能少于之前发放的教材数！", "error");
            }else{
                TextBookOrderLog textBookOrderLog = new TextBookOrderLog();
                textBookService.updateTextBookDeclareDiscount(textBookDeclare);
                textBookService.updateTextBookDeclareActualNum(textBookDeclare);
                textBookService.updateTextBookDeclareRemainderNum(textBookDeclare);
                textBookOrderLog.setDeclareId(textBookDeclare.getDeclareId());
                textBookOrderLog.setTextbookId(textBookDeclare.getTextbookId());
                textBookOrderLog.setActualNum(textBookDeclare.getActualNum());
                textBookOrderLog.setDiscount(textBookDeclare.getDiscount());
                textBookOrderLog.setChanger(CommonUtil.getPersonId());
                textBookOrderLog.setChangeDept(CommonUtil.getDefaultDept());
                textBookService.updateTextbookOrderLog(textBookOrderLog);
                return new Message(1, "修改成功！", "success");
            }
        }

    }

    /**
     * 教材结款汇总
     * @param response
     */
    @RequestMapping("/exportTextBookPaymentSummary")
    public void exportTextBookPaymentSummary(String textbookName, String courseId, String publishingHouse,HttpServletResponse response) {
        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setTerm(parameterService.getParameterValue());
        textBookStatistics.setTextbookName(textbookName);
        textBookStatistics.setCourseId(courseId);
        textBookStatistics.setPublishingHouse(publishingHouse);
        List<TextBookStatistics> list = textBookService.textBookPaymentList(textBookStatistics);
        for (TextBookStatistics lists: list){
            if("".equals(lists.getStudentCount())|| null == lists.getStudentCount()){
                lists.setStudentCount("0");
                if("".equals(lists.getTeacherCount())|| null == lists.getTeacherCount()){
                    lists.setTeacherCount("0");
                    lists.setDeclareNum("0");
                }else{
                    lists.setDeclareNum(lists.getTeacherCount());
                }
            }else{
                if("".equals(lists.getTeacherCount())|| null == lists.getTeacherCount()){
                    lists.setTeacherCount("0");
                    lists.setDeclareNum(lists.getStudentCount());
                }else{
                    lists.setDeclareNum((Integer.parseInt(lists.getStudentCount())+Integer.parseInt(lists.getTeacherCount()))+"");
                }
            }
            TextBookOrderLog textBookOrderLog  = new TextBookOrderLog();
            textBookOrderLog.setTerm(parameterService.getParameterValue());
            textBookOrderLog.setTextbookId(lists.getTextbookId());
            String num = textBookLogService.getTotalByTermTextBookId(textBookOrderLog);
            if("".equals(lists.getPrice()) || null == lists.getPrice()){
                lists.setTotal("");
            }else{
                lists.setTotal((Integer.parseInt(lists.getPrice())*Double.parseDouble(num))+"");
            }

        }
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教材结款汇总表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 6000);
        sheet.setColumnWidth((short) 2, (short) 2500);
        sheet.setColumnWidth((short) 3, (short) 2500);
        sheet.setColumnWidth((short) 4, (short) 8000);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 5000);
        sheet.setColumnWidth((short) 7, (short) 5000);
        sheet.setColumnWidth((short) 8, (short) 5000);
        sheet.setColumnWidth((short) 9, (short) 5000);
        sheet.setColumnWidth((short) 10, (short) 5000);
        sheet.setColumnWidth((short) 11, (short) 5000);

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("课程名称");
        row1.createCell(2).setCellValue("教材名称");
        row1.createCell(3).setCellValue("主编");
        row1.createCell(4).setCellValue("出版社");
        row1.createCell(5).setCellValue("学生用书合计");
        row1.createCell(6).setCellValue("教师用书合计");
        row1.createCell(7).setCellValue("合计");
        row1.createCell(8).setCellValue("每本单价");
        row1.createCell(9).setCellValue("折扣");
        row1.createCell(10).setCellValue("合计实付款");
        row1.createCell(11).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookLogObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookLogObj.getCourseId());
            row.createCell(2).setCellValue(textBookLogObj.getTextbookName());
            row.createCell(3).setCellValue(textBookLogObj.getEditor());
            row.createCell(4).setCellValue(textBookLogObj.getPublishingHouse());
            row.createCell(5).setCellValue(textBookLogObj.getStudentCount());
            row.createCell(6).setCellValue(textBookLogObj.getTeacherCount());
            row.createCell(7).setCellValue(textBookLogObj.getDeclareNum());
            row.createCell(8).setCellValue(textBookLogObj.getPrice());
            row.createCell(9).setCellValue(textBookLogObj.getDiscount());
            row.createCell(10).setCellValue(textBookLogObj.getTotal());
            row.createCell(11).setCellValue(textBookLogObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教材结款汇总表.xls", "utf-8"));
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




    @RequestMapping("/exportTextBookStatisticsListAll")
    public void exportTextBookStatisticsListAll(String textbookName,String personType,HttpServletResponse response) {
        TextBookStatistics textBookStatistics = new TextBookStatistics();
        textBookStatistics.setTerm(parameterService.getParameterValue());
        textBookStatistics.setTextbookName(textbookName);
        textBookStatistics.setPersonType(personType);
        List<TextBookStatistics> list = textBookService.textBookGrantStatisticsList(textBookStatistics);
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet;
        if("0".equals(personType)){
            sheet = wb.createSheet("学生教材发放汇总表");
            sheet.setVerticallyCenter(true);
        }else{
            sheet = wb.createSheet("教师教材发放汇总表");
            sheet.setVerticallyCenter(true);
        }



        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 6000);
        sheet.setColumnWidth((short) 2, (short) 2500);
        sheet.setColumnWidth((short) 3, (short) 2500);
        sheet.setColumnWidth((short) 4, (short) 8000);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("预定数量");
        row1.createCell(3).setCellValue("实订数");
        row1.createCell(4).setCellValue("库存数量");
        row1.createCell(5).setCellValue("发放数量");
        tmp++;
        int i = 1;
        for (TextBookStatistics textBookLogObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookLogObj.getTextbookName());
            row.createCell(2).setCellValue(textBookLogObj.getDeclareNum());
            row.createCell(3).setCellValue(textBookLogObj.getActualNum());
            row.createCell(4).setCellValue(textBookLogObj.getTextbookNumIn());
            row.createCell(5).setCellValue(textBookLogObj.getGiveNum());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            if("0".equals(personType)){
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                        ("学生教材发放汇总表.xls", "utf-8"));
            }else{
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                        ("教师教材发放汇总表.xls", "utf-8"));
            }

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
}
