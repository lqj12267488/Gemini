package com.goisan.enrollment;

import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.enrollment.service.EnrollmentService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mcq on 2017/11/13
 */
@Controller
public class EnrollmentAppController {
    @Resource
    private EnrollmentService enrollmentService;
    @Resource
    private CommonService commonService;
    /**新生登记列表页*/
    @RequestMapping("/enrollmentApp/index")
    public ModelAndView listNotice(){
        ModelAndView mv=new ModelAndView("/app/synergy/enrollment/enrollmentByAppList");
        String emJson = getEnrollmentByAppList(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**新生登记列表数据源*/
    @ResponseBody
    @RequestMapping("/enrollmentApp/getEnrollmentByAppList")
    public String getEnrollmentByAppList(int page) {
        EnrollmentStudent enrollmentStudent=new EnrollmentStudent();
        List<EnrollmentStudent> enrollmentStudentList = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
        return getEnrollmentJsonList(enrollmentStudentList,page);
    }
    /**请求转换*/
    public String getEnrollmentJsonList(List<EnrollmentStudent> enrollmentStudentList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = enrollmentStudentList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            EnrollmentStudent enrollmentStudent = enrollmentStudentList.get(i);
            String name = enrollmentStudent.getName();
            String idcard=enrollmentStudent.getIdcard();
            String major=enrollmentStudent.getMajorShow();
            String majorShow=major.split("--")[0];
            try {
                majorShow =java.net.URLEncoder.encode(majorShow,"UTF-8");
                name =java.net.URLEncoder.encode(name,"UTF-8");
                idcard =java.net.URLEncoder.encode(idcard,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"name\":\"" +name+"\", \"idcard\":\"" +idcard+"\", \"majorShow\":\"" + majorShow + "\"}" ;

            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    /**新生登记*/
    @RequestMapping("/enrollmentApp/editEnrollmentStudentByApp")
    public ModelAndView editEnrollmentStudentByApp() {
        ModelAndView mv = new ModelAndView("/app/synergy/enrollment/editEnrollmentStudentByApp");
        return mv;
    }
    /**新生登记详情*/
    @RequestMapping("/enrollmentApp/enrollmentStudentDetail")
    public ModelAndView enrollmentStudentDetail(String studentId) {
        EnrollmentStudent enrollmentstudent = enrollmentService.getEnrollmentStudentById(studentId);
        ModelAndView mv = new ModelAndView("/app/synergy/enrollment/enrollmentStudentDetail");
        mv.addObject("enrollmentstudent", enrollmentstudent);
        return mv;
    }


}
