package com.goisan.studentwork.studentgrants.controller;
import com.goisan.studentwork.studentgrants.bean.StudentGrants;
import com.goisan.studentwork.studentgrants.service.StudentGrantsService;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/28.
 */
@Controller
public class StudentGrantsController {
    @Resource
    private StudentGrantsService studentGrantsService;
    @Resource
    private EmpService empService;
    //跳转页面
    @RequestMapping("/studentwork/studentGrants")
    public ModelAndView StudentGrants() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentgrants/studentGrants");//跳转到这个路径下的jsp
        return mv;
    }
    //获取表中所有数据
    @ResponseBody
    @RequestMapping("/studentGrantsManagement/getStudentGrantsList")
    public Map<String, List<StudentGrants>> StudentGrantsAction(StudentGrants studentGrants) {
        Map<String, List<StudentGrants>> studentGrantsMap = new HashMap<String, List<StudentGrants>>();//创建一个map集合
        studentGrants.setCreator(CommonUtil.getPersonId());
        studentGrants.setCreateDept(CommonUtil.getDefaultDept());
        studentGrantsMap.put("data", studentGrantsService.getStudentGrantsList(studentGrants));
        //通过.xml中的XuZheAction方法查询数据库中的数据
        return studentGrantsMap;//返回一个map集合
    }

    //跳转新增页面
    @RequestMapping("/studentGrants/addStudentGrants")
    public ModelAndView addStudentGrants() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentgrants/editstudentGrants");
        mv.addObject("head", "助学金新增");
        return mv;
    }

    @RequestMapping("/studentGrants/updateStudentGrants")
    public ModelAndView updateStudentGrants(String id) {
        StudentGrants studentGrants = studentGrantsService.getStudentGrantsById(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "助学金修改");
        mv.addObject("studentGrants", studentGrants);
        mv.setViewName("/business/studentwork/studentgrants/editstudentGrants");
        return mv;
    }
    //删除一个数据
    @ResponseBody
    @RequestMapping("/studentGrants/deleteStudentGrantsById")
    public Message deleteDeptById(String id) {
        studentGrantsService.deleteStudentGrantsById(id);//.xml中的deleteXuZheById方法,通过id删除数据库中的一条数据
        return new Message(1, "删除成功！", null);
    }
    //查找
    @ResponseBody
    @RequestMapping("/studentGrants/searchStudentGrants")
    public Map<String, List<StudentGrants>> searchStudentGrants(StudentGrants studentGrants) {
        Map<String, List<StudentGrants>> studentGrantsMap = new HashMap<String, List<StudentGrants>>();
        studentGrants.setCreator(CommonUtil.getPersonId());
        studentGrants.setCreateDept(CommonUtil.getDefaultDept());
        studentGrantsMap.put("data", studentGrantsService.getStudentGrantsList(studentGrants));
        return studentGrantsMap;
    }
    //把数据存到数据库中
    @ResponseBody
    @RequestMapping("/studentGrants/saveStudentGrants")
    public Message saveStudentGrants(StudentGrants studentGrants){
        if(studentGrants.getId()==null || studentGrants.getId().equals("")){
            studentGrants.setCreateDept(CommonUtil.getDefaultDept());
            studentGrants.setCreator(CommonUtil.getPersonId());
            studentGrants.setId(CommonUtil.getUUID());
            studentGrantsService.insertStudentGrants(studentGrants);
            //通过.xml中的insertXuZhe方法存储数据到数据库中
            return new Message(1, "新增成功！", null);
        }else{
            //studentGrants.setId(CommonUtil.getUUID());
            studentGrants.setChanger(CommonUtil.getPersonId());
            studentGrants.setChangeDept(CommonUtil.getDefaultDept());
            studentGrantsService.updateStudentGrantsById(studentGrants);
            //通过.xml中的updateXuZheById方法修改数据库中的数据
            return new Message(1, "修改成功！", null);
        }
    }
    @ResponseBody
    @RequestMapping("/studentGrants/getMajorDeptId")
    public List<Select2> getMajorCodeByDeptId(String deptId) {
        return studentGrantsService.getMajorCodeByDeptId(deptId);
    }
    @ResponseBody
    @RequestMapping("/studentGrants/getStudentByClassId")
    public List<Select2> getStudentByClassId(String classId) {
        return studentGrantsService.getStudentByClassId(classId);
    }

    @ResponseBody
    @RequestMapping("/studentGrants/getTrainingLevelByClassId")
    public Map getTrainingLevelByClassId(String classId){
        String str = studentGrantsService.getTrainingLevelByClassId(classId);
        String[] strs = str.split(",");
        Map data = new HashMap();
        data.put("storeValue",strs[0]);
        data.put("showValue",strs[1]);
        return data;
    }
    //查询页面跳转
    @RequestMapping("/studentwork/studentSearch")
    public ModelAndView StudentGrantsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentgrants/studentGrantsList");//跳转到这个路径下的jsp
        return mv;
    }
    //详情界面跳转
    @RequestMapping("/studentGrants/studentGrantsDetail")
    public ModelAndView studentGrantsDetail(String id) {
        StudentGrants studentGrants = studentGrantsService.getStudentGrantsById(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "助学金详情");
        mv.addObject("studentGrants", studentGrants);
        mv.setViewName("/business/studentwork/studentgrants/studentGrantsDetail");
        return mv;
    }
}

