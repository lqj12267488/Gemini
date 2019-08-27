package com.goisan.tabular.dao;

import com.goisan.tabular.bean.Tabular;
import com.goisan.tabular.bean.TabularFile;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TabularDao {

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
