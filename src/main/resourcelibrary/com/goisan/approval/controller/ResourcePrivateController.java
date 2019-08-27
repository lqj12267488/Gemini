package com.goisan.approval.controller;

import com.goisan.approval.bean.ResourceApproval;
import com.goisan.approval.bean.ResourcePrivate;
import com.goisan.approval.service.ResourceApprovalService;
import com.goisan.approval.service.ResourcePrivateService;
import com.goisan.common.ResourcelibraryCommonUtil;
import com.goisan.common.transcoding.Transcoding;
import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.indexsearch.bean.ResourceView;
import com.goisan.indexsearch.service.IndexSearchService;
import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.service.ResourceOperateLogService;
import com.goisan.system.bean.Files;
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
import java.util.List;
import java.util.Map;

@Controller
public class ResourcePrivateController {
    @Resource
    private ResourcePrivateService resourcePrivateService;

    @Resource
    private ResourceOperateLogService resourceOperateLogService;

    //弹出主页面
    @RequestMapping("/resourcePrivate/toResourcePrivateList")
    public String toList() {
        return "/resourcelibrary/approval/resourcePrivateList";
    }

    //初始化主页面
    @ResponseBody
    @RequestMapping("/resourcePrivate/getResourcePrivateList")
    public Map getList(ResourcePrivate resourcePrivate) {
        List<ResourcePrivate> list = resourcePrivateService.getResourcePrivateList(resourcePrivate);
        return CommonUtil.tableMap(list);
    }

    //弹出新增页面
    @RequestMapping("/resourcePrivate/toResourcePrivateAdd")
    public String toAdd(Model model) {
        ResourcePrivate resourcePrivate = new ResourcePrivate();
        String personId = CommonUtil.getPersonId();
        model.addAttribute("resourcePrivate", resourcePrivate);
        model.addAttribute("head", "新增");
        model.addAttribute("personId", personId);
        return "/resourcelibrary/approval/resourcePrivateAdd";
    }

    //新增、修改保存方法
    @ResponseBody
    @RequestMapping("/resourcePrivate/saveResourcePrivate")
    public Message save(ResourcePrivate resourcePrivate) {
        if ("".equals(resourcePrivate.getResourceId())) {
            String resourceId = CommonUtil.getUUID();
            resourcePrivate.setResourceId(resourceId);
            CommonUtil.save(resourcePrivate);
            resourcePrivateService.saveResourcePrivate(resourcePrivate);
            ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
            resourceOperateLog.setResourceId(resourceId);
            resourceOperateLog.setBusinessId(resourceId);
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PRIVATE");
            resourceOperateLog.setOperateType("1");
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);
            return new Message(0, "添加成功！", "success");
        } else {
            ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
            resourceOperateLog.setResourceId(resourcePrivate.getResourceId());
            resourceOperateLog.setBusinessId(resourcePrivate.getResourceId());
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PRIVATE");
            resourceOperateLog.setOperateType("2");
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);

            CommonUtil.update(resourcePrivate);
            resourcePrivateService.updateResourcePrivate(resourcePrivate);
            return new Message(0, "修改成功！", "success");
        }
    }

    @Resource
    private ResourceFilesService resourceFilesService;

    //新增 保存方法
    @ResponseBody
    @RequestMapping("/resourcePrivate/insertResourcePrivate")
    public Message insertResourcePrivate(@RequestParam("resourceName") String resourceName,
                                         @RequestParam("resourceType") String resourceType,
                                         @RequestParam("resourceCustom") String resourceCustom,
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
            String Path = "/resourcefiles/ZYK_RESOURCE_PRIVATE/" + time + "/";
//            System.out.println("*********************************====="+uploadFilePath+Path);
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

            if (".avi.wmv.mpeg.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + type + ".") != -1) {
                Transcoding.transcoding(uploadFilePath + Path + resourceId + "." + type, uploadFilePath + Path +
                        resourceId);
            }

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
                uploadFiles.setCoverUrl( ResourcelibraryCommonUtil.getFilesThumbnailURL("", type) );
            }

            long fileSize = file.getSize();
            uploadFiles.setFileSize(fileSize + "");
            uploadFiles.setFileId(resourceId);
            uploadFiles.setFileName(name);
            uploadFiles.setFileType(type);
            uploadFiles.setFileUrl(Path + resourceId + "." + type);
            uploadFiles.setBusinessId(resourceId);
            uploadFiles.setTablename("ZYK_RESOURCE_PRIVATE");
            uploadFiles.setCreator(CommonUtil.getPersonId());
            uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            resourceFilesService.saveResourceFiles(uploadFiles);

            ResourcePrivate resourcePrivate = new ResourcePrivate();
            resourcePrivate.setResourceName(resourceName);
            resourcePrivate.setResourceType(resourceType);
            resourcePrivate.setRemark(remark);
            resourcePrivate.setResourceId(resourceId);
            resourcePrivate.setResourceCustom(resourceCustom);
            CommonUtil.save(resourcePrivate);
            resourcePrivateService.saveResourcePrivate(resourcePrivate);

            ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
            resourceOperateLog.setResourceId(resourceId);
            resourceOperateLog.setBusinessId(resourceId);
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PRIVATE");
            resourceOperateLog.setOperateType("1");
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);

            return new Message(1, "上传成功！文件需要转码，请稍后查看。", "success");
        } catch (IOException e) {
            e.printStackTrace();
            return new Message(0, "上传失败！", "error");
        }
    }

    //修改弹出页面
    @RequestMapping("/resourcePrivate/toResourcePrivateEdit")
    public String toEdit(String id, Model model) {
        ResourcePrivate resourcePrivate = resourcePrivateService.getResourcePrivateById(id);
        model.addAttribute("resourcePrivate", resourcePrivateService.getResourcePrivateById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/approval/resourcePrivateEdit";
    }

    //删除方法
    @ResponseBody
    @RequestMapping("/resourcePrivate/delResourcePrivate")
    public Message del(String id) {
        resourcePrivateService.delResourcePrivate(id);
        ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
        resourceOperateLog.setResourceId(id);
        resourceOperateLog.setBusinessId(id);
        resourceOperateLog.setLogId(CommonUtil.getUUID());
        CommonUtil.save(resourceOperateLog);
        resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PRIVATE");
        resourceOperateLog.setOperateType("3");
        resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);
        return new Message(0, "删除成功！", "success");
    }

    //填写申请理由
    @RequestMapping("/resourcePrivate/toUpResourcePrivate")
    public String toUpResourcesPrivate(String resourceId, String resourceName, String requestType, Model model) {
//        ResourcePrivate resourcePrivate = resourcePrivateService.getResourcePrivateById(resourceId);
        if (requestType.equals("1"))
            model.addAttribute("head", "分享到公共资源");
        else if (requestType.equals("2"))
            model.addAttribute("head", "分享到精品课");
//        model.addAttribute("resourcePrivate",resourcePrivate);
        model.addAttribute("resourceId", resourceId);
        model.addAttribute("requestType", requestType);
        model.addAttribute("resourceName", resourceName);
        return "/resourcelibrary/approval/upResourcePrivate";
    }

    //填写申请理由
    @RequestMapping("/resourcePrivate/toUpResourcePrivate2")
    public String toUpResourcesPrivate2(String resourceId, String resourceName, String requestType, Model model) {
//        ResourcePrivate resourcePrivate = resourcePrivateService.getResourcePrivateById(resourceId);
        if (requestType.equals("1"))
            model.addAttribute("head", "分享到公共资源");
        else if (requestType.equals("2"))
            model.addAttribute("head", "分享到精品课");
//        model.addAttribute("resourcePrivate",resourcePrivate);
        model.addAttribute("resourceId", resourceId);
        model.addAttribute("requestType", requestType);
        model.addAttribute("resourceName", resourceName);
        return "/resourcelibrary/approval/upResourcePrivate2";
    }

    @Resource
    private ResourceApprovalService resourceApprovalService;

    //申请理由存入数据库
    @ResponseBody
    @RequestMapping("/resourcePrivate/toUpResourcePrivateAdd")
    public Message toUpResourcesPrivateAdd(String resourceId, String requestType, String reason) {
        ResourcePrivate resourcePrivate = new ResourcePrivate();
        resourcePrivate.setResourceId(resourceId);
        if (requestType.equals("1")) {
            resourcePrivate.setPublicFlag("2");
        } else if (requestType.equals("2")) {
            resourcePrivate.setClassicFlag("2");
        }
        CommonUtil.update(resourcePrivate);
        resourcePrivateService.updatePrivateFlag(resourcePrivate);


        String approvalId = CommonUtil.getUUID();

        LoginUser loginUser = CommonUtil.getLoginUser();
        ResourceApproval resourceApproval = new ResourceApproval();
        resourceApproval.setApprovalId(approvalId);
        resourceApproval.setResourceId(resourceId);
        resourceApproval.setRequestType(requestType);
        resourceApproval.setRequestReason(reason);
        resourceApproval.setCreator(loginUser.getPersonId());
        resourceApproval.setCreateDept(loginUser.getDefaultDeptId());
        resourceApprovalService.addApprovalPublic(resourceApproval);

        CommonUtil.update(resourcePrivate);
        ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
        resourceOperateLog.setResourceId(resourceId);
        resourceOperateLog.setBusinessId(approvalId);
        resourceOperateLog.setLogId(CommonUtil.getUUID());
        CommonUtil.save(resourceOperateLog);
        resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PRIVATE");
        resourceOperateLog.setOperateType("5");
        resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);

        return new Message(1, "申请成功！", "success");
    }

    @RequestMapping("/resourcePrivate/toPrivateIndex")
    public ModelAndView toIndex() {
        ModelAndView mv = new ModelAndView();
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }
        mv.addObject("userName", loginUser.getName());
        mv.setViewName("/resourcelibrary/privateResource/privateIndex");
        return mv;
    }

    @RequestMapping("/resourcePrivate/myResourceLibrary")
    public ModelAndView myResourceLibrary() {
        ModelAndView mv = new ModelAndView();
        LoginUser loginUser = CommonUtil.getLoginUser();
        mv.addObject("userName", loginUser.getName());
        mv.addObject("personId", loginUser.getPersonId());
        mv.setViewName("/resourcelibrary/privateResource/privateLibrary");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/resourcePrivate/getPrivateLibraryList")
    public Map getPrivateList(ResourcePrivate resourcePrivate) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (!loginUser.getPersonId().equals("sa")) {
            resourcePrivate.setCreator(CommonUtil.getPersonId());
            resourcePrivate.setCreateDept(CommonUtil.getDefaultDept());
        }
        List<ResourcePrivate> list = resourcePrivateService.getResourcePrivateList(resourcePrivate);
        return CommonUtil.tableMap(list);
    }

    //我的回收站弹出页面
    @RequestMapping("/resourcePrivate/toMyResourceRecycle")
    public String toMyResourceRecycle(Model model) {
        String personId = CommonUtil.getPersonId();
        model.addAttribute("personId", personId);
        return "/resourcelibrary/approval/myResourceRecycleList";
    }

    //我的回收站初始化页面
    @ResponseBody
    @RequestMapping("/resourcePrivate/myResourceRecycleList")
    public Map myResourceRecycleList(ResourcePrivate resourcePrivate) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (!loginUser.getPersonId().equals("sa")) {
            resourcePrivate.setCreator(CommonUtil.getPersonId());
            resourcePrivate.setCreateDept(CommonUtil.getDefaultDept());
        }
        List<ResourcePrivate> list = resourcePrivateService.myResourceRecycleList(resourcePrivate);
        return CommonUtil.tableMap(list);
    }

    //恢复资源按钮
    @ResponseBody
    @RequestMapping("/resourcePrivate/backResourceRecycle")
    public Message backResourceRecycleList(ResourcePrivate resourcePrivate) {
        String id = resourcePrivate.getResourceId();
        resourcePrivateService.backResourceRecycle(id);
        return new Message(0, "恢复成功！", "success");
    }

    //回收站物理删除
    @ResponseBody
    @RequestMapping("/resourcePrivate/delResourceRecycle")
    public Message delResourceRecycle(ResourcePrivate resourcePrivate) {
        String uploadFilePath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        String new_uploadFilePath = uploadFilePath.replaceAll("\\\\", "\\\\");
        String id = resourcePrivate.getResourceId();
        Files files = resourcePrivateService.selectFileURL(id);
        if (null != files) {
            String Path = files.getFileUrl();
            String new_Path = Path.replaceAll("/", "\\\\");
            String new_fileURL = new_uploadFilePath + new_Path;
            File tempFile = new File("file:///" + new_fileURL);
            File new_tempFile = new File(new_fileURL);
            if (!tempFile.exists()) {
                Boolean b = new_tempFile.delete();
                if (b) {
                    resourcePrivateService.delResourceRecycle(id);
                    resourcePrivateService.delResourceURL(id);
                    return new Message(0, "删除成功！", "success");
                } else {
                    resourcePrivateService.delResourceRecycle(id);
                    resourcePrivateService.delResourceURL(id);
                    return new Message(0, "文件不存在，已删除该条记录", "success");
                }
            } else {
                return new Message(0, "文件不存在！", "error");
            }
        } else {
            resourcePrivateService.delResourceRecycle(id);
            return new Message(0, "文件不存在，已删除该条记录", "success");
        }
    }

    @Resource
    private IndexSearchService indexSearchService;

    @RequestMapping("/resourcePrivate/getPrivateResourceViewMain")
    public ModelAndView getpublicViewRightMain(HttpServletRequest request, String resourceId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/resourcelibrary/privateResource/privateMainView");
        mv.addObject("resourceId", resourceId);

        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            loginUser.setPhotoUrl("dmitry_b.jpg");
        }
        mv.addObject("publicPerson", loginUser);

        ResourceView resourceView = new ResourceView();
        resourceView.setPublicPersonId(loginUser.getPersonId());
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


        ResourcePrivate resourcePrivate = resourcePrivateService.getResourcePrivateById(resourceId);
        ResourceFiles resourceFiles = (ResourceFiles) resourceFilesService.getResourceFilesById(resourceId);
        if(null ==resourceFiles || null == resourcePrivate){
            mv.addObject("fileView","/libs/img/building.png");
            mv.addObject("resourceFormat","2");
            mv.addObject("resourceName","资源丢失了");
        }else if (resourceFiles != null) {
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
            mv.addObject("fileUrl", resourceFiles.getFileUrl());
            mv.addObject("resourceName",resourcePrivate.getResourceName());
        }

        mv.addObject("head", "");
        mv.addObject("resourceId", resourceId);
        mv.addObject("resourcePrivate", resourcePrivate);
        mv.addObject("resourceFiles", resourceFiles);

        if (null == loginUser.getPhotoUrl() || loginUser.getPhotoUrl().equals("")) {
            mv.addObject("photoUrl", "dmitry_b.jpg");
        } else {
            mv.addObject("photoUrl", loginUser.getPhotoUrl());
        }

        return mv;
    }

    @RequestMapping("/resourcePrivate/toBatchAdd")
    public String toBatchAdd() {
        return "resourcelibrary/approval/batchPublicResource";
    }

}
