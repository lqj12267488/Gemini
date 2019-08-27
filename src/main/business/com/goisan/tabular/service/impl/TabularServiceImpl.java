package com.goisan.tabular.service.impl;


import com.goisan.tabular.bean.Tabular;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.dao.TabularDao;
import com.goisan.tabular.service.TabularService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TabularServiceImpl implements TabularService {
    @Resource
    private TabularDao tabularDao;


    public List<Tabular> getTabularList(Tabular tabular) {
        return tabularDao.getTabularList(tabular);
    }

    public Tabular getTabularById(String id) {
        return tabularDao.getTabularById(id);
    }

    public void insertTabular(Tabular tabular) {
        tabularDao.insertTabular(tabular);
    }

    public void updateTabular(Tabular tabular) {
        tabularDao.updateTabular(tabular);
    }

    public void deleteTabular(String id) {
        tabularDao.deleteTabular(id);
    }

    public List<Tabular> checkTabular(String tabularType) {
        return tabularDao.checkTabular(tabularType);
    }

    public TabularFile getTabularFileById(String fileId) {
        return tabularDao.getTabularFileById(fileId);
    }

    public void insertTabularFile(TabularFile uploadFile) {
        tabularDao.insertTabularFile(uploadFile);
    }

    public String getFileIdByTabularId(String id) {
        return tabularDao.getFileIdByTabularId(id);
    }

    public List checkName(Tabular tabular) {
        return tabularDao.checkName(tabular);
    }
}
