package com.goisan.archives.controller;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.service.ArchivesService;
import com.goisan.archives.service.ArchivesTypeService;
import com.goisan.common.transcoding.WordUtil;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArchivesController {
    @Resource
    private ArchivesService archivesService;
    @Resource
    private EmpService empService;
    @Resource
    private ArchivesTypeService archivesTypeService;
    @Resource
    private SysDicService sysDicService;
    @Resource
    private EmpRangeService empRangeService;
    @Resource
    private CommonService commonService;
    @Resource
    private FilesService filesService;
    @Resource
    private DeptService deptService;

    //教师角色电子档案维护页面
    @RequestMapping("/archives/archivesListTeacher")
    public ModelAndView archivesListTeacher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListTeacher");
        mv.addObject("ptyh", true);
        return mv;
    }

    //普通教师电子档案信息维护

    @ResponseBody
    @RequestMapping("/archives/getTeacherArchivesList")
    public Map<String, List<Archives>> getTeacherArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
//        archives.setCreator(CommonUtil.getPersonId());
        archives.setValidFlag("1");
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        List l = empService.getEmpRole(personId,deptId);
        if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){

        }else if (l.contains("9e7ff02e-74ef-4e6c-9a25-31d1dbbd1a7e")){
            archives.setCreateDept(deptId);
        }else {
            archives.setCreator(personId);
        }
        List<Archives> list = archivesService.getArchivesList(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    @RequestMapping("/archives/archivesIndexInfo")
    public ModelAndView repairIndexInfo(Archives archives) {
        Archives archives1 = archivesService.getArchivesById(archives.getArchivesId());
        if ("0".equals(archives1.getRequestFlag())) {
            ModelAndView mv = new ModelAndView("/business/archives/archivesEditIndex");
            mv.addObject("head", "审核");
            mv.addObject("archives", archives1);
            mv.addObject("type", "1");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/business/archives/archivesEditRequestIndex");
            mv.addObject("head", "审核");
            mv.addObject("archives", archives1);
            mv.addObject("audit", "audit");
            mv.addObject("type", "1");
            return mv;
        }
    }

    @ResponseBody
    @RequestMapping("/archives/updateArchivesInfo")
    public Message repairFenPeis(String id) {
        Archives archives = new Archives();
        archivesService.updateArchivesInfo(id);
        return new Message(1, "查看完成！", null);
    }

    //电子档案审核列表页面
    @RequestMapping("/archives/archivesListAudit")
    public ModelAndView archivesListAudit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListAudit");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getArchivesListAudit")
    public Map<String, List<Archives>> getArchivesListAudit(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        archives.setRequestFlag("1");
        List<Archives> list = archivesService.getArchivesList(archives);
        map.put("data", list);
        return map;
    }

    //电子档案部门主任列表页面
    @RequestMapping("/archives/archivesListDirector")
    public ModelAndView archivesListDirector() {
        ModelAndView mv = new ModelAndView();
        String login = CommonUtil.getPersonId();
        mv.addObject("login", login);
        mv.addObject("ptyh", false);
        mv.setViewName("/business/archives/archivesListDirector");
        return mv;
    }

    //电子档案校领导列表页面
    @RequestMapping("/archives/archivesListSchLeader")
    public ModelAndView archivesListLeader() {
        ModelAndView mv = new ModelAndView();
        String login = CommonUtil.getPersonId();
        mv.addObject("login", login);
        mv.addObject("ptyh", false);
        mv.setViewName("/business/archives/archivesListSchLeader");
        return mv;
    }

    //部门主任
    @ResponseBody
    @RequestMapping("/archives/getDirectorArchivesList")
    public Map<String, List<Archives>> getDirectorArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setValidFlag("1");
//        archives.setCreateDept(CommonUtil.getDefaultDept());
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        List l = empService.getEmpRole(personId,deptId);
        if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){
            archives.setCreateDept(deptId);
        }else if (l.contains("9e7ff02e-74ef-4e6c-9a25-31d1dbbd1a7e")){
            archives.setCreateDept(deptId);
        }else {
            archives.setCreator(personId);
        }
        archives.setCreatePerson(personId);
        List<Archives> list = archivesService.getArchivesListBumen(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/archives/getSchLeaderArchivesList")
    public Map<String, List<Archives>> getSchLeaderArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setValidFlag("1");
//        archives.setCreator(CommonUtil.getPersonId());
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        List l = empService.getEmpRole(personId,deptId);
        if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){//校领导（管辖范围）
           /* List<EmpRange> sfcz=empRangeService.getEmpRangeListByPersonId(personId);//查询是否有管辖范围*/
            if(l.contains("04734ef5-943f-442d-9507-23c249871f7f")) {
                archives.setCreatePerson(personId);
                archives.setRoleFlag("2");
            }else {
                archives.setCreatePerson(personId);
                archives.setRoleFlag("1");
            }
        }else if (l.contains("9e7ff02e-74ef-4e6c-9a25-31d1dbbd1a7e")){
            archives.setCreatePerson(personId);
            archives.setCreateDept(deptId);
        }else if(l.contains("04734ef5-943f-442d-9507-23c249871f7f")){//大校长（所有）
            archives.setCreatePerson(personId);
            archives.setRoleFlag("2");
        } else {
            archives.setCreator(personId);
        }
        //List<Archives> list = archivesService.getArchivesHeadmasterList(archives);getArchivesListLingDao
        List<Archives> list = archivesService.getArchivesListLingDao(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    //普通教师角色电子档案查询列表页面
    @RequestMapping("/archives/directorArchivesList")
    public ModelAndView directorArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListTeacherAndDirector");
        return mv;
    }

    //部门主任角色电子档案查询列表页面
    @RequestMapping("/archives/departmentArchivesList")
    public ModelAndView departmentArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListDepartment");
        return mv;
    }

    //校领导角色电子档案查询列表页面
    @RequestMapping("/archives/leaderArchivesList")
    public ModelAndView leaderArchivesList() {
        ModelAndView mv = new ModelAndView();

        if (null!= CommonUtil.getDefaultDept()&&!"".equals(CommonUtil.getDefaultDept())) {
            List<String> roles = empService.getEmpRole(CommonUtil.getPersonId(), CommonUtil.getDefaultDept());
            if (roles.contains("776d345a-dc33-4de5-a804-12bf2bf66d8b")){
                mv.addObject("authFlag","1");
            }
        }else {
            mv.addObject("authFlag","0");
        }

        mv.setViewName("/business/archives/archivesListLeader");
        return mv;
    }

    //电子档案审核列表页面
    @RequestMapping("/archives/archivesListSchoolLeader")
    public ModelAndView archivesListSchoolLeader() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListSchoolLeader");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getLeaderArchivesList")
    public Map<String, List<Archives>> getLeaderArchivesList(Archives archives) {

        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getDeptName() != null && archives.getDeptName() != "") {
            try {
                archives.setDeptName(URLDecoder.decode(archives.getDeptName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
//        archives.setCreator(CommonUtil.getPersonId());
        archives.setValidFlag("1");
//        archives.setCreateDept(CommonUtil.getDefaultDept());
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        List l = empService.getEmpRole(personId,deptId);

        if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){//校领导（管辖范围）
            if(l.contains("04734ef5-943f-442d-9507-23c249871f7f")) {
                archives.setRoleFlag("4");
                archives.setCreator("");
            }else {
                archives.setCreatePerson(personId);
                archives.setRoleFlag("3");
            }
            /*archives.setCreator(personId);
            List<EmpRange> sfcz=empRangeService.getEmpRangeListByPersonId(personId);//查询是否有管辖范围
            if(sfcz.size()<0) {
                archives.setRoleFlag("3");
            }else {
                archives.setRoleFlag("4");
                archives.setCreator("");
            }*/
        }else if (l.contains("9e7ff02e-74ef-4e6c-9a25-31d1dbbd1a7e")){
            archives.setCreateDeptOne(deptId);
            //archives.setCreator(personId);
        }else if (l.contains("59c7bbf4-7755-4940-a05e-c3becb3f3f54")){
            archives.setCreator("");
        }else if(l.contains("04734ef5-943f-442d-9507-23c249871f7f")){
            archives.setCreator(personId);
        }else if(l.contains("776d345a-dc33-4de5-a804-12bf2bf66d8b")){
            archives.setCreator("");
        } else {
            archives.setCreator(personId);
        }
        List<Archives> list = archivesService.getAllArchivesList(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    //管理员角色电子档案列表页面
    @RequestMapping("/archives/managerArchivesList")
    public ModelAndView managerArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListManager");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getManagerArchivesList")
    public Map<String, List<Archives>> getManagerArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getDeptName() != null && archives.getDeptName() != "") {
            try {
                archives.setDeptName(URLDecoder.decode(archives.getDeptName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setValidFlag("1");
        archives.setRequestFlag("5");
        List<Archives> list = archivesService.getArchivesList(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    @RequestMapping("/archives/editArchivesIndex")
    public ModelAndView editArchivesIndex(Archives archives) {
        Archives archives1 = archivesService.getArchivesById(archives.getArchivesId());
        if ("0".equals(archives1.getRequestFlag())) {
            ModelAndView mv = new ModelAndView("/business/archives/archivesEditIndex");
            mv.addObject("head", "电子档案审查");
            mv.addObject("archives", archives1);
            mv.addObject("type", "2");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/business/archives/archivesEditRequestIndex");
            if("1".equals(archives1.getRequestFlag())){
                mv.addObject("head", "电子档案变更申请审批");
            }else {
                mv.addObject("head", "审核");
            }
            mv.addObject("archives", archives1);
            mv.addObject("audit", "audit");
            mv.addObject("type", "2");
            return mv;
        }
    }

    //新增和修改
    @RequestMapping("/archives/editArchives")
    public ModelAndView editArchives(Archives archives, String ptyh) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesEdit");
        String role = archives.getRole();
        if (("").equals(archives.getArchivesId()) || archives.getArchivesId() == null) {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            archives.setRequestDate(date);
            if (ptyh.equals("true")) {
                archives.setRequestFlag("6");
            } else {
                archives.setRequestFlag("7");
            }
            archives.setCreator(archivesService.getPersonNameById(CommonUtil.getPersonId()));
            archives.setCreateDept(archivesService.getDeptNameById(CommonUtil.getDefaultDept()));
            mv.addObject("head", "新增");
            mv.addObject("archives", archives);
        } else {
            archives = archivesService.getArchivesById(archives.getArchivesId());
            mv.addObject("head", "修改");
        }
        mv.addObject("archives", archives);
        mv.addObject("role", role);
        mv.addObject("ptyh", ptyh);
        return mv;
    }

    //新增和修改
    @RequestMapping("/archives/editArchivesManager")
    public ModelAndView editArchivesManager(Archives archives) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesEdit");
        String role = archives.getRole();
        if (("").equals(archives.getArchivesId()) || archives.getArchivesId() == null) {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            archives.setRequestDate(date);
            archives.setRequestFlag("7");
            archives.setCreator(archivesService.getPersonNameById(CommonUtil.getPersonId()));
            archives.setCreateDept(archivesService.getDeptNameById(CommonUtil.getDefaultDept()));
            mv.addObject("head", "新增");
            mv.addObject("archives", archives);
        } else {
            archives = archivesService.getArchivesById(archives.getArchivesId());
            archives.setRequestFlag("5");
            mv.addObject("head", "修改");
        }
        mv.addObject("archives", archives);
        mv.addObject("role", role);
        mv.addObject("ptyh", false);
        return mv;
    }

    //保存
    @ResponseBody
    @RequestMapping("/archives/saveArchives")
    public Message saveArchives(Archives archives, String ptyh, String menuType) {
        String oneLevelName = archivesService.getArchivesName(archives.getOneLevel());
        if (null == archives.getArchivesId() || archives.getArchivesId().equals("")) {
            String archivesCode = CommonUtil.getDefaultDept().substring(4, 6) +//部门
                    ("" + archives.getRequestDate()).substring(2, 4) +//申请年份
                    archives.getSchoolType() +//新增编号中的 大专或者中专学校类别
                    oneLevelName.substring(0,2)+//一级类别
                    archives.getTwoLevel().substring(3, 6) +//二级类别
                    archives.getFileType() +//档案类型
                    ("" + archives.getRequestDate()).substring(5, 7) +//月份
                    ("" + archives.getRequestDate()).substring(8, 10);//日期
            if (null == archives.getLevel() || archives.getLevel().equals("")) {
                archives.setArchivesId(CommonUtil.getUUID());
            } else {
                archives.setArchivesId(archives.getLevel());
            }
            archives.setArchivesCode(archivesCode);
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setDeptCode(CommonUtil.getDefaultDept());
            archives.setOperateType("9");
            archives.setRequestFlag("6");
//            if(menuType != null && menuType=="11"){
//                archives.setRequestFlag("6");
//            }else {
//                if(ptyh.equals("true") && null!=ptyh){
//                    archives.setRequestFlag("6");
//                }else {
//                    archives.setRequestFlag("7");
//                }
//            }
            archivesService.insertArchives(archives);
            String arcode = archivesService.getArchivesCode(archives.getArchivesId());
            archives.setArchivesCode(arcode);
            String pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "新增的此电子档案信息。");
            archivesService.insertArchivesLog(archives);
            archives.setSchoolCode(archivesService.getStaffBelongs(CommonUtil.getPersonId()));
            return new Message(1, "新增成功", "success");
        } else {
//            String old = archives.getArchivesCode().substring(0, 15);
//            if (archivesCode.equals(old)) {
//                archives.setArchivesCode("");
//            }
            String a = archives.getOneLevel().substring(1,3);
            String archivesCode = CommonUtil.getDefaultDept().substring(4, 6) +//部门
                    ("" + archives.getRequestDate()).substring(2, 4) +//申请年份
                    archives.getSchoolType() +//新增编号中的 大专或者中专学校类别
                    oneLevelName.substring(0,2)+//一级类别
                    archives.getTwoLevel().substring(3, 6) +//二级类别
                    archives.getFileType() +//档案类型
                    ("" + archives.getRequestDate()).substring(5, 7) +//月份
                    ("" + archives.getRequestDate()).substring(8, 10);//日期
            archives.setChanger(CommonUtil.getPersonId());
            archives.setChangeDept(CommonUtil.getDefaultDept());
            archives.setOperateType("10");
            archives.setArchivesCode(archivesCode);
            archivesService.updateArchives(archives);
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            String arcode = archivesService.getArchivesCode(archives.getArchivesId());
            archives.setArchivesCode(arcode);
            String pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "修改的此电子档案信息。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "修改成功", "success");
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/archives/deleteArchivesById")
    public Message deleteArchivesById(String archivesId, String archivesCode, String archivesName) {
        archivesService.deleteFileByArchivesId(archivesId);
        archivesService.deleteArchivesById(archivesId);
        Archives archives = new Archives();
        if (archivesName != null && archivesName != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archivesName, "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setArchivesCode(archivesCode);
        archives.setArchivesId(archivesId);
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setOperateType("4");
        String pname = empService.getPersonNameById(CommonUtil.getPersonId());
        archives.setRemark(pname + "删除了此电子档案信息。");
        archivesService.insertArchivesLog(archives);
        return new Message(1, "删除成功", null);
    }

    //移动至回收站
    @ResponseBody
    @RequestMapping("/archives/updateArchivesDelStateById")
    public Message updateArchivesById(Archives archives) {
        archivesService.updateArchivesDelStateById(archives);
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        if (archives.getDelState().equals("1")) {
            archives.setOperateType("5");
            String remark = empService.getPersonNameById(CommonUtil.getPersonId()) + "将此档案移至回收站。";
            archives.setRemark(remark);
            archivesService.insertArchivesLog(archives);
            return new Message(1, "已移动至回收站", null);
        } else {
            archives.setOperateType("7");
            String remark = empService.getPersonNameById(CommonUtil.getPersonId()) + "将此档案恢复至初始列表。";
            archives.setRemark(remark);
            archivesService.insertArchivesLog(archives);
        }
        return new Message(1, "已恢复至初始列表", null);
    }

    //电子档案回收站
    @RequestMapping("/archives/recycleBinArchivesList")
    public ModelAndView recycleBinArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListRecycleBin");
        return mv;
    }

    //获得个人回收站
    @ResponseBody
    @RequestMapping("/archives/getArchivesRecycleBinList")
    public Map<String, List<Archives>> getArchivesRecycleBinList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
//        archives.setCreator(CommonUtil.getPersonId());

        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        List l = empService.getEmpRole(personId,deptId);
        if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){
            archives.setCreator("");
        }else if (l.contains("9e7ff02e-74ef-4e6c-9a25-31d1dbbd1a7e")){
            archives.setCreateDept(deptId);
        }else {
            archives.setCreator(personId);
        }
        List<Archives> list = archivesService.getArchivesRecycleBinList(archives);
        for (int i = 0; i < list.size(); i++) {
            String aid = list.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            list.get(i).setFileNum(fnum);
        }
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/archives/getArchivesDeptAndPersonTree")
    public List<EmpDeptTree> getDeptAndPersonTree(EmpDeptTree edt) {
        edt.setCreateDept(CommonUtil.getDefaultDept());
        List<EmpDeptTree> trees = archivesService.getArchivesDeptAndPersonTree(edt);
        EmpDeptTree root = new EmpDeptTree();
        root.setName("组织机构");
        root.setId("0");
        root.setpId("root");
        root.setOpen(true);
        root.setChecked("false");
        root.setIsper("false");
        if (edt.getFlag().equals("") || edt.getFlag() == null) {
            trees.add(root);
        }
        return trees;
    }

    //分配权限
    @RequestMapping("/archives/archivesPerRole")
    public ModelAndView rolePerRelationByRole(String archivesId) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesPerRole");
        mv.addObject("archivesId", archivesId);
        mv.addObject("head", "电子档案授权");
        return mv;
    }

    //  查看权限
    @RequestMapping("/archives/archivesPerRoleView")
    public ModelAndView archivesPerRoleView(String archivesId) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesPerRoleView");
        mv.addObject("archivesId", archivesId);
        mv.addObject("head", "电子档案授权查看");
        return mv;
    }

    //获得所有电子档案id
    @ResponseBody
    @RequestMapping("/archives/allArchivesId")
    public Message allArchivesId(Archives arc) {
        arc.setValidFlag("1");
        arc.setRequestFlag("5");
        List<Archives> list = archivesService.allArchivesId(arc);
        String archivesId = null;
        for (Archives archives : list) {
            if (archivesId == null) {
                archivesId = archives.getArchivesId();
            } else {
                archivesId += "," + archives.getArchivesId();
            }
        }
        return new Message(1, archivesId, null);
    }

    //全部分配权限
    @RequestMapping("/archives/archivesAllRole")
    public String archivesAllRole(Model model, Archives arc) {
        String archivesId = null;
        arc.setValidFlag("1");
        arc.setRequestFlag("5");
        List<Archives> list = archivesService.allArchivesId(arc);
        for (Archives archives : list) {
            if (archivesId == null) {
                archivesId = archives.getArchivesId();
            } else {
                archivesId += "," + archives.getArchivesId();
            }
        }
        model.addAttribute("ids", archivesId.replaceAll("'", ""));
        return "/business/archives/archivesPerRole";
    }

    //批量分配权限
    @RequestMapping("/archives/archivesAllPerRole")
    public String archivesAllPerRole(String ids, Model model, String flag, String isAll) {
        String archivesId = null;
        if (isAll != null && "1".equals(isAll)) {
            Archives arc = new Archives();
            arc.setValidFlag("1");
            arc.setRequestFlag("5");
            List<Archives> list = archivesService.allArchivesId(arc);
            for (Archives archives : list) {
                if (archivesId == null) {
                    archivesId = archives.getArchivesId();
                } else {
                    archivesId += "," + archives.getArchivesId();
                }
            }
            model.addAttribute("ids", archivesId.replaceAll("'", ""));
        } else {
            model.addAttribute("ids", ids.replaceAll("'", ""));
        }
        model.addAttribute("flag", flag);
        return "/business/archives/archivesPerRole";
    }

    //批量权限收回
    @ResponseBody
    @RequestMapping("/archives/archivesRoleTakeBack")
    public Message archivesRoleTakeBack(String ids) {
        String[] id = ids.split(",");
        if (id.length > 1) {
            for (int i = 0; i < id.length; i++) {
                archivesService.archivesRoleTakeBack(id[i]);
                archivesService.updateArchivesRoleState(id[i]);
            }
        } else {
            archivesService.archivesRoleTakeBack(id[0]);
            archivesService.updateArchivesRoleState(id[0]);
        }
        return new Message(1, "收回成功！", null);
    }

    //批量权限收回
    @ResponseBody
    @RequestMapping("/archives/archivesChangeState")
    public Message archivesChangeState(String ids) {
        String[] id = ids.split(",");
        if (id.length > 0) {
            for (int i = 0; i < id.length; i++) {
                archivesService.updateArchivesState(id[i]);
            }
        }
        return new Message(1, "退回成功！", null);
    }

    //批量移入回收站
    @ResponseBody
    @RequestMapping("/archives/archivesAllrecycleBin")
    public Message archivesAllrecycleBin(String ids) {
        String[] id = ids.split(",");
        Archives archives = new Archives();
        archives.setDelState("1");
        archives.setChanger(CommonUtil.getPersonId());
        archives.setChangeDept(CommonUtil.getDefaultDept());
        if (id.length > 1) {
            for (int i = 0; i < id.length; i++) {
                archives.setArchivesId(id[i]);
                archivesService.updateArchivesDelStateById(archives);
            }
        } else {
            archives.setArchivesId(id[0]);
            archivesService.updateArchivesDelStateById(archives);
        }
        return new Message(1, "删除成功！", null);
    }

    //批量删除
    @ResponseBody
    @RequestMapping("/archives/archivesAlldel")
    public Message archivesAlldel(String ids) {
        String[] id = ids.split(",");
        if (id.length > 1) {
            for (int i = 0; i < id.length; i++) {
                archivesService.deleteFileByArchivesId(id[i]);
                archivesService.deleteArchivesById(id[i]);
            }
        } else {
            archivesService.deleteFileByArchivesId(id[0]);
            archivesService.deleteArchivesById(id[0]);
        }
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/archives/savePerRelation")
    public Message savePerRelation(String archivesId, String checkList, String ids) {
        if (ids.equals("") || ids.equals(null)) {
            archivesService.delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(archivesId, checkList);
            archivesService.updateRoleState(archivesId);
        } else {
            String[] id = ids.split(",");
            for (int i = 0; i < id.length; i++) {
                archivesService.delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(id[i], checkList);
                archivesService.updateRoleState(id[i]);
            }
        }
        return new Message(1, "保存成功！", null);
    }

    //模糊查询部门名称
    @ResponseBody
    @RequestMapping("/archives/selectDept")
    public List<AutoComplete> selectDept() {
        return archivesService.selectDept();
    }

    //模糊查询申请人姓名
    @ResponseBody
    @RequestMapping("/archives/getPerson")
    public List<AutoComplete> getPerson() {
        return archivesService.selectPerson();
    }

    //查创建人
    @ResponseBody
    @RequestMapping("/archives/getRequester")
    public List<AutoComplete> getRequester() {
        return archivesService.selectRequester(CommonUtil.getDefaultDept());
    }

    //获取部门选项
    @ResponseBody
    @RequestMapping("/archives/getDeptList")
    public List<Select2> getDeptList() {
        return archivesService.getDeptList();
    }

    /**
     * 文件上传跳转
     */
    @RequestMapping("/archives/uploadFiles")
    public ModelAndView uploadFiles(String archivesId, String flag, String role, String archivesName, String archivesCode) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesUploadFiles");
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        if (archivesName != null && archivesName != "") {
            try {
                archivesName = URLDecoder.decode(archivesName, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        Archives archives = archivesService.getArchivesById(archivesId);
        mv.addObject("head", "附件上传");
        mv.addObject("archivesId", archivesId);
        mv.addObject("archivesName", archivesName);
        mv.addObject("archivesCode", archivesCode);
        mv.addObject("fileType", archives.getFileType());
        mv.addObject("flag", files.size());
        mv.addObject("files", files);
        mv.addObject("role", role);
        return mv;
    }

    @RequestMapping("/archives/preview")
    public ModelAndView preview(String archivesId, String flag, String role,String authFlag) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesMainPreview");
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        mv.addObject("head", "附件下载及预览");
        mv.addObject("archivesId", archivesId);
        mv.addObject("flag", files.size());
        mv.addObject("files", files);
        mv.addObject("role", role);
        mv.addObject("authFlag", authFlag);
        return mv;
    }

    @RequestMapping("/archivesPrivate/getPrivateArchivesView")
    public ModelAndView getPrivateArchivesView(HttpServletRequest request, String fileId, String archivesId) {
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesPreview");
        mv.addObject("fileId", fileId);
        Files archivesFile = archivesService.getFileById(fileId);

        if (archivesFile != null) {
            String fileView = archivesFile.getFileUrl();
            String fileType = archivesFile.getFileType();
            if (".txt.docx.doc.xls.xlsx.pptx.ppt.pdf.TXT.DOCX.DOC.XLS.XLSX.PPTX.PPT.PDF.".indexOf("." + fileType + ".") != -1) {
                // 文本
                fileView = fileView.replace("." + fileType, ".pdf");
                mv.addObject("fileView", request.getContextPath() + fileView);
                mv.addObject("fileFormat", "1");
            } else if (".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.WMF.BMP.JPG.PNG.TIFF.GIF.PCX.TGA.EXIF.FPX.SVG.PSD.CDR.PCD.DXF.UFO.EPS.AI.RAW.".indexOf("." +
                    fileType + ".") != -1) {
                // 图片
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "2");
            } else if (".mp3.wmv.MP3.WMV.".indexOf("." + fileType + ".") != -1) {
                // 音频
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "3");
            } else if (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.AVI.WMV.MPEG.MP4.MOV.MKV.FLV.F4V.M4V.RMVB.RM.3GP.DAT.TS.MTS.VOB.".indexOf("." + fileType + "" +
                    ".") != -1) {
                // 视频
                fileView = fileView.replace("." + fileType, ".mp4");
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "4");
            } else {
                mv.addObject("fileFormat", "");
            }
        }
        mv.addObject("head", "");
        mv.addObject("fileId", fileId);
        mv.addObject("archivesFile", archivesFile);
        mv.addObject("fileUrl", archivesFile.getFileUrl());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getFilesByArchivesId")
    public Map getFilesByArchivesId(String archivesId) {
        return CommonUtil.tableMap(archivesService.getFilesByBusinessId(archivesId));
    }

    @ResponseBody
    @RequestMapping("/archives/getFilesByArchivesId2")
    public Map getFilesByArchivesId2(String archivesId) {
        return CommonUtil.tableMap(archivesService.getFilesByArchivesId(archivesId));
    }

    public static String COM_REPORT_PATH = null;

    @Resource
    private WordUtil wordUtil;

    @ResponseBody
    @RequestMapping("/archives/insertArchivesFiles")
    public void insertArchivesFiles(@RequestParam(value = "files[]", required = false) MultipartFile files[],
                                    HttpServletRequest request, String archivesId, String archivesName, String archivesCode,
                                    String flag, String role) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";
        for (MultipartFile file : files) {
            final String fileName = file.getOriginalFilename();
            String path = String.format(urlParten, sdf.format(new Date()));
            final String uuid = CommonUtil.getUUID();
            final String url = path + "/" + uuid + fileName.substring(fileName.lastIndexOf("."));
            FileOutputStream fos = null;
            try {
                File f = new File(COM_REPORT_PATH + path);
                f.mkdirs();
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(file.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    wordUtil.init();
                    wordUtil.wordToPdf(COM_REPORT_PATH + url);
                }
            });
            t.start();
            ArchivesFile uploadFile = new ArchivesFile();
            Archives archives = new Archives();
            uploadFile.setArchivesId(archivesId);
            uploadFile.setFileName(fileName);
            uploadFile.setFileUrl(url);
            uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
            uploadFile.setCreator(CommonUtil.getPersonId());
            uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            archivesService.insertArchivesFile(uploadFile);
            archives.setArchivesId(archivesId);
            archives.setArchivesCode(archivesCode);
            if (archivesName != null && archivesName != "") {
                try {
                    archives.setArchivesName(URLDecoder.decode(archivesName, "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setOperateType("2");
            String remark = empService.getPersonNameById(CommonUtil.getPersonId()) + "上传了附件。";
            archives.setRemark(remark);
            archivesService.insertArchivesLog(archives);
        }
    }

    @ResponseBody
    @RequestMapping("/archives/downloadArchivesFile")
    public void downloadArchivesFile(String archivesId, String fileId, HttpServletResponse response) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
//        Files archivesFile = filesService.getFileById(fileId);
        ArchivesFile archivesFile = archivesService.getArchivesFileByFileId(fileId);
        String filePath = COM_REPORT_PATH + archivesFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(archivesFile.getFileName(), "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    @ResponseBody
    @RequestMapping("/archives/deleteFileByFileId")
    public Message deleteFileByFileId(String fileId) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        ArchivesFile file = archivesService.getArchivesFileById(fileId);
        File f = new File(COM_REPORT_PATH + file.getFileUrl());
        f.delete();
        archivesService.deleteFileByFileId(fileId);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 操作记录查看
     */
    @RequestMapping("/archives/archivesLog")
    public ModelAndView archivesLog() {
        ModelAndView mv = new ModelAndView("/business/archives/archivesLog");
        return mv;
    }

    /**
     * 操作记录查询
     */
    @ResponseBody
    @RequestMapping("/archives/getArchivesLogList")
    public Map<String, List<Archives>> searchComputer(Archives archives) {
        Map<String, List<Archives>> softMap = new HashMap<String, List<Archives>>();
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        List<Archives> archivesLogList = archivesService.getArchivesLogList(archives);
        softMap.put("data", archivesLogList);
        return softMap;
    }

    //教师档案变更申请
    //逻辑删除申请
    @ResponseBody
    @RequestMapping("/archives/updateValidFlag")
    public Message updateValidFlag(Archives archives) {
        archives.setValidFlag("0");
        archivesService.updateValidFlag(archives);
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setOperateType("4");
        archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "将此档案移到了回收站中。");
        archivesService.insertArchivesLog(archives);
        return new Message(1, "档案已移动到回收站中", null);
    }

    @ResponseBody
    @RequestMapping("/archives/archivesDelete")
    public Message archivesDelete(String archivesId) {
        archivesService.deleteArchivesById(archivesId);
        return new Message(1, "档案已删除", null);
    }

    //申请页面
    @ResponseBody
    @RequestMapping("/archives/archivesEditRequest")
    public ModelAndView archivesEditRequest(String archivesId) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesEditRequest");
        mv.addObject("head", "申请");
        mv.addObject("archives", archivesService.getArchivesById(archivesId));
        return mv;
    }

    //审核页面
    @RequestMapping("/archives/archivesEditAudit")
    public ModelAndView archivesEditAudit(Archives archives) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesEditRequest");
        String archivesId = archives.getArchivesId();
        mv.addObject("archives", archivesService.getArchivesById(archivesId));
        mv.addObject("head", "审核");
        mv.addObject("audit", "audit");
        return mv;
    }

    //审核页面
    @RequestMapping("/archives/archivesAudit")
    public ModelAndView archivesAudit(Archives archives) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesRequest");
        String archivesId = archives.getArchivesId();
        mv.addObject("archives", archivesService.getArchivesById(archivesId));
        mv.addObject("head", "审核");
        mv.addObject("audit", "audit");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/saveArchivesRequest")
    public Message saveArchivesRequest(Archives archives) {
        if (archives.getRequestFlag() != "5" && archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        if ("0".equals(archives.getRequestFlag())) {
            archivesService.archivesRequestFlag(archives);
            archives.setOperateType("8");
            archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "提交了此档案。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "档案已提交", null);
        } else if ("5".equals(archives.getRequestFlag())) {
            archivesService.updateArchivesRemark(archives);
            archives.setOperateType("6");
            archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "审核了此档案。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "审查通过", null);
        } else if ("4".equals(archives.getRequestFlag())) {
            archivesService.archivesRequestFlag(archives);
            archives.setOperateType("6");
            archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "驳回了此档案。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "已驳回提交", null);
        } else if ("2".equals(archives.getRequestFlag())) {
            archivesService.updateArchivesRemark(archives);
            archives.setOperateType("6");
            archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "审核了此档案。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "已通过该申请", null);
        }

        if (archives.getReason() != null) {
            archivesService.archivesEditRequest(archives);
            archives.setOperateType("8");
            archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "申请了此档案。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "申请成功", null);
        } else {
            if ("2".equals(archives.getRequestFlag()) || (archives.getRequestFlag()).equals("7")) {
                archivesService.updateArchivesRemark(archives);
                archives.setOperateType("6");
                archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "审核了此档案。");
                archivesService.insertArchivesLog(archives);
                return new Message(1, "已通过该申请", null);
            } else {
                archivesService.archivesRequestFlag(archives);
                archives.setOperateType("6");
                archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "驳回了此档案。");
                archivesService.insertArchivesLog(archives);
                return new Message(1, "已驳回该申请", null);
            }
        }
    }

    /**
     * 导出数据
     *
     * @param response
     */
    @ResponseBody
    @RequestMapping("/archives/expList")
    public void exportStudent(Archives archives, HttpServletResponse response) {
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getDeptName() != null && archives.getDeptName() != "") {
            try {
                archives.setDeptName(URLDecoder.decode(archives.getDeptName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        if("undefined".equals(archives.getRoleState())){
            archives.setRoleState("");
        }
        List<Archives> archivesList = archivesService.getAllArchivesList(archives);
        for (int i = 0; i < archivesList.size(); i++) {
            String aid = archivesList.get(i).getArchivesId();
            String fnum = archivesService.getFileNum(aid);
            archivesList.get(i).setFileNum(fnum);
        }
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("电子档案基本信息");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        row1.createCell(0).setCellValue("档案编码");
        row1.createCell(1).setCellValue("创建部门");
        row1.createCell(2).setCellValue("创建人");
        row1.createCell(3).setCellValue("一级类别");
        row1.createCell(4).setCellValue("二级类别");
        row1.createCell(5).setCellValue("档案类型");
        row1.createCell(6).setCellValue("档案名称");
        row1.createCell(7).setCellValue("附件数量");
        tmp++;
        int i = 1;
        for (Archives salaryObj : archivesList) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(salaryObj.getArchivesCode());
            row.createCell(1).setCellValue(salaryObj.getCreateDept());
            row.createCell(2).setCellValue(salaryObj.getCreator());
            row.createCell(3).setCellValue(salaryObj.getOneLevel());
            row.createCell(4).setCellValue(salaryObj.getTwoLevel());
            row.createCell(5).setCellValue(salaryObj.getFileType());
            row.createCell(6).setCellValue(salaryObj.getArchivesName());
            row.createCell(7).setCellValue(salaryObj.getFileNum());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("电子档案信息.xls", "utf-8"));
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

    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/archives/printArchives")
    public ModelAndView printArchives(Archives archives) {
        if (archives.getArchivesName() != null && archives.getArchivesName() != "") {
            try {
                archives.setArchivesName(URLDecoder.decode(archives.getArchivesName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getPersonName() != null && archives.getPersonName() != "") {
            try {
                archives.setPersonName(URLDecoder.decode(archives.getPersonName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (archives.getDeptName() != null && archives.getDeptName() != "") {
            try {
                archives.setDeptName(URLDecoder.decode(archives.getDeptName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getAllArchivesList(archives);
        ModelAndView mv = new ModelAndView("/business/archives/printArchives");
        mv.addObject("list", list);
        return mv;
    }

    /**
     * 移动端主页
     */
    @RequestMapping("/archives/appArchivesList")
    public ModelAndView appArchivesList() {
        ModelAndView mv = new ModelAndView("/app/synergy/archives/appArchivesList");
        //List list = roleService.
        TableDict tableDict = new TableDict();
        tableDict.setId(" wm_concat(distinct role_id) ");
        tableDict.setText(" '' ");
        tableDict.setTableName(" T_RS_EMPLOYEE_DEPT_ROLE ");
        tableDict.setWhere("where 1=1");
        tableDict.setWhere(" where person_id = '" + CommonUtil.getPersonId() + "' and " +
                " role_id in ('39f68830-c435-49fe-8bfd-5415b8302bc8', 'b34d00b3-bcde-4600-9d4c-a48906c7d750'," +
                "'59c7bbf4-7755-4940-a05e-c3becb3f3f54', '9def9bc7-e04e-4053-abb7-d37c03cb945d' , " +
                "'04734ef5-943f-442d-9507-23c249871f7f' ) ");
        List<Select2> selectList = commonService.getTableDict(tableDict);
        String roles = "";
        if (selectList != null && selectList.size() > 0 && selectList.get(0) != null) {
            Select2 a = selectList.get(0);
            roles = a.getId();
        }
        String ptyh = "false";
        String bmzr = "false";
        String dagl = "false";
        String xld = "false";
        String dxz = "false";
        if (roles.indexOf("39f68830-c435-49fe-8bfd-5415b8302bc8") > -1)
            ptyh = "true";
        if (roles.indexOf("b34d00b3-bcde-4600-9d4c-a48906c7d750") > -1)
            bmzr = "true";
        if (roles.indexOf("59c7bbf4-7755-4940-a05e-c3becb3f3f54") > -1)
            dagl = "true";
        if (roles.indexOf("9def9bc7-e04e-4053-abb7-d37c03cb945d") > -1)
            xld = "true";
        if (roles.indexOf("04734ef5-943f-442d-9507-23c249871f7f") > -1)
            dxz = "true";
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);
        return mv;
    }

    /**
     * 移动端副页
     */
    @RequestMapping("/archives/appArchivesInfo")
    public ModelAndView appArchivesInfo(String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
//        roleService.
        ModelAndView mv = new ModelAndView();
        if (menuType.equals("1")) {
            mv.setViewName("/app/synergy/archives/appArchivesInfo");
        } else if (menuType.equals("2")) {
            mv.setViewName("/app/synergy/archives/appArchivesChange");
        } else if (menuType.equals("3")) {
            mv.setViewName("/app/synergy/archives/appArchivesSearch");
        } else if (menuType.equals("4")) {
            mv.setViewName("/app/synergy/archives/appArchivesSearch");
        }
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/appArchivesInfoList")
    public ModelAndView appArchivesInfoList(String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView();
        Archives archives = new Archives();
        archives.setValidFlag("1");
        if (menuType.equals("11")) {
            archives.setLevel(menuType);
        }
//        List<Archives> archivesList = archivesService.getArchivesList(archives);
        mv.setViewName("/app/synergy/archives/appArchivesInfoList");
        String emJson = getArchivesName(1, menuType, "", "");
//        mv.addObject("archivesList",archivesList);
        mv.addObject("menuType", menuType);
        mv.addObject("emJson", emJson);
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);
        return mv;
    }

    /**
     * 列出列表
     */
    @ResponseBody
    @RequestMapping("/archives/getArchivesName")
    public String getArchivesName(int page, String menuType,
                                  String requestFlag, String roleState) {
        Archives archives = new Archives();
        archives.setValidFlag("1");
        if (menuType.equals("1")) {
            archives.setCreator(CommonUtil.getPersonId());
            List<Archives> archivesList = archivesService.getArchivesList(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("12")) {
            if (null != requestFlag && !requestFlag.equals("")) {
                archives.setRequestFlag(requestFlag);
            }
            if (null != roleState && !roleState.equals("")) {
                archives.setRoleState(roleState);
            }
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setCreatePerson(CommonUtil.getPersonId());
            List<Archives> archivesList = archivesService.getArchivesListBumen(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("2")) {
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setRequestFlag("1");
            List<Archives> archivesList = archivesService.getArchivesList(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("31")) {
            archives.setRoleFlag("1");
            archives.setCreateDept(CommonUtil.getDefaultDept());
            List<Archives> archivesList = archivesService.getAllArchivesList(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("32")) {
            archives.setCreateDept(CommonUtil.getDefaultDept());
            List<Archives> archivesList = archivesService.getAllArchivesList(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("14")) {
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            List<Archives> archivesList = archivesService.getArchivesRecycleBinList(archives);
            return getJsonTaskList(archivesList, page);
        } else if (menuType.equals("13")) {
            archives.setCreatePerson(CommonUtil.getPersonId());
            archives.setRoleFlag("2");
            if (null != requestFlag && !requestFlag.equals("")) {
                archives.setRequestFlag(requestFlag);
            }
            if (null != roleState && !roleState.equals("")) {
                archives.setRoleState(roleState);
            }
            String personId = CommonUtil.getPersonId();
            String deptId = CommonUtil.getDefaultDept();
            List l = empService.getEmpRole(personId,deptId);
            archives.setCreatePerson(personId);
            archives.setRoleFlag("2");
            if (l.contains("9def9bc7-e04e-4053-abb7-d37c03cb945d")){//校领导（管辖范围）
                /* List<EmpRange> sfcz=empRangeService.getEmpRangeListByPersonId(personId);//查询是否有管辖范围*/
                if(l.contains("04734ef5-943f-442d-9507-23c249871f7f")) {
                    archives.setRoleFlag("2");
                }else {
                    archives.setRoleFlag("1");
                }
            }
            List<Archives> archivesList = archivesService.getArchivesListLingDao(archives);
            return getJsonTaskList(archivesList, page);
        } else {
            if (menuType.equals("11")) {
                archives.setLevel(menuType);
                if (null != requestFlag && !requestFlag.equals("")) {
                    archives.setRequestFlag(requestFlag);
                }
                if (null != roleState && !roleState.equals("")) {
                    archives.setRoleState(roleState);
                }
            }
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            List<Archives> archivesList = archivesService.getArchivesList(archives);
            return getJsonTaskList(archivesList, page);
        }
    }

    /**
     * 向前台jsp传数据
     */
    public String getJsonTaskList(List<Archives> archivesList, int page) {

        int from = (page - 1) * 10;
        int end = page * 10;
        int len = archivesList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len + 10 : from;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len : end;
        String str = "";
        boolean b = true;
        for (int i = from; i < end; i++) {
            Archives archives = archivesList.get(i);
            String title = archives.getArchivesCode();
            String personname, archivesId, operateType;
            String arname = archives.getArchivesName();
            String rfs = archives.getRequestFlagShow();
            String roleState = archives.getRoleState();
            if (archives.getLogId() == null || archives.getLogId().equals("")) {
                archivesId = archives.getArchivesId();
            } else {
                archivesId = archives.getLogId();
            }
            if (archives.getCreator() == null || archives.getCreator().equals("")) {
                personname = archives.getPersonId();
            } else {
                personname = archives.getCreator();
            }
            if (arname == null || arname.equals("")) {
                arname = "无";
            }
            if (rfs == null || rfs.equals("")) {
                rfs = "无";
            }
            if (roleState == null || roleState.equals("")) {
                roleState = "无";
            }
            if (archives.getOperateType() == null || archives.getOperateType().equals("")) {
                operateType = "无";
            } else {
                operateType = archives.getOperateType();
            }
            try {
                rfs = URLEncoder.encode(rfs, "UTF-8");
                personname = URLEncoder.encode(personname, "UTF-8");
                arname = URLEncoder.encode(arname, "UTF-8");
                operateType = URLEncoder.encode(operateType, "UTF-8");
                roleState = URLEncoder.encode(roleState, "UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String obj = "{\"archivesCode\":\"" + title + "\", \"archivesId\":\"" + archivesId + "\"" +
                    ",\"creator\":\"" + personname + "\",\"roleState\":\"" + roleState + "\",\"archivesName\":\"" + arname +
                    "\",\"operateType\":\"" + operateType +
                    "\",\"requestFlagShow\":\"" + rfs + "\"}";
            if (b) {
                str = obj;
                b = false;
            } else {
                str = str + "," + obj;
            }
        }
        return "[" + str + "]";
    }

    @ResponseBody
    @RequestMapping("/archives/getArchivesInfo")
    public ModelAndView getArchivesInfo(String archivesId, String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView();
        Archives archives = archivesService.getPrintById(archivesId);
        if (menuType.equals("11") || menuType.equals("12") || menuType.equals("13")) {
            mv.addObject("ptyh", ptyh);
            mv.addObject("bmzr", bmzr);
            mv.addObject("dagl", dagl);
            mv.addObject("xld", xld);
            mv.addObject("dxz", dxz);

            mv.setViewName("/app/synergy/archives/appArchives");
            List<ArchivesFile> list = archivesService.getFilesByArchivesId(archivesId);
            if (null == list)
                mv.addObject("filesFlag", "0");
            else
                mv.addObject("filesFlag", list.size());
            mv.addObject("list", list);
            mv.addObject("creator", CommonUtil.getLoginUser().getName());
        } else if (menuType.equals("21") || menuType.equals("2")) {
            mv.setViewName("/app/synergy/archives/appAuditArchives");
        } else if (menuType.equals("14")) {
            mv.setViewName("/app/synergy/archives/appRecoverArchives");
        } else {
            List<ArchivesFile> list = archivesService.getFilesByArchivesId(archivesId);
            mv.addObject("list", list);
            mv.setViewName("/app/synergy/archives/appSearchArchives");
        }
        mv.addObject("archives", archives);
        mv.addObject("menuType", menuType);
        mv.addObject("loginuser", CommonUtil.getPersonId());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getFilesByBusinessId")
    public Map getFilesByBusinessId(String businessId) {
        return CommonUtil.tableMap(archivesService.getFilesByArchivesId(businessId));
    }

    @ResponseBody
    @RequestMapping("/archives/appAddArchives")
    public ModelAndView appAddArchives(String archivesId, String menuType, String ptyh) {
        ModelAndView mv = new ModelAndView();
        Archives archives = new Archives();
        String role = archives.getRole();
        if (archivesId == null || archivesId.equals("")) {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            archives.setArchivesId(CommonUtil.getUUID());
            archives.setRequestDate(date);
            archives.setCreator(archivesService.getPersonNameById(CommonUtil.getPersonId()));
            archives.setCreateDept(archivesService.getDeptNameById(CommonUtil.getDefaultDept()));
            mv.setViewName("/app/synergy/archives/appAddArchives");
        } else {
            archives = archivesService.getPrintById(archivesId);
            mv.setViewName("/app/synergy/archives/appEditArchives");
        }
        mv.addObject("archives", archives);
        mv.addObject("menuType", menuType);
        mv.addObject("role", role);
        mv.addObject("ptyh", ptyh);
        return mv;
    }

    //申请页面
    @ResponseBody
    @RequestMapping("/archives/appArchivesRequest")
    public ModelAndView appArchivesRequest(String archivesId, String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView("/app/synergy/archives/appRequestArchives");
        mv.addObject("archives", archivesService.getArchivesById(archivesId));
        if (menuType.equals("12") || menuType.equals("2")) {
            mv.addObject("audit", "audit");
        }
        mv.addObject("menuType", menuType);
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);

        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/updateArchivesRemark")
    public Message updateArchivesRemark(Archives archives) {
        archivesService.updateArchivesRemark(archives);
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setOperateType("6");
        archives.setRemark(empService.getPersonNameById(CommonUtil.getPersonId()) + "驳回了此档案。");
        archivesService.insertArchivesLog(archives);
        return new Message(1, "已驳回申请", "success");
    }

    @ResponseBody
    @RequestMapping("/archives/checkArchivesPerson")
    public Message checkArchivesPerson(Archives archives) {
        if (archives.getCreator().equals(CommonUtil.getPersonName())) {
            return new Message(0, null, null);
        }
        return new Message(1, "抱歉，您没有权限执行该操作！", "error");
    }

    /**
     * 移动端操作日志列表页
     */
    @ResponseBody
    @RequestMapping("/archives/appArchivesLogList")
    public ModelAndView appArchivesLogList(String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/synergy/archives/appArchivesLogList");
        String emJson = getAppArchivesLog(1, menuType);
        mv.addObject("menuType", menuType);
        mv.addObject("emJson", emJson);
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);
        return mv;
    }

    /**
     * 移动端操作日志查询语句
     */
    @ResponseBody
    @RequestMapping("/archives/getAppArchivesLog")
    public String getAppArchivesLog(int page, String menuType) {
        Archives archives = new Archives();
        archives.setValidFlag("1");
        List<Archives> archivesList = archivesService.getArchivesLogList(archives);
        for (int i = 0; i < archivesList.size(); i++) {
            String acode = archivesList.get(i).getArchivesCode();
            String aid = archivesList.get(i).getArchivesId();
            if (acode == null || acode.equals("")) {
                Archives aa = archivesService.getArchivesById(aid);
                if (aa != null) {
                    acode = aa.getArchivesCode();
                    archivesList.get(i).setArchivesCode(acode);
                }
            }
        }
        return getJsonTaskList(archivesList, page);
    }

    /**
     * 移动端操作日志详情页
     */
    @ResponseBody
    @RequestMapping("/archives/appArchivesLogInfo")
    public ModelAndView appArchivesLogInfo(String archivesId) {
        ModelAndView mv = new ModelAndView();
        Archives archives = archivesService.getArchivesLogById(archivesId);
        if (archives.getArchivesName() == null || archives.getArchivesName().equals("")) {
            archives.setArchivesName("无");
        }
        mv.setViewName("/app/synergy/archives/appArchivesLogInfo");
        mv.addObject("archives", archives);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/searchArchives")
    public ModelAndView appArchives(String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);

        mv.setViewName("/app/synergy/archives/appArchivesSearchMenuList");
        String emJson = getArchivesList(1, ptyh, bmzr, dagl, xld, dxz, "");
        mv.addObject("menuType", menuType);
        mv.addObject("emJson", emJson);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/searchArchivesList")
    public ModelAndView appArchivesList(String menuType, String ptyh, String bmzr, String dagl, String xld, String dxz) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("ptyh", ptyh);
        mv.addObject("bmzr", bmzr);
        mv.addObject("dagl", dagl);
        mv.addObject("xld", xld);
        mv.addObject("dxz", dxz);

        mv.setViewName("/app/synergy/archives/appArchivesSearchList");
        String emJson = getArchivesList(1, ptyh, bmzr, dagl, xld, dxz, "");
        mv.addObject("menuType", menuType);
        mv.addObject("emJson", emJson);
        return mv;
    }

    /**
     * 列出列表
     */
    @ResponseBody
    @RequestMapping("/archives/getArchivesList")
    public String getArchivesList(int page, String ptyh, String bmzr, String dagl, String xld, String dxz,
                                  String roleState) {
        Archives archives = new Archives();
        if (null != roleState && !roleState.equals("")) {
            archives.setRoleState(roleState);
        }

        archives.setValidFlag("1");
        if (dxz.equals("true") || dagl.equals("true")) {
//            archives.setCreator(CommonUtil.getPersonId());
            archives.setRequestFlag("5");
        } else if (xld.equals("true")) {
            archives.setCreator(CommonUtil.getPersonId());
            archives.setValidFlag("1");
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setRoleFlag("1");
            List<Archives> list = archivesService.getAllArchivesList(archives);
            return getJsonTaskList(list, page);
        } else if (bmzr.equals("true")) {
            archives.setRequestFlag("5");
            archives.setCreateDept(CommonUtil.getDefaultDept());
        } else if (ptyh.equals("true")) {
            archives.setCreator(CommonUtil.getPersonId());
            archives.setRolePersonId(CommonUtil.getPersonId());
            archives.setRolePersonDept(CommonUtil.getDefaultDept());
        } else {
            archives.setCreator(CommonUtil.getPersonId());
        }
        List<Archives> archivesList = archivesService.getArchivesList(archives);
        return getJsonTaskList(archivesList, page);
    }

    //申请页面
    @ResponseBody
    @RequestMapping("/archives/appArchivesPower")
    public ModelAndView appArchivesPower(String archivesId) {
        ModelAndView mv = new ModelAndView("/app/synergy/archives/appArchivesPower");

        mv.addObject("archivesId", archivesId);
        mv.addObject("deptId", CommonUtil.getDefaultDept());
        mv.addObject("archives", archivesService.getArchivesById(archivesId));
        List<Emp> empList = archivesService.getPersonBydeptId(CommonUtil.getDefaultDept());
        List checkList = archivesService.getArchivesCheckEmp(archivesId, CommonUtil.getDefaultDept());

        for (Object personId : checkList) {
            for (Emp emp : empList) {
                if (personId.toString().equals(emp.getPersonId())) {
                    emp.setStaffStatusShow(" checked=\"checked\" ");
                    break;
                }
            }
        }

        mv.addObject("empList", empList);
        return mv;
    }

    //申请页面
    @ResponseBody
    @RequestMapping("/archives/saveArchivesPower")
    public Message saveArchivesPower(String deptId, String archivesId, String checkList) {
        archivesService.saveArchivesPower(deptId, archivesId, checkList);
        return new Message(1, "已保存", "success");
    }

    /**
     * 附件保存
     */
    @ResponseBody
    @RequestMapping("/archives/appFiles")
    public void appFiles(@RequestParam(value = "file", required = false) MultipartFile[] files, HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();
            String path = String.format(urlParten, request.getParameter("tableName"),
                    sdf.format(new Date()));
            String url = path + "/" + CommonUtil.getUUID()
                    + fileName.substring(fileName.indexOf("."));
            FileOutputStream fos = null;
            try {
                File f = new File(COM_REPORT_PATH + path);
                f.mkdirs();
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(file.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
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
            ArchivesFile uploadFile = new ArchivesFile();
            Archives archives = new Archives();
            uploadFile.setArchivesId(request.getParameter("archivesId"));
            uploadFile.setFileName(fileName);
            uploadFile.setFileUrl(url);
            uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
            uploadFile.setCreator(CommonUtil.getPersonId());
            uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            archivesService.insertArchivesFile(uploadFile);
            archives.setArchivesId(request.getParameter("archivesId"));
            if (request.getParameter("archivesName") != null && request.getParameter("archivesName") != "") {
                try {
                    archives.setArchivesName(URLDecoder.decode(request.getParameter("archivesName"), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setOperateType("2");
            String remark = archivesService.getPersonNameById(CommonUtil.getPersonId()) + "上传了附件。";
            archives.setRemark(remark);
            archivesService.insertArchivesLog(archives);
        }
    }

    @ResponseBody
    @RequestMapping("/archives/getCheckListCount")
    public String getCheckListCount() {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        TableDict tableDict = new TableDict();
        tableDict.setId(" wm_concat(distinct role_id) ");
        tableDict.setText(" '' ");
        tableDict.setTableName(" T_RS_EMPLOYEE_DEPT_ROLE ");
        tableDict.setWhere("where 1=1");
        tableDict.setWhere(" where person_id = '" + CommonUtil.getPersonId() + "' and " +
                " role_id in ('b34d00b3-bcde-4600-9d4c-a48906c7d750' ) ");
        List<Select2> selectList = commonService.getTableDict(tableDict);
        Archives archives = new Archives();
        archives.setValidFlag("1");
        archives.setRequestFlag("1");
        archives.setCreator(CommonUtil.getPersonId());
        if (null != selectList && selectList.size() != 0) {
            archives.setCreateDept(CommonUtil.getDefaultDept());
        }
        String count = archivesService.getCheckListCount(archives);
        if (null == count || count.equals("0")) {
            count = "0";
        }
        return count;
    }
}
