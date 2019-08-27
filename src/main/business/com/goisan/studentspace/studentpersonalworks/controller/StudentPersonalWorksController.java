package com.goisan.studentspace.studentpersonalworks.controller;

import com.goisan.common.transcoding.Transcoding;
import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.studentspace.studentpersonalworks.bean.StudentPersonalWorks;
import com.goisan.studentspace.studentpersonalworks.service.StudentPersonalWorksService;
import com.goisan.system.bean.Files;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
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
import java.io.*;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by fn on 2017/11/16
 */
@Controller
public class StudentPersonalWorksController {
    @Resource
    private StudentPersonalWorksService studentPersonalWorksService;
    @Resource
    private ResourceFilesService resourceFilesService;

    //弹出主页面
    @RequestMapping("/studentSpace/personalWorksList")
    public ModelAndView personalWorksList() {
        ModelAndView mv = new ModelAndView("/business/studentspace/personalWorksList");
        return mv;
    }

    //初始化主页面
    @ResponseBody
    @RequestMapping("/studentSpace/getPersonalWorksList")
    public Map getList(StudentPersonalWorks studentPersonalWorks) {
        Map<String, List<StudentPersonalWorks>> studentPersonalWorksMap = new HashMap<String, List<StudentPersonalWorks>>();
        String personId = CommonUtil.getPersonId();
        studentPersonalWorks.setUploadPersonId(personId);
        studentPersonalWorksMap.put("data", studentPersonalWorksService.getPersonalWorksList(studentPersonalWorks));
        return studentPersonalWorksMap;
    }

    //弹出新增页面
    @RequestMapping("/studentSpace/toStudentPersonalWorksAdd")
    public String toAdd(Model model) {
        StudentPersonalWorks StudentPersonalWorks = new StudentPersonalWorks();
        String personId = CommonUtil.getPersonId();
        model.addAttribute("StudentPersonalWorks", StudentPersonalWorks);
        model.addAttribute("head", "新增");
        model.addAttribute("personId", personId);
        return "/business/studentspace/StudentPersonalWorksAdd";
    }

    //修改保存方法
    @ResponseBody
    @RequestMapping("/StudentPersonalWorks/saveStudentPersonalWorks")
    public Message save(StudentPersonalWorks StudentPersonalWorks) {
        StudentPersonalWorks.setChanger(CommonUtil.getPersonId());
        StudentPersonalWorks.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        studentPersonalWorksService.updateStudentPersonalWorks(StudentPersonalWorks);
        return new Message(1, "修改成功！", "success");

    }
    //新增 保存方法
    @ResponseBody
    @RequestMapping("/StudentPersonalWorks/insertStudentPersonalWorks")
    public Message insertStudentPersonalWorks(@RequestParam("resourceName") String resourceName,
                                              @RequestParam("remark") String remark) {
            StudentPersonalWorks StudentPersonalWorks = new StudentPersonalWorks();
            String id=CommonUtil.getUUID();
            StudentPersonalWorks.setResourceName(resourceName);
            StudentPersonalWorks.setRemark(remark);
            StudentPersonalWorks.setId(id);
            CommonUtil.save(StudentPersonalWorks);
            studentPersonalWorksService.saveStudentPersonalWorks(StudentPersonalWorks);
            return new Message(1, "保存成功", "success");
    }

    //修改弹出页面
    @RequestMapping("/StudentPersonalWorks/toStudentPersonalWorksEdit")
    public String toEdit(String id, Model model) {
        StudentPersonalWorks StudentPersonalWorks = studentPersonalWorksService.getStudentPersonalWorksById(id);
        model.addAttribute("StudentPersonalWorks", StudentPersonalWorks);
        model.addAttribute("head", "修改");
        return "/business/studentspace/StudentPersonalWorksEdit";
    }

    //删除方法
    @ResponseBody
    @RequestMapping("/StudentPersonalWorks/delStudentPersonalWorks")
    public Message del(String id) {
        studentPersonalWorksService.delStudentPersonalWorks(id);
        return new Message(1, "删除成功！", "success");
    }
}
