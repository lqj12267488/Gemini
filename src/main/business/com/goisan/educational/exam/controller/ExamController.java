package com.goisan.educational.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.*;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

//考务管理
@Controller
public class ExamController {

    @Resource
    private ExamService examService;

    //考试信息
    @RequestMapping("/exam")
    public String toList() {
        return "/business/educational/exam/examList";
    }

    //考试信息列表
    @ResponseBody
    @RequestMapping("/exam/getExamList")
    public Map<String, Object> getExamList(Exam exam, String flag, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> examList = new HashMap<String, Object>();
        if (!"1".equals(flag)) {
            exam.setCreator(CommonUtil.getPersonId());
            exam.setDeptId(CommonUtil.getDefaultDept());
            exam.setLevel(CommonUtil.getLoginUser().getLevel());
        }
        List<Exam> list = examService.getExamList(exam);
        PageInfo<List<Exam>> info = new PageInfo(list);
        examList.put("draw", draw);
        examList.put("recordsTotal", info.getTotal());
        examList.put("recordsFiltered", info.getTotal());
        examList.put("data", list);
        return examList;
    }

    /**
     *新增参数，学期
     */
    @ResponseBody
    @RequestMapping("/exam/examClassList")
    public ModelAndView examClassList(String id, String name,String term) {
        ModelAndView mv = new ModelAndView("business/educational/exam/examClassList");
        mv.addObject("id", id);
        mv.addObject("name", name);
        mv.addObject("term", term);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/getExamClassList")
    public Map<String, List> getExamClassList(ExamCourseClass examCourseClass) {
        return CommonUtil.tableMap(examService.getExamCourseClass(examCourseClass));
    }

    @ResponseBody
    @RequestMapping("/exam/toEditExamClass")
    public ModelAndView toEditExamClass(String id, String examId,String term) {
        ModelAndView mv = new ModelAndView("business/educational/exam/editExamClass");
        if (id != null && !"".equals(id)) {
            ExamCourseClass examCourseClass = examService.getExamCourseClassById(id);
            mv.addObject("data", examCourseClass);
        }
        mv.addObject("id", examId);
        mv.addObject("term", term);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/delExamClass")
    public Message delExamClass(String id) {
        examService.delExamCourseClassById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/updateExamClass")
    public Message updateExamClass(ExamCourseClass examCourseClass) {
        String majorCode = examCourseClass.getMajorCode();
        examCourseClass.setMajorCode(majorCode.split(",")[0]);
        examCourseClass.setTrainingLevel(majorCode.split(",")[1]);
        if (examCourseClass.getId() != null && !"".equals(examCourseClass.getId())) {
            examService.updateExamCourseClass(examCourseClass);
            return new Message(1, "修改成功！", null);
        } else {
            List<ExamCourseClass> examCourseClasses = examService.getExamCourseClassByClassIdAndCourseId(examCourseClass.getClassId(), examCourseClass.getCourseId(), examCourseClass.getExamId());
            if (examCourseClasses.size() > 0) {
                return new Message(1, "不能重复添加！", null);
            } else {
                examService.insertExamCourseClass(examCourseClass);
                return new Message(1, "新增成功！", null);
            }

        }
    }

    @ResponseBody
    @RequestMapping("/exam/importClassData")
    public Message importClassData(String id) {
        examService.deleteExamCourseClassByExamId(id);
        if (examService.importClassData(id) > 0) {
            return new Message(1, "操作成功！", null);
        } else {
            return new Message(1, "操作失败！请查看落课信息是否正确！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/exam/examTimeList")
    public ModelAndView examTimeList(String id, String name) {
        ModelAndView mv = new ModelAndView("business/educational/exam/examTimeList");
        mv.addObject("id", id);
        mv.addObject("name", name);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/getExamTimeList")
    public Map<String, List> getExamTimeList(ExamTime examTime) {
        return CommonUtil.tableMap(examService.getExamTime(examTime));
    }

    @ResponseBody
    @RequestMapping("/exam/toEditExamTime")
    public ModelAndView toEditExamTime(String id, String examId) {
        ModelAndView mv = new ModelAndView("business/educational/exam/editExamTime");
        if (id != null && !"".equals(id)) {
            ExamTime ExamTime = examService.getExamTimeById(id);
            mv.addObject("data", ExamTime);
        }
        mv.addObject("id", examId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/delExamTime")
    public Message delExamTime(String id) {
        examService.delExamTimeById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/updateExamTime")
    public Message updateExamClass(ExamTime examTime) {
        if (examTime.getId() != null && !"".equals(examTime.getId())) {
            examService.updateExamTime(examTime);
            return new Message(1, "修改成功！", null);
        } else {
            examService.insertExamTime(examTime);
            return new Message(1, "新增成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/exam/getPersonalExamList")
    public Map<String, List> getPersonalExamList(Exam exam) {
        exam.setStudentId(CommonUtil.getPersonId());
        return CommonUtil.tableMap(examService.getPersonalExamList(exam));
    }

    //考试新增
    @RequestMapping("/exam/toAdd")
    public String toAddExam(Model model) {
        String now = CommonUtil.now("yyyy-MM-dd");
        model.addAttribute("head", "添加考试信息");
        model.addAttribute("now", now);
        return "/business/educational/exam/editExam";
    }

    //修改考试
    @RequestMapping("/exam/toEdit")
    public String toEditExam(String id, Model model) {
        model.addAttribute("exam", examService.selectExamById(id));
        model.addAttribute("head", "修改考试信息");
        return "/business/educational/exam/editExam";
    }

    //保存考试信息
    @ResponseBody
    @RequestMapping("/exam/save")
    public Message saveExam(Exam exam) {
        List<Exam> list = examService.getExamListByTermType(exam);
        if (null == exam.getExamId() || "".equals(exam.getExamId())) {
            if (list.size() > 0) {
                return new Message(1, "同一学期不能重复添加相同类型考试！", null);
            } else {
                exam.setExamId(CommonUtil.getUUID());
                CommonUtil.save(exam);
                examService.insertExam(exam);
                return new Message(0, "添加成功！", null);
            }
        } else {
            if (list.size() > 1) {
                return new Message(1, "同一学期不能重复添加相同类型考试！", null);
            } else {
                CommonUtil.update(exam);
                examService.updateExam(exam);
                return new Message(0, "修改成功！", null);
            }
        }

    }


    //删除考试
    @ResponseBody
    @RequestMapping("/exam/del")
    public Message delExam(String id) {
//        List<ExamCourse> courseList = examService.getExamCourseByExamId(id);
        List<ScoreImport> scoreImports = examService.checkImport(id);
        if (scoreImports.size() > 0) {
            return new Message(1, "该考试信息存在考试科目,不可删除！", "error");
        } else {
            examService.delExamById(id);
            return new Message(0, "删除成功！", "success");
        }
    }


    //考试科目
    @RequestMapping("/exam/course")
    public String toCourseList() {
        return "/business/educational/exam/toCourseList";
    }

    //设置考试科目
    @RequestMapping("/exam/course/setExamCourse")
    public ModelAndView setExamCourse(String examId, String startTime, String endTime, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("start", startTime);
        mv.addObject("examId", examId);
        mv.addObject("end", endTime);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/courseList");
        return mv;
    }


    //考试科目列表
    @ResponseBody
    @RequestMapping("/exam/course/getExamCourseList")
    public Map<String, List> getExamCourseList(ExamCourse examCourse, String examId) {
        examCourse.setExamId(examId);
        //examCourse.setCreator(CommonUtil.getPersonId());
        //examCourse.setCreateDept(CommonUtil.getDefaultDept());
        if ("undefined".equals(examCourse.getTrainingLevel()) || "".equals(examCourse.getTrainingLevel())) {
            examCourse.setTrainingLevel(null);
        }
        if ("undefined".equals(examCourse.getMajorCode()) || "".equals(examCourse.getMajorCode())) {
            examCourse.setMajorCode(null);
        }
        if ("undefined".equals(examCourse.getCourseId()) || "".equals(examCourse.getCourseId())) {
            examCourse.setCourseId(null);
        }
        return CommonUtil.tableMap(examService.getExamCourseList(examCourse));
    }

    //新增考试科目
    @RequestMapping("/exam/course/toAdd")
    public String toAddCourse(Model model, String examId, String start, String end) {
        model.addAttribute("head", "添加考试信息");
        model.addAttribute("examId", examId);
        model.addAttribute("start", start);
        model.addAttribute("end", end);
        return "/business/educational/exam/editCourse";
    }

    //添加考场信息
    @RequestMapping("/exam/room/toAdd")
    public String toAddRoom(Model model, String examId) {
        model.addAttribute("head", "添加考场信息");
        model.addAttribute("examId", examId);
        return "/business/educational/exam/editRoom";
    }

    //修改考场信息
    @RequestMapping("/exam/room/toEdit")
    public String toEditRoom(String id, Model model) {
        model.addAttribute("room", examService.selectExamRoomById(id));
        model.addAttribute("head", "修改考场信息");
        return "/business/educational/exam/editRoom";
    }


    //修改考试科目
    @RequestMapping("/exam/course/toEdit")
    public String toEditCourse(String id, Model model) {
        model.addAttribute("course", examService.selectExamCourseById(id));
        model.addAttribute("head", "修改考试科目信息");
        return "/business/educational/exam/editCourse";
    }

    //保存考试科目信息
    @ResponseBody
    @RequestMapping("/exam/course/save")
    public Message saveCourse(ExamCourse examCourse) {
        if (null == examCourse.getExamCourseId() || examCourse.getExamCourseId() == "") {
            examCourse.setExamCourseId(CommonUtil.getUUID());
            CommonUtil.save(examCourse);
            examService.insertExamCourse(examCourse);
            return new Message(4, "添加成功！", null);
        } else {
            CommonUtil.update(examCourse);
            examService.updateExamCourse(examCourse);
            return new Message(5, "修改成功！", null);
        }

    }


    //删除考试科目
    @ResponseBody
    @RequestMapping("/exam/course/del")
    public Message delCourseById(String id) {
        examService.deleteOriginalExamCourseClass(id);
        examService.delExamCourseById(id);
        return new Message(0, "删除成功！", "success");
    }


    //添加考试班级
    @RequestMapping("/exam/course/toAddExamClass")
    public ModelAndView toAddExamClass(String examCourseId, String examId, String courseType, String departmentsId, String courseId, String examType) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addExamClass");
        mv.addObject("examCourseId", examCourseId);
        mv.addObject("examId", examId);
        mv.addObject("courseType", courseType);
        mv.addObject("departmentsId", departmentsId);
        mv.addObject("courseId", courseId);
        mv.addObject("examType", examType);
        return mv;
    }

    //班级树形下拉树
    @ResponseBody
    @RequestMapping("/exam/course/getClassTreeForExam")
    public Map<String, List> getClassTreeForExam(String courseType, String departmentsId, String examCourseId) {
        List<Tree> classTree = new ArrayList<Tree>();
        if ("1".equals(courseType)) {
            classTree = examService.getALLClassTree();
        } else {
            classTree = examService.getClassTreeByDepartmentId(departmentsId);
        }

        List<ExamCourseClass> selectedClassList = examService.getSelectedClassById(examCourseId);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", classTree);
        map.put("selected", selectedClassList);
        return map;
    }

    //保存考试班级
    @ResponseBody
    @RequestMapping("/exam/course/saveExamClass")
    public Message saveExamClass(String ids, String examCourseId, String examId, String courseType, String courseId, String examType) {
        examService.deleteOriginalExamCourseClass(examCourseId);
        //选中的所有系部、专业、班级ID
        String dept_id = "";
        String major_code = "";
        String traningLeval = "";
        String class_id = "";
        ExamCourseClass examCourseClass = new ExamCourseClass();
        if ("1".equals(courseType)) {
            //普通考试
            List<Dept> deptList = examService.chooseDeptList(ids);
            if (deptList.size() > 0) {
                //选中的数据
                List<ClassBean> idsList = examService.chooseIdsList(ids);
                if (idsList.size() > 0) {
                    for (int b = 0; b < idsList.size(); b++) {
                        dept_id = idsList.get(b).getDepartmentsId();
                        major_code = idsList.get(b).getMajorCode();
                        class_id = idsList.get(b).getClassId();
                        traningLeval = idsList.get(b).getTrainingLevel();
                        ExamCourse examCourse = examService.selectExamCourseById(examCourseId);
                        examCourseClass.setId(CommonUtil.getUUID());
                        examCourseClass.setCourseId(courseId);
                        examCourseClass.setExamId(examId);
                        examCourseClass.setDepartmentsId(dept_id);
                        examCourseClass.setExamCourseId(examCourseId);
                        examCourseClass.setMajorCode(major_code);
                        if (null != traningLeval) {
                            examCourseClass.setTrainingLevel(traningLeval);
                        }
                        examCourseClass.setClassId(class_id);
                        if ("1".equals(examType)) {

                        } else {
                            examCourseClass.setRoomId(examCourse.getRoomId());
                        }
                        examCourseClass.setStartTime(examCourse.getStartTime().replace("T", ""));
                        examCourseClass.setEndTime(examCourse.getEndTime().replace("T", ""));
                        examCourseClass.setExamMinute(examCourse.getExamMinute());
                        examCourseClass.setExamType(examCourse.getExamType());
                        CommonUtil.save(examCourseClass);
                        examService.insertExamCourseClass(examCourseClass);

                    }
                }
            }
        } else {
            //非普通考试
            List<ClassBean> idsList = examService.chooseIdsList(ids);
            if (idsList.size() > 0) {
                for (int b = 0; b < idsList.size(); b++) {
                    dept_id = idsList.get(b).getDepartmentsId();
                    major_code = idsList.get(b).getMajorCode();
                    traningLeval = idsList.get(b).getTrainingLevel();
                    class_id = idsList.get(b).getClassId();
                    ExamCourse examCourse = examService.selectExamCourseById(examCourseId);
                    examCourseClass.setId(CommonUtil.getUUID());
                    examCourseClass.setExamId(examId);
                    examCourseClass.setClassId(class_id);
                    examCourseClass.setExamCourseId(examCourseId);
                    examCourseClass.setCourseId(examCourse.getCourseId());
                    examCourseClass.setDepartmentsId(dept_id);
                    examCourseClass.setMajorCode(major_code);
                    if ("1".equals(examType)) {

                    } else {
                        examCourseClass.setRoomId(examCourse.getRoomId());
                    }
                    examCourseClass.setTrainingLevel(traningLeval);
                    examCourseClass.setStartTime(examCourse.getStartTime().replace("T", ""));
                    examCourseClass.setEndTime(examCourse.getEndTime().replace("T", ""));
                    examCourseClass.setExamMinute(examCourse.getExamMinute());
                    examCourseClass.setExamType(examCourse.getExamType());
                    examCourseClass.setRoomId(examCourse.getRoomId());
                    CommonUtil.save(examCourseClass);
                    examService.insertExamCourseClass(examCourseClass);
                }
            }
        }

        return new Message(1, "保存成功！", null);
    }

    //监考教师
    @RequestMapping("/exam/teacher")
    public String teacherList() {
        return "/business/educational/exam/teacherList";
    }

    //添加监考教师
    @RequestMapping("/exam/teacher/toAddExamTeacher")
    public ModelAndView toAddExamTeacher(String examId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addExamTeacher");
        mv.addObject("examId", examId);
        return mv;
    }

    //查看已添加监考教师
    @RequestMapping("/exam/room/seachSetExamRoom")
    public ModelAndView seachSetExamRoom(String examId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/seachSetExamRoom");
        mv.addObject("examId", examId);
        return mv;
    }

    //人员树形下拉选
    @ResponseBody
    @RequestMapping("/exam/teacher/getEmpTreeForExam")
    public Map<String, List> getEmpTreeForExam(String examId) {
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = examService.getAllEmpTree();
        List<ExamTeacher> selectedEmpList = examService.getSelectedEmpByExamId(examId);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        map.put("selected", selectedEmpList);
        return map;
    }

    //保存监考教师
    @ResponseBody
    @RequestMapping("/exam/teacher/saveExamTeacher")
    public Message saveExamTeacher(String ids, String examId) {
        examService.deleteOriginalExamTeacher(examId);
        String dept_id = "";
        String person_id = "";
        ExamTeacher examTeacher = new ExamTeacher();
        //选中的系部
        List<Dept> deptList = examService.chooseDeptList(ids);
        if (deptList.size() > 0) {
            for (int a = 0; a < deptList.size(); a++) {
                dept_id = deptList.get(a).getDeptId();
                List<Emp> empList = examService.chooseEmpList(dept_id, ids);
                examTeacher.setTeacherDeptId(dept_id);
                //选中的人员
                if (empList.size() > 0) {
                    for (int b = 0; b < empList.size(); b++) {
                        person_id = empList.get(b).getPersonId();
                        examTeacher.setTeacherPersonId(person_id);
                        examTeacher.setId(CommonUtil.getUUID());
                        examTeacher.setExamId(examId);
                        CommonUtil.save(examTeacher);
                        examService.insertExamTeacher(examTeacher);
                    }
                }
            }
        }
        return new Message(1, "保存成功！", null);
    }

    //考试场地
    @RequestMapping("/exam/room")
    public String toRoomList() {
        return "/business/educational/exam/toRoomList";
    }

    //设置考试场地
    @RequestMapping("/exam/room/setExamRoom")
    public ModelAndView setExamRoom(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/roomList");
        return mv;
    }

    //考场信息列表
    @ResponseBody
    @RequestMapping("/exam/room/getExamRoomList")
    public Map<String, List> getExamRoomList(ExamRoom examRoom, String examId) {
        examRoom.setExamId(examId);
        examRoom.setCreator(CommonUtil.getPersonId());
        examRoom.setCreateDept(CommonUtil.getDefaultDept());
        examRoom.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(examService.getExamRoomList(examRoom));
    }

    //保存添加考场
    @ResponseBody
    @RequestMapping("/exam/room/save")
    public Message saveRoom(ExamRoom examRoom) {
        if (null == examRoom.getExamRoomId() || examRoom.getExamRoomId() == "") {
            String examId = examRoom.getExamId();
            String roomId = examRoom.getRoomId();
            List<ExamRoom> roomList = examService.getExamRoomById(roomId, examId);
            if (roomList.size() > 0) {
                return new Message(1, "考场不能重复添加，请重试！", null);
            } else {
                examRoom.setExamRoomId(CommonUtil.getUUID());
                CommonUtil.save(examRoom);
                examService.insertExamRoom(examRoom);
                return new Message(2, "添加成功！", null);
            }

        } else {
            CommonUtil.update(examRoom);
            examService.updateExamRoom(examRoom);
            return new Message(3, "修改成功！", null);
        }

    }

    @ResponseBody
    @RequestMapping("/exam/room/checkhandWorkAddExamEmp")
    public Message checkhandWorkAddExamEmp(String examId) {
        String teacherNum = examService.getExamTeacherCountByExamId(examId);
        if (null == teacherNum || "0".equals(teacherNum)) {
            return new Message(1, "还未设置监考教师！", null);
        }
        return new Message(0, null, null);
    }

    //修改监考教师
    @RequestMapping("/exam/room/handWorkAddExamEmp")
    public ModelAndView handWorkAddExamEmp(String roomId, String examId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/handWorkAddExamEmp");
        mv.addObject("roomId", roomId);
        mv.addObject("examId", examId);
        return mv;
    }

    //查出已设置监考教师人员树形下拉选
    @ResponseBody
    @RequestMapping("/exam/room/getEmpTreeForHandWork")
    public Map<String, List> getEmpTreeForHandWork(String examId, String roomId) {
        List<Tree> empTree = examService.getEmpTreeForHandWork(examId);
        List<ExamRoomTeacher> selectedEmpList = examService.getSelectedEmpTreeByExamIdAndRoomId(examId, roomId);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        map.put("selected", selectedEmpList);
        return map;
    }

    //删除考场信息
    @ResponseBody
    @RequestMapping("/exam/room/del")
    public Message delRoomById(String id, String roomId, String examId) {
        ExamClass examClass = new ExamClass();
        examClass.setExamRoomId(id);
        examClass.setRoomId(roomId);
        examClass.setExamId(examId);
        List<ExamRoomTeacher> teacherList = examService.getExamRoomTeacherByExamRoomId(id);
        if (teacherList.size() > 0) {
            return new Message(1, "该考场下存在监考教师,不可删除！", null);
        } else {
            examService.deleteOriginalExamClass(examClass);
            examService.delExamRoomById(id);
            return new Message(0, "删除成功！", null);
        }

    }

    //手动设置监考教师保存
    @ResponseBody
    @RequestMapping("/exam/room/saveExamRoomTeacherForHandWork")
    public Message saveExamRoomTeacher(String ids, String examId, String roomId) {
        String teacherNum = examService.getOriginalTeacherNum(examId, roomId);
        String empSize = examService.getSelectedEmpSize(ids);
        int teacher_num = Integer.parseInt(teacherNum);
        int emp_ize = Integer.parseInt(empSize);
        if (emp_ize == teacher_num) {
            String teacherDeptId = "";
            String teacherPersonId = "";
            ExamRoomTeacher examRoomTeacher = new ExamRoomTeacher();
            //选中的系部
            List<Dept> deptList = examService.chooseDeptList(ids);
            if (deptList.size() > 0) {
                for (int a = 0; a < deptList.size(); a++) {
                    if (a == 0) {
                        teacherDeptId = deptList.get(a).getDeptId();
                    } else {
                        teacherDeptId += "," + deptList.get(a).getDeptId();
                    }
                    List<Emp> empList = examService.chooseEmpList(teacherDeptId, ids);
                    //选中的人员
                    if (empList.size() > 0) {
                        for (int b = 0; b < empList.size(); b++) {
                            if (b == 0) {
                                teacherPersonId = empList.get(b).getPersonId();
                            } else {
                                teacherPersonId += "," + empList.get(b).getPersonId();
                            }


                        }
                    }
                }
                examRoomTeacher.setRoomId(roomId);
                examRoomTeacher.setTeacherDeptId(teacherDeptId);
                examRoomTeacher.setTeacherPersonId(teacherPersonId);
                CommonUtil.update(examRoomTeacher);
                examService.updateExamRoomTeacherByRoomIdForHandWork(examRoomTeacher);
            }
            return new Message(0, "设置成功！", null);
        } else {
            return new Message(1, "该考场监考教师人数应设置为" + teacherNum + "人,请重新设置", null);
        }

    }

    //考生信息
    @RequestMapping("/exam/student")
    public String toStudentList() {
        return "/business/educational/exam/toStudentList";
    }

    //设置考生
    @RequestMapping("/exam/student/setExamStudent")
    public ModelAndView setExamStudent(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/studentList");
        return mv;
    }

    //考生信息列表
    @ResponseBody
    @RequestMapping("/exam/student/getExamStudentList")
    public Map<String, List> getExamStudentList(ExamStudent examStudent, String examId) {
        examStudent.setExamId(examId);
        examStudent.setCreator(CommonUtil.getPersonId());
        examStudent.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(examService.getExamStudentList(examStudent));
    }


    //批量添加考场
    @ResponseBody
    @RequestMapping("/exam/room/batchAddExamRoom")
    public Message batchAddExamRoom(String examId) {
        examService.deleteOriginalExamRoom(examId);
        int count = 0;
        int sum = 0;
        String departmentsId = "";
        String majorCode = "";
        String trainingLevel = "";
        String classId = "";
        String roomId = "";
        String roomName = "";
        String peopleNumber = "";
        String classString = "";
        List<ExamCourseClass> list = examService.getExamClassByExamId(examId);
        //List <ClassBean>classList=examService.getClassBeanPropertyForBatchAddExamRoom(examId);
        ExamRoom examRoom = new ExamRoom();
        if (list.size() > 0) {
            for (int j = 0; j < list.size(); j++) {
                departmentsId = list.get(j).getDepartmentsId();
                majorCode = list.get(j).getMajorCode();
                trainingLevel = list.get(j).getTrainingLevel();
                classId = list.get(j).getClassId();
                roomId = examService.getClassRoomByClassId(classId);
                if (roomId == null || "".equals(roomId)) {
                    count++;
                } else {
                    Classroom classroom = examService.selectClassRoomById(roomId);
                    roomId = classroom.getId();
                    roomName = classroom.getClassroomName();
                    peopleNumber = classroom.getPeopleNumber();
                    examRoom.setExamRoomId(CommonUtil.getUUID());
                    examRoom.setRoomType("1");
                    examRoom.setExamId(examId);
                    examRoom.setRoomName(roomName);
                    examRoom.setDepartmentsId(departmentsId);
                    examRoom.setMajorCode(majorCode);
                    examRoom.setTrainingLevel(trainingLevel);
                    examRoom.setClassId(classId);
                    examRoom.setRoomId(roomId);
                    examRoom.setTeacherNumber("2");
                    examRoom.setStudentNumber(peopleNumber);
                    CommonUtil.save(examRoom);
                    examService.insertExamRoom(examRoom);
                    sum++;
                }
            }
            if (sum != 0 && sum < list.size()) {
                return new Message(0, "共添加" + sum + "条数据," + count + "个班级还未设置教室,请手动添加考场!", null);
            } else {
                return new Message(0, "共添加" + sum + "条数据," + count + "个班级还未设置教室,请手动添加考场!", null);
            }
        } else {
            return new Message(1, "未设置考试班级,无法批量添加！", null);
        }
    }

    //批量添加考生
    @ResponseBody
    @RequestMapping("/exam/student/batchAddExamStudent")
    public Message batchAddExamStudent(String examId) {
        examService.deleteOriginalExamStudent(examId);
        Integer sum = examService.autoAddStudent(examId);
        if (sum > 0) {
            return new Message(0, "批量添加成功！", null);
        } else {
            return new Message(1, "未设置考试班级,无法批量添加！", null);
        }
    }


    //删除考生信息
    @ResponseBody
    @RequestMapping("/exam/stduent/del")
    public Message delStudentById(String id) {
        examService.delExamStduentById(id);
        return new Message(0, "删除成功！", null);

    }

    //学生自动提示框
    @ResponseBody
    @RequestMapping("/exam/studuent/autoCompleteStudent")
    public List<AutoComplete> autoCompleteStudent() {
        return examService.autoCompleteStudent();
    }

    //自动排考
    @RequestMapping("/exam/auto")
    public String toArrayTeacherResult() {
        return "/business/educational/exam/toArrayTeacherResult";
    }

    //校验自动排考
    @ResponseBody
    @RequestMapping("/exam/auto/checkAutoTeacherArray")
    public Message checkAutoTeacherArray(String examId) {
        List<Exam> examList = examService.checkExamListAutoPossibility(examId);
        //参加考试的班级
        String joinClassNum = examService.getAllExamCourseClassNumByExamId(examId);
        //实际有考场的班级
        String realClassNum = examService.getAllExamRoomClassNumByExamId(examId);
        //设置的监考教师
        String realTeacherNum = examService.getExamRoomTeacherSumByExamId(examId);
        //监考的监考教师
        List<ExamTeacher> examTeacherList = examService.getSelectedEmpByExamId(examId);
        List<ExamRoomTeacher> examRoomTeacherList = examService.getExamRoomTeacherByExamRoomId(examId);
        if (examList.size() > 0) {
            return new Message(1, "自动排考已完成,不可重复排考", null);
        } else {
            if (joinClassNum != null && realClassNum != null) {
                if (Integer.parseInt(joinClassNum) > Integer.parseInt(realClassNum)) {
                    return new Message(1, "考场资源不足,请重新维护考试场地！", null);
                }
            }
            /*if(examTeacherList.size()==0){
                return new Message(1, "监考教师资源不足,请重新设置监考教师！", null);
            }
            if(examRoomTeacherList.size()==0){
                return new Message(1, "监考教师资源不足,请重新设置监考教师！", null);

            }
            if(realTeacherNum!=null){
                if(Integer.parseInt(realTeacherNum) < (Integer.parseInt(joinClassNum))*2){
                    return new Message(1, "监考教师资源不足,请重新设置监考教师！", null);
                }
            }*/
        }
        return new Message(0, null, null);
    }

    //自动排考算法lihaitao
    @ResponseBody
    @RequestMapping("/exam/auto/autoTeacherArray")
    public Message autoTeacherArray(String examId) {
        Exam exam = examService.selectExamById(examId);
        if ("1".equals(exam.getExamFlag())) {
            return new Message(0, "已经排过考了，请勿重复排考!", null);
        }
        List<ExamCourseClass> examCourseClasses = examService.getExamCourseClassByExamId(examId);
        if (examCourseClasses.size() == 0) {
            if ("1".equals(exam.getExamTypes())) {
                return new Message(0, "排考失败！请配置考试班级!", null);
            } else {
                return new Message(0, "排考失败！请配置补考学生信息!", null);
            }
        }
        List<ExamRoom> examRooms = examService.getExamRoomById(null, examId);
        if (examRooms.size() == 0) {
            return new Message(0, "排考失败！请配置考场！", null);
        }
        List<ExamTime> examTimes = examService.getExamTimeByExamId(examId);
        if (examTimes.size() == 0) {
            return new Message(0, "排考失败！请配置考试时间！", null);
        }
        List<ExamTeacher> examTeachers = examService.getExamTeacherByEaxmId(examId);
        if (examTeachers.size() == 0) {
            return new Message(0, "排考失败！请配置监考教师！", null);
        }
        String startTime = exam.getStartTime();
        String endTime = exam.getEndTime();
        Integer daySum = Integer.parseInt(endTime.split("-")[2]) - Integer.parseInt(startTime.split("-")[2]) + 1;
        Map<String, Set<ExamCourseClass>> courseClass = new HashMap<>();
        Set<ExamCourseClass> strs;
        for (ExamCourseClass examCourseClass : examCourseClasses) {
            if (courseClass.get(examCourseClass.getCourseId()) == null) {
                strs = new HashSet<>();
            } else {
                strs = courseClass.get(examCourseClass.getCourseId());
            }
            strs.add(examCourseClass);
            courseClass.put(examCourseClass.getCourseId(), strs);
        }
        Integer ceil = (int) Math.ceil((double) courseClass.size() / daySum / examTimes.size());
        Set<String> kSet = courseClass.keySet();
        List<ExamArray>[][] arrays = null;
        try {
            arrays = autoExamCourseClass(daySum, examTimes.size(), courseClass, ceil, kSet);
        } catch (StackOverflowError stackOverflowError) {
            examService.deleteExamArrayStudentByExamId(examId);
            return new Message(1, "排考失败！排考时间不够用，请重新排考", null);
        }

        if (kSet.size() > 0) {
            return new Message(1, "排考失败！请重新排考", null);
        }
        List<ExamStudent> studentList = examService.getStudentsByExamId(examId);
        if (studentList.size() <= 0) {
            return new Message(0, "排考失败！没有添加学生信息！", null);
        }
        Map<String, List<ExamStudent>> stringListMap = new HashMap<>();
        List<ExamStudent> examStudents;
        for (ExamStudent examStudent : studentList) {
            if (stringListMap.get(examStudent.getClassId()) == null) {
                examStudents = new ArrayList<>();
            } else {
                examStudents = stringListMap.get(examStudent.getClassId());
            }
            examStudents.add(examStudent);
            stringListMap.put(examStudent.getClassId(), examStudents);
        }
        int tmp = 0;
        for (int a = 0; a < arrays.length; a++) {
            for (int b = 0; b < arrays[a].length; b++) {
                List<ExamRoomTeacher> examRoomTeachers = new ArrayList<>();
                if (arrays[a][b] != null) {
                    String s = String.valueOf(Integer.parseInt(startTime.split("-")[2]) + a);
                    if (s.length() == 1) {
                        s = "0" + s;
                    }
                    String date = startTime.split("-")[0] + "-" + startTime.split("-")[1] + "-" + s;
                    int sum = 1;
                    for (ExamArray examArray : arrays[a][b]) {
                        List<ExamStudent> students = null;
                        if ("1".equals(exam.getExamTypes())) {
                            students = stringListMap.get(examArray.getClassId());
                        } else {
                            students = examService.getExamStudentByCalssIdAndCourseId(examArray.getClassId(), examArray.getCourseId(), examId);
                        }
                        ExamRoom examRoom = null;
                        if (students != null) {
                            for (int i = 0; i < students.size(); i++) {
                                try {
                                    examRoom = examRooms.get(tmp);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    examService.deleteExamArrayStudentByExamId(examId);
                                    return new Message(1, "排考失败！考场数量不够！", null);
                                }
                                if (examRoom == null) {
                                    examService.deleteExamArrayStudentByExamId(examId);
                                    return new Message(1, "排考失败！考场数量不够！", null);
                                }
                                ExamStudent examStudent = students.get(i);
                                ExamArrayStudent examArrayStudent = new ExamArrayStudent();
                                examArrayStudent.setExamId(examId);
                                examArrayStudent.setStudentId(examStudent.getStudentId());
                                examArrayStudent.setClassId(examStudent.getClassId());
                                examArrayStudent.setDepartmentsId(examStudent.getDepartmentsId());
                                examArrayStudent.setMajorCode(examStudent.getMajorCode());
                                examArrayStudent.setTrainingLevel(examStudent.getTrainingLevel());
                                examArrayStudent.setRoomId(examRoom.getRoomId());
                                examArrayStudent.setCourseId(examArray.getCourseId());
                                examArrayStudent.setDate(date);
                                examArrayStudent.setStartTime(examTimes.get(b).getStartTime());
                                examArrayStudent.setEndTime(examTimes.get(b).getEndTime());
                                examService.insertExamArrayStudent(examArrayStudent);
                                if (sum == Integer.parseInt(examRoom.getStudentNumber())) {
                                    tmp++;
                                    sum = 1;
                                } else {
                                    sum++;
                                }
                            }
                        }
                    }
                    List<ExamArrayStudent> arrayStudents = examService.getExamArrayStudentsByCurrent(date, examTimes.get(b).getStartTime(), examTimes.get(b).getEndTime(), examId);
                    if (arrayStudents.size() > 0) {
                        Map<String, String> map = new HashMap<>();
                        for (ExamArrayStudent arrayStudent : arrayStudents) {
                            if (map.get(arrayStudent.getRoomId()) == null) {
                                map.put(arrayStudent.getRoomId(), arrayStudent.getRemark() + ";" + arrayStudent.getDepartmentsId());
                            } else {
                                map.put(arrayStudent.getRoomId(), map.get(arrayStudent.getRoomId()) + "," + arrayStudent.getDepartmentsId());
                            }
                        }
                        Set<String> keySet = map.keySet();
                        for (String str : keySet) {
                            for (int i = 0; i < Integer.parseInt(map.get(str).split(";")[0]); i++) {
                                String teaId = "";
                                try {
                                    teaId = selectTeacher(map.get(str), examTeachers, examRoomTeachers);
                                } catch (StackOverflowError e) {
                                    e.printStackTrace();
                                    examService.deleteExamArrayStudentByExamId(examId);
                                    return new Message(1, "排考失败！监考教师数量不够或监考教师不能监考本系部！", null);
                                }
                                if ("".equals(teaId)) {
                                    examService.deleteExamArrayStudentByExamId(examId);
                                    return new Message(1, "排考失败！监考教师数量不够或监考教师不能监考本系部！", null);
                                } else {
                                    ExamRoomTeacher examRoomTeacher = new ExamRoomTeacher();
                                    examRoomTeacher.setTeacherPersonId(teaId.split(",")[0]);
                                    examRoomTeacher.setTeacherDeptId(teaId.split(",")[1]);
                                    examRoomTeacher.setRoomId(str);
                                    examRoomTeacher.setExamId(examId);
                                    examRoomTeacher.setDate(date);
                                    examRoomTeacher.setStartTime(examTimes.get(b).getStartTime());
                                    examRoomTeacher.setEndTime(examTimes.get(b).getEndTime());
                                    examRoomTeachers.add(examRoomTeacher);
                                }
                            }
                        }
                    }
                }
                tmp = 0;
                for (ExamRoomTeacher examRoomTeacher : examRoomTeachers) {
                    examService.insertExamRoomTeacher(examRoomTeacher);
                }
            }
        }
        Integer sum = examService.updateExamArray(examId);
        if (sum == 0) {
            examService.deleteExamArrayStudentByExamId(examId);
            return new Message(1, "排考失败！", null);
        } else {
            exam.setExamFlag("1");
            exam.setExamId(examId);
            CommonUtil.update(exam);
            examService.changeExamFlag(exam);
            return new Message(1, "排考成功！", null);
        }
    }

    private String selectTeacher(String deptId, List<ExamTeacher> examTeachers, List<ExamRoomTeacher> examRoomTeachers) {
        Random random = new Random();
        ExamTeacher examTeacher = examTeachers.get(random.nextInt(examTeachers.size()));
        if (deptId.contains(examTeacher.getTeacherDeptId())) {
            return selectTeacher(deptId, examTeachers, examRoomTeachers);
        } else {
            for (ExamRoomTeacher examRoomTeacher : examRoomTeachers) {
                if (examRoomTeacher.getTeacherPersonId().equals(examTeacher.getTeacherPersonId())) {
                    return selectTeacher(deptId, examTeachers, examRoomTeachers);
                }
            }
        }
        return examTeacher.getTeacherPersonId() + "," + examTeacher.getTeacherDeptId();
    }

    private List<ExamArray>[][] autoExamCourseClass(int daySum, int timeSum, Map<String, Set<ExamCourseClass>> courseClass, int i, Set<String> kSet) {
        List<ExamArray>[][] arrays = new List[daySum][timeSum];
        for (int a = arrays.length - 1; a >= 0; a--) {
            for (int b = 0; b < arrays[a].length; b++) {
                arrays[a][b] = new ArrayList<>();
                for (int c = 0; c < i; c++) {
                    if (kSet.size() == 0) {
                        return arrays;
                    } else {
                        Set<ExamCourseClass> examCourseClasses = selectExamCourseClass(arrays[a][b], courseClass, kSet);
                        for (ExamCourseClass examCourseClass : examCourseClasses) {
                            if (!examCourseClass.getExamMethod().equals("2")) {
                                ExamArray examArray = new ExamArray();
                                examArray.setExamId(examCourseClass.getExamId());
                                examArray.setDepartmentsId(examCourseClass.getDepartmentsId());
                                examArray.setMajorCode(examCourseClass.getMajorCode());
                                examArray.setTrainingLevel(examCourseClass.getTrainingLevel());
                                examArray.setClassId(examCourseClass.getClassId());
                                examArray.setCourseId(examCourseClass.getCourseId());
                                examArray.setExamType(examCourseClass.getExamType());
                                arrays[a][b].add(examArray);
                            }
                        }
                    }
                }
            }
        }
        return arrays;
    }

    private Set<ExamCourseClass> selectExamCourseClass(List<ExamArray> arrays, Map<String, Set<ExamCourseClass>> courseClass, Set<String> keySet) {
        String[] array = keySet.toArray(new String[keySet.size()]);
        Random random = new Random();
        String s = array[random.nextInt(array.length)];
        Set<ExamCourseClass> examCourseClasses = courseClass.get(s);
        if (checkExamCourseClass(arrays, examCourseClasses)) {
            keySet.remove(s);
            return examCourseClasses;
        } else {
            return selectExamCourseClass(arrays, courseClass, keySet);
        }
    }

    private boolean checkExamCourseClass(List<ExamArray> arrays, Set<ExamCourseClass> examCourseClasses) {
        for (ExamArray array : arrays) {
            for (ExamCourseClass examCourseClass : examCourseClasses) {
                if (array.getClassId().equals(examCourseClass.getClassId())) {
                    return false;
                }
            }
        }
        return true;
    }

    //自动排考查看排考结果
    @ResponseBody
    @RequestMapping("/exam/auto/arrayTeacherResult")
    public ModelAndView arrayTeacherResult(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/arrayTeacherResult");
        return mv;
    }

    //自动排考排考结果列表
    @ResponseBody
    @RequestMapping("/exam/array/getTeacherArrayList")
    public Map<String, List> getTeacherArrayList(ExamArray examArray, String examId) {
        examArray.setExamId(examId);
        //examArray.setCreator(CommonUtil.getPersonId());
        //examArray.setCreateDept(CommonUtil.getDefaultDept());
        if ("undefined".equals(examArray.getTrainingLevel()) || "".equals(examArray.getTrainingLevel())) {
            examArray.setTrainingLevel(null);
        }
        if ("undefined".equals(examArray.getMajorCode()) || "".equals(examArray.getMajorCode())) {
            examArray.setMajorCode(null);
        }
        if ("undefined".equals(examArray.getClassId()) || "".equals(examArray.getClassId())) {
            examArray.setClassId(null);
        }
        if ("undefined".equals(examArray.getCourseId()) || "".equals(examArray.getCourseId())) {
            examArray.setCourseId(null);
        }
        if (null != examArray.getMajorCode()) {
            examArray.setMajorCode(examArray.getMajorCode().split(",")[0]);
        }
        return CommonUtil.tableMap(examService.getTeacherArrayList(examArray));
    }

    //编辑自动排考结果中的数
    @RequestMapping("/exam/arry/toEdit")
    public String toEditTeacherArray(String id, Model model) {
        model.addAttribute("array", examService.selectTeacherArrayById(id));
        model.addAttribute("head", "修改自动排考数据");
        return "/business/educational/exam/editTeacherArray";
    }

    //编辑学生排考结果中的数
    @RequestMapping("/exam/arry/student/toEdit")
    public String toEditStudentArray(String id, Model model) {
        model.addAttribute("arrayStudent", examService.selectStudentArrayById(id));
        model.addAttribute("head", "修改学生排考数据");
        return "/business/educational/exam/editStudentArray";
    }

    //保存学生排考结果中的数
    @ResponseBody
    @RequestMapping("/exam/array/student/save")
    public Message saveStudentExamArray(ExamArrayStudent examArrayStudent) {
        CommonUtil.update(examArrayStudent);
        examService.updateStudentArray(examArrayStudent);
        return new Message(0, "修改成功！", null);
    }

    //保存自动排考结果中的数据
    @ResponseBody
    @RequestMapping("/exam/array/save")
    public Message saveTeacherExamArray(ExamArray examArray) {
        CommonUtil.update(examArray);
        examService.updateTeacherArray(examArray);
        return new Message(0, "修改成功！", null);

    }


    //学生排考
    @RequestMapping("/exam/auto/student")
    public String toAutoStudentList() {
        return "/business/educational/exam/toArrayStudentResult";
    }

    //学生排考查看结果
    @ResponseBody
    @RequestMapping("/exam/auto/student/arrayStudentResult")
    public ModelAndView arrayStudentResult(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/arrayStudentResult");
        return mv;
    }

    //学生排考结果列表
    @ResponseBody
    @RequestMapping("/exam/array/student/getStudentArrayList")
    public Map<String, List> getStudentArrayList(ExamArrayStudent examArrayStudent, String examId) {
        examArrayStudent.setExamId(examId);
        examArrayStudent.setCreator(CommonUtil.getPersonId());
        examArrayStudent.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(examService.getStudentArrayList(examArrayStudent));
    }

    //学生考试安排结果
    @RequestMapping("/exam/result/student")
    public String toResultStudentList() {
        return "/business/educational/exam/toResultStudentList";
    }

    //教师考试安排结果
    @RequestMapping("/exam/result/teacher")
    public String toResultTeacherList() {
        return "/business/educational/exam/toResultTeacherList";
    }

    //教师考试安排列表页
    @RequestMapping("/exam/result/final/teacher")
    public ModelAndView searchTeacherExamArrayResult(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/finalTeacherResult");
        return mv;
    }

    //学生考试安排列表页
    @RequestMapping("/exam/result/final/student")
    public ModelAndView searchStudentExamCourseResult(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/finalStudentResult");
        return mv;
    }


    //导出考试时间安排结果
    @RequestMapping("/exam/export/teacherResult")
    public void exportTeacherResult(String examId, HttpServletResponse response) {
        List<ExamArray> examArrays = examService.getResult(examId);
        List<String> dates = examService.getDate(examId);
        List<ExamTime> times = examService.getExamTimeByExamId(examId);
        List<ExamArray>[][] arrays = new List[dates.size()][times.size()];
        for (ExamArray array : examArrays) {
            String date = array.getExamDate();
            String time = array.getStartTime() + "——" + array.getEndTime();
            int i = 0;
            int j = 0;
            for (; i < dates.size(); i++) {
                if (dates.get(i).equals(date)) {
                    break;
                }
            }
            for (; j < times.size(); j++) {
                if ((times.get(j).getStartTime() + "——" + times.get(j).getEndTime()).equals(time)) {
                    break;
                }
            }
            if (arrays[i][j] == null) {
                arrays[i][j] = new ArrayList<>();
            }
            arrays[i][j].add(array);
        }
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("考试安排");
        Font headerFont = wb.createFont();
        headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        HSSFCellStyle headerStyle = wb.createCellStyle();
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        headerStyle.cloneStyleFrom(cellStyle);
        headerStyle.setFont(headerFont);
        sheet.setDefaultRowHeightInPoints(20);
        sheet.setDefaultColumnWidth(40 * 256);
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        sheet.createRow(0).createCell(0).setCellStyle(headerStyle);
        sheet.getRow(0).getCell(0).setCellValue("时间");
        sheet.createRow(1);
        for (int i = 0; i < dates.size(); i++) {
            CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, i * 4 + 1, i * 4 + 4);
            RegionUtil.setBorderBottom(1, cellRangeAddress, sheet, wb);//合并单元格设置下边框
            RegionUtil.setBorderLeft(1, cellRangeAddress, sheet, wb);//合并单元格设置左边框
            RegionUtil.setBorderRight(1, cellRangeAddress, sheet, wb);//合并单元格设置右边框
            RegionUtil.setBorderTop(1, cellRangeAddress, sheet, wb);//合并单元格设置上边框
            sheet.addMergedRegion(cellRangeAddress);
            sheet.getRow(0).createCell(i * 4 + 1).setCellValue(dates.get(i));
            sheet.getRow(0).getCell(i * 4 + 1).setCellStyle(headerStyle);
            sheet.getRow(1).createCell(i * 4 + 1).setCellValue("考场");
            sheet.getRow(1).getCell(i * 4 + 1).setCellStyle(headerStyle);
            sheet.getRow(1).createCell(i * 4 + 2).setCellValue("科目");
            sheet.getRow(1).getCell(i * 4 + 2).setCellStyle(headerStyle);
            sheet.getRow(1).createCell(i * 4 + 3).setCellValue("班级");
            sheet.getRow(1).getCell(i * 4 + 3).setCellStyle(headerStyle);
            sheet.getRow(1).createCell(i * 4 + 4).setCellValue("监考");
            sheet.getRow(1).getCell(i * 4 + 4).setCellStyle(headerStyle);
        }
        for (int i = 0; i < arrays.length; i++) {
            int a = 2;
            for (int j = 0; j < arrays[i].length; j++) {
                if (arrays[i][j] != null) {
                    for (ExamArray examArray : arrays[i][j]) {
                        HSSFRow row = sheet.getRow(a);
                        if (row == null) {
                            row = sheet.createRow(a);
                        }
                        row.createCell(0).setCellValue(examArray.getStartTime() + "——" + examArray.getEndTime());
                        row.getCell(0).setCellStyle(cellStyle);
                        row.createCell(i * 4 + 1).setCellValue(examArray.getRoomShow());
                        row.getCell(i * 4 + 1).setCellStyle(cellStyle);
                        row.createCell(i * 4 + 2).setCellValue(examArray.getCourseShow());
                        row.getCell(i * 4 + 2).setCellStyle(cellStyle);
                        row.createCell(i * 4 + 3).setCellValue(examArray.getClassShow());
                        row.getCell(i * 4 + 3).setCellStyle(cellStyle);
                        row.createCell(i * 4 + 4).setCellValue(examArray.getTeacherPersonShow());
                        row.getCell(i * 4 + 4).setCellStyle(cellStyle);
                        a++;
                    }
                }
            }
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("考试时间安排.xls", "utf-8"));
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

    //导出学生考试时间安排结果
    @RequestMapping("/exam/export/studentResult")
    public void exportStudentResult(String examId, HttpServletResponse response) {
        ExamArrayStudent examArrayStudent = new ExamArrayStudent();
        examArrayStudent.setExamId(examId);
        List<ExamArrayStudent> studentArrays = examService.getStudentArrayList(examArrayStudent);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("学生考试安排结果");
        Font headerFont = wb.createFont();
        headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        HSSFCellStyle headerStyle = wb.createCellStyle();
        headerStyle.cloneStyleFrom(cellStyle);
        headerStyle.setFont(headerFont);
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(2, 30 * 256);
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(4, 30 * 256);
        sheet.setColumnWidth(6, 30 * 256);
        sheet.setColumnWidth(7, 30 * 256);
        sheet.setColumnWidth(8, 30 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("考试科目");
        row.createCell(1).setCellValue("教室");
        row.createCell(2).setCellValue("系部");
        row.createCell(3).setCellValue("专业");
        row.createCell(4).setCellValue("班级");
        row.createCell(5).setCellValue("学生");
        row.createCell(6).setCellValue("日期");
        row.createCell(7).setCellValue("考试开始时间");
        row.createCell(8).setCellValue("考试结束时间");
        row.getCell(0).setCellStyle(headerStyle);
        row.getCell(1).setCellStyle(headerStyle);
        row.getCell(2).setCellStyle(headerStyle);
        row.getCell(3).setCellStyle(headerStyle);
        row.getCell(4).setCellStyle(headerStyle);
        row.getCell(5).setCellStyle(headerStyle);
        row.getCell(6).setCellStyle(headerStyle);
        row.getCell(7).setCellStyle(headerStyle);
        row.getCell(8).setCellStyle(headerStyle);
        tmp++;

        for (ExamArrayStudent arraytobj : studentArrays) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
            HSSFRow.createCell(0).setCellValue(arraytobj.getCourseShow());
            HSSFRow.createCell(1).setCellValue(arraytobj.getRoomName());
            HSSFRow.createCell(2).setCellValue(arraytobj.getDepartmentShow());
            HSSFRow.createCell(3).setCellValue(arraytobj.getMajorShow());
            HSSFRow.createCell(4).setCellValue(arraytobj.getClassShow());
            HSSFRow.createCell(5).setCellValue(arraytobj.getStudentName());
            HSSFRow.createCell(6).setCellValue(arraytobj.getDate());
            HSSFRow.createCell(7).setCellValue(arraytobj.getStartTime());
            HSSFRow.createCell(8).setCellValue(arraytobj.getEndTime());
            HSSFRow.getCell(0).setCellStyle(cellStyle);
            HSSFRow.getCell(1).setCellStyle(cellStyle);
            HSSFRow.getCell(2).setCellStyle(cellStyle);
            HSSFRow.getCell(3).setCellStyle(cellStyle);
            HSSFRow.getCell(4).setCellStyle(cellStyle);
            HSSFRow.getCell(5).setCellStyle(cellStyle);
            HSSFRow.getCell(6).setCellStyle(cellStyle);
            HSSFRow.getCell(7).setCellStyle(cellStyle);
            HSSFRow.getCell(8).setCellStyle(cellStyle);
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("学生考试安排结果.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //删除考试安排
    @ResponseBody
    @RequestMapping("/exam/array/del")
    public Message delExamArray(String id) {
        examService.delExamArrayById(id);
        return new Message(0, "删除成功！", null);
    }

    //删除学生考试安排
    @ResponseBody
    @RequestMapping("/exam/array/student/del")
    public Message delExamArrayStudent(String id) {
        examService.delExamArrayStudentById(id);
        return new Message(0, "删除成功！", null);
    }

    //学生查询
    @RequestMapping("/exam/personal/student")
    public String toPersonalStudent() {
        return "/business/educational/exam/toPersonalStudent";
    }

    //教师查询
    @RequestMapping("/exam/personal/teacher")
    public String toPersonalTeacher() {
        return "/business/educational/exam/toPersonalTeacher";
    }

    //学生查询列表页
    @RequestMapping("/exam/personal/student/result")
    public ModelAndView searchPersonalStudent(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/personalStudent");
        return mv;
    }

    //教师查询列表页
    @RequestMapping("/exam/personal/teacher/result")
    public ModelAndView searchPersonalTeacher(String examId, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/personalTeacher");
        return mv;
    }

    //教师个人查询列表
    @ResponseBody
    @RequestMapping("/exam/array/personal/teacher/getTeacherArrayList")
    public Map<String, List> getPersonalTeacherArray(ExamArray examArray, String examId) {
        examArray.setTeacherPersonId(CommonUtil.getPersonId());
        examArray.setExamId(examId);
        if ("undefined".equals(examArray.getTrainingLevel()) || "".equals(examArray.getTrainingLevel())) {
            examArray.setTrainingLevel(null);
        }
        if ("undefined".equals(examArray.getMajorCode()) || "".equals(examArray.getMajorCode())) {
            examArray.setMajorCode(null);
        }
        if ("undefined".equals(examArray.getCourseId()) || "".equals(examArray.getCourseId())) {
            examArray.setCourseId(null);
        }
        return CommonUtil.tableMap(examService.getTeacherArrayList(examArray));
    }

    //学生个人查询列表
    @ResponseBody
    @RequestMapping("/exam/array/personal/student/getStudentArrayList")
    public Map<String, List> getPersonalStudentArray(ExamArrayStudent examArrayStudent, String examId) {
        examArrayStudent.setStudentId(CommonUtil.getPersonId());
        examArrayStudent.setExamId(examId);
        return CommonUtil.tableMap(examService.getStudentArrayList(examArrayStudent));
    }

    /**
     * 获取容纳人数
     */
    @ResponseBody
    @RequestMapping("/exam/getPeopleNumber")
    public Classroom getPeopleNumber(String roomId) {
        String[] strings = roomId.split(",");
        return examService.getPeopleNumber(strings[0]);
    }

    /**
     * 设置考场内的考试班级
     */
    @RequestMapping("/exam/class/toAddExamRoomClass")
    public ModelAndView toAddExamClass(String examId, String examRoomId, String roomId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addExamRoomClass");
        mv.addObject("examId", examId);
        mv.addObject("examRoomId", examRoomId);
        mv.addObject("roomId", roomId);
        return mv;
    }

    /**
     * 班级树
     *
     * @param examRoomId
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/class/getRoomClassTreeForExam")
    public Map<String, List> getRoomClassTreeForExam(String examRoomId, String roomId) {
        ExamClass examClass = new ExamClass();
        examClass.setExamRoomId(examRoomId);
        examClass.setRoomId(roomId);
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = examService.getExamRoomClassTree();
        List<ExamClass> selectedClassList = examService.getSelectedClassByExamRoomId(examClass);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        map.put("selected", selectedClassList);
        return map;
    }

    /**
     * 保存场地中设置的班级
     */
    @ResponseBody
    @RequestMapping("/exam/class/saveExamRoomClass")
    public Message saveExamRoomClass(String ids, String examRoomId, String examId, String roomId) {
        ExamClass examClass1 = new ExamClass();
        examClass1.setExamRoomId(examRoomId);
        examClass1.setRoomId(roomId);
        examClass1.setExamId(examId);
        examService.deleteOriginalExamClass(examClass1);
        String dept_id = "";
        String class_id = "";
        String majorCode = "";
        ExamClass examClass = new ExamClass();
        examClass.setRoomId(roomId);
        //选中的系部
        List<Dept> deptList = examService.chooseDeptList(ids);
        int count = 0;
        if (deptList.size() > 0) {
            for (int a = 0; a < deptList.size(); a++) {
                dept_id = deptList.get(a).getDeptId();
                examClass.setDepartmentsId(dept_id);
                examClass.setExamRoomId(examRoomId);
                List<Major> majorList = examService.chooseMajorList(dept_id, ids);
                //选中的人员
                if (majorList.size() > 0) {
                    for (int b = 0; b < majorList.size(); b++) {
                        majorCode = majorList.get(b).getMajorCode();
                        examClass.setMajorCode(majorCode);
                        List<ClassBean> empList = examService.chooseClassList(majorCode, ids);
                        if (empList.size() > 0) {
                            for (int c = 0; c < empList.size(); c++) {
                                class_id = empList.get(c).getClassId();
                                examClass.setClassId(class_id);
                                examClass.setId(CommonUtil.getUUID());
                                examClass.setExamId(examId);
                                CommonUtil.save(examClass);
                                examService.insertExamClass(examClass);
                                count++;
                            }
                        }
                    }
                }
            }
        }
        if (count > 0) {
            return new Message(1, "保存成功！", null);
        } else {
            return new Message(0, "保存失败！", null);
        }

    }

    //设置考试科目
    @RequestMapping("/exam/course/setExamCourse1")
    public ModelAndView setExamCourse1(String id, String examId, String startTime, String endTime, String examName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("start", startTime);
        mv.addObject("examId", examId);
        mv.addObject("end", endTime);
        mv.addObject("examName", examName);
        mv.setViewName("/business/educational/exam/courseList1");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/course/getExamCourseAllList")
    public Map<String, List<ExamCourse>> getExamCourseAllList(ExamCourse examCourse, String examId, String roomId) {
        examCourse.setExamId(examId);
        examCourse.setRoomId(roomId);
        Map<String, List<ExamCourse>> scoreClassMap = new HashMap<String, List<ExamCourse>>();
        if ("undefined".equals(examCourse.getTrainingLevel()) || "".equals(examCourse.getTrainingLevel())) {
            examCourse.setTrainingLevel(null);
        }
        if ("undefined".equals(examCourse.getMajorCode()) || "".equals(examCourse.getMajorCode())) {
            examCourse.setMajorCode(null);
        }
        if ("undefined".equals(examCourse.getCourseId()) || "".equals(examCourse.getCourseId())) {
            examCourse.setCourseId(null);
        }
        scoreClassMap.put("data", examService.getExamCourseList(examCourse));
        return scoreClassMap;
    }

    /**
     * 设置监考教师数据
     *
     * @param ExamArray
     * @param examId
     * @param roomId
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/course/getExamCourseRoomTeacherList")
    public Map<String, List<ExamArray>> getExamCourseRoomTeacherList(ExamArray ExamArray, String examId, String roomId, String roomShow) {
        ExamArray.setExamId(examId);
        ExamArray.setRoomId(roomId);
        ExamArray.setRoomShow(roomShow);
        Map<String, List<ExamArray>> scoreClassMap = new HashMap<>();
        if ("undefined".equals(ExamArray.getTrainingLevel()) || "".equals(ExamArray.getTrainingLevel())) {
            ExamArray.setTrainingLevel(null);
        }
        if ("undefined".equals(ExamArray.getMajorCode()) || "".equals(ExamArray.getMajorCode())) {
            ExamArray.setMajorCode(null);
        }
        if ("undefined".equals(ExamArray.getCourseId()) || "".equals(ExamArray.getCourseId())) {
            ExamArray.setCourseId(null);
        }
        scoreClassMap.put("data", examService.getExamCourseRoomTeacherList(ExamArray));
        return scoreClassMap;
    }

    /**
     * 获取考场中的班级
     */
    @ResponseBody
    @RequestMapping("/exam/getClassIdByRoom")
    public ExamClass getClassIdByRoom(String roomId, String examId) {
        ExamClass examClass = new ExamClass();
        examClass.setExamRoomId(roomId);
        examClass.setExamId(examId);
        List<String> list = examService.getClassIdByRoom(examClass);

        String classid = "";
        for (String clas : list) {
            classid += clas + ",";
        }
        if (classid.endsWith(",")) {
            String s1 = classid.substring(0, classid.lastIndexOf(","));
            classid = s1 + " ";
        }
        ExamClass examClass1 = new ExamClass();
        examClass1.setClassId(classid);
        return examClass1;

    }

    /**
     * 获取考场类型
     *
     * @param roomId
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/getRoomTypeByExamRoomId")
    public ExamClass getRoomTypeByExamRoomId(String roomId) {
        String roomType = examService.getRoomTypeByExamRoomId(roomId);
        ExamClass examClass = new ExamClass();
        examClass.setRoomType(roomType);
        return examClass;

    }

    /**
     * 选择考试课程
     *
     * @param examId
     * @param examRoomId
     * @return
     */
    @RequestMapping("/exam/course/toAddExamRoomCourse")
    public ModelAndView toAddExamRoomCourse(String examId, String examRoomId, String examCourseId, String roomId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addExamRoomCourse");
        mv.addObject("examId", examId);
        mv.addObject("examCourseId", examCourseId);
        mv.addObject("examRoomId", examRoomId);
        mv.addObject("roomId", roomId);
        return mv;
    }

    /**
     * 保存选中的课程
     */
    @ResponseBody
    @RequestMapping("/exam/course/saveExamRoomCourse")
    public Message saveExamRoomCourse(String ids, String examId, String examRoomId, String roomId) {
        ExamCourse examCourse1 = new ExamCourse();
        examCourse1.setRoomId(roomId);
        examCourse1.setExamRoomId(examRoomId);
        examService.deleteOriginalExamCourse(examCourse1);
        String dept_id = "";
        String course_id = "";
        String majorCode = "";
        ExamCourse examCourse = new ExamCourse();
        examCourse.setRoomId(roomId);
        examCourse.setExamRoomId(examRoomId);
        //选中的系部
        List<Dept> deptList = examService.chooseDeptList(ids);
        Integer count = 0;
        if (deptList.size() > 0) {
            for (int a = 0; a < deptList.size(); a++) {
                dept_id = deptList.get(a).getDeptId();
                examCourse.setDepartmentsId(dept_id);
                List<Major> majorList = examService.chooseMajorList(dept_id, ids);
                //选中的专业
                if (majorList.size() > 0) {
                    for (int b = 0; b < majorList.size(); b++) {
                        majorCode = majorList.get(b).getMajorCode();
                        examCourse.setMajorCode(majorCode);
                        List<Course> empList = examService.chooseCourseList(majorCode, ids);
                        if (empList.size() > 0) {
                            for (int c = 0; c < empList.size(); c++) {
                                course_id = empList.get(c).getCourseId();
                                examCourse.setCourseId(course_id);
                                examCourse.setExamCourseId(CommonUtil.getUUID());
                                examCourse.setExamId(examId);
                                CommonUtil.save(examCourse);
                                examService.insertExamCourse(examCourse);
                                count++;
                            }
                        }
                    }
                }
            }
        }
        if (count > 0) {
            return new Message(1, "保存成功！", null);
        } else {
            return new Message(1, "保存失败！", null);
        }
    }

    /**
     * 课程树
     *
     * @param roomId
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/course/getExamCourseClassTree")
    public Map<String, List> getExamCourseClassTree(String roomId, String courseId, String examRoomId, String examId, String examCourseId) {
        ExamCourse examCourse = new ExamCourse();
        examCourse.setExamRoomId(examRoomId);
        examCourse.setRoomId(roomId);
        examCourse.setExamId(examId);
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = examService.getExamCourseClassTree(examCourse);
        ExamCourse examCourse1 = new ExamCourse();
        examCourse1.setCourseId(courseId);
        examCourse1.setExamCourseId(examCourseId);
        examCourse1.setExamRoomId(examRoomId);
        examCourse1.setExamId(examId);
        examCourse1.setRoomId(roomId);
        List<ExamCourse> selectedExamCourseList = examService.getSelectedCourseByExamRoomId(examCourse);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        map.put("selected", selectedExamCourseList);
        return map;
    }


    /**
     * 设置考试科目页面跳转
     *
     * @param examId
     * @param examRoomId
     * @param examName
     * @param roomName
     * @return
     */
    @RequestMapping("/exam/course/toCourse")
    public ModelAndView toCourse(String examId, String examRoomId, String examName, String roomName, String roomId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addCourse");
        mv.addObject("examId", examId);
        mv.addObject("examRoomId", examRoomId);
        mv.addObject("examName", examName);
        mv.addObject("roomName", roomName);
        mv.addObject("roomId", roomId);
        return mv;
    }

    /**
     * 判断考场内是否有班级
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/room/getExamRoomClass")
    public Boolean getExamRoomClassByExamRoomId(String examRoomId, String examId) {
        ExamRoom examRoom = new ExamRoom();
        examRoom.setExamId(examId);
        examRoom.setExamRoomId(examRoomId);
        List<ExamClass> list = examService.getExamClassByExamRoom(examRoom);
        if (list.size() > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 课程选择班级
     *
     * @param examId
     * @param examRoomId
     * @return
     */
    @RequestMapping("/exam/course/class/toAddExamRoomCourseExamClass")
    public ModelAndView toAddExamRoomCourseExamClass(String examId, String examRoomId, String examCourseId, String roomId, String courseId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/addExamRoomCourseExamClass");
        mv.addObject("examId", examId);
        mv.addObject("examCourseId", examCourseId);
        mv.addObject("examRoomId", examRoomId);
        mv.addObject("roomId", roomId);
        mv.addObject("courseId", courseId);
        return mv;
    }

    /**
     * 课程班级树
     *
     * @param roomId
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/course/class/getExamCourseExamClassTree")
    public Map<String, List> getExamCourseExamClassTree(String roomId, String courseId, String examRoomId, String examId, String examCourseId) {
        ExamCourseClass examCourseClass = new ExamCourseClass();
        examCourseClass.setExamRoomId(examRoomId);
        examCourseClass.setRoomId(roomId);
        examCourseClass.setExamId(examId);
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = examService.getExamCourseExamClassTree(examCourseClass);
        ExamCourseClass examCourseClass1 = new ExamCourseClass();
        examCourseClass1.setCourseId(courseId);
        examCourseClass1.setExamCourseId(examCourseId);
        examCourseClass1.setExamRoomId(examRoomId);
        examCourseClass1.setExamId(examId);
        examCourseClass1.setRoomId(roomId);
        List<ExamCourseClass> selectedExamCourseClassList = examService.getSelectedClassByExamCourseClass(examCourseClass1);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        map.put("selected", selectedExamCourseClassList);
        return map;
    }

    /**
     * 保存课程对应的考试班级
     */
    @ResponseBody
    @RequestMapping("/exam/course/class/saveExamRoomExamCourse")
    public Message saveExamRoomExamCourse(String ids, String examId, String examRoomId, String roomId, String examCourseId, String courseId, String classId) {
        ExamCourseClass examCourseClass1 = new ExamCourseClass();
        examCourseClass1.setRoomId(roomId);
        examCourseClass1.setExamRoomId(examRoomId);
        examCourseClass1.setExamId(examId);
        examCourseClass1.setExamCourseId(examCourseId);
        examService.deleteOriginalExamCourseExamClass(examCourseClass1);
        String dept_id = "";
        String course_id = "";
        String majorCode = "";
        ExamCourseClass examCourseClass = new ExamCourseClass();
        examCourseClass.setRoomId(roomId);
        examCourseClass.setExamRoomId(examRoomId);
        //选中的系部
        List<Dept> deptList = examService.chooseDeptList(ids);
        Integer count = 0;
        if (deptList.size() > 0) {
            for (int a = 0; a < deptList.size(); a++) {
                dept_id = deptList.get(a).getDeptId();
                examCourseClass.setDepartmentsId(dept_id);
                List<Major> majorList = examService.chooseMajorList(dept_id, ids);
                //选中的专业
                if (majorList.size() > 0) {
                    for (int b = 0; b < majorList.size(); b++) {
                        majorCode = majorList.get(b).getMajorCode();
                        examCourseClass.setMajorCode(majorCode);
                        List<ClassBean> empList = examService.chooseCourseClassList(majorCode, ids);
                        if (empList.size() > 0) {
                            for (int c = 0; c < empList.size(); c++) {
                                course_id = empList.get(c).getClassId();
                                examCourseClass.setClassId(course_id);
                                examCourseClass.setCourseId(courseId);
                                examCourseClass.setExamCourseId(examCourseId);
                                examCourseClass.setExamId(examId);
                                examCourseClass.setExamRoomId(examRoomId);
                                CommonUtil.save(examCourseClass);
                                examService.insertExamCourseExamClass(examCourseClass);
                                count++;
                            }
                        }
                    }
                }
            }
        }
        if (count > 0) {
            return new Message(1, "保存成功！", null);
        } else {
            return new Message(1, "保存失败！", null);
        }
    }

    /**
     * 批量设置考试时间
     * by fn 20180424
     */
    @RequestMapping("/exam/course/editExamCourseTime")
    public String editExamCourseTime(String ids, Model model) {
        List<ExamCourse> examCourseList = examService.getExamCourseByIds(ids.substring(0, ids.length() - 2));
        String examId = "";
        String examRoomId = "";
        for (ExamCourse examCourse : examCourseList) {
            examId = examCourse.getExamId();
            examRoomId = examCourse.getExamRoomId();
        }
        model.addAttribute("head", "科目考试时间设置");
        model.addAttribute("ids", ids.replaceAll("'", ""));
        model.addAttribute("examId", examId);
        model.addAttribute("examRoomId", examRoomId);

        return "/business/educational/exam/editExamCourseTime";
    }

    /**
     * 批量设置考试时间保存
     * by fn 20180424
     */
    @ResponseBody
    @RequestMapping("/exam/course/saveExamCourseTime")
    public Message changePartyRoles(ExamCourse examCourse) {
        String ids = examCourse.getIds();
        String[] tmp = ids.split(",");
        examCourse.setChanger(CommonUtil.getPersonId());
        examCourse.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        for (String id : tmp) {
            examCourse.setExamCourseId(id);
            examService.saveExamCourseTime(examCourse);
        }
        return new Message(1, "保存成功！", null);
    }

    /**
     * 设置监考教师
     */
    @RequestMapping("/exam/teacher/toAddExamRoomTeacher")
    public ModelAndView toAddExamRoomTeacher(String examId, String examRoomId, String examName, String roomName, String roomId) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/examRoomTeacher");
        mv.addObject("examId", examId);
        mv.addObject("examRoomId", examRoomId);
        mv.addObject("examName", examName);
        mv.addObject("roomId", roomId);
        return mv;
    }

    /**
     * 校验考试场地中是否有考试科目
     *
     * @param examRoom
     * @return
     */
    @ResponseBody
    @RequestMapping("/exam/room/getExamRoomCourseList")
    public Boolean changePartyRoles(ExamRoom examRoom) {
        List<ExamCourse> list = examService.getExamCourseByExamRoom(examRoom);
        if (list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 考试成绩查询
     *
     * @param
     * @return
     */
    @RequestMapping("/exam/personal/testScoreSearch")
    public String testScoreSearch() {
        return "/business/educational/exam/testScoreSearch";
    }

    @ResponseBody
    @RequestMapping("/exam/student/saveStatus")
    public Message saveStatus(String id, String status) {
        examService.saveStatus(id, status);
        return new Message(1, "修改成功！", null);
    }


    @RequestMapping("/exam/toSetTeacher")
    public ModelAndView toSetTeacher(String id) {
        ModelAndView mv = new ModelAndView("business/educational/exam/selectEmp");
        mv.addObject("id", id);
        return mv;
    }

    @Autowired
    private CommonService commonService;

    @ResponseBody
    @RequestMapping("/exam/getEmpsTree")
    public List<Tree> getEmpsTree(String id) {
        List<Tree> tree = commonService.getEmpTree();
        List<Tree> selected = examService.getEmpsTree(id);
        for (Tree emp : tree) {
            for (Tree selectedEmp : selected) {
                if (emp.getId().equals(selectedEmp.getId())) {
                    emp.setChecked(true);
                }
            }
        }
        return tree;
    }

    @ResponseBody
    @RequestMapping("/exam/saveEmps")
    public Message saveEmps(String id, String ids) {
        examService.deleteExamTeacherByExamId(id);
        String[] emps = ids.split(";");
        for (String emp : emps) {
            String[] strs = emp.split(",");
            ExamTeacher examTeacher = new ExamTeacher();
            examTeacher.setExamId(id);
            examTeacher.setTeacherPersonId(strs[0]);
            examTeacher.setTeacherDeptId(strs[1]);
            examService.saveEmps(examTeacher);
        }
        return new Message(1, "添加成功！", null);
    }

    @RequestMapping("/exam/makeup/makeupExamPlan")
    public ModelAndView makeupExamPlan() {
        return new ModelAndView("/business/educational/exam/makeuoExamPlan");
    }

    @RequestMapping("/exam/toExamStudentList")
    public ModelAndView toExamStudentList(String examId, String examName, String examTypes,String termId) {
        ModelAndView mv = new ModelAndView("business/educational/exam/examStudentList");
        mv.addObject("examId", examId);
        mv.addObject("examName", examName);
        mv.addObject("examTypes", examTypes);
        mv.addObject("termId", termId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/getStudentList")
    public Map<String, List> getStudentList(ExamStudent examStudent) {
        String majorCode = examStudent.getMajorCode();
        if (majorCode != null && !"".equals(majorCode) && majorCode.contains(",")) {
            examStudent.setMajorCode(majorCode.split(",")[0]);
            examStudent.setTrainingLevel(majorCode.split(",")[1]);
        }
        return CommonUtil.tableMap(examService.getStudents(examStudent));
    }

    @ResponseBody
    @RequestMapping("/exam/delExamStudent")
    public Message delExamStudent(String id) {
        examService.delExamStudentById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/toEditExamStudent")
    public ModelAndView toEditExamStudent(String id, String examId, String examTypes, String courseId, String termId) {
        ModelAndView mv = new ModelAndView("business/educational/exam/editExamStudent");
        if (id != null && !"".equals(id)) {
            ExamStudent examStudent = examService.getStudentById(id, examId, courseId);
            mv.addObject("data", examStudent);
        }
        mv.addObject("id", examId);
        mv.addObject("examTypes", examTypes);
        mv.addObject("termId", termId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/updateExamStudent")
    public Message updateExamStudent(ExamStudent examStudent) {
        String majorCode = examStudent.getMajorCode();
        examStudent.setMajorCode(majorCode.split(",")[0]);
        examStudent.setTrainingLevel(majorCode.split(",")[1]);
        List<ExamStudent> examStudents = examService.getExamStudentByStudentIdAndCourseIdAndTerm(examStudent.getStudentId(), examStudent.getCourseId(), examStudent.getExamId(),
                examStudent.getTerm(), examService.selectExamById(examStudent.getExamId()).getExamTypes());
        List<ExamCourseClass> courseClasses = examService.getExamCourseClassByClassIdAndCourseId(examStudent.getClassId(), examStudent.getCourseId(), examStudent.getExamId());
        if (courseClasses.size() == 0) {
            ExamCourseClass examCourseClass = new ExamCourseClass();
            examCourseClass.setExamId(examStudent.getExamId());
            examCourseClass.setDepartmentsId(examStudent.getDepartmentsId());
            examCourseClass.setMajorCode(examStudent.getMajorCode());
            examCourseClass.setTrainingLevel(examStudent.getTrainingLevel());
            examCourseClass.setClassId(examStudent.getClassId());
            examCourseClass.setCourseId(examStudent.getCourseId());
            examCourseClass.setExamType(examStudent.getExamTypes());
            examCourseClass.setExamMethod(examStudent.getExamMethod());
            examService.insertExamCourseClass(examCourseClass);
        }
        if (examStudent.getId() != null && !"".equals(examStudent.getId())) {
            examService.updateExamCourseStudent(examStudent);
            return new Message(1, "修改成功！", null);
        } else {
            if (examStudents.size() > 0) {
                return new Message(1, "不能重复添加！", null);
            }
            examService.insertExamCourseStudent(examStudent);
            return new Message(1, "新增成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/eaxm/getTeacher")
    public List<Select2> getTeacher(String id, String examId) {
        return examService.getTeachers(id, examId);
    }

    @ResponseBody
    @RequestMapping("/eaxm/updateTeacher")
    public Message updateTeacher(String id, String teacherId) {
        examService.updateTeacher(id, teacherId.split(",")[0], teacherId.split(",")[1]);
        return new Message(1, "操作成功！", null);
    }

    @ResponseBody
    @RequestMapping("/eaxm/getRoom")
    public List<Select2> getRoom(String id, String examId) {
//        return examService.getRooms(id, examId);
        return examService.getRoomsByExamId(examId);
    }

    @ResponseBody
    @RequestMapping("/eaxm/updateStudentRoom")
    public Message updateStudentRoom(String id, String roomId) {
        examService.updateStudentRoom(id, roomId);
        return new Message(1, "操作成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/getExamTree")
    public List<Tree> getExamTree(String examId) {
        return examService.getExamTree(examId);
    }

    @ResponseBody
    @RequestMapping("/eaxm/importStudent")
    public Message importStudent(String examId, String examIds, String examTypes) {
        examService.deleteExamStudentByExamId(examId);
        examService.deleteExamCourseClassByExamId(examId);
//        int i = examService.importStudent(examId, examIds.replaceAll(",", "','"), examTypes);
        int i = examService.importStudent(examId, examIds, examTypes);
        if (i > 0) {
            int a = examService.importClassDataByStudent(examId);
        }
        return new Message(1, "操作成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/toExaminationExamList")
    public ModelAndView toExaminationExamList() {
        return new ModelAndView("business/educational/exam/cxaminationExamList");
    }

    /**
     * 设置巡考教师
     */
    @ResponseBody
    @RequestMapping("/exam/toExaminationList")
    public ModelAndView toExaminationList(String id, String examName) {
        ModelAndView view = new ModelAndView("business/educational/exam/examinationList");
        view.addObject("examId", id);
        view.addObject("examName", examName);
        return view;
    }

    /**
     * 设置巡考教师数据
     */
    @ResponseBody
    @RequestMapping("/exam/getExaminationTeacherList")
    public Map<String, List<ExamArray>> getExaminationTeacherList(ExamArray examArray) {
        Map<String, List<ExamArray>> scoreClassMap = new HashMap<>();
        scoreClassMap.put("data", examService.getExaminationList(examArray));
        return scoreClassMap;
    }

    /**
     * 新增修改页
     */
    @ResponseBody
    @RequestMapping("/exam/toEditExamination")
    public ModelAndView toEditExamination(String id, String examId) {
        ModelAndView mv = new ModelAndView("business/educational/exam/editExamination");
        List<String> select = examService.getEdate(examId);
        String edate = "";
        if (id != null && !"".equals(id)) {
            ExamArray examArray = examService.getExaminationById(id);
            edate = examArray.getExamDate();
            mv.addObject("examArray", examArray);
        }
        List<Select2> select2s = new ArrayList<>();
        for (String s : select) {
            Select2 select2 = new Select2();
            select2.setId(s);
            select2.setText(s);
            select2s.add(select2);
        }
        mv.addObject("select", JsonUtils.toJson(select2s));
        mv.addObject("edate", edate);
        mv.addObject("examId", examId);
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/exam/delExamination")
    public Message delExamination(String id) {
        examService.delExamination(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/exam/saveExamination")
    public Message saveExamination(ExamArray examArray) {
        if (examArray.getId() != null && !"".equals(examArray.getId())) {
            examArray.setChanger(CommonUtil.getPersonId());
            examArray.setChangeDept(CommonUtil.getDefaultDept());
            examService.updateExamination(examArray);
            return new Message(1, "修改成功！", null);
        } else {
            examArray.setCreator(CommonUtil.getPersonId());
            examArray.setChangeDept(CommonUtil.getDefaultDept());
            examService.insertExamination(examArray);
            return new Message(1, "新增成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/exam/getExamMethod")
    public String getExamMethod(String courseId,String termId) {
        return examService.getExamMethod(courseId,termId);
    }
}
