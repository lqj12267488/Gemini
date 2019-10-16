package com.goisan.system.service.impl;

import com.goisan.system.bean.Files;
import com.goisan.system.dao.FilesDao;
import com.goisan.system.service.FilesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

/**
 * Created by Administrator on 2017/7/24.
 */
@Service
public class FilesServiceImpl implements FilesService {
    @Resource
    FilesDao filesDao;

    public List<Files> getFilesByFilesId(String id){
        return this.filesDao.getFilesByFilesId(id);
    }

    public void insertFiles(Files files) {
        filesDao.insertFiles(files);
    }

    public Files getFilesById(String id) {
        return filesDao.getFilesById(id);
    }

    public String getDownloadFilesUrl(String id) {
        return filesDao.getDownloadFilesUrl(id);
    }

    public List<Files> getFilesByBusinessId(String businessId) {
        return filesDao.getFilesByBusinessId(businessId);
    }

    public List<Files> getFilesByBusinessIdCompetition(String businessId) {
        return filesDao.getFilesByBusinessIdCompetition(businessId);
    }

    public List<Files> getFilesByBusinessIdTraining(String businessId) {
        return filesDao.getFilesByBusinessIdTraining(businessId);
    }

    public void delFilesById(String id) {
        filesDao.delFilesById(id);
    }

    public void delFilesByBusinessId(String businessId) {
        String path = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        for (Files file : filesDao.getFilesByBusinessId(businessId)) {
            File f = new File(path + file.getFileUrl());
            f.delete();
        }
        filesDao.delFilesByBusinessId(businessId);
    }

    @Override
    public Files getFileById(String fileId) {
        return filesDao.getFileById(fileId);
    }
}
