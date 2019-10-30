package com.goisan.archives.service;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.bean.ArchivesRole;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ArchivesService {
    List<Archives> getArchivesList(Archives archives);

    Archives getArchivesById(String archivesId);

    String getArchivesName(String oneLevel);

    Archives getArchivesByIds(String businessId);

    void insertArchives(Archives archives);

    void updateArchives(Archives archives);

    void updateArchivesState(String id);

    void updateArchivesInfo(String id);

    void updateValidFlag(Archives archives);

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

    @Transactional
    void delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(String archivesId, String checkList);

    void delRoleEmpDeptByArchivesId(String id);

    void insertRoleEmpDept(ArchivesRole ar);

    List<EmpDeptTree> getArchivesDeptAndPersonTree(EmpDeptTree edt);

    Archives getPrintById(String archivesId);

    Archives getArchivesLogById(String archivesId);

    List<Archives> getAllArchivesList(Archives archives);
    void insertArchivesLog(Archives archives);

    void updateArchivesRemark(Archives archives);

    List<Archives> getArchivesHeadmasterList(Archives archives);

    List<Archives> getArchivesListLingDao(Archives archives);//校领导

    List<Archives> getArchivesListBumen(Archives archives);//部门主任

    void archivesRoleTakeBack(String id);

    void updateArchivesRoleState(String id);

    void updateRoleState(String archivesId);

    List getArchivesCheckEmp(String archivesId, String deptId);

    List<Emp> getPersonBydeptId(String deptId);

    void saveArchivesPower(String deptId, String archivesId, String checkList);

    String getCheckListCount(Archives archives);

    List<Archives> allArchivesId(Archives arc);

    List<Files> getFilesByBusinessId(String businessId);

    Files getFileById(String fileId);

    ArchivesFile getArchivesFileByFileId(@Param("fileId") String fileId);
}
