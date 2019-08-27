package com.goisan.system.service;

import com.goisan.system.bean.Files;

import java.util.List;

/**
 * Created by Administrator on 2017/7/24.
 */
public interface FilesService {

    List<Files> getFilesByFilesId(String id);
    void insertFiles(Files files);

    Files getFilesById(String id);

    String getDownloadFilesUrl(String id);

    List<Files> getFilesByBusinessId(String businessId);

    List<Files> getFilesByBusinessIdCompetition(String businessId);

    List<Files> getFilesByBusinessIdTraining(String businessId);

    void delFilesById(String id);

    void delFilesByBusinessId(String businessId);
}
