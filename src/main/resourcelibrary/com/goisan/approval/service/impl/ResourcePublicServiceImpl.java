package com.goisan.approval.service.impl;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.approval.dao.ResourcePublicDao;
import com.goisan.approval.service.ResourcePublicService;
import com.goisan.common.ResourcelibraryCommonUtil;
import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.dao.ResourceFilesDao;
import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.dao.ResourceOperateLogDao;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class ResourcePublicServiceImpl implements ResourcePublicService {
    @Resource
    private ResourcePublicDao resourcePublicDao;
    @Resource
    private ResourceFilesDao resourceFilesDao;
    @Resource
    private ResourceOperateLogDao resourceOperateLogDao;

    public List<BaseBean> getResourcePublicList(BaseBean baseBean) {
        return resourcePublicDao.getResourcePublicList(baseBean);
    }

    public List<BaseBean> getPublicList(BaseBean baseBean) {
        return resourcePublicDao.getPublicList(baseBean);
    }

    public void saveResourcePublic(BaseBean baseBean) {
        resourcePublicDao.saveResourcePublic(baseBean);
    }

    public void addResourcePublic(BaseBean baseBean) {
        resourcePublicDao.addResourcePublic(baseBean);
    }

    public BaseBean getResourcePublicById(BaseBean baseBean) {
        return resourcePublicDao.getResourcePublicById(baseBean);
    }

    public void updateResourcePublic(BaseBean baseBean) {
        resourcePublicDao.updateResourcePublic(baseBean);
    }

    public void delResourcePublic(String id) {
        resourcePublicDao.delResourcePublic(id);
    }

    @Override
    public ResourcePublic toEditExcellect(BaseBean baseBean) {
        return resourcePublicDao.toEditExcellect(baseBean);
    }

    @Override
    public List<Tree> getResourceTree() {
        return resourcePublicDao.getResourceTree();
    }

    @SuppressWarnings("ResultOfMethodCallIgnored")
    @Override
    @Transactional
    public void batchUpdate(MultipartFile[] files, ResourcePublic resourcePublic, String comReportPath) {
        String time = new SimpleDateFormat("yyyyMMdd").format(new Date());
//        System.out.println(comReportPath);
        String path = "/resourcefiles/ZYK_RESOURCE_PUBLIC/" + time + "/";
        if ("undefined".equals(resourcePublic.getResourceMajorId())) {
            resourcePublic.setResourceMajorId(null);
        }
        if ("undefined".equals(resourcePublic.getResourceCourseId())) {
            resourcePublic.setResourceCourseId(null);
        }
        ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
        ResourceFiles resourceFiles = new ResourceFiles();
        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();
            String id = CommonUtil.getUUID();
            resourcePublic.setResourceId(id);
            resourcePublic.setResourceName(fileName);
            resourcePublic.setResourceType("99");
            resourcePublic.setPublicTime(CommonUtil.now("yyyy-MM-dd"));
            resourcePublic.setCreator(CommonUtil.getPersonId());
            resourcePublic.setResourceFormat(CommonUtil.getFileType(fileName));
            resourcePublic.setCreateTime(new Timestamp(System.currentTimeMillis()));
            CommonUtil.save(resourcePublic);
            resourcePublic.setPublicPersonId(CommonUtil.getPersonId());
            resourcePublic.setPublicDeptId(CommonUtil.getDefaultDept());
            resourcePublic.setPublicFlag("1");
            resourcePublic.setClassicFlag("0");
            resourcePublicDao.saveResourcePublic(resourcePublic);
            resourceFiles.setFileId(id);
            resourceFiles.setFileType(CommonUtil.getFileExt(fileName));
            resourceFiles.setBusinessId(id);
            resourceFiles.setFileSize(file.getSize() + "");
            resourceFiles.setFileName(fileName);
            resourceFiles.setFileUrl(path + id + "." + CommonUtil.getFileExt(fileName));
            resourceFiles.setIsTranscoding(0);
            resourceFiles.setTablename("ZYK_RESOURCE_PUBLIC");
            resourceFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            resourceFiles.setCoverUrl( ResourcelibraryCommonUtil.getFilesThumbnailURL("", resourceFiles.getFileType()) );

            resourceFilesDao.saveResourceFiles(resourceFiles);
            resourceOperateLog.setResourceId(id);
            resourceOperateLog.setBusinessId(id);
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);    // zyk_resource_public
            resourceOperateLog.setResourceTablename("ZYK_RESOURCE_PUBLIC");
            resourceOperateLog.setOperateType("1");
            resourceOperateLogDao.saveResourceOperateLog(resourceOperateLog);
            File f = new File(comReportPath + path);
            f.mkdirs();
            File out = new File(comReportPath + path + id + "." + CommonUtil.getFileExt(fileName));
            try {
                FileUtils.writeByteArrayToFile(out, file.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
