package com.goisan.archives.dao;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.bean.ArchivesRole;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArchivesDao {
    List<Archives> getArchivesList(Archives archives);

    Archives getArchivesById(String archivesId);

    String getArchivesName(String oneLevel);

    Archives getArchivesByIds(String businessId);

    void insertArchives(Archives archives);

    void updateArchives(Archives archives);

    void updateArchivesState(String id);

    void updateValidFlag(Archives archives);

    void updateArchivesInfo(String id);

    void deleteArchivesById(String archivesId);

    String getPersonNameById(String id);

    String getDeptNameById(String id);

    String getFileNum(String id);

    String getArchivesCode(String id);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();
    List<AutoComplete> selectRequester(String deptId);

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

    List<EmpDeptTree> getArchivesDeptAndPersonTree(EmpDeptTree edt);

    Archives getPrintById(String archivesId);

    List<Archives> getAllArchivesList(Archives archives);
    void insertArchivesLog(Archives archives);

    void updateArchivesRemark(Archives archives);

    List<Archives> getArchivesHeadmasterList(Archives archives);

    void archivesRoleTakeBack(String id);

    void updateArchivesRoleState(String id);

    void updateRoleState(String archivesId);

    Archives getArchivesLogById(String archivesId);

    List getArchivesCheckEmp(@Param("archivesId") String archivesId, @Param("deptId") String deptId);

    List<Emp> getPersonBydeptId(@Param("deptId") String deptId);

    void delArchivesPower(@Param("archivesId") String archivesId, @Param("deptId") String deptId);

    String getCheckListCount(Archives archives);

    List<Archives> allArchivesId(Archives arc);

    List<Archives> getArchivesListBumen(Archives archives);

    List<Archives> getArchivesListLingDao(Archives archives);
    ArchivesFile getArchivesFileByFileId(@Param("fileId") String fileId);
}
