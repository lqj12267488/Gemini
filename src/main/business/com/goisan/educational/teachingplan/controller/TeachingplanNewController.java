package com.goisan.educational.teachingplan.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.service.RescheduleCourseService;
import com.goisan.educational.teachingplan.bean.TeachingplanNew;
import com.goisan.educational.teachingplan.service.TeachingplanNewService;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.Role;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.bean.Select2;
import com.goisan.system.dao.FilesDao;
import com.goisan.system.service.FilesService;
import com.goisan.system.service.RoleService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class TeachingplanNewController {

    private static String COM_REPORT_PATH = null;
    @Autowired
    FilesService filesService;
    @Resource
    private TeachingplanNewService teachingplanNewService;
    @Resource
    private RoleService roleService;

    @Autowired
    private RescheduleCourseService rescheduleCourseService;

    @RequestMapping("/teachingplanNew/toTeachingplanNewList")
    public ModelAndView toList(String type, Model model) {
        model.addAttribute("type", type);
        //判断登录人是否有审核权限
        String loginId=CommonUtil.getPersonId();
        String roleId="1a58e196-74cc-4eb5-bde7-83b578166cd3";
        RoleEmpDeptRelation roleEmpDeptRelation =roleService.getEmpDeptByRoleIdAndPersonId(roleId, loginId);
        ModelAndView mav=new ModelAndView();
        mav.addObject("roleEmpDeptRelation", roleEmpDeptRelation);
        mav.setViewName("/business/teachingplanNew/teachingplanNewList");
        return mav;
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/getTeachingplanNewList")
    public Map<String, Object> getList(TeachingplanNew teachingplanNew, String type, int draw, int start, int length) {

        Map<String, Object> teachingplanNews = new HashMap();
//        if ("0".equals(type)) {
//            teachingplanNew.setUserId(CommonUtil.getPersonId());
//        }
        teachingplanNew.setRequester(CommonUtil.getPersonId());
        teachingplanNew.setRequestDept(CommonUtil.getDefaultDept());
        teachingplanNew.setOffice(false);

        String officeId = rescheduleCourseService.getTTKSPId("TTKSP");
        if (officeId.equals(CommonUtil.getDefaultDept())){
            teachingplanNew.setOffice(true);
        }
//       是否是系部主任
        teachingplanNew.setDeptBoss(false);
        Role role = new Role();
        role.setRolename("%系部主任%");
        List<Role> roleList = roleService.getRoleList(role);
        Set<String> userRole = CommonUtil.getUserRole();
        for (String roleId:userRole) {
            if (roleId.equals(roleList.get(0).getRoleid())){
                teachingplanNew.setDeptBoss(true);
            }
        }
        PageHelper.startPage(start / length + 1, length);
        List<TeachingplanNew> list = teachingplanNewService.getTeachingplanNewList(teachingplanNew);
        PageInfo<List<TeachingplanNew>> info = new PageInfo(list);
        teachingplanNews.put("draw", draw);
        teachingplanNews.put("recordsTotal", info.getTotal());
        teachingplanNews.put("recordsFiltered", info.getTotal());
        teachingplanNews.put("data", list);
        return teachingplanNews;
    }

    @RequestMapping("/teachingplanNew/toTeachingplanNewAdd")
    public String toAdd(Model model) {
        String requestDept =CommonUtil.getDefaultDept();
        String requester = CommonUtil.getPersonId();
        model.addAttribute("head", "新增");
        model.addAttribute("requestDept", requestDept);
        model.addAttribute("requester", requester);
        return "/business/teachingplanNew/teachingplanNewEdit";
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/saveTeachingplanNew")
    public Message save(TeachingplanNew teachingplanNew) {
        if ("".equals(teachingplanNew.getId())) {
            teachingplanNew.setId(CommonUtil.getUUID());
            CommonUtil.save(teachingplanNew);
            teachingplanNewService.saveTeachingplanNew(teachingplanNew);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(teachingplanNew);
            teachingplanNewService.updateTeachingplanNew(teachingplanNew);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/teachingplanNew/toTeachingplanNewEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", teachingplanNewService.getTeachingplanNewById(id));
        model.addAttribute("head", "修改");
        return "/business/teachingplanNew/teachingplanNewEdit";
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/delTeachingplanNew")
    public Message del(String id) {
        teachingplanNewService.delTeachingplanNew(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/submit")
    public Message submit(String id) {
        teachingplanNewService.changeTeachingplanNewStatus(id, "2");
        return new Message(0, "提交成功！", null);
    }

    @RequestMapping("/teachingplanNew/toUpload")
    public String toUpload(String id, Model model) {
        model.addAttribute("id", id);
        return "/business/teachingplanNew/upload";
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/upload")
    public Message update(String id, @RequestParam(value = "file") MultipartFile file) {
        filesService.delFilesByBusinessId(id);
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        String fileName = file.getOriginalFilename();
        String path = String.format(urlParten, "T_JW_TEACHING_PLAN", sdf.format(new Date()));
        String url = path + "/" + CommonUtil.getUUID() + fileName.substring(fileName.indexOf("."));
        FileOutputStream fos = null;
        try {
            File f = new File(COM_REPORT_PATH + path);
            boolean mkdirs = f.mkdirs();
            if (!mkdirs) {
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(file.getBytes());
            } else {
                return new Message(0, "上传失败！", null);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        Files uploadFiles = new Files();
        uploadFiles.setFileId(CommonUtil.getUUID());
        uploadFiles.setFileName(fileName);
        uploadFiles.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));
        uploadFiles.setFileUrl(url);
        uploadFiles.setBusinessId(id);
        uploadFiles.setTableName("T_JW_TEACHING_PLAN");
        uploadFiles.setBusinessType("1");
        uploadFiles.setCreator(CommonUtil.getPersonId());
        uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        filesService.insertFiles(uploadFiles);
        teachingplanNewService.changeTeachingplanNewStatus(id, "1");
        return new Message(0, "上传成功！", null);
    }

    @RequestMapping("/teachingplanNew/toAudit")
    public String toAudit(String id, Model model) {
        model.addAttribute("id", id);
        return "/business/teachingplanNew/audit";
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/audit")
    public Message submit(TeachingplanNew teachingplanNew) {
        teachingplanNewService.audit(teachingplanNew);
        return new Message(0, "审核成功！", null);
    }

    @RequestMapping("/teachingplanNew/toImportData")
    public String toImportData() {
        return "/business/teachingplanNew/selectCoursePlan";
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/getTimeTableSelect")
    public List<Select2> getTimeTableSelect() {
        return teachingplanNewService.getTimeTableSelect();
    }

    @ResponseBody
    @RequestMapping("/teachingplanNew/importData")
    public Message importData(String id, String term) {
        List<Map<String, Object>> maps = teachingplanNewService.getCourseById(id, CommonUtil.getPersonId());
        if (maps.size() > 0) {
            try {
                for (Map<String, Object> map : maps) {
                    int sum = ((Integer.parseInt(map.get("endWeek").toString()) -
                            Integer.parseInt(map.get("startWeek").toString()) + 1) * 2 * Integer.parseInt(map.get("sum").toString()));
                    for (int i = 1; i <= sum; i++) {
                        TeachingplanNew teachingplanNew = new TeachingplanNew();
                        teachingplanNew.setTerm(term);
                        teachingplanNew.setClassId((String) map.get("classId"));
                        teachingplanNew.setUserId(CommonUtil.getPersonId());
                        teachingplanNew.setId(CommonUtil.getUUID());
                        teachingplanNew.setCourseId((String) map.get("courseId"));
                        teachingplanNew.setMajorId((String) map.get("majorId"));
                        teachingplanNew.setDeptId((String) map.get("departmentsId"));
                        teachingplanNew.setDepartmentsId((String) map.get("departmentsId"));
                        teachingplanNew.setPeriod(i + "");
                        teachingplanNewService.saveTeachingplanNew(teachingplanNew);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                return new Message(1, "操作失败！课程表维护异常，请重新维护", null);
            }

            return new Message(0, "操作成功！", null);
        } else {
            return new Message(1, "操作失败！请维护课程表", null);
        }

    }
}
