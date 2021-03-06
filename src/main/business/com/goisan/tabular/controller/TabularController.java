package com.goisan.tabular.controller;

import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.service.EmploymentManageService;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.dao.ParameterDao;
import com.goisan.system.tools.ApplicationContextRegister;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.tabular.bean.Tabular;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.dao.TableAttributeDao;
import com.goisan.tabular.service.TableAttributeService;
import com.goisan.tabular.service.TabularService;
import com.goisan.tabular.service.impl.TableAttributeServiceImpl;
import com.goisan.teach.service.TeachClassService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class TabularController {
    @Resource
    private TabularService tabularService;
    @Resource
    private TableAttributeService tableAttributeService;

    @Resource
    private TableAttributeDao tableAttributeDao;
    @Resource
    private ParameterDao parameterDao;
    @Resource
    private MajorService majorService;
    @Resource
    private MajorLeaderService majorLeaderService;
    @Resource
    private EmpDao empDao;
    @Resource
    private CourseService courseService;

    @Resource
    private EmploymentManageService employmentManageService;


    /**
     * @function 表格种类URL
     * @author FanNing
     * @date 2018/10/15
     */
    @RequestMapping("/tabular/tabularTypeList")
    public String toCostItem() {
        return "/business/tabular/tabularTypeList";
    }

    /**
     * @function 表格种类删除校验
     * @author FanNing
     * @date 2018/10/15
     */
    @ResponseBody
    @RequestMapping("/tabular/checkTabular")
    public Message checkTabular(String tabularType) {
        Message message = new Message();
        List<Tabular> list = tabularService.checkTabular(tabularType);
        if (list.size() > 0)
            message = new Message(1, "该条数据已经被引用，不可删除！", "error");
        return message;

    }

    /**
     * @function 表格管理首页
     * @author FanNing
     * @date 2018/10/15
     */
    @RequestMapping("/tabular/tabularList")
    public ModelAndView tabularList() {
        ModelAndView mv = new ModelAndView("/business/tabular/tabularList");
        return mv;
    }

    /**
     * @function 获得表格结果集
     * @author FanNing
     * @date 2018/10/15
     */
    @ResponseBody
    @RequestMapping("/tabular/getTabularList")
    public Map<String, List<Tabular>> getTabularList(Tabular tabular) {
        Map<String, List<Tabular>> tabularMap = new HashMap<String, List<Tabular>>();
        tabular.setCreator(CommonUtil.getPersonId());
        tabular.setCreateDept(CommonUtil.getDefaultDept());
        tabularMap.put("data", tabularService.getTabularList(tabular));
        return tabularMap;
    }

    /**
     * @function 表格信息新增
     * @author FanNing
     * @date 2018/10/15
     */
    @ResponseBody
    @RequestMapping("/tabular/addTabular")
    public ModelAndView addTabular() {
        ModelAndView mv = new ModelAndView("/business/tabular/editTabular");
        Tabular tabular = new Tabular();
        mv.addObject("tabular", tabular);
        mv.addObject("head", "新增表格信息");
        return mv;
    }

    /**
     * @function 表格信息修改
     * @author FanNing
     * @date 2018/10/15
     */
    @ResponseBody
    @RequestMapping("/tabular/editTabular")
    public ModelAndView editTabular(String id) {
        ModelAndView mv = new ModelAndView("/business/tabular/updateTabular");
        Tabular tabular = tabularService.getTabularById(id);
        mv.addObject("head", "表格信息修改");
        mv.addObject("tabular", tabular);
        return mv;
    }

    /**
     * @function 表格信息修改保存方法
     * @author FanNing
     * @date 2018/10/19
     */
    @ResponseBody
    @RequestMapping("/tabular/updateTabular")
    public Message updateTabular(Tabular tabular) {
        tabular.setChanger(CommonUtil.getPersonId());
        tabular.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        tabularService.updateTabular(tabular);
        return new Message(1, "修改成功！", "success");

    }

    /**
     * @function 表格信息新增包括文件上传
     * @author FanNing
     * @date 2018/10/18
     */

    @ResponseBody
    @RequestMapping("/tabular/saveTabular")
    public void insertTabularFiles(@RequestParam("id") String id,
                                   @RequestParam("tabularName") String tabularName,
                                   @RequestParam("tabularType") String tabularType,
                                   @RequestParam("tableAttribute") String tableAttribute,
                                   @RequestParam(value = "file") CommonsMultipartFile files,
                                   HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";
        final String fileName = files.getOriginalFilename();
        String path = String.format(urlParten, sdf.format(new Date()));
        final String uuid = CommonUtil.getUUID();
        final String url = path + "/" + uuid + fileName.substring(fileName.lastIndexOf("."));
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

        Tabular tabular = new Tabular();
        tabular.setId(CommonUtil.getUUID());
        tabular.setTabularName(tabularName);
        tabular.setTabularType(tabularType);
        tabular.setTableAttribute(tableAttribute);
        tabular.setCreator(CommonUtil.getPersonId());
        tabular.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        tabularService.insertTabular(tabular);

        TabularFile uploadFile = new TabularFile();
        uploadFile.setTabularId(tabular.getId());
        uploadFile.setFileName(fileName);
        uploadFile.setFileUrl(url);
        uploadFile.setFileSuffix(fileName.substring(fileName.lastIndexOf(".") + 1));
        uploadFile.setCreator(CommonUtil.getPersonId());
        uploadFile.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        tabularService.insertTabularFile(uploadFile);

    }

    public static String COM_REPORT_PATH = null;

    @ResponseBody
    @RequestMapping("/tabular/downloadTabularFile")
    public void downloadTabularFile(@Param("id") String id, @Param("tableAttribute") String tableAttribute, HttpServletResponse response) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        String fileId = tabularService.getFileIdByTabularId(id);
        TabularFile files = tabularService.getTabularFileById(fileId);
        if (null == tableAttribute || "null".equals(tableAttribute)) {
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
        } else {
            if("expertExcel_A10_1".equals(tableAttribute)){
                tableAttributeService.expertExcel_A10_1(response,files);
            }else if("expertExcel_A10_1_2".equals(tableAttribute)){
                tableAttributeService.expertExcel_A10_1_2(response,files);
            }else{
                try {
                    Class<?> t_class =  Class.forName("com.goisan.tabular.service.TableAttributeService");
                    Object obj = ApplicationContextRegister.getApplicationContext().getBean("tableAttributeServiceImpl", t_class);
                    obj.getClass().getDeclaredMethod(tableAttribute, HttpServletResponse.class, TabularFile.class).invoke(obj, response, files);
                } catch (Exception e) {
                    e.printStackTrace();
                    String filePath = COM_REPORT_PATH + files.getFileUrl();
                    File file = FileUtils.getFile(filePath);
                    OutputStream os = null;
                    try {
                        response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(files.getFileName(),
                                "utf-8"));
                        os = response.getOutputStream();
                        os.write(FileUtils.readFileToByteArray(file));
                        os.flush();
                        os.close();
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * @function 表格信息删除
     * @author FanNing
     * @date 2018/10/15
     */
    @ResponseBody
    @RequestMapping("/tabular/deleteTabular")
    public Message deleteTabular(String id) {
        Message message = new Message(1, "删除成功！", "success");
        tabularService.deleteTabular(id);
        return message;
    }

    @RequestMapping("/tabular/tabularDownloadList")
    public ModelAndView tabularDownloadList() {
        ModelAndView mv = new ModelAndView("/business/tabular/tabularDownloadList");
        return mv;
    }

    /**
     * 字典类别名称查重
     */
    @ResponseBody
    @RequestMapping("/tabular/checkName")
    public Message archivesTypeCheckName(Tabular tabular) {
        List size = tabularService.checkName(tabular);
        if (size.size() > 0) {
            return new Message(1, "名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
}
