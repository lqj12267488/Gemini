package com.goisan.archives.controller;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.service.ArchivesService;
import com.goisan.archives.service.ArchivesTypeService;
import com.goisan.common.transcoding.WordUtil;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.SysDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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

    //教师角色电子档案维护页面
    @RequestMapping("/archives/archivesListTeacher")
    public ModelAndView archivesListTeacher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListTeacher");
        return mv;
    }

    //普通教师电子档案信息维护

    @ResponseBody
    @RequestMapping("/archives/getTeacherArchivesList")
    public Map<String, List<Archives>> getTeacherArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setCreator(CommonUtil.getPersonId());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getArchivesList(archives);
        if (archives.getOneLevel() != null && archives.getOneLevel() != "") {
            String one = "", two = "", file = "", year = "", typeName = "", pname = "";
            if (archives.getOneLevel() != "" || archives.getTwoLevel() != "" || archives.getFileType() != "" || archives.getYearCode() != "") {
                typeName = archivesTypeService.getTypeName(archives.getOneLevel());
                one = "一级类别：" + typeName + ",";
            } else {
                one = "一级类别：(未检索)";
            }
            if (archives.getTwoLevel() != "") {
                typeName = archivesTypeService.getTypeName(archives.getTwoLevel());
                two = "二级类别：" + typeName + ",";
            } else {
                two = "二级类别：(未检索)";
            }
            if (archives.getFileType() != "") {
                typeName = sysDicService.getDicName("DALX", archives.getFileType());
                file = "档案类型：" + typeName + ",";
            } else {
                file = "档案类型：(未检索)";
            }
            if (archives.getYearCode() != "" && archives.getYearCode() != null) {
                typeName = sysDicService.getDicName("ND", archives.getYearCode());
                year = "年份：" + typeName + "年,";
            } else {
                year = "年份：(未检索)";
            }
            pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "检索了条件为：" + one + two + file + year + "的档案信息");
            archives.setOperateType("5");
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setArchivesId("无");
            archivesService.insertArchivesLog(archives);
        }
        map.put("data", list);
        return map;
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
        mv.setViewName("/business/archives/archivesListDirector");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getDirectorArchivesList")
    public Map<String, List<Archives>> getDirectorArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getArchivesList(archives);
        if (archives.getOneLevel() != "" || archives.getTwoLevel() != "" || archives.getFileType() != "" || archives.getYearCode() != "") {
            String one = "", two = "", file = "", year = "", typeName = "", pname = "";
            if (archives.getOneLevel() != "") {
                typeName = archivesTypeService.getTypeName(archives.getOneLevel());
                one = "一级类别：" + typeName + ",";
            } else {
                one = "一级类别：(未检索)";
            }
            if (archives.getTwoLevel() != "") {
                typeName = archivesTypeService.getTypeName(archives.getTwoLevel());
                two = "二级类别：" + typeName + ",";
            } else {
                two = "二级类别：(未检索)";
            }
            if (archives.getYearCode() != "" && archives.getYearCode() != null) {
                typeName = sysDicService.getDicName("ND", archives.getYearCode());
                year = "年份：" + typeName + "年,";
            } else {
                year = "年份：(未检索)";
            }
            if (archives.getFileType() != "") {
                typeName = sysDicService.getDicName("DALX", archives.getFileType());
                file = "档案类型：" + typeName + ",";
            } else {
                file = "档案类型：(未检索)";
            }
            pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "检索了条件为：" + one + two + file + year + "的档案信息");
            archives.setOperateType("5");
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setArchivesId("无");
            archivesService.insertArchivesLog(archives);
        }
        map.put("data", list);
        return map;
    }

    //普通教师部门主任角色电子档案查询列表页面
    @RequestMapping("/archives/directorArchivesList")
    public ModelAndView directorArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListTeacherAndDirector");
        return mv;
    }
    //校领导管理员角色电子档案查询列表页面
    @RequestMapping("/archives/leaderArchivesList")
    public ModelAndView leaderArchivesList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesListLeader");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/getLeaderArchivesList")
    public Map<String, List<Archives>> getLeaderArchivesList(Archives archives) {
        Map<String, List<Archives>> map = new HashMap<String, List<Archives>>();
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getAllArchivesList(archives);
        if (archives.getCondition() != "" && archives.getCondition()!=null) {
            String pname = "";
            pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "全文检索了条件为：" + archives.getCondition() + "的档案信息");
            archives.setOperateType("5");
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setArchivesId("无");
            archivesService.insertArchivesLog(archives);
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
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getArchivesList(archives);
        if (archives.getOneLevel() != "" || archives.getTwoLevel() != "" || archives.getPersonName() != "" ||
                archives.getFileType() != "" || archives.getYearCode() != "" || archives.getDeptName() != "") {
            String one = "", two = "", file = "", year = "", typeName = "", pname = "", dpname = "", rename = "";
            if (archives.getOneLevel() != "") {
                typeName = archivesTypeService.getTypeName(archives.getOneLevel());
                one = "一级类别：" + typeName + ",";
            } else {
                one = "一级类别：(未检索)";
            }
            if (archives.getTwoLevel() != "") {
                typeName = archivesTypeService.getTypeName(archives.getTwoLevel());
                two = "二级类别：" + typeName + ",";
            } else {
                two = "二级类别：(未检索)";
            }
            if (archives.getFileType() != "") {
                typeName = sysDicService.getDicName("DALX", archives.getFileType());
                file = "档案类型：" + typeName + ",";
            } else {
                file = "档案类型：(未检索)";
            }
            if (archives.getYearCode() != "" && archives.getYearCode() != null) {
                typeName = sysDicService.getDicName("ND", archives.getYearCode());
                year = "年份：" + typeName + "年,";
            } else {
                year = "年份：(未检索)";
            }
            if (archives.getPersonName() != "") {
                rename = "申请人：" + archives.getPersonName() + ",";
            } else {
                rename = "申请人：(未检索)";
            }
            if (archives.getDeptName() != "") {
                dpname = "申请部门：" + archives.getDeptName() + ",";
            } else {
                dpname = "申请部门：(未检索)";
            }
            pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "检索了条件为：" + one + two + file + year + dpname + rename + "的档案信息");
            archives.setOperateType("5");
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setArchivesId("无");
            archivesService.insertArchivesLog(archives);
        }
        map.put("data", list);
        return map;
    }

    //新增和修改
    @RequestMapping("/archives/editArchives")
    public ModelAndView editArchives(Archives archives) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesEdit");
        String role = archives.getRole();
        if (archives.getArchivesId() == "" || archives.getArchivesId() == null) {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            archives.setRequestDate(date);
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
        return mv;
    }

    //保存
    @ResponseBody
    @RequestMapping("/archives/saveArchives")
    public Message saveArchives(Archives archives) {
//        String dept=CommonUtil.getDefaultDept().substring(4,6);
//        String year=(""+archives.getRequestDate()).substring(2,4);
//        String s=archivesService.getStaffBelongs(CommonUtil.getPersonId());
//        String level=archives.getTwoLevel().substring(1,6);
//        String type=archives.getFileType();
//        String month=(""+archives.getRequestDate()).substring(5,7);
//        String day=(""+archives.getRequestDate()).substring(8,10);
//        String archivesCode=dept+year+s+level+type+month+day;
        String archivesCode = CommonUtil.getDefaultDept().substring(4, 6) +
                ("" + archives.getRequestDate()).substring(2, 4) +
                archivesService.getStaffBelongs(CommonUtil.getPersonId()) +
                archives.getTwoLevel().substring(1, 6) +
                archives.getFileType() +
                ("" + archives.getRequestDate()).substring(5, 7) +
                ("" + archives.getRequestDate()).substring(8, 10);
        if (archives.getArchivesId() == "" || archives.getArchivesId() == null) {
            archives.setArchivesId(CommonUtil.getUUID());
            archives.setArchivesCode(archivesCode);
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            archives.setDeptCode(CommonUtil.getDefaultDept());
            archives.setOperateType("2");
            String pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "新增的此电子档案信息。");
            archivesService.insertArchivesLog(archives);
            archives.setSchoolCode(archivesService.getStaffBelongs(CommonUtil.getPersonId()));
            archivesService.insertArchives(archives);
            return new Message(1, "新增成功", "success");
        } else {
            String old = archives.getArchivesCode().substring(0, 15);
            if (archivesCode.equals(old)) {
                archives.setArchivesCode("");
            }
            archives.setChanger(CommonUtil.getPersonId());
            archives.setChangeDept(CommonUtil.getDefaultDept());
            archives.setOperateType("3");
            archivesService.updateArchives(archives);
            archives.setCreator(CommonUtil.getPersonId());
            archives.setCreateDept(CommonUtil.getDefaultDept());
            String pname = empService.getPersonNameById(CommonUtil.getPersonId());
            archives.setRemark(pname + "修改的此电子档案信息。");
            archivesService.insertArchivesLog(archives);
            return new Message(1, "修改成功", "success");
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/archives/deleteArchivesById")
    public Message deleteArchivesById(String archivesId) {
        archivesService.deleteFileByArchivesId(archivesId);
        archivesService.deleteArchivesById(archivesId);
        Archives archives = new Archives();
        archives.setArchivesId(archivesId);
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setOperateType("4");
        String pname = empService.getPersonNameById(CommonUtil.getPersonId());
        archives.setRemark(pname + "删除的此电子档案信息。");
        archivesService.insertArchivesLog(archives);
        return new Message(1, "删除成功", null);
    }

    //移动至回收站
    @ResponseBody
    @RequestMapping("/archives/updateArchivesDelStateById")
    public Message updateArchivesById(Archives archives) {
        archivesService.updateArchivesDelStateById(archives);
        if (archives.getDelState().equals("1")) {
            return new Message(1, "已移动至回收站", null);
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
        archives.setCreator(CommonUtil.getPersonId());
        List<Archives> list = archivesService.getArchivesRecycleBinList(archives);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/archives/getArchivesDeptAndPersonTree")
    public List<EmpDeptTree> getDeptAndPersonTree(String id) {
        List<EmpDeptTree> trees = archivesService.getArchivesDeptAndPersonTree(id);
        EmpDeptTree root = new EmpDeptTree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        root.setChecked("false");
        root.setIsper("false");
        trees.add(root);
        return trees;
    }

    //分配权限
    @RequestMapping("/archives/archivesPerRole")
    public ModelAndView rolePerRelationByRole(String archivesId) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesPerRole");
        mv.addObject("archivesId", archivesId);
        ModelAndView modelAndView = mv.addObject("head", "电子档案授权");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/archives/savePerRelation")
    public Message savePerRelation(String archivesId, String checkList) {
        archivesService.delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(archivesId, checkList);
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
    public ModelAndView uploadFiles(String archivesId, String flag, String role) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesUploadFiles");
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        mv.addObject("head", "附件下载");
        mv.addObject("archivesId", archivesId);
        mv.addObject("flag", files.size());
        mv.addObject("files", files);
        mv.addObject("role", role);
        return mv;
    }

    @RequestMapping("/archives/preview")
    public ModelAndView preview(String archivesId, String flag, String role) {
        ModelAndView mv = new ModelAndView("/business/archives/archivesMainPreview");
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        mv.addObject("head", "附件下载");
        mv.addObject("archivesId", archivesId);
        mv.addObject("flag", files.size());
        mv.addObject("files", files);
        mv.addObject("role", role);
        return mv;
    }

    @RequestMapping("/archivesPrivate/getPrivateArchivesView")
    public ModelAndView getPrivateArchivesView(HttpServletRequest request, String fileId, String archivesId) {
        List<ArchivesFile> files = archivesService.getFilesByArchivesId(archivesId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/archives/archivesPreview");
        mv.addObject("fileId", fileId);
        ArchivesFile archivesFile = archivesService.getArchivesFileById(fileId);

        if (archivesFile != null) {
            String fileView = archivesFile.getFileUrl();
            String fileType = archivesFile.getFileSuffix();
            if (".txt.docx.doc.xls.xlsx.pptx.pptx.".indexOf("." + fileType + ".") != -1) {
                // 文本
                fileView = fileView.replace("." + fileType, ".pdf");
                mv.addObject("fileView", request.getContextPath() + fileView);
                mv.addObject("fileFormat", "1");
            } else if (".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.WMF.".indexOf("." +
                    fileType + ".") != -1) {
                // 图片
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "2");
            } else if (".mp3.wmv.".indexOf("." + fileType + ".") != -1) {
                // 音频
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "3");
            } else if (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + fileType + "" +
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
        return CommonUtil.tableMap(archivesService.getFilesByArchivesId(archivesId));
    }

    public static String COM_REPORT_PATH = null;

    @Resource
    private WordUtil wordUtil;

    @ResponseBody
    @RequestMapping("/archives/insertArchivesFiles")
    public void insertArchivesFiles(@RequestParam(value = "files[]", required = false) MultipartFile files[],
                                    HttpServletRequest request, String archivesId, String flag, String role) {
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
            uploadFile.setArchivesId(archivesId);
            uploadFile.setFileName(fileName);
            uploadFile.setFileUrl(url);
            uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
            uploadFile.setCreator(CommonUtil.getPersonId());
            uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            archivesService.insertArchivesFile(uploadFile);
        }
    }

    @ResponseBody
    @RequestMapping("/archives/downloadArchivesFile")
    public void downloadArchivesFile(String fileId, HttpServletResponse response) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        ArchivesFile files = archivesService.getArchivesFileById(fileId);
        String filePath = COM_REPORT_PATH + files.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(files.getFileName(),
                    "utf-8"));
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
        archives.setCreator(CommonUtil.getPersonId());
        archives.setCreateDept(CommonUtil.getDefaultDept());
        softMap.put("data", archivesService.getArchivesLogList(archives));
        return softMap;
    }

    //教师档案变更申请
    //逻辑删除申请
    @ResponseBody
    @RequestMapping("/archives/updateValidFlag")
    public Message updateValidFlag(Archives archives) {
        archives.setValidFlag("0");
        archivesService.updateValidFlag(archives);
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

    @ResponseBody
    @RequestMapping("/archives/saveArchivesRequest")
    public Message saveArchivesRequest(Archives archives) {
        if ("0".equals(archives.getRequestFlag())) {
            archivesService.archivesRequestFlag(archives);
            return new Message(1, "档案已提交", null);
        }
        if (archives.getReason() != null) {
            archivesService.archivesEditRequest(archives);
            return new Message(1, "申请成功", null);
        } else {
            if ("2".equals(archives.getRequestFlag())) {
                archivesService.archivesRequestFlag(archives);
                return new Message(1, "已通过该申请", null);
            } else {
                archivesService.archivesRequestFlag(archives);
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
    public void exportStudent(Archives archives,String roleFlag, HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> archivesList = archivesService.getAllArchivesList(archives);

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
        row1.createCell(6).setCellValue("档案说明");
        tmp++;
        int i = 1;
        for (Archives salaryObj : archivesList) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(salaryObj.getArchivesCode());
            row.createCell(1).setCellValue(salaryObj.getCreator());
            row.createCell(2).setCellValue(salaryObj.getCreateDept());
            row.createCell(3).setCellValue(salaryObj.getOneLevel());
            row.createCell(4).setCellValue(salaryObj.getTwoLevel());
            row.createCell(5).setCellValue(salaryObj.getFileType());
            row.createCell(6).setCellValue(salaryObj.getRemark());
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
        archives.setCreateDept(CommonUtil.getDefaultDept());
        archives.setValidFlag("1");
        List<Archives> list = archivesService.getAllArchivesList(archives);
        ModelAndView mv = new ModelAndView("/business/archives/printArchives");
        mv.addObject("list", list);
        return mv;
    }
}
