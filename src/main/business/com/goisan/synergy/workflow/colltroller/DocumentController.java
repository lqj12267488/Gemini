package com.goisan.synergy.workflow.colltroller;

import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.synergy.workflow.bean.Document;
import com.goisan.synergy.workflow.bean.DocumentProcess;
import com.goisan.synergy.workflow.service.DocumentService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.task.bean.SysTask;
import com.goisan.task.service.TaskService;
import com.goisan.workflow.bean.*;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.NodeService;
import com.goisan.workflow.service.WorkflowService;
import com.goisan.workflow.util.UpdateBusiness;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/7/20.
 */
@Controller
public class DocumentController {


    @Resource
    private WorkflowService workflowService;
    @Resource
    private NodeService nodeService;
    @Resource
    private DefinitionService definitionService;
    @Resource
    private EmpService empService;
    @Resource
    private TaskService taskService;
    @Resource
    private UpdateBusiness updateBusiness;
    @Resource
    private ScoreChangeService scoreChangeService;
    @Resource
    private DocumentService documentService;
    @Resource
    private StampService stampService;
    @Resource
    private CommonService commonService;

    /**
     * 发文申请申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/document/request")
    public ModelAndView documentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/document/document");
        return mv;
    }

    /**
     * 发文申请URL
     * url by hanyue
     * modify by hanyue
     *
     * @param document
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getDocumentList")
    public Map<String, List<Document>> getDocumentList(Document document) {
        Map<String, List<Document>> documentMap = new HashMap<String, List<Document>>();
        document.setCreator(CommonUtil.getPersonId());
        document.setCreateDept(CommonUtil.getDefaultDept());
        documentMap.put("data", documentService.getDocumentList(document));
        return documentMap;
    }

    /**
     * 发文申请新增
     * add by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/document/editDocument")
    public ModelAndView addDocument() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/editDocument");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = documentService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = documentService.getDeptNameById(CommonUtil.getDefaultDept());
        Document document = new Document();
        document.setRequester(personName);
        document.setRequestDate(datetime);
        document.setRequestDept(deptName);
        mv.addObject("head", "发文申请新增");
        mv.addObject("document", document);
        return mv;
    }

    /**
     * 发文申请修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getDocumentById")
    public ModelAndView getDocumentById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/updateDocument");
        Document document = documentService.getDocumentById(id);
        mv.addObject("head", "发文申请修改");
        mv.addObject("document", document);
        return mv;
    }

    /**
     * 发文修改文号
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getDocumentSymbolById")
    public ModelAndView getDocumentSymbolById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/updateDocumentSymbol");
        Document document = documentService.getDocumentById(id);
        mv.addObject("head", "发文申请文号发布");
        mv.addObject("document", document);
        return mv;
    }


    /**
     * 文号发布
     * @param document
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/updateDocumentSymbol")
    public Message updateDocumentSymbol(Document document) {
        List<Document> list = documentService.getSymbolById(document.getSymbol());
        if(list.size()>0){
            return new Message(0, "发布失败，文号重复！", "error");
        }else{
            document.setChanger(CommonUtil.getPersonId());
            document.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            documentService.updateDocumentByBusinessId(document);
            return new Message(1, "发布成功！", "success");
        }
    }


    /**
     * 保存发文申请
     * save by hanyue
     * modify by hanyue
     *
     * @return
     */

    @ResponseBody
    @RequestMapping("/document/saveDocument")
    public void insertTabularFiles(@RequestParam("id") String id,
                                   @RequestParam("requestDate") String requestDate,
                                   @RequestParam("fileTitle") String fileTitle,
                                   @RequestParam("deliveryEmpId") String deliveryEmpId,
                                   @RequestParam("makeEmpId") String makeEmpId,
                                   @RequestParam("secretClass") String secretClass,
                                   @RequestParam("title") String title,
                                   @RequestParam("printingNumber") String printingNumber,
                                   @RequestParam("symbol") String symbol,
                                   @RequestParam(value = "file", required = false) CommonsMultipartFile files,
                                   HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";
        String fileName = "";
        String uuid = "";
        String url = "";
        if ((!"".equals(files)) && null != files) {
            fileName = files.getOriginalFilename();
            String path = String.format(urlParten, sdf1.format(new Date()));
            uuid = CommonUtil.getUUID();
            url = path + "/" + uuid + fileName.substring(fileName.lastIndexOf("."));
            FileOutputStream fos = null;
            try {
                File f = new File(COM_REPORT_PATH + path);
                f.mkdirs();
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(files.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        Document document = new Document();
        document.setFileTitle(fileTitle);
        document.setDeliveryEmpId(deliveryEmpId);
        document.setMakeEmpId(makeEmpId);
        document.setSecretClass(secretClass);
        document.setTitle(title);
        document.setPrintingNumber(printingNumber);
        document.setSymbol(symbol);
        if ("".equals(id) || null == id) {
            document.setCreator(CommonUtil.getPersonId());
            document.setCreateDept(CommonUtil.getDefaultDept());
            document.setRequester(CommonUtil.getPersonId());
            document.setRequestDept(CommonUtil.getDefaultDept());
            document.setId(CommonUtil.getUUID());
            document.setRequestDate(requestDate);
            documentService.insertDocument(document);
        } else {
            document.setId(id);
            document.setChanger(CommonUtil.getPersonId());
            document.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            documentService.updateDocumentById(document);
        }


        DocumentProcess uploadFile = new DocumentProcess();
        uploadFile.setId(CommonUtil.getUUID());
        uploadFile.setDocumentId(document.getId());
        uploadFile.setEdition("1.0");
        uploadFile.setFileName(fileName);
        uploadFile.setFileUrl(url);
        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
        uploadFile.setCreator(CommonUtil.getPersonId());
        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        documentService.insertDocumentProcess(uploadFile);

    }

    public static String COM_REPORT_PATH = null;

    @ResponseBody
    @RequestMapping("/document/downloadDocumentFile")
    public void downloadTabularFile(@Param("id") String id, HttpServletResponse response) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        String fileId = documentService.getFileIdByDocumentId(id);
        DocumentProcess files = documentService.getDocumentProcessById(fileId);
        String filePath = COM_REPORT_PATH + files.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(files.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @ResponseBody
    @RequestMapping("/document/updateDocument")
    public Message updateTabular(Document document) {
        document.setChanger(CommonUtil.getPersonId());
        document.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        documentService.updateDocumentById(document);
        return new Message(1, "修改成功！", "success");

    }


    /**
     * 删除发文申请
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/deleteDocumentById")
    public Message deleteDocumentById(String id) {
        documentService.deleteDocumentById(id);
        documentService.deleteDocumentProcessById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return documentService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return documentService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/document/process")
    public ModelAndView documentProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/document/documentProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param document
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getProcessList")
    public Map<String, List<Document>> getProcessList(Document document) {
        Map<String, List<Document>> documentMap = new HashMap<String, List<Document>>();
        document.setCreator(CommonUtil.getPersonId());
        document.setCreateDept(CommonUtil.getDefaultDept());
        document.setChanger(CommonUtil.getPersonId());
        document.setChangeDept(CommonUtil.getDefaultDept());
        documentMap.put("data", documentService.getProcessList(document));
        return documentMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/document/complete")
    public ModelAndView documentComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/document/documentComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param document
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getCompleteList")
    public Map<String, List<Document>> getCompleteList(Document document) {
        Map<String, List<Document>> documentMap = new HashMap<String, List<Document>>();
        document.setCreator(CommonUtil.getPersonId());
        document.setCreateDept(CommonUtil.getDefaultDept());
        document.setChanger(CommonUtil.getPersonId());
        document.setChangeDept(CommonUtil.getDefaultDept());
        documentMap.put("data", documentService.getCompleteList(document));
        return documentMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/auditDocumentEdit")
    public ModelAndView auditDocumentEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/editDocumentProcess");
        Document document = documentService.getDocumentById(id);
        mv.addObject("head", "修改");
        mv.addObject("document", document);
        return mv;
    }

    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/auditDocumentById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/addDocumentProcess");
        Document document = documentService.getDocumentById(id);
        mv.addObject("head", "审批");
        mv.addObject("document", document);
        return mv;
    }

    /**
     * 判断本次申请是否已办理完成
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/checkRequestFlagById")
    public Message checkRequestFlagById(String id) {
        List<Document> list = documentService.getRequestFlagById(id);
        if(list.size()>0){
            return new Message(1, "", null);
        }else{
            return new Message(0, "不能发布，本次申请未办理完成！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/document/printDocument")
    public ModelAndView printDocument(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/printDocument");
        Document document = documentService.getDocumentById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_DOCUMENT_WF01");
        String state = stampService.getStateById(id);
        Start start = documentService.getStartByBusinessId(id);
        String remark = documentService.getRemarkByRoleDeans(start);
        List<Handle> list = documentService.getDocumentHandleById(id);
        String heGao=documentService.getDocumentHandleById2(id,"办公室主任");
        String jiaoDui=documentService.getDocumentHandleById2(id,"文书");

        String handleTime = documentService.getHandleTime(id);
        int size = list.size();
        mv.addObject("handleList", list);
        mv.addObject("size", size);
        mv.addObject("state", state);
        String requestDate = document.getRequestDate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("document", document);
        mv.addObject("workflowName", workflowName);
        mv.addObject("remark", remark);
        mv.addObject("handleTime", handleTime);
        mv.addObject("heGao", heGao);
        mv.addObject("jiaoDui", jiaoDui);
        return mv;
    }

    /**
     * 查询附件
     *
     * @param businessId
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/getFilesByBusinessId")
    public Map getFilesByBusinessId(String businessId) {
        return CommonUtil.tableMap(documentService.getDocumentProcessByBusinessId(businessId));
    }


    @ResponseBody
    @RequestMapping("/document/audits")
    public Message documentAudits(@RequestParam("term") String term,
                                  @RequestParam("remark") String remark,
                                  @RequestParam("businessId") String businessId,
                                  @RequestParam("tableName") String tableName,
                                  @RequestParam(value = "file", required = false) CommonsMultipartFile files,
                                  HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";
        String fileName = "";
        String uuid = "";
        String url = "";
        if ((!"".equals(files)) && null != files) {
            fileName = files.getOriginalFilename();
            String path = String.format(urlParten, sdf1.format(new Date()));
            uuid = CommonUtil.getUUID();
            url = path + "/" + uuid + fileName.substring(fileName.lastIndexOf("."));
            FileOutputStream fos = null;
            try {
                File f = new File(COM_REPORT_PATH + path);
                f.mkdirs();
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(files.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        Handle handle = new Handle();
        handle.setRemark(remark);
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        Node node = nodeService.getNodeById(cuurent.getCuurentNodeId());
        Definition nextNode = workflowService.getNextNodeId(start.getWorkflowId(), cuurent
                .getCuurentNodeId(), term);
        //多选单人和单选单人
        if (!"2".equals(node.getNodeType())) {
            workflowService.updateHandleState(cuurent.getId(), handle.getRemark());
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            for (Handle h : handles) {
                if (!h.getId().equals(cuurent.getId())) {
                    workflowService.updateHandleState(h.getId(), null);
                }
            }
            if ("-1".equals(term)) {
                //办结
                handle.setId(CommonUtil.getUUID());
                handle.setStartId(start.getStartId());
                handle.setCuurentWorkflowId(start.getWorkflowId());
                handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                handle.setCuurentNodeId(nextNode.getNextNodeId());
                handle.setHandleName(empService.getPersonNameById(CommonUtil.getPersonId()));
                handle.setState("2");
                handle.setRemark(remark);
                handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                BaseBean bean = workflowService.getBusinessById(businessId, tableName);
                Relation relation = workflowService.getRelation(start.getWorkflowId(), tableName);
                Workflow workflow = workflowService.getWorkflowById(start.getWorkflowId());
                SysTask task = new SysTask();
                if ("T_JW_SCORE_CHANGE_WF".equals(tableName)) {
                    ScoreChange scoreChange = scoreChangeService.getScoreChangeById(businessId);
                    scoreChange.setChanger(CommonUtil.getPersonId());
                    scoreChangeService.updateScoreById(scoreChange);
                }
                task.setTaskId(CommonUtil.getUUID());
                task.setTaskTitle(workflow.getWorkflowName());
                task.setDeptId(bean.getCreateDept());
                task.setPersonId(bean.getCreator());
                task.setTaskBusinessId(businessId);
                task.setTaskTime(CommonUtil.now("yyyy-MM-dd"));
                task.setTaskFlag("1");
                task.setTaskTable(tableName);
                task.setTaskUrl(relation.getUrl());
                task.setTaskAppUrl(relation.getAppUrl());
                task.setTaskType("3");
                CommonUtil.save(task);
                workflowService.updateStartState(start.getStartId());
                workflowService.updateBusiness(tableName, businessId, "2");
                taskService.saveSysTask(task);
            } else {
                //正常流转
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser1 = null;
                    String handleDept = null;
                    String handleName1 = null;
                    if (handle.getHandleUser() != null) {
                        handleUser1 = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName1 = names[i].split("--")[0];
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setRemark(remark);
                    handle.setHandleUser(handleUser1);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName1);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if ((!"".equals(files)) && null != files) {
                        String edition = documentService.getEditionByDocumentId(businessId);
                        Double d = Double.parseDouble(edition);
                        DocumentProcess uploadFile = new DocumentProcess();
                        uploadFile.setId(CommonUtil.getUUID());
                        uploadFile.setDocumentId(start.getBusinessId());
                        uploadFile.setEdition(d + 0.1 + "");
                        uploadFile.setHandleId(handle.getId());
                        uploadFile.setFileName(fileName);
                        uploadFile.setFileUrl(url);
                        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
                        uploadFile.setCreator(CommonUtil.getPersonId());
                        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                        documentService.insertDocumentProcess(uploadFile);
                    }
                    if ("2".equals(term)) {
                        handle.setState("3");
                    } else {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
        } else {
            handle.setRemark(remark);
            //多选多人
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            if (handles.size() == 1) {
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser2 = null;
                    String handleDept = null;
                    String handleName2 = null;
                    if (handle.getHandleUser() != null) {
                        handleUser2 = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName2 = names[i].split("--")[0];
                    }
                    if ((!"".equals(files)) && null != files) {
                        String edition = documentService.getEditionByDocumentId(businessId);
                        Double d = Double.parseDouble(edition);
                        DocumentProcess uploadFile = new DocumentProcess();
                        uploadFile.setId(CommonUtil.getUUID());
                        uploadFile.setDocumentId(start.getBusinessId());
                        uploadFile.setEdition("" + (d + 0.1));
                        uploadFile.setHandleId(handle.getId());
                        uploadFile.setFileName(fileName);
                        uploadFile.setFileUrl(url);
                        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
                        uploadFile.setCreator(CommonUtil.getPersonId());
                        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                        documentService.insertDocumentProcess(uploadFile);
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setRemark(remark);
                    handle.setHandleUser(handleUser2);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName2);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if ("2".equals(term)) {
                        handle.setState("3");
                    } else {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
            if ("2".equals(term)) {
                String cuurentNodeId = workflowService.getCuurentNodeIdByStartIdAndHandleUserHandleRole(start.getStartId(), CommonUtil.getPersonId());
                String roleId = documentService.getRoleByNodeId(start.getWorkflowId(),nextNode.getNextNodeId());
                String personId = documentService.getHandleRole(roleId);
                handle.setHandleUser(personId);
                handle.setHandleName(documentService.getNameByPersonId(personId));
                handle.setHandleDept(documentService.getDeptByPersonId(personId));
                handle.setId(CommonUtil.getUUID());
                handle.setStartId(start.getStartId());
                handle.setCuurentWorkflowId(start.getWorkflowId());
                handle.setRemark(remark);
                handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                handle.setCuurentNodeId(nextNode.getNextNodeId());
                handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                handle.setState("3");
                workflowService.updateHandleStateByCuurentNodeId(start.getStartId(), cuurentNodeId, handle.getRemark());
            } else {
                workflowService.updateHandleStateByNodeIdAndStartId(start.getStartId(), CommonUtil.getPersonId(), handle.getRemark());
            }
        }

        return new Message(1, "提交成功！", null);
    }


    /**
     * 发文管理办理方法
     *
     * @param term
     * @param tableName
     * @param businessId
     * @return
     */
    @ResponseBody
    @RequestMapping("/document/audit")
    public Message documentAudit(@RequestParam("term") String term,
                                 @RequestParam("remark") String remark,
                                 @RequestParam("businessId") String businessId,
                                 @RequestParam("tableName") String tableName,
                                 @RequestParam("handleUser") String handleUser,
                                 @RequestParam("handleName") String handleName,
                                 @RequestParam(value = "file", required = false) CommonsMultipartFile files,
                                 HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";
        String fileName = "";
        String uuid = "";
        String url = "";
        if ((!"".equals(files)) && null != files) {
            fileName = files.getOriginalFilename();
            String path = String.format(urlParten, sdf1.format(new Date()));
            uuid = CommonUtil.getUUID();
            url = path + "/" + uuid + fileName.substring(fileName.lastIndexOf("."));
            FileOutputStream fos = null;
            try {
                File f = new File(COM_REPORT_PATH + path);
                f.mkdirs();
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(files.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        Handle handle = new Handle();
        handle.setRemark(remark);
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        Node node = nodeService.getNodeById(cuurent.getCuurentNodeId());
        Definition nextNode = workflowService.getNextNodeId(start.getWorkflowId(), cuurent
                .getCuurentNodeId(), term);
        //多选单人和单选单人
        if (!"2".equals(node.getNodeType())) {
            workflowService.updateHandleState(cuurent.getId(), handle.getRemark());
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            for (Handle h : handles) {
                if (!h.getId().equals(cuurent.getId())) {
                    workflowService.updateHandleState(h.getId(), null);
                }
            }
            if ("-1".equals(term)) {
                //办结
                handle.setId(CommonUtil.getUUID());
                handle.setStartId(start.getStartId());
                handle.setCuurentWorkflowId(start.getWorkflowId());
                handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                handle.setCuurentNodeId(nextNode.getNextNodeId());
                handle.setHandleName(empService.getPersonNameById(CommonUtil.getPersonId()));
                handle.setState("2");
                handle.setRemark(remark);
                handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                BaseBean bean = workflowService.getBusinessById(businessId, tableName);
                Relation relation = workflowService.getRelation(start.getWorkflowId(), tableName);
                Workflow workflow = workflowService.getWorkflowById(start.getWorkflowId());
                SysTask task = new SysTask();
                if ("T_JW_SCORE_CHANGE_WF".equals(tableName)) {
                    ScoreChange scoreChange = scoreChangeService.getScoreChangeById(businessId);
                    scoreChange.setChanger(CommonUtil.getPersonId());
                    scoreChangeService.updateScoreById(scoreChange);
                }
                task.setTaskId(CommonUtil.getUUID());
                task.setTaskTitle(workflow.getWorkflowName());
                task.setDeptId(bean.getCreateDept());
                task.setPersonId(bean.getCreator());
                task.setTaskBusinessId(businessId);
                task.setTaskTime(CommonUtil.now("yyyy-MM-dd"));
                task.setTaskFlag("1");
                task.setTaskTable(tableName);
                task.setTaskUrl(relation.getUrl());
                task.setTaskAppUrl(relation.getAppUrl());
                task.setTaskType("3");
                CommonUtil.save(task);
                workflowService.updateStartState(start.getStartId());
                workflowService.updateBusiness(tableName, businessId, "2");
                taskService.saveSysTask(task);
            } else {
                //正常流转
                handle.setHandleName(handleName);
                handle.setHandleUser(handleUser);
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser1 = null;
                    String handleDept = null;
                    String handleName1 = null;
                    if (handle.getHandleUser() != null) {
                        handleUser1 = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName1 = names[i].split("--")[0];
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setRemark(remark);
                    handle.setHandleUser(handleUser1);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName1);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if (!"".equals(files) && null != files) {
                        String edition = documentService.getEditionByDocumentId(businessId);
                        Double d = Double.parseDouble(edition);
                        DocumentProcess uploadFile = new DocumentProcess();
                        uploadFile.setId(CommonUtil.getUUID());
                        uploadFile.setDocumentId(start.getBusinessId());
                        uploadFile.setEdition("" + (d + 0.1));
                        uploadFile.setHandleId(handle.getId());
                        uploadFile.setFileName(fileName);
                        uploadFile.setFileUrl(url);
                        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
                        uploadFile.setCreator(CommonUtil.getPersonId());
                        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                        documentService.insertDocumentProcess(uploadFile);
                    }
                    if ("2".equals(term)) {
                        handle.setState("3");
                    } else {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
        } else {
            handle.setHandleUser(handleUser);
            handle.setHandleName(handleName);
            handle.setRemark(remark);
            //多选多人
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            if (handles.size() == 1) {
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser2 = null;
                    String handleDept = null;
                    String handleName2 = null;
                    if (handle.getHandleUser() != null) {
                        handleUser2 = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName2 = names[i].split("--")[0];
                    }
                    if ((!"".equals(files)) && null != files) {
                        String edition = documentService.getEditionByDocumentId(businessId);
                        Double d = Double.parseDouble(edition);
                        DocumentProcess uploadFile = new DocumentProcess();
                        uploadFile.setId(CommonUtil.getUUID());
                        uploadFile.setDocumentId(start.getBusinessId());
                        uploadFile.setEdition("" + (d + 0.1));
                        uploadFile.setHandleId(handle.getId());
                        uploadFile.setFileName(fileName);
                        uploadFile.setFileUrl(url);
                        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
                        uploadFile.setCreator(CommonUtil.getPersonId());
                        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                        documentService.insertDocumentProcess(uploadFile);
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setRemark(remark);
                    handle.setHandleUser(handleUser2);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName2);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if (!"2".equals(term)) {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
            if ("2".equals(term)) {
                String cuurentNodeId = workflowService.getCuurentNodeIdByStartIdAndHandleUserHandleRole(start.getStartId(), CommonUtil.getPersonId());
                String roleId = documentService.getRoleByNodeId(start.getWorkflowId(),nextNode.getNextNodeId());
                String personId = documentService.getHandleRole(roleId);
                handle.setHandleUser(personId);
                handle.setHandleName(documentService.getNameByPersonId(personId));
                handle.setHandleDept(documentService.getDeptByPersonId(personId));
                handle.setHandleName(handleName);
                handle.setId(CommonUtil.getUUID());
                handle.setStartId(start.getStartId());
                handle.setCuurentWorkflowId(start.getWorkflowId());
                handle.setRemark(remark);
                handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                handle.setCuurentNodeId(nextNode.getNextNodeId());
                handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                handle.setState("3");
                workflowService.saveHandleAfter(handle);
                workflowService.updateHandleStateByCuurentNodeId(start.getStartId(), cuurentNodeId, handle.getRemark());
            } else {
                workflowService.updateHandleStateByNodeIdAndStartIdRole(start.getStartId(), CommonUtil.getPersonId(), handle.getRemark(),node.getHandleRole());
            }

        }

        return new Message(1, "提交成功！", null);
    }

}


