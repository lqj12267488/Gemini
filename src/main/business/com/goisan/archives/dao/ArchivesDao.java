package com.goisan.archives.dao;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.bean.ArchivesRole;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface ArchivesDao {
    List<Archives> getArchivesList(Archives archives);

    Archives getArchivesById(String archivesId);

    void insertArchives(Archives archives);

    void updateArchives(Archives archives);

    void updateValidFlag(Archives archives);

    void deleteArchivesById(String archivesId);

    String getPersonNameById(String id);

    String getDeptNameById(String id);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<Select2> getDeptList();

    String getStaffBelongs(String personId);

    ArchivesFile getArchivesFilesById(String archivesId);

    List<ArchivesFile> getFilesByArchivesId(String archivesId);

    List<Archives> getArchivesLogList(Archives archives);

    ArchivesFile getArchivesFileById(String fileId);

    void insertArchivesFile(ArchivesFile archivesFile);

    void deleteFileByFileId(String fileId);

    void deleteFileByArchivesId(String archivesId);

    void archivesRequestFlag(Archives archives);

    void archivesEditRequest(Archives archives);

    void updateArchivesDelStateById(Archives archives);

    List<Archives> getArchivesRecycleBinList(Archives archives);

    void delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(String archivesId, String checkList);

    void delRoleEmpDeptByArchivesId(String archivesId);

    void insertRoleEmpDept(ArchivesRole ar);

    List<EmpDeptTree> getArchivesDeptAndPersonTree(String id);

    Archives getPrintById(String archivesId);

    List<Archives> getAllArchivesList(Archives archives);
    void insertArchivesLog(Archives archives);
}
