package com.goisan.system.controller;

import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.educational.major.service.MajorService;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/7/24.
 */
@Controller
public class FilesController extends HttpServlet {
    @Resource
    private FilesService filesService;

    public static String COM_REPORT_PATH = null;


    /**
     * 通过id查询文件
     */
    @ResponseBody
    @RequestMapping("/files/getFilesById")
    public Map<String, Object> getFilesById(String id){

        Map<String ,Object> tmapList=new HashMap();
        List<Files> list=this.filesService.getFilesByFilesId(id);
        tmapList.put("draw", 1);
        tmapList.put("recordsTotal", 1);
        tmapList.put("recordsFiltered", 1);
        tmapList.put("data", list);
        return tmapList;
    }
    /**
     * 文件上传跳转
     */
    @RequestMapping("/files/filesUpload")
    public ModelAndView filesUpload(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("core/files/addFiles");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "文件上传");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }

    /**
     * 文件上传跳转
     */
    @RequestMapping("/files/filesUploadCompetition")
    public ModelAndView filesUploadCompetition(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("core/files/addFilesCompetition");
        List<Files> files = filesService.getFilesByBusinessIdCompetition(businessId);
        mv.addObject("head", "文件上传");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }

    /**
     * 人才培养文件上传跳转
     */
    @RequestMapping("/files/filesUploadTalentTrain")
    public ModelAndView filesUploadTraining(String id, String tableName, String businessType, String appendixType,
                                            String talentTrainId) {
        ModelAndView mv = new ModelAndView("core/files/showTalentTrainFiles");
        List<Files> files = filesService.getFilesByFilesId(id);
        mv.addObject("head", "文件上传");
        mv.addObject("id", id);
        mv.addObject("tableName", tableName);
        mv.addObject("talentTrainId", talentTrainId);
        mv.addObject("appendixType", appendixType);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }

    /**
     * 文件上传跳转
     */
    @RequestMapping("/files/filesUploadTable")
    public ModelAndView filesUploadSel(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("core/files/addFilesTable");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "文件上传");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }

    /**
     * 文件下载跳转
     */
    @RequestMapping("/files/filesUploadTable1")
    public ModelAndView filesUpload1(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("core/files/addFilesTable1");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "文件上传");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }

    /**
     * 文件上传跳转
     */
    @RequestMapping("/files/filesUploadType")
    public ModelAndView filesUploadType(String businessId, String tableName, String businessType,String type) {
        ModelAndView mv = new ModelAndView("core/files/addFilesTypes");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "文件上传");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        mv.addObject("type", type);
        return mv;
    }




    @ResponseBody
    @RequestMapping("/files/insertFiles")
    public void upload(@RequestParam(value = "files[]", required = false) MultipartFile[] files,
                       HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        for (int i=0;i<files.length;i++) {
            MultipartFile file =files[i];
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
            Files uploadFiles = new Files();
            String id=CommonUtil.getUUID();
            uploadFiles.setFileId(id);
            uploadFiles.setFileName(fileName);
            uploadFiles.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));
            uploadFiles.setFileUrl(url);
            uploadFiles.setBusinessId(request.getParameter("businessId"));
            uploadFiles.setTableName(request.getParameter("tableName"));
            uploadFiles.setBusinessType(request.getParameter("businessType"));
            uploadFiles.setCreator(CommonUtil.getPersonId());
            uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            filesService.insertFiles(uploadFiles);
        }
    }

    @ResponseBody
    @RequestMapping("/app/files/insertFiles")
    public void appUpload(@RequestParam(value = "file", required = false) MultipartFile[] files,
                       HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        for (MultipartFile file : files) {
            if(file.getSize() > 0){
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
                Files uploadFiles = new Files();
                uploadFiles.setFileId(CommonUtil.getUUID());
                uploadFiles.setFileName(fileName);
                uploadFiles.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));
                uploadFiles.setFileUrl(url);
                uploadFiles.setBusinessId(request.getParameter("businessId"));
                uploadFiles.setTableName(request.getParameter("tableName"));
                uploadFiles.setBusinessType(request.getParameter("businessType"));
                uploadFiles.setCreator(CommonUtil.getPersonId());
                uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                filesService.insertFiles(uploadFiles);
            }
        }
    }


    @ResponseBody
    @RequestMapping("/files/downloadFiles")
    public void downLoadFiles(String id, HttpServletResponse response) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        Files files = filesService.getFilesById(id);
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

    /**
     * 查看文件跳转
     */
    @RequestMapping("/files/lookFiles")
    public ModelAndView lookFiles(String personFilesId) {
        ModelAndView mv = new ModelAndView("/core/files/lookFiles");
        List<Files> uploadFiles = filesService.getFilesByBusinessId(personFilesId);
        for (Files uploadFile : uploadFiles) {
            uploadFile.setFileType(uploadFile.getFileType().substring(1));
            uploadFile.setFileUrl(uploadFile.getFileUrl().substring(8));
        }
        mv.addObject("head", "查看文件");
        mv.addObject("uploadFiles", uploadFiles);
        mv.addObject("personFilesId", personFilesId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/files/getFilesByBusinessId")
    public Map getFilesByBusinessId(String businessId) {
        return CommonUtil.tableMap(filesService.getFilesByBusinessId(businessId));
    }

    @ResponseBody
    @RequestMapping("/files/getFilesByBusinessIdCompetition")
    public Map getFilesByBusinessIdCompetition(String businessId) {
        return CommonUtil.tableMap(filesService.getFilesByBusinessIdCompetition(businessId));
    }

    @ResponseBody
    @RequestMapping("/files/getFilesByBusinessIdTraining")
    public Map getFilesByBusinessIdTraining(String businessId) {
        return CommonUtil.tableMap(filesService.getFilesByBusinessIdTraining(businessId));
    }


    @ResponseBody
    @RequestMapping("/files/delFile")
    public Message delFile(String id) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        Files file = filesService.getFilesById(id);
        File f = new File(COM_REPORT_PATH + file.getFileUrl());
        f.delete();
        filesService.delFilesById(id);
        return new Message(1, "删除成功！", null);
    }

    @Resource
    MajorService majorService;
    @ResponseBody
    @RequestMapping("/files/delTalentFile")
    public Message delTeachFile(String id, String talentTrainId, String appendixType) {
        TalentTrain talentTrain=this.majorService.getTalentTrainById(talentTrainId);
        if("1".equals(talentTrain.getRequestFlag())||"2".equals(talentTrain.getRequestFlag())){
            return new Message(0, "当前数据已提交，无法删除！",null);
        }
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        Files file = filesService.getFilesById(id);
        if(file!=null){
            File f = new File(COM_REPORT_PATH + file.getFileUrl());
            f.delete();
            filesService.delFilesById(id);
            switch (appendixType){
                case "teachFile11":
                    majorService.clearTeachFile(talentTrainId);
                    break;
                case "practiceFile":
                    majorService.clearPtacticeFile(talentTrainId);
                    break;
                case "distributeFile":
                    majorService.clearDistributeFile(talentTrainId);
                    break;

            }
            return new Message(1, "删除成功！", null);
        }else{
            return new Message(0,"删除失败，文件不存在！",null);
        }
    }
}
