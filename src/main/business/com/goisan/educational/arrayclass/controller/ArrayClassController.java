package com.goisan.educational.arrayclass.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.system.bean.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.NumTrans;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ArrayClassController {
    @Resource
    private ArrayClassService arrayClassService;

    //排课计划维护

    @RequestMapping("/arrayClass/request")
    public ModelAndView resultList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/arrayplan/arrayClassList");
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClass/getArrayClassList")
    public Map<String, Object> getArrayClassList(ArrayClass arrayClass, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> arrayClassa = new HashMap();
        arrayClass.setCreator(CommonUtil.getPersonId());
        arrayClass.setCreateDept(CommonUtil.getDefaultDept());
        List<ArrayClass> list =arrayClassService.getArrayClassList(arrayClass);
        PageInfo<List<Emp>> info = new PageInfo(list);
        arrayClassa.put("draw", draw);
        arrayClassa.put("recordsTotal", info.getTotal());
        arrayClassa.put("recordsFiltered", info.getTotal());
        arrayClassa.put("data", list);
        return arrayClassa;
    }

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClass/addArrayClass")
    public ModelAndView addArrayClass(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addArrayClass");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            ArrayClass arrayClass = arrayClassService.getArrayClassById(id);
            mv.addObject("arrayClass", arrayClass);
        }
        return mv;
    }

    //保存
    @ResponseBody
    @RequestMapping("/arrayClass/saveArrayClass")
    public Message insertArrayClass(ArrayClass arrayClass) {
        ArrayClassTime arrayClassTime = new ArrayClassTime();
        String id = arrayClass.getArrayClassId();
        int morning = Integer.parseInt(arrayClass.getMorningHours());
        int fornoonHour = Integer.parseInt(arrayClass.getForenoonHours());
        int noonHour = Integer.parseInt(arrayClass.getNoonHours());
        int afternoonHour = Integer.parseInt(arrayClass.getAfternoonHours());
        int eveningHour = Integer.parseInt(arrayClass.getEveningHours());
        int j = morning + fornoonHour + noonHour + afternoonHour + eveningHour;
        if (arrayClass.getArrayClassId() == null || arrayClass.getArrayClassId().equals("")) {
            String arrayClassId = CommonUtil.getUUID();
            arrayClass.setArrayClassId(arrayClassId);
            arrayClass.setCreator(CommonUtil.getPersonId());
            arrayClass.setCreateDept(CommonUtil.getDefaultDept());
            arrayClassService.insertArrayClass(arrayClass);
            insertTime(arrayClassId, arrayClass, arrayClassTime, morning, fornoonHour, noonHour, afternoonHour);
            return new Message(1, "新增成功！", null);
        } else {
            arrayClassService.deleteArrayClassTimeById(arrayClass.getArrayClassId());
            insertTime(arrayClass.getArrayClassId(), arrayClass, arrayClassTime, morning, fornoonHour, noonHour,
                    afternoonHour);
            arrayClass.setChanger(CommonUtil.getPersonId());
            arrayClass.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClass(arrayClass);
            return new Message(1, "修改成功！", null);
        }
    }

    public void insertTime(String arrayClassId, ArrayClass arrayClass, ArrayClassTime arrayClassTime, int morning,
                           int fornoonHour, int noonHour, int afternoonHour) {
        if (arrayClass.getMorningHours() != null || Integer.parseInt(arrayClass.getMorningHours()) != 0) {
            for (int k = 0; k < Integer.parseInt(arrayClass.getMorningHours()); k++) {
                arrayClassTime.setArrayClassId(arrayClassId);
                arrayClassTime.setHoursType("1");
                arrayClassTime.setHoursName("第" + NumTrans.get(String.valueOf(k + 1)) + "节");
                arrayClassTime.setHoursCode("1" + (k + 1));
                arrayClassTime.setCreator(CommonUtil.getPersonId());
                arrayClassTime.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassTime(arrayClassTime);
            }
        }
        if (arrayClass.getForenoonHours() != null || Integer.parseInt(arrayClass.getForenoonHours()) != 0) {
            for (int k = 0; k < Integer.parseInt(arrayClass.getForenoonHours()); k++) {
                arrayClassTime.setArrayClassId(arrayClassId);
                arrayClassTime.setHoursType("2");
                arrayClassTime.setHoursName("第" + NumTrans.get(String.valueOf(morning + k + 1)) + "节");
                arrayClassTime.setHoursCode("2" + (k + 1));
                arrayClassTime.setCreator(CommonUtil.getPersonId());
                arrayClassTime.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassTime(arrayClassTime);
            }
        }
        if (arrayClass.getNoonHours() != null || Integer.parseInt(arrayClass.getNoonHours()) != 0) {
            for (int k = 0; k < Integer.parseInt(arrayClass.getNoonHours()); k++) {
                arrayClassTime.setArrayClassId(arrayClassId);
                arrayClassTime.setHoursType("3");
                arrayClassTime.setHoursName("第" + NumTrans.get(String.valueOf(morning + fornoonHour + k + 1)) + "节");
                arrayClassTime.setHoursCode("3" + (k + 1));
                arrayClassTime.setCreator(CommonUtil.getPersonId());
                arrayClassTime.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassTime(arrayClassTime);
            }
        }
        if (arrayClass.getAfternoonHours() != null || Integer.parseInt(arrayClass.getAfternoonHours()) != 0) {
            for (int k = 0; k < Integer.parseInt(arrayClass.getAfternoonHours()); k++) {
                arrayClassTime.setArrayClassId(arrayClassId);
                arrayClassTime.setHoursType("4");
                arrayClassTime.setHoursName("第" + NumTrans.get(String.valueOf(morning + noonHour + fornoonHour + k +
                        1)) + "节");
                arrayClassTime.setHoursCode("4" + (k + 1));
                arrayClassTime.setCreator(CommonUtil.getPersonId());
                arrayClassTime.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassTime(arrayClassTime);
            }
        }
        if (arrayClass.getEveningHours() != null || Integer.parseInt(arrayClass.getEveningHours()) != 0) {
            for (int k = 0; k < Integer.parseInt(arrayClass.getEveningHours()); k++) {
                arrayClassTime.setArrayClassId(arrayClassId);
                arrayClassTime.setHoursType("5");
                arrayClassTime.setHoursName("第" + NumTrans.get(String.valueOf(morning + fornoonHour + noonHour +
                        afternoonHour + k + 1)) + "节");
                arrayClassTime.setHoursCode("5" + (k + 1));
                arrayClassTime.setCreator(CommonUtil.getPersonId());
                arrayClassTime.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassTime(arrayClassTime);
            }
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClass/deleteArrayClassById")
    public Message deleteArrayClassById(String id) {
        arrayClassService.deleteArrayClassById(id);
        arrayClassService.deleteArrayClassTimeById(id);
        return new Message(1, "删除成功！", null);
    }

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClass/relateCoursePlanToArrayClass")
    public ModelAndView addCoursePlanForArrayClass(String id, String arrayClassId) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/relateCoursePlan");
        ArrayClassCoursePlan arrayClassCoursePlan = arrayClassService.getArrayClassCoursePlanById(id);
        if (id == "" || id == null) {
            mv.addObject("arrayClassId", arrayClassId);
            mv.addObject("arrayClassCoursePlan", arrayClassCoursePlan);
            mv.addObject("head", "关联教学计划");
        } else {
            mv.addObject("arrayClassId", arrayClassId);
            mv.addObject("arrayClassCoursePlan", arrayClassCoursePlan);
            mv.addObject("head", "修改关联的教学计划");
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/saveArrayClassCoursePlan")
    public Message insertArrayClassCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan) {
        List<ArrayClassCoursePlan> list=arrayClassService.getArrayClassListBySchoolYearTermCoursePlan(arrayClassCoursePlan);
        if (arrayClassCoursePlan.getId() == null || arrayClassCoursePlan.getId().equals("")) {
            arrayClassCoursePlan.setCreator(CommonUtil.getPersonId());
            arrayClassCoursePlan.setCreateDept(CommonUtil.getDefaultDept());
            if(list.size()>0){
                return new Message(1, "关联失败，关联教学计划重复！", null);
            }else{
                arrayClassService.insertArrayClassCoursePlan(arrayClassCoursePlan);
                return new Message(1, "关联成功！", null);
            }
        } else {
            arrayClassCoursePlan.setChanger(CommonUtil.getPersonId());
            arrayClassCoursePlan.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassCoursePlan(arrayClassCoursePlan);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/arrayClass/deleteArrayClassCoursePlanById")
    public Message deleteArrayClassCoursePlan(String id) {
        arrayClassService.deleteArrayClassCoursePlan(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/arrayClassCoursePlan/request")
    public ModelAndView arrayClassCoursePlanList(String arrayClassId, String name) {
        String planId = "";
        int count = 0;
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/arrayClassCoursePlanList");
        List<ArrayClassCoursePlan> arrayClassCoursePlan = arrayClassService.getArrayClassPlan(arrayClassId);
        for (int i = 0; i < arrayClassCoursePlan.size(); i++) {
            planId += arrayClassCoursePlan.get(i).getPlanId() + ",";
        }
        if (arrayClassCoursePlan.size() == 0) {
            planId = "";
            count = 0;
        } else {
            planId = planId.substring(0, planId.length() - 1);
            count = arrayClassCoursePlan.size();
        }
        mv.addObject("count", count);
        mv.addObject("planId", planId);
        mv.addObject("arrayClassId", arrayClassId);
        mv.addObject("name", name);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/exportCoursePlanForArrayClass")
    public Message exportCoursePlanForArrayClass(ArrayClassCoursePlan arrayClassCoursePlan, String arrayClassId,
                                                 String arr_planId) {
        ArrayClassClass arrayClassClass = new ArrayClassClass();
        ArrayClassCourse arrayClassCourse = new ArrayClassCourse();
        ArrayClassCourse arrayClassCoursePublic = new ArrayClassCourse();
        ArrayClassTeacher arrayClassTeacher = new ArrayClassTeacher();
        ArrayClassTeacherCourse arrayClassTeacherCourse = new ArrayClassTeacherCourse();
        ArrayClassTeacherCourse arrayClassTeacherCoursePublic = new ArrayClassTeacherCourse();
        ArrayClassRoom arrayClassRoom = new ArrayClassRoom();
        ArrayclassResultClass arrayclassResultClass = new ArrayclassResultClass();
        ArrayclassArray arrayclassArray = new ArrayclassArray();
        arrayclassResultClass.setCreator(CommonUtil.getPersonId());
        arrayClassTeacherCoursePublic.setCreator(CommonUtil.getPersonId());
        arrayClassTeacherCoursePublic.setArrayclassId(arrayClassId);
        arrayClassTeacherCoursePublic.setCreateDept(CommonUtil.getDefaultDept());
        arrayclassArray.setArrayclassId(arrayClassId);
        arrayClassClass.setArrayclassId(arrayClassId);
        arrayClassCourse.setArrayClassId(arrayClassId);
        arrayClassRoom.setArrayClassId(arrayClassId);
        arrayClassTeacher.setArrayclassId(arrayClassId);
        arrayClassTeacherCourse.setArrayclassId(arrayClassId);
        arrayclassResultClass.setArrayclassId(arrayClassId);
        arrayClassCoursePublic.setArrayClassId(arrayClassId);
        arrayClassRoom.setCreator(CommonUtil.getPersonId());
        arrayclassArray.setCreator(CommonUtil.getPersonId());
        arrayClassClass.setCreator(CommonUtil.getPersonId());
        arrayClassTeacherCourse.setCreator(CommonUtil.getPersonId());
        arrayClassCourse.setCreator(CommonUtil.getPersonId());
        arrayClassCoursePublic.setCreator(CommonUtil.getPersonId());
        arrayClassTeacher.setCreator(CommonUtil.getPersonId());
        arrayClassClass.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassCoursePublic.setCreateDept(CommonUtil.getDefaultDept());
        arrayclassResultClass.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassTeacherCourse.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassCourse.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassTeacher.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassRoom.setCreateDept(CommonUtil.getDefaultDept());
        arrayclassArray.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassService.exportCoursePlan(arrayClassTeacher, arrayClassClass, arrayClassTeacherCourse,
                arrayClassTeacherCoursePublic, arrayClassRoom, arrayClassCourse, arrayClassCoursePublic,
                arrayclassResultClass, arrayclassArray, arr_planId, arrayClassId);
        return new Message(1, "导入成功！", null);
    }

    @ResponseBody
    @RequestMapping("/arrayClass/deleteCoursePlanForArrayClass")
    public Message deleteCoursePlan(String arrayClassId) {
        arrayClassService.deleteCoursePlan(arrayClassId);
        return new Message(1, "删除成功！", null);
    }


    //查询学时时间
    @ResponseBody
    @RequestMapping("/arrayClass/getArrayClassCoursePlanList")
    public Map<String, List<ArrayClassCoursePlan>> getArrayClassCoursePlanList(ArrayClassCoursePlan
                                                                                       arrayClassCoursePlan) {
        Map<String, List<ArrayClassCoursePlan>> resultMap = new HashMap<String, List<ArrayClassCoursePlan>>();
        resultMap.put("data", arrayClassService.getArrayClassCoursePlanList(arrayClassCoursePlan));
        return resultMap;
    }

    @ResponseBody
    @RequestMapping("/arrayClassTime/request")
    public ModelAndView arrayClassTimeList(String arrayClassId, String name) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/arrayClassTimeList");
        mv.addObject("arrayClassId", arrayClassId);
        mv.addObject("name", name);
        return mv;
    }


    //查询学时时间
    @ResponseBody
    @RequestMapping("/arrayClass/getArrayClassTimeList")
    public Map<String, List<ArrayClassTime>> getArrayClassTimeList(ArrayClassTime arrayClassTime) {
        Map<String, List<ArrayClassTime>> resultMap = new HashMap<String, List<ArrayClassTime>>();
        resultMap.put("data", arrayClassService.getArrayClassTimeList(arrayClassTime));
        return resultMap;
    }

    //修改学时时间
    @ResponseBody
    @RequestMapping("/arrayClass/addArrayClassTime")
    public ModelAndView addArrayClassTime(String id, String arrayClassId) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addArrayClassTime");
        mv.addObject("head", "修改");
        ArrayClassTime arrayClassTime = arrayClassService.getArrayClassTimeById(id);
        mv.addObject("arrayClassTime", arrayClassTime);
        mv.addObject("arrayClassId", arrayClassId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/saveArrayClassTime")
    public Message insertArrayClassTime(ArrayClassTime arrayClassTime) throws ParseException {
        Message message = null;
        List<ArrayClassTime> arrayClassTimes = arrayClassService.checkArrayClassTimeList(arrayClassTime);
        String hourName = arrayClassTime.getHoursName();
        String old_hourName = "";
        SimpleDateFormat old_startTime = null;
        SimpleDateFormat old_endTime = null;
        Date start_time = null;
        Date end_time = null;
        SimpleDateFormat startTime = new SimpleDateFormat("HH:mm");
        SimpleDateFormat endTime = new SimpleDateFormat("HH:mm");
        Date start = startTime.parse(arrayClassTime.getStartTime());
        Date end = endTime.parse(arrayClassTime.getEndTime());
        for (int i = 0; i < arrayClassTimes.size(); i++) {
            old_startTime = new SimpleDateFormat("HH:mm");
            old_endTime = new SimpleDateFormat("HH:mm");
            start_time = old_startTime.parse(arrayClassTimes.get(i).getStartTime());
            end_time = old_endTime.parse(arrayClassTimes.get(i).getEndTime());
            if ((start.after(start_time) && start.before(end_time)) ||
                    (end.after(start_time) && end.before(end_time))) {
                old_hourName = arrayClassTimes.get(i).getHoursName();
                if (Integer.parseInt(arrayClassTime.getHoursCode()) < Integer.parseInt(arrayClassTimes.get(i)
                        .getHoursCode())) {
                    return new Message(2, hourName + "时间应在" + old_hourName + "之前！", null);
                }
                return new Message(2, hourName + "时间应在" + old_hourName + "之后！", null);
            }
            if (Integer.parseInt(arrayClassTime.getHoursCode()) < Integer.parseInt(arrayClassTimes.get(i)
                    .getHoursCode())
                    && !((start.after(start_time) && start.before(end_time)) ||
                    (end.after(start_time) && end.before(end_time)))) {
                old_hourName = arrayClassTimes.get(i).getHoursName();
                return new Message(3, hourName + "时间应在" + old_hourName + "之前！", null);
            }
        }
        arrayClassTime.setChanger(CommonUtil.getPersonId());
        arrayClassTime.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        arrayClassService.updateArrayClassTime(arrayClassTime);
        return new Message(1, "修改成功！", null);
    }

    //////////////

    @RequestMapping("/arrayClassCourse")
    public ModelAndView arrayClassCourseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/arrayplan/arrayClassCourseList");
        return mv;
    }

    //排课课程跳转
    @RequestMapping("/arrayClassCourse/request")
    public String toCourseList(String arrayClassId, String term, String arrayClassName, Model model) {
        model.addAttribute("arrayClassId", arrayClassId);
        model.addAttribute("term", term);
        model.addAttribute("arrayClassName", arrayClassName);
        return "/business/educational/arrayclass/arrayplan/courseList";
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassCourse/getArrayClassCourseList")
    public Map<String, List<ArrayClassCourse>> getArrayClassCourseList(ArrayClassCourse arrayClassCourse) {
        Map<String, List<ArrayClassCourse>> resultMap = new HashMap<String, List<ArrayClassCourse>>();
        arrayClassCourse.setCreator(CommonUtil.getPersonId());
        arrayClassCourse.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", arrayClassService.getArrayClassCourseList(arrayClassCourse));
        return resultMap;
    }

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClassCourse/addArrayClassCourse")
    public ModelAndView addArrayClassCourse(String id, String arrayClassId, String term) {
        if (id == "" || id == null) {
            ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addCourse");
            mv.addObject("arrayClassId", arrayClassId);
            mv.addObject("term", term);
            mv.addObject("head", "新增");
            return mv;
        } else {
            String  courseType =arrayClassService.getCourseTypeById(id);
            if("1".equals(courseType)){
                ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addCourseCourseType");
                mv.addObject("arrayClassId", arrayClassId);
                mv.addObject("term", term);
                mv.addObject("head", "修改");
                ArrayClassCourse arrayClassCourse = arrayClassService.getArrayClassCourseById(id);
                mv.addObject("arrayClassCourse", arrayClassCourse);
                return mv;
            }else{
                ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addCourse");
                mv.addObject("arrayClassId", arrayClassId);
                mv.addObject("term", term);
                mv.addObject("head", "修改");
                ArrayClassCourse arrayClassCourse = arrayClassService.getArrayClassCourseById(id);
                mv.addObject("arrayClassCourse", arrayClassCourse);
                return mv;
            }

        }

    }

    //保存
    @ResponseBody
    @RequestMapping("/arrayClassCourse/saveArrayClassCourse")
    public Message insertArrayClassCourse(ArrayClassCourse arrayClassCourse) {
        if (arrayClassCourse.getArrayClassCourseId() == null || arrayClassCourse.getArrayClassCourseId().equals("")) {
            if (arrayClassCourse.getCourseType().equals("1")) {
                List<ArrayClassCourse> arrayClassCourseList2 = arrayClassService.getArrayClassCourseBy
                        (arrayClassCourse);
                if (arrayClassCourseList2.size() > 0) {
                    return new Message(1, "新增排课重复，新增失败！", null);
                } else {
                    arrayClassCourse.setCreator(CommonUtil.getPersonId());
                    arrayClassCourse.setCreateDept(CommonUtil.getDefaultDept());
                    arrayClassService.insertArrayClassCourse(arrayClassCourse);
                    return new Message(1, "新增成功！", null);
                }
            } else {
                List<ArrayClassCourse> arrayClassCourseList1 = arrayClassService.getArrayClassCourseByCourse
                        (arrayClassCourse);
                if (arrayClassCourseList1.size() > 0) {
                    return new Message(1, "新增排课重复,新增失败！", null);
                } else {
                    arrayClassCourse.setCreator(CommonUtil.getPersonId());
                    arrayClassCourse.setCreateDept(CommonUtil.getDefaultDept());
                    arrayClassService.insertArrayClassCourse(arrayClassCourse);
                    return new Message(1, "新增成功！", null);
                }
            }
        } else {
            arrayClassCourse.setChanger(CommonUtil.getPersonId());
            arrayClassCourse.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassCourse(arrayClassCourse);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClassCourse/deleteArrayClassCourseById")
    public Message deleteArrayClassCourseById(String id) {
        arrayClassService.deleteArrayClassCourseById(id);
        return new Message(1, "删除成功！", null);
    }

    //约束条件设置跳转
    @RequestMapping("/arrayClassCondition/request")
    public String toCourseWeekList(String arrayClassId, String elementsId, String elementsType, String
            arrayClassName, Model model) {
        ArrayClassCondition arrayClassCondition = new ArrayClassCondition();
        arrayClassCondition.setElementsType(elementsType);
        arrayClassCondition.setElementsId(elementsId);
        String elementsIdShow = arrayClassService.selectConditionName(arrayClassCondition);
        model.addAttribute("arrayClassId", arrayClassId);
        model.addAttribute("elementsId", elementsId);
        model.addAttribute("elementsIdShow", elementsIdShow);
        model.addAttribute("elementsType", elementsType);
        model.addAttribute("arrayClassName", arrayClassName);
        return "/business/educational/arrayclass/arrayplan/conditionList";
    }


    //查询列表
    /*@ResponseBody
    @RequestMapping("/arrayClassCourse/getArrayClassCourseWeekList")
    public Map<String, List<ArrayClassCourseWeek>> getArrayClassCourseWeekList(ArrayClassCourseWeek
    arrayClassCourseWeek) {
        Map<String, List<ArrayClassCourseWeek>> resultMap = new HashMap<String, List<ArrayClassCourseWeek>>();
        arrayClassCourseWeek.setCreator(CommonUtil.getPersonId());
        arrayClassCourseWeek.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", arrayClassService.getArrayClassCourseWeekList(arrayClassCourseWeek));
        return resultMap;
    }*/

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClassCourse/addArrayClassCondition")
    public ModelAndView addArrayClassCourseWeek(String id, String arrayClassId, String elementsId) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/addCondition");
        if (id == "" || id == null) {
            mv.addObject("arrayClassId", arrayClassId);
            mv.addObject("elementsId", elementsId);
            mv.addObject("head", "新增");
        } else {
            mv.addObject("arrayClassId", arrayClassId);
            mv.addObject("elementsId", elementsId);
            mv.addObject("head", "修改");
            ArrayClassCondition arrayClassCondition = arrayClassService.getArrayClassConditionById(id);
            mv.addObject("arrayClassCondition", arrayClassCondition);
        }
        return mv;
    }

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClassCourse/editArrayClassCondition")
    public ModelAndView editArrayClassCourseWeek(String id, String arrayClassId, String elementsId) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/arrayplan/editCondition");
        mv.addObject("arrayClassId", arrayClassId);
        mv.addObject("elementsId", elementsId);
        mv.addObject("head", "修改");
        ArrayClassCondition arrayClassCondition = arrayClassService.getArrayClassConditionById(id);
        mv.addObject("arrayClassCondition", arrayClassCondition);

        return mv;
    }

    //保存
    @ResponseBody
    @RequestMapping("/arrayClassCourse/saveArrayClassCondition")
    public Message insertArrayCondition(ArrayClassCondition arrayClassCondition) {
        if (arrayClassCondition.getId() == null || arrayClassCondition.getId().equals("")) {
            List<ArrayClassCondition> arrayClassCondition1 = arrayClassService.getArrayClassConditionByCondition
                    (arrayClassCondition);
            if (arrayClassCondition1.size() != 0) {
                return new Message(1, "排课约束已存在，新增失败！", null);
            } else {
                arrayClassCondition.setCreator(CommonUtil.getPersonId());
                arrayClassCondition.setCreateDept(CommonUtil.getDefaultDept());
                arrayClassService.insertArrayClassCondition(arrayClassCondition);
                return new Message(1, "新增成功！", null);
            }

        } else {
            arrayClassCondition.setChanger(CommonUtil.getPersonId());
            arrayClassCondition.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassCondition(arrayClassCondition);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    /*@ResponseBody
    @RequestMapping("/arrayClassCourse/deleteArrayClassCourseWeekById")
    public Message deleteArrayClassCourseWeekById(String id) {
        arrayClassService.deleteArrayClassCourseWeekById(id);
        return new Message(1, "删除成功！", null);
    }*/

    @RequestMapping("/arrayClassCourse/toSelectClass")
    public ModelAndView getClassTree(String id, String arrayClassId, String arrayClassCourseId, String term, String
            courseType,
                                     String courseID, String departmentsId, String majorCode) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/selectClass");
        mv.addObject("id", id);
        mv.addObject("arrayClassId", arrayClassId);
        mv.addObject("arrayClassCourseId", arrayClassCourseId);
        mv.addObject("term", term);
        mv.addObject("courseType", courseType);
        mv.addObject("courseID", courseID);
        mv.addObject("departmentsId", departmentsId);
        mv.addObject("majorCode", majorCode);
        return mv;
    }

    //班级树形下拉树
    @ResponseBody
    @RequestMapping("/arrayClassCourse/getClassTree")
    public Map<String, List> getClassTreeForExam(String courseType, String departmentsId, String courseID) {
        List<Tree> classTree = new ArrayList<Tree>();
        if ("1".equals(courseType)) {
            classTree = arrayClassService.getALLClassTree();
        } else {
            classTree = arrayClassService.getClassTreeByDepartmentId(departmentsId);
        }

        List<ArrayClassCourseWeekClass> selectedClassList = arrayClassService.getSelectedClassById(courseID);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", classTree);
        map.put("selected", selectedClassList);
        return map;
    }

    @ResponseBody
    @RequestMapping("/arrayClassCourse/saveClass")
    public Message saveExamClass(String id, String arrayClassId, String arrayClassCourseId, String courseType, String
            courseID) {
        arrayClassService.deleteOriginalCourseClass(arrayClassCourseId);
        //选中的所有系部、专业、班级ID
        String departmentsId = "";
        String majorCode = "";
        String classId = "";
        ArrayClassCourseWeekClass arrayClassCourseWeekClass = new ArrayClassCourseWeekClass();
        if ("1".equals(courseType)) {
            //选中的系部
            List<Dept> deptList = arrayClassService.chooseDeptList(id);
            if (deptList.size() > 0) {
                for (int a = 0; a < deptList.size(); a++) {
                    departmentsId = deptList.get(a).getDeptId();
                    arrayClassCourseWeekClass.setDepartmentsId(departmentsId);
                    //选中的专业
                    List<Major> majorList = arrayClassService.chooseMajorList(departmentsId, id);
                    if (majorList.size() > 0) {
                        for (int b = 0; b < majorList.size(); b++) {
                            majorCode = majorList.get(b).getMajorCode();
                            //选中的班级
                            List<ClassBean> classList = arrayClassService.chooseClassList(majorCode, id);
                            if (classList.size() > 0) {
                                for (int c = 0; c < classList.size(); c++) {
                                    classId = classList.get(c).getClassId();
                                    arrayClassCourseWeekClass.setClassId(classId);
                                    arrayClassCourseWeekClass.setArrayClassCourseId(arrayClassCourseId);
                                    arrayClassCourseWeekClass.setId(CommonUtil.getUUID());
                                    arrayClassCourseWeekClass.setCourseID(courseID);
                                    arrayClassCourseWeekClass.setArrayClassId(arrayClassId);
                                    arrayClassCourseWeekClass.setMajorCode(majorCode);
                                    CommonUtil.save(arrayClassCourseWeekClass);
                                    arrayClassService.insertClass(arrayClassCourseWeekClass);
                                }
                            }

                        }
                    }
                }
            }


        } else {
            //选中的专业
            List<Dept> deptList = arrayClassService.chooseDeptList(id);
            departmentsId = deptList.get(0).getDeptId();
            List<Major> majorList = arrayClassService.chooseMajorList(departmentsId, id);
            if (majorList.size() > 0) {
                for (int b = 0; b < majorList.size(); b++) {
                    majorCode = majorList.get(b).getMajorCode();
                    arrayClassCourseWeekClass.setMajorCode(majorCode);
                    //选中的班级
                    List<ClassBean> classList = arrayClassService.chooseClassList(majorCode, id);
                    if (classList.size() > 0) {
                        for (int c = 0; c < classList.size(); c++) {
                            classId = classList.get(c).getClassId();
                            arrayClassCourseWeekClass.setClassId(classId);
                            ArrayClassCourse arrayClassCourse = arrayClassService.getArrayClassCourseById
                                    (arrayClassCourseId);
                            arrayClassCourseWeekClass.setId(CommonUtil.getUUID());
                            arrayClassCourseWeekClass.setArrayClassId(arrayClassId);
                            arrayClassCourseWeekClass.setArrayClassCourseId(arrayClassCourseId);
                            arrayClassCourseWeekClass.setCourseID(arrayClassCourse.getCourseID());
                            arrayClassCourseWeekClass.setDepartmentsId(arrayClassCourse.getDepartmentsId());
                            arrayClassCourseWeekClass.setTrainingLevel(arrayClassCourse.getTrainingLevel());
                            arrayClassCourseWeekClass.setMajorCode(arrayClassCourse.getMajorCode());
                            CommonUtil.save(arrayClassCourseWeekClass);
                            arrayClassService.insertClass(arrayClassCourseWeekClass);
                        }
                    }
                }
            }
        }
        return new Message(1, "保存成功！", null);
    }

    @ResponseBody
    @RequestMapping("/arrayClassCourse/getClassRoomTree")
    public List<Tree> getClassTree(String roomType) {
        List<Select2> selectList = arrayClassService.getClassTree(roomType);
        return getClassToTree(selectList);
    }

    //zTree公共方法
    public List<Tree> getClassToTree(List<Select2> selectList) {
        List<Tree> treeList = new ArrayList<Tree>();
        for (int i = 0; i < selectList.size(); i++) {
            Select2 select = selectList.get(i);
            Tree tree = new Tree();
            tree.setId(select.getId());
            tree.setName(select.getText());
            treeList.add(tree);
        }
        return treeList;
    }

    //检查是否有教学计划
    @ResponseBody
    @RequestMapping("/arrayClass/checkCoursePlanForArrayClass")
    public Message checkCoursePlanForArrayClass() {
        ArrayClass arrayClass = new ArrayClass();
        List list = arrayClassService.checkCoursePlanForArrayClass();
        List list1 = arrayClassService.getArrayClassList(arrayClass);
        if (list.size() == 0) {
            return new Message(1, "当前没有教学计划可以关联，请在【教学计划管理】中添加！", null);
        } else if (list1.size() == 0) {
            return new Message(2, "当前没有排课计划可以关联，请在【排课计划管理】中添加！", null);
        } else {
            return new Message(0, "关联", null);
        }
    }

    @ResponseBody
    @RequestMapping("/arrayClass/getPlanId")
    public List<CoursePlan> getCoursePlan() {
        List list = arrayClassService.checkCoursePlanForArrayClass();
        return list;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/getArrClassId")
    public List<ArrayClass> getArrayClassId() {
        List list = arrayClassService.getArrayClassId();
        return list;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/saveCoursePlanForArrayClass")
    public Message insertCoursePlanForArrayClass(ArrayClassCourse arrayClassCourse) {
        ArrayClass arrayClass = new ArrayClass();
        ArrayClassCourseWeek arrayClassCourseWeek = new ArrayClassCourseWeek();
        ArrayClassTeacher arrayClassTeacher = new ArrayClassTeacher();
        arrayClass.setChanger(CommonUtil.getPersonId());
        arrayClass.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        arrayClassCourseWeek.setCreator(CommonUtil.getPersonId());
        arrayClassCourseWeek.setCreateDept(CommonUtil.getDefaultDept());
        return new Message(1, "关联成功！", null);
    }

    /**
     * 排课班级设置跳转
     *
     * @param arrayClassId
     * @param model
     * @return
     */
    @RequestMapping("/arrayClass/toArrayClassClassList")
    public String toList(String arrayClassId, String arrayClassName, Model model) {
        model.addAttribute("arrayClassId", arrayClassId);
        model.addAttribute("arrayClassName", arrayClassName);
        return "/business/educational/arrayclass/class/arrayClassClassPlanList";
    }

    @RequestMapping("/arrayclass/class")
    public ModelAndView toClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/class/arrayClassClass");
        return mv;
    }

    /**
     * 排课班级首页显示
     *
     * @param arrayClassClass
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayclass/getArrayClassClassList")
    public Map getList(ArrayClassClass arrayClassClass) {
        return CommonUtil.tableMap(arrayClassService.getArrayClassClassList(arrayClassClass));
    }

    /**
     * 排课班级新增跳转
     *
     * @param arrayClassId
     * @param model
     * @return
     */
    @RequestMapping("/arrayclass/toArrayClassClassAdd")
    public String toAdd(String arrayClassId, Model model) {
        ArrayClassClass arrayClassClass = new ArrayClassClass();
        arrayClassClass.setArrayclassId(arrayClassId);
        model.addAttribute("head", "新增");
        model.addAttribute("data", arrayClassClass);
        return "/business/educational/arrayclass/class/arrayClassClassEdit";
    }

    /**
     * 排课设置保存
     *
     * @param arrayClassClass
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayclass/saveArrayClassClass")
    public Message save(ArrayClassClass arrayClassClass) {
        ArrayClassClass a = arrayClassService.selectArrayClassClassById(arrayClassClass.getClassId());

        if ("".equals(arrayClassClass.getArrayclassClassId())) {
            arrayClassClass.setArrayclassClassId(CommonUtil.getUUID());
            arrayClassClass.setDepartmentsId(a.getDepartmentsId());
            arrayClassClass.setMajorCode(a.getMajorCode());
            arrayClassClass.setMajorDirection(a.getMajorDirection());
            arrayClassClass.setTrainingLevel(a.getTrainingLevel());
            CommonUtil.save(arrayClassClass);
            arrayClassService.saveArrayClassClass(arrayClassClass);
            return new Message(0, "添加成功！", null);
        } else {
            arrayClassClass.setDepartmentsId(a.getDepartmentsId());
            arrayClassClass.setMajorCode(a.getMajorCode());
            arrayClassClass.setMajorDirection(a.getMajorDirection());
            arrayClassClass.setTrainingLevel(a.getTrainingLevel());
            CommonUtil.update(arrayClassClass);
            arrayClassService.updateArrayClassClass(arrayClassClass);
            return new Message(0, "修改成功！", null);
        }

    }

    /**
     * 排课班级设置修改跳转
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/arrayclass/toArrayClassClassEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", arrayClassService.getArrayClassClassById(id));
        model.addAttribute("head", "修改");
        return "/business/educational/arrayclass/class/arrayClassClassEdit";
    }

    /**
     * 排课班级设置删除
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayclass/delArrayClassClass")
    public Message del(String id) {
        arrayClassService.delArrayClassClass(id);
        return new Message(0, "删除成功！", null);
    }


    /**
     * 禁排学时首页显示
     *
     * @param arrayClassCondition
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClass/toArrayClassConditionList")
    public Map getListCondition(ArrayClassCondition arrayClassCondition) {
        return CommonUtil.tableMap(arrayClassService.getArrayClassConditionList(arrayClassCondition));
    }

    /**
     * 禁排学时设置删除
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/arrayClass/delArrayClassCondition")
    public Message delArrayClassCondition(String id) {
        arrayClassService.deleteArrayClassCondition(id);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/student/request")
    public ModelAndView toStudentLook() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/lookstudentarrayclass/lookStudentArrayClassList");
        return mv;
    }

    //<!--Begin wq-->
//排课场地设置 create: wq 2017/08/11
    //排课场地设置首页
    @RequestMapping("/arrayClassRoom/request")
    public ModelAndView planList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/classroom/arrayclassroomplan");
        return mv;
    }

    //查询排课计划列表
    @ResponseBody
    @RequestMapping("/arrayClassRoom/getPlanList")
    public Map<String, List<ArrayClass>> getPlanList(ArrayClass arrayClass) {
        Map<String, List<ArrayClass>> resultMap = new HashMap<String, List<ArrayClass>>();
        resultMap.put("data", arrayClassService.getArrayClassList(arrayClass));
        return resultMap;
    }

    //跳转场地设置页面
    @RequestMapping("/arrayClassRoom/arrayClassRoom")
    public ModelAndView arrayClassRoomList(String arrayClassId, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/classroom/arrayclassroom");
        mv.addObject("head", "设置");
        mv.addObject("arrayClassId", arrayClassId);
        mv.addObject("arrayClassName", arrayClassName);
        return mv;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClassRoom/getArrayClassRoomList")
    public Map<String, List<ArrayClassRoom>> getArrayClassRoomList(ArrayClassRoom arrayClassRoom) {
        Map<String, List<ArrayClassRoom>> resultMap = new HashMap<String, List<ArrayClassRoom>>();
        arrayClassRoom.setCreator(CommonUtil.getPersonId());
        arrayClassRoom.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", arrayClassService.getArrayClassRoomList(arrayClassRoom));
        return resultMap;
    }

    //新增
    @ResponseBody
    @RequestMapping("/arrayClassRoom/addArrayClassRoom")
    public ModelAndView addArrayClassRoom(String arrayClassId) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/classroom/editarrayclassroom");
        mv.addObject("head", "新增");
        mv.addObject("arrayClassId", arrayClassId);
        return mv;
    }

    //修改
    @ResponseBody
    @RequestMapping("/arrayClassRoom/editArrayClassRoom")
    public ModelAndView editArrayClassRoom(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/arrayclass/classroom/editarrayclassroom");
        ArrayClassRoom arrayClassRoom = arrayClassService.getArrayClassRoomById(id);
        mv.addObject("head", "修改");
        mv.addObject("arrayClassRoom", arrayClassRoom);
        return mv;
    }

    //保存
    @ResponseBody
    @RequestMapping("/arrayClassRoom/saveArrayClassRoom")
    public Message saveArrayClassRoom(ArrayClassRoom arrayClassRoom) {
        if (arrayClassRoom.getId() == null || arrayClassRoom.getId().equals("")) {
            arrayClassRoom.setCreator(CommonUtil.getPersonId());
            arrayClassRoom.setCreateDept(CommonUtil.getDefaultDept());
            arrayClassService.insertArrayClassRoom(arrayClassRoom);
            return new Message(1, "新增成功！", null);
        } else {
            arrayClassRoom.setChanger(CommonUtil.getPersonId());
            arrayClassRoom.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassRoom(arrayClassRoom);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClassRoom/deleteArrayClassRoomById")
    public Message deleteArrayClassRoomById(String id) {
        arrayClassService.deleteArrayClassRoomById(id);
        return new Message(1, "删除成功！", null);
    }

    //教室场地查重
    @ResponseBody
    @RequestMapping("/arrayClassRoom/checkRoom")
    public Message checkRoom(ArrayClassRoom arrayClassRoom) {
        List size = arrayClassService.checkRoom(arrayClassRoom);
        if (size.size() > 0) {
            return new Message(1, "该教室已在排课计划中，请重新选择！", "error");
        } else {
            return new Message(0, "", "success");
        }
    }

    //批量新增
    @ResponseBody
    @RequestMapping("/arrayClassRoom/addArrayClassRoomBatch")
    public Message addArrayClassRoomBatch(ArrayClassRoom arrayClassRoom) {
        arrayClassService.deleteArrayClassRoomBatch(arrayClassRoom.getArrayClassId());
        arrayClassRoom.setCreator(CommonUtil.getPersonId());
        arrayClassRoom.setCreateDept(CommonUtil.getDefaultDept());
        arrayClassService.addArrayClassRoomBatch(arrayClassRoom);
        return new Message(1, "批量新增成功！", null);
    }

    //排课教师管理 modify: wq 2017/08/23
    //排课教师设置首页
    @RequestMapping("/arrayClassTeacher/request")
    public ModelAndView getarrayClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/teacher/arrayclassgrid");
        return mv;
    }

    @RequestMapping("/arrayClass/teacher/teacherList")
    public ModelAndView teacherlist(String arrayclassId, String arrayClassName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/teacher/teacherlist");
        mv.addObject("arrayclassId", arrayclassId);
        mv.addObject("arrayClassName", arrayClassName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/teacher/getTeacherList")
    public Map<String, List<ArrayClassTeacher>> getArrayClassTeacherList(ArrayClassTeacher arrayClassTeacher) {
        Map<String, List<ArrayClassTeacher>> resultMap = new HashMap<String, List<ArrayClassTeacher>>();
        arrayClassTeacher.setCreator(CommonUtil.getPersonId());
        arrayClassTeacher.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", arrayClassService.getArrayClassTeacher(arrayClassTeacher));
        return resultMap;
    }

    @RequestMapping("/arrayClass/teacher/addTeacher")
    public ModelAndView addTeacher(String arrayclassId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/teacher/editteacher");
        mv.addObject("head", "新增");
        mv.addObject("arrayclassId", arrayclassId);
        return mv;
    }

    //修改
    @RequestMapping("/arrayClass/teacher/editTeacher")
    public ModelAndView updateTeacher(String arrayclassTeacherId) {
        ArrayClassTeacher arrayClassTeacher = arrayClassService.getArrayClassTeacherById(arrayclassTeacherId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/arrayclass/teacher/editteacher");
        mv.addObject("head", "修改");
        mv.addObject("arrayClassTeacher", arrayClassTeacher);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/arrayClass/teacher/saveArrayClassTeacher")
    public Message saveArrayClassTeacher(ArrayClassTeacher arrayClassTeacher) {
        if (arrayClassTeacher.getArrayclassTeacherId() == null || arrayClassTeacher.getArrayclassTeacherId().equals
                ("")) {
            LoginUser loginUser = CommonUtil.getLoginUser();
            arrayClassTeacher.setCreator(loginUser.getPersonId());
            arrayClassTeacher.setCreateDept(loginUser.getDefaultDeptId());
            arrayClassService.saveArrayClassTeacher(arrayClassTeacher);
            return new Message(1, "保存成功！", null);
        } else {
            arrayClassTeacher.setChanger(CommonUtil.getPersonId());
            arrayClassTeacher.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassTeacher(arrayClassTeacher);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClass/delArrayClassTeacher")
    public Message delArrayClassTeacher(String arrayclassTeacherId) {
        arrayClassService.delArrayClassTeacher(arrayclassTeacherId);
        return new Message(1, "删除成功！", null);
    }

    //授课教师查重
    @ResponseBody
    @RequestMapping("/arrayClass/teacher/checkTeacher")
    public Message checkTeacher(ArrayClassTeacher arrayClassTeacher) {
        List size = arrayClassService.checkTeacher(arrayClassTeacher);
        if (size.size() > 0) {
            return new Message(1, "该教师已在排课计划中，请重新选择！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    //排课教师设置任课课程 create: wq 2017/08/23
    @RequestMapping("/arrayClass/teacher/teacherCourseAction")
    public String teacherCourseAction(String teacherPersonId, String arrayclassId, String arrayClassName, String
            teacherPersonName, Model model,String arrayclassTeacherId) {
        model.addAttribute("teacherPersonId", teacherPersonId);
        model.addAttribute("arrayclassId", arrayclassId);
        model.addAttribute("arrayClassName", arrayClassName);
        model.addAttribute("teacherPersonName", teacherPersonName);
        model.addAttribute("arrayclassTeacherId1", arrayclassTeacherId);
        return "/business/educational/arrayclass/teacher/teachercourselist";
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/arrayClass/teacher/getTeacherCourseList")
    public Map<String, List<ArrayClassTeacherCourse>> getArrayClassTeacherCourseList(ArrayClassTeacherCourse
                                                                                             arrayclassTeacherCourse) {
        Map<String, List<ArrayClassTeacherCourse>> resultMap = new HashMap<String, List<ArrayClassTeacherCourse>>();
        resultMap.put("data", arrayClassService.getArrayClassTeacherCourseList(arrayclassTeacherCourse));
        return resultMap;
    }

    //新增和修改
    @ResponseBody
    @RequestMapping("/arrayClass/teacher/editTeacherCourse")
    public ModelAndView editTeacherCourse(String id, String teacherPersonId, String arrayclassId,String arrayclassTeacherId) {

        if (id == "" || id == null) {
            ModelAndView mv = new ModelAndView("/business/educational/arrayclass/teacher/editteachercourse");
            mv.addObject("teacherPersonId", teacherPersonId);
            mv.addObject("arrayclassId", arrayclassId);
            mv.addObject("arrayclassTeacherId", arrayclassTeacherId);
            mv.addObject("head", "新增");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/business/educational/arrayclass/teacher/editteachercourse");
            mv.addObject("head", "修改");
            ArrayClassTeacherCourse arrayclassTeacherCourse = arrayClassService.getArrayClassTeacherCourseById(id);
            mv.addObject("arrayclassTeacherCourse", arrayclassTeacherCourse);
            return mv;
        }

    }

    //保存
    @ResponseBody
    @RequestMapping("/arrayClass/teacher/saveTeacherCourse")
    public Message saveTeacherCourse(ArrayClassTeacherCourse arrayclassTeacherCourse) {
        if (arrayclassTeacherCourse.getId() == null || arrayclassTeacherCourse.getId().equals("")) {
            arrayclassTeacherCourse.setCreator(CommonUtil.getPersonId());
            arrayclassTeacherCourse.setCreateDept(CommonUtil.getDefaultDept());
            arrayClassService.insertArrayClassTeacherCourse(arrayclassTeacherCourse);
            return new Message(1, "新增成功！", null);
        } else {
            arrayclassTeacherCourse.setChanger(CommonUtil.getPersonId());
            arrayclassTeacherCourse.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            arrayClassService.updateArrayClassTeacherCourse(arrayclassTeacherCourse);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/arrayClass/teacher/deleteTeacherCourseById")
    public Message deleteTeacherCourseById(String id) {
        arrayClassService.deleteArrayClassTeacherCourseById(id);
        return new Message(1, "删除成功！", null);
    }
// <!--end wq-->


}
