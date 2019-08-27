package com.goisan.excellect.controller;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.approval.service.ResourcePublicService;
import com.goisan.common.ResourcelibraryCommonUtil;
import com.goisan.excellect.bean.ResourceExcellect;
import com.goisan.excellect.service.ResourceExcellectService;
import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.indexsearch.bean.ResourceView;
import com.goisan.log.bean.ResourceLog;
import com.goisan.log.service.ResourceLogService;
import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.service.ResourceOperateLogService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ResourceExcellectController {

    /*
    *  add by yang  liu
    */

    @Resource
    private ResourcePublicService resourcePublicService;
    @Resource
    private ResourceExcellectService resourceExcellectService;
    @Resource
    private ResourceOperateLogService resourceOperateLogService;
/*    @Resource
    private ResourceExcellectTypeService jpkResourceTypeService;*/
    @Resource
    private ResourceFilesService resourceFilesService;
    @Resource
    private ResourceLogService resourceLogService;

    @ResponseBody
    @RequestMapping("/resourceLibrary/saveExcellect")
    public Message saveExcellect(String resourceId, String jpkTypeName, String remark , Model model) {
        ResourcePublic resourcePublic = new ResourcePublic();
        resourcePublic.setResourceId(resourceId);
       ResourcePublic resourcePublic1 = resourcePublicService.toEditExcellect(resourcePublic);
        resourcePublic1.setJpkTypeName(jpkTypeName);
        resourcePublic1.setCreator(CommonUtil.getPersonId());
        resourcePublic1.setCreateDept(CommonUtil.getDefaultDept());
        resourcePublic1.setRemark(remark);
        resourceExcellectService.saveResourceExcellect(resourcePublic1);
        resourceExcellectService.updateResourceExcellect(resourceId);
        return new Message(0, "添加成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/saveExcellect/Private")
    public Message saveExcellectPirvate(ResourcePublic resourcePublic) {
        resourcePublic.setCreator(CommonUtil.getPersonId());
        resourcePublic.setCreateDept(CommonUtil.getDefaultDept());
        resourceExcellectService.saveResourceExcellectPrivate(resourcePublic);
        //resourceExcellectService.updateResourceExcellect(resourceId);
        return new Message(0, "添加成功！", "success");
    }

    @RequestMapping("/resourcePublic/toResourceExcellectList")
    public String toList() {
        return "/resourcelibrary/excellect/resourceExcellectList";
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/getResourceEcellectList")
    public Map getList(ResourceExcellect resourceExcellect) {
        return CommonUtil.tableMap(resourceExcellectService.getResourceExcellectList(resourceExcellect));
    }

    @RequestMapping("/resourcePublic/toResourceExcellectAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/excellect/resourceExcellectAdd";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/excellect/saveExcellect")
    public Message toSaveExcellect(ResourcePublic resourcePublic ,
                                   @RequestParam(value = "file") CommonsMultipartFile file,
                                   @RequestParam(value = "cover") CommonsMultipartFile coverfile) {
        String excellectId = CommonUtil.getUUID();
        resourcePublic.setResourceId(excellectId);
        resourcePublic.setPublicPersonId(CommonUtil.getPersonId());
        resourcePublic.setPublicDeptId(CommonUtil.getDefaultDept());
        resourcePublic.setCreator(CommonUtil.getPersonId());
        resourcePublic.setCreateDept(CommonUtil.getDefaultDept());
        resourceExcellectService.saveResourceExcellect(resourcePublic);
       // resourceExcellectService.updateResourceExcellect(resourceId);
       String coverRemark = resourcePublic.getCoverRemark();
        String resourceFormat = resourcePublic.getResourceFormat();
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
            String Path = "/resourcefiles/ZYK_RESOURCE_EXCELLECT/" + time + "/";
            File tempFile = new File(uploadFilePath + Path);

            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            FileOutputStream fos = new FileOutputStream(uploadFilePath + Path + excellectId + "." + type);
            byte[] buffer = new byte[8192]; // 每次读8K字节
            int count = 0;
            // 开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
            while ((count = in.read(buffer)) > 0) {
                fos.write(buffer, 0, count); // 向服务端文件写入字节流
            }
            fos.close(); // 关闭FileOutputStream对象
            in.close(); // InputStream对象
      /*      if (".avi.wmv.mpeg.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + type + ".") != -1) {
                Transcoding.transcoding(uploadFilePath + Path + resourceId + "." + type, uploadFilePath + Path +
                        resourceId);
            }*/
            ResourceFiles uploadFiles = new ResourceFiles();
            if (coverRemark.equals("true")) {
                InputStream inCover = coverfile.getInputStream();
                String nameCover = coverfile.getFileItem().getName();
                String typeCover = nameCover.substring(nameCover.lastIndexOf(".") + 1);
                FileOutputStream fosCover = new FileOutputStream(uploadFilePath + Path + excellectId + "Cover." +
                        typeCover);
                byte[] bufferCover = new byte[8192]; // 每次读8K字节
                int countCover = 0;
                // 开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
                while ((countCover = inCover.read(bufferCover)) > 0) {
                    fosCover.write(bufferCover, 0, countCover); // 向服务端文件写入字节流
                }
                fosCover.close(); // 关闭FileOutputStream对象
                inCover.close(); // InputStream对象
                uploadFiles.setCoverUrl(Path + excellectId + "Cover." + typeCover);
                uploadFiles.setCoverType(typeCover);
            } else {
                uploadFiles.setCoverUrl( ResourcelibraryCommonUtil.getFilesThumbnailURL(resourceFormat, type) );
            }
            long fileSize = file.getSize();
            uploadFiles.setFileSize(fileSize + "");
            uploadFiles.setFileId(excellectId);
            uploadFiles.setFileName(name);
            uploadFiles.setFileType(type);
            uploadFiles.setFileUrl(Path + excellectId + "." + type);
            uploadFiles.setBusinessId(excellectId);
            uploadFiles.setTablename("ZYK_RESOURCE_PUBLIC");
            uploadFiles.setCreator(CommonUtil.getPersonId());
            uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            resourceFilesService.saveResourceFiles(uploadFiles);
            return new Message(1, "上传成功！文件需要转码，请稍后查看。", excellectId);
        } catch (IOException e) {
            e.printStackTrace();
            return new Message(0, "上传失败！", "error");
        }
        //return new Message(1, "添加成功！", excellectId);
    }

    @ResponseBody
    @RequestMapping("/resourcePublic/savePublic")
    public Message addPublic(@RequestParam("resourceId") String resourceId,
                             @RequestParam("resourceName") String resourceName,
                             @RequestParam("resourceType") String resourceType,
                             @RequestParam("resourceSubjectId") String resourceSubjectId,
                             @RequestParam("resourceMajorId") String resourceMajorId,
                             @RequestParam("resourceCourseId") String resourceCourseId,
                             @RequestParam("resourceFormat") String resourceFormat,
                             @RequestParam("edition") String edition,
                             @RequestParam("remark") String remark,
                             @RequestParam("coverRemark") String coverRemark,
                             @RequestParam(value = "file") CommonsMultipartFile file,
                             @RequestParam(value = "cover") CommonsMultipartFile coverfile) {
        //String resourceId = CommonUtil.getUUID();
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
      /*      if (".avi.wmv.mpeg.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + type + ".") != -1) {
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
            //resourceFilesService.saveResourceFiles(uploadFiles);
            DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
            String time1 = format1.format(date);
            ResourcePublic resourcePublic = new ResourcePublic();
            resourcePublic.setResourceName(resourceName);
            resourcePublic.setResourceType(resourceType);
            resourcePublic.setResourceSubjectId(resourceSubjectId);
            resourcePublic.setResourceMajorId(resourceMajorId);
            resourcePublic.setResourceCourseId(resourceCourseId);
            resourcePublic.setResourceFormat(resourceFormat);
            //resourcePublic.setEdition(edition);
            resourcePublic.setRemark(remark);
            resourcePublic.setResourceId(resourceId);
            CommonUtil.save(resourcePublic);
            resourcePublic.setPublicPersonId(CommonUtil.getPersonId());
            resourcePublic.setPublicDeptId(CommonUtil.getDefaultDept());
            resourcePublic.setPublicTime(time1);
            resourcePublic.setPublicFlag("1");
            resourcePublic.setClassicFlag("1");
            //resourcePublic.setClassicFlag("");
            resourcePublicService.saveResourcePublic(resourcePublic);
            ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
            resourceOperateLog.setResourceId(resourceId);
            resourceOperateLog.setBusinessId(resourceId);
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);    // zyk_resource_public
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PUBLIC");
            resourceOperateLog.setOperateType("1");
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);
            return new Message(1, "上传成功！文件需要转码，请稍后查看。", resourceId);
        } catch (IOException e) {
            e.printStackTrace();
            return new Message(0, "上传失败！", "error");
        }
    }

    @RequestMapping("/resourcePublic/toResourceExcellectEdit")
    public String toExcellectEdit(ResourceExcellect resourceExcellect, Model model) {
        ResourceExcellect resourceExcellect1 = resourceExcellectService.getResourceExcellectById(resourceExcellect);
        model.addAttribute("data", resourceExcellectService.getResourceExcellectById(resourceExcellect));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/excellect/resourceExcellectEdit";
    }
    @ResponseBody
    @RequestMapping("/resourcePublic/excellect/updateExcellect")
    public Message updateResourceExcellect(ResourceExcellect resourceExcellect){
        resourceExcellect.setChanger(CommonUtil.getPersonId());
        resourceExcellect.setChangeDept(CommonUtil.getDefaultDept());
        resourceExcellectService.updateExcellect(resourceExcellect);
        return new Message(1, "修改成功！", "success");
    }
    @ResponseBody
    @RequestMapping("/resourcePublic/excellect/deleteExcellect")
    public Message deleteResourceExcellect(ResourceExcellect resourceExcellect){
        String excellectId = resourceExcellect.getExcellectId();
        //resourceFilesService.delResourceFiles(excellectId);
        resourceExcellectService.deleteExcellect(excellectId);
        return new Message(1, "删除成功！", "success");
    }

    /*
    高中数学主页面
     */
    @RequestMapping("/resourceExcellect/excellectMath")
    public ModelAndView excellectOneMath(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        String courseId =resourceExcellect.getResourceCourseId();
        if("fa27a0f1-b5e2-4def-bce0-42860b3f8c4c".equals(courseId)){
            mv.setViewName("/excellectlibrary/math/mathGradeOne"); //高一主页面
        }else if("92d1298a-059a-4a16-a099-b52e241ee4cc".equals(courseId)){
            mv.setViewName("/excellectlibrary/math/mathGradeTwo"); //高二主页面
        }else if("76b10dcd-cae1-441f-b4c0-dcadf8043e51".equals(courseId)){
            mv.setViewName("/excellectlibrary/math/mathGradeThree"); //高三主页面
        }
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /*
    高一、高二、高三首页头
     */
    @RequestMapping("/resourceExcellect/math/mathIndexTop")
    public ModelAndView toTopIndexMath(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        if(resourceExcellect.getResourceMajorId().equals("551cb5ad-0807-44d6-88bb-47158397244a")){
            // 高一
            mv.setViewName("/excellectlibrary/math/mathIndexTop");
        }else if(resourceExcellect.getResourceMajorId().equals("9eae56b9-d2cc-472e-ab82-e52e5a951472")){
            // 高二
            mv.setViewName("/excellectlibrary/math/mathIndexTopTwo");
        }else if(resourceExcellect.getResourceMajorId().equals("5f43c990-b196-481d-a950-1aa166746df5")){
            // 高三
            mv.setViewName("/excellectlibrary/math/mathIndexTopThree");
        }
        resourceExcellect.getResourceMajorId();
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /*
    静态页头部
     */
    @RequestMapping("/resourceExcellect/math/mathTop")
    public ModelAndView toTpoMath(String gradeId, ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        if(resourceExcellect.getResourceMajorId().equals("551cb5ad-0807-44d6-88bb-47158397244a")){
            // 高一
            mv.setViewName("/excellectlibrary/math/mathTop");
        }else if(resourceExcellect.getResourceMajorId().equals("9eae56b9-d2cc-472e-ab82-e52e5a951472")){
            // 高二
            mv.setViewName("/excellectlibrary/math/mathTopTwo");
        }else if(resourceExcellect.getResourceMajorId().equals("5f43c990-b196-481d-a950-1aa166746df5")){
            // 高三
            mv.setViewName("/excellectlibrary/math/mathTopThree");
        }
        resourceExcellect.getResourceMajorId();
        mv.addObject("resourceExcellect",resourceExcellect);

        return mv;
    }

/*    *//*
    高二数学首页
     *//*
    @RequestMapping("/resourceExcellect/excellectTwoMath")
    public ModelAndView excellectTwoMath() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/excellectlibrary/math/mathGradeTwo");
        return mv;
    }*/

    /*
    高一静态页
     */
    @RequestMapping("/resourceExcellect/OneMathIndex")
    public ModelAndView OneMathIndex(String menu, ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        if("1".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/mathGradeOneMore");
        }else if("2".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/termIntroductionPage");
        }else if("3".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/pointSummaryPage");
        }else if("4".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/learningMethod");
        }else if("5".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/classFeature");
        }
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /*
    高二静态页
     */
    @RequestMapping("/resourceExcellect/TwoMathIndex")
    public ModelAndView TwoMathIndex(String menu, ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        if("1".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/mathGradeMoreTwo");
        }else if("2".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/termIntroductionPageTwo");
        }else if("3".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/pointSummaryPageTwo");
        }else if("4".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/learningMethodTwo");
        }else if("5".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/classFeatureTwo");
        }
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

/*    *//*
    高三数学首页
     *//*
    @RequestMapping("/resourceExcellect/excellectThreeMath")
    public ModelAndView excellectThreeMath() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/excellectlibrary/math/mathGradeThree");
        return mv;
    }*/

    /*
    高三静态页
     */
    @RequestMapping("/resourceExcellect/ThreeMathIndex")
    public ModelAndView ThreeMathIndex(String menu, ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        if("1".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/mathGradeMoreThree");
        }else if("2".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/termIntroductionPageThree");
        }else if("3".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/pointSummaryPageThree");
        }else if("4".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/learningMethodThree");
        }else if("5".equals(menu)){
            mv.setViewName("/excellectlibrary/math/staticPage/classFeatureThree");
        }
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /*
    *  add by liu  end
    * */

    /*
    *  add by yang  start
    * */
    // 精品课首页
    @RequestMapping("/resourceExcellect/excellectlibraryIndex")
    public ModelAndView excellectlibraryIndex() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/excellectlibrary/excellectlibraryIndex");
        return mv;
    }

    // 语文样式头部
    @RequestMapping("/resourceExcellect/chinese/chineseTop")
    public ModelAndView chineseTop(ResourceExcellect resourceExcellect, String title, String indexUrl) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.addObject("resourceExcellect", resourceExcellect);
        mv.addObject("title", title);
        mv.addObject("indexUrl", indexUrl);
        mv.setViewName("/excellectlibrary/chinese/chineseTop");
        return mv;
    }

    @RequestMapping("/resourceExcellect/chinesePage")
    public ModelAndView chinesePage(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        if(resourceExcellect.getResourceCourseId().equals("ef3727c3-e083-496f-94fa-07f8691197ba")){
            // 电子技术基础与技能
            mv.setViewName("/excellectlibrary/chinese/chineseGradeOne");
        }else if(resourceExcellect.getResourceCourseId().equals("1b9667f4-24ea-43a7-bd0c-ebf66c3039e9")){
            // 电子技术基础与技能
            mv.setViewName("/excellectlibrary/chinese/chineseGradeTwo");
        }else if(resourceExcellect.getResourceCourseId().equals("5f43c990-b196-481d-a950-1aa166746df5")){
            // 高三
            mv.setViewName("/excellectlibrary/chinese/chineseGradeThree");
        }
        resourceExcellect.getResourceMajorId();
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    // 语文 静态页头部
    @RequestMapping("/resourceExcellect/chinese/staticPage/chineseTop")
    public ModelAndView tostaticPageTpo(ResourceExcellect resourceExcellect,String indexUrl) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("resourceExcellect",resourceExcellect);
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.addObject("indexUrl", indexUrl);
        mv.setViewName("/excellectlibrary/chinese/staticPage/chineseTop");
        return mv;
    }

    // 语文静态页
    @RequestMapping("/resourceExcellect/chinese/staticPage")
    public ModelAndView chineseStaticPage(String page , ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("resourceExcellect",resourceExcellect);
        if(page.equals("1"))// 电工技术基础与技能 团队介绍
            mv.setViewName("/excellectlibrary/chinese/staticPage/teamIntroductionPage");
        else if(page.equals("2"))// 电工技术基础与技能 课程设计
            mv.setViewName("/excellectlibrary/chinese/staticPage/pointSummaryPage");
        else if(page.equals("3"))// 电工技术基础与技能 教学方法
            mv.setViewName("/excellectlibrary/chinese/staticPage/learningMethod");
        else if(page.equals("4"))// 高一 学习心得
            mv.setViewName("/excellectlibrary/chinese/staticPage/learningExperience");
        else if(page.equals("5"))// 电子技术基础与技能 团队介绍
            mv.setViewName("/excellectlibrary/chinese/staticPage/teamIntroductionPageTwo");
        else if(page.equals("6"))// 电子技术基础与技能 课程设计
            mv.setViewName("/excellectlibrary/chinese/staticPage/knowledgePoint");
        else if(page.equals("7"))// 电子技术基础与技能 教学方法
            mv.setViewName("/excellectlibrary/chinese/staticPage/learningMethodTwo");
        else if(page.equals("8"))// 电工基础介绍
            mv.setViewName("/excellectlibrary/chinese/staticPage/readSkill");
        else if(page.equals("9"))// 高三 提分技巧
            mv.setViewName("/excellectlibrary/chinese/staticPage/liftingSkill");
        else if(page.equals("10"))// 高三 团队介绍
            mv.setViewName("/excellectlibrary/chinese/staticPage/teamIntroductionThree");
        else if(page.equals("11"))// 高三 文言词知识点
            mv.setViewName("/excellectlibrary/chinese/staticPage/ancientProse");
        else if(page.equals("12"))// 高三 语文学霸经验
            mv.setViewName("/excellectlibrary/chinese/staticPage/learningExperienceThree");
        return mv;
    }

    // 精品课查询
    @ResponseBody
    @RequestMapping("/resourceExcellect/searchList")
    public Map searchList(ResourceView resourceView ) {
        return resourceExcellectService.getHomePageExcellectList( resourceView);
    }

    // 精品课查询
    @ResponseBody
    @RequestMapping("/resourceExcellect/searchExcellectList")
    public Map searchExcellectList(ResourceView resourceView ) {
        if((null == resourceView.getStartCount() || resourceView.getStartCount().equals(""))
                && (null == resourceView.getEndCount() || resourceView.getEndCount().equals(""))){
            resourceView.setStartCount("10");
            resourceView.setEndCount("10");
        }
        Map resultData = new HashMap();
        List list = resourceExcellectService.searchExcellectList( resourceView ) ;
        resultData.put("listData", list );
        String countNum = resourceExcellectService.countsearchExcellectList( resourceView ) ;
        resultData.put("countNum",countNum);
        return resultData;
    }

    // 课程栏目页
    @RequestMapping("/resourceExcellect/excellectTypesSearch")
    public ModelAndView excellectTypesSearch(ResourceExcellect resourceExcellect , String title , String indexUrl) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("resourceExcellect",resourceExcellect);
        mv.addObject("title",title);
        mv.addObject("indexUrl",indexUrl);
        mv.setViewName("/excellectlibrary/searchExcellectType");
        return mv;
    }

    // 详细
    @RequestMapping("/resourceExcellect/getPublicExcellectViewMain")
    public ModelAndView getPublicExcellectViewMain(HttpServletRequest request, String resourceId , String indexUrl ) {
        ModelAndView mv = new ModelAndView();
        ResourceView result = resourceExcellectService.searchExcellectResourceById(resourceId);
        if (null != result) {
            String downCount = null == result.getDownCount() ? "0" : result.getDownCount();
            String viewCount = null == result.getViewCount() ? "0" : result.getViewCount();
            mv.addObject("downCount", downCount);
            mv.addObject("viewCount", viewCount);
        }
        ResourceFiles resourceFiles = (ResourceFiles) resourceFilesService.getResourceFilesById(resourceId);
        if (resourceFiles != null) {
            long fileSize = Long.parseLong(resourceFiles.getFileSize());
            String size = ResourcelibraryCommonUtil.fileSize(fileSize);
            resourceFiles.setFileSize(size);
            String fileView = resourceFiles.getFileUrl();
            String fileType = resourceFiles.getFileType();
            if (".txt.docx.doc.xls.xlsx.pptx.pptx.".indexOf("." + fileType + ".") != -1) {
                // 文本
                fileView = fileView.replace("." + fileType, ".pdf");
                mv.addObject("fileView", request.getContextPath() + fileView);
                mv.addObject("resourceFormat", "1");
            } else if (".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.WMF.".indexOf("." +
                    fileType + ".") != -1) {
                // 图片
                mv.addObject("fileView", fileView);
                mv.addObject("resourceFormat", "2");
            } else if (".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.WMF.".indexOf("." +
                    fileType + ".") != -1) {
                // 音频
                mv.addObject("fileView", fileView);
                mv.addObject("resourceFormat", "3");
            } else if (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + fileType + "" +
                    ".") != -1) {
                // 视频
                fileView = fileView.replace("." + fileType, ".mp4");
                mv.addObject("fileView", fileView);
                mv.addObject("resourceFormat", "4");
            } else {
                mv.addObject("resourceFormat", "");
            }
        }

        mv.setViewName("/excellectlibrary/publicExcellectViewMain");
//        mv.addObject("resourceExcellect",resourceExcellect);
        mv.addObject("result",result);
        mv.addObject("indexUrl",indexUrl);
        mv.addObject("resourceFiles",resourceFiles);
        addLog(resourceId, "1");
        return mv;
    }

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

    // 模块首页
    @RequestMapping("/resourceExcellect/excellectTop")
    public ModelAndView excellectTop(ResourceExcellect resourceExcellect , String title , String indexUrl) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.addObject("title", title);
        mv.addObject("resourceExcellect", resourceExcellect);
        mv.addObject("indexUrl", indexUrl);
        mv.setViewName("/excellectlibrary/excelletTypeTop");
        return mv;
    }



    /*
    *  add by yang  end
    * */

    /*
    *  add by zhou  start
    * */
    @RequestMapping("/resourceExcellect/foreignLanguage/foreignLanguageTop")
    public ModelAndView foreignLanguageTop(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("excellectlibrary/english/foreignLanguageTop");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/english/staticPage/englishTop")
    public ModelAndView toEngstaticPageTop(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("loginFlag", 1);
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/excellectlibrary/english/staticPage/englishTop");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }
    @RequestMapping("/resourceExcellect/foreignLanguage/grade")
    public ModelAndView englishGrade(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        if(resourceExcellect.getResourceMajorId().equals("551cb5ad-0807-44d6-88bb-47158397244a")){
            // 高一
            mv.setViewName("/excellectlibrary/english/englishGradeOne");
        }else if(resourceExcellect.getResourceMajorId().equals("9eae56b9-d2cc-472e-ab82-e52e5a951472")){
            // 高二
            mv.setViewName("/excellectlibrary/english/englishGradeTwo");
        }else if(resourceExcellect.getResourceMajorId().equals("5f43c990-b196-481d-a950-1aa166746df5")){
            // 高三
            mv.setViewName("/excellectlibrary/english/englishGradeTri");
        }
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }


    /**
     * 高一静态页
     * @return
     */

    @RequestMapping("/resourceExcellect/foreignLanguage/teamIntroductionPage")
    public ModelAndView teamIntroductionPageForEng(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/teamIntroductionPage");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/PointSummaryPage")
    public ModelAndView pointSummaryPageforEng(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/pointSummaryPage");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/learningMethod")
    public ModelAndView learningMethodForEng(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learningMethod");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }
    @RequestMapping("/resourceExcellect/foreignLanguage/learnMoreOne")
    public ModelAndView learnMoreForEng(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learnMoreOne");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }
    /*
    高二静态页
     */
    @RequestMapping("/resourceExcellect/foreignLanguage/teamIntroductionPageTwo")
    public ModelAndView teamIntroductionPageForEngTwo(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/teamIntroductionPageTwo");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/PointSummaryPageTwo")
    public ModelAndView pointSummaryPageforEngTwo(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/pointSummaryPageTwo");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/learningMethodTwo")
    public ModelAndView learningMethodForEngTwo(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learningMethodTwo");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }
    @RequestMapping("/resourceExcellect/foreignLanguage/learnMoreTwo")
    public ModelAndView learnMoreForEngTwo(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learnMoreTwo");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /**
     * 高三静态页
     * @return
     */
    @RequestMapping("/resourceExcellect/foreignLanguage/teamIntroductionPageTri")
    public ModelAndView teamIntroductionPageForEngTri(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/teamIntroductionPageTri");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/PointSummaryPageTri")
    public ModelAndView pointSummaryPageforEngTri(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/pointSummaryPageTri");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    @RequestMapping("/resourceExcellect/foreignLanguage/learningMethodTri")
    public ModelAndView learningMethodForEngTri(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learningMethodTri");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }
    @RequestMapping("/resourceExcellect/foreignLanguage/learnMoreTri")
    public ModelAndView learnMoreForTri(ResourceExcellect resourceExcellect) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/excellectlibrary/english/staticPage/learnMoreTri");
        mv.addObject("resourceExcellect",resourceExcellect);
        return mv;
    }

    /*
    *  add by zhou  end
    * */


}
