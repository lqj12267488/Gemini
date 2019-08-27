package com.goisan.archives.dao;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArchivesTypeDao {
    List<Tree> getArchivesTypeTree();
    ArchivesType getArchivesTypeById(String typeId);
    List<ArchivesType> checkName(ArchivesType archivesType);
    String getMaxDeptOrder(String parentTypeId);
    String getMaxTypeid(String pId);
    void saveArchivesType(ArchivesType archivesType);
    void updateArchivesType(ArchivesType archivesType);
    void deleteArchivesType(String id);
    String getTypeName(String pId);
}
