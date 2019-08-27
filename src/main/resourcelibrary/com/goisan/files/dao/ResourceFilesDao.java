package com.goisan.files.dao;

import com.goisan.files.bean.ResourceFiles;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourceFilesDao {

    List<BaseBean> getResourceFilesList(BaseBean baseBean);

    void saveResourceFiles(BaseBean baseBean);

    BaseBean getResourceFilesById(String id);

    void updateResourceFiles(BaseBean baseBean);

    void delResourceFiles(String id);

    List<ResourceFiles> getUnDeDodeWord();

    void updateResourceFileStatus(@Param("fileId") String fileId, @Param("status") int status);
}
