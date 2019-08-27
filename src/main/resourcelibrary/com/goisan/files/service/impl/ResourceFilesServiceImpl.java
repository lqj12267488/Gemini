package com.goisan.files.service.impl;

import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.dao.ResourceFilesDao;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceFilesServiceImpl implements ResourceFilesService {
    @Resource
    private ResourceFilesDao resourceFilesDao;

    public List<BaseBean> getResourceFilesList(BaseBean baseBean) {
        return resourceFilesDao.getResourceFilesList(baseBean);
    }

    public void saveResourceFiles(BaseBean baseBean) {
        resourceFilesDao.saveResourceFiles(baseBean);
    }

    public BaseBean getResourceFilesById(String id) {
        return resourceFilesDao.getResourceFilesById(id);
    }

    public void updateResourceFiles(BaseBean baseBean) {
        resourceFilesDao.updateResourceFiles(baseBean);
    }

    public void delResourceFiles(String id) {
        resourceFilesDao.delResourceFiles(id);
    }

    public List<ResourceFiles> getUnDeDodeWord() {
        return resourceFilesDao.getUnDeDodeWord();
    }

    public void updateResourceFileStatus(String fileId, int status) {
        resourceFilesDao.updateResourceFileStatus(fileId, status);
    }
}
