package com.goisan.educational.teachingresult.controller;

import com.goisan.educational.teachingresult.bean.*;
import com.goisan.educational.teachingresult.service.TeacherResultService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Controller
public class TeachingResultController {
    @Resource
    private TeacherResultService teacherResultService;
    @Resource
    private EmpService empService;
    //页面跳转
    @RequestMapping("/teacherResult/request")
    public ModelAndView resultList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/resultList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList")
    public Map<String, List<TeachingResult>> getTeacherResultList(TeachingResult teacherResult) {
        Map<String, List<TeachingResult>> resultMap = new HashMap<String, List<TeachingResult>>();
        teacherResult.setCreator(CommonUtil.getPersonId());
        teacherResult.setCreateDept(CommonUtil.getDefaultDept());
        resultMap.put("data", teacherResultService.getTeacherResultList(teacherResult));
        return resultMap;
    }
    //新增和修改
    @ResponseBody
    @RequestMapping("/teacherResult/addTeachingResult")
    public ModelAndView addAssetsInstall(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/addTeacherResults");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResult teachingResult = teacherResultService.getTeachingResultById(id);
            mv.addObject("teachingResult", teachingResult);
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult")
    public Message saveTeachingResult(TeachingResult teacherResult) {
        if (teacherResult.getId() == null || teacherResult.getId().equals("")) {
            teacherResult.setCreator(CommonUtil.getPersonId());
            teacherResult.setCreateDept(CommonUtil.getDefaultDept());
            teacherResult.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResult(teacherResult);
            return new Message(1, "新增成功！", null);
        } else {
            teacherResult.setChanger(CommonUtil.getPersonId());
            teacherResult.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResult(teacherResult);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResultById")
    public Message deleteTeachingResultById(String id) {
        teacherResultService.deleteTeachingResultById(id);
        return new Message(1, "删除成功！", null);
    }
    //获取部门名称
    @ResponseBody
    @RequestMapping("/teacherResult/getDept")
    public List<AutoComplete> selectDept() {
        return teacherResultService.selectDept();
    }
    //获取人员姓名
    @ResponseBody
    @RequestMapping("/teacherResult/getPerson")
    public List<AutoComplete> selectPerson() {
        return teacherResultService.selectPerson();
    }

//教科研成果管理（项目）
    //页面跳转
    @RequestMapping("/teacherResult/request/project")
    public ModelAndView teachingResultProjectAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/projectList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/project")
    public Map<String, List<TeachingResultProject>> getTeachingResultProjectList(TeachingResultProject teacherResultProject) {
        Map<String, List<TeachingResultProject>> projectMap = new HashMap<String, List<TeachingResultProject>>();
        teacherResultProject.setCreator(CommonUtil.getPersonId());
        teacherResultProject.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultProject.setLevel(CommonUtil.getLoginUser().getLevel());
        projectMap.put("data", teacherResultService.getTeachingResultProjectList(teacherResultProject));
        return projectMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/project")
    public ModelAndView editTeachingResultProject(String id, String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editProject");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultProject teachingResultProject = teacherResultService.getTeachingResultProjectById(id);
            mv.addObject("project", teachingResultProject);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/project")
    public Message saveTeachingResultProject(TeachingResultProject teachingResultProject) {
        if (teachingResultProject.getId() == null || teachingResultProject.getId().equals("")) {
            teachingResultProject.setCreator(CommonUtil.getPersonId());
            teachingResultProject.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultProject.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultProject(teachingResultProject);
            return new Message(1, "新增成功！", null);
        } else {
            teachingResultProject.setChanger(CommonUtil.getPersonId());
            teachingResultProject.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultProject(teachingResultProject);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/project")
    public Message deleteTeachingResultProject(String id) {
        teacherResultService.deleteTeachingResultProject(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果管理（国家标准或行业标准）
    //页面跳转
    @RequestMapping("/teacherResult/request/standard")
    public ModelAndView teachingResultStandardAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/standardList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/standard")
    public Map<String, List<TeachingResultStandard>> getTeachingResultStandardList(TeachingResultStandard teacherResultStandard) {
        Map<String, List<TeachingResultStandard>> standardMap = new HashMap<String, List<TeachingResultStandard>>();
        teacherResultStandard.setCreator(CommonUtil.getPersonId());
        teacherResultStandard.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultStandard.setLevel(CommonUtil.getLoginUser().getLevel());
        standardMap.put("data", teacherResultService.getTeachingResultStandardList(teacherResultStandard));
        return standardMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/standard")
    public ModelAndView editTeachingResultStandard(String id, String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editStandard");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultStandard teachingResultStandard = teacherResultService.getTeachingResultStandardById(id);
            mv.addObject("standard", teachingResultStandard);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/standard")
    public Message saveTeachingResultStandard(TeachingResultStandard teachingResultStandard) {
        if (teachingResultStandard.getId() == null || teachingResultStandard.getId().equals("")) {
            teachingResultStandard.setCreator(CommonUtil.getPersonId());
            teachingResultStandard.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultStandard.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultStandard(teachingResultStandard);
            return new Message(1, "新增成功！", null);
        } else {
            teachingResultStandard.setChanger(CommonUtil.getPersonId());
            teachingResultStandard.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultStandard(teachingResultStandard);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/standard")
    public Message deleteTeachingResultStandard(String id) {
        teacherResultService.deleteTeachingResultStandard(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果管理（国家医药证书）
    //页面跳转
    @RequestMapping("/teacherResult/request/medicine")
    public ModelAndView teachingResultMedicineAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/medicineList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/medicine")
    public Map<String, List<TeachingResultMedicine>> getTeachingResultMedicineList(TeachingResultMedicine teacherResultMedicine) {
        Map<String, List<TeachingResultMedicine>> medicineMap = new HashMap<String, List<TeachingResultMedicine>>();
        teacherResultMedicine.setCreator(CommonUtil.getPersonId());
        teacherResultMedicine.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultMedicine.setLevel(CommonUtil.getLoginUser().getLevel());
        medicineMap.put("data", teacherResultService.getTeachingResultMedicineList(teacherResultMedicine));
        return medicineMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/medicine")
    public ModelAndView editTeachingResultMedicine(String id, String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editMedicine");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultMedicine teachingResultMedicine = teacherResultService.getTeachingResultMedicineById(id);
            mv.addObject("medicine", teachingResultMedicine);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/medicine")
    public Message saveTeachingResultMedicine(TeachingResultMedicine teachingResultMedicine) {
        if (teachingResultMedicine.getId() == null || teachingResultMedicine.getId().equals("")) {
            teachingResultMedicine.setCreator(CommonUtil.getPersonId());
            teachingResultMedicine.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultMedicine.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultMedicine(teachingResultMedicine);
            return new Message(1, "新增成功！", null);
        } else {
            teachingResultMedicine.setChanger(CommonUtil.getPersonId());
            teachingResultMedicine.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultMedicine(teachingResultMedicine);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/medicine")
    public Message deleteTeachingResultMedicine(String id) {
        teacherResultService.deleteTeachingResultMedicine(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

    //教科研成果管理（论文）
    //页面跳转
    @RequestMapping("/teacherResult/request/paper")
    public ModelAndView teachingResultPaperAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/paperList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/paper")
    public Map<String, List<TeachingResultPaper>> getTeachingResultPaperList(TeachingResultPaper teacherResultPaper) {
        Map<String, List<TeachingResultPaper>> paperMap = new HashMap<String, List<TeachingResultPaper>>();
        teacherResultPaper.setCreator(CommonUtil.getPersonId());
        teacherResultPaper.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultPaper.setLevel(CommonUtil.getLoginUser().getLevel());
        paperMap.put("data", teacherResultService.getTeachingResultPaperList(teacherResultPaper));
        return paperMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/paper")
    public ModelAndView editTeachingResultPaper(String id, String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editPaper");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultPaper teachingResultPaper = teacherResultService.getTeachingResultPaperById(id);
            mv.addObject("paper", teachingResultPaper);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/paper")
    public Message saveTeachingResultPaper(TeachingResultPaper teachingResultPaper) {
        if (teachingResultPaper.getId() == null || teachingResultPaper.getId().equals("")) {
            teachingResultPaper.setCreator(CommonUtil.getPersonId());
            teachingResultPaper.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultPaper.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultPaper(teachingResultPaper);
            return new Message(1, "新增成功！", null);
        } else {
            teachingResultPaper.setChanger(CommonUtil.getPersonId());
            teachingResultPaper.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultPaper(teachingResultPaper);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/paper")
    public Message deleteTeachingResultPaper(String id) {
        teacherResultService.deleteTeachingResultPaper(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);

    }
//教科研成果管理（著作）
    //页面跳转
    @RequestMapping("/teacherResult/request/writing")
    public ModelAndView teachingResultWritingAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/writingList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/writing")
    public Map<String, List<TeachingResultWriting>> getTeachingResultWritingList(TeachingResultWriting teacherResultWriting) {
        Map<String, List<TeachingResultWriting>> writingMap = new HashMap<String, List<TeachingResultWriting>>();
        teacherResultWriting.setCreator(CommonUtil.getPersonId());
        teacherResultWriting.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultWriting.setLevel(CommonUtil.getLoginUser().getLevel());
        writingMap.put("data", teacherResultService.getTeachingResultWritingList(teacherResultWriting));
        return writingMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/writing")
    public ModelAndView editTeachingResultWriting(String id, String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editWriting");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultWriting teachingResultWriting = teacherResultService.getTeachingResultWritingById(id);
            mv.addObject("writing", teachingResultWriting);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/writing")
    public Message saveTeachingResultWriting(TeachingResultWriting teachingResultWriting) {
        if (teachingResultWriting.getId() == null || teachingResultWriting.getId().equals("")) {
            teachingResultWriting.setCreator(CommonUtil.getPersonId());
            teachingResultWriting.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultWriting.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultWriting(teachingResultWriting);
            return new Message(1, "新增成功！", null);
        } else {
            teachingResultWriting.setChanger(CommonUtil.getPersonId());
            teachingResultWriting.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultWriting(teachingResultWriting);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/writing")
    public Message deleteTeachingResultWriting(String id) {
        teacherResultService.deleteTeachingResultWriting(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);

    }

//教科研成果管理（文艺作品）
    //页面跳转
    @RequestMapping("/teacherResult/request/art")
    public ModelAndView teachingResultArtAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/artList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/art")
    public Map<String,List<TeachingResultArt>> getTeachingResultArtList(TeachingResultArt teacherResultArt) {
        Map<String, List<TeachingResultArt>> artMap = new HashMap<String, List<TeachingResultArt>>();
        teacherResultArt.setCreator(CommonUtil.getPersonId());
        teacherResultArt.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultArt.setLevel(CommonUtil.getLoginUser().getLevel());
        artMap.put("data", teacherResultService.getTeachingResultArtList(teacherResultArt));
        return artMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/art")
    public ModelAndView editTeachingResultArt(String id,String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editArt");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultArt teachingResultArt = teacherResultService.getTeachingResultArtById(id);
            mv.addObject("art", teachingResultArt);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/art")
    public Message saveTeachingResultArt(TeachingResultArt teachingResultArt){
        if(teachingResultArt.getId()==null || teachingResultArt.getId().equals("")){
            teachingResultArt.setCreator(CommonUtil.getPersonId());
            teachingResultArt.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultArt.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultArt(teachingResultArt);
            return new Message(1, "新增成功！", null);
        }else{
            teachingResultArt.setChanger(CommonUtil.getPersonId());
            teachingResultArt.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultArt(teachingResultArt);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/art")
    public Message deleteTeachingResultArt(String id) {
        teacherResultService.deleteTeachingResultArt(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果管理（指导学生参加竞赛获奖）
    //页面跳转
    @RequestMapping("/teacherResult/request/guide")
    public ModelAndView teachingResultGuideAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/guideList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/guide")
    public Map<String,List<TeachingResultGuide>> getTeachingResultGuideList(TeachingResultGuide teacherResultGuide) {
        Map<String, List<TeachingResultGuide>> guideMap = new HashMap<String, List<TeachingResultGuide>>();
        teacherResultGuide.setCreator(CommonUtil.getPersonId());
        teacherResultGuide.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultGuide.setLevel(CommonUtil.getLoginUser().getLevel());
        guideMap.put("data", teacherResultService.getTeachingResultGuideList(teacherResultGuide));
        return guideMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/guide")
    public ModelAndView editTeachingResultGuide(String id,String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editGuide");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultGuide teachingResultGuide = teacherResultService.getTeachingResultGuideById(id);
            mv.addObject("guide", teachingResultGuide);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/guide")
    public Message saveTeachingResultGuide(TeachingResultGuide teachingResultGuide){
        if(teachingResultGuide.getId()==null || teachingResultGuide.getId().equals("")){
            teachingResultGuide.setCreator(CommonUtil.getPersonId());
            teachingResultGuide.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultGuide.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultGuide(teachingResultGuide);
            return new Message(1, "新增成功！", null);
        }else{
            teachingResultGuide.setChanger(CommonUtil.getPersonId());
            teachingResultGuide.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultGuide(teachingResultGuide);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/guide")
    public Message deleteTeachingResultGuide(String id) {
        teacherResultService.deleteTeachingResultGuide(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果管理（专利或软件著作权）
    //页面跳转
    @RequestMapping("/teacherResult/request/patent")
    public ModelAndView teachingResultPatentAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/patentList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/patent")
    public Map<String,List<TeachingResultPatent>> getTeachingResultPatentList(TeachingResultPatent teacherResultPatent) {
        Map<String, List<TeachingResultPatent>> patentMap = new HashMap<String, List<TeachingResultPatent>>();
        teacherResultPatent.setCreator(CommonUtil.getPersonId());
        teacherResultPatent.setCreateDept(CommonUtil.getDefaultDept());
        patentMap.put("data", teacherResultService.getTeachingResultPatentList(teacherResultPatent));
        return patentMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/patent")
    public ModelAndView editTeachingResultPatent(String id,String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editPatent");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultPatent teachingResultPatent = teacherResultService.getTeachingResultPatentById(id);
            mv.addObject("patent", teachingResultPatent);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/patent")
    public Message saveTeachingResultPatent(TeachingResultPatent teachingResultPatent){
        if(teachingResultPatent.getId()==null || teachingResultPatent.getId().equals("")){
            teachingResultPatent.setCreator(CommonUtil.getPersonId());
            teachingResultPatent.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultPatent.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultPatent(teachingResultPatent);
            return new Message(1, "新增成功！", null);
        }else{
            teachingResultPatent.setChanger(CommonUtil.getPersonId());
            teachingResultPatent.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultPatent(teachingResultPatent);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/patent")
    public Message deleteTeachingResultPatent(String id) {
        teacherResultService.deleteTeachingResultPatent(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果管理（咨询报告或研究报告）
    //页面跳转
    @RequestMapping("/teacherResult/request/report")
    public ModelAndView teachingResultReportAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/reportList");
        return mv;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/teacherResult/getResultList/report")
    public Map<String,List<TeachingResultReport>> getTeachingResultReportList(TeachingResultReport teacherResultReport) {
        Map<String, List<TeachingResultReport>> reportMap = new HashMap<String, List<TeachingResultReport>>();
        teacherResultReport.setCreator(CommonUtil.getPersonId());
        teacherResultReport.setCreateDept(CommonUtil.getDefaultDept());
        teacherResultReport.setLevel(CommonUtil.getLoginUser().getLevel());
        reportMap.put("data", teacherResultService.getTeachingResultReportList(teacherResultReport));
        return reportMap;
    }
    //新增和修改页面跳转
    @ResponseBody
    @RequestMapping("/teacherResult/editTeachingResult/report")
    public ModelAndView editTeachingResultReport(String id,String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingresult/editReport");
        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            mv.addObject("head", "修改");
            TeachingResultReport teachingResultReport = teacherResultService.getTeachingResultReportById(id);
            mv.addObject("report", teachingResultReport);
            if (flag != null) {
                if (flag.equals("on") || flag == "on") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                }
            }
        }
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/teacherResult/saveTeachingResult/report")
    public Message saveTeachingResultReport(TeachingResultReport teachingResultReport){
        if(teachingResultReport.getId()==null || teachingResultReport.getId().equals("")){
            teachingResultReport.setCreator(CommonUtil.getPersonId());
            teachingResultReport.setCreateDept(CommonUtil.getDefaultDept());
            teachingResultReport.setId(CommonUtil.getUUID());
            teacherResultService.insertTeachingResultReport(teachingResultReport);
            return new Message(1, "新增成功！", null);
        }else{
            teachingResultReport.setChanger(CommonUtil.getPersonId());
            teachingResultReport.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            teacherResultService.updateTeachingResultReport(teachingResultReport);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/teacherResult/deleteTeachingResult/report")
    public Message deleteTeachingResultReport(String id) {
        teacherResultService.deleteTeachingResultReport(id);
        teacherResultService.deleteFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

//教科研成果统计
    @ResponseBody
    @RequestMapping("/teacherResult/count")
    public ModelAndView countAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/teachingResultCount");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/teacherResult/teachingResultCount")
    public Map<String,List<TeachingResultProject>> teachingResultCount(TeachingResultProject teachingResultProject) {
        Map<String, List<TeachingResultProject>> countMap = new HashMap<String, List<TeachingResultProject>>();
        teachingResultProject.setCreateDept(CommonUtil.getDefaultDept());
        teachingResultProject.setLevel(CommonUtil.getLoginUser().getLevel());
        List<TeachingResultProject> list=teacherResultService.getCountList(teachingResultProject);
        countMap.put("data", list);
        return countMap;
    }

//个人教科研成果查询
    @ResponseBody
    @RequestMapping("/teacherResult/teacherResultMyself")
    public ModelAndView teacherResultMyself() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingresult/teacherResultMyself");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/teacherResult/teacherResultMyselfList")
    public Map<String,List<TeachingResultProject>> teacherResultMyselfList(TeachingResultProject teachingResultProject) {
        Map<String, List<TeachingResultProject>> countMap = new HashMap<String, List<TeachingResultProject>>();
        teachingResultProject.setPersonId(CommonUtil.getPersonId());
        List<TeachingResultProject> list=teacherResultService.getCountList(teachingResultProject);
        countMap.put("data", list);
        return countMap;
    }
}