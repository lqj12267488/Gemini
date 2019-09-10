package com.goisan.system.controller;

import com.goisan.educational.arrayclass.bean.ArrayClass;
import com.goisan.educational.arrayclass.bean.ArrayClassStudent;
import com.goisan.educational.arrayclass.bean.ArrayClassTime;
import com.goisan.educational.arrayclass.bean.StudentArrayClassLook;
import com.goisan.educational.arrayclass.service.ArrayClassResultClassService;
import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreImportService;
import com.goisan.educational.teachingresult.bean.TeachingResultProject;
import com.goisan.educational.teachingresult.service.TeacherResultService;
import com.goisan.evaluation.bean.EvaluationEmp;
import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.logistics.assets.service.AssetsService;
import com.goisan.studentwork.studentprove.service.StudentProveService;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.goisan.logistics.assets.controller.AssetsController.setHSSFPrompt;
import static com.goisan.logistics.assets.controller.AssetsController.setHSSFValidation;

@Controller
public class ParentController {

    @Resource
    private ParentService parentService;
    @Resource
    private StudentParentRelationService studentParentRelationService;
    @Resource
    private CommonService commonService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private ArrayClassResultClassService arrayClassResultClassService;
    @Resource
    private ArrayClassService arrayClassService;
    @Resource
    private ScoreImportService scoreImportService;
    @Resource
    private StudentService studentService;
    @Resource
    public EvaluationService evaluationService;
    @Resource
    private TeacherResultService teacherResultService;
    @Resource
    private ClassCadreService classCadreService;
    @Resource
    private StudentProveService studentProveService;

    @Resource
    private AssetsService assetsService;

    @RequestMapping("/core/parent/toParentList")
    public String toList() {
        return "/core/xg/parent/parentList";
    }

    @ResponseBody
    @RequestMapping("/core/parent/getParentList")
    public Map getList(Parent parent) {
        return CommonUtil.tableMap(parentService.getParentList(parent));
    }

    @RequestMapping("/core/parent/toParentAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/core/xg/parent/parentAdd";
    }

    @ResponseBody
    @RequestMapping("/core/parent/getStudentByStudentId")
    public Map getStudentByStudentNumber(String studentId) {
        Student student = studentProveService.getStudentByStudentId(studentId);
        Map studentList = new HashMap();
        if(null == student){
            studentList.put("householdRegisterPlace","");
            studentList.put("studentName","");
        }else{
            studentList.put("householdRegisterPlace",student.getHouseholdRegisterPlace());
            studentList.put("studentName",student.getName());
        }
        return studentList;
    }
    @ResponseBody
    @RequestMapping("/core/parent/saveParent")
    public Message save(Parent parent,String studentId,String relationVal) {
        if (null == parent.getParentId() || "".equals(parent.getParentId()) || "null".equals(parent.getParentId())) {
            String parentIdCard = CommonUtil.toIdcardCheck( parent.getIdcard() );
            studentId = CommonUtil.toIdcardCheck( studentId );

            parent.setIdcard(parentIdCard);
            String count = parentService.checkParentIdcard(parentIdCard);
            List<BaseBean> chechStudent = studentParentRelationService.checkStudentRelation(studentId);
            if( null != chechStudent  && chechStudent.size() > 0 ){
                return new Message(0, "此学生已添加家长！", "error");
            }
            if(count.equals("0")){
                parent.setParentId(parentIdCard);
                CommonUtil.save(parent);
                parentService.saveParent(parent);

                StudentParentRelation relation = new StudentParentRelation();
                relation.setRelation(relationVal);
                relation.setStudentId(studentId);
                relation.setParentId(parentIdCard);
                relation.setId(CommonUtil.getUUID());
                studentParentRelationService.saveStudentParentRelation(relation);

                LoginUser loginUser = new LoginUser();
//                    String userAccount = parent.getParentName();
//                    userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setName(parent.getParentName());
                loginUser.setUserAccount(parent.getIdcard());
                loginUser.setPersonId(parent.getIdcard());
                loginUser.setPassword((new SimpleHash("MD5", "123456",
                        null, 1).toString()));
                loginUser.setUserType("2");
                CommonUtil.save(loginUser);
                loginUser.setDefaultDeptId(studentId);
                loginUserService.saveUser(loginUser);

                return new Message(1, "添加成功！", "success");
            }else{
                return new Message(0, "此家长身份证号信息已存在,新增失败", "error");
            }
        } else {
            CommonUtil.update(parent);
            parentService.updateParent(parent);
            parentService.updateStudentId(parent);
            return new Message(1, "修改成功！", "success");
        }

    }

    @RequestMapping("/core/parent/toParentEdit")
    public String toEdit(String id, String ifIndex, Model model) {
        if(null == id || id.equals(""))
            id = CommonUtil.getPersonId();
        model.addAttribute("data", parentService.getParentById(id));
        model.addAttribute("head", "修改");
        model.addAttribute("ifIndex", ifIndex);
        return "/core/xg/parent/parentEdit";
    }

    @RequestMapping("/core/parent/toParentBySelf")
    public String toParentBySelf(Model model) {
        String id = CommonUtil.getPersonId();
        model.addAttribute("data", parentService.getParentById(id));
        return "/core/xg/parent/parentBySelf";
    }

    @ResponseBody
    @RequestMapping("/core/parent/delParent")
    public Message del(String id) {
        loginUserService.deleteUser(id);
        parentService.delParent(id);
        studentParentRelationService.delRelationByParentid(id);
        studentParentRelationService.delRoleByParentid(id);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 导入导出
     */
    @RequestMapping("/core/parent/toOpenImportDialog")
    public ModelAndView toImportDialog() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/impParent");
        return mv;
    }

    /**
     * 导出模板
     * @param response
     */
    @RequestMapping("/core/parent/getParentTemplate")
   /* public void getParentTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20"," ");
        String fileName = rootPath + "/template/parentTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("高等教育学生父母或监护人信息录取表.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }*/

    public void getAssetsExcelTemplate(HttpServletResponse response) {
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("高等教育学生父母或监护人信息录取表模板");
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnWidth(25);
        sheet.createRow(0).createCell(0).setCellStyle(headStyle);
        //sheet.getRow(0).getCell(0).setCellValue("");
        sheet.getRow(0).getCell(0).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(1).setCellStyle(headStyle);
        sheet.getRow(0).getCell(1).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(2).setCellStyle(headStyle);
        sheet.getRow(0).getCell(2).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(3).setCellStyle(headStyle);
        sheet.getRow(0).getCell(3).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(4).setCellStyle(headStyle);
        sheet.getRow(0).getCell(4).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(5).setCellStyle(headStyle);
        sheet.getRow(0).getCell(5).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(6).setCellStyle(headStyle);
        sheet.getRow(0).getCell(6).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(7).setCellStyle(headStyle);
        sheet.getRow(0).getCell(7).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(8).setCellStyle(headStyle);
        sheet.getRow(0).getCell(8).setCellValue("说明：此项为必填项");

        sheet.createRow(1).createCell(0).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(0).setCellValue("学生身份证件号码");
        sheet.getRow(1).createCell(1).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(1).setCellValue("父母或监护人1姓名");
        sheet.getRow(1).createCell(2).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(2).setCellValue("父母或监护人1身份证件类型");
        sheet.getRow(1).createCell(3).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(3).setCellValue("父母或监护人1身份证件号码");
        sheet.getRow(1).createCell(4).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(4).setCellValue("父母或监护人1联系方式");
        sheet.getRow(1).createCell(5).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(5).setCellValue("父母或监护人2姓名");
        sheet.getRow(1).createCell(6).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(6).setCellValue("父母或监护人2身份证件类型");
        sheet.getRow(1).createCell(7).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(7).setCellValue("父母或监护人2身份证件号码");
        sheet.getRow(1).createCell(8).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(8).setCellValue("父母或监护人2联系方式");
        HSSFCellStyle textS = wb.createCellStyle();
        HSSFDataFormat form = wb.createDataFormat();
        textS.setDataFormat(form.getFormat("@"));
        for (int i = 2; i < 10000; i++) {
            HSSFRow row = sheet.createRow(i);
            for (int j = 0; j <9; j++) {
                row.createCell(j).setCellStyle(textS);
            }
        }
        setHSSFPrompt(sheet, "", "", 1, 65535, 0, 0);
        setHSSFPrompt(sheet, "", "", 1, 65535, 1, 1);
        setHSSFPrompt(sheet, "", "", 1, 65535, 2, 2);
        setHSSFPrompt(sheet, "", "", 1, 65535, 3, 3);
        setHSSFPrompt(sheet, "", "", 1, 65535, 4, 4);
        setHSSFPrompt(sheet, "", "", 1, 65535, 5, 5);
        setHSSFPrompt(sheet, "", "", 1, 65535, 6, 6);
        setHSSFPrompt(sheet, "", "", 1, 65535, 7, 7);
        setHSSFPrompt(sheet, "", "", 1, 65535, 8, 8);
        List<Select2> list5 = assetsService.getUserDictName("JZZJLX");
        String[] major = new String[list5.size()];
        for (int i = 0; i < list5.size(); i++) {
            major[i] = list5.get(i).getText();
        }
        setHSSFValidation(sheet, major, 2, 65535, 2, 2);
        setHSSFValidation(sheet, major, 2, 65535, 6, 6);
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("高等教育学生父母或监护人信息录取表模板.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                    wb.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }

    /**
     * 导入数据
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/core/parent/importParent")
    public Message importEmp(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        List<Select2> List1 = commonService.getUserDict("JZZJLX");
        /*TableDict tableDict = new TableDict();
        tableDict.setId("DEPT_ID");
        tableDict.setText("DEPT_NAME");
        tableDict.setTableName("T_SYS_DEPT");
        tableDict.setWhere("  WHERE VALID_FLAG='1' ");
        List<Select2> bz = commonService.getTableDict(tableDict);*/

        List<Parent> parentList = new ArrayList<Parent>();
        int count = 0;
        int num = 0;
        Object str;
        String msg = "第";
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
            ++num;
        }
        if (num > 0) {
            return new Message(1, "导入失败！请重新导入", null);
        } else {
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = getRealLastRowNum(workbook);
            for (int i = 2; i < end; i++) {
                HSSFRow row = sheet.getRow(i);
                int flag = 1;
                Parent parent = new Parent();
                parent.setParentId(CommonUtil.changeToString(row.getCell(3)));
                //assets.setAssetsId(CommonUtil.changeToString(row.getCell(1)));
               /* for (Select2  ParentType: List1) {
                    if (ParentType.getText().equals(row.getCell(0).toString())) {
                        parent.setIdCardType(ParentType.getId());
                    }
                }*/
                parent.setStudentId(CommonUtil.changeToString(row.getCell(0)));
                parent.setParentName(CommonUtil.changeToString(row.getCell(1)));
                for (Select2  ParentType: List1) {
                    if (ParentType.getText().equals(row.getCell(2).toString())) {
                        parent.setIdCardType(ParentType.getId());
                    }
                }

                parent.setIdcard(CommonUtil.changeToString(row.getCell(3)));
                parent.setParentTel(CommonUtil.changeToString(row.getCell(4)));
                parent.setParentNameSecond(CommonUtil.changeToString(row.getCell(5)));
                for (Select2  ParentType: List1) {
                    if (ParentType.getText().equals(row.getCell(6).toString())) {
                        parent.setIdCardTypeSecond(ParentType.getId());
                    }
                }
                parent.setIdcardSecond(CommonUtil.changeToString(row.getCell(7)));
                parent.setParentTelSecond(CommonUtil.changeToString(row.getCell(8)));
                Student student = studentProveService.getStudentByStudentId(parent.getStudentId());
                if (null == student){
                    return new Message(0, "此学生不存在", null);
                }
                List<BaseBean> chechStudent = studentParentRelationService.checkStudentRelation(parent.getStudentId());
                if( null != chechStudent  && chechStudent.size() > 0 ){
                    return new Message(0, "此学生已添加家长！", "error");
                }
                parentService.saveParent(parent);
                StudentParentRelation relation = new StudentParentRelation();
                relation.setRelation("");
                relation.setStudentId(parent.getStudentId());
                relation.setParentId(parent.getIdcard());
                relation.setId(CommonUtil.getUUID());
                studentParentRelationService.saveStudentParentRelation(relation);

                LoginUser loginUser = new LoginUser();
//                    String userAccount = parent.getParentName();
//                    userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setName(parent.getParentName());
                loginUser.setUserAccount(parent.getIdcard());
                loginUser.setPersonId(parent.getIdcard());
                loginUser.setPassword((new SimpleHash("MD5", "123456",
                        null, 1).toString()));
                loginUser.setUserType("2");
                CommonUtil.save(loginUser);
                loginUser.setDefaultDeptId(parent.getStudentId());
                loginUserService.saveUser(loginUser);

                if (flag == 0) {
                    msg += i + ",";
                    count++;
                }

            }
            if (count > 0) {
                msg = msg.substring(0, msg.length() - 1) + "行,人员身份信息不正确！请重新导入！";
            } else {
                msg = "导入成功！";
            }
            return new Message(1, msg, null);
        }
    }

    /**
     * 获取真实行数
     * @param workbook 工作簿对象
     * @return 真实行数
     */
    private int getRealLastRowNum(Workbook workbook) {
        Sheet sheetAt = workbook.getSheetAt(0);
        int lastRowNum = sheetAt.getLastRowNum();

        Row row = sheetAt.getRow(0);
        int realLastRowNum = 0;
        error:
        for (int i = 0; i < lastRowNum; i++) {
            StringBuilder str = new StringBuilder();
            for (int j = 0; j < sheetAt.getRow(0).getPhysicalNumberOfCells(); j++) {
                Cell cell = sheetAt.getRow(i).getCell(j);
                try {
                    cell.setCellType(CellType.STRING);
                    str.append(cell.getStringCellValue());
                }
                catch (Exception e)
                {
                    break error;
                }

            }
            if (!"".equals(str.toString().replaceAll(" ", "")))
            {
                realLastRowNum = realLastRowNum + 1;
            }
        }
        System.err.println("----------------------> 真实行数 "+realLastRowNum);
        return realLastRowNum;

    }
    /**
     * 导入导出
     */

    /**
     * 权限
     */
    @ResponseBody
    @RequestMapping("/core/parent/getParentTree")
    public List<Tree> getDeptAndPersonTree(String roleId) {
        List<Tree> trees = parentService.getParsonStudentTree(roleId);
        return trees;
    }

    /**
     * 切换 关联学生
     */
    @RequestMapping("/core/parent/toChangeStudent")
    public ModelAndView toChangeStudent() {
        ModelAndView mv = new ModelAndView("/core/xg/parent/changeStudentBySelf");
        return mv;
    }

    /**
     * 家长 查看 学生个人课表菜单
     * @return
     */
    @RequestMapping("/core/parent/toStudentScheduleList")
    public ModelAndView lookPersonal(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/children/ScheduleList");
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/core/parent/getArrayClassList")
    public Map<String, List<ArrayClass>> getArrayClassList(ArrayClass arrayClass) {
        Map<String, List<ArrayClass>> resultMap = new HashMap<String, List<ArrayClass>>();
        resultMap.put("data", arrayClassService.getArrayClassList(arrayClass));
        return resultMap;
    }

    /**
     * 查看学生课表跳转
     */
    @RequestMapping("/core/parent/lookStudentViewCourse")
    public ModelAndView lookStudentViewCourse(ArrayClassStudent arrayClassStudent, String arrayClassName) {
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        arrayClassStudent.setStudentId( studentId );
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/children/ScheduleListView");

        // 本学生已排课  T_JW_ARRAYCLASS_RESULT_STUDENT
        List<StudentArrayClassLook> studentArrayClassLooks = arrayClassResultClassService.getArrayClassStudentClassByStudent(arrayClassStudent);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(studentArrayClassLooks));

        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByStudent(arrayClassStudent);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);
        TableDict tableDict = new TableDict();
        tableDict.setId("class_id");
        tableDict.setText("class_name");
        tableDict.setTableName(" T_XG_CLASS ");
        tableDict.setWhere(" where class_id in(select class_id from T_XG_STUDENT_CLASS where student_id ='"+studentId+"') ");
        List<Select2> className = commonService.getTableDict(tableDict);
        mv.addObject("className",className);

        mv.addObject("arrayclassId",arrayClassStudent.getArrayclassId());
        mv.addObject("studentId",arrayClassStudent.getStudentId());
        mv.addObject("studentName",arrayClassStudent.getStudentName());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    /**
     * 家长 查看 学生个人课表菜单
     * @return
     */
    @RequestMapping("/core/parent/toStudentScoreListResult")
    public ModelAndView toStudentScoreListResult(){
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/score/scoreStudentResult");

        // 班级列表
        TableDict tableDict = new TableDict();
        tableDict.setId("class_id");
        tableDict.setText("class_name");
        tableDict.setTableName(" T_XG_CLASS ");
        tableDict.setWhere(" where class_id in(select class_id from T_XG_STUDENT_CLASS where student_id ='"+studentId+"') ");
        List<Select2> className = commonService.getTableDict(tableDict);
        mv.addObject("className",className);
        mv.addObject("classNum",className.size());
        if(null !=className && className.size()!=0)
            mv.addObject("classCheck",className.get(0).getId());

        ScoreImport scoreImports = new ScoreImport();
        scoreImports.setStudentId(studentId);
        // 學生成績
        List<ScoreImport> coreImports = scoreImportService.getScoreListByStudentId(scoreImports);
        mv.addObject("courseList", CommonUtil.jsonUtil(coreImports));

        // 班級信息
        List<Map> map = parentService.getScoreExamCourseList(studentId , className);
        mv.addObject("classScoreExam",map);
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/core/parent/getClassList11111")
    public Map getArrayClassList(String classId) {
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        Map resultMap = new HashMap();
        // 课程列表(适用于基教)
        TableDict tableDict = new TableDict();
        tableDict.setId(" c.course_id ");
        tableDict.setText(" distinct c.COURSE_NAME ");
        tableDict.setTableName(" t_jw_score_import i, t_jw_course c, t_jw_score_exam e ");
        tableDict.setWhere(" where c.course_id = i.course_id and " +
                "i.score_exam_id = e.score_exam_id  and i.class_id = '"+classId+"' ");
        List<Select2> courseName = commonService.getTableDict(tableDict);
        resultMap.put("courseName",courseName);

        return resultMap;
    }

    /**
     * 家长 查看 各任课教师信息
     * @return
     */
    @RequestMapping("/core/parent/toTeacherList")
    public ModelAndView toTeacherList(){
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        Student stu = studentService.getStudentNameByStudentId(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("studentName",stu.getName());
        mv.addObject("studentId",studentId);
        mv.setViewName("/core/xg/parent/teacher/teacherList");
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/core/parent/getTeacherList")
    public Map getTeacherList() {
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        Map resultMap = new HashMap();

        TableDict tableDict = new TableDict();
        tableDict.setId("class_id");
        tableDict.setText("class_name");
        tableDict.setTableName(" T_XG_CLASS ");
        tableDict.setWhere(" where class_id in(select class_id from T_XG_STUDENT_CLASS where student_id ='"+studentId+"') ");
        List<Select2> className = commonService.getTableDict(tableDict);

        List id = new ArrayList();
        for (int i = 0 ;i < className.size() ; i++) {
            id.add(className.get(i).getId());
        }
        List list =  parentService.getCourseTeacherList(id);
        resultMap.put("data",list);
        return resultMap;
    }

    /**
     * 家长 查看 各任课教师信息
     * @return
     */
    @RequestMapping("/core/parent/toTeachingResult")
    public ModelAndView toTeachingResult(String teacherId , String teacherName){
        ModelAndView mv = new ModelAndView();
        mv.addObject("teacherName",teacherName);
        mv.addObject("teacherId",teacherId);

        // 教师教授班级
        List courseList = parentService.getCourseListByTeacher(teacherId);
        mv.addObject("courseList",CommonUtil.jsonUtil(courseList));

        // 教师校验成果列表
        TeachingResultProject teachingResultProject = new TeachingResultProject();
        teachingResultProject.setPersonId(teacherId);
//        teachingResultProject.setPersonId("2411b600-d401-4912-8d7e-b6bf658eaf05");
        List teachingResultList= teacherResultService.getCountList(teachingResultProject);
        mv.addObject("teachingResultList",CommonUtil.jsonUtil(teachingResultList));

        // 教师评教 查看
        EvaluationTask task = new EvaluationTask();
        task.setEvaluationType("0");
        task.setCreator(teacherId);
//        task.setCreator("13a86cd0-bbb6-4794-8b07-f0d766dd4ebe");
        List evaluationlist = evaluationService.getMonitoerTaskByTeacherId(task);
        mv.addObject("evaluationList",CommonUtil.jsonUtil(evaluationlist));

        mv.addObject("teacherId",teacherId);
        mv.setViewName("/core/xg/parent/teacher/teachingResult");
        return mv;
    }

    @RequestMapping("/core/parent/resultEmps")
    public ModelAndView resultEmps(EvaluationTask task,String personId,String head) {
        ModelAndView mv = new ModelAndView();
        List<EvaluationEmp> list= evaluationService.getMonitoerEmpsByTaskId(task);
        List<EvaluationEmp> re = new ArrayList<EvaluationEmp>();
        for (EvaluationEmp sel : list) {
            if(sel.getPersonId().equals(personId)
//                    || sel.getPersonId().equals("210203199909050529")|| sel.getPersonId().equals("13a86cd0-bbb6-4794-8b07-f0d766dd4ebe")
                    ){//
                re.add(sel);
            }
        }
        mv.addObject("data",CommonUtil.jsonUtil( re));
        if(task.getEvaluationType().equals("0"))
            mv.addObject("title","被评人部门" );
        else if(task.getEvaluationType().equals("1"))
            mv.addObject("title","被评人班级" );
        mv.addObject("head", head);
        mv.setViewName("/core/xg/parent/teacher/resultEmps") ;
        return mv;
    }

    @RequestMapping("/core/parent/toClassCadreList")
    public ModelAndView toClassList() {
        ModelAndView mv = new ModelAndView();

        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        TableDict tableDict = new TableDict();
        tableDict.setId("class_id");
        tableDict.setText("class_name");
        tableDict.setTableName(" T_XG_CLASS ");
        tableDict.setWhere(" where class_id in(select class_id from T_XG_STUDENT_CLASS where student_id ='"+studentId+"') ");
        List<Select2> className = commonService.getTableDict(tableDict);

        mv.addObject("className",className);
        mv.addObject("classList",CommonUtil.jsonUtil(className));
        mv.addObject("classCheck",className.get(0).getId());
        mv.setViewName("/core/xg/parent/cadre/cadreList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/core/parent/getClassCadreList")
    public Map getList(ClassCadre classCadre) {
        Map<String, List> map = new HashMap<String, List>();
        map.put("data", classCadreService.getClassCadreList(classCadre));

        TableDict tableDict = new TableDict();
        tableDict.setId(" FUNC_GET_DICVALUE(sex, 'XB') ");
        tableDict.setText(" count(1) ");
        tableDict.setTableName(" t_xg_student t, t_xg_student_class s ");
        tableDict.setWhere(" where t.student_id = s.student_id and s.class_id = '"+classCadre.getClassId()+"' group by t.sex  order by sex ");
        List<Select2> sexSel = commonService.getTableDict(tableDict);
        int i = 0;
        for (Select2 sex : sexSel) {
            i = i+ Integer.parseInt(sex.getText());
        }
        Select2 all = new Select2();
        all.setId("班级总数");
        all.setText(i+"");
        sexSel.add(0,all);
        map.put("sexSel", sexSel);
        return map;
    }

    //缴费计划列表
    @RequestMapping("/core/parent/paymentResult")
    public ModelAndView toPaymentResult() {
        ModelAndView mv = new ModelAndView();
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
//        studentId = "220581199201171673";
        mv.addObject("studentId",studentId);
        mv.setViewName("/core/xg/parent/payment/paymentList");
        return mv;
    }

    //缴费结果列表
    @RequestMapping("/core/parent/toPaymentResult")
    public ModelAndView toSearchPaymentResult(String planId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("planId",planId);
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
//        studentId = "220581199201171673";
        mv.addObject("studentId",studentId);
        mv.setViewName("/core/xg/parent/payment/paymentResult");
        return mv;
    }

    //学生评教列表
    @RequestMapping("/core/parent/toevaluationList")
    public ModelAndView toSea1rchPaymentResult() {
        ModelAndView mv = new ModelAndView();
        String studentId =  CommonUtil.getLoginUser().getDefaultDeptId();
        mv.addObject("studentId",studentId);
        mv.setViewName("/core/xg/parent/children/studentResultList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/core/parent/getStudentTask")
    public Map getPaymentInfoStandardList(EvaluationTask task) {
//        task.setCreator("210203199909050529");
        return CommonUtil.tableMap( evaluationService.getMonitoerTaskByTeacherId(task) );
    }

    /**
     * 导出
     *
     * @param
     * @param response
     * @throws UnsupportedEncodingException
     */
    @ResponseBody
    @RequestMapping("/core/parent/exportParent")
    public void exportParent(HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Parent parent = new Parent();
        List<Parent> list = parentService.getParentStudentList(parent);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("高等教育学生父母或监护人信息录取表");

        CellStyle cellStyle0 = wb.createCellStyle();

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);

        int tmp = 0;
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("姓名（学生姓名）");
        row1.createCell(2).setCellValue("学生身份证件类型");
        row1.createCell(3).setCellValue("学生身份证件号码");
        row1.createCell(4).setCellValue("学生是否在职");
        row1.createCell(5).setCellValue("入学日期");
        row1.createCell(6).setCellValue("学籍状态");
        row1.createCell(7).setCellValue("父母或监护人1姓名");
        row1.createCell(8).setCellValue("父母或监护人1身份证件类型");
        row1.createCell(9).setCellValue("父母或监护人1身份证件号码");
        row1.createCell(10).setCellValue("父母或监护人1联系方式");
        row1.createCell(11).setCellValue("父母或监护人2姓名");
        row1.createCell(12).setCellValue("父母或监护人2身份证件类型");
        row1.createCell(13).setCellValue("父母或监护人2身份证件号码");
        row1.createCell(14).setCellValue("父母或监护人2联系方式");
        row1.createCell(15).setCellValue("班级");
        row1.createCell(16).setCellValue("学生户籍地址（与身份证上一致）");
        tmp++;
        int i = 1;
        for (Parent parent1 : list) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(parent1.getStudentName());
            row.createCell(2).setCellValue(parent1.getIdcardStudentType());
            row.createCell(3).setCellValue(parent1.getStudentId());
            row.createCell(4).setCellValue(parent1.getDuringEmploymentShow());
            row.createCell(5).setCellValue(parent1.getYear());
            row.createCell(6).setCellValue(parent1.getStudentStatusShow());
            row.createCell(7).setCellValue(parent1.getParentName());
            row.createCell(8).setCellValue(parent1.getIdCardTypeShow());
            row.createCell(9).setCellValue(parent1.getIdcard());
            row.createCell(10).setCellValue(parent1.getParentTel());
            row.createCell(11).setCellValue(parent1.getParentNameSecond());
            row.createCell(12).setCellValue(parent1.getIdCardTypeSecondShow());
            row.createCell(13).setCellValue(parent1.getIdcardSecond());
            row.createCell(14).setCellValue(parent1.getParentTelSecond());
            row.createCell(15).setCellValue(parent1.getClassName());
            row.createCell(16).setCellValue(parent1.getHouseholdRegisterPlace());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("高等教育学生父母或监护人信息录取表.xls", "utf-8"));
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
