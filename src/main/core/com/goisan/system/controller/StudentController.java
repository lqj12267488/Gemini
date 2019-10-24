package com.goisan.system.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.educational.major.service.MajorService;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.studentwork.payment.bean.PaymentResult;
import com.goisan.studentwork.payment.service.PaymentService;
import com.goisan.studentwork.studentrewardpunish.bean.StudentPunish;
import com.goisan.studentwork.studentrewardpunish.service.StudentRewardPunishService;
import com.goisan.system.bean.*;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by admin on 2017/5/20.
 */
@Controller
public class StudentController {
    @Resource
    private StudentService studentService;
    @Resource
    private CommonService commonService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private PaymentService paymentService;
    @Resource
    private StudentRewardPunishService studentRewardPunishService;
    @Resource
    private ScoreImportService scoreImportService;

    @RequestMapping("/student/studentList")
    public ModelAndView studentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/studentMajorClassTree");
        return mv;
    }

    @RequestMapping("/student/studentListZz")
    public ModelAndView studentListZz() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/studentMajorClassTreePolytechnicSchool");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/getMajorClassTree")
    public List<Tree> getMajorClassTree() {
        List<Tree> a = studentService.getMajorClassTree();
        return a;
    }

    @ResponseBody
    @RequestMapping("/student/getMajorClassTreeByLevel")
    public List<Tree> getMajorClassTreeByLevel(String level) {
        List<Tree> a = studentService.getMajorClassTreeByLevel(level);
        return a;
    }



    @ResponseBody
    @RequestMapping("/student/getDeptMajorGradClassTree")
    public List<Tree> getDeptMajorGradClassTree(String level) {
        List<Tree> a = studentService.getDeptMajorGradClassTree(level);
        return a;
    }

    @RequestMapping("/student/studentGrid")
    public ModelAndView studentGrid(String id) {
        ModelAndView mv = new ModelAndView();
        String tablename = studentService.getTreeTable(id);
        mv.setViewName("/core/xg/student/studentGrid");
        mv.addObject("tablename", tablename);
        if ("T_XG_CLASS".equals(tablename)) {
            mv.addObject("classId", id);
        } else if ("T_XG_MAJOR".equals(tablename)) {
//            mv.addObject("tablename",tablename);
            mv.addObject("relationId", id);
        } else if ("T_SYS_DEPT".equals(tablename)) {
//            mv.addObject("tablename",tablename);
            mv.addObject("relationId", id);
        }
        return mv;
    }


    @RequestMapping("/student/studentGridZz")
    public ModelAndView studentGridZz(String id) {
        ModelAndView mv = new ModelAndView();
        String tablename = studentService.getTreeTable(id);
        mv.setViewName("/core/xg/student/studentGridPolytechnicSchool");
        mv.addObject("tablename", tablename);
        if ("T_XG_CLASS".equals(tablename)) {
            mv.addObject("classId", id);
        } else if ("T_XG_MAJOR".equals(tablename)) {
//            mv.addObject("tablename",tablename);
            mv.addObject("relationId", id);
        } else if ("T_SYS_DEPT".equals(tablename)) {
//            mv.addObject("tablename",tablename);
            mv.addObject("relationId", id);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/getStudentList")
    public Map<String, Object> getStudentList(Student student, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> studentList = new HashMap<String, Object>();
        List<Student> list = studentService.getStudentList(student);
        PageInfo<List<Student>> info = new PageInfo(list);
        studentList.put("draw", draw);
        studentList.put("recordsTotal", info.getTotal());
        studentList.put("recordsFiltered", info.getTotal());
        studentList.put("data", list);
        return studentList;
    }

    @RequestMapping("/student/addStudent")
    public ModelAndView addStudent(String classId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/editStudent");
        mv.addObject("classId", classId);
        mv.addObject("head", "学生新增");
        return mv;
    }

    @RequestMapping("/student/addStudentZz")
    public ModelAndView addStudentZz(String classId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/editStudentPolytechnicSchool");
        mv.addObject("classId", classId);
        mv.addObject("head", "学生新增");
        return mv;
    }

    @RequestMapping("/student/updateStudent")
    public ModelAndView updateStudent(String studentId) {
        Student student = studentService.getStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "学生修改");
        mv.addObject("student", student);
        mv.setViewName("/core/xg/student/editStudent");
        return mv;
    }

    @RequestMapping("/student/updateStudentZz")
    public ModelAndView updateStudentZz(String studentId) {
        Student student = studentService.getStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "学生修改");
        mv.addObject("student", student);
        mv.setViewName("/core/xg/student/editStudentPolytechnicSchool");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/savaStudent")
    public Message deptStudent(Student student, String img) {
        String root = new File(getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
        CommonUtil.generateImage(img, root + File.separator + "idcardimg" + File.separator + student.getIdcard() + ".jpeg");
        if (null == student.getStudentId() || "".equals(student.getStudentId())) {
            String idCard = CommonUtil.toIdcardCheck(student.getIdcard());
            student.setIdcard(idCard);
            student.setStudentId(idCard);
            student.setCreator(CommonUtil.getPersonId());
            student.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            studentService.insertStudent(student);
            ClassStudentRelation relation = new ClassStudentRelation();
            relation.setClassId(student.getClassId());
            relation.setStudentId(idCard);
            relation.setCreator(CommonUtil.getPersonId());
            relation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            studentService.addRelation(relation);
            List<ScoreImport> scoreImportList = scoreImportService.getScoreImportByClassId(student.getClassId());
            if (scoreImportList.size() > 0) {
                ScoreImport scoreImport = new ScoreImport();
                for (ScoreImport list : scoreImportList) {
                    scoreImport.setDepartmentsId(list.getDepartmentsId());
                    scoreImport.setMajorCode(list.getMajorCode());
                    scoreImport.setMajorDirection(list.getMajorDirection());
                    scoreImport.setTrainingLevel(list.getTrainingLevel());
                    scoreImport.setSubjectId(list.getSubjectId());
                    scoreImport.setPlanId(list.getPlanId());
                    scoreImport.setScoreExamId(list.getScoreExamId());
                    scoreImport.setScoreExamName(list.getScoreExamName());
                    scoreImport.setClassId(list.getClassId());
                    scoreImport.setPersonId(list.getPersonId());
                    scoreImport.setCourseId(list.getCourseId());
                    scoreImport.setScoreClassId(list.getScoreClassId());
                    scoreImport.setStudentId(student.getIdcard());
                    scoreImport.setStudentName(student.getName());
                    scoreImport.setTermId(list.getTermId());
                    scoreImport.setExamMethod(list.getExamMethod());
                    //                    添加授课老师
                    scoreImport.setTeachingTeacherId(list.getTeachingTeacherId());
                    scoreImportService.insertScoreImport(scoreImport);
                }
                LoginUser loginUser = new LoginUser();
                String userAccount = null;
                try {
                    userAccount = PinyinHelper.convertToPinyinString(student.getName(), "", PinyinFormat.WITHOUT_TONE);
                } catch (PinyinException e) {
                    e.printStackTrace();
                }
                userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setUserAccount(student.getStudentId());
                loginUser.setPersonId(student.getStudentId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("1");
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setDefaultDeptId(student.getClassId());
                loginUser.setName(student.getName());
                loginUser.setIdCardPhotoUrl(File.separator + "idcardimg" + File.separator + student.getIdcard() + ".jpeg");
                loginUserService.saveUser(loginUser);
                return new Message(1, "新增成功！", "success");
            } else {
                LoginUser loginUser = new LoginUser();
                String userAccount = null;
                try {
                    userAccount = PinyinHelper.convertToPinyinString(student.getName(), "", PinyinFormat.WITHOUT_TONE);
                } catch (PinyinException e) {
                    e.printStackTrace();
                }
                userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setUserAccount(student.getStudentId());
                loginUser.setPersonId(student.getStudentId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("1");
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setDefaultDeptId(student.getClassId());
                loginUser.setName(student.getName());
                loginUser.setIdCardPhotoUrl(File.separator + "idcardimg" + File.separator + student.getIdcard() + ".jpeg");
                loginUserService.saveUser(loginUser);
                return new Message(1, "新增成功！", "success");
            }

        } else {
            student.setChanger(CommonUtil.getPersonId());
            student.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            studentService.updateStudent(student);
            LoginUser LoginUser = new LoginUser();
            LoginUser.setPersonId(student.getStudentId());
            LoginUser.setName(student.getName());
            loginUserService.upadtedeLoginUser(LoginUser);

            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/student/checkIdCard")
    public Message checkIdCard(String idcard) {
        List list = studentService.checkIdCard(idcard);
        if (null != list)
            return new Message(list.size(), "", null);
        else
            return new Message(0, "", null);
    }

    @ResponseBody
    @RequestMapping("/student/checkStudentNumber")
    public Message checkStudentNumber(String studentNumber) {
        List list = studentService.checkStudentNumber(studentNumber);
        if (null != list)
            return new Message(list.size(), "", null);
        else
            return new Message(0, "", null);
    }

    @ResponseBody
    @RequestMapping("/student/delStudent")
    public Message delStudent(String studentId) {
        List<Map<String, Object>> maps = studentService.checkStudentById(studentId);
        if (maps.size() > 0) {
            return new Message(0, "当前学生已被使用不能删除！", "error");
        } else {
            loginUserService.deleteUser(studentId);
            studentService.delStudent(studentId);
            studentService.delClassStudentRelation(studentId);
            studentService.delRoleByStudentId(studentId);
            return new Message(1, "删除成功！", "success");
        }

    }

    @RequestMapping("/student/studentClassRelation")
    public ModelAndView studentClassRelation(String studentId) {
        ModelAndView mv = new ModelAndView();
        String relation = "";
        boolean b = true;

        List<ClassStudentRelation> list = studentService.getClassStudentRelation(studentId);
        for (int i = 0; i < list.size(); i++) {
            ClassStudentRelation r = list.get(i);
            if (b) {
                relation += r.getClassId();
                b = false;
            } else
                relation += "," + r.getClassId();
        }

        mv.addObject("relation", relation);
        mv.addObject("studentId", studentId);
        mv.addObject("head", "学生班级关联");
        mv.setViewName("/core/xg/student/studentClassRelation");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/saveRelation")
    public Message saveRelation(String studentId, String relationids) {
        studentService.saveClassStudentRelation(studentId, relationids);
        return new Message(1, "保存成功！", "success");
    }

    @RequestMapping("/student/viewStudent")
    public ModelAndView viewStudent(String studentId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/viewStudent");
        Student student = studentService.getStudentById(studentId);
        mv.addObject("student", student);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/getStudentListByDeptOrMajor")
    public Map<String, Object> getStudentListByDeptOrMajor(
            String tablename, String relationId, String name, String idcard, String level, int draw, int start, int length) {
        Map<String, Object> studentList = new HashMap<>();
        PageHelper.startPage(start / length + 1, length);
        List<Student> students = null;
        if ("T_XG_MAJOR".equals(tablename)) {
            students = studentService.getStudentListByMajor(relationId, name, idcard, level);
        } else if ("T_SYS_DEPT".equals(tablename)) {
            students = studentService.getStudentListByDept(relationId, relationId + "%", name, idcard, level);

        }
        PageInfo<List<Student>> info = new PageInfo(students);
        studentList.put("draw", draw);
        studentList.put("recordsTotal", info.getTotal());
        studentList.put("recordsFiltered", info.getTotal());
        studentList.put("data", students);
        return studentList;
    }

    /**
     * 导出表数据
     * 222
     *
     * @param response
     */
    @RequestMapping("/student/exportStudent")
    public void exportStudent(@RequestParam Map<String, Object> param, HttpServletResponse response) {

        List<Student> stuS = studentService.exportStudent(param);
        HSSFWorkbook wb = null;
        if (param.get("type").equals("0")) {
            wb = studentService.getStudentExcelTemplate(param.get("type").toString());
            HSSFSheet sheet = wb.getSheetAt(0);
            for (int i = 0; i < stuS.size(); i++) {
                sheet.createRow(i + 1).createCell(0).setCellValue(stuS.get(i).getCandidateNumberDz());
                sheet.getRow(i + 1).createCell(1).setCellValue(stuS.get(i).getStudentNumber());
                sheet.getRow(i + 1).createCell(2).setCellValue(stuS.get(i).getName());
                sheet.getRow(i + 1).createCell(3).setCellValue(stuS.get(i).getSex());
                sheet.getRow(i + 1).createCell(4).setCellValue(CommonUtil.formatData("yyyy-MM-dd", stuS.get(i).getBirthday()));
                sheet.getRow(i + 1).createCell(5).setCellValue(stuS.get(i).getIdcard());
                sheet.getRow(i + 1).createCell(6).setCellValue(stuS.get(i).getPoliticalStatus());
                sheet.getRow(i + 1).createCell(7).setCellValue(stuS.get(i).getNation());
                sheet.getRow(i + 1).createCell(8).setCellValue(stuS.get(i).getMajorCode());
                sheet.getRow(i + 1).createCell(9).setCellValue(stuS.get(i).getMajorShow());
                sheet.getRow(i + 1).createCell(10).setCellValue(stuS.get(i).getTrainingLevel());
                sheet.getRow(i + 1).createCell(11).setCellValue(stuS.get(i).getEductionalSystem());
                sheet.getRow(i + 1).createCell(12).setCellValue(stuS.get(i).getLearnMode());
                sheet.getRow(i + 1).createCell(13).setCellValue(stuS.get(i).getTotalPoints());
                sheet.getRow(i + 1).createCell(14).setCellValue(stuS.get(i).getClassId());
            }
        } else {
            wb = studentService.getStudentExcelTemplate1();
            HSSFSheet sheet = wb.getSheetAt(0);
            for (int i = 0; i < stuS.size(); i++) {
                sheet.createRow(i + 3).createCell(0).setCellValue(stuS.get(i).getName());
                sheet.getRow(i + 3).createCell(1).setCellValue(stuS.get(i).getSex());
                sheet.getRow(i + 3).createCell(2).setCellValue(CommonUtil.formatData("yyyy-MM-dd", stuS.get(i).getBirthday()));
                sheet.getRow(i + 3).createCell(3).setCellValue(stuS.get(i).getIdCardType());
                sheet.getRow(i + 3).createCell(4).setCellValue(stuS.get(i).getIdcard());
                sheet.getRow(i + 3).createCell(5).setCellValue(stuS.get(i).getSpellName());
                sheet.getRow(i + 3).createCell(6).setCellValue(stuS.get(i).getClassId());
                sheet.getRow(i + 3).createCell(7).setCellValue(stuS.get(i).getStudentNumber());
                sheet.getRow(i + 3).createCell(8).setCellValue(stuS.get(i).getStudentType());
                sheet.getRow(i + 3).createCell(9).setCellValue(stuS.get(i).getLearnMode());
                sheet.getRow(i + 3).createCell(10).setCellValue(stuS.get(i).getEnrollmentType());
                sheet.getRow(i + 3).createCell(11).setCellValue(stuS.get(i).getStudyingWay());
                sheet.getRow(i + 3).createCell(12).setCellValue(stuS.get(i).getNationality());
                sheet.getRow(i + 3).createCell(13).setCellValue(stuS.get(i).getOverseasChinese());
                sheet.getRow(i + 3).createCell(14).setCellValue(stuS.get(i).getMaritalStatus());
                sheet.getRow(i + 3).createCell(15).setCellValue(stuS.get(i).getTrainInterval());
                sheet.getRow(i + 3).createCell(16).setCellValue(stuS.get(i).getTrailingChildrenFlag());
                sheet.getRow(i + 3).createCell(17).setCellValue(stuS.get(i).getSourcePlaceDivisionCode());
                sheet.getRow(i + 3).createCell(18).setCellValue(stuS.get(i).getBirthPlaceDivisionCode());
                sheet.getRow(i + 3).createCell(19).setCellValue(stuS.get(i).getNativePlaceDivisionCode());
                sheet.getRow(i + 3).createCell(20).setCellValue(stuS.get(i).getHouseholdRegisterPlace());
                sheet.getRow(i + 3).createCell(21).setCellValue(stuS.get(i).getSubordinateStation());
                sheet.getRow(i + 3).createCell(22).setCellValue(stuS.get(i).getResidenceDivisionCode());
                sheet.getRow(i + 3).createCell(23).setCellValue(stuS.get(i).getHouseholdRegisterType());
                sheet.getRow(i + 3).createCell(24).setCellValue(stuS.get(i).getStudentResidenceType());
                sheet.getRow(i + 3).createCell(25).setCellValue(stuS.get(i).getYear() + stuS.get(i).getMonth());
                sheet.getRow(i + 3).createCell(26).setCellValue(stuS.get(i).getProfessionalExpertise());
                sheet.getRow(i + 3).createCell(27).setCellValue(stuS.get(i).getEductionalSystem());
                sheet.getRow(i + 3).createCell(28).setCellValue(stuS.get(i).getNation());
                sheet.getRow(i + 3).createCell(29).setCellValue(stuS.get(i).getPoliticalStatus());
                sheet.getRow(i + 3).createCell(30).setCellValue(stuS.get(i).getHealthCondition());
                sheet.getRow(i + 3).createCell(31).setCellValue(stuS.get(i).getFrom());
                sheet.getRow(i + 3).createCell(32).setCellValue(stuS.get(i).getEnrollmentTarget());
                sheet.getRow(i + 3).createCell(33).setCellValue(stuS.get(i).getTel());
                sheet.getRow(i + 3).createCell(34).setCellValue(stuS.get(i).getAdmissionsWay());
                sheet.getRow(i + 3).createCell(35).setCellValue(stuS.get(i).getCooperationType());
                sheet.getRow(i + 3).createCell(36).setCellValue(stuS.get(i).getExaminationCardNumber());
                sheet.getRow(i + 3).createCell(37).setCellValue(stuS.get(i).getCandidateNumber());
                sheet.getRow(i + 3).createCell(38).setCellValue(stuS.get(i).getTestScores());
                sheet.getRow(i + 3).createCell(39).setCellValue(stuS.get(i).getFormCooperativeEducation());
                sheet.getRow(i + 3).createCell(40).setCellValue(stuS.get(i).getCodeCooperativeEducation());
                sheet.getRow(i + 3).createCell(41).setCellValue(stuS.get(i).getExternalTeachingPoint());
                sheet.getRow(i + 3).createCell(42).setCellValue(stuS.get(i).getSubsectionCulture());
                sheet.getRow(i + 3).createCell(43).setCellValue(stuS.get(i).getNameOfMember());
                sheet.getRow(i + 3).createCell(44).setCellValue(stuS.get(i).getMemberRelationship());
                sheet.getRow(i + 3).createCell(45).setCellValue(stuS.get(i).getIsGuardian());
                sheet.getRow(i + 3).createCell(46).setCellValue(stuS.get(i).getMemberTelephoneNumber());
                sheet.getRow(i + 3).createCell(47).setCellValue(stuS.get(i).getGraduationSchool());
            }
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("学生基本信息.xls", "utf-8"));
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

    /**
     * 导出模板 大专
     *
     * @param response
     */
    @Autowired
    private MajorService majorService;
    @Autowired
    private ClassService classService;

    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }

    @RequestMapping("/student/getStudentExcelTemplate")
    public void getStudentExcelTemplate(HttpServletResponse response) {
        HSSFWorkbook wb = studentService.getStudentExcelTemplate("1");
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("学生基本信息模板.xls", "utf-8"));
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

    /**
     * 导出模板 中专
     *
     * @param response
     */
    @RequestMapping("/student/getStudentExcelTemplate1")
    public void getStudentExcelTemplate1(HttpServletResponse response) {
        HSSFWorkbook wb = studentService.getStudentExcelTemplate1();
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("中专学生基本信息模板.xls", "utf-8"));
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
    @RequestMapping("/student/importStudent1130")
    public Message importStudent1130(@RequestParam(value = "file", required = false) CommonsMultipartFile file, HttpServletResponse response) {
        int count = 0;
        try {
            HSSFWorkbook wb = studentService.getStudentExcelTemplate1();
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheet("学生基础信息");
            HSSFCellStyle cellStyle = workbook.createCellStyle();
            cellStyle.setDataFormat(workbook.createDataFormat().getFormat("@"));
            List<HSSFRow> errorRowList = new ArrayList<>();

            if (sheet != null) {

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                List<Select2> sexs = commonService.getSysDict("XB", "");
                List<Select2> xslx = commonService.getSysDict("XSLX", "");
                List<Select2> gj = commonService.getSysDict("GJ", "");
                List<Select2> gatqb = commonService.getSysDict("GATQB", "");
                List<Select2> hyzk = commonService.getSysDict("HYZK", "");
                List<Select2> hjxz = commonService.getSysDict("HJXZ", "");
                List<Select2> xz = commonService.getSysDict("XZ", "");
                List<Select2> mz = commonService.getSysDict("MZ", "");
                List<Select2> zzmm = commonService.getSysDict("ZZMM", "");
                List<Select2> sylx = commonService.getSysDict("XSLY", "");

                int end = sheet.getLastRowNum();

                for (int i = 3; i <= end; i++) {

                    HSSFRow row = sheet.getRow(i);

                    if (null == row && count == 0) {

                        return new Message(0, "无数据，导入失败！", "error");

                    } else if (null == row || row.getLastCellNum() == 1) {

                        if (errorRowList.size() > 0) {

                            int tmp = 3;

                            for (HSSFRow rows : errorRowList) {

                                if (rows != null) {

                                    HSSFCellStyle textStyle = wb.createCellStyle();
                                    textStyle.setBorderLeft(BorderStyle.THIN);//左边框
                                    textStyle.setBorderTop(BorderStyle.THIN);//上边框
                                    textStyle.setBorderRight(BorderStyle.THIN);//右边框
                                    textStyle.setBorderBottom(BorderStyle.THIN); //下边框
                                    textStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
                                    textStyle.setDataFormat(wb.createDataFormat().getFormat("@"));

                                    HSSFRow row1 = wb.getSheet("学生基础信息").createRow(tmp);

                                    for (int j = 0; j < 43; j++) {

                                        if (rows.getCell(j) != null) {
                                            row1.createCell(j).setCellValue(rows.getCell(j).toString());
                                            row1.getCell(j).setCellStyle(textStyle);
                                        }
                                    }

                                    tmp++;
                                }
                            }

                            SimpleDateFormat ddd = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
                            String fileName = "/tmp/错误数据_" + ddd.format(System.currentTimeMillis()) + ".xls";
                            String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent();
                            File files = new File(rootPath + fileName);
                            if (!files.exists()) {
                                files.createNewFile();
                            }
                            FileOutputStream outputStream = new FileOutputStream(files);
                            wb.write(outputStream);
                            outputStream.close();
                            wb.close();

                            return new Message(3, "共计" + count + "条，导入成功！", fileName);

                        } else {

                            return new Message(1, "共计" + count + "条，导入成功！", "success");
                        }
                    }

                    Student student = new Student();

                    if (row.getCell(0) != null && row.getCell(0).toString() != null && !"".equals(row.getCell(0).toString())) {

                        student.setName(row.getCell(0).toString());

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(1) != null && row.getCell(1).toString() != null && !"".equals(row.getCell(1).toString())) {

                        for (Select2 sex : sexs) {
                            if (sex.getText().equals(row.getCell(1).toString())) {
                                student.setSex(sex.getId());
                            }
                        }

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(2) != null && row.getCell(2).toString() != null && !"".equals(row.getCell(2).toString())) {
                        String r = row.getCell(2).toString();
                        student.setBirthday(new Date(sdf.parse(row.getCell(2).toString()).getTime()));

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(3) != null && row.getCell(3).toString() != null && !"".equals(row.getCell(3).toString())) {
                        row.getCell(3).setCellStyle(cellStyle);
                        row.getCell(3).setCellType(CellType.STRING);
                        student.setIdCardType(row.getCell(3).toString());
                    } else {
                        student.setIdCardType("1");
                    }

                    if (row.getCell(4) != null && row.getCell(4).toString() != null && !"".equals(row.getCell(4).toString())) {
                        row.getCell(4).setCellStyle(cellStyle);
                        row.getCell(4).setCellType(CellType.STRING);
                        student.setIdcard(row.getCell(4).toString());
                        student.setStudentId(row.getCell(4).toString());

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(5) != null && row.getCell(5).toString() != null && !"".equals(row.getCell(5).toString())) {

                        student.setSpellName(row.getCell(5).toString());

                    }

                    if (row.getCell(6) != null && row.getCell(6).toString() != null && !"".equals(row.getCell(6).toString())) {
                        String className = row.getCell(6).toString();
                        String classId = studentService.getClassIdByClassName(className);
//                        ClassBean classBean = classService.selectClassBeranByClassName(row.getCell(6).toString(), "2");

//                        if (classBean != null) {

                        student.setClassId(classId);

//                        } else {
//
//                            errorRowList.add(row);
//                            continue;
//                        }

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(7) != null && row.getCell(7).toString() != null && !"".equals(row.getCell(7).toString())) {
                        row.getCell(7).setCellStyle(cellStyle);
                        row.getCell(7).setCellType(CellType.STRING);
                        student.setStudentNumber(row.getCell(7).toString());

                    } else {

                        errorRowList.add(row);
                        continue;
                    }

                    if (row.getCell(8) != null && row.getCell(8).toString() != null && !"".equals(row.getCell(8).toString())) {
                        for (Select2 dic : xslx) {
                            if (dic.getText().equals(row.getCell(8).toString())) {
                                student.setStudentType(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(9) != null && row.getCell(9).toString() != null && !"".equals(row.getCell(9).toString())) {
                        student.setLearnMode(row.getCell(9).toString());
                    }

                    if (row.getCell(10) != null && row.getCell(10).toString() != null && !"".equals(row.getCell(10).toString())) {

                        student.setEnrollmentType(row.getCell(10).toString());

                    }

                    if (row.getCell(11) != null && row.getCell(11).toString() != null && !"".equals(row.getCell(11).toString())) {

                        student.setStudyingWay(row.getCell(11).toString());

                    }

                    if (row.getCell(12) != null && row.getCell(12).toString() != null && !"".equals(row.getCell(12).toString())) {

                        for (Select2 dic : gj) {
                            if (dic.getText().equals(row.getCell(12).toString())) {
                                student.setNationality(dic.getId());
                            }
                        }

                    }
                    if (row.getCell(13) != null && row.getCell(13).toString() != null && !"".equals(row.getCell(13).toString())) {

                        for (Select2 dic : gatqb) {
                            if (dic.getText().equals(row.getCell(13).toString())) {
                                student.setOverseasChinese(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(14) != null && row.getCell(14).toString() != null && !"".equals(row.getCell(14).toString())) {

                        for (Select2 dic : hyzk) {
                            if (dic.getText().equals(row.getCell(14).toString())) {
                                student.setMaritalStatus(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(15) != null && row.getCell(15).toString() != null && !"".equals(row.getCell(15).toString())) {

                        student.setTrainInterval(row.getCell(15).toString());

                    }

                    if (row.getCell(16) != null && row.getCell(16).toString() != null && !"".equals(row.getCell(16).toString())) {

                        student.setTrailingChildrenFlag(row.getCell(16).toString());

                    }

                    if (row.getCell(17) != null && row.getCell(17).toString() != null && !"".equals(row.getCell(17).toString())) {

                        student.setSourcePlaceDivisionCode(row.getCell(17).toString());

                    }
                    if (row.getCell(18) != null && row.getCell(18).toString() != null && !"".equals(row.getCell(18).toString())) {

                        student.setBirthPlaceDivisionCode(row.getCell(18).toString());

                    }

                    if (row.getCell(19) != null && row.getCell(19).toString() != null && !"".equals(row.getCell(19).toString())) {

                        student.setNativePlaceDivisionCode(row.getCell(19).toString());

                    }

                    if (row.getCell(20) != null && row.getCell(20).toString() != null && !"".equals(row.getCell(20).toString())) {

                        student.setHouseholdRegisterPlace(row.getCell(20).toString());

                    }

                    if (row.getCell(21) != null && row.getCell(21).toString() != null && !"".equals(row.getCell(21).toString())) {

                        student.setSubordinateStation(row.getCell(21).toString());

                    }

                    if (row.getCell(22) != null && row.getCell(22).toString() != null && !"".equals(row.getCell(22).toString())) {

                        student.setResidenceDivisionCode(row.getCell(22).toString());

                    }

                    if (row.getCell(23) != null && row.getCell(23).toString() != null && !"".equals(row.getCell(23).toString())) {

                        for (Select2 dic : hjxz) {
                            if (dic.getText().equals(row.getCell(23).toString())) {
                                student.setHouseholdRegisterType(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(24) != null && row.getCell(24).toString() != null && !"".equals(row.getCell(24).toString())) {

                        student.setStudentResidenceType(row.getCell(24).toString());

                    }

                    if (row.getCell(25) != null && row.getCell(25).toString() != null && !"".equals(row.getCell(25).toString()) && row.getCell(25).toString().length() == 6) {

                        student.setJoinYear(row.getCell(25).toString().substring(0, 4));
                        student.setJoinMonth(row.getCell(25).toString().substring(4, 6));

                    }

                    if (row.getCell(26) != null && row.getCell(26).toString() != null && !"".equals(row.getCell(26).toString())) {

                        student.setProfessionalExpertise(row.getCell(26).toString());

                    }

                    if (row.getCell(27) != null && row.getCell(27).toString() != null && !"".equals(row.getCell(27).toString())) {

                        for (Select2 dic : xz) {
                            if (dic.getText().equals(row.getCell(27).toString())) {
                                student.setEductionalSystem(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(28) != null && row.getCell(28).toString() != null && !"".equals(row.getCell(28).toString())) {

                        for (Select2 dic : mz) {
                            if (dic.getText().equals(row.getCell(28).toString())) {
                                student.setNation(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(29) != null && row.getCell(29).toString() != null && !"".equals(row.getCell(29).toString())) {

                        for (Select2 dic : zzmm) {
                            if (dic.getText().equals(row.getCell(29).toString())) {
                                student.setPoliticalStatus(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(30) != null && row.getCell(30).toString() != null && !"".equals(row.getCell(30).toString())) {

                        student.setHealthCondition(row.getCell(30).toString());

                    }

                    if (row.getCell(31) != null && row.getCell(31).toString() != null && !"".equals(row.getCell(31).toString())) {
                        for (Select2 dic : sylx) {
                            if (dic.getText().equals(row.getCell(31).toString())) {
                                student.setFrom(dic.getId());
                            }
                        }

                    }

                    if (row.getCell(32) != null && row.getCell(32).toString() != null && !"".equals(row.getCell(32).toString())) {
                        student.setEnrollmentTarget(row.getCell(32).toString());
                    }

                    if (row.getCell(33) != null && row.getCell(33).toString() != null && !"".equals(row.getCell(33).toString())) {
                        student.setTel(row.getCell(33).toString());

                    }

                    if (row.getCell(34) != null && row.getCell(34).toString() != null && !"".equals(row.getCell(34).toString())) {
                        student.setAdmissionsWay(row.getCell(34).toString());
                    }

                    if (row.getCell(35) != null && row.getCell(35).toString() != null && !"".equals(row.getCell(35).toString())) {
                        student.setCooperationType(row.getCell(35).toString());
                    }

                    if (row.getCell(36) != null && row.getCell(36).toString() != null && !"".equals(row.getCell(36).toString())) {
                        student.setExaminationCardNumber(row.getCell(36).toString());
                    }

                    if (row.getCell(37) != null && row.getCell(37).toString() != null && !"".equals(row.getCell(37).toString())) {
                        row.getCell(37).setCellStyle(cellStyle);
                        row.getCell(37).setCellType(CellType.STRING);
                        student.setCandidateNumber(row.getCell(37).toString());
                    }

                    if (row.getCell(38) != null && row.getCell(38).toString() != null && !"".equals(row.getCell(38).toString())) {
                        student.setTestScores(row.getCell(38).toString());
                    }
                    if (row.getCell(39) != null && row.getCell(39).toString() != null && !"".equals(row.getCell(39).toString())) {
                        student.setFormCooperativeEducation(row.getCell(39).toString());
                    }

                    if (row.getCell(40) != null && row.getCell(40).toString() != null && !"".equals(row.getCell(40).toString())) {
                        student.setCodeCooperativeEducation(row.getCell(40).toString());
                    }

                    if (row.getCell(41) != null && row.getCell(41).toString() != null && !"".equals(row.getCell(41).toString())) {
                        student.setExternalTeachingPoint(row.getCell(41).toString());
                    }

                    if (row.getCell(42) != null && row.getCell(42).toString() != null && !"".equals(row.getCell(42).toString())) {
                        student.setSubsectionCulture(row.getCell(42).toString());
                    }

                    if (row.getCell(43) != null && row.getCell(43).toString() != null && !"".equals(row.getCell(43).toString())) {
                        student.setNameOfMember(row.getCell(43).toString());
                    }
                    if (row.getCell(44) != null && row.getCell(44).toString() != null && !"".equals(row.getCell(44).toString())) {
                        student.setMemberRelationship(row.getCell(44).toString());
                    }
                    if (row.getCell(45) != null && row.getCell(45).toString() != null && !"".equals(row.getCell(45).toString())) {
                        student.setIsGuardian(row.getCell(45).toString());
                    }
                    if (row.getCell(46) != null && row.getCell(46).toString() != null && !"".equals(row.getCell(46).toString())) {
                        student.setMemberTelephoneNumber(row.getCell(46).toString());
                    }

                    if (row.getCell(47) != null && row.getCell(47).toString() != null && !"".equals(row.getCell(47).toString())) {
                        student.setGraduationSchool(row.getCell(47).toString());
                    }

                    Student oldStudent = studentService.getStudentById(student.getStudentId());

                    if (oldStudent != null) {

                        return new Message(2, "抱歉，身份证号为" + student.getStudentId() + "的" + student.getName() + "同学已存在", "error");
                    }

                    studentService.insertStudent(student);


                    ClassStudentRelation CSRelation = new ClassStudentRelation();
                    CSRelation.setId(CommonUtil.getUUID());
                    CSRelation.setStudentId(student.getStudentId());
                    CSRelation.setClassId(student.getClassId());
                    CSRelation.setCreator(CommonUtil.getPersonId());
                    CSRelation.setCreateDept(CommonUtil.getDefaultDept());
                    CSRelation.setCreateTime(CommonUtil.getDate());
                    studentService.addRelation(CSRelation);

                    LoginUser loginUser = new LoginUser();

                    loginUser.setId(CommonUtil.getUUID());
                    loginUser.setName(student.getName());
                    loginUser.setUserAccount(student.getIdcard());
                    loginUser.setPersonId(student.getStudentId());
                    loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                    loginUser.setUserType("1");
                    loginUser.setCreateDept(CommonUtil.getDefaultDept());
                    loginUser.setCreateTime(CommonUtil.getDate());
                    loginUser.setCreator(CommonUtil.getPersonId());
                    loginUser.setDefaultDeptId(student.getClassId());
                    loginUserService.saveUser(loginUser);
                    count++;
                }

//                if (errorRowList.size() > 0) {
//
//                    int tmp = 3;
//
//                    for (HSSFRow row : errorRowList) {
//
//                        if (row != null) {
//
//                            HSSFCellStyle textStyle = wb.createCellStyle();
//                            textStyle.setBorderLeft(BorderStyle.THIN);//左边框
//                            textStyle.setBorderTop(BorderStyle.THIN);//上边框
//                            textStyle.setBorderRight(BorderStyle.THIN);//右边框
//                            textStyle.setBorderBottom(BorderStyle.THIN); //下边框
//                            textStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
//                            textStyle.setDataFormat(wb.createDataFormat().getFormat("@"));
//
//                            HSSFRow row1 = wb.getSheet("学生基础信息").createRow(tmp);
//
//                            for (int j = 0; j < 48; j++) {
//
//                                if (row.getCell(j) != null) {
//                                    row1.createCell(j).setCellValue(row.getCell(j).toString());
//                                    row1.getCell(j).setCellStyle(textStyle);
//                                }
//                            }
//
//                            tmp++;
//                        }
//                    }
//
//                    SimpleDateFormat ddd = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
//                    String fileName = "/tmp/错误数据_" + ddd.format(System.currentTimeMillis()) + ".xls";
//                    String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent();
//                    File files = new File(rootPath + fileName);
//                    if (!files.exists()) {
//                        files.createNewFile();
//                    }
//                    FileOutputStream outputStream = new FileOutputStream(files);
//                    wb.write(outputStream);
//                    outputStream.close();
//                    wb.close();
//
//                    return new Message(3, "共计" + count + "条，导入成功！", fileName);
//
//                } else {

//                    return new Message(1, "共计" + count + "条，导入成功！", "success");
//                }
            }

        } catch (Exception allE) {

            allE.printStackTrace();
        }
        return new Message(1, "共计" + count + "条，导入成功！", "success");
//        return new Message(2, "系统错误，请稍后重试", "error");
    }

    /**
     * 导入数据 中专
     *
     * @param file
     * @param classId
     * @return
     */
    @ResponseBody
    @RequestMapping("/student/importStudent1")
    public Message importStudent1(@RequestParam(value = "file", required = false) CommonsMultipartFile file,
                                  @RequestParam("classId") String classId, HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        List<Select2> sexs = commonService.getSysDict("XB", "");
        List<Select2> mzs = commonService.getSysDict("MZ", "");
        List<Select2> xszt = commonService.getSysDict("XSZT", "");
        List<Select2> zzmm = commonService.getSysDict("ZZMM", "");
        List<Select2> gj = commonService.getSysDict("GJ", "");
        List<Select2> xslx = commonService.getSysDict("XSLX", "");
        List<Select2> gatqb = commonService.getSysDict("GATQB", "");
        List<Select2> hjxz = commonService.getSysDict("HJXZ", "");
        List<Select2> yf1 = commonService.getSysDict("YF", "");
        List<Select2> nd1 = commonService.getSysDict("ND", "");
        List<Select2> xsly = commonService.getSysDict("XSLY", "");
        int count = 0;
        try {
            HSSFWorkbook workbook1 = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook1.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if (null == row && count == 0) {
                    return new Message(0, "无数据，导入失败！", "error");
                } else if (null == row || row.getLastCellNum() == 1) {
                    return new Message(1, "共计" + count + "条，导入成功！", "success");
                }

                Student student = new Student();
                student.setName(row.getCell(0).toString());
                for (Select2 sex : sexs) {
                    if (sex.getText().equals(row.getCell(1).toString())) {
                        student.setSex(sex.getId());
                    }
                }
                student.setIdcard(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
                student.setStudentId(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
                student.setStudentNumber(CommonUtil.toIdcardCheck(row.getCell(3).toString()));
/*
                String time = CommonUtil.changeToString(row.getCell(4));
                if(!"".equals(time)){
                    try {
                        student.setBirthday(CommonUtil.formatExcelDate(time));
                    } catch (ParseException e1) {
                        e1.printStackTrace();
                    }
                }
*/
                if (student.getIdcard().length() >= 15) {
                    String birthday = student.getIdcard().substring(6, 14);
                    student.setBirthday(new Date(sdf.parse(birthday).getTime()));
                }
                /*String time = row.getCell(4).toString();
                student.setBirthday(new Date(sdf.parse(time).getTime()));*/
                if (null == CommonUtil.changeToString(row.getCell(5))
                        || CommonUtil.changeToString(row.getCell(5)).equals("")) {
                    student.setNationality("156");
                } else {
                    for (Select2 g : gj) {
                        if (g.getText().equals(CommonUtil.changeToString(row.getCell(5)))) {
                            student.setNationality(g.getId());
                        }
                    }
                }
                for (Select2 mz : mzs) {
                    if (mz.getText().equals(CommonUtil.changeToString(row.getCell(6)))) {
                        student.setNation(mz.getId());
                    }
                }
                student.setAddress(CommonUtil.changeToString(row.getCell(7)));
                student.setHouseholdRegisterPlace(CommonUtil.changeToString(row.getCell(8)));
                if (null == CommonUtil.changeToString(row.getCell(9))
                        || CommonUtil.changeToString(row.getCell(9)).equals("")) {
                    student.setPoliticalStatus("13");
                } else if (CommonUtil.changeToString(row.getCell(9)).equals("团员")) {
                    student.setPoliticalStatus("03");
                } else {
                    for (Select2 mz : zzmm) {
                        if (mz.getText().equals(CommonUtil.changeToString(row.getCell(9)))) {
                            student.setPoliticalStatus(mz.getId());
                        }
                    }
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(10))) || null == CommonUtil.changeToString(row.getCell(10))) {
                    try {
                        student.setHomePhone(CommonUtil.changeToString(row.getCell(10)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setHomePhone(CommonUtil.changeToString(row.getCell(10)));
                }

                if ("".equals(CommonUtil.changeToString(row.getCell(11))) || null == CommonUtil.changeToString(row.getCell(11))) {
                    try {
                        student.setTel(CommonUtil.changeToString(row.getCell(11)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setTel(CommonUtil.changeToString(row.getCell(11)));
                }
                if (null == CommonUtil.changeToString(row.getCell(12))
                        || CommonUtil.changeToString(row.getCell(12)).equals("")) {
                    student.setStudentStatus("1");
                } else {
                    for (Select2 zt : xszt) {
                        if (zt.getText().equals(CommonUtil.changeToString(row.getCell(12)))) {
                            student.setStudentStatus(zt.getId());
                        }
                    }
                }
                student.setEductionalSystem(CommonUtil.changeToString(row.getCell(13)));
                if ("".equals(CommonUtil.changeToString(row.getCell(14))) || null == CommonUtil.changeToString(row.getCell(14))) {
                    try {
                        student.setLearnMode(CommonUtil.changeToString(row.getCell(14)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setLearnMode(CommonUtil.changeToString(row.getCell(14)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(15))) || null == CommonUtil.changeToString(row.getCell(15))) {
                    try {
                        student.setTotalPoints(CommonUtil.toIdcardCheck(row.getCell(15).toString()));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setTotalPoints(CommonUtil.toIdcardCheck(row.getCell(15).toString()));
                }
                student.setIdCardType(CommonUtil.changeToString(row.getCell(16)));
                student.setSpellName(CommonUtil.changeToString(row.getCell(17)));
                if (null == CommonUtil.changeToString(row.getCell(18))
                        || CommonUtil.changeToString(row.getCell(18)).equals("")) {
                    student.setStudentType("1");
                } else {
                    for (Select2 xsl : xslx) {
                        if (xsl.getText().equals(CommonUtil.changeToString(row.getCell(18)))) {
                            student.setStudentType(xsl.getId());
                        }
                    }
                }
                student.setEnrollmentType(CommonUtil.changeToString(row.getCell(19)));
                student.setStudyingWay(CommonUtil.changeToString(row.getCell(20)));
                if (null == CommonUtil.changeToString(row.getCell(21))
                        || CommonUtil.changeToString(row.getCell(21)).equals("")) {
                    student.setOverseasChinese("0");
                } else {
                    for (Select2 gatq : gatqb) {
                        if (gatq.getText().equals(CommonUtil.changeToString(row.getCell(21)))) {
                            student.setOverseasChinese(gatq.getId());
                        }
                    }
                }
                student.setMaritalStatus(CommonUtil.changeToString(row.getCell(22)));
                student.setTrainInterval(CommonUtil.changeToString(row.getCell(23)));
                student.setTrailingChildrenFlag(CommonUtil.changeToString(row.getCell(24)));
                HSSFCell hssef1 = row.getCell(25);
                hssef1.setCellType(hssef1.CELL_TYPE_STRING);
                student.setSourcePlaceDivisionCode(hssef1.toString() + "");
                HSSFCell hssef2 = row.getCell(26);
                hssef2.setCellType(hssef1.CELL_TYPE_STRING);
                student.setBirthPlaceDivisionCode(hssef2.toString() + "");
                HSSFCell hssef3 = row.getCell(27);
                hssef3.setCellType(hssef1.CELL_TYPE_STRING);
                student.setNativePlaceDivisionCode(hssef3.toString() + "");
                student.setSubordinateStation(CommonUtil.changeToString(row.getCell(28)));
                HSSFCell hssef4 = row.getCell(29);
                hssef4.setCellType(hssef1.CELL_TYPE_STRING);
                student.setResidenceDivisionCode(hssef4.toString() + "");
                if (null == CommonUtil.changeToString(row.getCell(30))
                        || CommonUtil.changeToString(row.getCell(30)).equals("")) {
                    student.setHouseholdRegisterType("0");
                } else {
                    for (Select2 hjx : hjxz) {
                        if (hjx.getText().equals(CommonUtil.changeToString(row.getCell(30)))) {
                            student.setHouseholdRegisterType(hjx.getId());
                        }
                    }
                }
                student.setStudentResidenceType(CommonUtil.changeToString(row.getCell(31)));
                if (null == CommonUtil.changeToString(row.getCell(32))
                        || CommonUtil.changeToString(row.getCell(32)).equals("")) {
                    student.setJoinYear("2018");
                } else {
                    for (Select2 nd : nd1) {
                        if (nd.getText().equals(CommonUtil.changeToString(row.getCell(32)))) {
                            student.setJoinYear(nd.getId());
                        }
                    }
                }
                if (null == CommonUtil.changeToString(row.getCell(33))
                        || CommonUtil.changeToString(row.getCell(33)).equals("")) {
                    student.setJoinMonth("1");
                } else {
                    for (Select2 yf : yf1) {
                        if (yf.getText().equals(CommonUtil.changeToString(row.getCell(33)))) {
                            student.setJoinMonth(yf.getId());
                        }
                    }
                }
                student.setProfessionalExpertise(CommonUtil.changeToString(row.getCell(34)));
                student.setHealthCondition(CommonUtil.changeToString(row.getCell(35)));
                if (null == CommonUtil.changeToString(row.getCell(36))
                        || CommonUtil.changeToString(row.getCell(36)).equals("")) {
                    student.setStudentSource("1");
                } else {
                    for (Select2 xsl : xsly) {
                        if (xsl.getText().equals(CommonUtil.changeToString(row.getCell(36)))) {
                            student.setStudentSource(xsl.getId());
                        }
                    }
                }
                student.setEnrollmentTarget(CommonUtil.changeToString(row.getCell(37)));
                student.setAdmissionsWay(CommonUtil.changeToString(row.getCell(38)));
                student.setCooperationType(CommonUtil.changeToString(row.getCell(39)));
                if ("".equals(CommonUtil.changeToString(row.getCell(40))) || null == CommonUtil.changeToString(row.getCell(40))) {
                    try {
                        student.setCandidateNumber(CommonUtil.changeToString(row.getCell(40)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setCandidateNumber(CommonUtil.changeToString(row.getCell(40)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(41))) || null == CommonUtil.changeToString(row.getCell(41))) {
                    try {
                        student.setExaminationCardNumber(CommonUtil.changeToString(row.getCell(41)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setExaminationCardNumber(CommonUtil.changeToString(row.getCell(41)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(42))) || null == CommonUtil.changeToString(row.getCell(24))) {
                    try {
                        student.setTestScores(CommonUtil.changeToString(row.getCell(42)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setTestScores(CommonUtil.changeToString(row.getCell(42)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(43))) || null == CommonUtil.changeToString(row.getCell(43))) {
                    try {
                        student.setFormCooperativeEducation(CommonUtil.changeToString(row.getCell(43)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setFormCooperativeEducation(CommonUtil.changeToString(row.getCell(43)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(44))) || null == CommonUtil.changeToString(row.getCell(44))) {
                    try {
                        student.setCodeCooperativeEducation(CommonUtil.changeToString(row.getCell(44)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setCodeCooperativeEducation(CommonUtil.changeToString(row.getCell(44)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(45))) || null == CommonUtil.changeToString(row.getCell(45))) {
                    try {
                        student.setExternalTeachingPoint(CommonUtil.changeToString(row.getCell(45)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setExternalTeachingPoint(CommonUtil.changeToString(row.getCell(45)));
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(46))) || null == CommonUtil.changeToString(row.getCell(46))) {
                    try {
                        student.setSubsectionCulture(CommonUtil.changeToString(row.getCell(46)));
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }

                } else {
                    student.setSubsectionCulture(CommonUtil.changeToString(row.getCell(46)));
                }
                student.setCreateDept(CommonUtil.getDefaultDept());
                student.setCreateTime(CommonUtil.getDate());
                student.setCreator(CommonUtil.getPersonId());
                student.setClassName(studentService.getClassNameByClassId(classId));
                studentService.insertStudent(student);

                ClassStudentRelation CSRelation = new ClassStudentRelation();
                CSRelation.setId(CommonUtil.getUUID());
                CSRelation.setStudentId(student.getStudentId());
                CSRelation.setClassId(classId);
                CSRelation.setCreator(CommonUtil.getPersonId());
                CSRelation.setCreateDept(CommonUtil.getDefaultDept());
                CSRelation.setCreateTime(CommonUtil.getDate());
                studentService.addRelation(CSRelation);

                LoginUser loginUser = new LoginUser();
                String userAccount = student.getName();
/*
                String userAccount = null;
                userAccount = PinyinHelper.convertToPinyinString(student.getName(), "", PinyinFormat
                        .WITHOUT_TONE);
*/
                userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setName(student.getName());
                loginUser.setUserAccount(student.getIdcard());
                loginUser.setPersonId(student.getStudentId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("1");
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setDefaultDeptId(classId);
                loginUserService.saveUser(loginUser);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";

            return new Message(0, msg, null);
        }

        return new Message(1, "共计" + count + "条，导入成功！", "success");
    }

    public boolean isNumeric(String str) {
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(str);
        if (!isNum.matches()) {
            return false;
        }
        return true;
    }

    @ResponseBody
    @RequestMapping("/student/importStudent")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file,
                                 @RequestParam("classId") String classId) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Map<String, String> zzmm = commonService.getSysDicMap("ZZMM");
        Map<String, String> xb = commonService.getSysDicMap("XB");
        Map<String, String> mz = commonService.getSysDicMap("MZ");
        Map<String, String> xz = commonService.getSysDicMap("XZ");
        Map<String, String> cc = commonService.getSysDicMap("CC");
        Map<String, String> xxxs = commonService.getSysDicMap("XXXS");
        ClassBean classBean1 = new ClassBean();
        classBean1.setTrainingLevel("1,3");
        List<ClassBean> classList = classService.getClassList(classBean1);
        int count = 0;
        int tmp = 2;
        String fileName = "";
        HSSFWorkbook wb = studentService.getStudentExcelTemplate("1");
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setDataFormat(workbook.createDataFormat().getFormat("@"));
        int end = sheet.getLastRowNum();
        for (int i = 1; i <= end - 1; i++) {
            boolean b = true;
            HSSFRow row = sheet.getRow(i + 1);
            if (null == row && count == 0) {
                return new Message(0, "无数据，导入失败！", "error");
            }
            Student student = new Student();
            student.setStudentStatus("1");
            if (row.getCell(0) != null) {
                row.getCell(0).setCellStyle(cellStyle);
                row.getCell(0).setCellType(CellType.STRING);
                String candidateNumber = row.getCell(0).toString();
                if (isNumeric(candidateNumber)) {
                    Student stu = studentService.getStudentByCandidateNumber(candidateNumber);
                    if (stu == null) {
                        student.setCandidateNumberDz(candidateNumber);
                    } else {
                        b = false;
                    }
                } else {
                    b = false;
                }
            } else {
                b = false;
            }

            if (row.getCell(1) != null) {
                row.getCell(1).setCellStyle(cellStyle);
                row.getCell(1).setCellType(CellType.STRING);
                String studentNumber = row.getCell(1).toString();
                if (isNumeric(studentNumber)) {
                    Student stu = studentService.getStudentByStudentNumber(studentNumber);
                    if (stu == null) {
                        student.setStudentNumber(studentNumber);
                    } else {
                        b = false;
                    }
                } else {
                    b = false;
                }
            } else {
                b = false;
            }

            if (row.getCell(2) == null) {
                b = false;
            } else {
                row.getCell(2).setCellStyle(cellStyle);
                row.getCell(2).setCellType(CellType.STRING);
                String name = row.getCell(2).toString();
                student.setName(name);
            }

            if (row.getCell(3) == null) {
                b = false;
            } else {
                row.getCell(3).setCellStyle(cellStyle);
                row.getCell(3).setCellType(CellType.STRING);
                String sex = row.getCell(3).toString();
                student.setSex(xb.get(sex));
            }

            if (row.getCell(4) == null) {
                b = false;
            } else {
                row.getCell(4).setCellStyle(cellStyle);
                row.getCell(4).setCellType(CellType.STRING);
                String birthday = row.getCell(4).toString();
                try {
                    student.setBirthday(new Date(sdf.parse(birthday).getTime()));
                } catch (ParseException e) {
                    e.printStackTrace();
                    b = false;
                }
            }

            String idCard = "";
            if (row.getCell(5) == null) {
                b = false;
            } else {
                row.getCell(5).setCellStyle(cellStyle);
                row.getCell(5).setCellType(CellType.STRING);
                idCard = row.getCell(5).toString();
                if (idCard.length() == 18 || idCard.length() == 15) {
                    if (loginUserService.getLoginUserByLoginId(idCard) == null) {
                        student.setStudentId(idCard);
                        student.setIdcard(idCard);
                        student.setIdCardType("1");
                    } else {
                        b = false;
                    }
                } else {
                    b = false;
                }
            }

            if (row.getCell(6) == null) {
                b = false;
            } else {
                row.getCell(6).setCellStyle(cellStyle);
                row.getCell(6).setCellType(CellType.STRING);
                String politicalStatus = row.getCell(6).toString();
                student.setPoliticalStatus(zzmm.get(politicalStatus));
            }

            if (row.getCell(7) == null) {
                b = false;
            } else {
                row.getCell(7).setCellStyle(cellStyle);
                row.getCell(7).setCellType(CellType.STRING);
                String nation = row.getCell(7).toString();
                student.setNation(mz.get(nation));
            }

            if (row.getCell(9) == null) {
                b = false;
            }
            if (row.getCell(10) == null) {
                b = false;
            }
            if (row.getCell(11) == null) {
                b = false;
            } else {
                row.getCell(11).setCellStyle(cellStyle);
                row.getCell(11).setCellType(CellType.STRING);
                String eductionalSystem = row.getCell(11).toString();
                student.setEductionalSystem(xz.get(eductionalSystem));
            }

            if (row.getCell(12) != null) {
                row.getCell(12).setCellStyle(cellStyle);
                row.getCell(12).setCellType(CellType.STRING);
                student.setLearnMode(xxxs.get(row.getCell(12).toString()));
            }
            if (row.getCell(13) != null) {
                row.getCell(13).setCellStyle(cellStyle);
                row.getCell(13).setCellType(CellType.STRING);
                student.setTotalPoints(row.getCell(13).toString());
            }
            String className = "";
            String classIds = "";
            if (row.getCell(14) == null) {
                b = false;
            } else {
                row.getCell(14).setCellStyle(cellStyle);
                row.getCell(14).setCellType(CellType.STRING);
                className = row.getCell(14).toString();
                classIds = studentService.getClassIdByClassName(className);
                b = true;
//                student.setClassId(classIds);
//                for (ClassBean classBean : classList) {
//                    if (className.equals(classBean.getClassName())) {
//                        classIda = classBean.getClassId();
//                        break;
//                    }
//                }
            }


            if (b) {
                student.setCreateDept(CommonUtil.getDefaultDept());
                student.setCreateTime(CommonUtil.getDate());
                student.setCreator(CommonUtil.getPersonId());
                student.setClassName(className);
                studentService.insertStudent(student);

                ClassStudentRelation CSRelation = new ClassStudentRelation();
                CSRelation.setId(CommonUtil.getUUID());
                CSRelation.setStudentId(student.getStudentId());
                CSRelation.setClassId(classIds);
                CSRelation.setCreator(CommonUtil.getPersonId());
                CSRelation.setCreateDept(CommonUtil.getDefaultDept());
                CSRelation.setCreateTime(CommonUtil.getDate());
                studentService.addRelation(CSRelation);

                LoginUser loginUser = new LoginUser();
                String userAccount = student.getName();
                userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setName(student.getName());
                loginUser.setUserAccount(student.getIdcard());
                loginUser.setPersonId(student.getStudentId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("1");
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setDefaultDeptId(classId);
                loginUserService.saveUser(loginUser);
                count++;
            } else {
                HSSFCellStyle textStyle = wb.createCellStyle();
                textStyle.setBorderLeft(BorderStyle.THIN);//左边框
                textStyle.setBorderTop(BorderStyle.THIN);//上边框
                textStyle.setBorderRight(BorderStyle.THIN);//右边框
                textStyle.setBorderBottom(BorderStyle.THIN); //下边框
                textStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
                textStyle.setDataFormat(wb.createDataFormat().getFormat("@"));
                HSSFRow row1 = wb.getSheetAt(0).createRow(tmp);
                for (int j = 0; j < 15; j++) {
                    if (row.getCell(j) != null) {
                        row1.createCell(j).setCellValue(row.getCell(j).toString());
                        row1.getCell(j).setCellStyle(textStyle);
                    }
                }
                tmp++;
            }
        }
//        SimpleDateFormat ddd = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
//        fileName = "/tmp/错误数据_" + ddd.format(System.currentTimeMillis()) + ".xls";
//        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent();
//        FileOutputStream outputStream = null;
//        try {
//            outputStream = new FileOutputStream(rootPath + fileName);
//        } catch (FileNotFoundException e) {
//            e.printStackTrace();
//        }
//        try {
//            wb.write(outputStream);
//            outputStream.close();
//            wb.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        if (tmp > 2) {
//            return new Message(2, "共导入" + count + "条", fileName);
//        }

        return new Message(1, "共导入" + count + "条", "success");
    }

    @RequestMapping("/student/toImportStudent")
    public ModelAndView toImportStudent(String classId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/imStudent");
        mv.addObject("classId", classId);
        return mv;
    }

    @RequestMapping("/student/toImportStudent1")
    public ModelAndView toImportStudent1(String classId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/imStudent1");
        mv.addObject("classId", classId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/getStudentTree")
    public List<Tree> getDeptAndPersonTree(String roleId) {
        List<Tree> trees = studentService.getStudentTree(roleId);
        return trees;
    }

    @RequestMapping("/student/toEditStudentBySelf")
    public ModelAndView toEditStudentBySelf() {
        LoginUser a = CommonUtil.getLoginUser();
        String studentId = a.getPersonId();
        Student student = studentService.getStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "学生修改");
        mv.addObject("student", student);
        mv.setViewName("/core/xg/student/editStudentBySelf");
        return mv;
    }

    @RequestMapping("/student/toChangeClass")
    public ModelAndView toChangeDept() {
        ModelAndView mv = new ModelAndView("/core/xg/student/changeClassBySelf");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/student/getLoginStudent")
    public Student getLoginEmp() {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String classid = loginUser.getDefaultDeptId();
        ClassBean classBean = classService.getClassByClassid(classid);
        String name = classBean.getDepartmentsIdShow()
                + "&nbsp;<span class=\"icon-arrow-right\"></span>&nbsp;"
                + classBean.getMajorCodeShow()
                + "&nbsp;<span class=\"icon-arrow-right\"></span>&nbsp;"
                + classBean.getClassName();
        Student student = new Student();
        student.setName(loginUser.getName());
        student.setClassShow(name);
        return student;
    }

    @ResponseBody
    @RequestMapping("/student/getStudentByStudentId")
    public Map getStudentByStudentId(String studentId) {
        Student student = studentService.getStudentById(studentId);
        Map studentList = new HashMap();
        studentList.put("sex", student.getSex());
        studentList.put("idcard", student.getIdcard());
        return studentList;
    }

    @RequestMapping("/core/student/toGrowthArchives")
    public ModelAndView toGrowthArchives() {
        String studentId = CommonUtil.getLoginUser().getPersonId();
        String studentName = CommonUtil.getLoginUser().getName();
        Student student = studentService.getStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        //学生信息
        mv.addObject("studentName", studentName);
        mv.addObject("student", student);
        //个人缴费记录
        PaymentResult paymentResult = new PaymentResult();
        paymentResult.setStudentId(studentId);
        List<PaymentResult> paymentResults = paymentService.getPersonalPaymentList(paymentResult);
        mv.addObject("paymentResults", CommonUtil.jsonUtil(paymentResults));
        //学生奖惩查看
        StudentPunish studentPunish = new StudentPunish();
        studentPunish.setStudentId(studentName);
        List<StudentPunish> studentPunishes = studentRewardPunishService.getRewardPunishCountList(studentPunish);
        mv.addObject("studentPunishes", CommonUtil.jsonUtil(studentPunishes));
        mv.setViewName("/core/xg/student/growthArchives");
        return mv;
    }

    //学籍统计
    @RequestMapping("/core/student/studentStatistics")
    public ModelAndView studentStatistics() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/student/studentStatisticsList");
        return mv;
    }

    //学籍统计
    @ResponseBody
    @RequestMapping("/core/student/getStudentStatisticsList")
    public Map<String, Object> getStudentStatisticsList(Student student, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> logList = new HashMap<>();
        List<Student> r = studentService.getStudentStatisticsList(student);
        r.get(0).setDepartmentsId(student.getDepartmentShow());
        r.get(0).setMajorCode(student.getMajorShow());
        r.get(0).setSex(student.getSexShow());
        r.get(0).setTrainingLevel(student.getTrainingLevelShow());
        r.get(0).setNation(student.getNationShow());
        r.get(0).setPoliticalStatus(student.getPoliticalStatusShow());
        PageInfo<List<Student>> info = new PageInfo(r);
        logList.put("draw", draw);
        logList.put("recordsTotal", info.getTotal());
        logList.put("recordsFiltered", info.getTotal());
        logList.put("data", r);
        return logList;
    }

    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }

    /**
     * 设置单元格上提示
     *
     * @param sheet         要设置的sheet.
     * @param promptTitle   标题
     * @param promptContent 内容
     * @param firstRow      开始行
     * @param endRow        结束行
     * @param firstCol      开始列
     * @param endCol        结束列
     * @return 设置好的sheet.
     */
    public static void setHSSFPrompt(HSSFSheet sheet, String promptTitle, String promptContent, int firstRow, int endRow, int firstCol, int endCol) {
        // 构造constraint对象
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1");
        // 四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        hssfDataValidation.createPromptBox(promptTitle, promptContent);
        sheet.addValidationData(hssfDataValidation);
    }


    @ResponseBody
    @RequestMapping("/student/getStudentNumByClassId")
    public String getStudentNumByClassId(String classId){
        return studentService.getStudentNumByClassId(classId);
    }


    @ResponseBody
    @RequestMapping("/student/getStudentByIdcard")
    public Student getStudentByIdcard(String idcard){
        return studentService.getStudentByIdcard(idcard);
    }
}
