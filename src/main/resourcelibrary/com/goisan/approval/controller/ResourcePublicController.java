package com.goisan.approval.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.approval.bean.ResourcePublic;
import com.goisan.approval.service.ResourceApprovalService;
import com.goisan.approval.service.ResourcePublicService;
import com.goisan.common.ResourcelibraryCommonUtil;
import com.goisan.common.transcoding.Transcoding;
import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.indexsearch.bean.ResourceView;
import com.goisan.indexsearch.service.IndexSearchService;
import com.goisan.log.bean.ResourceLog;
import com.goisan.log.service.ResourceLogService;
import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.service.ResourceOperateLogService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ResourcePublicController {

    @Resource
    private ResourcePublicService resourcePublicService;
    @Resource
    private ResourceOperateLogService resourceOperateLogService;

    @RequestMapping("/resourcePublic/toResourcePublicList")
    public String toList() {
        return "/resourcelibrary/approval/resourcePublicList";
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/getResourcePublicList")
    public Map<String, Object> getList(ResourcePublic resourcePublic, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        List<BaseBean> list = resourcePublicService.getResourcePublicList(resourcePublic);
        PageInfo<List<BaseBean>> info = new PageInfo(list);
        Map<String, Object> resourceList = new HashMap();
        resourceList.put("draw", draw);
        resourceList.put("recordsTotal", info.getTotal());
        resourceList.put("recordsFiltered", info.getTotal());
        resourceList.put("data", list);
        return resourceList;
    }

    @RequestMapping("/resourcePublic/toResourcePublicAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/approval/resourcePublicAdd";
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/saveResourcePublic")
    public Message save(ResourcePublic resourcePublic) {
        if (null == resourcePublic.getResourceId() || "".equals(resourcePublic.getResourceId())) {
            resourcePublic.setResourceId(CommonUtil.getUUID());
            CommonUtil.save(resourcePublic);
            resourcePublicService.saveResourcePublic(resourcePublic);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourcePublic);
            resourcePublicService.updateResourcePublic(resourcePublic);
            return new Message(0, "修改成功！", "success");
        }

    }

    @ResponseBody
    @RequestMapping("/resourcePublic/addPublic")
    public Message addPublic(@RequestParam("resourceName") String resourceName,
                             @RequestParam("resourceType") String resourceType,
                             @RequestParam("resourceSubjectId") String resourceSubjectId,
                             @RequestParam("resourceMajorId") String resourceMajorId,
                             @RequestParam("resourceCourseId") String resourceCourseId,
                             @RequestParam("resourceFormat") String resourceFormat,
                             @RequestParam("remark") String remark,
                             @RequestParam("coverRemark") String coverRemark,
                             @RequestParam(value = "file") CommonsMultipartFile file,
                             @RequestParam(value = "cover") CommonsMultipartFile coverfile) {
        String resourceId = CommonUtil.getUUID();
        String name = file.getFileItem().getName();
        String type = name.substring(name.lastIndexOf(".") + 1);
        try {
            InputStream in = file.getInputStream();
            byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据
            String uploadFilePath = new File(getClass().getResource("/").getPath()).getParentFile().getParent()
                    .toString();

            Date date = new Date();
            DateFormat format = new SimpleDateFormat("yyyyMMdd");
            String time = format.format(date);
            String Path = "/resourcefiles/ZYK_RESOURCE_PUBLIC/" + time + "/";

            File tempFile = new File(uploadFilePath + Path);

            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            FileOutputStream fos = new FileOutputStream(uploadFilePath + Path + resourceId + "." + type);
            byte[] buffer = new byte[8192]; // 每次读8K字节
            int count = 0;
            // 开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
            while ((count = in.read(buffer)) > 0) {
                fos.write(buffer, 0, count); // 向服务端文件写入字节流
            }
            fos.close(); // 关闭FileOutputStream对象
            in.close(); // InputStream对象

    /*        if (".avi.wmv.mpeg.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + type + ".") != -1) {
                Transcoding.transcoding(uploadFilePath + Path + resourceId + "." + type, uploadFilePath + Path +
                        resourceId);
            }*/

            ResourceFiles uploadFiles = new ResourceFiles();
            if (coverRemark.equals("true")) {
                InputStream inCover = coverfile.getInputStream();
                String nameCover = coverfile.getFileItem().getName();
                String typeCover = nameCover.substring(nameCover.lastIndexOf(".") + 1);

                FileOutputStream fosCover = new FileOutputStream(uploadFilePath + Path + resourceId + "Cover." +
                        typeCover);
                byte[] bufferCover = new byte[8192]; // 每次读8K字节
                int countCover = 0;
                // 开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
                while ((countCover = inCover.read(bufferCover)) > 0) {
                    fosCover.write(bufferCover, 0, countCover); // 向服务端文件写入字节流
                }
                fosCover.close(); // 关闭FileOutputStream对象
                inCover.close(); // InputStream对象
                uploadFiles.setCoverUrl(Path + resourceId + "Cover." + typeCover);
                uploadFiles.setCoverType(typeCover);
            } else {
                uploadFiles.setCoverUrl( ResourcelibraryCommonUtil.getFilesThumbnailURL(resourceFormat, type) );
            }

            long fileSize = file.getSize();
            uploadFiles.setFileSize(fileSize + "");
            uploadFiles.setFileId(resourceId);
            uploadFiles.setFileName(name);
            uploadFiles.setFileType(type);
            uploadFiles.setFileUrl(Path + resourceId + "." + type);
            uploadFiles.setBusinessId(resourceId);
            uploadFiles.setTablename("ZYK_RESOURCE_PUBLIC");
            uploadFiles.setCreator(CommonUtil.getPersonId());
            uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            resourceFilesService.saveResourceFiles(uploadFiles);

            DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
            String time1 = format1.format(date);

            ResourcePublic resourcePublic = new ResourcePublic();
            resourcePublic.setResourceName(resourceName);
            resourcePublic.setResourceType(resourceType);
            resourcePublic.setResourceSubjectId(resourceSubjectId);
            resourcePublic.setResourceMajorId(resourceMajorId);
            resourcePublic.setResourceCourseId(resourceCourseId);
            resourcePublic.setResourceFormat(resourceFormat);
            resourcePublic.setRemark(remark);
            resourcePublic.setResourceId(resourceId);
            CommonUtil.save(resourcePublic);
            resourcePublic.setPublicPersonId(CommonUtil.getPersonId());
            resourcePublic.setPublicDeptId(CommonUtil.getDefaultDept());
            resourcePublic.setPublicTime(time1);
            resourcePublic.setPublicFlag("1");
            resourcePublic.setClassicFlag("0");
            resourcePublicService.saveResourcePublic(resourcePublic);

            ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
            resourceOperateLog.setResourceId(resourceId);
            resourceOperateLog.setBusinessId(resourceId);
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);    // zyk_resource_public
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PUBLIC");
            resourceOperateLog.setOperateType("1");
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);

            return new Message(1, "上传成功！如果文件需要转码，请稍后查看。", resourceId);
        } catch (IOException e) {
            e.printStackTrace();
            return new Message(0, "上传失败！", "error");
        }
    }

    @RequestMapping("/resourcePublic/toResourcePublicEdit")
    public String toEdit(String id, Model model) {
        ResourcePublic result = new ResourcePublic();
        result.setResourceId(id);
        model.addAttribute("data", resourcePublicService.getResourcePublicById(result));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/approval/resourcePublicEdit";
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/delResourcePublic")
    public Message del(String id) {
        resourcePublicService.delResourcePublic(id);
        return new Message(0, "删除成功！", "success");
    }

    @RequestMapping("/resourcePublic/addApprovalResource")
    public String approvalResource(String resourceId, String resourceName, Model model) {
        model.addAttribute("head", "设置");
        model.addAttribute("resourceId", resourceId);
        model.addAttribute("resourceName", resourceName);
        return "/resourcelibrary/approval/resourcePublicEdit";
    }

    @Resource
    private ResourceApprovalService resourceApprovalService;

    @ResponseBody
    @RequestMapping("/resourcePublic/addResourcePublic")
    public Message addResourcePublic(ResourcePublic resourcePublic) {
        CommonUtil.save(resourcePublic);
        resourcePublicService.addResourcePublic(resourcePublic);
        return new Message(0, "添加成功！", "success");
    }

    @Resource
    private ResourceFilesService resourceFilesService;
    @Resource
    private ResourceLogService resourceLogService;

    @RequestMapping("/resourcePublic/getPublicResourceView")
    public ModelAndView getPublicResourceView(HttpServletRequest request, String resourceId) {
        ModelAndView mv = new ModelAndView();
        LoginUser loginUser = CommonUtil.getLoginUser();
        ResourcePublic result = new ResourcePublic();
        result.setResourceId(resourceId);
        result.setCreator(loginUser.getPersonId());
        ResourcePublic resourcePublic = (ResourcePublic) resourcePublicService.getResourcePublicById(result);
        ResourceFiles resourceFiles = (ResourceFiles) resourceFilesService.getResourceFilesById(resourceId);
        if (resourceFiles == null || resourcePublic == null) {
            mv.setViewName("/resourcelibrary/searchResources/publicLoseView");
        } else {
            long fileSize = Long.parseLong(resourceFiles.getFileSize());
            String size = ResourcelibraryCommonUtil.fileSize(fileSize);
            resourceFiles.setFileSize(size);
            mv.addObject("resourceFiles", resourceFiles);
            mv.addObject("fileUrl", resourceFiles.getFileUrl());
            String fileView = resourceFiles.getFileUrl();
            if ((resourcePublic.getResourceFormat().equals("1") || resourcePublic.getResourceFormat().equals("9")
                    && (".txt.docx.doc.xls.xlsx.pptx.pptx.".indexOf("." + resourceFiles.getFileType() + ".") != -1))) {
                //文档   其他
                fileView = request.getContextPath() + fileView.replace("." + resourceFiles.getFileType(), ".pdf");
                mv.setViewName("/resourcelibrary/searchResources/publicTextView");
            } else if (resourcePublic.getResourceFormat().equals("2")) {
                //图片
                mv.setViewName("/resourcelibrary/searchResources/publicPictureView");
            } else if (resourcePublic.getResourceFormat().equals("3")) {
                //音频
                mv.setViewName("/resourcelibrary/searchResources/publicAudioView");
            } else if ((resourcePublic.getResourceFormat().equals("4") || resourcePublic.getResourceFormat().equals
                    ("5"))
                    && (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." +
                    resourceFiles.getFileType() + ".") != -1)) {
                // 视频   动画
                fileView = fileView.replace("." + resourceFiles.getFileType(), ".mp4");
                mv.setViewName("/resourcelibrary/searchResources/publicVideoView");
            } else {
                mv.setViewName("/resourcelibrary/searchResources/publicView");
            }
            mv.addObject("fileView", fileView);
            mv.addObject("resourcePublic", resourcePublic);
        }

        mv.addObject("head", "");
        mv.addObject("resourceId", resourceId);

        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }

        addLog(resourceId, "1");
        return mv;
    }

    @Resource
    private IndexSearchService indexSearchService;
    @Resource
    private EmpService empService;

    @RequestMapping("/resourcePublic/getPublicResourceViewMain")
    public ModelAndView getpublicViewRightMain(String resourceId, String publicPersonId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/resourcelibrary/searchResources/publicMainView");
        mv.addObject("resourceId", resourceId);

        LoginUser publicPerson = empService.getEmpByPersonId(publicPersonId);
        if (null != publicPerson) {
            if (null == publicPerson.getPhotoUrl() || publicPerson.getPhotoUrl().equals("")) {
                publicPerson.setPhotoUrl("dmitry_b.jpg");
            }
            mv.addObject("publicPerson", publicPerson);
        }

        ResourceView resourceView = new ResourceView();
        resourceView.setPublicPersonId(publicPersonId);
        String countNum = indexSearchService.countSearchResource(resourceView);
        mv.addObject("countPublic", countNum);

        resourceView.setPublicPersonId("");
        resourceView.setResourceId(resourceId);
        ResourceView result = indexSearchService.searchResourceById(resourceView);
        if (null != result) {
            String downCount = null == result.getDownCount() ? "0" : result.getDownCount() ;
            String viewCount = null == result.getViewCount() ? "0" : result.getViewCount() ;
            mv.addObject("downCount", downCount);
            mv.addObject("viewCount", viewCount);
        }
        return mv;
    }

    @RequestMapping("/resourcePublic/getPublicTop")
    public ModelAndView getPublicTop() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/resourcelibrary/searchResources/publicTop");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/downResource")
    public void downloadResource(HttpServletRequest request, HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String resourceId = request.getParameter("resourceId");
        String fileUrl = request.getParameter("fileUrl");
        String fileName = request.getParameter("fileName");
        try {
            response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        java.io.OutputStream outp = null;
        java.io.FileInputStream in = null;
        addLog(resourceId, "3");
        try {
            outp = response.getOutputStream();
            in = new FileInputStream(rootPath + fileUrl);
            byte[] b = new byte[1024];
            int i = 0;
            while ((i = in.read(b)) > 0) {
                outp.write(b, 0, i);
            }
            outp.flush();
            //要加以下两句话，否则会报错
            //java.lang.IllegalStateException: getOutputStream() has already been called for //this response
        } catch (Exception e) {
            System.out.println("Error!");
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                in = null;
            }
            //这里不能关闭
            if (outp != null) {
                try {
                    outp.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static String COM_REPORT_PATH = null;

    public void addLog(String resourceId, String operateType) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        ResourceLog resourceLog = new ResourceLog();
        resourceLog.setLogId(CommonUtil.getUUID());
        resourceLog.setResourceId(resourceId);
        resourceLog.setOperateType(operateType);
        resourceLog.setPersonId(loginUser.getPersonId());
        resourceLog.setDeptId(loginUser.getDefaultDeptId());
        resourceLog.setCreator(loginUser.getPersonId());
        resourceLog.setCreateDept(loginUser.getDefaultDeptId());
        resourceLog.setValidFlag("1");
        resourceLogService.saveResourceLog(resourceLog);
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/getResourceTree")
    public List<Tree> getResourceTree() {
        return resourcePublicService.getResourceTree();
    }

    @RequestMapping("/resourcePublic/toAddFiles")
    public String toAddFiles(Model model) {
        model.addAttribute("head", "文件上传");
        return "resourcelibrary/approval/addFiles";
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/batchUpdate")
    public Message batchUpdate(@RequestParam(value = "files[]", required = false) MultipartFile[] files, ResourcePublic
            resourcePublic) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        resourcePublicService.batchUpdate(files, resourcePublic, COM_REPORT_PATH);
        return new Message(1, "上传成功！", null);
    }

    @RequestMapping("/resourceLibrary/JPK/setJPKResourceSkip")
    public String toEditCourse(ResourcePublic resourcePublic, Model model) {
        BaseBean data = resourcePublicService.toEditExcellect(resourcePublic);
        model.addAttribute("data", data);
        model.addAttribute("head", "设置精品课");
        return "/resourcelibrary/approval/setExcellectPublish";
    }
}
