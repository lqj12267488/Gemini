package com.goisan.files.service;

import com.goisan.files.bean.ResourceFiles;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceFilesService {

    List<BaseBean> getResourceFilesList(BaseBean baseBean);

    void saveResourceFiles(BaseBean baseBean);

    BaseBean getResourceFilesById(String id);

    void updateResourceFiles(BaseBean baseBean);

    void delResourceFiles(String id);

    List<ResourceFiles> getUnDeDodeWord();

    void updateResourceFileStatus(String fileId,int status);
}