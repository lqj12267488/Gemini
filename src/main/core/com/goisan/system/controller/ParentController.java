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
import com.goisan.studentwork.studentprove.service.StudentProveService;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
    public void getParentTemplate(HttpServletResponse response) {
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
    }

    /**
     * 导入数据
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/core/parent/importParent")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Select2> gxList = commonService.getSysDict("XSJZGX","");
        List<Select2> zjlx1 = commonService.getUserDict("JZZJLX");
        List<Select2> zjlx2 = commonService.getUserDict("JZZJLX");
        int count = 0 ;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if(null == row && count == 0){
                    return new Message(0, "无数据，导入失败！", "error");
                }else if(null == row || row.getLastCellNum() == 1){
                    return new Message(1, "共计"+count+"条，导入成功！", "success");
                }
                Parent parent = new Parent();
                parent.setStudentId(row.getCell(0).toString());
                parent.setParentName(row.getCell(1).toString());
                for (Select2 IdCardType : zjlx1) {
                    if (IdCardType.getText().equals(row.getCell(2).toString())) {
                        parent.setIdCardType(IdCardType.getId());
                    }
                }
                parent.setIdcard(CommonUtil.toIdcardCheck(row.getCell(3).toString()));
                parent.setParentTel(row.getCell(4).toString());
                parent.setParentNameSecond(row.getCell(5).toString());
                for (Select2 IdCardTypeSecond : zjlx2) {
                    if (IdCardTypeSecond.getText().equals(row.getCell(6).toString())) {
                        parent.setIdCardTypeSecond(IdCardTypeSecond.getId());
                    }
                }
                parent.setIdcardSecond(CommonUtil.toIdcardCheck(row.getCell(7).toString()));
                parent.setParentTelSecond(row.getCell(8).toString());
                /*parent.setIdcard(CommonUtil.toIdcardCheck(row.getCell(1).toString()));
                parent.setParentId(CommonUtil.toIdcardCheck(row.getCell(1).toString()));
                parent.setParentTel(row.getCell(2).toString());*/

                String check = parentService.checkParentIdcard(parent.getIdcard());
                if(check.equals("0")){
                    CommonUtil.save(parent);
                    parentService.saveParent(parent);

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
                    if(row.getLastCellNum()>=5) {
                        loginUser.setDefaultDeptId(CommonUtil.toIdcardCheck(row.getCell(4).toString()));
                    }
                    loginUserService.saveUser(loginUser);

                  /*  if(row.getLastCellNum()>=5){
                        String studentId =CommonUtil.toIdcardCheck( row.getCell(4).toString() );
                        String rygx = row.getCell(3).toString();
                        List<BaseBean> chechStudent = studentParentRelationService.checkStudentRelation(studentId);
                        if( null == chechStudent || chechStudent.size() == 0 ){
                            StudentParentRelation relation = new StudentParentRelation();
                            for (Select2 gx : gxList) {
                                if (gx.getText().equals(rygx)) {
                                    relation.setRelation(gx.getId());
                                }
                            }
                            relation.setStudentId(studentId);
                            relation.setParentId(parent.getParentId());
                            relation.setId(CommonUtil.getUUID());
                            studentParentRelationService.saveStudentParentRelation(relation);
                        }else{
                            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据"+parent.getParentName()+"异常，" +
                                    "此条数据的学生已经添加了家长。导入失败！" ;
                            return new Message(0, msg, "error");
                        }
                    }*/

                    count++;
                }else{
                    String msg = "导入"+count+"条成功，第"+(count+1)+"条数据"+parent.getParentName()+"异常," +
                            "此条数据的身份证号已存在。导入失败！" ;
                    count = end+1;
                    return new Message(0, msg, "error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！" ;
            return new Message(0, msg, "error");
        }
        return new Message(1, "共计"+count+"条，导入成功！", "success");
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

}
