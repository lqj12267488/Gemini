package com.goisan.educational.arrayclass.controller;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.arrayclass.service.ArrayClassResultClassService;
import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArrayClassResultClassController {
    @Resource
    private ArrayClassService arrayClassService;
    @Resource
    private ArrayClassResultClassService arrayClassResultClassService;
    @Resource
    private StudentService studentService;

    /**
     * 寒月 start
     * @return
     */

    /**
     * 学生课表查看首页
     * @return
     */
    @RequestMapping("/student/look")
    public ModelAndView  toStudentLook(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentArrayClassList");
        return mv;
    }
    /**
     * 生成学生课表
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/lookStudentArrayClass")
    public Message lookStudentTable(){
        List<StudentArrayClassLook> studentArrayClassLookList=arrayClassResultClassService.selectResultStudentList();
        if(studentArrayClassLookList.size()>0){
            arrayClassResultClassService.deleteStudentArrayClass();
            boolean flag=arrayClassResultClassService.insertStudent();
            if(flag==true){
                return new Message(1, "生成课表成功！", null);
            }else{
                return new Message(1, "生成课表失败！", null);
            }
        }else{
            boolean flag=arrayClassResultClassService.insertStudent();
            if(flag==true){
                return new Message(1, "生成课表成功！", null);
            }else{
                return new Message(1, "生成课表失败！", null);
            }
        }
    }

    /**
     * 生成学生课表跳转
     * @return
     */
    @RequestMapping("/arrayClassResultClass/studentView")
    public String studentView(String arrayClassName,Model model){
        model.addAttribute("arrayClassName",arrayClassName);
        return "/business/educational/arrayclass/resultClass/lookstudentarrayclass/studentCourseTable";

    }
    /**
     * 生成学生课表页显示
     * @param studentArrayClassLook
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/selectArrayClassResultStudentList")
    public Map selectArrayClassResultStudentList(StudentArrayClassLook studentArrayClassLook) {
        return CommonUtil.tableMap(arrayClassResultClassService.selectArrayClassResultStudentList(studentArrayClassLook));
    }

    /**
     * 生成课表查看详细
     * @param id
     * @return
     */
    @RequestMapping("/arrayClassResultClass/selectArrayClassResultStudentById")
    public ModelAndView selectStudentListById(String id){
        ModelAndView mv = new ModelAndView();
        StudentArrayClassLook studentArrayClassLook=arrayClassResultClassService.selectArrayClassResultStudentById(id);
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/addArrayClassResultStudent");
        mv.addObject("head", "查看详情");
        mv.addObject("studentArrayClassLook",studentArrayClassLook);
        return mv;
    }

    /**
     * 生成课表中的查看学生课表
     * @param arrayClassStudent
     * @param arrayClassName
     * @return
     */
    @RequestMapping("/arrayClassResultClass/lookStudentTableView")
    public ModelAndView lookStudentTableView(ArrayClassStudent arrayClassStudent,String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentTableView");

        // 本学生已排课  T_JW_ARRAYCLASS_RESULT_STUDENT
        List<StudentArrayClassLook> studentArrayClassLooks = arrayClassResultClassService.getArrayClassStudentClassByClass(arrayClassStudent);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(studentArrayClassLooks));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        /*ArrayClassClass arrayCalassClass = new ArrayClassClass ();
        arrayCalassClass.setArrayclassId(arrayClassStudent.getArrayclassId());*/
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByStudent(arrayClassStudent);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayClassStudent.getArrayclassId());
        mv.addObject("studentId",arrayClassStudent.getStudentId());
        mv.addObject("studentName",arrayClassStudent.getStudentName());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    /**
     * 查看学生列表跳转
     * @param arrayClassId
     * @param model
     * @return
     */
    @RequestMapping("/arrayClassResultClass/toSelectStudentList")
    public String toList(String arrayClassId,String arrayClassName,Model model) {
        model.addAttribute("arrayClassId", arrayClassId);
        model.addAttribute("arrayClassName",arrayClassName);
        return "/business/educational/arrayclass/resultClass/lookstudentarrayclass/studentTable";
    }
    /**
     * 查看学生课表跳转
     */
    @RequestMapping("/arrayClassResultClass/lookStudentViewCourse")
    public ModelAndView lookStudentViewCourse(ArrayClassStudent arrayClassStudent,String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentViewCourse");

        // 本学生已排课  T_JW_ARRAYCLASS_RESULT_STUDENT
        List<StudentArrayClassLook> studentArrayClassLooks = arrayClassResultClassService.getArrayClassStudentClassByClass(arrayClassStudent);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(studentArrayClassLooks));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        /*ArrayClassClass arrayCalassClass = new ArrayClassClass ();
        arrayCalassClass.setArrayclassId(arrayClassStudent.getArrayclassId());*/
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByStudent(arrayClassStudent);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayClassStudent.getArrayclassId());
        mv.addObject("studentId",arrayClassStudent.getStudentId());
        mv.addObject("studentName",arrayClassStudent.getStudentName());
        mv.addObject("studentNumber",arrayClassStudent.getStudentNumber());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    /**
     * 查看学生列表页显示
     * @param arrayClassClass
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getArrayClassStudentClassList")
    public Map getList(ArrayClassClass arrayClassClass) {
        return CommonUtil.tableMap(arrayClassResultClassService.getArrayClassStudentClassList(arrayClassClass));
    }
    /**
     * 查看个人课程表
     */
    @RequestMapping("/student/studentCourseTable")
    public ModelAndView lookStudentCourse(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/studentCourseTable");
        return mv;
    }
    /**
     * 个人课表查看菜单跳转
     * @return
     */
    @RequestMapping("/student/personal")
    public ModelAndView lookPersonal(){
        String studentId= CommonUtil.getPersonId();
        Student student = studentService.getStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "学生修改");
        mv.addObject("student", student);
        //mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookPersonal");
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentPersonalCourseTableList");
        return mv;
    }
    /**
     * 个人课表查看菜单跳转
     * @return
     */
    @RequestMapping("/student/personal/schedule")
    public ModelAndView lookCourse(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentPersonalCourseTableList");
        return mv;
    }
    @RequestMapping("/student/personal/list")
    public ModelAndView lookStudentPersonalCourseList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/lookStudentPersonalCourseTableListList");
        return mv;
    }
    @RequestMapping("/arrayClassResultClass/selectStudentCourse")
    public ModelAndView selectStudentCourse(ArrayClassStudent arrayClassStudent,String arrayClassName) {
        arrayClassStudent.setStudentId(CommonUtil.getPersonId());

        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookstudentarrayclass/studentPersonalCourseTable");

        // 本学生已排课  T_JW_ARRAYCLASS_RESULT_STUDENT
        List<StudentArrayClassLook> studentArrayClassLooks = arrayClassResultClassService.getArrayClassStudentClassByClass(arrayClassStudent);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(studentArrayClassLooks));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        /*ArrayClassClass arrayCalassClass = new ArrayClassClass ();
        arrayCalassClass.setArrayclassId(arrayClassStudent.getArrayclassId());*/
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByStudent(arrayClassStudent);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        String studentName=arrayClassResultClassService.selectStudentName(CommonUtil.getPersonId());
        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayClassStudent.getArrayclassId());
        mv.addObject("studentId",arrayClassStudent.getStudentId());
        mv.addObject("studentName",studentName);
        mv.addObject("studentNumber",arrayClassStudent.getStudentNumber());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    /**
     * 场地课表查看首页
     */
    @RequestMapping("/place/look")
    public ModelAndView placeList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookplacecourse/placeCourseTableList");
        return mv;
    }

    /**
     * 查看场地列表跳转
     * @param arrayClassId
     * @return
     */
    @RequestMapping("/arrayClassResultClass/toPlaceList")
    public ModelAndView toPlaceList(String arrayClassId,String arrayClassName){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookplacecourse/lookPlaceCourseTable");
        mv.addObject("arrayClassId",arrayClassId );
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    /**
     * 查看场地列表页显示
     * @param arrayClassRoom
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getArrayClassRoomPlaceList")
    public Map getList(ArrayClassRoom arrayClassRoom) {
        return CommonUtil.tableMap(arrayClassResultClassService.getArrayClassRoomPlaceList(arrayClassRoom));
    }

    @RequestMapping("/arrayClassResultClass/lookPlaceView")
    public ModelAndView viewPlace(ArrayClassRoom arrayClassRoom,String arrayClassName){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/lookplacecourse/lookPlaceView");

        // 本班级已排课  T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getArrayclassResultClassByPlace(arrayClassRoom);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByPlace(arrayClassRoom);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayClassId",arrayClassRoom.getArrayClassId());
        mv.addObject("roomId",arrayClassRoom.getRoomId());
        mv.addObject("roomIdShow",arrayClassRoom.getRoomIdShow());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    /**
     * 寒月 end
     */


    /**
     * yangshuang start
     */
    @RequestMapping("/arrayClassResultClass/arrayClassList")
    public ModelAndView resultList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/manual/arrayClassList");
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getArrayClassList")
    public Map<String, List<ArrayClass>> getArrayClassList(ArrayClass arrayClass) {
        Map<String, List<ArrayClass>> resultMap = new HashMap<String, List<ArrayClass>>();
        arrayClass.setCreator(CommonUtil.getPersonId());
        arrayClass.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", arrayClassResultClassService.getArrayClassList(arrayClass));
        return resultMap;
    }

    @RequestMapping("/arrayClassResultClass/classList")
    public ModelAndView classList(String arrayClassId,String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/manual/classList");
        mv.addObject("arrayClassId",arrayClassId);
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getClassList")
    public Map<String, List<ArrayClassClass>> getClassList(ArrayClassClass arrayClassId) {
        if(arrayClassId.getMajorCode()!= null && !arrayClassId.getMajorCode().equals("")){
            String[] code =  arrayClassId.getMajorCode().split(",");
            arrayClassId.setMajorCode(code[0]);
            arrayClassId.setTrainingLevel(code[1]);
            arrayClassId.setMajorDirection(code[2]);
        }
        Map<String, List<ArrayClassClass>> resultMap = new HashMap<String, List<ArrayClassClass>>();
        resultMap.put("data", arrayClassResultClassService.getClassListByArrayClassId(arrayClassId));
        return resultMap;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/delresultClassList")
    public Message del(ArrayclassResultClass resultClass) {
        arrayClassResultClassService.delResultClass(resultClass);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/arrayClassResultClass/manualClass")
    public ModelAndView manualClass(ArrayClassClass arrayCalassClass, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/manual/manualClass");
        //排课安排表 T_JW_ARRAYCLASS_ARRAY
        List<ArrayclassArray> arrayclassArrayList = arrayClassResultClassService.getArrayclassArrayListByClass(arrayCalassClass);
        mv.addObject("arrayclassArrayList", JsonUtils.toJson( arrayclassArrayList ));

        //排课约束条件表 T_JW_ARRAYCLASS_CONDITION
        List<ArrayClassCondition> arrayClassConditionList = arrayClassResultClassService.getArrayClassConditionByClass(arrayCalassClass);
        mv.addObject("arrayClassConditionList", JsonUtils.toJson(arrayClassConditionList));

        //排课教室关联表  T_JW_ARRAYCLASS_ROOM
        List<ArrayClassRoom> arrayClassRoomList = arrayClassResultClassService.getArrayClassRoomByClass(arrayCalassClass);
        mv.addObject("arrayClassRoomList", JsonUtils.toJson(arrayClassRoomList));

        // 本班级已排课  T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getArrayclassResultClassByClass(arrayCalassClass);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //教师其他班级已排课 T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayResultClassOtherClass = arrayClassResultClassService.getArrayclassResultClassOtherClass(arrayCalassClass);
        mv.addObject("arrayResultClassOtherClass", JsonUtils.toJson(arrayResultClassOtherClass));

        //排课时间表 T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.geArrayClassTimeByClass(arrayCalassClass);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);
        mv.addObject("colspanlength",arrayClassTimeList.size());

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayCalassClass.getArrayclassId());
        mv.addObject("classId",arrayCalassClass.getClassId());
        mv.addObject("className",arrayCalassClass.getClassName());
        mv.addObject("studentNumber",arrayCalassClass.getStudentNumber());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    @Resource
    private CommonService commonService;

    @RequestMapping("/arrayClassResultClass/viewClass")
    public ModelAndView viewClass(ArrayClassClass arrayCalassClass, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/manual/viewClass");

        // 本班级已排课  T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getArrayclassResultClassByClass(arrayCalassClass);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.geArrayClassTimeByClass(arrayCalassClass);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayCalassClass.getArrayclassId());
        mv.addObject("classId",arrayCalassClass.getClassId());
        mv.addObject("className",arrayCalassClass.getClassName());
        mv.addObject("studentNumber",arrayCalassClass.getStudentNumber());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/delClassResultByid")
    public Message delClassResultByid(String id) {
        arrayClassResultClassService.delClassResultByid(id);
        return new Message(1, "删除成功！", null);
    }

    @Resource
    private ClassService classService;

    //保存
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/saveClassResult")
    public Message saveClassResult(ArrayclassResultClass arrayResultClass) {
        if(arrayResultClass.getId() == null || arrayResultClass.getId().equals("")  || arrayResultClass.getId().equals("undefined")  ){//新增
            ClassBean classBean = classService.getClassByClassid(arrayResultClass.getClassId());
            // 班级信息
            arrayResultClass.setDepartmentsId(classBean.getDepartmentsId());
            arrayResultClass.setMajorCode(classBean.getMajorCode());
            arrayResultClass.setMajorDirection(classBean.getMajorDirection());
            arrayResultClass.setTrainingLevel(classBean.getTrainingLevel());
            arrayResultClass.setClassName(classBean.getClassName());

            String hoursCode = arrayResultClass.getHoursCode();
            arrayResultClass.setHoursType(hoursCode.substring(0,1));
            arrayResultClass.setId(CommonUtil.getUUID());
            arrayResultClass.setCreateDept(CommonUtil.getDefaultDept());
            arrayResultClass.setCreator(CommonUtil.getPersonId());
            arrayClassResultClassService.insertResultClass(arrayResultClass);
        }else{
            String hoursCode = arrayResultClass.getHoursCode();
            arrayResultClass.setHoursType(hoursCode.substring(0,1));
            arrayResultClass.setChanger(CommonUtil.getPersonId());
            arrayResultClass.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassResultClassService.updateResultClass(arrayResultClass);

        }

        return new Message(1, arrayResultClass.getId(), null);
    }



    /**
     * yangshuang end
     * @return
     */


    /**
     * 王强 start
     * @return
     */
//班级课表查看
    //跳转排课计划页面
    @RequestMapping("/class/look")
    public ModelAndView resultClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/classSyllabus/arrayClassClassList");
        return mv;
    }
    //跳转班级列表页面
    @RequestMapping("/arrayClassResultClass/classSyllabusList")
    public ModelAndView classSyllabusList(String arrayClassId,String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/classSyllabus/classSyllabusList");
        mv.addObject("arrayClassId",arrayClassId);
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    //查询班级列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getClassSyllabusList")
    public Map<String, List<ArrayClassClass>> getClassSyllabusList(ArrayClassClass arrayClassClass) {
        Map<String, List<ArrayClassClass>> resultMap = new HashMap<String, List<ArrayClassClass>>();
        resultMap.put("data", arrayClassResultClassService.getClassSyllabusList(arrayClassClass));
        return resultMap;
    }
    @RequestMapping("/arrayClassResultClass/classSyllabusView")
    public ModelAndView classSyllabusView(ArrayClassClass arrayClassClass, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/classSyllabus/classSyllabusView");

        //本班级已排课 T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getClassSyllabusById(arrayClassClass);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByClass(arrayClassClass);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayClassClass.getArrayclassId());
        mv.addObject("classId",arrayClassClass.getClassId());
        mv.addObject("className",arrayClassClass.getClassName());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }

    //教师课表查看
//跳转排课计划页面
    @RequestMapping("/teacher/look")
    public ModelAndView resultTeacherList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/teacherSyllabus/arrayClassTeacherList");
        return mv;
    }
    //跳转教师列表页面
    @RequestMapping("/arrayClassResultClass/teacherSyllabusList")
    public ModelAndView teacherSyllabusList(String arrayClassId,String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/teacherSyllabus/teacherSyllabusList");
        mv.addObject("arrayClassId",arrayClassId);
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    //查询教师列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getTeacherSyllabusList")
    public Map<String, List<ArrayClassTeacher>> getTeacherSyllabusList(ArrayClassTeacher arrayClassTeacher) {
        Map<String, List<ArrayClassTeacher>> resultMap = new HashMap<String, List<ArrayClassTeacher>>();
        resultMap.put("data", arrayClassResultClassService.getTeacherSyllabusList(arrayClassTeacher));
        return resultMap;
    }
    @RequestMapping("/arrayClassResultClass/teacherSyllabusView")
    public ModelAndView teacherSyllabusView(ArrayClassTeacher arrayClassTeacher, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/teacherSyllabus/teacherSyllabusView");

        //本班级已排课 T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getTeacherSyllabusById(arrayClassTeacher);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByTeacher(arrayClassTeacher);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        mv.addObject("arrayclassId",arrayClassTeacher.getArrayclassId());
        mv.addObject("teacherPersonId",arrayClassTeacher.getTeacherPersonId());
        mv.addObject("teacherPersonShow",arrayClassTeacher.getTeacherPersonShow());
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    //教师个人课表查看
    //跳转排课计划页面
    @RequestMapping("/teacher/personal")
    public ModelAndView TeacherPersonalList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/teacherSyllabus/teacherPersonalSyllabusList");
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getArrayClassTeacherList")
    public Map<String, List<ArrayClass>> getArrayClassTeacherList(StudentArrayClassLook studentArrayClassLook) {
        Map<String, List<ArrayClass>> resultMap = new HashMap<String, List<ArrayClass>>();
        studentArrayClassLook.setTeacherPersonId(CommonUtil.getPersonId());
        resultMap.put("data", arrayClassResultClassService.getArrayClassTeacherList(studentArrayClassLook));
        return resultMap;
    }

    //查询排课计划列表
    @ResponseBody
    @RequestMapping("/arrayClassResultClass/getTeacherPersonalList")
    public Map<String, List<ArrayClass>> getTeacherPersonalList(ArrayClass arrayClass) {
        Map<String, List<ArrayClass>> resultMap = new HashMap<String, List<ArrayClass>>();
        resultMap.put("data", arrayClassResultClassService.getArrayClassList(arrayClass));
        return resultMap;
    }
    @RequestMapping("/arrayClassResultClass/teacherPersonalSyllabusView")
    public ModelAndView teacherPersonalSyllabusView(ArrayClassTeacher arrayClassTeacher, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/resultClass/teacherSyllabus/teacherPersonalSyllabusView");
        arrayClassTeacher.setTeacherPersonId(CommonUtil.getPersonId());

        //本班级已排课 T_JW_ARRAYCLASS_RESULT_CLASS
        List<ArrayclassResultClass> arrayclassResultClassList = arrayClassResultClassService.getTeacherSyllabusById(arrayClassTeacher);
        mv.addObject("arrayclassResultClassList", JsonUtils.toJson(arrayclassResultClassList));

        //排课时间表  T_JW_ARRAYCLASS_TIME
        List<ArrayClassTime> arrayClassTimeList = arrayClassResultClassService.getArrayClassTimeByTeacher(arrayClassTeacher);
        mv.addObject("arrayClassTimeList",arrayClassTimeList);

        List<Select2> weekShow = commonService.getSysDict("XQZ","");
        mv.addObject("weekShow",weekShow);

        String teacherPersonShow=arrayClassResultClassService.getTeacherName(arrayClassTeacher).get(0);

        mv.addObject("arrayclassId",arrayClassTeacher.getArrayclassId());
        mv.addObject("teacherPersonId",arrayClassTeacher.getTeacherPersonId());
        mv.addObject("teacherPersonShow",teacherPersonShow);
        mv.addObject("arrayClassName",arrayClassName);
        return mv;
    }
    /**
     *王强 end
     * @return
     */



}
