package com.goisan.tabular.service;


import com.goisan.tabular.bean.Tabular;
import com.goisan.tabular.bean.TabularFile;

import java.util.List;

public interface TabularService {

    List<Tabular> getTabularList(Tabular tabular);

    Tabular getTabularById(String id);

    void insertTabular(Tabular tabular);

    void updateTabular(Tabular tabular);

    void deleteTabular(String id);

    List<Tabular> checkTabular(String tabularType);

    TabularFile getTabularFileById(String fileId);

    void insertTabularFile(TabularFile uploadFile);

    String getFileIdByTabularId(String id);

    List checkName(Tabular tabular);
}
